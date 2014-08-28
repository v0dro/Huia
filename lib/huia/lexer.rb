require 'huia/lexer.rex'

class Huia::Lexer
  attr_accessor :indent_level
  attr_reader   :filename, :source

  def initialize str, filename
    super()
    @indent_level = 0
    @token_stack  = []
    @eof_sent     = false
    @state        = []
    @filename     = filename
    @source       = str
    @pos          = 0
    parse str
  end

  def line
    @source[0..@pos].count("\n")
  end

  def column
    @source[0..@pos].split("\n").last.length
  end

  def get_line n
    @source.split("\n")[n]
  end

  def current_line
    get_line line-1
  end

  def state
    @state.last
  end

  def state= x
    if x
      @state.push x
    else
      @state.pop
    end
    state
  end

  def each
    Enumerator.new do |y|
      while token = next_computed_token
        y << token
      end
    end
  end

  def next_token_with_pos
    @pos = @ss.pos
    next_token_without_pos
  rescue ScanError
    message = "Lexing error: count not match #{@ss.peek(10).inspect} at #{filename} line #{line}:#{column}:\n\n"

    start = line - 5 > 0 ? line - 5 : 0
    i_size = line.to_s.size
    (start..(start + 5)).each do |i|
      message << sprintf("\t%#{i_size}d: %s\n", i, get_line(i))
      message << "\t#{' ' * i_size}  #{'-' * (column - 1)}^\n" if i == line
    end

    raise SyntaxError, message
  end
  alias next_token_without_pos next_token
  alias next_token next_token_with_pos

  def next_computed_token
    push_more_tokens if @token_stack.empty?
    @token_stack.shift
  end

  def push_more_tokens
    token = next_token
    if token
      case token.first

      when :COMPOSITE
        @token_stack = @token_stack.concat(token.last)

      when :COMMENT
        push_more_tokens

      else
        @token_stack << token

      end
    else
      @indent_level.times do
        @token_stack << [ :OUTDENT, '  ' ]
      end
      @indent_level = 0
      @token_stack << [ :EOF, '' ] unless @eof_sent
      @eof_sent = true
    end
  end

  def tokens
    each.to_a
  end

  def do_parse
    # noop
  end

  def in_or_out_dent text
    text  = text.reverse.gsub("\t", '  ').gsub("\r\n", "\n")
    nls   = text.count("\n")
    depth = text.index(/[^ ]/) || text.size
    raise "Invalid depth level of #{depth} spaces" unless depth % 2 == 0

    depth = depth / 2
    tokens = []

    if depth > @indent_level
      dents = depth - @indent_level
      @indent_level = depth
      dents.times { tokens << [ :INDENT, '  ' ] }

    elsif depth < @indent_level
      dents = @indent_level - depth
      @indent_level = depth
      [ :OUTDENT, dents ]
      dents.times { tokens << [ :OUTDENT, '  ' ] }

    end

    nls.times { tokens << [ :NL, "\n" ] }

    [ :COMPOSITE, tokens ]
  end

end

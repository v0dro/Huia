require 'huia/lexer.rex'

class Huia::Lexer
  attr_accessor :indent_level
  attr_reader   :lineno

  def initialize str
    super()
    @indent_level = 0
    @token_stack  = []
    @eof_sent     = false
    parse str
  end

  def each
    Enumerator.new do |y|
      while token = next_computed_token
        y << token
      end
    end
  end

  def next_computed_token
    push_more_tokens if @token_stack.empty?
    @token_stack.shift
  end

  def push_more_tokens
    token = next_token
    if token
      case token.first

      when :INDENT
        token.last.times do
          @token_stack << [ :INDENT, '  ' ]
        end

      when :OUTDENT
        token.last.times do
          @token_stack << [ :OUTDENT, '  ' ]
        end

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
    text = text.reverse.gsub("\t", '  ')
    depth = text.index(/[^ ]/) || text.size
    raise "Invalid depth level of #{depth} spaces" unless depth % 2 == 0

    depth = depth / 2

    if depth > @indent_level
      dents = depth - @indent_level
      @indent_level = depth
      [ :INDENT, dents ]

    elsif depth < @indent_level
      dents = @indent_level - depth
      @indent_level = depth
      [ :OUTDENT, dents ]

    elsif depth == @indent_level

      [ :NL, '' ]

    else

      nil
    end
  end

end

require 'huia/raw_lexer.rex'

class Huia::Lexer < Huia::RawLexer
  attr_accessor :indent_level

  def initialize str
    super()
    @indent_level = 0
    @queue        = []
    parse str
  end

  def next_token
    if @queue.empty?
      tokens = super

      if tokens
        if tokens.first.is_a? Array
          @queue.concat tokens
        else
          @queue << tokens
        end
        @queue.shift
      end
    else
      @queue.shift
    end
  end

  def each
    Enumerator.new do |y|
      while token = next_token
        y << token
      end
    end
  end

  def tokens
    each.to_a
  end

  def do_parse
    # noop
  end

  def in_or_out_dent text
    text = text.gsub("\t", '  ').gsub("\n", '')
    raise "Invalid indent level of #{text.size} spaces" unless text.size % 2 == 0
    depth = text.size / 2
    if depth > @indent_level
      (depth - @indent_level).times.map { [ :INDENT, '  ' ] }
    elsif depth < @indent_level
      (@indent_level - depth).times.map { [ :OUTDENT, '  ' ] }
    else
      []
    end
  end

end

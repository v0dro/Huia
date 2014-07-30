require 'huia/lexer.rex'

class Huia::Lexer
  attr_accessor :indent_level

  def initialize str
    super()
    @indent_level = 0
    parse str
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
      dents = depth - @indent_level
      @indent_level = depth
      [ :INDENT, dents ]
    elsif depth < @indent_level
      dents = @indent_level - depth
      @indent_level = depth
      [ :OUTDENT, dents ]
    else
      []
    end
  end

end

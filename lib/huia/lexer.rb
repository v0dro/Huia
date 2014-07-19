require 'huia/lexer.rex'

class Huia::Lexer

  attr_accessor :indent_level

  def initialize str
    super()
    @indent_level = 0
    parse str
  end

  def do_parse
    # noop
  end

  def in_or_out_dent text
    text = text.gsub(/\t/, '  ')
    depth = (text.size - 1) / 2
    if depth > @indent_level
      (depth - @indent_level).times { lex_indent }
    elsif depth < @indent_level
      (@indent_level - depth).times { lex_outdent }
    end
    nil
  end

end

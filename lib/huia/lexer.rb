require 'huia/lexer.rex'

class Huia::Lexer

  attr_accessor :indent_level

  def initialize
    super
    @indent_level = 0
  end

  def lex_comment text
    puts "comment #{text.inspect}"
  end

  def lex_identifier text
    puts "lex_identifier #{text.inspect}"
  end

  def lex_call_method text
    puts "lex_call_method #{text.inspect}"
  end

  def lex_state *args
    puts "lex_state: #{args.inspect}"
  end

  def lex_string str
    puts "string: #{str.inspect}"
  end

  def lex_integer i
    puts "integer: #{i}"
  end

  def lex_float f
    puts "float: #{f}"
  end

  def lex_dot _
    puts "dot"
  end

  def lex_colon _
    puts "colon"
  end

  def lex_equal _
    puts "equal"
  end

  def lex_indent
    @indent_level += 1
    puts "indent. level = #{@indent_level}"
  end

  def lex_outdent
    @indent_level -= 1
    puts "outdent. level = #{@indent_level}"
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

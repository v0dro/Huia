require "huia/version"

module Huia
  autoload :Lexer,       'huia/lexer'
  autoload :Parser,      'huia/parser'
  autoload :AST,         'huia/ast'
  autoload :Bootstrap,   'huia/bootstrap'

  SyntaxError = Class.new(RuntimeError)

  module_function

  def lex string_or_io
    lexer(string_or_io).tokens
  end

  def lexer string_or_io
    str = if string_or_io.respond_to? :read
            string_or_io.read
          else
            string_or_io
          end
    Huia::Lexer.new(str)
  end

  def parse string_or_io
    parser(string_or_io).ast
  end

  def parser string_or_io
    Huia::Parser.new lexer string_or_io
  end

end

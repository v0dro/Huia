require "huia/version"

module Huia
  autoload :Boot,        'huia/boot'
  autoload :Core,        'huia/core'
  autoload :ToolSet,     'huia/tool_set'
  autoload :Lexer,       'huia/lexer'
  autoload :Parser,      'huia/parser'
  autoload :AST,         'huia/ast'
  autoload :CodeLoader,  'huia/code_loader'
  autoload :Compiler,    'huia/compiler'
  autoload :Script,      'huia/script'

  SyntaxError = Class.new(RuntimeError)

  module_function

  def load file, wd=Dir.getwd, debug=false
    cm = Huia::CodeLoader.new(file, wd).load
    Huia::Script.new(cm, file).tap { |s| s.debug = debug }
  end

  def eval string, debug=false
    cm = Huia::Compiler.eval_from string
    Huia::Script.new(cm, '(eval)').tap { |s| s.debug = debug }
  end

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

require "huia/version"

# Protect against loading Huia on incorrect Rubies.
proc do
  begin
    raise RuntimeError, RUBY_ENGINE unless RUBY_ENGINE == 'rbx'
    version = Rubinius::VERSION.split('.').take(3).map(&:to_i)
    raise RuntimeError, Rubinius::VERSION unless version[0] >= 2 && version[1] >= 2 && version[2] >= 10
  rescue RuntimeError
    STDERR.puts "Huia only supports Rubinius >= 2.2.10"
    exit(1)
  end
end.call

module Huia

  DESCRIPTION = "Huia version #{VERSION} running on #{RUBY_ENGINE} #{Rubinius::VERSION}."

  autoload :Boot,        'huia/boot'
  autoload :Core,        'huia/core'
  autoload :ToolSet,     'huia/tool_set'
  autoload :Lexer,       'huia/lexer'
  autoload :Parser,      'huia/parser'
  autoload :AST,         'huia/ast'
  autoload :CodeLoader,  'huia/code_loader'
  autoload :Generator,   'huia/generator'
  autoload :Compiler,    'huia/compiler'
  autoload :Script,      'huia/script'
  autoload :Commands,    'huia/commands'
  autoload :HuiaLoader,  'huia/huia_loader'

  SyntaxError = Class.new(RuntimeError)

  module_function

  def load file, wd=Dir.getwd
    cm = Huia::CodeLoader.new(file, wd).load
    Huia::Script.new(cm, file)
  end

  def eval string
    cm = Huia::Compiler.eval_from string
    Huia::Script.new(cm, '(eval)')
  end

  def extend_loader
    Huia::HuiaLoader
    true
  end

end

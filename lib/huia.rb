require 'bundler/setup'
require "huia/version"

# Protect against loading Huia on incorrect Rubies.
proc do
  begin
    raise RuntimeError, RUBY_ENGINE unless RUBY_ENGINE == 'rbx'
    version = Rubinius::VERSION.split('.').take(3).map(&:to_i)
    raise RuntimeError, Rubinius::VERSION unless version[0] >= 2 && version[1] >= 3
  rescue RuntimeError
    STDERR.puts "Huia only supports Rubinius >= 2.3.0"
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

  SyntaxError = Class.new(RuntimeError)

  module_function

  def load file, wd=Dir.getwd
    cm = Huia::CodeLoader.new(file, wd).load
    Huia::Script.new(cm, file)
  end

  def require_file file, wd=Dir.getwd
    @cache ||= {}
    cache_key = File.absolute_path(file,wd)
    @cache[cache_key] ||= self.load(file,wd).invoke
  end

  def eval string
    cm = Huia::Compiler.eval_from string
    Huia::Script.new(cm, '(eval)')
  end

  def add_package string, path
    packages[string] = path
  end

  def packages
    @packages ||= {}
  end

end

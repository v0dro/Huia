require 'yaml'
require 'rubinius/compiler'
require 'rubinius/ast'

module Huia
  class Compiler < ToolSet::Compiler

    def self.compile_from source, opts={}
      raise ArgumentError, "must provide compiler destination" unless opts[:to]

      new(:huia_file, :compiled_file).tap do |c|
        c.parser.input source
        c.writer.name = opts[:to]
      end.run
    end

    def self.eval_from source
      new(:huia_string, :compiled_method).tap do |c|
        c.parser.input source
      end.run
    end

    class HuiaGenerator < ToolSet::Compiler::Bytecode
      stage      :huia_generator
      next_stage ToolSet::Compiler::Encoder

      def initialize compiler, last
        super
        compiler.generator = self
      end

      def run
        @output = ::Huia::Generator.new
        @input.bytecode @output
        @output.close

        run_next
      end

      def input root_ast
        @input = root_ast
      end
    end

    class HuiaParser < ToolSet::Compiler::Stage
      def initialize compiler, last
        super
        compiler.parser = self
      end

      def run
        lexer = Huia::Lexer.new(@source, @filename)
        ast   = Huia::Parser.new(lexer).ast

        @output = ast
        @output.file = @filename
        run_next
      end
    end

    class HuiaFileParser < HuiaParser
      stage :huia_file
      next_stage HuiaGenerator

      def input(filename, line=1)
        @filename = filename
        @line     = line
        @source   = File.read(@filename)
      end
    end

    class HuiaStringParser < HuiaParser
      stage :huia_string
      next_stage HuiaGenerator

      def input source, line=1
        @filename = '(eval)'
        @line     = line
        @source   = source
      end
    end

  end
end

require 'yaml'
require 'rubinius/compiler'
require 'rubinius/ast'

module Huia
  class Compiler < CodeTools::Compiler

    def self.compile_from source, opts={}
      raise ArgumentError, "must provide compiler destination" unless opts[:to]

      compiler = new :huia_file, :compiled_file

      parser = compiler.parser
      # parser.root CodeTools::AST::Script
      parser.input source

      if @print
        parser.print
        printer = compiler.packager.print
        printer.bytecode = true
      end

      writer = compiler.writer
      writer.name = opts[:to]

      compiler.run
    end

    # Compiler Stages

    class HuiaGenerator < CodeTools::Compiler::Stage
      stage      :huia_bytecode
      next_stage CodeTools::Compiler::Encoder

      attr_reader :variable_scope

      def initialize compiler, last
        super
        @variable_scope = nil
        compiler.generator = self
      end

      def run
        @output               = Rubinius::Generator.new
        @input.variable_scope = @variable_scope
        @input.bytecode       = @output
        @output.close
        run_next
      end

      def input root_ast
        @input = root_ast
      end
    end

    # Huia File -> AST
    class HuiaParser < CodeTools::Compiler::Stage
      stage      :huia_file
      next_stage HuiaGenerator

      def initialize compiler, last
        super
        compiler.parser = self
      end

      def root(root)
        @root = root
      end

      def print
        @print = true
      end

      def input(filename, line=1)
        @filename = filename
        @line     = line
      end

      def run
        lexer = Huia::Lexer.new(File.read(@filename))
        ast   = Huia::Parser.new(lexer).ast

        if @print
          puts ast.to_yaml
        end

        @output = ast
        @output.file = @filename
        run_next
      end
    end

  end
end

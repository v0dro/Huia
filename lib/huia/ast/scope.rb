module Huia
  module AST
    class Scope < Node

      Compiler = ::Huia::ToolSet::Compiler

      include Compiler::LocalVariables

      attr_reader :children, :parent, :arguments

      def initialize parent
        @children  = []
        @arguments = []
        @variables = {}
        @block     = 0
        @parent    = parent
      end

      def name
        'Roger Rabbit'.to_sym
      end

      def add_argument variable
        allocate_local variable
        @arguments << variable
      end

      def arity
        @arguments.size
      end

      def allocate_local variable
        local = @variables[variable.name] ||= Compiler::LocalVariable.new(allocate_slot)

        variable.variable = local.reference
      end

      def argument_names
        @arguments
      end

      def append node
        raise RuntimeError, "Cannot append a non-Node" unless node.is_a? Huia::AST::Node
        @children << node
        self
      end

      def bytecode g
        pos g

        push_huia_const g, :Closure
        g.push_literal 'create:'

        g.push_rubinius
        g.create_block block_from_children g
        g.send_with_block :lambda, 0, false

        g.send :__huia__send, 2

        g.ret
      end

      def push_block
        @block += 1
      end

      def pop_block
        @block -= 1 if block?
      end

      def block?
        @block > 0
      end

      private

      def block_from_children g
        blk = g.class.new
        blk.name = name || :__block__
        blk.file = g.file
        blk.for_block = true

        # blk.required_args = 0
        # blk.post_args = 0
        blk.total_args = arity
        # blk.splat_index = nil
        # blk.block_index = nil
        blk.arity = arity
        blk.definition_line line

        blk.push_state self
        blk.state.push_super parent

        blk.state.push_name blk.name

        pos blk

        # arguments.each do |argument|
        #   argument.bytecode g
        # end

        blk.state.push_block
        blk.push_modifiers
        blk.break = nil
        blk.next = nil
        blk.redo = blk.new_label
        blk.redo.set!

        children.each do |child|
          child.bytecode(blk)
        end

        blk.pop_modifiers
        blk.state.pop_block
        blk.ret
        blk.close
        blk.pop_state

        blk.local_count = local_count
        blk.local_names = local_names

        blk
      end
    end
  end
end

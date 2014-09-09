module Huia
  module AST
    class Scope < Node

      Compiler = ::Huia::ToolSet::Compiler

      attr_reader :children, :parent, :arguments

      include Compiler::LocalVariables

      def initialize parent
        @children  = []
        @arguments = []
        @variables = {}
        @block     = 0
        @parent    = parent
      end

      def name
        "#{file}:#{line}:#{column}".to_sym
      end

      def add_argument variable
        v = new_local variable
        variable.variable = v.reference
        @arguments << variable
      end

      def arity
        @arguments.size
      end

      def search_for_parent_ref variable
        @parent.search_for_nested_ref(variable) if @parent
      end

      def search_for_nested_ref variable
        if local = @variables[variable.name]
          return local.nested_reference
        else
          ref = search_for_parent_ref(variable)
          ref.depth += 1 if ref
          ref
        end
      end

      def new_local variable
        @variables[variable.name] = Compiler::LocalVariable.new(allocate_slot)
      end

      def allocate_local variable
        if v = @variables[variable.name]
          variable.variable = v.reference
        elsif r = search_for_parent_ref(variable)
          r.depth += 1
          variable.variable = r
        else
          v = new_local variable
          variable.variable = v.reference
        end
      end

      def append node
        raise RuntimeError, "Cannot append a non-Node" unless node.is_a? Huia::AST::Node
        @children << node
        self
      end

      def bytecode g
        pos g

        g.name = "#{name} (file scope)".to_sym

        g.push_huia_closure block_from_children(g), argument_names

        g.dup
        g.push_literal file
        g.push_int line
        g.push_int column
        g.send :defined_at, 3
        g.pop

        g.ret if top_level?
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

      def argument_names
        arguments.map(&:name)
      end

      def top_level?
        !@parent
      end

      def empty?
        @children.size == 0
      end

      def block_from_children g
        blk = g.class.new
        blk.name = name || :__block__
        blk.file = g.file
        blk.for_block = true

        blk.total_args = arity
        blk.arity = arity
        blk.definition_line line

        blk.push_state self

        pos blk

        blk.state.push_block
        blk.push_modifiers
        blk.break = nil
        blk.next = nil
        blk.redo = blk.new_label
        blk.redo.set!

        if empty?
          push_huia_const blk, :Nil
          blk.send :new, 0
        else
          last = children.size - 1
          children.each_with_index do |child, i|
            child.bytecode(blk)
            blk.pop unless i == last
          end
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

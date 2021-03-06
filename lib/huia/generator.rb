module Huia
  # A subclass of ToolSet::Generator which adds a bunch of helpers
  # for common Huia bytecode operations.
  class Generator < ToolSet::Generator

    # Push a huia constant onto the stack.
    # Huia constants are the core library
    # and are located under Ruby's Huia::Core
    # namespace.
    def push_huia_const const
      push_cpath_top
      find_const :Huia
      find_const :Core
      find_const const.to_sym
    end

    # Push a huia method call onto the stack via the Ruby
    # Huia::Core::Object#__huia__send method.
    def huia_send method, arg_count=0
      push_literal method
      string_dup
      yield self if arg_count > 0
      send :__huia__send, arg_count + 1
    end

    # Push a huia integer onto the stack.
    def push_huia_integer value
      push_huia_const :Integer
      huia_send 'createFromValue:', 1 do |g|
        g.push_int value.to_int
      end
    end

    # Push a huia float onto the stack.
    def push_huia_float value
      push_huia_const :Float
      huia_send 'createFromValue:', 1 do |g|
        g.push_literal value.to_f
      end
    end

    # Push a huia false onto the stack.
    def push_huia_false
      push_huia_const :False
      huia_send 'create'
    end

    # Push a huia true onto the stack.
    def push_huia_true
      push_huia_const :True
      huia_send 'create'
    end

    # Push a huia nil onto the stack.
    def push_huia_nil
      push_huia_const :Nil
      huia_send 'create'
    end

    # Push an empty huia array onto the stack
    # and populate it with the contents of the block
    # if asize is non-zero.
    def push_huia_array asize
      push_huia_const :Array
      huia_send 'createFromValue:', 1 do |g|
        yield self if asize > 0
        g.make_array asize
      end
    end

    # Push an empty Huia hash onto the stack.
    def push_huia_hash
      push_huia_const :Hash
      huia_send 'create'
    end

    # Push a huia string onto the stack.
    def push_huia_string value
      push_huia_const :String
      huia_send 'createFromValue:', 1 do |g|
        g.push_literal value
        g.string_dup
      end
    end

    # Push a huia closure onto the stack, passing
    # in a block and possible argument names.
    def push_huia_closure block, argument_names=[]
      push_huia_const :Closure
      huia_send 'create:', 1 do |g|
        g.push_rubinius
        g.create_block block
        g.send_with_block :lambda, 0, false
      end

      dup
      push_literal :@argumentNames

      # Remove the special '@' argument so that it's not in the list.
      filtered_arguments = argument_names.reject { |a| a == '@' }

      push_huia_array filtered_arguments.size do |g|
        filtered_arguments.each do |argument_name|
          g.push_huia_string argument_name
        end
      end
      send :instance_variable_set, 2
      pop
    end

  end
end

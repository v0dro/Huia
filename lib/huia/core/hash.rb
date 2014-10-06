# # `Hash`
#
# Implements a hash-based key/value dictionary.
#
# Inherits from [[Object]].
#
# ## Methods defined by the Huia VM:
module Huia
  module Core
    Hash = Literal.__huia__send('extend:', proc do
      define_method :__huia__init do
        super
        @value = {}
      end

      # ### `Hash#at:` **Public**
      #
      # Returns the object at a given index in the Hash.
      #
      # Arguments:
      #   - `index`: the indexing object.
      define_instance_method_as 'at:' do |index|
        result = value[index]
        if result
          result
        else
          ::Huia::Core.nil unless result
        end
      end

      # ### `Hash#at:set:` **Public**
      #
      # Sets the value of the object at the given index>
      #
      # Arguments:
      #   - `index`: the indexing object.
      #   - `value`: the value object.
      define_instance_method_as 'at:set:' do |index, _value|
        value[index] = _value
      end

      define_method :[] do |index|
        value[index]
      end

      define_method :[]= do |index, _value|
        value[index] = _value
      end
    end)
  end
end

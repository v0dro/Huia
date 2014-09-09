module Huia
  module Core
    Hash = Literal.__huia__send('extend:', proc do
      define_method :__huia__init do
        super
        @value = {}
      end

      define_instance_method_as 'at:' do |index|
        result = value[index]
        if result
          result
        else
          ::Huia::Core.nil unless result
        end
      end

      define_instance_method_as 'at:set:' do |index, _value|
        value[index] = _value
      end
    end)
  end
end

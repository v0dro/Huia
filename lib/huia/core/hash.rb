module Huia
  module Core
    Hash = Literal.__huia__send('extend:', proc do
      define_method :__huia__init do
        super
        @value = {}
      end

      __huia__send('def:as:', 'at:', proc do |index|
        result = value[index]
        if result
          result
        else
          ::Huia::Core::Nil.__huia__send('create') unless result
        end
      end)

      __huia__send('def:as:', 'at:set:', proc do |index, _value|
        value[index] = _value
      end)
    end)
  end
end

module Huia
  module Core
    Hash = Literal.__huia__send('extend:', proc do
      define_method :__huia__init do
        @value = {
          keys:   {},
          values: {}
        }
      end

      __huia__send('def:as:', 'keys', proc do
        ::Huia::Core::Array.__huia__send('createFromValue:', value[:keys].values)
      end)

      __huia__send('def:as:', 'values', proc do
        ::Huia::Core::Array.__huia__send('createFromValue:', value[:values].values)
      end)

      __huia__send('def:as:', 'size', proc do
        ::Huia::Core::Integer.__huia__send('createFromValue:', value[:keys].size)
      end)

      __huia__send('def:as:', 'at:', proc do |index|
        result = value[:values][index.unique_id]
        if result
          result
        else
          ::Huia::Core::Nil.__huia__send('create') unless result
        end
      end)

      __huia__send('def:as:', 'at:set:', proc do |index, _value|
        value[:values][index.unique_id] = _value
        value[:keys][index.unique_id]   = index
      end)
    end)
  end
end

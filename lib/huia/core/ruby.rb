module Huia
  module Core
    Ruby = Object.__huia__send('extend:', proc do

      attr_accessor :object

      __huia__send('defineMethod:as:', 'createFromConstant:', proc do |constant|
        constant = constant.to_ruby if constant.respond_to? :to_ruby

        const = constant.split('::').inject(Kernel) do |parent, const|
          parent.const_get(const.to_sym)
        end
        __huia__send('create').tap do |o|
          o.object = const
        end
      end)

      __huia__send('defineMethod:as:', 'createFromObject:', proc do |object|
        object = object.to_ruby if object.respond_to? :to_ruby
        __huia__send('create').tap do |o|
          o.object = object
        end
      end)

      __huia__send('def:as:', 'send:', proc do |signature|
        signature = signature.to_ruby if signature.respond_to? :to_ruby
        ::Huia::Core::Ruby.__huia__send('createFromObject:', object.public_send(signature.to_sym))
      end)

      __huia__send('def:as:', 'send:withArgs:', proc do |signature, args|
        signature = signature.to_ruby if signature.respond_to? :to_ruby
        ::Huia::Core::Ruby.__huia__send('createFromObject:', object.public_send(signature.to_sym, *args))
      end)

      define_method :to_ruby do
        object
      end

    end)
  end
end

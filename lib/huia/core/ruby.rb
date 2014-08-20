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
        __huia__send('create').tap do |o|
          o.object = object
        end
      end)

      __huia__send('def:as:', 'sendMessage:', proc do |signature|
        object.public_send signature.to_sym
      end)

      __huia__send('def:as:', 'sendMessage:withArgs:', proc do |signature, args|
        object.public_send signature.to_sym, *args
      end)

    end)
  end
end

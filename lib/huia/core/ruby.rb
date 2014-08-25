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

      __huia__send('def:as:', 'send:withArgs:andBlock:', proc do |signature, args, block|
        signature = signature.to_ruby if signature.respond_to? :to_ruby
        block     = block.to_ruby     if block.respond_to?     :to_ruby
        args = args.to_ruby if args.is_a? ::Huia::Core::Array
        args = Array(args)
        args = args.map do |arg|
          if arg.respond_to? :to_ruby
            arg.to_ruby
          else
            arg
          end
        end
        ::Huia::Core::Ruby.__huia__send('createFromObject:', object.public_send(signature.to_sym, *args, &block))
      end)

      __huia__send('def:as:', 'send:', proc do |signature|
        __huia__send('send:withArgs:andBlock:', signature, [], -> {})
      end)

      __huia__send('def:as:', 'send:withArgs:', proc do |signature,args|
        __huia__send('send:withArgs:andBlock:', signature, args, -> {})
      end)

      __huia__send('def:as:', 'send:withBlock:', proc do |signature,block|
        __huia__send('send:withArgs:andBlock:', signature, [], block)
      end)

      define_method :to_ruby do
        object
      end

    end)
  end
end

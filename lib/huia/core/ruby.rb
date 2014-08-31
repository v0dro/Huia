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
        signature = normalize_signature signature
        block     = normalize_block     block
        args      = normalize_args      args
        result = object.public_send(signature, *args, &block)
        normalize_result result
      end)

      __huia__send('def:as:', 'send:', proc do |signature|
        signature = normalize_signature signature
        result = object.public_send(signature)
        normalize_result result
      end)

      __huia__send('def:as:', 'send:withArgs:', proc do |signature,args|
        signature = normalize_signature signature
        args      = normalize_args      args
        result = object.public_send(signature, *args)
        normalize_result result
      end)

      __huia__send('def:as:', 'send:withBlock:', proc do |signature,block|
        signature = normalize_signature signature
        block     = normalize_block     block
        result = object.public_send(signature, &block)
        normalize_result result
      end)

      __huia__send('def:as:', 'truthy?', proc do
        if !!object
          ::Huia::Core::True.__huia__send('create')
        else
          ::Huia::Core::False.__huia__send('create')
        end
      end)

      define_method :to_ruby do
        object
      end

      define_method :normalize_signature do |signature|
        signature.to_str.to_sym
      end

      define_method :normalize_block do |block|
        return block.to_ruby if block.respond_to? :to_ruby
        block
      end

      define_method :normalize_args do |args|
        return args.to_ruby if args.is_a? ::Huia::Core::Array
        args = Array(args)
      end

      define_method :normalize_result do |result|
        return result if ::Huia::Core::Object === result
        ::Huia::Core::Ruby.__huia__send('createFromObject:', result)
      end

    end)
  end
end

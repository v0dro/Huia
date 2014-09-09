module Huia
  module Core
    Ruby = Object.__huia__send('extend:', proc do

      attr_accessor :object

      define_method_as 'createFromConstant:' do |constant|
        constant = constant.to_ruby if constant.respond_to? :to_ruby

        const = constant.split('::').inject(Kernel) do |parent, const|
          parent.const_get(const.to_sym)
        end
        __huia__send('create').tap do |o|
          o.object = const
        end
      end

      define_method_as 'createFromObject:' do |object|
        object = object.to_ruby if object.respond_to? :to_ruby
        huia_send('create').tap do |o|
          o.object = object
        end
      end

      define_instance_method_as 'send:withArgs:andBlock:' do |signature, args, block|
        signature = normalize_signature signature
        block     = normalize_block     block
        args      = normalize_args      args

        result = object.public_send(signature, *args, &block)
        normalize_result result
      end

      define_instance_method_as 'send:' do |signature|
        signature = normalize_signature signature

        result = object.public_send(signature)
        normalize_result result
      end

      define_instance_method_as 'send:withArgs:' do |signature, args|
        signature = normalize_signature signature
        args      = normalize_args      args

        result = object.public_send(signature, *args)
        normalize_result result
      end

      define_instance_method_as 'send:withBlock:' do |signature, block|
        signature = normalize_signature signature
        block     = normalize_block     block

        result = object.public_send(signature, &block)
        normalize_result result
      end

      define_instance_method_as 'truthy?' do
        if !!object
          ::Huia::Core.true
        else
          ::Huia::Core.false
        end
      end

      define_instance_method_as 'inspect' do
        klass_name = self.class.to_s.split('::').last
        ::Huia::Core.string "<Class(#{klass_name})##{object_id} object=#{object.inspect}>"
      end

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

        ::Huia::Core::Ruby.create_from_object result
      end

      def self.create_from_object object
        self.__huia__send('createFromObject:', object)
      end
    end)
  end
end

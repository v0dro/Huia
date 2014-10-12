# # `Ruby`
#
# Implements an object proxy between the Ruby and Huia runtime environments.
#
# Inherits from [[Object]].
#
# ## Methods defined by the Huia VM:
module Huia
  module Core
    Ruby = Object.__huia__send('extend:', proc do

      attr_accessor :object

      # ### `Ruby.createFromConstant:` **Public**
      #
      # Return an instance of [[Ruby]] wrapping a given Ruby constant.
      #
      # Arguments:
      #   - `constant`: a [[String]] representing the name of the Ruby constant to wrap.
      define_method_as 'createFromConstant:' do |constant|
        constant = constant.to_ruby if constant.respond_to? :to_ruby

        const = constant.split('::').inject(Kernel) do |parent, const|
          parent.const_get(const.to_sym)
        end
        __huia__send('create').tap do |o|
          o.object = const
        end
      end

      # ### `Ruby.createFromObject:` **Public**
      #
      # Return an instance of [[Ruby]] wrapping a given Ruby object.
      # This is useful for wrapping the results of other [[Ruby]] instances.
      #
      # Arguments:
      #   - `object`: a Ruby object to wrap.
      define_method_as 'createFromObject:' do |object|
        object = object.to_ruby if object.respond_to? :to_ruby
        huia_send('create').tap do |o|
          o.object = object
        end
      end

      # ### `Ruby#send:withArgs:andBlock:` **Public**
      #
      # Send a method call to the wrapped Ruby object with arguments and a block.
      #
      # Arguments:
      #   - `signature`: the method signature to send [[String]].
      #   - `args`: an [[Array]] of arguments to pass to the method call.
      #   - `block`: a [[Closure]] or block to pass to the method.
      define_instance_method_as 'send:withArgs:andBlock:' do |signature, args, block|
        signature = normalize_signature signature
        block     = normalize_block     block
        args      = normalize_args      args

        result = object.public_send(signature, *args, &block)
        normalize_result result
      end

      # ### `Ruby#send:` **Public**
      #
      # Send a method call to the wrapped Ruby object.
      #
      # Arguments:
      #   - `signature`: the method signature to send [[String]].
      define_instance_method_as 'send:' do |signature|
        signature = normalize_signature signature

        result = object.public_send(signature)
        normalize_result result
      end

      # ### `Ruby#send:withArgs:` **Public**
      #
      # Send a method call to the wrapped Ruby object with arguments.
      #
      # Arguments:
      #   - `signature`: the method signature to send [[String]].
      #   - `args`: an [[Array]] of arguments to pass to the method call.
      define_instance_method_as 'send:withArgs:' do |signature, args|
        signature = normalize_signature signature
        args      = normalize_args      args

        result = object.public_send(signature, *args)
        normalize_result result
      end

      # ### `Ruby#send:withBlock:` **Public**
      #
      # Send a method call to the wrapped Ruby object with a block.
      #
      # Arguments:
      #   - `signature`: the method signature to send [[String]].
      #   - `block`: a [[Closure]] or block to pass to the method.
      define_instance_method_as 'send:withBlock:' do |signature, block|
        signature = normalize_signature signature
        block     = normalize_block     block

        result = object.public_send(signature, &block)
        normalize_result result
      end

      # ### `Ruby#truthy?` **Public**
      #
      # Returns [[True]] or [[False]] depending on whether the object is
      # truthy or not.
      define_instance_method_as 'truthy?' do
        if !!object
          ::Huia::Core.true
        else
          ::Huia::Core.false
        end
      end

      # ### `Ruby#inspect` **Public**
      #
      # Returns a human readable representation of the object.
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
        if block.respond_to? :__huia__send
          proc do |*args|
            __huia__call(block, self, *args.flatten)
          end
        else
          block
        end
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

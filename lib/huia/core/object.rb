# The most basic definition of object.  See also `core/object`.

module Huia
  module Core
    class Object < ::Object
      include ObjectMixin
      include BootstrapMethods

      class << self
        puts self.methods.grep /huia/i
        # __huia__send('definePrivateMethod:as:', 'defineInstanceMethod:as:', proc do |signature,closure|
        #   @instanceMethods[signature] = closure
        #   __huia__define_method signature do |*args|
        #     instance_exec *args, &__huia__send('defaultResponderFor:', signature).block
        #   end
        # end)
        # __huia__alias_private('defineInstanceMethod:as:', 'def:as:')

        # __huia__send('definePrivateMethod:as:', 'definePrivateInstanceMethod:as:', proc do |signature,closure|
        #   @privateInstanceMethods[signature] = closure
        #   __huia__define_method signature do |*args|
        #     instance_exec *args, &__huia__send('defaultResponderFor:', signature).block
        #   end
        # end)
        # __huia__alias_private('definePrivateInstanceMethod:as:', 'defp:as:')

        # __huia__send('defineMethod:as:', 'extendWith:', proc do |closure|
        #   Class.new(self, &closure.block)
        # end)
      end
    end
  end
end

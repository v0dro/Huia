module Huia
  module Core
    class Closure < Object

      def initialize
        super
      end

      huia_method "callWithSelf:andArgs:" do |_self,args|
        @block.instance_exec _self, *args
      end

    end
  end
end

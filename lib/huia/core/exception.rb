# # `Exception`
#
# Abstract exception superclass.
#
# Inherits from [[Object]].
module Huia
  module Core
    Exception = Object.__huia__send('extend:', proc do

      attr_accessor :backtrace
      attr_reader :message

      class RuntimeException < ::RuntimeError

        attr_reader :message

        def initialize message, huia_exception
          @message        = message
          @huia_exception = huia_exception
        end

        def backtrace
          super.grep /(.*\.huiac?:\d+)|\(eval\)/
        end

        def huia_exception
          @huia_exception.backtrace = backtrace
          @huia_exception
        end
      end

      define_method :exception do
        RuntimeException.new @message, self
      end
    end)
  end
end

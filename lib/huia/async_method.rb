require 'mr_darcy'

# Configure MrDarcy to use Celluloid.
MrDarcy.driver = :celluloid

module Huia
  module AsyncMethod

    attr_reader :promise

    def __huia__send signature, *args
      puts "Using async dispatch for #{signature}."

      this = self

      __huia__promise do
        MrDarcy.promise do |promise|
          promise.resolve __huia__send_to_drf(signature)
        end.then do |closure|
          __huia__call closure, this, *args
        end
      end
    end

    private

    def __huia__promise
      promise = yield.fail { |e| raise e }
      if @promise
        @promise.then { promise }
      else
        @promise = promise
      end
    end
  end
end

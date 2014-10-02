# # `Exception`
#
# Abstract exception superclass.
#
# Inherits from [[Object]].
module Huia
  module Core
    Exception = Object.__huia__send('extend:', proc do
    end)
  end
end

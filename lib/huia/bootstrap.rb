require 'huia/bootstrap/base_object'
require 'huia/bootstrap/class_object'
require 'huia/bootstrap/class_instance'

module Huia
  module Bootstrap

    def singleton_object
      @object ||= BaseObject.new
    end
    module_function :singleton_object

  end
end

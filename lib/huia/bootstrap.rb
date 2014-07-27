require 'huia/bootstrap/ivar_table'
require 'huia/bootstrap/object_object'
require 'huia/bootstrap/class_object'
require 'huia/bootstrap/method_class'
require 'huia/bootstrap/default_responder'
require 'huia/bootstrap/initialize'

module Huia
  module Bootstrap

    module_function

    def object_object
      @object_object ||= ObjectObject.new.tap do |o|
        o.add_method { |binding| DefaultResponder.new binding }
      end
    end

  end
end

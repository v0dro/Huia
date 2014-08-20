module Huia
  module Core

    core_classes = %w| Object Closure Literal Numeric Integer Float String Symbol Nil True False |

    core_classes.each do |name|
      require "huia/core/#{name.downcase}"
    end

    core_classes.each do |const|
      klass = const_get const
      klass.__huia__load_core if klass.respond_to? :__huia__load_core
    end
  end
end

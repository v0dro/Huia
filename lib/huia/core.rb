# These constants represent the core classes which are available as constants
# inside the Huia runtime.  Some of them have methods defined in Ruby, and
# most of them have methods also defined in Huia code.
#
# The rest of the files in the `core` directory will be used to create the
# Huia standard library, and can be used in the runtime by calling
# `Huia.requireCore: 'Stdout'` for example.
module Huia
  module Core
    core_classes = %w| Object Closure Huia Ruby Literal Numeric Integer Float String Nil True False Array Hash Exception |

    core_classes.each do |name|
      require "huia/core/#{name.downcase}"
    end

    core_classes.each do |const|
      klass = const_get const
      klass.__huia__load_core if klass.respond_to? :__huia__load_core
    end

    module_function

    def true
      ::Huia::Core::True.__huia__send('create')
    end

    def false
      ::Huia::Core::False.__huia__send('create')
    end

    def string value
      ::Huia::Core::String.__huia__send('createFromValue:', value.to_s)
    end

    def integer value
      ::Huia::Core::Integer.__huia__send('createFromValue:', value.to_i)
    end

    def nil
      ::Huia::Core::Nil.__huia__send('create')
    end

    def array default=[]
      ::Huia::Core::Array.__huia__send('createFromValue:', default)
    end

    def hash default={}
      ::Huia::Core::Hash.__huia__send('createFromValue:', default)
    end
  end
end

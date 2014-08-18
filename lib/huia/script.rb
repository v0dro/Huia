module Huia
  class Script
    def initialize compiled_method, filename, scope=MAIN
      @compiled_method = compiled_method
      @filename        = filename
      @scope           = scope

      puts @compiled_method.decode
    end

    def invoke
      top = Huia::Core::Object.__huia__send 'create'
      closure.__huia__send 'callWithSelf:andArgs:', top, []
    end

    def closure
      script = @compiled_method.create_script false
      script.file_path = @filename
      MAIN.__send__ :__script__
    end
  end
end

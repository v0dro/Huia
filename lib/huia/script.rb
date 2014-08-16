module Huia
  class Script
    def initialize compiled_method
      @compiled_method = compiled_method
    end

    def invoke filename, scope=MAIN
      script = @compiled_method.create_script false
      script.file_path = filename
      MAIN.__send__ :__script__
    end
  end
end

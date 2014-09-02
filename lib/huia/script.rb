module Huia
  class Script

    attr_reader :compiled_method

    def initialize compiled_method, filename, scope=MAIN
      @compiled_method = compiled_method
      @filename        = filename
      @scope           = scope
    end

    def invoke main = new_object_instance
      main.instance_exec([], &closure.block)
    end

    def closure
      script = @compiled_method.create_script false
      script.file_path = @filename
      MAIN.__send__ :__script__
    end

    def dump_bytecode
      puts_block @compiled_method
    end

    private

    def new_object_instance
      Huia::Core::Object.__huia__send('create')
    end

    def puts_block cm
      puts "---BEGIN: #{cm.name.inspect} / #{cm.file.inspect}"
      puts "locals: " << cm.local_names.to_a.each_with_index.map { |name, i| "#{i}: #{name}" }.join(" ") if cm.local_names
      puts cm.decode
      puts "---END\n\n"

      cm.child_methods.each do |child|
        puts_block child
      end
    end
  end
end

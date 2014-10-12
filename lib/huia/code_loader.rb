module Huia
  class CodeLoader
    LoadError = Class.new(RuntimeError)

    attr_reader :file, :wd, :path

    HUIA_EXT  = 'huia'
    CHUIA_EXT = 'huiac'

    def initialize file, wd
      @file = file
      @wd   = wd
      @path = absolute_path_for file, wd
    end

    def load
      if File.exist? compiled_filename
        load_compiled_file
      elsif File.exist? uncompiled_filename
        compile_and_load_file
      else
        raise LoadError, "Can't find file: #{@file} (tried #{@path}.[#{CHUIA_EXT},#{HUIA_EXT}])"
      end
    end

    def compiled_filename
      @compiled_filename ||= "#{filename_without_extension}.#{CHUIA_EXT}"
    end

    def uncompiled_filename
      @uncompiled_filename ||= "#{filename_without_extension}.#{HUIA_EXT}"
    end

    private

    def filename_without_extension
      @filename_without_extension ||= if File.extname(@file) == ".#{HUIA_EXT}"
                                        @path[0..-6]
                                      elsif File.extname(@file) == ".#{CHUIA_EXT}"
                                        @path[0..-7]
                                      else
                                        @path
                                      end
    end

    def load_compiled_file
      if needs_recompile?
        @compiled_file = begin
                           compile
                           really_load_compiled_file
                         end
      else
        @compiled_file ||= really_load_compiled_file
      end
    end

    def really_load_compiled_file
      cl = Rubinius::CodeLoader.new(compiled_filename)
      cl.load_compiled_file(compiled_filename, 0, 0)
    end

    def compile_and_load_file
      compile
      load_compiled_file
    end

    def needs_recompile?
      mtime_of(uncompiled_filename) > mtime_of(compiled_filename)
    end

    def compile
      Huia::Compiler.compile_from uncompiled_filename, to: compiled_filename
    end

    def mtime_of file
      File.stat(file).mtime
    end

    def is_absolute_path? file
      file[0] == '/'
    end

    def absolute_path_for file, wd
      if is_absolute_path? file
        file
      else
        File.join(wd, file)
      end
    end

  end
end

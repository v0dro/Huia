require 'polyglot'

module Huia
  class HuiaLoader
    def self.load filename, options=nil
      filename << ".huia" unless filename[-5..-1] == ".huia"
      puts "attempting to load #{filename}"
      Huia.load(filename).invoke
    end
  end
end

Polyglot.register 'huia', Huia::HuiaLoader

module Kernel
  alias polyglot_original_load load

  # Load is often called with an absolute filename, so we rescue
  # SyntaxError also
  def load *a, &b
    polyglot_original_load(*a, &b)
  rescue LoadError, SyntaxError => load_error
    begin
      Polyglot.load(*a, &b)
    rescue Polyglot::NestedLoadError => e
      e.reraise
    rescue LoadError
      # Raise the origina exception, possibly a MissingSourceFile with a path
      raise load_error
    end
  end
end

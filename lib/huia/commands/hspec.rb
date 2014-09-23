require 'optparse'

module Huia
  module Commands
    class Hspec

      def initialize argv
        @argv    = argv
        @options = {}

        parse_options

        files = @argv
        files += Dir['spec/**/*_spec.huia'] unless files.size > 0
        files.each do |filename|
          ::Huia.load(filename).invoke
        end
      end

      private

      def parse_options
        option_parser.parse! @argv
      end

      def option_parser
        OptionParser.new do |opts|
          opts.banner = "Usage: hspec [options] <directory|filename_spec.huia>..."
        end
      end

    end
  end
end

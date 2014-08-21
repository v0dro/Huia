require 'optparse'

module Huia
  module Commands
    class Huia

      def initialize argv
        @argv    = argv
        @options = {}

        parse_options

        return print_version_string if @options[:version]
        return print_help_string    if @options[:help]

        @filename = argv.pop

        unless @filename
          STDERR.puts "Required parameter, <filename.huia> missing."
          exit(1)
        end

        ::Huia.load(@filename).invoke
      end

      private

      def print_version_string
        puts "Huia version #{::Huia::VERSION} running on #{RUBY_ENGINE} #{RUBY_VERSION}p#{RUBY_PATCHLEVEL}."
        exit(0)
      end

      def print_help_string
        puts option_parser
        exit(0)
      end

      def parse_options
        option_parser.parse! @argv
      end

      def option_parser
        OptionParser.new do |opts|
          opts.banner = "Usage: huia [options] <filename.huia>"

          opts.on_tail('-v', '--version', "Print version, and exit.") do
            @options[:version] = true
          end

          opts.on_tail('-h', '--help', "Show this message.") do
            @options[:help] = true
          end
        end
      end

    end
  end
end

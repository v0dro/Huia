require 'optparse'

module Huia
  module Commands
    class Huia

      def initialize argv
        @argv    = argv
        @options = {}

        parse_options

        print_version_string if @options[:version]
        print_help_string    if @options[:help]

        @filename = argv.pop

        unless @filename || @options[:evaluate]
          STDERR.puts "Required parameter, <filename.huia> missing."
          exit(1)
        end

        script = if @options[:evaluate]
                   ::Huia.eval(@options[:evaluate])
                 else
                   ::Huia.load(@filename, Dir.getwd)
                 end

        if @options[:bytecode_debug]
          script.dump_bytecode
        else
          script.invoke
        end
      end

      private

      def print_version_string
        puts ::Huia::DESCRIPTION
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

          opts.on('-e', '--evaluate SCRIPT', "Evaluate the passed argument as a script, then exit.") do |script|
            @options[:evaluate] = script
          end

          opts.on_tail('-b', '--bytecode', "Print compiler bytecode output for the given file, then exit.") do
            @options[:bytecode_debug] = true
          end

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

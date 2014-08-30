require 'optparse'
require 'readline'
require 'pry'

module Huia
  module Commands
    class Hirb
      def initialize argv
        @argv    = argv
        @options = {}

        parse_options

        print_version_string if @options[:version]
        print_help_string    if @options[:help]

        puts "#{::Huia::DESCRIPTION}, starting REPL."
        puts "  use '\\' on the end of the line for multiline input."
        repl
      end

      private

      def repl
        @main = ::Huia::Core::Object.__huia__send('create')
        loop do
          line = collect_lines
          begin
            result = ::Huia.eval(line).invoke(@main)
          rescue SystemExit
            exit(0)
          rescue Exception => e
            puts "#{e.class}: #{e.message}"
            puts "  #{e.backtrace.join("\n  ")}"
          end
          print_result result
        end
      end

      def collect_lines multiline=false
        line = Readline.readline(prompt(multiline), true)
        unless line
          puts "Exiting Huia REPL"
          exit 0
        end
        line = line.chomp
        if line[-1] == "\\"
          line = line[0..-2] + "\n"
          line += collect_lines(true)
        end
        line + "\n"
      end

      def prompt multiline=false
        multiline ? '>| ' : '>> '
      end

      def print_result result
        return puts "WARNING: object #{result.inspect} is not a Huia object!" unless result.respond_to? :__huia__send
        result = result.__huia__send('inspect')
        puts sprintf(" => %s", result.value)
      end

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
          opts.banner = "Usage: hirb [options]"

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

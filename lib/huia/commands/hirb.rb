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

      def main
        @main ||= begin
                    file = File.expand_path('../hirb.huia', __FILE__)
                    ::Huia.load(file).invoke.huia_send('create')
                  end
      end

      def repl
        loop do
          line = collect_lines
          line = rewrite_line(line)
          begin
            result = ::Huia.eval(line).invoke(main)
          rescue SystemExit
            exit(0)
          rescue ::Huia::Core::RuntimeException => e
            e  = e.huia_exception
            bt = e.backtrace
            puts "#{e.huia_send('inspect').to_s}: #{e.huia_send('message').to_s}"
            puts "  #{bt.join("\n  ")}"
          rescue ::Huia::SyntaxError => e
            puts e.message
          rescue Exception => e
            puts "#{e.class}: #{e.message}"
            puts "  #{e.backtrace.join("\n  ")}"
          end
          print_result result
        end
      end

      def rewrite_line line
        return "self.exit\n" if line == "exit\n"
        return "self.displayHelp\n" if line == "help\n"
        line
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
        return if result.nil?
        return puts "WARNING: object #{result.inspect} is not a Huia object!" unless result.respond_to?(:__huia__send)
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

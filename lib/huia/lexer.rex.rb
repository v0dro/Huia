# encoding: UTF-8
#--
# This file is automatically generated. Do not modify it.
# Generated by: oedipus_lex version 2.3.2.
# Source: lib/huia/lexer.rex
#++

class Huia::Lexer
  require 'strscan'

  IDENTIFIER = /[a-zA-Z_][a-zA-Z_0-9]*/
  INT        = /(0|[1-9][0-9]*)/

  class ScanError < StandardError ; end

  attr_accessor :lineno
  attr_accessor :filename
  attr_accessor :ss
  attr_accessor :state

  alias :match :ss

  def matches
    m = (1..9).map { |i| ss[i] }
    m.pop until m[-1] or m.empty?
    m
  end

  def action
    yield
  end

  def scanner_class
    StringScanner
  end unless instance_methods(false).map(&:to_s).include?("scanner_class")

  def parse str
    self.ss     = scanner_class.new str
    self.lineno = 1
    self.state  ||= nil

    do_parse
  end

  def parse_file path
    self.filename = path
    open path do |f|
      parse f.read
    end
  end

  def next_token

    token = nil

    until ss.eos? or token do
      token =
        case state
        when nil, :interpolation, :hash then
          case
          when text = ss.scan(/'/) then
            [:state, :SINGLE_TICK_STRING]
          when text = ss.scan(/"/) then
            action { @state.push :DOUBLE_TICK_STRING; [ :DOUBLE_TICK_STRING, '' ] }
          when text = ss.scan(/#{INT}\.[0-9]+/) then
            action { [ :FLOAT, text ] }
          when text = ss.scan(/0x[0-9a-fA-F]+/) then
            action { [ :INTEGER, text.to_i(16) ] }
          when text = ss.scan(/0b[01]+/) then
            action { [ :INTEGER, text.to_i(2) ] }
          when text = ss.scan(/#{INT}/) then
            action { [ :INTEGER, text.to_i ] }
          when text = ss.scan(/Object/) then
            action { [ :CONSTANT, text ] }
          when text = ss.scan(/Closure/) then
            action { [ :CONSTANT, text ] }
          when text = ss.scan(/Huia/) then
            action { [ :CONSTANT, text ]}
          when text = ss.scan(/Ruby/) then
            action { [ :CONSTANT, text ]}
          when text = ss.scan(/true/) then
            action { [ :TRUE, text ] }
          when text = ss.scan(/false/) then
            action { [ :FALSE, text ] }
          when text = ss.scan(/nil/) then
            action { [ :NIL, text ] }
          when text = ss.scan(/self/) then
            action { [ :SELF, text ] }
          when text = ss.scan(/#.*/) then
            action { [ :COMMENT,     text ] }
          when text = ss.scan(/#{IDENTIFIER}\:/) then
            action { [ :SIGNATURE,  text ] }
          when text = ss.scan(/#{IDENTIFIER}[?!]/) then
            action { [ :CALL, text ] }
          when text = ss.scan(/#{IDENTIFIER}/) then
            action { [ :IDENTIFIER,  text ] }
          when text = ss.scan(/\[\]/) then
            action { [ :BOX, text ] }
          when text = ss.scan(/\[/) then
            action { [ :LSQUARE, text ] }
          when text = ss.scan(/\]/) then
            action { [ :RSQUARE, text ] }
          when text = ss.scan(/\{\}/) then
            action { [ :FACES, text ] }
          when text = ss.scan(/\{/) then
            action { @state.push :hash; [ :LFACE, text ] }
          when text = ss.scan(/\<-/) then
            action { [ :RETURN, text ] }
          when text = ss.scan(/\./) then
            action { [ :DOT, text ] }
          when text = ss.scan(/\:/) then
            action { [ :COLON, text ] }
          when text = ss.scan(/\==/) then
            action { [ :EQUALITY, text ] }
          when text = ss.scan(/\!=/) then
            action { [ :NOT_EQUALITY, text ] }
          when text = ss.scan(/\=/) then
            action { [ :EQUAL, text ] }
          when text = ss.scan(/\+/) then
            action { [ :PLUS, text ] }
          when text = ss.scan(/,/) then
            action { [ :COMMA, text ] }
          when text = ss.scan(/\|/) then
            action { [ :PIPE, text ] }
          when text = ss.scan(/\-/) then
            action { [ :MINUS, text ] }
          when text = ss.scan(/\*\*/) then
            action { [ :EXPO, text ] }
          when text = ss.scan(/\*/) then
            action { [ :ASTERISK, text ] }
          when text = ss.scan(/\//) then
            action { [ :FWD_SLASH, text ] }
          when text = ss.scan(/%/) then
            action { [ :PERCENT, text ] }
          when text = ss.scan(/\(/) then
            action { [ :OPAREN, text ] }
          when text = ss.scan(/\)/) then
            action { [ :CPAREN, text ] }
          when text = ss.scan(/\!/) then
            action { [ :BANG, text ] }
          when text = ss.scan(/\~/) then
            action { [ :TILDE, text ] }
          when text = ss.scan(/[\n\r][\n\t\r ]*/) then
            in_or_out_dent text
          when text = ss.scan(/\s+/) then
            # do nothing
          when (state == :interpolation) && (text = ss.scan(/\}/)) then
            action { @state.pop; [ :INTERPOLATE_END, '}'] }
          when (state == :hash) && (text = ss.scan(/\}/)) then
            action { @state.pop; [ :RFACE, text ] }
          else
            text = ss.string[ss.pos .. -1]
            raise ScanError, "can not match (#{state.inspect}): '#{text}'"
          end
        when :SINGLE_TICK_STRING then
          case
          when text = ss.scan(/[^']+/) then
            action { [ :STRING, text ] }
          when text = ss.scan(/'/) then
            [:state, nil]
          else
            text = ss.string[ss.pos .. -1]
            raise ScanError, "can not match (#{state.inspect}): '#{text}'"
          end
        when :DOUBLE_TICK_STRING then
          case
          when text = ss.scan(/#{'#{'}/) then
            action { @state.push :interpolation; [ :INTERPOLATE_START, '#{' ] }
          when text = ss.scan(/[^"]/) then
            action { [ :CHAR, text ] }
          when text = ss.scan(/"/) then
            action { @state.pop; [ :DOUBLE_TICK_STRING_END, '' ] }
          else
            text = ss.string[ss.pos .. -1]
            raise ScanError, "can not match (#{state.inspect}): '#{text}'"
          end
        else
          raise ScanError, "undefined state: '#{state}'"
        end # token = case state

      next unless token # allow functions to trigger redo w/ nil
    end # while

    raise "bad lexical result: #{token.inspect}" unless
      token.nil? || (Array === token && token.size >= 2)

    # auto-switch state
    self.state = token.last if token && token.first == :state

    token
  end # def next_token
end # class

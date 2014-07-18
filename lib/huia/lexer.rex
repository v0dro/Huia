class Huia::Lexer

options
  do_parse

macros
  IDENTIFIER      /[a-zA-Z_][a-zA-Z_0-9]*/
  METHOD_SIG      /[a-z][a-zA-Z0-9_]*/
  W               /\s+/
  NL              /\\n/
  INT             /(0|[1-9][0-9]*)/

rules
                          /'/                    :SINGLE_TICK_STRING
  :SINGLE_TICK_STRING     /[^']+/                { [ :string, text ] }
  :SINGLE_TICK_STRING     /'/                    nil

                          /"/                    :DOUBLE_TICK_STRING
  :DOUBLE_TICK_STRING     /[^"]+/                { [ :string, text ] }
  :DOUBLE_TICK_STRING     /"/                    nil

                          /#{INT}\.[0-9]+/       { [ :float, text ] }
                          /0x[0-9a-fA-F]+/       { [ :integer, text.to_i(16) ] }
                          /0b[01]+/              { [ :integer, text.to_i(2) ] }
                          /#{INT}/               { [ :integer, text ] }

                          /\s*(\#.*)/            { [ :comment,     text ] }
                          /#{IDENTIFIER}/        { [ :identifier,  text ] }

                          /\./                   { [ :dot, text ] }
                          /\:/                   { [ :colon, text ] }
                          /\=/                   { [ :equal, text ] }
                          /\n[\ \t]*/            in_or_out_dent
                          /\s+/


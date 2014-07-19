class Huia::Lexer

macros
  IDENTIFIER      /[a-zA-Z_][a-zA-Z_0-9]*/
  METHOD_SIG      /[a-z][a-zA-Z0-9_]*/
  W               /\s+/
  NL              /\\n/
  INT             /(0|[1-9][0-9]*)/

rules
                          /'/                    :SINGLE_TICK_STRING
  :SINGLE_TICK_STRING     /[^']+/                { [ :STRING, text ] }
  :SINGLE_TICK_STRING     /'/                    nil

                          /"/                    :DOUBLE_TICK_STRING
  :DOUBLE_TICK_STRING     /[^"]+/                { [ :STRING, text ] }
  :DOUBLE_TICK_STRING     /"/                    nil

                          /#{INT}\.[0-9]+/       { [ :FLOAT, text ] }
                          /0x[0-9a-fA-F]+/       { [ :INTEGER, text.to_i(16) ] }
                          /0b[01]+/              { [ :INTEGER, text.to_i(2) ] }
                          /#{INT}/               { [ :INTEGER, text ] }

                          /\s*(\#.*)/            { [ :COMMENT,     text ] }
                          /#{IDENTIFIER}/        { [ :IDENTIFIER,  text ] }

                          /\./                   { [ :DOT, text ] }
                          /\:/                   { [ :COLON, text ] }
                          /\=/                   { [ :EQUAL, text ] }
                          /\n[\ \t]*/            in_or_out_dent
                          /\s/                   { [ :WS, text ] }


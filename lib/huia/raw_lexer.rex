class Huia::RawLexer

macros
  IDENTIFIER      /[a-zA-Z_][a-zA-Z_0-9]*/
  INT             /(0|[1-9][0-9]*)/

rules
                          /'/                    :SINGLE_TICK_STRING
  :SINGLE_TICK_STRING     /[^']+/                { [ :STRING, text ] }
  :SINGLE_TICK_STRING     /'/                    nil

                          /"/                    :DOUBLE_TICK_STRING
  :DOUBLE_TICK_STRING     /[^"]+/                { [ :STRING, text ] }
  :DOUBLE_TICK_STRING     /"/                    nil

                          /def/                  { [ :DEF, text ] }

                          /#{INT}\.[0-9]+/       { [ :FLOAT, text ] }
                          /0x[0-9a-fA-F]+/       { [ :INTEGER, text.to_i(16) ] }
                          /0b[01]+/              { [ :INTEGER, text.to_i(2) ] }
                          /#{INT}/               { [ :INTEGER, text.to_i ] }

                          /\s*(\#.*)/            { [ :COMMENT,     text ] }
                          /:#{IDENTIFIER}/       { [ :SYMBOL, text ] }
                          /#{IDENTIFIER}\:/      { [ :SIGNATURE,  text ] }
                          /#{IDENTIFIER}/        { [ :IDENTIFIER,  text ] }

                          /\./                   { [ :DOT, text ] }
                          /\:/                   { [ :COLON, text ] }
                          /\=/                   { [ :EQUAL, text ] }
                          /\+/                   { [ :PLUS, text ] }
                          /\-/                   { [ :MINUS, text ] }
                          /\*\*/                 { [ :EXPO, text ] }
                          /\*/                   { [ :ASTERISK, text ] }
                          /\//                   { [ :FWD_SLASH, text ] }
                          /%/                    { [ :PERCENT, text ] }
                          /\(/                   { [ :OPAREN, text ] }
                          /\)/                   { [ :CPAREN, text ] }
                          /\n+[\ \t]+/           in_or_out_dent
                          /\s+/


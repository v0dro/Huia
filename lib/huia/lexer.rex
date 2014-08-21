class Huia::Lexer

macros
  IDENTIFIER      /[a-zA-Z_][a-zA-Z_0-9]*/
  INT             /(0|[1-9][0-9]*)/

rules
                          /'/                    :SINGLE_TICK_STRING
  :SINGLE_TICK_STRING     /[^']+/                { [ :STRING, text ] }
  :SINGLE_TICK_STRING     /'/                    nil

                          /"/                    { @state.push :DOUBLE_TICK_STRING; [ :DOUBLE_TICK_STRING, '' ] }
  :DOUBLE_TICK_STRING     /#{'#{'}/              { @state.push :interpolation; [ :INTERPOLATE_START, '#{' ] }
  :interpolation          /#{'}'}/               { @state.pop; [ :INTERPOLATE_END, '}'] }
  :DOUBLE_TICK_STRING     /[^"]/                 { [ :CHAR, text ] }
  :DOUBLE_TICK_STRING     /"/                    { @state.pop; [ :DOUBLE_TICK_STRING_END, '' ] }

                          /#{INT}\.[0-9]+/       { [ :FLOAT, text ] }
                          /0x[0-9a-fA-F]+/       { [ :INTEGER, text.to_i(16) ] }
                          /0b[01]+/              { [ :INTEGER, text.to_i(2) ] }
                          /#{INT}/               { [ :INTEGER, text.to_i ] }

                          /Object/               { [ :CONSTANT, text ] }
                          /Closure/              { [ :CONSTANT, text ] }
                          /Huia/                 { [ :CONSTANT, text ]}
                          /Ruby/                 { [ :CONSTANT, text ]}

                          /true/                 { [ :TRUE, text ] }
                          /false/                { [ :FALSE, text ] }
                          /nil/                  { [ :NIL, text ] }
                          /self/                 { [ :SELF, text ] }

                          /#.*/                  { [ :COMMENT,     text ] }
                          /#{IDENTIFIER}\:/      { [ :SIGNATURE,  text ] }
                          /#{IDENTIFIER}?!/      { [ :CALL, text ] }
                          /#{IDENTIFIER}/        { [ :IDENTIFIER,  text ] }

                          /\./                   { [ :DOT, text ] }
                          /\:/                   { [ :COLON, text ] }
                          /\==/                  { [ :EQUALITY, text ] }
                          /\=/                   { [ :EQUAL, text ] }
                          /\+/                   { [ :PLUS, text ] }
                          /,/                    { [ :COMMA, text ] }
                          /\|/                   { [ :PIPE, text ] }
                          /\-/                   { [ :MINUS, text ] }
                          /\*\*/                 { [ :EXPO, text ] }
                          /\*/                   { [ :ASTERISK, text ] }
                          /\//                   { [ :FWD_SLASH, text ] }
                          /%/                    { [ :PERCENT, text ] }
                          /\(/                   { [ :OPAREN, text ] }
                          /\)/                   { [ :CPAREN, text ] }
                          /[\n\r][\n\t\r ]*/     in_or_out_dent
                          /\s+/

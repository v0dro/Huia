class Huia::Parser

  rule
    statement: expr
               | /* none */

    expr:    literal

    literal: integer | float | string | symbol
    symbol:  COLON IDENTIFIER { n :Symbol, val }
    float:   FLOAT            { n :Float,   val }
    integer: INTEGER          { n :Integer, val }
    string:  STRING           { n :String,  val }

end

---- inner

attr_accessor :lexer, :result, :state

def initialize lexer
  self.lexer  = lexer
  self.result = []
  self.state  = []
  do_parse
end

def next_token
  nt = lexer.next_token
  # just use a state stack for now, we'll have to do something
  # more sophisticated soon.
  if nt && nt.first == :state
    if nt.last
      state.push << nt.last
    else
      state.pop
    end
    next_token
  else
    nt
  end
end

def node type, *args
  result << Huia::AST.const_get(type).new(*args)
end
alias n node

class Huia::Parser

  token IDENTIFIER EQUAL PLUS MINUS ASTERISK FWD_SLASH COLON FLOAT INTEGER STRING EXPO INDENT OUTDENT OPAREN CPAREN DOT SIGNATURE

  prechigh
    left EXPO
    left ASTERISK FWD_SLASH PERCENT
    left PLUS MINUS

    right EQUAL
  preclow

  rule
    statement: expr
               | /* none */

    expr:      callable
               | binary_op
               | method_call

    callable:  literal | variable | grouped_expr

    method_call:   callable DOT call_signature     { return n :MethodCall, val[0], val[2] }

    call_signature: call_arguments | simple_name

    simple_name:    IDENTIFIER                     { return n :CallSignature, val[0] }
    call_argument:  SIGNATURE callable             { return n :CallSignature, val[0], [val[1]] }
    call_arguments: call_argument
                    | call_arguments call_argument { return val[0].concat_signature val[1] }


    grouped_expr: OPAREN expr CPAREN            { return n :Expression, val[1] }

    variable:  IDENTIFIER                       { return n :Variable, val[0] }

    binary_op: assignment
               | addition
               | subtraction
               | multiplication
               | division
               | exponentiation
               | modulo

    assignment:     variable EQUAL expr   { return n :VarAssign, val[0], val[2] }
    addition:       expr PLUS expr        { return n :Addition, val[0], val[2] }
    subtraction:    expr MINUS expr       { return n :Subtraction, val[0], val[2] }
    multiplication: expr ASTERISK expr    { return n :Multiplication, val[0], val[2] }
    division:       expr FWD_SLASH expr   { return n :Division, val[0], val[2]}
    exponentiation: expr EXPO expr        { return n :Exponentiation, val[0], val[2] }
    modulo:         expr PERCENT expr     { return n :Modulo, val[0], val[2] }

    literal:   integer
               | float
               | string
               | symbol

    symbol:         COLON IDENTIFIER            { return n :Symbol,  val[0] }
    float:          FLOAT                       { return n :Float,   val[0] }
    integer:        INTEGER                     { return n :Integer, val[0] }
    string:         STRING                      { return n :String,  val[0] }

end

---- inner

attr_accessor :lexer, :state

def initialize lexer
  self.lexer  = lexer
  self.state  = []
end

def ast
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
  Huia::AST.const_get(type).new(*args)
end
alias n node

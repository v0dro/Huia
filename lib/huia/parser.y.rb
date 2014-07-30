class Huia::Parser

  token IDENTIFIER EQUAL PLUS MINUS ASTERISK FWD_SLASH COLON FLOAT INTEGER STRING EXPO INDENT OUTDENT OPAREN CPAREN DOT SIGNATURE SYMBOL DEF

  prechigh
    left EXPO
    left ASTERISK FWD_SLASH PERCENT
    left PLUS MINUS

    right EQUAL
  preclow

  rule
    statements: statement | statements statement   { return scope }
    statement: expr                                { return scope.append val[0] }

    expr:      callable
               | binary_op
               | method_call
               | def_method

    callable:  literal | variable | grouped_expr

    method_call:            method_call_sans_block | method_call_with_block
    method_call_sans_block: callable DOT call_signature     { return n :MethodCall, val[0], val[2] }
    method_call_with_block: callable DOT call_signature INDENT statements OUTDENT { return n :MethodCall, val[0], val[2], push_scope.append(val[4]) }

    call_signature:         call_arguments | call_simple_name
    call_simple_name:       IDENTIFIER                     { return n :CallSignature, val[0] }
    call_argument:          SIGNATURE callable             { return n :CallSignature, val[0], [val[1]] }
    call_arguments:         call_argument
                            | call_arguments call_argument { return val[0].concat_signature val[1] }

    def_method: def_method_sans_block | def_method_with_block
    def_method_sans_block: DEF def_method_sig
    def_method_with_block: DEF def_method_sig INDENT statements OUTDENT
    def_method_sig: def_method_arguments | def_method_simple_name
    def_method_simple_name: IDENTIFIER                     { return n :DefSignature, val[0] }
    def_method_argument:    SIGNATURE assignment           { return n :DefSignature, val[0], [val[1]] }
    def_method_arguments:   def_method_argument
                            | def_method_arguments def_method_argument { return val[0].concat_signature val[1] }

    grouped_expr: OPAREN expr CPAREN            { return n :Expression, val[1] }

    variable:  IDENTIFIER                       { return scope.allocate val[0] }

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

    symbol:         SYMBOL                      { return n :Symbol,  val[0] }
    float:          FLOAT                       { return n :Float,   val[0] }
    integer:        INTEGER                     { return n :Integer, val[0] }
    string:         STRING                      { return n :String,  val[0] }

end

---- inner

attr_accessor :lexer, :state, :scopes

def initialize lexer
  @lexer  = lexer
  @state  = []
  @scopes = []
  push_scope
end

def ast
  @ast ||= do_parse
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

def push_scope
  puts "pushing new scope."
  scopes.push Huia::AST::Scope.new
end

def scope
  scopes.first
end

def node type, *args
  Huia::AST.const_get(type).new(*args)
end
alias n node

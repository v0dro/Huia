#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.11
# from Racc grammer file "".
#

require 'racc/parser.rb'
module Huia
  class Parser < Racc::Parser

module_eval(<<'...end parser.racc/module_eval...', 'parser.racc', 105)

attr_accessor :lexer, :state, :scopes

def initialize lexer
  @lexer  = lexer
  @state  = []
  @scopes = []
  push_scope
end

def ast
  @ast ||= do_parse
  @scopes.first
end

#def do_parse
#super
#rescue ParseError => e
#  raise SyntaxError, "#{e.message} on line #{@lexer.lineno}"
#end

#def on_error t, val, vstack
#  binding.pry
#end

def next_token
  nt = lexer.next_computed_token
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
  new_scope = Huia::AST::Scope.new scope
  scopes.push new_scope
  new_scope
end

def pop_scope
  scopes.pop
end

def scope
  scopes.last
end

def node type, *args
  Huia::AST.const_get(type).new(*args)
end
alias n node
...end parser.racc/module_eval...
##### State transition tables begin ###

racc_action_table = [
    43,    79,    18,    50,    46,    47,    48,    49,    50,    37,
    38,    39,    50,    89,   -48,    21,    50,    19,    19,    36,
     5,     6,    18,    88,    40,    41,    42,    51,   -48,    37,
    38,    39,    93,    94,    69,    21,    52,    53,    19,    36,
    19,    37,    38,    39,    40,    41,    42,    21,    95,    96,
    88,    36,    18,    71,   100,   nil,    40,    41,    42,    37,
    38,    39,   nil,   nil,    84,    21,   nil,   nil,    19,    36,
     5,     6,    18,   nil,    40,    41,    42,    48,    49,    37,
    38,    39,   nil,    50,    18,    21,   nil,   nil,    19,    36,
   nil,    37,    38,    39,    40,    41,    42,    21,    51,   nil,
    19,    36,    18,   nil,   nil,   nil,    40,    41,    42,    37,
    38,    39,   nil,   nil,   nil,    21,   nil,   nil,    19,    36,
     5,     6,    69,   nil,    40,    41,    42,   nil,   nil,    37,
    38,    39,   nil,    62,   nil,    21,   nil,    48,    49,    36,
    18,   nil,    61,    50,    40,    41,    42,    37,    38,    39,
   nil,   nil,    18,    21,   nil,   nil,    19,    36,    51,    37,
    38,    39,    40,    41,    42,    21,   nil,   nil,    19,    36,
    18,   nil,   nil,   nil,    40,    41,    42,    37,    38,    39,
   nil,   nil,    18,    21,   nil,   nil,    19,    36,   nil,    37,
    38,    39,    40,    41,    42,    21,   nil,   nil,    19,    36,
    18,   nil,   nil,   nil,    40,    41,    42,    37,    38,    39,
   nil,   nil,   nil,    21,   nil,   nil,    19,    36,    18,   nil,
   nil,   nil,    40,    41,    42,    37,    38,    39,   nil,   nil,
    84,    21,   nil,   nil,    19,    36,     5,     6,   nil,   nil,
    40,    41,    42,    46,    47,    48,    49,    46,    47,    48,
    49,    50,   nil,    84,   nil,    50,   nil,   nil,   nil,     5,
     6,   nil,   nil,     5,     6,   nil,    51,   nil,   nil,   nil,
    51,    46,    47,    48,    49,   nil,   nil,   nil,   nil,    50,
   nil,   nil,   nil,    90,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    51 ]

racc_action_check = [
     1,    52,     1,    75,    80,    80,    80,    80,    74,     1,
     1,     1,    80,    68,    18,     1,    77,    52,     1,     1,
     1,     1,    51,    60,     1,     1,     1,    80,    18,    51,
    51,    51,    85,    85,    95,    51,     7,    11,    51,    51,
    16,    95,    95,    95,    51,    51,    51,    95,    87,    93,
    94,    95,    81,    43,    97,   nil,    95,    95,    95,    81,
    81,    81,   nil,   nil,    81,    81,   nil,   nil,    81,    81,
    81,    81,    49,   nil,    81,    81,    81,    73,    73,    49,
    49,    49,   nil,    73,    53,    49,   nil,   nil,    49,    49,
   nil,    53,    53,    53,    49,    49,    49,    53,    73,   nil,
    53,    53,     0,   nil,   nil,   nil,    53,    53,    53,     0,
     0,     0,   nil,   nil,   nil,     0,   nil,   nil,     0,     0,
     0,     0,    19,   nil,     0,     0,     0,   nil,   nil,    19,
    19,    19,   nil,    19,   nil,    19,   nil,    72,    72,    19,
    21,   nil,    19,    72,    19,    19,    19,    21,    21,    21,
   nil,   nil,    50,    21,   nil,   nil,    21,    21,    72,    50,
    50,    50,    21,    21,    21,    50,   nil,   nil,    50,    50,
    46,   nil,   nil,   nil,    50,    50,    50,    46,    46,    46,
   nil,   nil,    47,    46,   nil,   nil,    46,    46,   nil,    47,
    47,    47,    46,    46,    46,    47,   nil,   nil,    47,    47,
    48,   nil,   nil,   nil,    47,    47,    47,    48,    48,    48,
   nil,   nil,   nil,    48,   nil,   nil,    48,    48,    59,   nil,
   nil,   nil,    48,    48,    48,    59,    59,    59,   nil,   nil,
    59,    59,   nil,   nil,    59,    59,    59,    59,   nil,   nil,
    59,    59,    59,    82,    82,    82,    82,     3,     3,     3,
     3,    82,   nil,    82,   nil,     3,   nil,   nil,   nil,    82,
    82,   nil,   nil,     3,     3,   nil,    82,   nil,   nil,   nil,
     3,    70,    70,    70,    70,   nil,   nil,   nil,   nil,    70,
   nil,   nil,   nil,    70,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    70 ]

racc_action_pointer = [
   100,     0,   nil,   243,   nil,   nil,   nil,    19,   nil,   nil,
   nil,    34,   nil,   nil,   nil,   nil,    22,   nil,    11,   120,
   nil,   138,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    53,   nil,   nil,   168,   180,   198,    70,
   150,    20,    -1,    82,   nil,   nil,   nil,   nil,   nil,   216,
    21,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    -7,   nil,
   267,   nil,   131,    71,    -4,    -9,   nil,     4,   nil,   nil,
     0,    50,   239,   nil,   nil,    10,   nil,    45,   nil,   nil,
   nil,   nil,   nil,    29,    48,    32,   nil,    41,   nil,   nil,
   nil ]

racc_action_default = [
   -77,   -77,    -1,    -4,    -5,    -6,    -7,   -10,   -11,   -12,
   -13,   -14,   -15,   -33,   -34,   -36,   -37,   -38,   -39,   -77,
   -45,   -77,   -49,   -50,   -51,   -52,   -53,   -54,   -55,   -63,
   -64,   -65,   -66,   -67,   -68,   -69,   -70,   -71,   -72,   -73,
   -74,   -75,   -76,   -77,    -2,    -3,   -77,   -77,   -77,   -77,
   -77,   -77,   -77,   -77,   -46,   -14,   -16,   -17,   -18,   -77,
   -77,   -24,   -25,   -26,   -27,   -40,   -41,   -42,   -43,   -48,
   -77,   101,   -57,   -58,   -59,   -60,   -61,   -62,   -35,   -39,
   -56,   -77,    -4,   -21,   -22,   -77,   -28,   -30,   -32,   -44,
   -47,   -19,   -20,    -9,   -77,   -77,    -8,   -77,   -29,   -31,
   -23 ]

racc_goto_table = [
    44,    55,    45,    66,     1,    70,    86,    59,    57,    58,
    56,    68,    63,    60,    85,    64,    83,    97,    78,    54,
    65,    67,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    72,    73,    74,    75,    76,    77,   nil,    80,    91,    92,
    98,   nil,   nil,    82,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    81,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    55,   nil,    99,
    44,    45 ]

racc_goto_check = [
     2,    10,     4,     6,     1,     3,    22,    16,    14,    15,
    13,    12,    18,    19,    20,    21,    17,     5,    26,    29,
    30,    31,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
     3,     3,     3,     3,     3,     3,   nil,     3,    17,    17,
    22,   nil,   nil,     3,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,     1,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    10,   nil,     6,
     2,     4 ]

racc_goto_pointer = [
   nil,     4,    -1,   -16,    -1,   -76,   -16,   nil,   nil,   nil,
   -18,   nil,    -8,    -9,   -11,   -10,   -12,   -43,    -7,    -6,
   -46,    -4,   -54,   nil,   nil,   nil,   -34,   nil,   nil,     3,
     1,     2,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil ]

racc_goto_default = [
   nil,   nil,     2,     3,     4,   nil,     7,     8,     9,    10,
    11,    12,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    87,    13,    14,    15,    16,    17,    20,
   nil,   nil,    22,    23,    24,    25,    26,    27,    28,    29,
    30,    31,    32,    33,    34,    35 ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 29, :_reduce_none,
  2, 29, :_reduce_2,
  2, 30, :_reduce_3,
  1, 30, :_reduce_4,
  1, 30, :_reduce_5,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 33, :_reduce_none,
  0, 33, :_reduce_none,
  1, 31, :_reduce_none,
  1, 31, :_reduce_none,
  1, 31, :_reduce_none,
  1, 34, :_reduce_none,
  1, 34, :_reduce_none,
  1, 34, :_reduce_none,
  1, 40, :_reduce_none,
  1, 40, :_reduce_none,
  1, 40, :_reduce_none,
  3, 41, :_reduce_19,
  3, 42, :_reduce_20,
  2, 43, :_reduce_21,
  1, 45, :_reduce_22,
  5, 46, :_reduce_23,
  1, 47, :_reduce_24,
  1, 49, :_reduce_25,
  1, 44, :_reduce_none,
  1, 44, :_reduce_none,
  1, 48, :_reduce_none,
  3, 48, :_reduce_none,
  1, 50, :_reduce_30,
  3, 50, :_reduce_31,
  1, 51, :_reduce_32,
  1, 36, :_reduce_none,
  1, 36, :_reduce_none,
  3, 52, :_reduce_35,
  1, 53, :_reduce_36,
  1, 54, :_reduce_none,
  1, 54, :_reduce_none,
  1, 56, :_reduce_39,
  2, 57, :_reduce_40,
  1, 58, :_reduce_none,
  1, 58, :_reduce_none,
  1, 59, :_reduce_none,
  2, 59, :_reduce_none,
  1, 55, :_reduce_45,
  2, 55, :_reduce_46,
  3, 39, :_reduce_47,
  1, 38, :_reduce_48,
  1, 35, :_reduce_none,
  1, 35, :_reduce_none,
  1, 35, :_reduce_none,
  1, 35, :_reduce_none,
  1, 35, :_reduce_none,
  1, 35, :_reduce_none,
  1, 35, :_reduce_none,
  3, 60, :_reduce_56,
  3, 61, :_reduce_57,
  3, 62, :_reduce_58,
  3, 63, :_reduce_59,
  3, 64, :_reduce_60,
  3, 65, :_reduce_61,
  3, 66, :_reduce_62,
  1, 37, :_reduce_none,
  1, 37, :_reduce_none,
  1, 37, :_reduce_none,
  1, 37, :_reduce_none,
  1, 37, :_reduce_none,
  1, 37, :_reduce_none,
  1, 37, :_reduce_none,
  1, 70, :_reduce_70,
  1, 68, :_reduce_71,
  1, 67, :_reduce_72,
  1, 69, :_reduce_73,
  1, 71, :_reduce_74,
  1, 72, :_reduce_75,
  1, 73, :_reduce_76 ]

racc_reduce_n = 77

racc_shift_n = 101

racc_token_table = {
  false => 0,
  :error => 1,
  :IDENTIFIER => 2,
  :EQUAL => 3,
  :PLUS => 4,
  :MINUS => 5,
  :ASTERISK => 6,
  :FWD_SLASH => 7,
  :COLON => 8,
  :FLOAT => 9,
  :INTEGER => 10,
  :STRING => 11,
  :EXPO => 12,
  :INDENT => 13,
  :OUTDENT => 14,
  :OPAREN => 15,
  :CPAREN => 16,
  :DOT => 17,
  :SIGNATURE => 18,
  :SYMBOL => 19,
  :NL => 20,
  :EOF => 21,
  :PIPE => 22,
  :COMMA => 23,
  :NIL => 24,
  :TRUE => 25,
  :FALSE => 26,
  :PERCENT => 27 }

racc_nt_base = 28

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "IDENTIFIER",
  "EQUAL",
  "PLUS",
  "MINUS",
  "ASTERISK",
  "FWD_SLASH",
  "COLON",
  "FLOAT",
  "INTEGER",
  "STRING",
  "EXPO",
  "INDENT",
  "OUTDENT",
  "OPAREN",
  "CPAREN",
  "DOT",
  "SIGNATURE",
  "SYMBOL",
  "NL",
  "EOF",
  "PIPE",
  "COMMA",
  "NIL",
  "TRUE",
  "FALSE",
  "PERCENT",
  "$start",
  "statements",
  "statement",
  "expr",
  "eol",
  "nlq",
  "callable",
  "binary_op",
  "method_call",
  "literal",
  "variable",
  "grouped_expr",
  "indented",
  "indented_w_stmts",
  "indented_w_expr",
  "indented_wo_stmts",
  "indent",
  "outdent",
  "indent_w_args",
  "indent_pipe",
  "indent_args",
  "indent_wo_args",
  "indent_arg",
  "arg_var",
  "method_call_on_object",
  "method_call_on_self",
  "call_signature",
  "call_arguments",
  "call_simple_name",
  "call_argument",
  "call_passed_arg",
  "call_passed_indented",
  "assignment",
  "addition",
  "subtraction",
  "multiplication",
  "division",
  "exponentiation",
  "modulo",
  "integer",
  "float",
  "string",
  "symbol",
  "nil",
  "true",
  "false" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

module_eval(<<'.,.,', 'parser.racc', 14)
  def _reduce_2(val, _values, result)
     return scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 16)
  def _reduce_3(val, _values, result)
     return scope.append val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 17)
  def _reduce_4(val, _values, result)
     return scope.append val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 18)
  def _reduce_5(val, _values, result)
     return scope 
    result
  end
.,.,

# reduce 6 omitted

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

# reduce 10 omitted

# reduce 11 omitted

# reduce 12 omitted

# reduce 13 omitted

# reduce 14 omitted

# reduce 15 omitted

# reduce 16 omitted

# reduce 17 omitted

# reduce 18 omitted

module_eval(<<'.,.,', 'parser.racc', 32)
  def _reduce_19(val, _values, result)
     return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 33)
  def _reduce_20(val, _values, result)
     return val[0].append(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 34)
  def _reduce_21(val, _values, result)
     return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 35)
  def _reduce_22(val, _values, result)
     return pop_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 38)
  def _reduce_23(val, _values, result)
     return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 39)
  def _reduce_24(val, _values, result)
     return push_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 40)
  def _reduce_25(val, _values, result)
     return push_scope 
    result
  end
.,.,

# reduce 26 omitted

# reduce 27 omitted

# reduce 28 omitted

# reduce 29 omitted

module_eval(<<'.,.,', 'parser.racc', 46)
  def _reduce_30(val, _values, result)
     return scope.add_argument val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 47)
  def _reduce_31(val, _values, result)
     val[0].value = val[2]; return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 48)
  def _reduce_32(val, _values, result)
     return n :Variable, val[0] 
    result
  end
.,.,

# reduce 33 omitted

# reduce 34 omitted

module_eval(<<'.,.,', 'parser.racc', 52)
  def _reduce_35(val, _values, result)
     return n :MethodCall, val[0], val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 53)
  def _reduce_36(val, _values, result)
     return n :MethodCall, scope, val[0] 
    result
  end
.,.,

# reduce 37 omitted

# reduce 38 omitted

module_eval(<<'.,.,', 'parser.racc', 57)
  def _reduce_39(val, _values, result)
     return n :CallSignature, val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 58)
  def _reduce_40(val, _values, result)
     return n :CallSignature, val[0], [val[1]] 
    result
  end
.,.,

# reduce 41 omitted

# reduce 42 omitted

# reduce 43 omitted

# reduce 44 omitted

module_eval(<<'.,.,', 'parser.racc', 62)
  def _reduce_45(val, _values, result)
     return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 63)
  def _reduce_46(val, _values, result)
     return val[0].concat_signature val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 65)
  def _reduce_47(val, _values, result)
     return n :Expression, val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 67)
  def _reduce_48(val, _values, result)
     return scope.allocate val[0] 
    result
  end
.,.,

# reduce 49 omitted

# reduce 50 omitted

# reduce 51 omitted

# reduce 52 omitted

# reduce 53 omitted

# reduce 54 omitted

# reduce 55 omitted

module_eval(<<'.,.,', 'parser.racc', 77)
  def _reduce_56(val, _values, result)
     return n :VarAssign, val[0], val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 78)
  def _reduce_57(val, _values, result)
     return n :Addition, val[0], val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 79)
  def _reduce_58(val, _values, result)
     return n :Subtraction, val[0], val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 80)
  def _reduce_59(val, _values, result)
     return n :Multiplication, val[0], val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 81)
  def _reduce_60(val, _values, result)
     return n :Division, val[0], val[2]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 82)
  def _reduce_61(val, _values, result)
     return n :Exponentiation, val[0], val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 83)
  def _reduce_62(val, _values, result)
     return n :Modulo, val[0], val[2] 
    result
  end
.,.,

# reduce 63 omitted

# reduce 64 omitted

# reduce 65 omitted

# reduce 66 omitted

# reduce 67 omitted

# reduce 68 omitted

# reduce 69 omitted

module_eval(<<'.,.,', 'parser.racc', 93)
  def _reduce_70(val, _values, result)
     return n :Symbol,  val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 94)
  def _reduce_71(val, _values, result)
     return n :Float,   val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 95)
  def _reduce_72(val, _values, result)
     return n :Integer, val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 96)
  def _reduce_73(val, _values, result)
     return n :String,  val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 97)
  def _reduce_74(val, _values, result)
     return n :Nil 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 98)
  def _reduce_75(val, _values, result)
     return n :True 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 99)
  def _reduce_76(val, _values, result)
     return n :False 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module Huia

#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.11
# from Racc grammer file "".
#

require 'racc/parser.rb'
module Huia
  class Parser < Racc::Parser

module_eval(<<'...end parser.racc/module_eval...', 'parser.racc', 140)

attr_accessor :lexer, :scopes, :state

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

def on_error t, val, vstack
  line = lexer.line
  col  = lexer.column
  message = "Unexpected #{token_to_str t} at #{lexer.filename} line #{line}:#{col}:\n\n"

  start = line - 5 > 0 ? line - 5 : 0
  i_size = line.to_s.size
  (start..(start + 5)).each do |i|
    message << sprintf("\t%#{i_size}d: %s\n", i, lexer.get_line(i))
  end
  message << "\t#{' ' * i_size}  #{'-' * col}^\n"

  raise SyntaxError, message
end

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
  new_scope.file = lexer.filename
  new_scope.line = lexer.lineno
  scopes.push new_scope
  new_scope
end

def pop_scope
  scopes.pop
end

def scope
  scopes.last
end

def binary left, right, method
  node(:MethodCall, left, node(:CallSignature, method, [right]))
end

def node type, *args
  Huia::AST.const_get(type).new(*args).tap do |n|
    n.file   = lexer.filename
    n.line   = lexer.line
  end
end
alias n node

def allocate_local name
  node(:Variable, name).tap do |n|
    scope.allocate_local n
  end
end

def allocate_local_assignment name, value
  node(:Assignment, name, value).tap do |n|
    scope.allocate_local n
  end
end

def scope_instance
  node(:ScopeInstance, scope)
end

def constant name
  return scope_instance if name == 'self'
  node(:Constant, name)
end

def to_string expr
  node(:MethodCall, expr, node(:CallSignature, 'toString'))
end
...end parser.racc/module_eval...
##### State transition tables begin ###

racc_action_table = [
    53,    65,    28,    25,    58,    59,    60,    61,    82,    44,
    45,    50,    62,   119,   120,    27,   111,    57,    25,     5,
     6,    89,    56,    46,    47,    48,    64,    24,    49,    18,
    28,    52,    57,   109,   110,    16,    63,    44,    45,    50,
   116,    64,   121,    27,   123,    92,    25,     5,     6,   109,
   127,    46,    47,    48,   nil,    24,    49,    18,    28,    52,
   nil,    25,   nil,    16,   nil,    44,    45,    50,    62,    74,
    24,    27,    88,    57,    25,    84,   nil,    73,   nil,    46,
    47,    48,    64,    24,    49,    18,    28,    52,   nil,   nil,
   nil,    16,    62,    44,    45,    50,    62,    57,   nil,    27,
   nil,    57,    25,   nil,   nil,   nil,    64,    46,    47,    48,
    64,    24,    49,    18,    28,    52,   nil,   nil,   nil,    16,
   nil,    44,    45,    50,   nil,   nil,    88,    27,   113,    84,
    25,   nil,   nil,   nil,   nil,    46,    47,    48,   nil,    24,
    49,    18,    28,    52,   nil,   nil,   nil,    16,   nil,    44,
    45,    50,   nil,   nil,   nil,    27,   nil,   nil,    25,   nil,
   nil,   nil,   nil,    46,    47,    48,   nil,    24,    49,    18,
    28,    52,   nil,   nil,   nil,    16,   nil,    44,    45,    50,
   nil,   nil,   nil,    27,   nil,   nil,    25,   nil,   nil,   nil,
   nil,    46,    47,    48,   nil,    24,    49,    18,    28,    52,
   nil,   nil,   nil,    16,   nil,    44,    45,    50,   nil,   nil,
   nil,    27,   nil,   nil,    25,   nil,   nil,   nil,   nil,    46,
    47,    48,   nil,    24,    49,    18,    28,    52,   nil,   nil,
   nil,    16,   nil,    44,    45,    50,   nil,   nil,   nil,    27,
   nil,   nil,    25,   nil,   nil,   nil,   nil,    46,    47,    48,
   nil,    24,    49,    18,    28,    52,   nil,   nil,   nil,    16,
   nil,    44,    45,    50,   nil,   nil,   nil,    27,   nil,   nil,
    25,   nil,   nil,   nil,   nil,    46,    47,    48,   nil,    24,
    49,    18,    28,    52,   nil,   nil,   nil,    16,   nil,    44,
    45,    50,   nil,   nil,   nil,    27,   nil,   nil,    25,   nil,
   nil,   nil,   nil,    46,    47,    48,   nil,    24,    49,    18,
    28,    52,   nil,   nil,   nil,    16,   nil,    44,    45,    50,
   nil,   nil,   nil,    27,   nil,   nil,    25,   nil,   nil,   nil,
   nil,    46,    47,    48,   nil,    24,    49,    18,    28,    52,
   nil,   nil,   nil,    16,   nil,    44,    45,    50,   nil,   nil,
   nil,    27,   nil,   nil,    25,   nil,   nil,   nil,   nil,    46,
    47,    48,   nil,    24,    49,    18,    28,    52,   nil,   nil,
   nil,    16,   nil,    44,    45,    50,   nil,   nil,   105,    27,
   nil,   nil,    25,     5,     6,   nil,   nil,    46,    47,    48,
   nil,    24,    49,    18,    28,    52,   nil,   nil,   nil,    16,
   nil,    44,    45,    50,   nil,   nil,   nil,    27,   nil,   nil,
    25,   nil,   nil,   nil,   nil,    46,    47,    48,   nil,    24,
    49,    18,    28,    52,   nil,   nil,   nil,    16,   nil,    44,
    45,    50,   nil,   nil,   nil,    27,   nil,   nil,    25,   nil,
   nil,   nil,   nil,    46,    47,    48,   nil,    24,    49,    18,
    28,    52,   nil,   nil,   nil,    16,   nil,    44,    45,    50,
   nil,   nil,   105,    27,   nil,   nil,    25,     5,     6,   nil,
   nil,    46,    47,    48,   nil,    24,    49,    18,    28,    52,
   nil,   nil,   nil,    16,   nil,    44,    45,    50,   nil,   nil,
   nil,    27,   nil,   nil,    25,   nil,   nil,   nil,   nil,    46,
    47,    48,   nil,    24,    49,    18,   nil,    52,   nil,   nil,
   nil,    16,    58,    59,    60,    61,   nil,   nil,   nil,   nil,
    62,   nil,   nil,   nil,   nil,    57,   nil,     5,     6,   nil,
    56,   nil,   nil,   nil,    64,    58,    59,    60,    61,    58,
    59,    60,    61,    62,    63,   nil,   nil,    62,    57,   nil,
   101,   nil,    57,    56,   nil,   nil,   nil,    64,   nil,   nil,
   nil,    64,    58,    59,    60,    61,   nil,    63,   nil,   nil,
    62,    63,   nil,   nil,   nil,    57,   nil,   nil,   nil,   nil,
    56,   nil,   nil,   nil,    64,    58,    59,    60,    61,   nil,
   nil,   nil,   nil,    62,    63,   nil,   nil,   nil,    57,   nil,
    58,    59,    60,    61,   nil,   nil,   nil,    64,    62,   nil,
   105,   nil,   nil,    57,   nil,     5,     6,    63,    56,   nil,
   nil,   nil,    64,    58,    59,    60,    61,   nil,   nil,   nil,
   nil,    62,    63,    60,    61,   nil,    57,   nil,   nil,    62,
   nil,    56,   nil,   nil,    57,    64,    58,    59,    60,    61,
   nil,   nil,   nil,    64,    62,    63,   nil,   nil,   nil,    57,
   nil,   nil,   nil,    63,    56,   nil,   nil,   nil,    64,    58,
    59,    60,    61,    60,    61,   nil,   122,    62,    63,    62,
   nil,   nil,    57,   nil,    57,   nil,   nil,    56,   nil,   nil,
   nil,    64,   nil,    64,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    63,   nil,    63 ]

racc_action_check = [
     1,    17,     1,    22,    81,    81,    81,    81,    28,     1,
     1,     1,    81,   106,   106,     1,    81,    81,     1,     1,
     1,    53,    81,     1,     1,     1,    81,     1,     1,     1,
     0,     1,    97,    72,    80,     1,    81,     0,     0,     0,
    86,    97,   108,     0,   119,    57,     0,     0,     0,   120,
   124,     0,     0,     0,   nil,     0,     0,     0,    25,     0,
   nil,    57,   nil,     0,   nil,    25,    25,    25,    95,    25,
    57,    25,    52,    95,    25,    52,   nil,    25,   nil,    25,
    25,    25,    95,    25,    25,    25,    27,    25,   nil,   nil,
   nil,    25,    96,    27,    27,    27,    98,    96,   nil,    27,
   nil,    98,    27,   nil,   nil,   nil,    96,    27,    27,    27,
    98,    27,    27,    27,    56,    27,   nil,   nil,   nil,    27,
   nil,    56,    56,    56,   nil,   nil,    83,    56,    83,    83,
    56,   nil,   nil,   nil,   nil,    56,    56,    56,   nil,    56,
    56,    56,    58,    56,   nil,   nil,   nil,    56,   nil,    58,
    58,    58,   nil,   nil,   nil,    58,   nil,   nil,    58,   nil,
   nil,   nil,   nil,    58,    58,    58,   nil,    58,    58,    58,
    59,    58,   nil,   nil,   nil,    58,   nil,    59,    59,    59,
   nil,   nil,   nil,    59,   nil,   nil,    59,   nil,   nil,   nil,
   nil,    59,    59,    59,   nil,    59,    59,    59,    60,    59,
   nil,   nil,   nil,    59,   nil,    60,    60,    60,   nil,   nil,
   nil,    60,   nil,   nil,    60,   nil,   nil,   nil,   nil,    60,
    60,    60,   nil,    60,    60,    60,    61,    60,   nil,   nil,
   nil,    60,   nil,    61,    61,    61,   nil,   nil,   nil,    61,
   nil,   nil,    61,   nil,   nil,   nil,   nil,    61,    61,    61,
   nil,    61,    61,    61,    62,    61,   nil,   nil,   nil,    61,
   nil,    62,    62,    62,   nil,   nil,   nil,    62,   nil,   nil,
    62,   nil,   nil,   nil,   nil,    62,    62,    62,   nil,    62,
    62,    62,    63,    62,   nil,   nil,   nil,    62,   nil,    63,
    63,    63,   nil,   nil,   nil,    63,   nil,   nil,    63,   nil,
   nil,   nil,   nil,    63,    63,    63,   nil,    63,    63,    63,
    64,    63,   nil,   nil,   nil,    63,   nil,    64,    64,    64,
   nil,   nil,   nil,    64,   nil,   nil,    64,   nil,   nil,   nil,
   nil,    64,    64,    64,   nil,    64,    64,    64,    65,    64,
   nil,   nil,   nil,    64,   nil,    65,    65,    65,   nil,   nil,
   nil,    65,   nil,   nil,    65,   nil,   nil,   nil,   nil,    65,
    65,    65,   nil,    65,    65,    65,    71,    65,   nil,   nil,
   nil,    65,   nil,    71,    71,    71,   nil,   nil,    71,    71,
   nil,   nil,    71,    71,    71,   nil,   nil,    71,    71,    71,
   nil,    71,    71,    71,    82,    71,   nil,   nil,   nil,    71,
   nil,    82,    82,    82,   nil,   nil,   nil,    82,   nil,   nil,
    82,   nil,   nil,   nil,   nil,    82,    82,    82,   nil,    82,
    82,    82,    84,    82,   nil,   nil,   nil,    82,   nil,    84,
    84,    84,   nil,   nil,   nil,    84,   nil,   nil,    84,   nil,
   nil,   nil,   nil,    84,    84,    84,   nil,    84,    84,    84,
   102,    84,   nil,   nil,   nil,    84,   nil,   102,   102,   102,
   nil,   nil,   102,   102,   nil,   nil,   102,   102,   102,   nil,
   nil,   102,   102,   102,   nil,   102,   102,   102,   121,   102,
   nil,   nil,   nil,   102,   nil,   121,   121,   121,   nil,   nil,
   nil,   121,   nil,   nil,   121,   nil,   nil,   nil,   nil,   121,
   121,   121,   nil,   121,   121,   121,   nil,   121,   nil,   nil,
   nil,   121,     3,     3,     3,     3,   nil,   nil,   nil,   nil,
     3,   nil,   nil,   nil,   nil,     3,   nil,     3,     3,   nil,
     3,   nil,   nil,   nil,     3,    67,    67,    67,    67,    90,
    90,    90,    90,    67,     3,   nil,   nil,    90,    67,   nil,
    67,   nil,    90,    67,   nil,   nil,   nil,    67,   nil,   nil,
   nil,    90,    99,    99,    99,    99,   nil,    67,   nil,   nil,
    99,    90,   nil,   nil,   nil,    99,   nil,   nil,   nil,   nil,
    99,   nil,   nil,   nil,    99,   100,   100,   100,   100,   nil,
   nil,   nil,   nil,   100,    99,   nil,   nil,   nil,   100,   nil,
   103,   103,   103,   103,   nil,   nil,   nil,   100,   103,   nil,
   103,   nil,   nil,   103,   nil,   103,   103,   100,   103,   nil,
   nil,   nil,   103,   112,   112,   112,   112,   nil,   nil,   nil,
   nil,   112,   103,    93,    93,   nil,   112,   nil,   nil,    93,
   nil,   112,   nil,   nil,    93,   112,   115,   115,   115,   115,
   nil,   nil,   nil,    93,   115,   112,   nil,   nil,   nil,   115,
   nil,   nil,   nil,    93,   115,   nil,   nil,   nil,   115,   126,
   126,   126,   126,    94,    94,   nil,   115,   126,   115,    94,
   nil,   nil,   126,   nil,    94,   nil,   nil,   126,   nil,   nil,
   nil,   126,   nil,    94,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   126,   nil,    94 ]

racc_action_pointer = [
    28,     0,   nil,   508,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   -21,   nil,   nil,
   nil,   nil,   -15,   nil,   nil,    56,   nil,    84,     5,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    42,    21,   nil,   nil,   112,    43,   140,   168,
   196,   224,   252,   280,   308,   336,   nil,   531,   nil,   nil,
   nil,   364,    31,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    15,     0,   392,    96,   420,   nil,    10,   nil,   nil,   nil,
   535,   nil,   nil,   627,   667,    56,    80,    15,    84,   558,
   581,   nil,   448,   596,   nil,   nil,    -8,   nil,    39,   nil,
   nil,   nil,   619,   nil,   nil,   642,   nil,   nil,   nil,    25,
    47,   476,   nil,   nil,    37,   nil,   665,   nil ]

racc_action_default = [
   -99,   -99,    -1,    -4,    -5,    -6,    -7,   -10,   -11,   -12,
   -13,   -14,   -15,   -16,   -17,   -18,   -19,   -20,   -23,   -41,
   -42,   -45,   -46,   -47,   -48,   -99,   -56,   -99,   -59,   -60,
   -61,   -62,   -63,   -64,   -65,   -66,   -67,   -76,   -77,   -78,
   -79,   -80,   -81,   -82,   -83,   -84,   -85,   -86,   -87,   -88,
   -89,   -90,   -99,   -99,    -2,    -3,   -99,   -99,   -99,   -99,
   -99,   -99,   -99,   -99,   -99,   -99,   -57,   -52,   -24,   -25,
   -26,   -99,   -99,   -32,   -33,   -34,   -35,   -49,   -50,   -51,
   -54,   -99,   -99,   -99,   -99,   -93,   -95,   -96,   -97,   128,
   -22,   -43,   -44,   -69,   -70,   -71,   -72,   -73,   -74,   -75,
   -21,   -53,   -99,    -4,   -29,   -30,   -99,   -36,   -38,   -40,
   -55,   -58,   -68,   -91,   -94,   -99,   -98,   -27,   -28,    -9,
   -99,   -99,   -92,    -8,   -99,   -37,   -39,   -31 ]

racc_goto_table = [
    54,    67,    55,    81,     1,   107,   124,    80,    68,    69,
    70,   104,    71,    85,    75,    72,   106,    76,    91,    66,
    77,    78,    79,    83,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    90,   nil,    93,    94,    95,    96,    97,    98,
    99,   100,   117,   118,   114,   nil,   nil,   103,   nil,   nil,
   nil,   nil,   nil,   125,   nil,   nil,   nil,   nil,   112,   nil,
   115,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   102,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   126,   nil,   nil,
   nil,    54,    55 ]

racc_goto_check = [
     2,     3,     4,     3,     1,    26,     5,    16,    17,    18,
    19,    21,    20,    55,    22,    23,    24,    25,    30,    33,
    34,    35,    36,    53,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,     3,   nil,     3,     3,     3,     3,     3,     3,
     3,     3,    21,    21,    55,   nil,   nil,     3,   nil,   nil,
   nil,   nil,   nil,    26,   nil,   nil,   nil,   nil,     3,   nil,
     3,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,     1,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,     3,   nil,   nil,
   nil,     2,     4 ]

racc_goto_pointer = [
   nil,     4,    -1,   -24,    -1,  -113,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   -18,   -17,   -16,   -15,
   -13,   -60,   -11,   -10,   -56,    -8,   -67,   nil,   nil,   nil,
   -39,   nil,   nil,    -3,    -5,    -4,    -3,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   -29,   nil,   -39,   nil ]

racc_goto_default = [
   nil,   nil,     2,     3,     4,   nil,     7,     8,     9,    10,
    11,    12,    13,    14,    15,    17,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   108,    19,    20,
    21,    22,    23,    26,   nil,   nil,   nil,    29,    30,    31,
    32,    33,    34,    35,    36,    37,    38,    39,    40,    41,
    42,    43,    51,   nil,    87,   nil,    86 ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 38, :_reduce_none,
  2, 38, :_reduce_2,
  2, 39, :_reduce_3,
  1, 39, :_reduce_4,
  1, 39, :_reduce_5,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 42, :_reduce_none,
  0, 42, :_reduce_none,
  1, 40, :_reduce_none,
  1, 40, :_reduce_none,
  1, 40, :_reduce_none,
  1, 40, :_reduce_none,
  1, 40, :_reduce_none,
  1, 40, :_reduce_none,
  1, 40, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 50, :_reduce_19,
  1, 51, :_reduce_none,
  3, 51, :_reduce_21,
  3, 52, :_reduce_22,
  1, 47, :_reduce_23,
  1, 53, :_reduce_none,
  1, 53, :_reduce_none,
  1, 53, :_reduce_none,
  3, 54, :_reduce_27,
  3, 55, :_reduce_28,
  2, 56, :_reduce_29,
  1, 58, :_reduce_30,
  5, 59, :_reduce_31,
  1, 60, :_reduce_32,
  1, 62, :_reduce_33,
  1, 57, :_reduce_none,
  1, 57, :_reduce_none,
  1, 61, :_reduce_none,
  3, 61, :_reduce_none,
  1, 63, :_reduce_38,
  3, 63, :_reduce_39,
  1, 64, :_reduce_40,
  1, 46, :_reduce_none,
  1, 46, :_reduce_none,
  3, 65, :_reduce_43,
  3, 65, :_reduce_44,
  1, 66, :_reduce_45,
  1, 67, :_reduce_none,
  1, 67, :_reduce_none,
  1, 69, :_reduce_48,
  2, 70, :_reduce_49,
  1, 71, :_reduce_none,
  1, 71, :_reduce_none,
  1, 72, :_reduce_none,
  2, 72, :_reduce_none,
  1, 73, :_reduce_none,
  2, 73, :_reduce_none,
  1, 68, :_reduce_56,
  2, 68, :_reduce_57,
  3, 44, :_reduce_58,
  1, 48, :_reduce_59,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  1, 45, :_reduce_none,
  3, 74, :_reduce_68,
  3, 75, :_reduce_69,
  3, 76, :_reduce_70,
  3, 77, :_reduce_71,
  3, 78, :_reduce_72,
  3, 79, :_reduce_73,
  3, 80, :_reduce_74,
  3, 81, :_reduce_75,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 43, :_reduce_none,
  1, 83, :_reduce_83,
  1, 82, :_reduce_84,
  1, 85, :_reduce_85,
  1, 86, :_reduce_86,
  1, 87, :_reduce_87,
  1, 88, :_reduce_88,
  1, 84, :_reduce_89,
  1, 84, :_reduce_none,
  3, 89, :_reduce_91,
  3, 91, :_reduce_92,
  1, 90, :_reduce_93,
  2, 90, :_reduce_94,
  1, 92, :_reduce_95,
  1, 92, :_reduce_96,
  1, 93, :_reduce_97,
  2, 93, :_reduce_98 ]

racc_reduce_n = 99

racc_shift_n = 128

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
  :NL => 19,
  :EOF => 20,
  :PIPE => 21,
  :COMMA => 22,
  :NIL => 23,
  :TRUE => 24,
  :FALSE => 25,
  :EQUALITY => 26,
  :CALL => 27,
  :SELF => 28,
  :CONSTANT => 29,
  :CHAR => 30,
  :DOUBLE_TICK_STRING => 31,
  :DOUBLE_TICK_STRING_END => 32,
  :INTERPOLATE_START => 33,
  :INTERPOLATE_END => 34,
  :BOX => 35,
  :PERCENT => 36 }

racc_nt_base = 37

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
  "NL",
  "EOF",
  "PIPE",
  "COMMA",
  "NIL",
  "TRUE",
  "FALSE",
  "EQUALITY",
  "CALL",
  "SELF",
  "CONSTANT",
  "CHAR",
  "DOUBLE_TICK_STRING",
  "DOUBLE_TICK_STRING_END",
  "INTERPOLATE_START",
  "INTERPOLATE_END",
  "BOX",
  "PERCENT",
  "$start",
  "statements",
  "statement",
  "expr",
  "eol",
  "nlq",
  "literal",
  "grouped_expr",
  "binary_op",
  "method_call",
  "constant",
  "variable",
  "array",
  "empty_array",
  "array_list",
  "array_tuple",
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
  "call_passed_simple",
  "call_passed_indented",
  "assignment",
  "addition",
  "subtraction",
  "multiplication",
  "division",
  "exponentiation",
  "modulo",
  "equality",
  "integer",
  "float",
  "string",
  "nil",
  "true",
  "false",
  "self",
  "interpolated_string",
  "interpolated_string_contents",
  "interpolation",
  "interpolated_string_chunk",
  "chars" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

module_eval(<<'.,.,', 'parser.racc', 19)
  def _reduce_2(val, _values, result)
     return scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 21)
  def _reduce_3(val, _values, result)
     return scope.append val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 22)
  def _reduce_4(val, _values, result)
     return scope.append val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 23)
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

module_eval(<<'.,.,', 'parser.racc', 39)
  def _reduce_19(val, _values, result)
     return n :Array 
    result
  end
.,.,

# reduce 20 omitted

module_eval(<<'.,.,', 'parser.racc', 42)
  def _reduce_21(val, _values, result)
     val[0].append(val[2]); return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 43)
  def _reduce_22(val, _values, result)
     return n :Array, [val[0], val[2]]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 45)
  def _reduce_23(val, _values, result)
     return constant val[0] 
    result
  end
.,.,

# reduce 24 omitted

# reduce 25 omitted

# reduce 26 omitted

module_eval(<<'.,.,', 'parser.racc', 50)
  def _reduce_27(val, _values, result)
     return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 51)
  def _reduce_28(val, _values, result)
     return val[0].append(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 52)
  def _reduce_29(val, _values, result)
     return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 53)
  def _reduce_30(val, _values, result)
     return pop_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 56)
  def _reduce_31(val, _values, result)
     return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 57)
  def _reduce_32(val, _values, result)
     return push_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 58)
  def _reduce_33(val, _values, result)
     return push_scope 
    result
  end
.,.,

# reduce 34 omitted

# reduce 35 omitted

# reduce 36 omitted

# reduce 37 omitted

module_eval(<<'.,.,', 'parser.racc', 64)
  def _reduce_38(val, _values, result)
     return scope.add_argument val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 65)
  def _reduce_39(val, _values, result)
     return n :Assignment, val[0], val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 66)
  def _reduce_40(val, _values, result)
     return n :Variable, val[0] 
    result
  end
.,.,

# reduce 41 omitted

# reduce 42 omitted

module_eval(<<'.,.,', 'parser.racc', 70)
  def _reduce_43(val, _values, result)
     return n :MethodCall, val[0], val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 71)
  def _reduce_44(val, _values, result)
     return n :MethodCall, val[0], n(:CallSignature, val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 72)
  def _reduce_45(val, _values, result)
     return n :MethodCall, scope_instance, val[0] 
    result
  end
.,.,

# reduce 46 omitted

# reduce 47 omitted

module_eval(<<'.,.,', 'parser.racc', 76)
  def _reduce_48(val, _values, result)
     return n :CallSignature, val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 77)
  def _reduce_49(val, _values, result)
     return n :CallSignature, val[0], [val[1]] 
    result
  end
.,.,

# reduce 50 omitted

# reduce 51 omitted

# reduce 52 omitted

# reduce 53 omitted

# reduce 54 omitted

# reduce 55 omitted

module_eval(<<'.,.,', 'parser.racc', 84)
  def _reduce_56(val, _values, result)
     return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 85)
  def _reduce_57(val, _values, result)
     return val[0].concat_signature val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 87)
  def _reduce_58(val, _values, result)
     return n :Expression, val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 89)
  def _reduce_59(val, _values, result)
     return allocate_local val[0] 
    result
  end
.,.,

# reduce 60 omitted

# reduce 61 omitted

# reduce 62 omitted

# reduce 63 omitted

# reduce 64 omitted

# reduce 65 omitted

# reduce 66 omitted

# reduce 67 omitted

module_eval(<<'.,.,', 'parser.racc', 100)
  def _reduce_68(val, _values, result)
     return allocate_local_assignment val[0], val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 101)
  def _reduce_69(val, _values, result)
     return binary val[0], val[2], 'plus:' 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 102)
  def _reduce_70(val, _values, result)
     return binary val[0], val[2], 'minus:' 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 103)
  def _reduce_71(val, _values, result)
     return binary val[0], val[2], 'multiplyBy:' 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 104)
  def _reduce_72(val, _values, result)
     return binary val[0], val[2], 'divideBy:' 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 105)
  def _reduce_73(val, _values, result)
     return binary val[0], val[2], 'toThePowerOf:' 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 106)
  def _reduce_74(val, _values, result)
     return binary val[0], val[2], 'moduloOf:' 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 107)
  def _reduce_75(val, _values, result)
     return binary val[0], val[2], 'isEqualTo:' 
    result
  end
.,.,

# reduce 76 omitted

# reduce 77 omitted

# reduce 78 omitted

# reduce 79 omitted

# reduce 80 omitted

# reduce 81 omitted

# reduce 82 omitted

module_eval(<<'.,.,', 'parser.racc', 117)
  def _reduce_83(val, _values, result)
     return n :Float,   val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 118)
  def _reduce_84(val, _values, result)
     return n :Integer, val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 119)
  def _reduce_85(val, _values, result)
     return n :Nil 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 120)
  def _reduce_86(val, _values, result)
     return n :True 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 121)
  def _reduce_87(val, _values, result)
     return n :False 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 122)
  def _reduce_88(val, _values, result)
     return n :Self 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 124)
  def _reduce_89(val, _values, result)
     return n :String,  val[0] 
    result
  end
.,.,

# reduce 90 omitted

module_eval(<<'.,.,', 'parser.racc', 127)
  def _reduce_91(val, _values, result)
     return val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 128)
  def _reduce_92(val, _values, result)
     return val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 129)
  def _reduce_93(val, _values, result)
     return n :InterpolatedString, val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 130)
  def _reduce_94(val, _values, result)
     val[0].append(val[1]); return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 131)
  def _reduce_95(val, _values, result)
     return val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 132)
  def _reduce_96(val, _values, result)
     return to_string(val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 134)
  def _reduce_97(val, _values, result)
     return n :String, val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 135)
  def _reduce_98(val, _values, result)
     val[0].append(val[1]); return val[0] 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module Huia

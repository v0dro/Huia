module Huia
  module AST
    # Abstract nodes
    autoload :Node,           'huia/ast/node'
    autoload :Reducible,      'huia/ast/reducible'
    autoload :Literal,        'huia/ast/literal'
    autoload :Numeric,        'huia/ast/numeric'
    autoload :BinaryOp,       'huia/ast/binary_op'

    autoload :Expression,     'huia/ast/expression'
    autoload :CallSignature,  'huia/ast/call_signature'
    autoload :MethodCall,     'huia/ast/method_call'
    autoload :Scope,          'huia/ast/scope'
    autoload :DefSignature,   'huia/ast/def_signature'
    autoload :Lambda,         'huia/ast/lambda'

    # Literals
    autoload :Integer,        'huia/ast/integer'
    autoload :Float,          'huia/ast/float'
    autoload :String,         'huia/ast/string'
    autoload :Symbol,         'huia/ast/symbol'
    autoload :Variable,       'huia/ast/variable'
    autoload :Nil,            'huia/ast/nil'
    autoload :True,           'huia/ast/true'
    autoload :False,          'huia/ast/false'

    # Binary operations
    autoload :VarAssign,      'huia/ast/var_assign'
    autoload :Addition,       'huia/ast/addition'
    autoload :Subtraction,    'huia/ast/subtraction'
    autoload :Multiplication, 'huia/ast/multiplication'
    autoload :Division,       'huia/ast/division'
    autoload :Exponentiation, 'huia/ast/exponentiation'
    autoload :Modulo,         'huia/ast/modulo'
    autoload :Equality,       'huia/ast/equality'
  end
end

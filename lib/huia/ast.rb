module Huia
  module AST
    # Abstract nodes
    autoload :Node,           'huia/ast/node'
    autoload :Literal,        'huia/ast/literal'
    autoload :Numeric,        'huia/ast/numeric'

    autoload :Expression,     'huia/ast/expression'
    autoload :CallSignature,  'huia/ast/call_signature'
    autoload :MethodCall,     'huia/ast/method_call'
    autoload :Scope,          'huia/ast/scope'
    autoload :ScopeInstance,  'huia/ast/scope_instance'

    autoload :Assignment,     'huia/ast/assignment'
    autoload :InterpolatedString, 'huia/ast/interpolated_string'
    autoload :Return,         'huia/ast/return'

    # Literals
    autoload :Integer,        'huia/ast/integer'
    autoload :Float,          'huia/ast/float'
    autoload :String,         'huia/ast/string'
    autoload :Variable,       'huia/ast/variable'
    autoload :Nil,            'huia/ast/nil'
    autoload :True,           'huia/ast/true'
    autoload :False,          'huia/ast/false'
    autoload :Self,           'huia/ast/self'
    autoload :Constant,       'huia/ast/constant'
    autoload :Array,          'huia/ast/array'
    autoload :Hash,           'huia/ast/hash'
    autoload :HashItem,       'huia/ast/hash_item'
  end
end

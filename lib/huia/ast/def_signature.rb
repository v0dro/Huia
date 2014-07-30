module Huia
  module AST
    class DefSignature < CallSignature

      def initialize signature, arguments=[]
        super
        raise RuntimeError, "Argument must be a VarAssign" unless arguments.all? { |a| a.is_a? Huia::AST::VarAssign }
      end

    end
  end
end

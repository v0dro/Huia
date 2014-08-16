module Huia
  module AST
    class Constant < Literal

      def bytecode g
        pos g

        g.push_cpath_top
        g.push_const :Huia
        g.push_const :Core
        g.push_const value.to_sym
      end

    end
  end
end

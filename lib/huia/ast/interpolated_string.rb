module Huia
  module AST
    class InterpolatedString < Expression

      def bytecode g
        pos g

        push_huia_const g, :String
        g.push_literal 'createFromValue:'
        g.string_dup
        g.push_literal ''
        g.string_dup
        g.send :__huia__send, 2

        @children.each do |child|
          g.push_literal 'concat:'
          g.string_dup
          child.bytecode g
          g.send :__huia__send, 2
        end
      end

    end
  end
end

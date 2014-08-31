module Huia
  module AST
    class InterpolatedString < Expression

      def bytecode g
        pos g

        g.push_huia_string ''

        @children.each do |child|
          g.huia_send 'concat:', 1 do |g|
            child.bytecode g
          end
        end
      end

    end
  end
end

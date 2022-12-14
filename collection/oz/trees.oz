functor
import
    Application(exit:Exit)
    System
define
    % Count leaf nodes
    fun {CountLeaves Tree}
        case Tree
        of leaf then 1
        [] tree(left:Left right:Right) then % using tree record
           {CountLeaves Left} + {CountLeaves Right}
        end
    end

    % Computing the height of a tree
    fun {Height Tree}
        case Tree
        of leaf then 1
        [] tree(left:Left right:Right) then
           {Max {Height Left} {Height Right}} + 1
        end
    end
end
functor
import
    Application(exit:Exit)
    System
define
    % Count leaf nodes
    fun {CountLeaves Tree}
        case Tree
        of leaf then 1
        [] tree(left:Left right:Right) then
           {CountLeaves Left} + {CountLeaves Right}
        end
    end
end
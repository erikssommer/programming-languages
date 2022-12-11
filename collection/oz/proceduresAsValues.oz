functor
import
    Application(exit:Exit)
    System
define

    % Testing if binary tree:
    local 
        proc {And B1 B2 ?B}
            if B1 then B = B2 else B = false end
        end
    in 
        proc {BinaryTree T ?B}
            case T of nil then
                B = true
            [] tree(K V T1 T2) then
                {And (BinaryTree T1) (BinaryTree T2) B}
            else 
                B = false
            end
        end
    end

end
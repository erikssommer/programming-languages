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

    % Checking a binary tree lazily:
    local 
        proc {AndThen BP1 BP2 ?B}
           if {BP1} then B = {BP2} else B = false end 
        end 
     in 
        proc {BinaryTree T ?B}
           case T
           of nil then B = true 
           [] tree(K V T1 T2) then 
              {AndThen
               proc {$ B1} {BinaryTree T1 B1} end 
               proc {$ B2} {BinaryTree T2 B2} end 
               B}
           else B = false end 
        end 
     end

     {Exit 0}
end
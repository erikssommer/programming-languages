functor
import
    Application(exit:Exit)
    System
define
    % Bottom-up accumulator of node val- ues {FoldTree NodeAcc BranchAcc Tree StartVal} 
    % where BranchAcc accu- mulates a list of branches, while NodeAcc accumulates a node value and the
    % result of accumulating branches. StartVal is the value for an empty list of branches.

    local 
        fun {FoldTreeR NodeAcc BranchAcc ListofTrees U}
            case ListofTrees of nil then
                U
            [] S|ListofTrees2 then
                {FoldTree NodeAcc BranchAcc S U}
                {FoldTreeR ListofTrees2 NodeAcc BranchAcc U}
            end
        end
    in
        fun {FoldTree NodeAcc BranchAcc Tree U}
            case Tree of tree(node:N branches:ListofTrees U) then
                {NodeAcc N {FoldTreeR NodeAcc BranchAcc ListofTrees U}}
            end 
        end
    end
end
% Task 4: Lazy Evaluation
functor
import
    Application(exit:Exit)
    System
define
    % The program shown employs pattern matching on records.
    proc {Insert Key Value TreeIn ?TreeOut}
        if TreeIn == nil then TreeOut = tree(Key Value nil nil)
        else
            local tree(K1 V1 T1 T2) = TreeIn in
                if Key == K1 then TreeOut = tree(Key Value T1 T2)
                local T in
                    TreeOut = tree(K1 V1 T1 T2)
                    {Insert Key Value T2 T}
                end
            else
                local T in
                    TreeOut = tree(K1 V1 T1 T)
                    {Insert Key Value T1 T}
                end
            end
        end 
    end

    % Simplify by using pattern-matching in case-constructs.
    proc {Insert Key Value TreeIn ?TreeOut}
        case TreeIn of nil then TreeOut = tree(Key Value nil nil)
        [] tree(K1 V1 T1 T2) then
            if Key == K1 then TreeOut = tree(Key Value, T1 T2)
            elseif Key < K1 then T in
                TreeOut = tree(K1 V1 T T2)
                {Insert Key Value T1 T}
            else T in
                TreeOut = tree(K1 V1 T1 T)
                {Insert Key Value T2 T}
            end
        end 
    end

end
% Task 7
% a) return the element count of List
fun {Length List}
    case List of Head|Rest then
        1 + {Length Rest}
    else
        0
    end
end

% b) return a list of the first Count elements
fun {Take List Count}
    if Count == 0 then
        nil
    else
        if Count >= {Length List} then
            List
        else
            case List of Head|Rest then
                Head|{Take Rest Count-1}
            end
        end
    end
end

% c) return a list without the first Count values
fun {Drop List Count}
    if Count >= {Length List} then
        nil
    else
        if Count == 0 then
            List
        else
            case List of Head|Rest then
                {Drop Rest Count-1}
            end
        end
    end
end

% d) return a list of all the elements in List1 followed by all the elements in List2
fun {Append List1 List2}
    if {Length List1} == 0 then
        List2
    else
        case List1 of Head|Rest then
            Head|{Append Rest List2}
        end
    end
end

% e) return true if Element is present in List, false otherwise
fun {Member List Element}
    if {Length List} == 0 then
        false
    else
        case List of Head|Rest then
            if Head == Element then
                true
            else
                {Member Rest Element}
            end
        end
    end    
end

% f) return the position of Element in List
fun {Position List Element}
    if {Length List} == 0 then
        0
    else
        case List of Head|Rest then
            if Head == Element then
                0
            else
                1 + {Position Rest Element}
            end
        end
    end
end

% Task 8
% a) return an updated version of List, in which Element has been added in the first position
fun {Push List Element}
    if {Length List} == 0 then
        [Element]
    else
        Element|List
    end
end

% b) return the element in the first position of List, or nil if the stack (list) is empty
fun {Peek List}
    if {Length List} == 0 then
        nil
    else
        case List of Head|Rest then
            Head
        end
    end
end

% c) return an updated version of List, in which the first element has been removed
fun {Pop List}
    case List of Head|Rest then
        Rest
    end
 end
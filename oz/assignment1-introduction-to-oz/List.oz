% a)
fun {Length List}
    case List of Head|Rest then
        1 + {Length Rest}
    else
        0
    end
end

% b)
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

% c)
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

% d)
fun {Append List1 List2}
    
end

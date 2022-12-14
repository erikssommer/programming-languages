functor
import
    Application(exit:Exit)
    System
define
    X = person(name:"George" age:25)
    
    {System.show X.age} % returns 25

    {Exit 0}
end
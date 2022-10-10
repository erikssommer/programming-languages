functor
import
    Application(exit:Exit)
    System
define
    proc {Circle R}
            Pi = 355.0/113.0
            Area = Pi * R * R
            Diameter = 2.0 * R
            Circumference = Pi * Diameter
        in
            {System.showInfo "Area: " #Area}
            {System.showInfo "Diameter: " #Diameter}
            {System.showInfo "Circumference: " #Circumference}
    end
    {Circle 14.0}
    {Exit 0}
end
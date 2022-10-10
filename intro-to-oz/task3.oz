functor
import
    Application(exit:Exit)
    System
define
    % a)
   local X Y Z in
      Y = 300
      Z = 30
      X = Y * Z
      {System.showInfo X}
   end

   % b)
   % Y can be used before assignment because all code is first compiled, which assigns variables, and the thread can then use Y.
   % The execution of the thread is halted until Y is assigned a value.
   % This behaviour is useful because it makes programming concurrency easier.
   % The statement Y = X assigns Y with the value of X  
   local X Y in
      X = "This is a string"
      thread {System.showInfo Y} end
      Y=X
   end
   {Exit 0}
end
package body Mandelbrot is

   function Mandelbrot_Function (Z, C : Complex) return Complex is
   begin
      return Z ** 2 + C;
   end Mandelbrot_Function;

   function Mandelbrot_Generate (
      Corner1, Corner2 : Complex;
      X_Max, Y_Max, Max_Iterations : Positive)
   return Image_Ptr
   is
      I : constant Image_Ptr := new Image (1 .. X_Max, 1 .. Y_Max);

      X_Step : constant Long_Float := (Corner2.Re - Corner1.Re) / Long_Float (X_Max);
      Y_Step : constant Long_Float := (Corner2.Im - Corner1.Im) / Long_Float (Y_Max);

      Xf, Yf : Long_Float;
   begin
      Yf := Corner1.Im;

      for Y in Positive range 1 .. Y_Max loop
         Xf := Corner1.Re;

         for X in Positive range 1 .. X_Max loop
            I (X, Y) := Mandelbrot_Iteration (Compose_From_Cartesian (Xf, Yf), Max_Iterations);
            Xf := Xf + X_Step;
         end loop;

         Yf := Yf + Y_Step;
      end loop;

      return I;
   end Mandelbrot_Generate;

   function Mandelbrot_Iteration (C : Complex; N : Positive) return Natural
   is
      Z : Complex := Compose_From_Cartesian (Re => 0.0, Im => 0.0);
   begin
      for I in 1 .. N loop
         Z := Mandelbrot_Function (Z, C);
         if abs Z > 2.0 then
            return I;
         end if;
      end loop;
      return 0;
   end Mandelbrot_Iteration;

end Mandelbrot;

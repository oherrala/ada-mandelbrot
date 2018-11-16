pragma Assertion_Policy (Check);

with Ada.Numerics.Long_Complex_Types; use Ada.Numerics.Long_Complex_Types;

package Mandelbrot is
   type Image;
   type Image_Ptr is access all Image;
   type Image is array (Positive range <>, Positive range <>) of Natural;

   function Mandelbrot_Function (Z, C : Complex) return Complex;
   --  Mandelbrot's Complex Function: Z_n+1 = Z_n^2 + C

   function Mandelbrot_Generate (
      Corner1, Corner2 : Complex;
      X_Max, Y_Max, Max_Iterations : Positive)
    return Image_Ptr
    with
       Pre => Corner1.Re <= Corner2.Re and Corner1.Im <= Corner2.Im,
       Post => Mandelbrot_Generate'Result'Length (1) = X_Max and
          Mandelbrot_Generate'Result'Length (2) = Y_Max;
   --  Generate Mandelbrot series for Image consisting of bounding box from
   --  Corner1 to Corner2 using pixel resolution of (X_Max, Y_Max).

   function Mandelbrot_Iteration (C : Complex; N : Positive) return Natural;
   --  Iterate Mandelbrot until iteration limit N is reached or function
   --  diverges.

end Mandelbrot;

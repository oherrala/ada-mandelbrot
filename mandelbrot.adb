with Ada.Text_IO;
with Ada.Numerics.Generic_Complex_Types;

use Ada.Text_IO;

procedure Mandelbrot is
   package Complex_Types is new
      Ada.Numerics.Generic_Complex_Types (Long_Float);
   use Complex_Types;

   --  Mandelbrot's Complex Function: Z_n+1 = Z_n^2 + C
   function Mandelbrot_Function (Z, C : Complex) return Complex;

   --  Iterate Mandelbrot until iteration limit N is reached or function
   --  diverges
   function Mandelbrot_Iteration (C : Complex; N : Positive) return Natural;

   function Mandelbrot_Function (Z, C : Complex) return Complex is
   begin
      return Z ** 2 + C;
   end Mandelbrot_Function;

   function Mandelbrot_Iteration (C : Complex; N : Positive) return Natural is
      Z : Complex := Compose_From_Cartesian (Re => 0.0, Im => 0.0);
   begin
      for I in Integer range 1 .. N loop
         Z := Mandelbrot_Function (Z, C);
         if abs Z > 2.0 then
            return I;
         end if;
      end loop;
      return 0;
   end Mandelbrot_Iteration;

   --  Image coordinates
   X_Min : Integer := 0;
   X_Max : Integer := 2560;
   Y_Min : Integer := 0;
   Y_Max : Integer := 1440;

   --  Mandelbrot range: X := -2.5 .. 1.0, Y := -1.0 .. 1.0
   X : Long_Float;
   Y : Long_Float;
   X_Step : Long_Float := (2.5 + 1.0) / Long_Float (X_Max);
   Y_Step : Long_Float := 2.0 / Long_Float (Y_Max);

   --  Value of one coordinate pair
   M : Natural;

   --  Shades of grey
   I : Positive := 50;
begin
   Put_Line ("P2");
   Put_Line (X_Max'Image & " " & Y_Max'Image);
   Put_Line (I'Image);

   Y := -1.0;
   while Y < 1.0 loop
      X := -2.5;
      while X < 1.0 loop
         M := Mandelbrot_Iteration (
            Compose_From_Cartesian (Re => X, Im => Y),
            I
         );
         Put (M'Image & " ");
         X := X + X_Step;
      end loop;
      Y := Y + Y_Step;
      New_Line;
   end loop;
end Mandelbrot;

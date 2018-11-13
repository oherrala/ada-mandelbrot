with Ada.Text_IO;
with Ada.Numerics.Generic_Complex_Types;

use Ada.Text_IO;

procedure Mandelbrot is
   package Complex_Types is new
      Ada.Numerics.Generic_Complex_Types (Long_Float);
   use Complex_Types;

   type Mandelbrot_Result is record
       I : Natural;
       Z : Complex;
   end record;

   --  Mandelbrot's Complex Function: Z_n+1 = Z_n^2 + C
   function Mandelbrot_Function (Z, C : Complex) return Complex is
   begin
      return Z ** 2 + C;
   end Mandelbrot_Function;

   --  Iterate Mandelbrot until iteration limit N is reached or function
   --  diverges.
   function Mandelbrot_Iteration (C : Complex; N : Positive) return Mandelbrot_Result is
      Z : Complex := Compose_From_Cartesian (Re => 0.0, Im => 0.0);
      Result : Mandelbrot_Result;
   begin
      for I in Natural range 1 .. N loop
         Z := Mandelbrot_Function (Z, C);
         if abs Z > 2.0 then
            Result := (I => I, Z => Z);
            return Result;
         end if;
      end loop;
      Result := (I => 0, Z => Z);
      return Result;
   end Mandelbrot_Iteration;

   --  Image resolution (in pixels)
   X_Max : constant Integer := 2560;
   Y_Max : constant Integer := 1440;

   --  Mandelbrot range: X := -2.5 .. 1.0, Y := -1.0 .. 1.0
   X : Long_Float;
   Y : Long_Float;

   --  Step size for Mandelbrot range using image resolution
   X_Step : constant Long_Float := (2.5 + 1.0) / Long_Float (X_Max);
   Y_Step : constant Long_Float := 2.0 / Long_Float (Y_Max);

   --  Value of one coordinate pair
   M : Mandelbrot_Result;

   --  Shades of grey
   I : constant Positive := 1024;

begin
   --  NetPBM image header
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
         Put (M.I'Image & " ");
         X := X + X_Step;
      end loop;

      Y := Y + Y_Step;
      New_Line;
   end loop;
end Mandelbrot;

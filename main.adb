with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Long_Complex_Types; use Ada.Numerics.Long_Complex_Types;

with Mandelbrot; use Mandelbrot;

procedure Main is
   --  Image resolution (in pixels)
   X_Max : constant Positive := 3000;
   Y_Max : constant Positive := 2000;

   Max_Iterations : constant Positive := 40;

   --  Mandelbrot bounding box
   Corner1 : constant Complex := Compose_From_Cartesian (Re => -2.0, Im => -1.0);
   Corner2 : constant Complex := Compose_From_Cartesian (Re => 1.0, Im => 1.0);

   I : constant Image_Ptr := Mandelbrot_Generate (Corner1, Corner2, X_Max, Y_Max, Max_Iterations);
   P : Natural;
   Line_Length : Natural := 0;
begin
   --  PGM file format output: http://netpbm.sourceforge.net/doc/pgm.html
   Put_Line ("P2");
   Put_Line (X_Max'Image & " " & Y_Max'Image);
   Put_Line (Max_Iterations'Image);

   for Y in 1 .. Y_Max loop
      for X in 1 .. X_Max loop
         P := I (X, Y);
         Put (P'Image);
         Line_Length := Line_Length + P'Image'Length;
         if Line_Length >= 70 - 3 then
            New_Line;
            Line_Length := 0;
         end if;
      end loop;
   end loop;
end Main;

{Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.
}
program Ejer2PracticaUno;
type
  fileInt = file of integer;
var
  arch_enteros:fileInt;
  total,totalMenor,listar,num:integer;
  nombre:String[12];
begin
  Writeln('Ingresar nombre de archivo');
  readln(nombre);
  assign(arch_enteros,'C:\Users\Usuario\Desktop\seba\Fundamentos de Organizacion de Datos\' + nombre );
  reset(arch_enteros);
  totalMenor:= 0;
  total:= 0;
  listar:= 0;
  while( not eof(arch_enteros)) do begin
         read(arch_enteros,num);
         write(num,' , ');
         listar:= listar + 1;
         total:= total + num;
         if(num < 1500)then
                totalMenor := totalMenor + 1;
  end;
  writeln();
  writeln('el total menores  1500 es: ', totalMenor);
  writeln('el promedio es es: ', total div listar);
  readln;
end.


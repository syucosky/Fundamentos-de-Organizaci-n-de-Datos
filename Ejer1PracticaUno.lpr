{Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.}
program Ejer1PracticaUno;
type
  numero = file of integer;
var
  arch_num: numero;
  num:integer;
  nombre:String[12];
begin
  Writeln('Nombre del archivo');
  readln(nombre);
  assign(arch_num,nombre);// Asigno al Archivo Logico (arch_num) el nombre del archivo fisico asignado por el usuario(nombre)
  rewrite(arch_num); // Crear el archivo con nombre Arch_num
  Writeln('Numero a guardar');
  readln(num);
  while (num <> 30000) do begin
        write(arch_num,num);// Escribo en el archivo logico el numero ingresado por pantalla
        Writeln('Numero a guardar');
        readln(num);
  end;
  writeln('fin del programa');
  close(arch_num);// Uso close para cerrar el archivo y poner una marca de EoF(End of File) al final del mismo
end.


{Agregar al menú del programa del ejercicio 3, opciones para:
a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
un número de empleado ya registrado (control de unicidad).
b. Modificar edad a uno o más empleados.
c. Exportar el contenido del archivo a un archivo de texto llamado
“todos_empleados.txt”.
d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado}
program Ejer4PracticaUno;
Type
  regEmpleados = record
    numEmpleado: integer;
    apellido: String[12];
    nombre: String[12];
    edad: integer;
    dni: integer;
  end;
  arch_registro = file of regEmpleados;
procedure leerEmpleados(var reg:RegEmpleados);
Begin
  Write('Apellido: ');
  readln(reg.apellido);
  if(reg.apellido <> 'fin')then begin
      Write('Nombre: ');
      readln(reg.nombre);
      Write('Edad: ');
      readln(reg.edad);
      Write('DNI: ');
      readln(reg.dni);
      Write('Numero de Empleado: ');
      readln(reg.numEmpleado);
  end;
end;
procedure cargaEmpleados(var empleados:arch_registro);
var
  reg:regEmpleados;
Begin
  leerEmpleados(reg);
  while(reg.apellido <> 'fin')do begin
    write(empleados,reg);
    leerEmpleados(reg);
  end;
end;
procedure buscar(nombre,apellido:string ;var archEmpleado: arch_registro);
var
  reg:regEmpleados;
Begin
  while (not eof(archEmpleado))do begin
      read(archEmpleado,reg);
      if(reg.nombre = nombre)then begin
          Writeln('Nombre: ',reg.nombre);
          Writeln('Apellido: ',reg.apellido);
          Writeln('Edad: ',reg.edad);
          Writeln('DNI: ',reg.dni);
          Writeln('Numero Empleado: ',reg.numEmpleado);
      end
      else
        if(reg.apellido = apellido)then begin
            Writeln('Nombre: ',reg.nombre);
            Writeln('Apellido: ',reg.apellido);
            Writeln('Edad: ',reg.edad);
            Writeln('DNI: ',reg.dni);
            Writeln('Numero Empleado: ',reg.numEmpleado);
        end;
  end;
end;
procedure listar(var archEmpleados:arch_registro);
var
  reg:regEmpleados;
Begin
  while(not eof(archEmpleados))do begin
       read(archEmpleados,reg);
          Writeln('Nombre: ',reg.nombre);
          Writeln('Apellido: ',reg.apellido);
          Writeln('Edad: ',reg.edad);
          Writeln('DNI: ',reg.dni);
          Writeln('Numero Empleado: ',reg.numEmpleado);
          writeln();
          writeln('-------------------------');
          writeln();
  end;
end;
procedure mayores70(var archEmpleados:arch_registro);
var
  reg:regEmpleados;
Begin
    while(not eof(archEmpleados))do begin
         read(archEmpleados,reg);
         if(reg.edad > 70) then begin
            Writeln('Nombre: ',reg.nombre);
            Writeln('Apellido: ',reg.apellido);
            Writeln('Edad: ',reg.edad);
            Writeln('DNI: ',reg.dni);
            Writeln('Numero Empleado: ',reg.numEmpleado);
            writeln();
            writeln('-------------------------');
            writeln();
          end;
    end;
end;
function encontre(var archEmpleados:arch_registro; numEmp:integer):boolean;
var
  reg:regEmpleados;
Begin
  while (not eof(archEmpleados))do begin
      read(archEmpleados,reg);
      writeln(reg.numEmpleado);
      if(reg.numEmpleado = numEmp)then
          encontre:= true;
  end;
end;
procedure agregarEmpleado(var archEmpleados:arch_registro);
var
  reg:regEmpleados;
Begin
  Writeln('Numero de empleado a agregar');
  readln(reg.numEmpleado);
  if(not encontre(archEmpleados,reg.numEmpleado))then begin
      Write('Nombre: ');
      readln(reg.nombre);
      Write('Edad: ');
      readln(reg.edad);
      Write('DNI: ');
      readln(reg.dni);
      Write('Apellido: ');
      readln(reg.apellido);
      Seek(archEmpleados,FileSize(archEmpleados));
      write(archEmpleados,reg);
  end;
end;
procedure buscarPos(var archEmpleados:arch_registro; numEmp:integer;var pos:integer);
var
  reg:regEmpleados;
  i:integer;
begin
  seek(archEmpleados,0);
  read(archEmpleados,reg);
  for i:= 0 to fileSize(archEmpleados)do begin
      if(reg.numEmpleado = numEmp)then begin
          writeln('a',pos);
          pos:= filePos(archEmpleados);
          writeln('b',pos);
      end;
  end;
end;

procedure modificarEmpleado(var archEmpleados:arch_registro);
var
  regReal:regEmpleados;
  numEmp,pos:integer;
Begin
  pos:= 0;
  writeln('Numero de empleado a modificar');
  readln(numEmp);;
  if(encontre(archEmpleados,numEmp))then begin
    buscarPos(archEmpleados,numEmp,pos);
    writeln(pos);
    seek(archEmpleados,pos);
    write('Edad a modificar: ');
    readln(regReal.edad);
    write(archEmpleados,regReal);
  end;
end;

var
  archEmpleados:arch_registro;
  nombreArch,apellido,nombre:String[12];
  opcion:integer;
begin
  writeln('Desea 1: cargar archivo o 2: leer archivo');
  readln(opcion);
  if(opcion = 1)then begin
    writeln('Nombre del archivo');
    readln(nombreArch);
    assign(archEmpleados,nombreArch);
    rewrite(archEmpleados);
    cargaEmpleados(archEmpleados);
    close(archEmpleados);
  end;
  writeln('Desea 1: Buscar por Nombre o Apellido');
  writeln('Desea 2: Listar todos los empleados');
  writeln('Desea 3: Listar mayores de 70 años');
  writeln('Desea 4: Agregar Nuevo Empleado');
  writeln('Desea 5: Modificar Empelado');
  writeln('Desea 6: Salir');
  readln(opcion);
  while(opcion <> 6) do begin
      assign(archEmpleados,'C:\Users\Usuario\Desktop\seba\Fundamentos de Organizacion de Datos\regEmpleados');
      reset(archEmpleados);
      if(opcion = 1)then begin
        writeln('Nombre a buscar: ');
        readln(nombre);
        writeln('Apellido a buscar: ');
        readln(apellido);
        buscar(nombre,apellido,archEmpleados);
      end;
      if(opcion = 2)then begin
        writeln('Listar empleados');
        listar(archEmpleados);
      end;
      if(opcion = 3)then begin
        writeln('Listar mayores de 70');
        mayores70(archEmpleados);
      end;
      if(opcion = 4)then
        agregarEmpleado(archEmpleados);
      if(opcion = 5)then
        modificarEmpleado(archEmpleados);
      close(archEmpleados);
      writeln('Desea 1: Buscar por Nombre o Apellido');
      writeln('Desea 2: Listar todos los empleados');
      writeln('Desea 3: Listar mayores de 70 años');
      writeln('Desea 4: Agregar Nuevo Empleado');
      writeln('Desea 5: Modificar Empelado');
      writeln('Desea 6: Salir');
      readln(opcion);
  end;
  writeln('FIN');
  readln;
end.

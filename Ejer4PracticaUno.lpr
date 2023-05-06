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
  ok: boolean;
Begin
  ok:= false;
  reset(archEmpleados);
  while (not eof(archEmpleados) and (not ok))do begin
      read(archEmpleados,reg);
      if(reg.numEmpleado = numEmp)then
          ok:= true;
  end;
  encontre:= ok;
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
      reset(archEmpleados);
      Seek(archEmpleados,FileSize(archEmpleados));
      write(archEmpleados,reg);
  end;
end;
{function buscarPos(var archEmpleados:arch_registro; numEmp:integer):integer;
var
  reg:regEmpleados;
Begin
  reset(archEmpleados);
  while (not eof(archEmpleados))do begin
      read(archEmpleados,reg);
      if(reg.numEmpleado = numEmp)then
          buscarPos:= filePos(archEmpleados);
  end;
end;}
procedure modificarEmpleado(var archEmpleados:arch_registro);
var
  reg,regAux:regEmpleados;
  numEmp,edad:integer;
  ok:boolean;
Begin
   writeln('Numero de empleado a modificar');
   readln(numEmp);
   ok:=false;
       while(not eof(archEmpleados))do begin
           read(archEmpleados,reg);
           if(reg.numEmpleado = numEmp)then begin
               ok:=true;
               write('Edad a modificar: ');
               readln(edad);
               regAux.nombre:= reg.nombre;
               regAux.edad:= reg.edad;
               reg.edad:= edad;
               seek(archEmpleados,filePos(archEmpleados)-1);
               write(archEmpleados,reg);
           end;
       end;
       if(not ok)then begin
           writeln();
           writeln('Numero de empleado no encontrado');
           writeln();
       end
       else
           writeln();
           writeln('La edad de ', regAux.nombre ,' a sido actualizada de ', regAux.edad ,' a ', edad);
           writeln();
end;
procedure exportar(var archEmpleados:arch_registro; var todosEmpleados:arch_registro);
var
  reg:regEmpleados;
Begin
  while(not eof(archEmpleados)) do begin
       read(archEmpleados,reg);
       write(todosEmpleados,reg);
  end;
  close(todosEmpleados);
end;
procedure exportarSinDni(var archEmpleados:arch_registro; var empSinDni:arch_registro);
var
  reg:regEmpleados;
Begin
  while(not eof(archEmpleados)) do begin
       read(archEmpleados,reg);
       if(reg.dni = 00)then
          write(empSinDni,reg);
  end;
  close(empSinDni);
end;
var
  archEmpleados,todosEmpleados,empSinDni:arch_registro;
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
  writeln('Desea 5: Modificar Empleado');
  writeln('Desea 6: Exportar archivo');
  writeln('Desea 7: Exportar empleados sin dni');
  writeln('Desea 8: Salir');
  readln(opcion);
<<<<<<< HEAD
  while(opcion <> 6) do begin
      assign(archEmpleados,'C:\Users\syuco\Desktop\FoD\Practicas\Fundamentos-de-Organizaci-n-de-Datos\regEmpleados');
=======
  while(opcion <> 8) do begin
      assign(archEmpleados,'C:\Users\Usuario\Desktop\seba\Fundamentos de Organizacion de Datos\regEmpleados');
>>>>>>> c59eb9f08940916b2a5772197e3e9c842a747db7
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
      if(opcion = 6)then begin
         assign(todosEmpleados,'todos_empleados.txt');
         rewrite(todosEmpleados);
         exportar(archEmpleados,todosEmpleados);
      end;
      if(opcion = 7) then begin
          assign(empSinDni,'faltaDNIEmpleado.txt');
          rewrite(empSinDni);
          exportarSinDni(archEmpleados,empSinDni);
      end;
      close(archEmpleados);
      writeln('Desea 1: Buscar por Nombre o Apellido');
      writeln('Desea 2: Listar todos los empleados');
      writeln('Desea 3: Listar mayores de 70 años');
      writeln('Desea 4: Agregar Nuevo Empleado');
      writeln('Desea 5: Modificar Empleado');
<<<<<<< HEAD
      writeln('Desea 6: Salir');
=======
      writeln('Desea 6: Exportar archivo');
      writeln('Desea 7: Exportar empleados sin dni');
      writeln('Desea 8: Salir');
>>>>>>> c59eb9f08940916b2a5772197e3e9c842a747db7
      readln(opcion);
  end;
  writeln('FIN');
  readln;
end.



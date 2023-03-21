{Realizar un programa que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.}
program Ejer3PracticaUno;
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
  writeln('Desea 4: Salir');
  readln(opcion);
  while(opcion <> 4) do begin
      assign(archEmpleados,'C:\Users\Usuario\Desktop\seba\Fundamentos de Organizacion de Datos\regEmpleado');
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
      close(archEmpleados);
      writeln('Desea 1: Buscar por Nombre o Apellido');
      writeln('Desea 2: Listar todos los empleados');
      writeln('Desea 3: Listar mayores de 70 años');
      writeln('Desea 4: Salir');
      readln(opcion);
  end;
  writeln('FIN');
  readln;
end.


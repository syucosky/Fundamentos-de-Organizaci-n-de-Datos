{Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripción, marca, precio, stock mínimo y el stock disponible.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo. El archivo de texto generado
podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
debería respetar el formato dado para este tipo de archivos en la NOTA 2.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”.}
program Ejer5PracticaUno;
type
  celular = record
    codCel:integer;
    nombre:String[12];
    descripcion:String[20];
    marca:String[12];
    precio:real;
    stockMin:integer;
    stockDisp:integer;
  end;
  arch_celulares = file of celular;
procedure incisoA(var arch:arch_celulares);
var
  arch2:arch_celulares;
  cel:celular;
Begin
  assign(arch2,'celulares.txt');
  reset(arch2);
  rewrite(arch);
  while (not eof(arch2))do begin
      read(arch2,cel);
      write(arch,cel);
  end;
  close(arch2);
  close(arch);
end;
procedure incisoB(var arch:arch_celulares);
var
  reg:celular;
Begin
  reset(arch);
  while(not eof(arch))do begin
      read(arch,reg);
      if(reg.stockMin > reg.stockDisp)then
                      mostrarCel(reg);

  end;
  close(arch);
end;
procedure incisoC(var arch:arch_celulares);
var
  reg:celular;
  desc:String[12];
Begin
  reset(arch);
  Writeln('Descripcion');
  readln(desc);
  while(not eof(arch))do begin
      read(arch,reg);
      if( desc = reg.descripcion)then
                      mostararCel(reg);
  end;
  close(arch);
end;

var
  arch:arch_celulares;
  nombreArch:String[12];
begin
  write('Elegir nombre de archivo: ');
  readln(nombreArch);
  assign(arch,nombreArch);
  incisoA(arch);
  incisoB(arch);
  incisoC(arch);
  readln;
end.


{6. Agregar al menú del programa del ejercicio 5, opciones para:
f. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado.
g. Modificar el stock de un celular dado.
h. Exportar el contenido del archivo binario a un archivo de texto denominado:
”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.}
program Ejer6PracticaUno;
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
procedure incisoF(var arch:arch_celulares);
var
  reg:celular;
Begin
  reset(arch);
  writeln('Leer celular');
  leer(reg);
  seek(arch,fileSize(arch));
  write(arch,reg);
  close(arch);
end;
procedure incicoG(var arch:arch_celulares);
procedure incisoH(var arch:arch_celulares,var archSS:arch_celulares);
var
  reg:celular;
  arch2:arch_celulares;
Begin
  reset(arch);
  assign(arch2,'SinStock.txt');
  rewrite(arch2);
  while(not eof(arch))do begin
      read(arch,reg);
      if(reg.stockDisp = 0)then begin
        write(arch2,reg);
      end;
  end;
end;

var
  num:integer;
  nombre:String[12];
  reg:celular;
  ok:boolean;
Begin
   reset(arch);
   ok:= false;
   write('Nombre de cel a buscar: ');
   readln(nombre);
   while(not eof(arch)) and (!ok) do begin
       read(arch,reg);
       if(reg.nombre = nombre)then begin
         ok:= true;
         write('Numero de stock nuevo: ');
         readln(num);
         reg.stockDisp:= num;

       end;
   end;

end;

var
  arch,archSS:arch_celulares;
  nombreArch:String[12];
begin
  write('Elegir nombre de archivo: ');
  readln(nombreArch);
  assign(arch,nombreArch);
  incisoA(arch);
  incisoB(arch);
  incisoC(arch);
  incisoF(arch);
  incisoG(arch);
  incisoH(arch,archSS);
  readln;
end.


{Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
a. Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez
 }
program Ejer2PracticaDos;
const
  valorAlto = 9999;
type
  rango = 0..1;
  alumno = record
    codAlu:integer;
    apellido:String[12];
    nombre:String[12];
    cantCursadas:integer;
    cantFinal:integer;
  end;
  info = record
    codAlum:integer;
    infoMat:rango;
  end;
 maestro = file of alumno;
 detalle = file of info;
procedure leer(var arch:detalle;var reg:info);
begin
  if(not eof(arch))then
         read(arch,reg)
  else
    reg.codAlum:= valorAlto;
end;
procedure actualizarMaestro(var mae:maestro; var det:detalle);
var
  cursada,final,aux:integer;
  aux:string;
  regM:maestro;
  regD:detalle;
Begin
  rewrite(mae);
  reset(det);
  read(mae,regM);
  leer(det,regD);
  while(regD.codAlum <> valorAlto)do begin
     cursada:= 0;
     final:= 0;
     aux:= regD.codAlum;
     while(aux = regD.codAlum)do begin
        if(regD.infoMat = 0)then
               cursada:= cursada + 1
        else
               final:= final + 1;
        leer(det,regD);
     end;
     while(aux <> regM.codAlu)do
          read(mae,regM);
     regM.cantCursadas:=  regM.cantCursadas + cursada;
     regM.cantFinal :=    regM.cantFinal + final;
     Seek(mae,filePos(mae)-1);
     write(mae,regM);
     if(not eof(mae))then
            read(mae,regM);
  end;
  close(mae);
  close(det);
end;
procedure alumnosCuatroCursadas(var archTexto:Text;var mae:maestro);
var
  reg:alumno;
Begin
  reset(mae);
  reset(archTexto);
  while(not eof(mae))do begin
     if(mae.cantFinal = 0)then
            if(mae.cantCursadas >= 4)then begin
                   read(mae,reg);
                   write(archTexto,reg.codAlu,' ',reg.nombre,' ',reg.apellido,' ',reg.cantCursadas,' ',reg.cantFinal,' ');
            end;

  end;
  close(mae);
  close(archTexto);
end;

var
  mae:maestro;
  det:detalle;
  archTexto:Text;
begin
  assign(mae,'maestro');
  assign(det,'detalle');
  assign(archTexto,'archivo_texto');
  actualizarMaestro(mae,det);
  alumnosCuatroCursadas(archTexto,mae);
  readln;
end.


{Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}
program Ejer1PracticaDos;
const
  valorAlto = 9999;
type
  empleado = record
    codEmp: integer;
    nombre: String[12];
    montoComi:real;
  end;
arch_empleados : file of empleado;
procedure leer(var arch:arch_empleados; var reg:emplead);
begin
  if(not eof(arch))then
         read(arch,reg)
  else
    reg.codEmp := valorAlto;
end;
procedure compactar(var archEmp: arch_empleados; var comisiones:arch_empleados);
var
  reg,regTotal:empleado;
begin
  rewrite(archEmp);
  reset(comisiones);
  leer(comisiones,reg);
  while(reg.codEmp <> valorAlto)do begin
      regTotal:= reg;
      regTotal.montoComi := 0;
      while(regTotal.codEmp = reg.codEmp)then begin
           regTotal.montoComi:= regTotal.montoComi + reg.montoComi;
           leer(comisiones,reg);
      end;
      write(archEmp,regTotal);
  end;
  close(archEmp);
  close(comisiones);
end;
var
  archEmp,comisiones:arch_empleados;
begin
  assign(archEmp,'archivo_empleados');
  assign(comisiones,'archivo_comisiones');
  compactar(archEmp,comisiones);
  readln;
end.


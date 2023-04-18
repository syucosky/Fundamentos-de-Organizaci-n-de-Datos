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
Type
  empleado = record
    codEmp : integer;
    nombre : String[12];
    montoComi : real;
  end;
  arch_empleados = file of empleado;
  // LA INFORMACION ESTA ORDENADA POR CODIGO DE EMPLEADO, UN EMPLEADO PUEDE APARECER VARIAS VECES
  // CREAR UN ARCHIVO NUEVO CON LA INFORMACION COMPACTADA SIN REPETICION DE EMPLEADOS
procedure compactarArchivo(var arch: arch_empleados; var archCompactado:arch_empleados);
var
  reg,regAux: empleado;
  codAux:
Begin
  reset(arch);
  reset(archCompactado);
  while(not eof(arch))do begin
    read(arch,reg);


  end;
end;
var
  arch,archCompactado:arch_empleados;
begin
  assign(arch,'arch_sinCompactar');
  assign(archCompactado,'arch_compactado');
  compactarArchivo(arch,archCompactado);
  readln();
end.


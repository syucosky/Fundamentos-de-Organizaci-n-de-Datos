{3. Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo.
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto.
}
program Ejer3PracticaDos;
const
  dimF = 30;
  valorAlto = 9999;
type
  producto = record
    codPro:integer;
    nombre:String[12];
    descripcion:String[20];
    stockDis:integer;
    stockMin:integer;
    precio:real;
  end;
  venta = record
    cod:integer;
    cant:integer;
  end;
  maestro = file of producto;
  detalle = file of venta;
  ventas = array of [1..dimF] of detalle;
procedure leer(var arch:detalle; var reg:venta);
begin
     if(not eof(arch))then
            read(arch,reg)
     else
       reg.cod := valorAlto;
end;
procedure asignarDetalle(var vec:ventas);
var
  i:integer;
Begin
  for i:= 1 to dimf do
    assign(vec[i],'detalle'+i);
end;
procedure actualizarMaestro(var mae:maestro; var vec:ventas);
var
  regM:producto;
  regD:venta;
  total,aux,i:integer
Begin
  for i:= i to dimF do begin
    rewrite(mae);
    read(mae,regM);
    reset(v[i]);
    leer(v[i],reg);
    while(reg.cod <> valorAlto)do begin
       total:= 0;
       aux:= reg.cod;
       while(aux = reg.cod)do begin
          total:total + reg.cant;
          leer(v[i],reg);
       end;
       while(regM.codPro <> aux)do
           read(mae,regM);
       regM.stockDis:= regM.stockDis - total;
       Seek(mae,filePos(mae)-1)
       write(mae,regM);
       if(not eof(mae))then
              read(mae,regM);
    end;
    close(mae);
    close(v[i]);
  end;
end;
procedure stockAgotado(var mae:maestro; var sinStock:Text);
var
  reg:producto;
Begin
   rewrite(sinStock);
   reset(mae);
   while (not eof(mae))do begin
     read(mae,reg);
     if(reg.stockDis < reg.stockMin)then
            write(sinStock,reg.nombre,' ',reg.descripcion,' ',reg.stockDis,' ',reg.precio,' ');
   end;
   close(mae);
   close(sinStock);
end;
{nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo.                           }
var
  mae:maestro;
  vec:ventas;
  sinStock:Text;
begin
  assign(mae,'maestro');
  asignarDetalle(vec);
  actualizarMaestro(mae,vec);
  assign(sinStock,'SinStock.txt');
  stockAgotado(mae,sinStock);
  informar(sinStock);
  readln;
end.


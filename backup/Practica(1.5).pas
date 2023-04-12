program  Practica1Ej5;

Uses sysutils;

type

celular = record
cod: integer;
pre: LongInt;
marca: string;
stock_minimo: integer;
stock_actual: integer;
des: string[240];
nom: string[30];
End;

cel = file of celular;



procedure pantalla;
begin
writeln('------------------------------------------------------------------------------------------');
writeln('Elegir que accion vas a realizar');
writeln('a)Cargar archivo');
writeln('b)Mostar en pantalla datos de aquellos celulares que tengan un stock menor al stock mínimo.');
writeln('c)Mostar Descripcion');
writeln;
end;


procedure Crear(var arc:cel);
var
c:celular;
arc2:Text;
begin
Assign(arc2,'celulares.txt');
reset(arc2);
rewrite(arc);
while (not eof(arc2)) do
	begin
	  readln(arc2, c.cod ,c.pre, c.marca);
	  readln(arc2, c.stock_minimo,c.stock_actual,c.des);
	  readln(arc2,c.nom); 
      write(arc,c);
	end;
close(arc);
close(arc2);
end;

procedure Mostrar(c:celular);
begin
writeln('Nombre: ',c.nom);
writeln('Codigo: ',c.cod);
writeln('Precio: USD',c.pre);
writeln('Marca: ',c.marca);
writeln('StockMinimo: ',c.stock_minimo);
writeln('StockActual: ',c.stock_actual);
writeln;
end;


procedure Stock(var arc:cel;nom:string);
var
c:celular;
begin
if(fileExists(nom))then 
	begin
		reset(arc);
		while(not eof(arc))do
			begin
				read(arc,c);
				if(c.stock_minimo > c.stock_actual) then
					Mostrar(c);		
			end;
		close(arc);
	end
else
	begin
		writeln('----------------------');
		writeln('El archivo no Existe');
		writeln('----------------------');
	end;
end;

procedure Caracter(var arc:cel;nom:string);
var
c:celular;
desc:string;
find:boolean;
begin
if(fileExists(nom))then
	begin
		reset(arc);
		write('Escibra la descripcion que dese buscar');
		readln(desc);
		while(not eof(arc))do
			begin
				read(arc,c);
				if(c.des = desc)then
					begin
						writeln('Codigo: ', c.cod, ' Modelo: ', c.nom);
						writeln('Marca: ', c.marca, ' Precio: $USD ', c.pre);
						find := true;
					end;
			end;
		if not find then
			begin
				writeln('###################################');
				writeln('No se encontraron coincidencias.');
				writeln('###################################');
			end;
		close(arc);
	end
else
	begin
	  writeln('###################################');
      writeln('Debes generar el archivo primero');
      writeln('###################################');
	end;
end;

procedure Exportar(var arc:cel;nom:string);
var
c:celular;
arc2:Text;
begin
if(fileExists(nom))then
	begin
		Assign(arc2,'celulares.txt');
		rewrite(arc2);
		reset(arc);
		while(not eof(arc))do
			begin
				read(arc,c);
				writeln(arc2, c.cod,' ',c.pre,' ', c.marca);
				writeln(arc2, c.stock_minimo,' ',c.stock_actual,' ',c.des);
				writeln(arc2, c.nom);
				
			end;
		close(arc);
		close(arc2);
	end
else
	begin
	  writeln('###################################');
      writeln('Debes generar el archivo primero');
      writeln('###################################');
	end;
end;

procedure LeerC(var c:celular);
	begin
		writeln('Para finalizar escribir en el nombre: fin');
		write('nombre:');
		readln(c.nom);
		if(c.nom = 'fin')then
			begin
				write('codigo del celular:');
				readln(c.cod);
				write('descripcion:');
				readln(c.des);
				write('marca:');
				readln(c.marca);
				write('precio:');
				readln(c.pre);
				write('stock minimo:');
				readln(c.stock_minimo);
				write('stock disponible:');
				readln(c.stock_actual);
			end;
	end;
	
procedure Agregar(var arc:cel;nom:string);
var
c:celular;
begin
if(fileExists(nom))then
	begin
		reset(arc);
		Seek(arc,fileSize(arc)-1);
		LeerC(c);
		while(c.nom = 'fin')do
			begin
				write(arc,c);
			end;
		close(arc);
	end
else
	begin
		writeln('###################################');
        writeln('Debes generar el archivo primero');
        writeln('###################################');
	end;
end;


procedure CambiarStock(var arc:cel;nom:string);
var
c:celular;
cant:integer;
find:boolean;
begin
if(fileExists(nom))then
	begin
		find:=false;
		writeln('Eleguir el nombre de que telefono se desea cambiar el Stock');
		readln(nom);
		writeln('Eleguir el cantidad que quieres agregar al stock');
		readln(cant);
		reset(arc);
		while(not eof(arc))do
			begin
				read(arc,c);
				if(c.nom = nom) then
					begin
						c.stock_actual:= c.stock_actual + cant;
						seek(arc,FilePos(arc)-1);
						write(arc,c);
					end;
			end;
			close(arc);
		if not find then
			begin
				writeln('#####################');
				writeln('No Existe el Celular.');
				writeln('#####################');
			end;
	end
else
	begin
		writeln('###################################');
        writeln('Debes generar el archivo primero');
        writeln('###################################');
	end;


end;


procedure Exportar2(var arc:cel;nom:string);
var
c:celular;
arc2:Text;
begin
if(fileExists(nom))then
	begin
		Assign(arc2,'SinStock.txt');
		reset(arc);
		rewrite(arc2);
		while not eof(arc) do
			begin
				read(arc,c);
				if(c.stock_actual = 0)then
					begin
						writeln(arc2, c.cod,' ',c.pre,' ', c.marca);
						writeln(arc2, c.stock_minimo,' ',c.stock_actual,' ',c.des);
						writeln(arc2, c.nom);
					end;
			end;
		close(arc2);
		close(arc);
	end
else
	begin
		writeln('###################################');
        writeln('Debes generar el archivo primero');
        writeln('###################################');
	end;
end;

var
i:char;
archivo:cel;
nom:string;
BEGIN
writeln('Eliga archivo a utilizar');
readln(nom);
Assign(archivo,nom);
pantalla;
readln(i);
while(i <> '0') do
	begin
		case(i) of
			'a':Crear(archivo);
			'b':Stock(archivo,nom);
			'c':Caracter(archivo,nom);
			'd':Exportar(archivo,nom);
			'e':Agregar(archivo,nom);
			'f':CambiarStock(archivo,nom);
			'g':Exportar2(archivo,nom);
			end;
			writeln;
			pantalla;
			readln(i);
	end;
END.


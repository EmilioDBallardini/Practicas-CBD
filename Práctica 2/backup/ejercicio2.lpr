program ejercicio2;
Const
  Alto = 9999999;
//está ordenado por codigo de autor
//genero
//disco
//mientras el código de autor sea igual recorrer
// lo mismo para el código de genero
//lo mismo para el código de disco
// ir sumando en cada iteración la cantidad vendida

Type

  registro=Record
    codigo:integer;
    nombre_autor:String[255];
    nombre_disco:String[255];
    genero:String[255];
    vendida:integer;
  end;

  archivo = File of registro;

procedure leer(var binario:archivo; var reg:registro);
	begin
    if not(eof(binario)) then
    	read(binario, reg)
    else
      reg.codigo:=Alto;
  end;

var

  binario: archivo;
  cod_codigo, cant_genero, cant_discos, cant_total: integer;
  reg:registro;
  texto : Text;
  cod_genero, cod_autor, cod_disco : String[255];

begin
   Assign(binario, 'discos.bat');
	 Assign(texto, 'discos.txt');
   Reset(archivo);
   Rewrite(texto);
   //recorrer mientras el género sea el mismo
   //recorrer por cada disco la cantidad vendida (puede que aparezca mas de una vez? por las dudas si)
   //ir sumando las cantidades vendidas de c/disco y sumarlo al total del género
   //o sumar de c/disco y al llegar al corte de control de ese disco sumar al total

   Leer(binario, reg);
   With reg do
	 begin
     while ( codigo <> Alto ) do
     begin
       cod_codigo := codigo;
       cod_autor := nombre_autor;
       WriteLn(texto, 'Autor: ', nombre_autor);
       WriteLn(Autor: ', nombre_autor);
       cant_total:= 0;
       while ( cod_codigo := codigo ) do
       begin
         cod_genero := genero;
         cant_genero := 0;
         while ( cod_genero := genero ) do
         begin
           cod_disco:= nombre_disco;
           cant_discos:= 0;
           WriteLn(texto, 'Disco: ', nombre_disco);
           WriteLn('Disco: ', nombre_disco);
           while ( cod_disco:= nombre_disco) do
           begin
             cant_disco += vendida;
             leer(binario, reg);
           end;
           WriteLn(texto, 'Cantidad vendida: ', cant_total);
           WriteLn('Cantidad vendida: ', cant_total);
           cant_genero+= cant_disco;
         end;
         cant_total+= cant_genero;
       end;
     end;
   end;

	Close(binario);
	Close(texto);
end.


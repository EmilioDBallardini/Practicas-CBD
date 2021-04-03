program ejercicio5;


Type

  //declaro el registro
  registro = Record
    nro:integer;
    altura_max:double;
    n_cient : String[255];
    n_vulgar : String[255];
    color : String[255];
  end;

  //declaro el archivo
  archivo_bin = File of registro;


var

  //instancio el archivo y registro
  archivo:archivo_bin;
  reg:registro;

  //para hacerlo mas modular
  //uso un procedure para leer los campos del regístro
  procedure leerRegistro(var reg:registro);
  begin
    With reg do
		begin
      Write('Numero de especie: ');ReadLn(nro);
      Write('Altura máxima: ');ReadLn(altura_max);
      Write('Nombre científico: ');ReadLn(n_cient);
      Write('Nombre vulgar: ');ReadLn(n_vulgar);
      Write('Color: ');ReadLn(color);
    end;
  end;

 procedure reportarNumeros(var archivo: archivo_bin; nombre: String);
 var
   cant_total:integer;
   min, max:double;
   min_str, max_str: String;
   reg:registro;
 begin
   cant_total:=0;
   min:=999999;
   max:=-1;

   Assign(archivo, nombre);
   Reset(archivo);

   if not (eof ( archivo ) ) then
     repeat
       Read(archivo, reg);
       With reg do
       begin
         //incremento la cantidad total de especies
         cant_total += 1;
         //si la altura es mayor a la máxima cambio los valores
         if ( altura_max  > max ) then
         begin
           max:= altura_max;
           max_str:=n_vulgar;
         end;
         //si la altura es menor a la mínima cambio los valores
         if ( altura_max < min ) then
         begin
           min:= altura_max;
           min_str:=n_vulgar;
         end;
       end;

     until (eof(archivo));
  Close(archivo);
 end;

procedure listarContenido(var archivo:archivo_bin; nombre:String);
var
  reg:registro;
begin
  Assign(archivo, nombre);
  Reset(archivo);
  if not (eof(archivo)) then
    repeat
  	  Read(archivo, reg);
      With reg do
      begin
        Write('Numero de especie: ', nro);
        Write('Altura máxima: ',altura_max);
        Write('Nombre científico: ', n_cient);
        Write('Nombre vulgar: ', n_vulgar);
        WriteLn('Color: ', color);
      end;
    until (eof(archivo));

  Close(archivo);
end;

procedure cambiarNombre(var archivo: archivo_bin; nombre:String);
var
  reg:registro;
begin
  Assign(archivo, nombre);
  Reset(archivo);

  if not (eof(archivo)) then
  	repeat
      Read(archivo, reg);
      with reg do
      begin
        if(n_cient = 'Victoria amazonia')then
        begin
        	n_cient:='Victoria amazónica';
          Seek(archivo, FilePos(archivo) - 1);
          Write(archivo, reg);
          //para que no siga buscando cuando ya lo encontró
          Seek(archivo, FileSize(archivo));
        end;
      end;
    until (eof(archivo));
  Close(archivo);

end;

procedure anadirEspecies(var archivo: archivo_bin; nombre:String);
var
  reg:registro;
begin
  Assign(archivo, nombre);
  Reset(archivo);
  Seek(archivo, FileSize(archivo));

  leerRegistro(reg);

  While not (reg.n_cient = 'zzz' ) do
  begin
    Write(archivo, reg);
    leerRegistro(reg);
  end;

  Close(archivo);
end;

procedure pasarATexto(var archivo: archivo_bin; nombre:String; var texto: Text);
var
  reg:registro;
begin
  Assign(archivo, nombre);
  Assign(texto, 'flores.txt');
  Reset(archivo);
	Rewrite(texto);

  if not(eof(archivo)) then
  	repeat
    	Read(archivo, reg);
      With reg do
  		begin
        WriteLn(texto, 'Numero de especie: ', nro, 'Altura máxima: ', altura_max, 'Nombre científico: ', n_cient);
        WriteLn(texto, 'Nombre vulgar: ', n_vulgar);
        WriteLn(texto, 'Color: ', color);
      end;
    until (eof(archivo));

  Close(arhivo);
  Close(texto);

end;

begin
  Assign(archivo, 'especies.bat');
  Rewrite(archivo);

  //Primero leo todo el registro
  leerRegistro(reg);
  //y si el nombre científio no es zzz procedo a seguir leyendo
  //como no se aclara asumo que no se debe incluir
  While (reg.n_cient <> 'zzz' ) do
  begin
		Write(archivo, reg);
    leerRegistro(reg);
  end;


  Close(archivo);
end.


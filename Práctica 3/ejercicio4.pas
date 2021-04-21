program ejercicio4;

Type

  registro=Record
    codigo:integer;
    nombre:String[255];
    genero:String[255];
    artista:String[255];
    desc:String[255];
    anio:ShortInt;
    stock:integer;
  end;


  archivo_reg = File of registro;



  procedure anularStock(var binario:archivo_reg; cod_b:integer);
  var
    reg:registro;
    cod:integer;
  begin
    Reset(binario);


    Read(binario, reg);
    while not (eof(archivo) or (reg.codigo = cod_b))do
    begin
    	Read(binario, reg);
    end;
    if ( reg.codigo = cod_b ) then
    begin
      Seek(binario, FilePos(binario) - 1);
      reg.stock:=0;
      Write(binario, reg);
      WriteLn('El álbum ', reg.nombre, ', se quedó sin stock');
    end;


    Close(archivo);
  end;

	procedure compactar(var binario:archivo);
  var
    reg, aux:registro;
    pos:integer;
	begin
    Reset(binario);

    Read(binario, reg);
		while not (eof(binario))do
    begin
      if ( reg.stock = 0 )then
      begin
        pos:= FilePos(binario) - 1;
        Seek(binario, FileSize(binario) - 1);
       	Read(binario, aux);
        Seek(binario, pos);
        Write(binario, aux);
        Seek(binario, FileSize(binario) - 1);
        truncate(binario);
      end;
    end;


    Close(binario);
  end;

var
  binario:archivo_reg;
  cod_b:integer;


begin
  Assign(binario, 'discos.bat');



end.


program ejercicio3;

Type

  registro = Record
    codigo:integer;
    nombre:String[255];
    descripcion:String[255];
    stock:integer;
  end;

  archivo_reg = File of registro;

  procedure leerRegistro(var reg:registro);
  begin
    With reg do
    begin
      Write('Ingrese codigo de producto: ');ReadLn(codigo);
      Write('Ingrese nombre de producto: ');ReadLn(descripcion);
      Write('Ingrese descripcion de producto: ');ReadLn(nombre);
      Write('Ingrese stock de producto: ');ReadLn(stock);
    end;
  end;

  procedure generarBinario(var texto:Text);
  var
    reg:registro;
    binario: archivo_reg;
  begin
    Reset(texto);
    Rewrite(binario);

    while not(eof(texto))do
    begin
      With reg do
			begin
        ReadLn(texto, codigo, descripcion);
        ReadLn(texto, stock, nombre);
      	Write(binario, reg);
      end;
    end;

    Close(binario);
		Close(texto);

  end;

	procedure colocarMarca(var binario:archivo_reg);
  var
    reg:registro;
    cod:integer;
  begin
    Reset(binario);

    Write('Ingrese el código a borrar: ');ReadLn(cod);
		while not(cod=10000)do
    begin
      Read(binario, reg);
			while not(eof(binario) and (cod <> reg.codigo)) do
      begin
	      Read(binario, reg);
      end;
      if(cod = reg.codigo)then
      begin
        Seek(binario, FilePos(binario) - 1);
        reg.codigo:= reg.codigo * (-1);
        Write(binario, reg);
      end;
			Seek(binario, 0);
      Write('Ingrese el código a borrar: ');ReadLn(cod);
    end;
    Close(binario);
  end;

	procedure darAltaInef(var binario:archivo_reg);
  var
    reg, aux:registro;
  begin
    Reset(binario);
    leerRegistro(reg);
    While not(reg.codigo = 10000)do
    begin
      Read(binario, aux);
      while((aux.codigo > 0) and not(eof(binario)))do
      begin
        Read(binario, aux);
      end;

      if(aux.codigo < 0)then
      begin
        Seek(binario, FilePos(binario) -1);
        Write(binario, reg);
      end
      else
      begin
      	Write(binario, reg);
      end;
      leerRegistro(reg);
      Seek(binario, 0);
    end;
    Close(binario);
  end;

	procedure generarListaInvertida(var binario:archivo_reg);
  var
    reg, aux:registro;
    cod, nLibre:integer;
  begin
    Reset(binario);

    Write('Ingrese el código a borrar: ');ReadLn(cod);
		Read(binario, aux);
    while (cod <> 10000) do
    begin
      While not(( reg.codigo = cod) or (eof(binario)))do
      	Read(binario, reg);
      if (cod = reg.codigo ) then
      begin
      	nLibre:= FilePos(binario) - 1;
        Seek(binario, nLibre);
        Write(binario, aux);
        Seek(binario, 0);
        reg.codigo:= nLibre;
        Write(binario, reg);
      end
      else
      begin
        WriteLn();
        WriteLn('No se encontró el producto..');
        WriteLn('Aprete Enter para continuar');
        ReadLn();
        Seek(binario, 0);
      end;
      Write('Ingrese el código a borrar: ');ReadLn(cod);
    end;
    Close(binario);
  end;

	procedure darAltaLista(var binario:archivo_reg);
  var
    reg_libre, reg, aux:registro;
  	nLibre:integer;
  begin
    Reset(binario);

    Read(binario, reg_libre); //leo el registro dedicado
		leerRegistro(reg); //leo el registro a agregar
    nLibre:= reg_libre.codigo; //guardo la posición que tiene
    while not (reg.codigo = 10000) do
    begin
      //si la posición era -1
      //es que no había registro libre y se mueve al final
      if (nLibre = -1 )then
      	Seek(binario, FileSize(binario))
      else
      //en cambio si es distinto de 0
      begin
        Seek(binario, nLibre);//busco esa posición
        Read(binario, aux); //leo el registro
        Seek(binario, 0); //vuelvo al inicio
        Write(binario, aux); //cambio la posición del siguiente libre
        Seek(binario, nLibre);
      end;
      Write(binario, reg);
      WriteLn();
      leerRegistro(reg);
    end;
    Close(binario);
  end;

	procedure generarBinarioConLista(var texto:Text);
  var
    reg:registro;
		binario:archivo_reg;
	begin

    Reset(texto);
    Rewrite(binario);

    //configuro el registro dedicado
    reg.codigo:= -1;

    Write(binario, reg);
    while not(eof(texto))do
    begin
      With reg do
			begin
        ReadLn(texto, codigo, descripcion);
        ReadLn(texto, stock, nombre);
      	Write(binario, reg);
      end;
    end;
    Close(binario);
		Close(texto);
  end;

var

  texto:Text;
  binario: archivo_reg;

begin
    Assign(texto, 'stocks.txt');
    Assign(binario, 'stocks.bat');
end.


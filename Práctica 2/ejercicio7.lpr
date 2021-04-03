program ejercicio7;
Uses
	SysUtils;
Const Alto = 999999999;

Type

  registro_m=Record
    codigo:integer;
    nombre:String[255];
    desc:string[255];
    precio:real;
    stock:integer;
    stock_min:integer;
  end;

  registro_d=Record
    codigo:integer;
    vendidas:integer;
  end;

  archivo_d = File of registro_d;
  archivo_m = File of registro_m;
  arreglo_d = Array[0..9] of archivo_d;
  arreglo_regs = Array[0..9] of registro_d;

  procedure leer(var archivo:archivo_d; var reg:registro_d);
  begin
    if not(eof(archivo)) then
    	Read(archivo, reg)
      else
        reg.codigo:=Alto;
  end;

	procedure minimo(var detalles:arreglo_d; var reg:registro_d; var registros:arreglo_regs);
  var
    id_min, min, i:integer;
  begin
    min:=Alto;
    for i:= 0 to 9 do
    begin
    	if(registros[i].codigo < min) then
        begin
          min:=registros[i].codigo;
          id_min:=i;
        end;
    end;

    reg:= registros[id_min];

    leer(detalles[id_min], registros[id_min]);

  end;

	procedure generarMaestro(var maestro:archivo_m; var texto:Text);
  var
    reg:registro_m;
  begin
    Assign(maestro, 'productos.bat');
    Assign(texto, 'productos.txt');
    Reset(texto);
    Rewrite(maestro);

    While not(eof(texto)) do
    begin
			with reg do
			begin
        ReadLn(texto, codigo, precio, stock, stock_min, nombre);
        ReadLn(texto, desc);
        Write(maestro, reg);
      end;
    end;

    Close(maestro);
    Close(texto);
  end;

	procedure actualizarMaestro(var maestro:archivo_m; var detalles:arreglo_d);
  var
    aux_d, reg_d: registro_d;
    a_regs:arreglo_regs;
    reg_m:registro_m;
    i:integer;
  begin
    Assign(maestro, 'productos.bat');
    for i:=0 to 9 do
    begin
      Assign(detalles[i], Concat('caja',IntToStr(i),'.bat'));
      Reset(detalles[i]);
      leer(detalles[i], a_regs[i]);
    end;


    minimo(detalles, reg_d, a_regs);

    while (reg_d.codigo <> Alto)do
    begin
      aux_d.codigo:=reg_d.codigo;
      aux_d.vendidas:=0;

      while (aux_d.codigo = reg_d.codigo)do
      begin
      	aux_d.vendidas+=reg_d.vendidas;
        minimo(detalles, reg_d, a_regs);
      end;

      leer(maestro, reg_m);
      while( reg_m.codigo <> aux_d.codigo) do
      	leer(maestro, reg_m);
      reg_m.stock-=aux_d.vendidas;
      Seek(maestro, FilePos(maestro) - 1);
      Write(maestro, reg_m);
    end;


    for i:= 0 to 9 do
    	Close(detalles[i]);
    Close(maestro);
  end;

begin
end.


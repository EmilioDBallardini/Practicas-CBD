program ejercicio3;
Uses
	SysUtils;
Const
  Alto=9999999;

Type

  registro_d=Record
    codigo:integer;
    numero:integer;
    cant_vendidas:integer;
  end;

  registro_m=Record
    codigo:integer;
    numero:integer;
    descripcion:String[255];
    precio:real;
    color:String[255];
    stock:integer;
    stock_min:integer;
  end;

  archivo_d = File of registro_d;
  archivo_m = File of registro_m;
  arreglo_d = array[0..19] of archivo_d;
  arreglo_reg = array [0..19] of registro_d;

	procedure leer(var archivo:archivo_d; var reg:registro_d);
  begin
    if not(eof(archivo)) then
    	Read(archivo, reg)
      else
        reg.codigo:=Alto;
  end;

	procedure minimo(var arreglo:arreglo_d; var reg:registro_d; var a_regs: arreglo_reg);
  var
    id_min, min, i:integer;
  begin
  	min:= Alto;

    for i:= 0 to 19 do
    begin
      if (a_regs[i].codigo < min) then
        begin
          id_min:=i;
          min:= a_regs[i].codigo;
        end;
    end;

    reg:= a_regs[id_min];

    leer(arreglo[id_min], a_regs[id_min]);

  end;


var

  binario:archivo_d;
  maestro:archivo_m;
  a_detalles:arreglo_d;
  a_registros:arreglo_reg;
  aux, reg_m:registro_m;
  aux_d, reg_d:registro_d;
	i, cant_ventas, cant_stock, aux_codigo:integer;
  texto : Text;

begin
  Assign(maestro, 'maestro_zapatos.bat');
  Assign(texto, 'calzadossinstock.txt');
  Reset(maestro);
  Rewrite(texto);

  for i:= 0 to 19 do
  begin
    Assign(a_detalles[i], Concat('detalle_zapatería_',IntToStr(i),'.bat'));
    Reset(a_detalles[i]);
    leer(a_detalles[i], a_registros[i]);
  end;

  minimo(a_detalles, reg_d, a_registros);

  while(reg_d.codigo <> Alto) do
  begin
    aux_d.codigo:=reg_d.codigo;
    cant_ventas:=0;
    cant_stock:=0;
    while(aux_d.codigo = reg_d.codigo) do
    begin
      cant_ventas+=aux_d.cant_vendidas;
      minimo(a_detalles, aux_d, a_registros);
    end;

    Read(maestro, reg_m);

    //busco el codigo del calzado dentro del maestro
    while (reg_m.codigo <> aux_d.codigo) do
    begin
      WriteLn('El calzado con codigo: ', reg_m.codigo,' - no se vendió.');
      Read(maestro, reg_m);
  	end;

    reg_m.stock-=cant_ventas;
    if (reg_m.stock < reg_m.stock_min) then
    	WriteLn(texto, reg_m.codigo, reg_m.stock, reg_m.descripcion);
    Seek(maestro, FilePos(maestro) - 1);
    Write(maestro, reg_m);

  end;


  while not(eof(maestro)) do
  begin
    Read(maestro, reg_m);
    WriteLn('El calzado con codigo: ', reg_m.codigo,' - no se vendió.');
  end;

  Close(texto);
  Close(maestro);
  for i:= 0 to 19 do
  	Close(a_detalles[i]);
end.


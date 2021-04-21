program ejercicio6;

Type

  registro=Record
    nro_articulo:integer;
    descripcion:String[255];
    color:String[255];
    talle:integer;
    stock:integer;
    precio:real;
  end;

  archivo_reg = File of registro;

  procedure generarNuevo(var viejo:archivo_reg; var nuevo:archivo_reg);
  var
    reg:registro;
	begin
    Reset(viejo);
    Rewrite(nuevo);

    while not (eof(viejo))do
    begin
      Read(viejo, reg);
      if not(reg.stock < 0)then
      begin
      	Write(nuevo, reg);
      end;
    end;
    erase(viejo);
    Assign(nuevo, 'indumentariaDeportiva.bat');
    close(nuevo);
    Close(viejo);
  end;

var

  binario, nuevo:archivo_reg;

begin
	Assign(binario, 'indumentariaDeportiva.bat');
  Assign(nuevo, 'indumentariaProvisional.bat');
  generarNuevo(viejo, nuevo);
end.


program ejercicio2;


Type

  tVehiculo= Record
		codigoVehiculo:integer;
		patente: String[255];
		nro_motor:String[255];
		cantidadPuertas: integer;
		precio:real;
		descripcion:String[255];
	end;

	tArchivo = File of tVehiculo;


 	procedure leerRegistro(var reg:tVehiculo);
  begin
    with reg do
    begin
      Write('Código vehículo: '); ReadLn(codigoVehiculo);
      Write('Patente: '); ReadLn(patente);
      Write('Numero de motor: '); ReadLn(nro_motor);
      Write('Cantidad de puertas: '); ReadLn(cantidadPuertas);
      Write('Precio: '); ReadLn(precio);
      Write('Descripción: '); ReadLn(descripcion);
    end;
  end;

  Procedure agregar (var arch: tArchivo; vehiculo: tVehiculo);
  var
    o, cl: Byte;
    reg: tVehiculo;
    nLibre, cod: integer;

	begin

  	Reset(arch);
    Read(arch, reg);
    Val(reg.descripcion, nLibre, cod);
    if (nLibre = 0) then
    begin
      Seek(arch, FileSize(arch));
    end
    else
    begin
      Seek(arch, nLibre);
      Read(arch, reg);
			Seek(arch, 0);
      Write(arch, reg);
      Seek(arch, nLibre);
    end;
    Write(arch, vehiculo);
    Close(arch);
	End;

  Procedure eliminar (var arch: tArchivo; codigoVehiculo: integer);
  var
    o, cl: Byte;
    reg, reg_b, aux: tVehiculo;
    sLibre: tArchivo;
    nLibre, cod: integer;
    pate_aux:String[255];

  Begin
  	Reset(arch);
    Read(arch, reg);
    While not((codigoVehiculo = reg_b.codigoVehiculo) or (eof(arch))) do
			Read(arch, reg_b);
    if ( reg_b.codigoVehiculo = codigoVehiculo ) then
    begin
      nLibre := FilePos(arch) - 1;
      Seek(arch, nLibre);
      Write(arch, reg);
      Str(nLibre, reg_b.descripcion);
      Seek(arch, 0);
      Write(arch, reg_b);
    end
    else
    begin
      WriteLn();
      WriteLn('No exite ese vehículo');
			Write('Oprima Enter para continuar...'); ReadLn();
    end;
    Close(arch);
  End;

var
  o, cl: Byte;
  reg, reg_b: tVehiculo;  //codigo y codigo a buscar
  sLibre: String[255];  //string con el proximo registro libre
  nLibre, cod: Word;
  archivo: tArchivo;

begin
      Assign(arch, 'patentes.bat');

end.


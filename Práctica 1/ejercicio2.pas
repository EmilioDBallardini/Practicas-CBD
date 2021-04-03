program ejercicio2;

Type

  archivo_vot = File of integer;

var

  archivo:archivo_vot;
  suma_parcial:integer;
  prom:double;
  min:integer;
  aux:integer;
  cant:integer;
begin

  Assign(archivo, 'votantes.bat');
  Reset(archivo);
  prom:=0;
  min:=99999999;
  suma_parcial:=0;
  cant:=0;

  repeat
		Read(archivo, aux);
    suma_parcial+=aux;
    if ( aux <  min ) then
    	min := aux;
    cant+=1;
  until (eof(archivo));
  prom := suma_parcial / cant;
  Close(archivo);

  WriteLn('La cantidad promedio de votantes es: ',prom);
  WriteLn('El mínimo de votantes es: ', min);
  ReadLn();
  end.

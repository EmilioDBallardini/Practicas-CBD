program ejercicio5;
Const
  Alto=99999999;

Type

  registro=Record
    partido:integer;
		localidad:integer;
    barrio:integer;
    cant_n:integer;
		cant_adultos:integer;
  end;

  archivo = File of registro;

	procedure leer(var binario:archivo; var reg:registro);
  begin
  	if (not(eof(binario))) then
    	Read(binario, reg)
      else
        reg.partido:=Alto;
  end;

var

  binario:archivo;
  aux, reg:registro;
  cant_a_barrio, cant_n_barrio, cant_n_localidad, cant_a_localidad, cant_n_partido, cant_a_partido:integer;
  cant_ninios, cant_adultos: integer;



begin
  Assign(binario, 'partidos.bat');
  Reset(binario);

  leer(binario, reg);

  while(reg.partido <> Alto) do
  begin

    aux.partido:=reg.partido;
    cant_a_partido:=0;
    cant_n_partido:=0;
    WriteLn('Partido: ', aux.partido);
    while (aux.partido = reg.partido) do
    begin
      cant_a_localidad:=0;
      cant_n_localidad:=0;
      aux.localidad:=reg.localidad;
      WriteLn('Localidad: ', aux.localidad);
      while(aux.localidad = reg.localidad) and (aux.partido = reg.partido)do
      begin
        //no es necesario acumular por barrio
        aux.barrio:= reg.barrio;
        cant_a_barrio:=0;
        cant_n_barrio:=0;

        while (aux.barrio = reg.barrio) and (aux.localidad = reg.localidad) and (aux.partido = reg.partido) do
        begin
        	cant_n_barrio+=aux.cant_n;
          cant_a_barrio+=aux.cant_adultos;
          leer(binario, aux);
        end;
        cant_a_localidad+=cant_a_barrio;
        cant_n_localidad+=cant_n_barrio;
        WriteLn('Barrio: ', aux.barrio, '. Cantidad niños: ', aux.cant_n,'. Cantidad adultos: ', aux.cant_adultos);
      end;
      cant_a_partido+=cant_a_localidad;
      cant_n_partido+=cant_n_localidad;
      WriteLn('Total niños localidad ', aux.localidad,': ', cant_n_barrio,'. Total adultos localidad ',aux.localidad,': ', cant_a_barrio);
    end;
  end;
  WriteLn('Total niños partido: ', cant_n_partido,'. Total adultos partido: ', cant_a_partido);

  Close(binario);
end.


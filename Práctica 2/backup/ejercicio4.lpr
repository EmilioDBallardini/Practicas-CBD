program ejercicio4;
Uses
	SysUtils;

Const
  Alto=99999999;

Type

  registro_d=Record
    cod_pelicula:integer;
    nombre:string[255];
    genero:string[255];
    director:string[255];
    fecha:integer;
    asistencia:integer;
  end;

  archivo_d = File of registro_d;
  arreglo_d = Array[0..19] of archivo_d;
  archivo_m = File of registro_d;
  arreglo_regs = array[0..19] of registro_d;

  procedure leer(var archivo:archivo_d; var reg:registro_d);
  begin
    if not(eof(archivo)) then
    	Read(archivo, reg)
      else
        reg.cod_pelicula:=Alto;
  end;

	procedure minimo(var detalles:arreglo_d; var reg:registro_d; var a_regs:arreglo_regs);
  var
    id_min, min, i:integer;
  begin
		min:=Alto;

    for i:= 0 to 19 do
    begin
    	if(a_regs[i].cod_pelicula < min) then
        begin
          min:=a_regs[i].cod_pelicula;
          id_min:=i;
        end;
    end;

    reg:=a_regs[id_min];

    leer(detalles[id_min], a_regs[id_min]);

  end;

	procedure actualizarMaestro(var detalles:arreglo_d; var maestro: archivo_m; ruta:String);
  var
    aux, reg, reg_m:registro_d;
    a_regs:arreglo_d;
    i, cant_asistentes:integer;
	begin
    Assign(maestro, ruta);
    for i:= 0 to 19 do
    begin
      Assign(detalles[i], Concat('cine', IntToStr(i),'.bat'));
      Reset(detalles[i]);
      leer(detalles[i], a_regs[i]);
    end;

    minimo(detalles, reg, a_regs);

    while (reg.cod_pelicula <> Alto) do
    begin
      aux.cod_pelicula:=reg.cod_pelicula;
      aux.asistencia:=0;

      while(aux.cod_pelicula = reg.cod_pelicula) do
      begin
      	aux.asistencia+=reg.cod_pelicula;
        minimo(detalles, reg, a_regs);
      end;

      leer(maestro, reg_m);
      while (reg.cod_pelicula <> reg_m.cod_pelicula) do
      	leer(maestro, reg_m);

      reg_m.asistencia+=aux.asistencia;
      Seek(maestro, FilePos(maestro) - 1);
      Write(maestro, reg_m);


    end;


    Close(maestro);
  end;

begin
end.


program ejercicio1;
uses sysutils;
Const
  Alto = 99999999;


Type

  registro_d=Record
    codigo:integer;
    fecha:integer;
    dias:shortInt;
  end;

  registro_m=Record
    codigo:integer;
    nombre_y_apellido:String[255];
    nacimiento:integer;
    direccion:String[255];
    hijos:shortInt;
    telefono:longInt;
    dias:shortInt;
  end;

  archivo_m = File of registro_m;
  archivo_d = File of registro_d;

  arreglo_d = array [0..9] of archivo_d;
  arreglo_regs = array [0..9] of registro_d;

  procedure leerDetalle(var archivo: archivo_d; var reg:registro_d);
  begin
		if not(eof(archivo)) then
    	Read(archivo, reg)
    else
    	reg.codigo:=Alto;
  end;

	procedure minimo(var detalles:arreglo_d; var reg:registro_d; var a_regs:arreglo_regs);
  var
    id_min, min, i:integer;
  begin
  	min:=Alto;
    id_min:=0;

    for i:=0 to 9 do
    begin
    	if (a_regs[i].codigo < min ) then
        begin
          min:= a_regs[i].codigo;
          id_min:=i;
        end;
    end;

    reg:=a_regs[id_min];

    leerDetalle(detalles[id_min], a_regs[id_min]);

    //buscar el minimo
    //asignar ese para devolver
    //leer desde el archivo que corresponde al minimo
    //así queda actualizado
    //?
  end;

  procedure actualizar(var detalle:arreglo_d; var maestro:archivo_m; var texto:Text; var regs:arreglo_regs);
  var
    aux, reg_d:registro_d;
    reg_m:registro_m;
    i:integer;
  begin
    Assign(texto, 'faltanDias.txt');
  	Assign(maestro, 'maestro.bat');
    Reset(maestro);
    Rewrite(texto);
		for i:=0 to 9 do
    begin
    	Assign(detalle[i], Concat('detalle',inttostr(i),'.bat'));
      Reset(detalle[i]);
			leerDetalle(detalle[i], regs[i]);
    end;

    minimo(detalle, aux, regs);

    while ( aux.codigo <> Alto ) do
    begin
    	reg_d.codigo:=aux.codigo;
      reg_d.dias:=0;
      while (aux.codigo = reg_d.codigo) do
      begin
      	reg_d.dias += aux.dias;
        minimo(detalle, aux, regs);
      end;
      //buscar el coincidente
      //repito hasta que encuentre el codigo en el maestro
      repeat
      	Read(maestro, reg_m);
      until (reg_d.codigo = reg_m.codigo);

      if (reg_m.dias - reg_d.dias < 0) then
        begin
          With reg_m do
          begin
            //legible para pascal
            WriteLn(texto, codigo, dias, reg_d.dias, nombre_y_apellido);
          end;
        end
      else
        begin
          reg_m.dias -= reg_d.dias;
          Seek(maestro, FilePos(maestro) - 1);
          Write(maestro, reg_m);
        end;

    end;

    //implementar la funcion mínimo
    //procesando en paralelo los detalles
    //recorriendo el maestro una sola vez

    for i:= 0 to 9 do
    begin
      Close(detalle[i]);
    end;
    Close(texto);
    Close(maestro);
  end;




begin
end.


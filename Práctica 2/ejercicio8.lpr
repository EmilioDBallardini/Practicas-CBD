program ejercicio8;
Uses
	SysUtils;
Const Alto = 99999999;

Type

  registro_d=Record
    cod_zona:integer;
    nombre:string[255];
    desc:string[255];
    fecha:integer;
    metros:real;
  end;

  registro_m=Record
    cod_zona:integer;
    nombre:String[255];
    metros:real;
  end;

  archivo_d = File of registro_d;
  archivo_m = File of registro_m;
  arreglo_d = Array[0..14] of archivo_d;
  arreglo_regs = Array[0..15] of registro_d;

  procedure leer(var archivo:archivo_d; var reg:registro_d);
  begin
    if not(eof(archivo)) then
    	Read(archivo, reg)
      else
        reg.cod_zona:=Alto;
  end;

	procedure minimo(var detalles:arreglo_d; var reg:registro_d; var a_regs:arreglo_regs);
  var
    id_min, i, min:integer;
	begin
    min:=Alto;

    for i:=0 to 14 do
    begin
      if (a_regs[i].cod_zona < min) then
        begin
          id_min:=i;
          min:=a_regs[i].cod_zona;
        end;
    end;

    reg:=a_regs[id_min];

    leer(detalles[id_min], a_regs[id_min]);

  end;

	procedure generarMaestro(var detalles:arreglo_d; var maestro:archivo_m);
  var
    aux_d, reg_d:registro_d;
    reg_m:registro_m;
    a_regs:arreglo_regs;
    i:integer;
    texto:Text;
	begin
  	Assign(maestro, 'maestroObras.bat');
    Assign(texto, 'maestroObrasTexto.txt');
   	Rewrite(maestro);
    Rewrite(texto);
    for i:= 0 to 14 do
    begin
      Assign(detalles[i], Concat('arquitecto', IntToStr(i), '.bat'));
      Reset(detalles[i]);
      leer(detalles[i], a_regs[i]);
    end;

    minimo(detalles, reg_d, a_regs);

    while (reg_d.cod_zona <> Alto)do
    begin
      aux_d.cod_zona:=reg_d.cod_zona;
      aux_d.metros:=0;
      aux_d.desc:=reg_d.desc;
      aux_d.nombre:=reg_d.nombre;

      while (aux_d.cod_zona = reg_d.cod_zona)do
      begin
      	aux_d.metros+=reg_d.cod_zona;
        minimo(detalles, reg_d, a_regs);
      end;

      //cargo los valores en el registro maestro
      reg_m.cod_zona:=aux_d.cod_zona;
      reg_m.metros:=aux_d.metros;
      reg_m.nombre:=aux_d.nombre;
      Write(maestro, reg_m); //escribo en el registro

      //escribo la información solicitada en el archivo de texto
      With aux_d do
      begin
        WriteLn(texto, desc);
        WriteLn(texto, cod_zona, metros, nombre);
      end;

    end;

    Close(texto);
    Close(maestro);
    for i:= 0 to 14 do
    	Close(detalles[i]);
  end;

begin
end.


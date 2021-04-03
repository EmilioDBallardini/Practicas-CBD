program ejercicio6;
Const
  Alto = 99999999;
Type

  registro = record
    codigo:integer;
    fecha:integer;
    servicio:real;
  end;

  archivo_r = File of registro;

  procedure leer(var archivo:archivo_r; var reg:registro);
  begin
    if not(eof(archivo))then
    	Read(archivo, reg)
      else
        reg.codigo:=Alto;
  end;

	procedure merge(var archivo:archivo_d; ruta:string);
  var
    aux, reg:registro;
    salida:archivo_d;

   begin
     Assign(archivo, ruta);
     Assign(salida, 'mozos.bat');
     Reset(archivo);
     Rewrite(salida);

     leer(archivo, reg);

     while(reg.codigo <> Alto) do
     begin
       aux.codigo:=reg.codigo;
       aux.servicio:=0;
       while(aux.codigo = reg.codigo) do
       begin
         aux.servicio+=reg.servicio;
         leer(archivo, reg);
       end;
       aux.fecha:=null;
       Write(salida, aux);

     end;

     Close(archivo);
     Close(salida);
   end;

begin
end.


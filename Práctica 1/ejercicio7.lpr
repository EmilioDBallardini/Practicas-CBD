program ejercicio7;

Type

  registro=Record
    DNI:integer;
    legajo:integer;
    nombre:String[255];
    apellido:String[255];
		direccion:String[255];
    anio:integer;
    nacimiento:longInt;
  end;

	archivo_bin = File of registro;

  //para hacerlo mas modular
  //uso un procedure para leer los campos del regístro
  procedure leerRegistro(var reg:registro);
  begin
    With reg do
		begin
      Write('DNI: ');ReadLn(DNI);
      Write('Legajo: ');ReadLn(legajo);
      Write('Nombre: ');ReadLn(nombre);
      Write('Apellido: ');ReadLn(apellido);
      Write('Dirección: ');ReadLn(direccion);
      Write('Anio: ');ReadLn(anio);
      Write('Nacimiento: ');ReadLn(nacimiento);
    end;
  end;

	procedure crearArchivo(var archivo:archivo_bin; var texto:Text);
  var
    reg:registro;
	begin
    Assign(archivo, 'alumnos.bat');
    Assign(texto, 'alumnos.txt');
    Rewrite(archivo);
    Reset(texto);

    //como no se especifica, supongo el órden de carga de los datos
    //dni legajo nombre
    //apellido
    //año nacimiento direccion
    if not(eof(texto)) then
    	repeat
      	With Reg do
				begin
          //leo en el orden establecido antes
        	ReadLn(texto, DNI, legajo, nombre);
          ReadLn(texto, apellido);
          ReadLn(texto, anio, nacimiento, direccion);
          //escribo en el archivo binario
          Write(archivo, reg);
        end;
      until eof(texto);

    Close(archivo);
    Close(texto);
  end;

	procedure listarEnPantalla(var archivo:archivo_bin; sub_string:String);
  var
    reg:registro;
  begin
    Assign(archivo,	'alumnos.bat');
    Reset(archivo);

    if not(eof(archivo)) then
      repeat
      	Read(archivo, reg);
        if(reg.nombre = sub_string)then
          begin
          	With reg do
            begin
              WriteLn('Nombre y apellido: ', nombre, ' ', apellido);
              WriteLn('DNI: ', DNI, ' - Legado: ', legajo);
              WriteLn('Nacimiento: ', nacimiento, ' - Año de ingreso: ', anio);
              WriteLn('Dirección : ', direccion);
            end;
          end;
      until eof(archivo);
    Close(archivo);
  end;

	procedure listarEnQuinto(var archivo:archivo_bin; var texto:Text);
  var
    reg:registro;
  begin
  	Assign(archivo, 'alumnos.bat');
    Assign(texto, 'alumnosAEgresar.txt');
    Reset(archivo);
    Rewrite(texto);

    if not(eof(archivo)) then
      begin
        repeat
        	Read(archivo, reg);
          if (reg.anio = 5) then
            With Reg do
            begin
            	WriteLn(texto, DNI, legajo, nombre);
              WriteLn(texto, apellido);
              WriteLn(texto, anio, nacimiento, direccion);
            end;
        until eof(archivo);
      end;

    Close(archivo);
    Close(texto);
  end;

  procedure agregarAlumnos(var archivo:archivo_bin);
  var
    reg:registro;
  begin
  	Assign(archivo, 'alumnos.bat');
    Reset(archivo);
    Seek(archivo, FileSize(archivo));
    //como no se aclara asumo que se deja de ingresar alumnos cuando
    //se ingrese un nombre = 'zzz'
    leerRegistro(reg);

    while not(reg.nombre = 'zzz')do
    begin
     	Write(archivo, reg);
      leerRegistro(reg);
    end;

    Close(archivo);
  end;

	procedure modificarFecha(var archivo:archivo_bin);
  var
    reg:registro;
    fecha:longInt;  //fecha modificada
    leg:integer; //legajo a buscar
  begin
    Assign(archivo, 'alumnos.bat');
    Reset(archivo);

    if not(eof(archivo)) then
      begin
        Write('Legajo a buscar: ');ReadLn(leg);

        repeat
        	Read(archivo, reg);
          With reg do
          begin
            if ( legajo = leg ) then
              begin
              	nacimiento:=fecha;
                Seek(archivo, FilePos(archivo) - 1);
                Write(archivo, reg);
              end;
          end;
        until (eof(archivo) or (reg.legajo = leg));
      end;

    Close(archivo);
  end;

begin
end.


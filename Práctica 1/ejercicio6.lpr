program ejercicio6;
Type

  registro=Record
    ISBN:integer;
		titulo:String[255];
    genero:String[255];
		editorial:String[255];
    anio:integer;
  end;

  archivo_bin = File of registro;

var

  archivo:archivo_bin;
  texto:Text;

  procedure leerRegistro(var reg:registro);
  begin
    With reg do
	  begin
      Write('ISBN: ');ReadLn(ISBN);
      Write('Título: ');ReadLn(titulo);
      Write('Género: ');ReadLn(genero);
      Write('Editorial: ');ReadLn(editorial);
      Write('Año de lanzamiento: ');ReadLn(anio);
    end;
  end;


  procedure crearBinario(var archivo:archivo_bin; var texto:Text);
  var
    reg:registro;
	begin
    Assign(archivo, 'libros.bat');
    Assign(texto, 'libros.txt');
    Reset(texto);
    Rewrite(archivo);

    if not(eof(texto)) then
    	repeat
        With reg do
				begin
          ReadLn(texto, ISBN, titulo);
          ReadLn(texto, anio, editorial);
          ReadLn(texto, genero);
          Write(archivo, reg);
        end;
      until eof(texto);


    Close(archivo);
    Close(texto);
  end;

	procedure modificarArchivo(var archivo:archivo_bin);
  var
    reg:registro;
    opc:integer;
    isbn_mod:integer;
  begin


    Write('Ingrese 1 si desea agregar un libro, o 2 si desea modificar uno existente: ');ReadLn(opc);
    if(opc = 1) then
      begin
        Assign(archivo, 'libros.bat');
    		Reset(archivo);
      	leerRegistro(reg);
        seek(archivo, FileSize(archivo));
        Close(archivo);
      end
    else
    	if(opc = 2) then
        begin
          if not(eof(archivo)) then
            begin
              Assign(archivo, 'libros.bat');
          		Reset(archivo);
              With reg do
              begin
              	Write('Ingrese el ISBN del libro a modificar: ');ReadLn(isbn_mod);
                repeat
                	Read(archivo, reg);
                  if(ISBN = isbn_mod) then
                    begin
                      //es molesto tener que modificar todo el registro
                    	//pero bueno
                      leerRegistro(reg);
                      Seek(archivo, FilePos(archivo) - 1);
                      Write(archivo, reg);
                    end;
                until (eof(archivo) or (isbn_mod = ISBN));
              end;
              Close(archivo);
            end;
        end else WriteLn('Opción no disponible. Cerrando programa');



  end;

begin



end.


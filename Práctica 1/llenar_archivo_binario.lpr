program llenar_archivo_binario;

//Usar este programa para llenar los archivos binarios que necesite

Type

  registro = Record
    //llenar con los datos necesarios
  end;

  archivo = File of integer;

  {
  Descomentar el que se necesite
  O cortarlo y copiarlo afuera del bloque comentario


  archivo = File of String[255];

  archivo = File of char;

  archivo = File of double;

  archivo = File of registro;

  }

  cadena=String[255];
var

  binario:archivo;
  str:cadena;
  car:char;
  dou:double;
  int:integer;
  reg:registro;
  by:byte;

  procedure usandoUntil(var binario:archivo; cond, by:byte);
  begin

    repeat

    until (by = cond);

  end;

	procedure usandoWhile(var binario:archivo; cond, by:byte);
  begin

  end;

begin

  //Acá le cambian el nombre al que ustedes quieran
  Assign(binario, 'votantes.bat');
  Rewrite(binario);

  //Misma lógica que con los tipos declarados
  Write('Ingrese un dato: ');ReadLn(int);
  while ( int <> -1 ) do
	begin
     Write(binario, int);
     Write('Ingrese un dato: ');ReadLn(int);
  end;
  {

  Write('Ingrese un dato: ');ReadLn(str);
  while ( str <> 'zzz' ) do
  begin
  	Write(binario, str);
  	Write('Ingrese un dato: ');ReadLn(str);
  end;

  Write('Ingrese un dato: ');ReadLn(car);
  while ( car <> '<' ) do
  begin
  	Write(binario, car);
    Write('Ingrese un dato: ');ReadLn(car);
  end;

  Write('Ingrese un dato: ');ReadLn(dou);
  while ( dou <> -1.0 ) do
  begin
	  Write(binario, dou);
  	Write('Ingrese un dato: ');ReadLn(dou);
  end;
  }

  {
  repeat
           Write('Ingrese un dato: ');ReadLn(int);
                Write(binario, int);
  until ( int = -1 );

  repeat
            Write('Ingrese un dato: ');ReadLn(str);
                 Write(binario, str);
  until ( str = 'zzz' );

  repeat
            Write('Ingrese un dato: ');ReadLn(car);
                 Write(binario, car);
  until ( car = '<' );

  repeat
           Write('Ingrese un dato: ');ReadLn(dou);
                Write(binario, dou);
  until ( dou = -1.0 );
  }

  Close(binario);
end.


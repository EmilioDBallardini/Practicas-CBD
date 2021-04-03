program ejercicio3;

Type

 var_in=String[255];

var

  archivo:Text;
  entrada:var_in;


begin

  Assign(archivo, 'dinosaurios.txt');
  Rewrite(archivo);

  Write('Ingrese un tipo de dinosaurio: ');ReadLn(entrada);

  while not ( entrada = 'zzz' ) do
  begin
		  WriteLn(archivo, entrada);
      Write('Ingrese un tipo de dinosaurio: ');ReadLn(entrada);
  end;


	close(archivo);


  end.


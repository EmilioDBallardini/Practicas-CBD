program ejercicio4;

Type

  archivo_in = File of integer;

var

  archivo_out : Text;
  aux:integer;
  entrada:archivo_in;


  procedure pasarTextoBinario(var binario:archivo_in; var texto:Text);
  var
    aux:integer;
  begin

  repeat
  	Read(entrada, aux);
    WriteLn('Pasando dato: ', aux);
    WriteLn(archivo_out, aux);
  until (eof (entrada));

  ReadLn();
  end;

begin

  Assign(entrada, 'votantes.bat');
  Assign(archivo_out, 'votantes_out.txt');
  Reset(entrada);
  Rewrite(archivo_out);


  Close(entrada);
  Close(archivo_out);

end.


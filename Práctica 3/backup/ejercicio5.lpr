program ejercicio5;

Type

  registro=Record
    nro_articulo:integer;
    desc:String[255];
    color:String[255];
    talle:integer;
    stock:integer;
    precio:real;
  end;

  archivo_reg=File of registro;

  //para realizar la baja lógica, marco los stocks de los productos en negativo
  //si el stock es 0, le asigno -1
  //se deja de tomar códigos cuando se ingrese el valor 0
  //asumo una baja lógica sin lista invertida ya que no se especifica
  procedure actualizarYGenerar(var binario:archivo_reg; var texto:Text);
  var
    reg:registro;
    cod_b:integer;
  begin
    Reset(binario);
		Rewrite(texto);

    Write('Ingrese el código a buscar y eliminar: ');ReadLn(cod_b); //leo el código a buscar
    while not(cod_b = 0) do
    begin
      Read(binario, reg);
      while not(eof(binario) and (cod_b <> reg.nro_articulo))do //mientras no lo encuentre sigo buscando
      begin
      	Read(binario, reg);
      end;
      if (cod_b = reg.nro_articulo)then //si lo encontré
      begin
      	Seek(binario, FilePos(binario) - 1);  //vuelvo a la posición anterior
        With reg do
        begin
          //escribo en el archivo de texto
          Write(texto, nro_articulo, stock, talle, precio, color);
          Write(texto, desc);
        end;
        reg.stock:=reg.stock * (-1);      //modifico el stock para marcarlo como libre
        Write(binario, reg);  //lo escribo
      end
      else  //si no encontré el código, aviso que no existe y vuelvo al inicio
      begin
      	WriteLn();
				WriteLn('El codigo de articulo no existe...');
				Write('Ingrese cualquier tecla para continuar'); ReadLn();
      end;
      Seek(binario, 0);
      Write('Ingrese el código a buscar y eliminar: ');ReadLn(cod_b);
    end;
    Close(texto);
    Close(binario);
  end;

var

  binario:archivo_reg;
  texto:Text;


begin
  Assign(binario, 'indumentariaDeportiva.bat');
  Assign(texto, 'indumentariaDeportiva.txt');
  actualizarYGenerar(binario, texto);
end.


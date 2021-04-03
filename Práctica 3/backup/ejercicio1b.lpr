program ejercicio1b;

Type

  registro= Record
    codigo:integer;
    n_vulgar:String[255];
    n_cient:String[255];
    alt_prom: real;
    desc:String[255];
    zona:String[255];
  end;

  archivo_reg = File of registro;


 var

 	 ant, cod_b, cod_in: integer;
   reg, aux, ult: registro;
   nuevo, binario:archivo_reg;
   o, cl: Byte;
   nLibre, cod: Word;
   sLibre: registro;



begin
	Assign(binario, 'plantas.bat');
  Assign(nuevo, 'plantas_Nuevo.bat');
  Reset(binario);
  Rewrite(nuevo);

  //leo el caracter a borrar
  Write('Ingrese el código a buscar: '); ReadLn(cod_in);
  while (cod_in <> 10000) do
	begin
    Read(binario, reg);
    While((cod_in <> reg.codigo) and (not(eof(binario))))do
    begin
    	Read(binario, aux);
		end;

    //marco el registro cambiandole el código
    if (reg.codigo = cod_in) then
    begin

      nLibre := FilePos(binario) - 1;
      Seek(binario, FileSize(binario) - 1;
      Read(binario, aux);
      Seek(binario, nLibre);
      Write(binario, aux);
      Seek(binario, FileSize(binario) - 1;
      Truncate(binario);
    end
    else
    begin
      WriteLn(); WriteLn('No existe esa especie');
      Write('Oprima Enter para continuar...');ReadLn();
      Seek(binario, 0);
    end;

	  Write('Ingrese el código a buscar: '); ReadLn(cod_in);
		//leo el codigo del archivo
    //mientras sea distinto y no esté en el eof recorro
    //cuando salgo pregunto si encontré el código
    //Sino es que no existe
  end;

  Close(archivo);


end.


program Ej4;
uses
  Crt, Sysutils;
const
     valorAlto = 9999;
type

    maestroReg = Record
     codigo: integer;
     cantPers: integer;
     genero: string[255];
     director: string[255];
     nombre: string[255];
    end;

    cine = Record
     codigo: integer;
     fecha: integer;
     cantPers: integer;
     genero: string[255];
     director: string[255];
     nombre: string[255];
    end;

	archMaestro = File of maestroReg;
	archDetalle = File of cine;
  arrDetalle = array[1..10] of archDetalle;
  arrCine = array[1..10] of cine;

  procedure cineAMestro(cineMin: cine; var axi: maestroReg);
  begin
     axi.codigo:= cineMin.codigo;
     axi.cantPers:= cineMin.cantPers;
     axi.genero:= cineMin.genero;
     axi.director:= cineMin.director;
     axi.nombre:= cineMin.nombre;
  end;


  procedure leer(var arch:archDetalle;var reg: cine);
  begin
     if(not eof(arch))
     then
            read(arch,reg)
     else
         reg.codigo := valorAlto;
  end;


  procedure minimoYactualizaDetalle(var registrosMin: arrCine;var cineCodMin : cine; var detalle:arrDetalle );
  var
     i, axi: integer;
  begin
     axi := 1;
     cineCodMin := registrosMin[1];
     for i:=2 to 10 do
     begin
         if (registrosMin[i].codigo < cineCodMin.codigo)then         //si encuentro uno mas chico lo cambio y me guardo el archivo
         begin
              axi := i;
              cineCodMin := registrosMin[i];
         end
     end;
     leer(detalle[axi], registrosMin[axi]);//actualizo registro del vector con un nuevo registro
  end;

procedure actulizarMaestro(ruta: string; var detalle: arrDetalle);
var axi: maestroReg;
    cineMin: cine;
    registrosMin: array[1..10] of cine;
    i:integer;
    maestro: archMaestro;

begin
     assign(maestro, ruta);
     rewrite(maestro);

     for i:=1 to 10 do
     begin
          reset(detalle[i]);
          leer(detalle[i],registrosMin[i]);
     end;
     WriteLn('Llego: 0');

     minimoYactualizaDetalle(registrosMin, cineMin, detalle);

     while(cineMin.codigo<valorAlto)do
     begin
           WriteLn('Llego: 1');
           cineAMestro(cineMin,axi);
           axi.cantPers := 0;
           while(axi.codigo = cineMin.codigo)do  //si son el mismo zapato (cod y num)
           begin
               WriteLn('Llego: 2');
                axi.cantPers:= cineMin.cantPers + axi.cantPers;
                minimoYactualizaDetalle(registrosMin, cineMin, detalle);
           end;
           //cambio de codigo o sequedo sin pelis
           write(maestro, axi);  //lo escribo en el archivo maestro
           writeln('codigo: ', axi.codigo,' cantPers: ', axi.cantPers);
     end;
          //solo actualizo el archivo si cambio el stock es decir que si no vendi nada no tengo que actualizar el maestro

     close(maestro);
end;


procedure cargarDetalle(var detalle: arrDetalle);
var i: integer;
    axi: cine;
begin
     for i:= 1 to 10 do
     begin
          rewrite(detalle[i]);
          axi.codigo := i;
          axi.cantPers := 2*i;
          write(detalle[i],axi);
          writeln('codigo: ', axi.codigo,' cantPers: ', axi.cantPers);
          readkey();
     end;
     readkey();
     for i:= 1 to 10   do
         close(detalle[i]);
     readln();
end;


var
   detalle: array[1..10] of archDetalle;
   ruta: string;
   axi: cine;
   i: integer;
begin
     for i:= 1 to 10
         do begin
            assign (detalle[i],concat('detCine',IntToStr(i)));
         end;

     cargarDetalle(detalle);

     writeln('ruta del archivo: ');
     readln(ruta);



     writeln('maestro: ');

     actulizarMaestro(ruta,detalle);

     writeln('Final');
     readkey();




end.

program ejercicio1;

Type

  regBin=Record
    nombre:String[255];
    end;

  materiales = File of regBin;

  materiales_str = File of String[255];

var

  aux:materiales;
  nombre_arch, nombre:String;
  arch_mate:materiales_str;

begin
  Write('Nombre del archivos de materiales: '); ReadLn(nombre_arch);
  Assign(aux, nombre_arch);
  Assign(arch_mate, nombre_arch);
  Rewrite(arch_mate);

  repeat
    Write('Ingrese nombre del material: '); ReadLn(nombre);
    Write(arch_mate, nombre);
  until (nombre = 'cemento');

  ReadLn();
  close(aux);
end.


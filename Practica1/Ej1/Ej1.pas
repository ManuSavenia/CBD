type

    archMateriales= text;
var
    archivo:archMateriales;
    nombre:string;
    material:string;
begin
    writeln('Ingrese el nombre del archivo a crear');
    readln(nombre);
    assign(archivo,nombre);
    rewrite(archivo);
    material:='';
    while (material<>'cemento') do begin
        writeln('Ingrese el material');
        readln(material);
        writeln(archivo,material);
    end;
    close(archivo);
end.
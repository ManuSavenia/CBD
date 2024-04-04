type
    Planta = record
        codigoEspecie: integer;
        nvulgar: string;
        ncientifico: string;
        alturaProm: real;
        descripcion: String;
        zona: string;
    end;

    archivoPlantas = file of Planta;
var
    plantaAborrar: integer;
    Plantas: archivoPlantas;
    planta: Planta;
    posAborrar: integer;
begin
    assign(Plantas, 'plantas.data');
    reset(Plantas);
    writeln('Ingrese el codigo de la planta a borrar: ');
    readln(plantaAborrar);
    while (plantaAborrar <> 100000) do
    begin
        seek(Plantas, 0);
        while (not eof(Plantas)) do
        begin
            read(Plantas, planta);
            if (planta.codigoEspecie = plantaAborrar) then
            begin
                read(Plantas, planta);
                planta.codigoEspecie := 0;
                seek(Plantas, filepos(Plantas) - 1);
                write(Plantas, planta);
            end;
        end;
        writeln('Ingrese el codigo de la planta a borrar: ');
        readln(plantaAborrar);
    end;
    seek(Plantas, 0);
    while (not eof(Plantas)) do
    begin
        read(Plantas, planta);
        if (planta.codigoEspecie = 0) then
        begin
            posAborrar := filepos(Plantas);
            seek(Plantas, filesize(Plantas) - 1);
            read(Plantas, planta);
            seek(Plantas, posAborrar - 1);
            write(Plantas, planta);
            truncate(Plantas);
        end;
        end;
    end;
end.
//esta es la solucion b, para el A creas un archivo temporal y vas copiando los datos que no queres borrar
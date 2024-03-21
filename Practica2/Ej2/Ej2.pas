const
    valoralto = '9999';
type
    informacion = record
        codigoAutor: String;
        nombreAutor: String;
        nombreDisco: String;
        genero: String;
        cantidadVendida: Integer;
    end;
    archivo = file of informacion;
var
    discografia: archivo;
    reg: informacion;
    t_autor, t_discografia, t_genero: integer;
    act_autor, act_genero: string;
    texto: text;
    
    procedure leer (var arch: archivo; var dato:informacion);
    begin
        if (not eof( arch ))then 
            read (arch,dato)
        else 
            dato.codigoAutor := valoralto;
        
    end;

    {procedure createFile(var cd_file: archivo);
var
    i: integer;
    cd: informacion;
begin
    Assign(cd_file, 'discografia.dat');
    Rewrite(cd_file);

    for i := 1 to 3 do
    begin
        WriteLn('Enter details for CD ', i, ':');
        Write('Author code: '); ReadLn(cd.codigoAutor);
        Write('Author name: '); ReadLn(cd.nombreAutor);
        Write('Disk name: '); ReadLn(cd.nombreDisco);
        Write('Genre: '); ReadLn(cd.genero);
        Write('Amount sold: '); ReadLn(cd.cantidadVendida);

        WriteLn;
        Write(cd_file, cd);
    end;

    Close(cd_file);
end;}


begin
    {createFile(discografia);}
    assign(discografia, 'discografia.dat');
    reset(discografia);
    leer(discografia,reg);
    assign(texto, 'discografia.txt');
    rewrite(texto);
    t_autor := 0;
    t_discografia := 0;
    t_genero := 0;
    while(reg.codigoAutor <> valoralto) do begin
        act_autor := reg.codigoAutor;
        writeln('Autor: ', reg.nombreAutor);
        while(act_autor = reg.codigoAutor) and (reg.codigoAutor <> valoralto) do begin
            act_genero := reg.genero;
            writeln('Genero: ', reg.genero);
            while(act_genero = reg.genero) and (reg.codigoAutor <> valoralto) and (act_autor = reg.codigoAutor)  do begin
                t_genero := t_genero + reg.cantidadVendida;
                writeln('Disco: ', reg.nombreDisco, ' Cantidad vendida: ', reg.cantidadVendida);
                writeln(texto, reg.nombreDisco, ' ',reg.nombreAutor,' ', reg.cantidadVendida);
                leer(discografia,reg);
            end;
            t_autor := t_autor + t_genero;
            writeln('Total genero: ', t_genero);
            writeln;
            t_genero := 0;
        end;
        t_discografia := t_discografia + t_autor;
        writeln('Total autor: ', t_autor);
        writeln;
        writeln;
        WriteLn;
        t_autor := 0;
    end;
    writeln('Total discografia: ', t_discografia);
    close(discografia);
    close(texto);
end.
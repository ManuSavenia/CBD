const
    n = 20;
    valoralto = 'ZZZZ';
type
    informacion = record
        codigoPelicula: String;
        nombrePelicula: String;
        generoPelicula: String;
        directorPelicula: String;
        duracionPelicula: Integer;
        fecha: String;
        cantAsistentes: Integer;
    end;
    cine:informacion;
var
    cines:array[1..n] of cine;
    merge:cine;
    regD: array[1..n] of informacion;
    regm: informacion;
    min:informacion;
    i:integer;
    aux: string;

    procedure leer (var archivo:cine; var dato:informacion);
    begin
        if (not eof( archivo ))
        then read (archivo, dato)
        else dato.codigoPelicula := valoralto;
    end;

    procedure minimo (var reg_deta: regD; var min:informacion; var deta:cine);
        var
            indice_min: integer;
            aux: informacion;
        begin
        aux.codigoPelicula := valoralto;
        {recorrer el arreglo de registros reg_deta determinando el elemento MINIMO. En la
        variable indice_min guardar la POSICION del elemento mínimo}
        for (i:=1 to n) do begin
            if (reg_deta[i].codigoPelicula <> valoralto) then begin
                if (reg_deta[i].codigoPelicula < aux.cod) then begin
                    aux := reg_deta[i];
                    indice_min := i;
                end;
        end;
        {guardar minimo}
        min = reg_deta[indice_min];
        {leer nuevo elemento del archivo correspondiente}
        leer(deta[indice_min], reg_deta[indice_min]);
    end;



    procedure mergear(var cines:array of informacion;var ruta:string);
    begin
        assign(merge,ruta);
        rewrite(merge);
        minimo(regD,min,cines);
        while (min.codigoPelicula <> valoralto) do {se procesan los archivos de detalles}
        begin
            aux := min.codigoPelicula;
            regm.codigoPelicula := min.codigoPelicula; {valor para registro del archivo merged}
            regm.cantAsistentes := 0;
            while (aux = min.codigoPelicula ) do {se procesan los registros de una misma pelicula}
            begin
                regm.cantAsistentes := regm.cantAsistentes + min.cantAsistentes;
                minimo (regD,min,cines);
            end;
            write(merge, regm); {se guarda el registro en el archivo maestro}
        end;
        close(merge);
    end;

begin
    for i:=1 to n do
    begin
    assign(cines[i],'cine', i, '.dat');
    reset(cines[i]);
    leer(cines[i],regD[i]);
    end;
    mergear(cines,'/home/manuel/Documentos/Practica 2/merge.dat');
    for i:=1 to n do
    begin
    close(cines[i]);
    end;
end.
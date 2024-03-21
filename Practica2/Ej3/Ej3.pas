const
    valoralto = '9999';
type
    calzadoD = record
        codigoCalzado : string;
        numero : integer;
        cantidadVendida : integer;
    end;
    calzadoM = record
        codigoCalzado : string;
        numero : integer;
        descripcion : string;
        precio : integer;
        color : string;
        stock : integer;
    
    end;
    archivoD = file of calzadoD;
    archivoM = file of calzadoM;

var
    detalle: array[1..20] of archivoD;
    mae: archivoM;
    regN: array[1..20] of calzadoD;

    procedure leer (var arch: ; var dato:informacion);
    begin
        if (not eof( arch ))then 
            read (arch,dato)
        else 
            dato.codigoAutor := valoralto;
        
    end;

    procedure minimo (var reg_deta: regN; var min:calzadoD; var deta:detalle);
        var
            indice_min: integer;
            aux: calzadoD;
        begin
        aux.codigoCalzado := valoralto;
        aux.numero := 9999;
        {recorrer el arreglo de registros reg_deta determinando el elemento MINIMO. En la
        variable indice_min guardar la POSICION del elemento mínimo}
        for (i:=1 to 20) do begin
            if (reg_deta[i].codigoCalzado <> valoralto) then begin
                if (reg_deta[i].cod <= aux.codigoCalzado) then begin
                    if (reg_deta[i].numero < aux.numero) then begin
                        aux := reg_deta[i];
                        indice_min := i;
                    end;
                end;
            end;
        end;
        {guardar minimo}
        min = reg_deta[indice_min];
        {leer nuevo elemento del archivo correspondiente}
        leer(deta[indice_min], reg_deta[indice_min]);
    end;


begin
for i:=1 to 20 do begin
        assign(detalle[i], 'calzado'+i);
        reset(detalle[i]);
        leer(detalle[i], regDet[i]);
    end;
    assign(mae, 'maestro');
    reset(mae);
    leer(mae, regMae);
    while (regMae.codigo <> valoralto) do begin
        minimo(regDet, min, detalle);
        {recorrer el arreglo de registros reg_deta determinando el elemento MINIMO}
        while (regMae.codigoCalzado<> min.codigoCalzado) and (regMae.numero <> min.numero)do begin
            leer(mae, regMae);
        end;
        {Recorrer el archivo maestro hasta encontrar el calzado cuyo código y numero es igual al código del registro leído en el archivo detalle}
        if (regMae.stock >= min.cantidadVendida) then 
            regMae.stock := regMae.stock - min.cantidadVendida
        else
            writeln('no hay stock flaco');{me da paja hacer el archivo de texto}
        seek(mae, filepos(mae)-1);
        write(mae, regMae);
    end;
    for i:=1 to 20 do begin
        close(detalle[i]);
    end;
    close(mae);
    for i:=1 to 20 do begin
        close(detalle[i]);
    end;
end.
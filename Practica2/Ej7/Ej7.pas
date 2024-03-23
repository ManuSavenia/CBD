const
    n = 10;
    valoralto = 'ZZZZ';
type
    maestro=record
        codigoProducto:string;
        nombreComercial:string;
        descripcion:string;
        precioVenta:real;
        stockActual:integer;
        strockMinimo:integer;
    end;

    detalle=record
        codigoProducto:string;
        cantidadVendidas:integer;
    end;

    mae = file of maestro;
    det = file of detalle;
    maeText:text;
     
var
    regm = maestro;
    maeCambiado = mae;
    detN = array[1..n] of det;
    regD = array [1..n] of detalle;
    min = detalle; 
    i:integer;
    maeOriginal = maeText;
    regText: string;

    procedure leer(var archivo:det; var reg:detalle);
    begin
        if not eof(archivo) then
            read(archivo,reg)
        else
            reg.codigoProducto:=valoralto;
    end;    

    procedure minimo (var reg_deta: regD; var min:detalle; var deta:detN);
        var
            indice_min: integer;
            aux: detalle;
        begin
        aux.codigoProducto := valoralto;
        {recorrer el arreglo de registros reg_deta determinando el elemento MINIMO. En la
        variable indice_min guardar la POSICION del elemento mínimo}
        for (i:=1 to n) do begin
            if (reg_deta[i].codigoProducto <> valoralto) then begin
                if (reg_deta[i].codigoProducto < aux.codigoProducto) then begin
                    aux := reg_deta[i];
                    indice_min := i;
                    leer(deta[i], reg_deta[i]);
                end;
        end;
        {guardar minimo}
        min = reg_deta[indice_min];
        {leer nuevo elemento del archivo correspondiente}
        leer(deta[indice_min], reg_deta[indice_min]);
    end;
    
    procedure traducirMaestro(var maeCambiado:mae; var maeOriginal:maeText; var regText:string; var regm:maestro);
    var
        i:integer;
    begin
        while (not eof(maeOriginal)) do begin
            readln(maeOriginal,regText);
            regm.codigoProducto:=regText;
            readln(maeOriginal,regText);
            regm.nombreComercial:=regText;
            readln(maeOriginal,regText);
            regm.descripcion:=regText;
            readln(maeOriginal,regText);
            val(regText,regm.precioVenta);
            readln(maeOriginal,regText);
            val(regText,regm.stockActual);
            readln(maeOriginal,regText);
            val(regText,regm.strockMinimo);
        end;
    end.


    procedure actualizarMaestro(var maeCambiado:mae; var regm:maestro; var detN:det; var regD:detalle; var min:detalle);
    var
        i:integer;
    begin
        minimo(regD,min,detN);
        while (min.codigoProducto <> valoralto) do begin
            while (regm.codigoProducto < min.codigoProducto) do begin
                read(maeCambiado,regm);
            end;
            if (regm.codigoProducto = min.codigoProducto) then begin
                regm.stockActual := regm.stockActual - min.cantidadVendidas;
                seek(maeCambiado,filepos(maeCambiado)-1);
                write(maeCambiado,regm);
                minimo(regD,min,detN);
            end;
        end;
    
    end;

begin
    for i := 1 to n do
    begin
        assign(detN[i],'detalle'+intToStr(i)+'.dat');
        rewrite(detN[i]);
        leer(detN[i],regD[i]);
    end;
    assign(maeOriginal,'productos.txt');
    reset(maeOriginal);
    assign(maeCambiado,'productos.dat');
    rewrite(maeCambiado);
    traducirMaestro(maeCambiado,maeOriginal,regText,regm);
    actualizarMaestro(maeCambiado,regm,detN,regD,min);
    close(maeCambiado);
    close(maeOriginal);
    for i := 1 to n do
    begin
        close(detN[i]);
    end;
end.
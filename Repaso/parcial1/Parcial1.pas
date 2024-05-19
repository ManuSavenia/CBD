Program Parcial1;
const
valor_alto = 9999;
Type
    
    producto=record
        cod_producto:integer;
        nombre:string;
        descripcion:string;
        stock:integer;
    end;
    archivoB = file of producto;


    procedure leer(var original:text;var reg:producto);
    begin
        if(not eof(original)) then begin 
            readln(original,reg.cod_producto);
            readln(original,reg.nombre);
            readln(original,reg.descripcion);
            readln(original,reg.stock);
        end
        else
            reg.cod_producto:= valor_alto;
    end;


    procedure Traducir(var traducido:archivoB;var original:text);
    var
        reg:producto;
    begin
        rewrite(traducido);
        reset(original);
        reg.cod_producto:=-1;
        reg.descripcion:='@';
        write(traducido,reg);
        leer(original,reg);
        while(reg.cod_producto <> valor_alto) do 
        begin
            write(traducido,reg);
            leer(original,reg);
        end;
        close(original);
        close(traducido);
    end;
    

    procedure eliminar(var cod_e:integer;var traducido:archivoB);
    var
        nlibre:integer;
        aux,cabecera:producto;
    begin
        reset(traducido);
        read(traducido,cabecera); {leo la cabecera}
        aux.cod_producto:=-1;
        while(not((aux.cod_producto = cod_e) or (eof(traducido))))do {busco el producto hasta encontrarlo o llegar al final del archivo} 
            read(traducido,aux);
        if(aux.cod_producto=cod_e) then {si encontre el producto}
        begin
            nlibre:=Filepos(traducido) -1;{me guardo la posicion borrada}
            seek(traducido,nlibre);write(traducido,cabecera);{escribo la cabecera en la posicion eliminada}
            aux.cod_producto:=nlibre;
            aux.descripcion:='@';
            seek(traducido,0);write(traducido,aux);{actualizo la cabecera}
        end
        else 
            write('no se encuentra el codigo a borrar');

        close(traducido);
    end;
var
    traducido:archivoB;
    original:text;
    prod: producto;
    cod_e:integer;
begin
    assign(original,'productos.txt');
    assign(traducido,'productosB.bin');
    Traducir(traducido,original);
    writeln('inserte el codigo a eliminar. -1 para terminar: ');
    readln(cod_e);

    while(cod_e <> -1) do begin
        eliminar(cod_e,traducido);
        writeln('inserte el codigo a eliminar. -1 para terminar: ');
        readln(cod_e);
    end;

    reset(traducido);
    while(not eof(traducido))do begin
        read(traducido, prod);
        writeln('Codigo: ', prod.cod_producto);
        writeln('Nombre: ', prod.nombre);
        writeln('Descripcion: ', prod.descripcion);
        writeln('Stock: ', prod.stock);
    end;
    Close(traducido);
end.
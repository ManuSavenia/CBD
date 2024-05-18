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
            writeln('nashe3');
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
        read(traducido,cabecera);
        aux.cod_producto:=-1;
        while (aux.cod_producto <> cod_e) or (not Eof(traducido)) do read(traducido,aux);
        if(aux.cod_producto=cod_e) then
        begin
            nlibre:=Filepos(traducido) -1;
            seek(traducido,nlibre);
            write(traducido,cabecera);
            seek(traducido,0);
            aux.cod_producto:=nlibre;
            aux.descripcion:='@';
            write(traducido,aux);
        end
        else 
            write('no se encuentra el codigo a borrar');

        close(traducido);
    end;
var
    traducido:archivoB;
    original:text;
    
    cod_e:integer;
begin
    writeln('nashe1');
    assign(original,'productos.txt');
    assign(traducido,'productosB.bin');
    writeln('nashe2');
    Traducir(traducido,original);
    write('inserte el codigo a eliminar. -1 para terminar');
    readln(cod_e);

    while(cod_e <> -1) do begin
        eliminar(cod_e,traducido);
        write('inserte el codigo a eliminar. -1 para terminar');
        readln(cod_e);
    end;
    close(original);
    close(traducido);
end.
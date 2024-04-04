type
    Articulos = record
        numeroArticulo: integer;
        descripcion: string;
        color: string;
        talle: string;
        stockDisponible: integer;
        precio: integer;
    end;
    archivoArticulos = file of Articulos;
    TXT = text;
var
    numeroArticuloAeliminar: integer;

    procedure eliminarArticulos(var archivo: archivoArticulos);
    var
        articulo: Articulos;
        archivoTXT: TXT;
    begin
        readln(numeroArticuloAeliminar);
        reset(archivo);
        reset(archivoTXT, 'articulos.txt');
        while(numeroArticuloAeliminar <> -1) do
        begin
            articulo.numeroArticulo := -1;
            while(numeroArticuloAeliminar <> articulo.numeroArticulo ) do
                read(archivo, articulo);
            end;
            if(articulo.numeroArticulo = numeroArticuloAeliminar) then begin
                write(archivoTXT, articulo.numeroArticulo, articulo.descripcion, articulo.color, articulo.talle, articulo.stockDisponible, articulo.precio);
                articulo.color := '$';
                seek(archivo, filePos(archivo) - 1);
                write(archivo, articulo);
            else
                writeln('El articulo no existe');
            readln(numeroArticuloAeliminar);
        end;
    end;
begin
    eliminarArticulos(archivo);
end.

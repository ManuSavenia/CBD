Program ej1;
const
    valor_alto = 9999;
type
    str30 = string[30];
    producto_type = record 
        codigo: integer;
        nombre: str30;
        descripcion: str30;
        stock: integer;
    end;

    maestro_type = file of producto_type;


procedure leer(var archivo: text; var prod: producto_type);
begin
    if(not eof(archivo))then begin
        readln(archivo, prod.codigo);
        readln(archivo, prod.nombre);
        readln(archivo, prod.descripcion);
        readln(archivo, prod.stock);
    end
    else
        prod.codigo := valor_alto;

end;

procedure text_a_bin(var texto: text; var maestro: maestro_type);
var
    prod: producto_type;
begin
    reset(texto); rewrite(maestro);
    prod.stock := -1;    //Marca de que no se utiliza
    prod.codigo := -1;   //Dir. al siguiente borrado

    Write(maestro, prod);  
    leer(texto, prod);

    {Supongo que el archivo de texto tiene un campo por linea}
    while(prod.codigo <> valor_alto)do begin
        write(maestro, prod);
        leer(texto, prod);
    end;

    close(texto); close(maestro);
end;


procedure eliminar_reutilizando(var maestro: maestro_type; var codigo_elim: integer);
var
    prod, prod_act: producto_type;
    NLibre: integer;
begin
    reset(maestro);
    read(maestro, prod);
    // prod.codigo tiene el sig. en la lista de borrados
    prod_act.codigo := -1;
    while(not((codigo_elim = prod_act.codigo) or (eof(maestro))))do
        read(maestro, prod_act);

    if(codigo_elim = prod_act.codigo)then begin
        NLibre := FilePos(maestro)-1;
        seek(maestro, NLibre); write(maestro, prod);
        prod_act.stock := -1;
        prod_act.codigo := NLibre;
        seek(maestro, 0); write(maestro, prod_act);
    end;
    close(maestro);
end;


var
    maestro: maestro_type;
    prod: producto_type;
    texto: text;
    codigo: integer;

begin
    Assign(texto, 'productos.txt');
    Assign(maestro, 'productos.dat');

    text_a_bin(texto, maestro);


    writeln('Ingrese el codigo del producto a eliminar (-1 para finalizar): ');
    readln(codigo);
    while(codigo <> -1)do begin
        eliminar_reutilizando(maestro, codigo);
        writeln('Ingrese el codigo del producto a eliminar (-1 para finalizar): ');
        readln(codigo);
    end;

    reset(maestro);
    while(not eof(maestro))do begin
        read(maestro, prod);
        writeln('Codigo: ', prod.codigo);
        writeln('Nombre: ', prod.nombre);
        writeln('Descripcion: ', prod.descripcion);
        writeln('Stock: ', prod.stock);
    end;
    Close(maestro);
end.
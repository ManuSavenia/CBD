type
archVotos=file of integer;
var
Votos:archVotos;
nombre:string;
numero:integer;
numeroMax:integer;
numeroMin:integer;
begin
    numeroMax:=0;
    numero:=0;
    numeroMin:=9999;
    writeln('Ingrese el nombre del archivo a buscar');
    readln(nombre);
    assign(Votos,nombre);
    rewrite(Votos);
    while numero <> -1 do
    begin
        writeln('Ingrese el numero de votos');
        readln(numero);
        if numero <> -1 then
        begin
            write(Votos,numero);
        end;
    end;
    close(Votos);
    reset(Votos);
    while not eof(Votos) do
    begin
        read(Votos,numero);
        if numero>numeroMax then
        begin
            numeroMax:=numero;
        end;
        if numero<numeroMin then
        begin
            numeroMin:=numero;
        end;
        writeln(numero);
    end;
    writeln('El numero maximo es: ',numeroMax);
    writeln('El numero minimo es: ',numeroMin);
    close(Votos);
end.
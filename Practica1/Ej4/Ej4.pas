type
Numeros = file of integer;
archivo = text;
var
numero:integer;
datos:Numeros;
texto:archivo;
begin
    assign(datos,'votos');
    assign(texto,'votos.txt');
    reset(datos);
    rewrite(texto);
    while not eof(datos) do
    begin
        read(datos,numero);
        writeln(texto,numero);
    end;
    close(datos);
    close(texto);
end.
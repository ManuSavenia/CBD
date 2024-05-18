Program Parcial2;
const
    valor_alto = 9999;
type
    excursion=record
        codigo:integer;
        nombre:string;
        descripcion:string;
        cantvendida:integer;
    end;
    archivoB= file of excursion;


    procedure leer(var archivo:text;var reg:excursion);
    begin
        if(not eof(archivo)) then begin
            readln(archivo,reg.codigo);
            readln(archivo,reg.nombre);
            readln(archivo,reg.descripcion);
            readln(archivo,reg.cantvendida);
        end
        else
            reg.codigo:= valor_alto;
    end;


    procedure compactar(var maestro:archivoB;var detalle:text);
    var
        reg:excursion;
        reg_act:excursion;
    begin
        reset(detalle);
        rewrite(maestro);
        leer(detalle,reg);
        while(reg.codigo <> valor_alto) do begin
            reg_act:=reg;
            leer(detalle,reg);
            while(reg_act.codigo=reg.codigo) do begin
                reg_act.cantvendida:=reg_act.cantvendida + reg.cantvendida;
                leer(detalle,reg);
            end;
            write(maestro,reg_act);
        end;
        close(maestro);
        close(detalle);
    end;
var
    maestro:archivoB;
    detalle:text;
    reg:excursion;
begin
    assign(maestro,'maestro.dat');
    assign(detalle,'excursiones.txt');
    compactar(maestro,detalle);
    reset(maestro);
    while(not eof(maestro)) do begin
        read(maestro,reg);
        writeln(reg.codigo);
        writeln(reg.nombre);
        writeln(reg.descripcion);
        writeln(reg.cantvendida);
    end;
    close(maestro);
end.
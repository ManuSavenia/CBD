Program Parcial4;
const
    valor_alto = 9999;
type
    viviendas=record
        cod_partido:integer;
        tipo_vivienda:integer;
        cantidad:integer;
    end;

    vivienda=record
        cod_partido:integer;
        tipo_vivienda:integer;
    end;

    maestro=file of viviendas; 
    detalle=file of vivienda;

    procedure leer(var archivo:detalle;var regd:vivienda);
    begin
        if(not eof(archivo)) then begin
            read(archivo,regd);
        end
        else
            regd.cod_partido:=valor_alto;
    end;

    procedure compactar(var mae:maestro;var det:detalle);
    var
        regm:viviendas;
        regd:vivienda;
        reg_Pact:vivienda;
        reg_Vact:vivienda;
        contador:integer;
    begin
        reset(det);
        rewrite(mae);
        leer(det,regd);
        while(regd.cod_partido<>valor_alto) do begin
            reg_Pact:=regd;
            writeln('nashe2');
            while((reg_Pact.cod_partido = regd.cod_partido) and (regd.cod_partido<>valor_alto)) do begin
                reg_Vact:=regd;
                contador:=1;
                leer(det,regd);
                while((reg_Vact.tipo_vivienda = regd.tipo_vivienda) and (regd.cod_partido<>valor_alto)) do begin
                    contador:= contador +1;
                    leer(det,regd);
                end;
                regm.cod_partido:= reg_Vact.cod_partido;
                regm.tipo_vivienda:= reg_Vact.tipo_vivienda;
                regm.cantidad:=contador;
                write(mae,regm);
            end;
        end;
        close(mae);
        close(det);
    end;
var
    mae:maestro;
    det:detalle;
    reg:viviendas;
begin
    assign(det,'viviendas.dat');
    assign(mae,'maestro.dat');
    writeln('nashe1');
    compactar(mae,det);
    writeln('nashe3');
    reset(mae);
    while(not eof(mae)) do begin
        read(mae,reg);
        writeln(reg.cod_partido);
        writeln(reg.tipo_vivienda);
        writeln(reg.cantidad);
        writeln();
    end;
    close(mae);
end.
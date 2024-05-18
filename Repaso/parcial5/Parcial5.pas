const
    valor_alto = 9999;
type
    archM=record
        codigo:integer;
        nombre:string;
        descripcion:string;
        precio:integer;
        cant_vendida:integer;
        mayor_cant_vendida:integer;
    end;

    archD=record
        codigo:integer;
        cant_vendida:integer;
    end;
    maestro= file of archM;
    detalle= file of archD;
    detalles= array[1..8] of detalle;
    rdetalles=array[1..8] of archD;

    procedure leer(var archivo:detalle;var regd:archD);
    begin
        if(not eof(archivo)) then begin
            read(archivo,regd);
        end
        else
            regd.codigo:=valor_alto;
    end;

    procedure minimo(var det:detalles;var regd:rdetalles;var min:archD);
    var
        posmin:integer;
    begin
        posmin:=1;
        min:=regd[1];
        for i=2 to 8 do begin
            if(reg[i].codigo<min.codigo) then begin
                min:=regd[i];
                posmin:=i;
            end;
        end;
        leer(det[posmin],regd[posmin]);
    end;

    procedure actualizar(var mae:maestro;var det:detalles;);
    var
        regd:rdetalles;
        regm:archM;
        min,venta_act:archD;
        i:integer;
    begin
        reset(mae);
        for i := 1 to 8 do begin
            reset(det[i],'detalle'i);
            leer(det[i],regd[i]);
        end;
        minimo(det,regd,min);
        while(min.codigo<>valor_alto) do begin
            venta_act.codigo:=min.codigo;
            venta_act.cant_vendida:=0;
            while(min.codigo=venta_act.codigo) do begin
                venta_act.cant_vendida:= venta_act.cant_vendida+min.cant_vendida;
                minimo(det,regd,min);
            end;
            leer(mae,regm);
            regm.cant_vendida:=venta_act.cant_vendida;
            if (regm.mayor_cant_vendida<regm.cant_vendida)then begin
                writeln('se paso la anterior mayor cantidad vendida');
                writeln(regm.codigo);
                writeln(regm.nombre);
                writeln(regm.mayor_cant_vendida);
                writeln(regm.cant_vendida);
                regm.mayor_cant_vendida:=regm.cant_vendida;
            end:
            seek(mae,Filepos(mae)-1);
            write(mae,regm);
        end;
        close(mae);
        for i:= 1 to 8 do close(det[i]);
    end;
var
    mae:maestro;
    det:detalles;
    
    i:integer;
begin
    assign(mae,'maestro.dat');
    for i := 1 to 8 do
        assign(det[i],'detalle'i);
    actualizar(mae,det);
end.
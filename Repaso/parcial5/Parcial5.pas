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
    detalles= array[1..2] of detalle;
    rdetalles=array[1..2] of archD;

    procedure leer(var archivo:detalle;var regd:archD);
    begin
        if(not eof(archivo)) then begin
            read(archivo,regd);
        end
        else
            regd.codigo:=valor_alto;
    end;

    procedure leerM(var archivo:maestro;var regm:archM);
    begin
        if(not eof(archivo)) then begin
            read(archivo,regm);
        end
        else
            regm.codigo:=valor_alto;
    end;

    procedure minimo(var det:detalles;var regd:rdetalles;var min:archD);
    var
        posmin:integer;
        i:integer;
    begin
        posmin:=1;
        min:=regd[1];
        for i:=2 to 2 do begin
            if(regd[i].codigo<min.codigo) then begin
                min:=regd[i];
                posmin:=i;
            end;
        end;
        leer(det[posmin],regd[posmin]);
    end;

    procedure actualizar(var mae:maestro;var det:detalles);
    var
        regd:rdetalles;
        regm:archM;
        min,venta_act:archD;
        i:integer;
    begin
        reset(mae);
        for i := 1 to 2 do begin
            reset(det[i]);
            leer(det[i],regd[i]);
        end;
        minimo(det,regd,min);
        while(min.codigo<>valor_alto) do begin
            venta_act.codigo:=min.codigo;
            writeln('codigo actual: ',venta_act.codigo);
            venta_act.cant_vendida:=0;
            while(min.codigo=venta_act.codigo) do begin
                venta_act.cant_vendida:= venta_act.cant_vendida+min.cant_vendida;
                writeln('venta_act.cant_vendida: ',venta_act.cant_vendida);
                minimo(det,regd,min);
            end;
            leerM(mae,regm);
            while(regm.codigo<>venta_act.codigo) do
                leerM(mae,regm);
            regm.cant_vendida:=venta_act.cant_vendida;
            writeln('regm.mayor_cant_vendida: ',regm.mayor_cant_vendida);
            if ((venta_act.codigo<>valor_alto) and (regm.mayor_cant_vendida<venta_act.cant_vendida))then begin
                writeln('se paso la anterior mayor cantidad vendida');
                writeln(regm.codigo);
                writeln(regm.nombre);
                writeln(regm.cant_vendida);
                writeln(regm.mayor_cant_vendida);
                regm.mayor_cant_vendida:=regm.cant_vendida;
            end;
            seek(mae,Filepos(mae)-1);
            write(mae,regm);
        end;
        close(mae);
        for i:= 1 to 2 do close(det[i]);
    end;


    procedure pasarM(var mae:maestro);
    var
        regm:archM;
        maetxt:text;
    begin
        assign(maetxt,'maestro.txt');
        reset(maetxt);
        rewrite(mae);    
        
        while(not eof(maetxt)) do begin
            readln(maetxt,regm.codigo);
            readln(maetxt,regm.nombre);
            readln(maetxt,regm.descripcion);
            readln(maetxt,regm.precio);
            readln(maetxt,regm.cant_vendida);
            readln(maetxt,regm.mayor_cant_vendida);
            write(mae,regm);
        end;
        close(maetxt);
        close(mae);
    end;

    procedure pasarD(var det:detalles);
    var
        regD:rdetalles;
        i:integer;
    begin
        
        for i := 1 to 2 do begin
            rewrite(det[i]);
    
                regd[i].codigo:=1;
                regd[i].cant_vendida:=5;
                write(det[i],regd[i]);
                regd[i].codigo:=1;
                regd[i].cant_vendida:=6;
                write(det[i],regd[i]);
                regd[i].codigo:=1;
                regd[i].cant_vendida:=7;
                write(det[i],regd[i]);
                regd[i].codigo:=2;
                regd[i].cant_vendida:=8;
                write(det[i],regd[i]);
                regd[i].codigo:=2;
                regd[i].cant_vendida:=9;
                write(det[i],regd[i]);
            

            close(det[i]); 
        end;
    end;

var
    mae:maestro;
    det:detalles;
    
begin
    assign(mae,'maestro.dat');
    assign(det[1],'detalle1.dat');
    assign(det[2],'detalle2.dat');
    pasarM(mae);
    pasarD(det);
   
    actualizar(mae,det);
end.
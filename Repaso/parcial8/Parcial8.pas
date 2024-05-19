Program Parcial8;
const
    valor_alto=9999;
    N=2;
type
    venta_det=record
        anio:integer;
        mes:integer;
        dia:integer;
        codigoMarca:integer;
        codigoModelo:integer;
        nombreMarca:string;
        nombreModelo:string;
        color:string;
        dni:integer;
        monto:double;
    end;

    ventas_mae=record
        anio:integer;
        mes:integer;
        monto_tot:double;
        cant_ventas:integer;
    end;

    maestro=file of ventas_mae;
    detalle=file of venta_det;
    detalles=array[1..N] of detalle;
    rdetalles=array[1..N] of venta_det;


    procedure leer(var archivo:detalle;var regd:venta_det);
    begin
        if(not eof(archivo)) then begin
            read(archivo,regd);
        end
        else
            regd.anio:=valor_alto;
    end;

    procedure minimo(var det:detalles;var regd:rdetalles;var min:venta_det);
    var
        i:integer;
        posMin:integer;
    begin
        min:=regd[1];
        posMin:=1;
        for i:=2 to N do begin
            if(regd[i].anio<min.anio) then begin
                min:=regd[i];
                posMin:=i;
            end
            else
                if((regd[i].anio=min.anio) and (regd[i].mes<min.mes)) then begin
                    min:=regd[i];
                    posMin:=i;
                end
                else
                    if((regd[i].anio=min.mes) and (regd[i].dia<min.dia)) then begin
                        min:=regd[i];
                        posMin:=i;
                    end
                    else
                        if((regd[i].anio=min.dia) and (regd[i].codigoMarca<min.codigoMarca)) then begin
                            min:=regd[i];
                            posMin:=i;
                        end
                        else
                            if((regd[i].anio=min.codigoMarca) and (regd[i].codigoModelo<min.codigoModelo)) then begin
                                min:=regd[i];
                                posMin:=i;
                            end;
        end;
        leer(det[posMin],regd[posMin]);
    end;

    procedure Merge(var mae:maestro;var det:detalles;var regd:rdetalles;var reporte:text);
    var
        regm:ventas_mae;
        aux:venta_det;
        min:venta_det;
        mas,menos,contador:integer;
        modeloMax,modeloMin:=string;
    begin
        reset(det[1]);
        reset(det[2]);
        rewrite(mae);
        rewrite(reporte);
        minimo(det,regd,min);
        while(minimo.anio<>valor_alto) do begin
            aux:=min;
            while(aux.anio=min.anio) do begin
                while(aux.mes=min.mes) do begin
                    while(aux.dia=min.dia) do begin
                        mas:=0;
                        menos:=9999;
                        while(aux.nombreMarca=min.nombreMarca) do begin
                            contador:=0;
                            while(aux.nombreModelo=min.nombreModelo) do begin
                                contador:=contador+1;
                                regm.monto_tot:=regm.monto_tot+min.monto;
                                regm.cant_ventas:=regm.cant_ventas+1;
                                minimo(det,regd,min);
                            end;
                            if(mas<contador)then begin
                                mas:=contador;
                                modeloMax:=min.nombreModelo;
                            end
                            else
                                if(menos>contador) then begin
                                    menos:=contador;  
                                    modeloMin:=min.nombreModelo;
                                end;
                        end;
                        writeln(reporte,aux.nombreMarca)
                        writeln(reporte,modeloMax);
                        writeln(reporte,mas);
                        writeln(reporte,modeloMin);
                        writeln(reporte,menos);
                        writeln(reporte,'');
                        aux:=min;
                    end;
                end;
                regm.anio:=aux.anio;
                regm.mes:=aux.mes;
                write(mae,regm);
                regm.monto_tot:=0;
                regm.cant_ventas:=0;
                aux:=min;
            end;
        end;
        close(reporte);
        close(mae);
        close(det[1]);
        close(det[2]);
    end;

var
    mae:maestro;
    det:detalles;
    i:integer;
    regd:rdetalles;
begin
    assign(mae,'maestro.dat');
    assign(det,'detalle1.dat');
    assign(det,'detalle2.dat');
    for i:=1 to N do begin
        reset(det[i]);
        leer(det[i],regd[i]);
    end;

end.
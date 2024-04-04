type
    tVehiculo= Record
        codigoVehiculo:integer;
        patente: String;
        #motor:String;
        cantidadPuertas: integer;
        precio:real;
        descripcion:String
    end;
    tArchivo = File of tVehiculo;
var
    archivo:tVehiculo;
    vehiculo:tVehiculo;
    i:integer;


    Procedure agregar(var arch: archivo;var auto: vehiculo);
        var
            aux:vehiculo;
    begin
        reset(arch);
        read(arch,aux);
        if(aux.descripcion = '0') then begin
            seek(arch, filesize(arch));
            write(arch,auto);
        end
        else begin
            seek(arch, val(aux.descripcion));
            write(arch,auto);
        end;
        close(arch);
    end;

    Procedure eliminar (var arch: archivo; codigoVehiculo: integer);
    var
        aux: tVehiculo;
    Begin
        reset(arch);
        while(not eof(arch)) do begin
            read(arch,aux);
            if(aux.codigoVehiculo = codigoVehiculo) then begin
                aux.descripcion := '0';
                seek(arch, filepos(arch)-1);
                write(arch,aux);
            end;
        end;
    End;
    begin
    end.
Program Parcial6;
const
valor_alto=9999;
type
    profesional = Record
        DNI : integer ;
        nombre : String ;
        apellido: String ;
    end;
tArchivo =File of profesional;


    procedure leer(var archivo:tArchivo;var regm:profesional);
    begin
        if(not eof(archivo)) then begin
            read(archivo,regm);
        end
        else
            regm.DNI:=valor_alto;
    end;

    procedure crear(var mae:tArchivo;var info:text);
    var
        regm:profesional;
    begin
        rewrite(mae);
        reset(info);
        regm.DNI:=0;
        write(mae,regm);
        while(not eof(info)) do begin
            readln(info,regm.DNI);
            readln(info,regm.nombre);
            readln(info,regm.apellido);
            write(mae,regm);
        end;
        writeln('nashe1');
        close(mae);
        close(info);
    end;

    procedure agregar(var mae:tArchivo;var p:profesional);
    var
        regm:profesional;
        cabecera:profesional;
    begin
        reset(mae);
        leer(mae,cabecera);
        if(cabecera.DNI<>0)then begin
            seek(mae,cabecera.DNI*(-1));
            leer(mae,regm);
            cabecera.DNI:=regm.DNI;
            seek(mae,Filepos(mae)-1);
            write(mae,p);
        end
        else begin
            while(regm.DNI<>valor_alto) do 
                leer(mae,regm);
            write(mae,p);
        end;
        writeln('nashe2');
        close(mae);
    end;

    procedure eliminar(var mae:tArchivo;var DNI:integer;var bajas:text);
    var
        regm:profesional;
        posE:integer;
        cabecera:profesional;
        palabra:string;
        palabra1:string;
        palabra2:string;
    begin
        reset(mae);
        
        rewrite(bajas);
        leer(mae,regm);
        cabecera:=regm;
        while((regm.DNI<>valor_alto) and (regm.DNI<>DNI)) do 
            leer(mae,regm);
        writeln('el dni act es: ',regm.DNI);
        if(regm.DNI=DNI) then begin
            seek(mae,Filepos(mae)-1);
            posE:=Filepos(mae);
            writeln(bajas,regm.DNI);
            writeln('nashe3');
            writeln(bajas,regm.nombre);
            writeln(bajas,regm.apellido);
            write(mae,cabecera);
            seek(mae,0);
            regm.DNI:=posE*(-1);
            write(mae,regm);
        end
        else
            writeln('no se encontro el profesional a eliminar');
        
        close(mae);
        close(bajas);
    end;

    procedure verificar(var bajas:text);
        var
            palabra:string;
        begin
            reset(bajas);
            while(not eof(bajas)) do begin
                readln(bajas,palabra);
                writeln(palabra);
            end;
            close(bajas);
        end;

var
    info:text;
    bajas:text;
    mae:tArchivo;
    p1,p2:profesional;
    DNI:integer;
begin
    assign(info,'maestro.txt');
    assign(bajas,'bajas.txt');
    assign(mae,'maestro.dat');
    DNI:=2;
    p1.DNI:=7;
    p1.nombre:='nombre7';
    p1.apellido:='apellido7';
    crear(mae,info);
    agregar(mae,p1);
    verificar(bajas);
    eliminar(mae,DNI,bajas);
end.
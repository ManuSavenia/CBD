type
    infoFlor=record
        numeroEspecie:integer;
        alturaMax:integer;
        nombreCientifico:string;
        nombreVulgar:string;
        color:string;
    end;
    archFlores=file of infoFlor;
    texto =text;
var
    archivo:archFlores;
    archivo2:texto;
    flor:infoFlor;
    numero:integer;
    palabra:String;
    alturaMax:integer;
    alturaMin:integer;
    nombreMax:string;
    nombreMin:string;
    contador:integer;
    opc:integer;
    opc2:integer;
begin
    alturaMax:=-1;
    alturaMin:=9999;
    WriteLn('VOTOS');
    WriteLn('0. Terminar el Programa');
    WriteLn('1. Crear un archivo');
    WriteLn('2. Abrir un archivo existente');
    assign(archivo,'Flores');
    Repeat
        contador:=0;
        Write('Ingrese el nro. de opcion: ');
        ReadLn(opc);
        Case opc of 1: 
        begin
            rewrite(archivo);
            writeln('Ingrese el nombre cientifico');
            readln(palabra);
            while (palabra <> 'ZZZ') do begin
                flor.nombreCientifico:=palabra;
                writeln('Ingrese el numero de especie');
                readln(numero);
                flor.numeroEspecie:=numero;
                writeln('Ingrese la altura maxima');
                readln(numero);
                flor.alturaMax:=numero;
                writeln('Ingrese el nombre vulgar');
                readln(palabra);
                flor.nombreVulgar:=palabra;
                writeln('Ingrese el color');
                readln(palabra);
                flor.color:=palabra;
                write(archivo,flor);
                writeln('Ingrese el nombre cientifico');
                readln(palabra);
            end;
        close(archivo);
        end;
        2:
        begin
            writeln('0. Añadir mas flores');
            writeln('1. Cambiar el nombre cientifico');
            readln(opc2);
            case opc2 of
                0:
                begin
                    reset(archivo);
                    seek(archivo,filesize(archivo));
                    writeln('Ingrese el nombre cientifico');
                    readln(palabra);
                    while (palabra <> 'ZZZ') do begin
                        flor.nombreCientifico:=palabra;
                        writeln('Ingrese el numero de especie');
                        readln(numero);
                        flor.numeroEspecie:=numero;
                        writeln('Ingrese la altura maxima');
                        readln(numero);
                        flor.alturaMax:=numero;
                        writeln('Ingrese el nombre vulgar');
                        readln(palabra);
                        flor.nombreVulgar:=palabra;
                        writeln('Ingrese el color');
                        readln(palabra);
                        flor.color:=palabra;
                        write(archivo,flor);
                        writeln('Ingrese el nombre cientifico');
                        readln(palabra);
                    end;
                    close(archivo);
                end;
                1:
                begin
                    reset(archivo);
                    while (not eof(archivo)) do begin
                        writeln('Ingrese el nuevo nombre cientifico');
                        readln(palabra);
                        read(archivo,flor);
                        flor.nombreCientifico:=palabra;
                        write(archivo,flor);
                    end;
                    close(archivo);
                end;
            end;
        end;    
        end; 
        reset(archivo);
        while (not eof(archivo)) do begin
            contador:=contador+1;
            read(archivo,flor);
            if flor.alturaMax > alturaMax then begin
                alturaMax:=flor.alturaMax;
                nombreMax:=flor.nombreCientifico;
            end;
            if flor.alturaMax < alturaMin then begin
                alturaMin:=flor.alturaMax;
                nombreMin:=flor.nombreCientifico;
            end;
            writeln('Nombre cientifico: ',flor.nombreCientifico, ' Nombre vulgar: ',flor.nombreVulgar, ' Color: ',flor.color, ' Altura maxima: ',flor.alturaMax, ' Numero de especie: ',flor.numeroEspecie);
        end;
        writeln('La cantidad de flores es: ',contador);
        writeln('La flor mas alta es: ',nombreMax);
        writeln('La flor mas baja es: ',nombreMin);    
        close(archivo);
    until (opc=0);
    assign(archivo2,'Flores.txt');
    rewrite(archivo2);
    reset(archivo);
    while (not eof(archivo)) do begin
        read(archivo,flor);
        writeln(archivo2,'Nombre cientifico: ',flor.nombreCientifico, ' Nombre vulgar: ',flor.nombreVulgar, ' Color: ',flor.color, ' Altura maxima: ',flor.alturaMax, ' Numero de especie: ',flor.numeroEspecie);
    end;
    close(archivo);

end.

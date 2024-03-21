const
    valoralto='9999';
type
licencias=record
    codigoEmpleado:string;
    diasSolicitados:integer;
    fecha:integer;
    end;
master=record
    codigoEmpleado:string;
    nombre:string;
    apellido:string;
    fechaNacimiento:integer;
    direccion:integer;
    cantHijos:integer;
    telefono:integer;
    diasRestantes:integer;
    end;
    detalle = file of licencias;
    maestro = file of master;
    regN = array[1..10] of licencias;
    fileN = array[1..10] of detalle;
var
    mae:maestro;
    regMae:master;
    det[10]:detalle;
    regDet[10]:licencias;
    min:licencias;
    i:integer;


    procedure leer (var archivo:detalle; var dato:licencias);
        begin
        if (not eof( archivo ))
        then
            read (archivo, dato)
        else
            dato.cod := valoralto;
    end;
    
    procedure minimo (var reg_deta: regN; var min:licencias; var deta:fileN);
        var
            indice_min: integer;
            aux: licencias;
        begin
        aux.cod := valoralto;
        {recorrer el arreglo de registros reg_deta determinando el elemento MINIMO. En la
        variable indice_min guardar la POSICION del elemento mínimo}
        for (i:=1 to 10) do begin
            if (reg_deta[i].cod <> valoralto) then begin
                if (reg_deta[i].cod < aux.cod) then begin
                    aux := reg_deta[i];
                    indice_min := i;
                end;
        end;
        {guardar minimo}
        min = reg_deta[indice_min];
        {leer nuevo elemento del archivo correspondiente}
        leer(deta[indice_min], reg_deta[indice_min]);
    end;

begin 
    for i:=1 to 10 do begin
        assign(det[i], 'licencias'+i);
        reset(det[i]);
        leer(det[i], regDet[i]);
    end;
    assign(mae, 'maestro');
    reset(mae);
    read(mae, regMae);
    while (regMae.codigo <> valoralto) do begin
        minimo(regDet, min, det);
        {recorrer el arreglo de registros reg_deta determinando el elemento MINIMO}
        while (regMae.codigo <> min.codigo) do begin
            if eof(mae) then
            break;
            read(mae, regMae);
        end;
        {Recorrer el archivo maestro hasta encontrar el empleado cuyo código es igual al código del registro leído en el archivo detalle}
        if (regMae.diasRestantes >= min.diasSolicitados) then 
            regMae.diasRestantes := regMae.diasRestantes - min.diasSolicitados;
        else
            regMae.diasRestantes := 0;{me da paja hacer el archivo de texto}
        seek(mae, filepos(mae)-1);
        write(mae, regMae);
    end;
    for i:=1 to 10 do begin
        close(det[i]);
    end;
    close(mae);
end.
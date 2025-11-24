/* Paso 1: Eliminar registros duplicados utilizando 'folio' como clave única */
proc sort data=LM.LINEA_DE_MUJERES nodupkey;
    by folio; /* Usamos 'folio' como la clave primaria para eliminar duplicados */
run;

/* Paso 2: Filtrar valores atípicos en la variable 'edad' fuera del rango esperado */
data LM.LINEA_DE_MUJERES_Limpio;
    set LM.LINEA_DE_MUJERES;
    /* Si 'edad' está fuera del rango (18-99), se considera un valor nulo */
    if edad < 18 or edad > 99 then edad = .; 
run;

/* Paso 3: Eliminar registros donde la variable 'edad' es nula */
data LM.LINEA_DE_MUJERES_Limpio;
    set LM.LINEA_DE_MUJERES_Limpio;
    if edad = . then delete; /* Eliminamos registros con 'edad' nula */
run;

/* Paso 4: Crear un nuevo grupo para clasificar las edades */
data LM.LINEA_DE_MUJERES_Limpio;
    set LM.LINEA_DE_MUJERES_Limpio;
    /* Clasificamos 'edad' en grupos según el rango */
    if edad < 18 then rango_edad = 'Menor de 18';
    else if 18 <= edad <= 30 then rango_edad = '18-30';
    else if 31 <= edad <= 50 then rango_edad = '31-50';
    else if edad > 50 then rango_edad = 'Mayor de 50';
run;

/* Paso 5: Reemplazar valores nulos o vacíos en las variables de temáticas */
data LM.LINEA_DE_MUJERES_Limpio;
    set LM.LINEA_DE_MUJERES_Limpio;
    /* Reemplazamos "NA" o vacíos con 'Desconocido' en las temáticas */
    array tematicas{7} tematica_1-tematica_7;
    do i = 1 to 7;
        if tematicas{i} = "NA" or tematicas{i} = "" then tematicas{i} = "Desconocido";
    end;
run;

/* Paso 6: Revisamos la estructura final de la base de datos */
proc contents data=LM.LINEA_DE_MUJERES_Limpio;
run;
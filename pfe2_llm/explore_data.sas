* Resumen de variables numéricas ;
title "Estadísticos descriptivos de variables numéricas";
* Calcula estadísticas básicas (número de datos, media, mediana, mínimo, máximo, desviación estándar y valores faltantes) de la variable edad.;
proc means data=LM.tabla1 n mean median min max std nmiss;
   var edad; * Indica que solo se analizará la variable edad.;
run;

* Distribución de variables categóricas.;
title "Distribución de variables categóricas";
* Muestra la frecuencia (conteo) de las categorías para las variables tipo texto: sexo, estado civil, ocupación, escolaridad, servicio y origen.;
proc freq data=LM.tabla1;
   tables sexo estado_civil ocupacion escolaridad servicio origen / nocum;
run;

title "Distribución de variables numéricas";
* Variables numéricas.;
* Analiza la frecuencia de algunas variables numéricas y limita el análisis a las primeras 50,000 filas para hacerlo más rápido.;
proc freq data=LM.tabla1 (obs=50000);
   tables folio fecha_alta ano_alta mes_alta hora_alta / nocum;
run;

* Análisis de temáticas principales.;
title "Frecuencia de temáticas reportadas";
* Muestra cuántas veces aparece cada categoría en las tres primeras variables de temática.;
proc freq data=LM.tabla1;
   tables tematica_1 tematica_2 tematica_3 / nocum;
run;

* Conteo de valores faltantes en cada temática.;
* Cuenta cuántas veces aparece "NA" (sin dato) en cada una de las variables temáticas.;
proc sql;
   select 
      count(*) as Total_Registros, * Total de filas en la tabla.;
      sum(upcase(tematica_1) = "NA") as NA_Tematica1, * Conteo de "NA" en tematica_1.;
      sum(upcase(tematica_2) = "NA") as NA_Tematica2;
      sum(upcase(tematica_3) = "NA") as NA_Tematica3;
      sum(upcase(tematica_4) = "NA") as NA_Tematica4;
      sum(upcase(tematica_5) = "NA") as NA_Tematica5;
      sum(upcase(tematica_6) = "NA") as NA_Tematica6;
      sum(upcase(tematica_7) = "NA") as NA_Tematica7
   from LM.tabla1; * Indica de dónde se toman los datos.;
quit;

* Distribución y valores atípicos (edad).;
title "Distribución de la variable Edad";
* Analiza la variable edad con más detalle: muestra un histograma, calcula media, desviación, mínimos y máximos, y detecta valores fuera de lo común .;
proc univariate data=LM.tabla1;
   var edad; * Variable que se analiza.;
   histogram edad / normal kernel; * Gráfico con curva normal y suavizado kernel.;
   inset n mean std min max / position=ne; * Muestra estadísticas dentro del gráfico.;
run;

title; * Limpia el título después del análisis.;

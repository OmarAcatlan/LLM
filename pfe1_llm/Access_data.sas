libname LM "~/PG2V2/proyecto";
proc import datafile="~/PG2V2/proyecto/linea-mujeres-cdmx-reducido.csv" 
			dbms=csv out=work.tabla1
			replace;
run;

title "Tabla general de Linea Mujeres";
data LM.tabla1;
	set work.tabla1;
run; 
TITLE;

proc contents data=LM.tabla1;
	format fecha_alta date10.;
run;

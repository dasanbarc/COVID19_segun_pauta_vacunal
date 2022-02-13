
# Objetivos del script:
   # 1. Numerar y nombrar los campos del dataset (for de NR==1).
   # 2. Definir el recuento total de hospitalizados, críticos, difuntos y de la suma de todos ellos (variables recuento_total_...).
   # 3. Establecer, para cada uno de estos grupos, el recuento y porcentaje de cada estado vacunal (resto de variables).

BEGIN {FS=",";
       recuento_total_hosp=0; recuento_total_crit=0; recuento_total_def=0; recuento_total_atencion_hospitalaria=0;
       hosp_noi=0; hosp_par=0; hosp_com=0; crit_noi=0; crit_par=0; crit_com=0; def_noi=0; def_par=0; def_com=0; ah_noi=0; ah_par=0; ah_com=0;
       printf "\n\n\nRESUMEN Y CONCLUSIONES DEL DATASET TRANSFORMADO\n***********************************************\n\n\nCampos del dataset:\n"}
NR==1 {for (i=1; i<=NF; i+=1) {printf "\n   Campo " i ": " $i "."}}
{if ($6=="Hospitalización") recuento_total_hosp+=$8}
{if ($6=="Críticos") recuento_total_crit+=$8}
{if ($6=="Defunción") recuento_total_def+=$8}
{if ($6!="Caso") recuento_total_atencion_hospitalaria+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},Hospitalización,No_iniciada,[0-9]+$/ {hosp_noi+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},Hospitalización,Parcial,[0-9]+$/ {hosp_par+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},Hospitalización,Completa,[0-9]+$/ {hosp_com+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},Críticos,No_iniciada,[0-9]+$/ {crit_noi+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},Críticos,Parcial,[0-9]+$/ {crit_par+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},Críticos,Completa,[0-9]+$/ {crit_com+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},Defunción,No_iniciada,[0-9]+$/ {def_noi+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},Defunción,Parcial,[0-9]+$/ {def_par+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},Defunción,Completa,[0-9]+$/ {def_com+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},(Hospitalización|Críticos|Defunción),No_iniciada,[0-9]+$/ {ah_noi+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},(Hospitalización|Críticos|Defunción),Parcial,[0-9]+$/ {ah_par+=$8}
/^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},[0-9]{2},[0-9]{4},(Hospitalización|Críticos|Defunción),Completa,[0-9]+$/ {ah_com+=$8}
END {print "\n\n\nPorcentaje de acontecimientos que han requerido atención hospitalaria según pauta vacunal y según tipo de ingreso:\n";
     printf("   Hospitalización convencional: %i acontecimientos, de los cuales:\n", recuento_total_hosp);
     printf("      Vacuna no iniciada: %i acontecimientos, %.2f%% de los hospitalizados.\n", hosp_noi, (hosp_noi/recuento_total_hosp)*100);
     printf("      Vacuna parcial: %i acontecimientos, %.2f%% de los hospitalizados.\n", hosp_par, (hosp_par/recuento_total_hosp)*100);
     printf("      Vacuna completa: %i acontecimientos, %.2f%% de los hospitalizados.\n\n", hosp_com, (hosp_com/recuento_total_hosp)*100);
     printf("   Críticos: %i acontecimientos, de los cuales:\n", recuento_total_crit);
     printf("      Vacuna no iniciada: %i acontecimientos, %.2f%% de los críticos.\n", crit_noi, (crit_noi/recuento_total_crit)*100);
     printf("      Vacuna parcial: %i acontecimientos, %.2f%% de los críticos.\n", crit_par, (crit_par/recuento_total_crit)*100);
     printf("      Vacuna completa: %i acontecimientos, %.2f%% de los críticos.\n\n", crit_com, (crit_com/recuento_total_crit)*100);
     printf("   Defunciones: %i acontecimientos, de los cuales:\n", recuento_total_def);
     printf("      Vacuna no iniciada: %i acontecimientos, %.2f%% de las defunciones.\n", def_noi, (def_noi/recuento_total_def)*100);
     printf("      Vacuna parcial: %i acontecimientos, %.2f%% de las defunciones.\n", def_par, (def_par/recuento_total_def)*100);
     printf("      Vacuna completa: %i acontecimientos, %.2f%% de las defunciones.\n\n", def_com, (def_com/recuento_total_def)*100);
     printf("   Acontecimientos que han requerido atención hospitalaria (hospitalizados, críticos y defunciones): %i acontecimientos, de los cuales:\n", recuento_total_atencion_hospitalaria);
     printf("      Vacuna no iniciada: %i acontecimientos, %.2f%% de los acontecimientos que han requerido atención hospitalaria.\n", ah_noi, (ah_noi/recuento_total_atencion_hospitalaria)*100);
     printf("      Vacuna parcial: %i acontecimientos, %.2f%% de los acontecimientos que han requerido atención hospitalaria.\n", ah_par, (ah_par/recuento_total_atencion_hospitalaria)*100);
     printf("      Vacuna completa: %i acontecimientos, %.2f%% de los acontecimientos que han requerido atención hospitalaria.\n\n", ah_com, (ah_com/recuento_total_atencion_hospitalaria)*100)}


# BIBLIOGRAFÍA:

# https://stackoverflow.com/questions/28913826/how-to-parse-through-a-csv-file-by-awk

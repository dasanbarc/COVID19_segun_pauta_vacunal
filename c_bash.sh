#!/bin/bash

# Objetivo del script:
   # Con jq: contar cuántos episodios de COVID (acontecimientos en general, independientemente de la gravedad) hay en cada estación para el 2021; luego verifica estos números con for y awk.
   # Con while: contar cuántos acontecimientos hay de los tipos graves para este mes de diciembre de 2021.

d_json=$(csvjson $1)

echo -e "\nRecuento de acontecimientos por estaciones en el año 2021 con jq *:\n"
echo -e "   - Primavera:" $(cat <(echo $d_json) | jq -c '[.[] | select(."AÑO"==2021) | select([."MES"] | inside([3, 4, 5])) | .RECUENTO] | reduce .[] as $rec(0; .+$rec)')
echo -e "   - Verano:" $(cat <(echo $d_json) | jq -c '[.[] | select(."AÑO"==2021) | select([."MES"] | inside([6, 7, 8])) | .RECUENTO] | reduce .[] as $rec(0; .+$rec)')
echo -e "   - Otoño:" $(cat <(echo $d_json) | jq -c '[.[] | select(."AÑO"==2021) | select([."MES"] | inside([9, 10, 11])) | .RECUENTO] | reduce .[] as $rec(0; .+$rec)')
echo -e "   - Invierno:" $(cat <(echo $d_json) | jq -c '[.[] | select(."AÑO"==2021) | select([."MES"] | inside([12, 1, 2])) | .RECUENTO] | reduce .[] as $rec(0; .+$rec)')

echo -ne "\n         * Verificado con bucle for y awk:"
echo -ne " Primavera" $(a=(); for i in $(awk -F, '{if (($4==3 || $4==4 || $4==5) && $5==2021) print $8}' $1); do a+=($i); done; echo $(($(echo ${a[*]} | sed 's/ /+/g'))))";"
echo -ne " Verano" $(a=(); for i in $(awk -F, '{if (($4==6 || $4==7 || $4==8) && $5==2021) print $8}' $1); do a+=($i); done; echo $(($(echo ${a[*]} | sed 's/ /+/g'))))";"
echo -ne " Otoño" $(a=(); for i in $(awk -F, '{if (($4==9 || $4==10 || $4==11) && $5==2021) print $8}' $1); do a+=($i); done; echo $(($(echo ${a[*]} | sed 's/ /+/g'))))";"
echo -e " Invierno" $(a=(); for i in $(awk -F, '{if (($4==12 || $4==1 || $4==2) && $5==2021) print $8}' $1); do a+=($i); done; echo $(($(echo ${a[*]} | sed 's/ /+/g'))))"."

OLDIFS=$IFS
IFS=","

Ho=(); Cr=(); De=()

while read SE ED D M A AC PA REC; do
   if [[ "$M" == "12" && "$A" == "2021" &&  "$AC" == "Hospitalización" ]]; then
      Ho+=($(echo "$SE,$ED,$D,$M,$A,$AC,$PA,$REC" | grep -E '^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},.*,.*,.*,(No_iniciada|Parcial|Completa),[0-9]+$' | cut -d, -f8))
   elif [[ "$M" == "12" && "$A" == "2021" &&  "$AC" == "Críticos" ]]; then
      Cr+=($(echo "$SE,$ED,$D,$M,$A,$AC,$PA,$REC" | grep -E '^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},.*,.*,.*,(No_iniciada|Parcial|Completa),[0-9]+$' | cut -d, -f8))
   elif [[ "$M" == "12" && "$A" == "2021" &&  "$AC" == "Defunción" ]]; then
      De+=($(echo "$SE,$ED,$D,$M,$A,$AC,$PA,$REC" | grep -E '^(Mujer|Hombre|No_clasificado),([0-9]+_(a|o)_([0-9]+|más)|No_clasificado),[0-9]{2},.*,.*,.*,(No_iniciada|Parcial|Completa),[0-9]+$' | cut -d, -f8))
   fi
done < $1

sumHo=$(IFS=+; echo "$((${Ho[*]}))")
sumCr=$(IFS=+; echo "$((${Cr[*]}))")
sumDe=$(IFS=+; echo "$((${De[*]}))")

echo -e "\n\nEste mes de diciembre del año 2021, debido a la COVID-19, ha habido:\n"
echo -e "   - Hospitalizaciones convencionales: $sumHo"
echo -e "   - Ingresos en críticos: $sumCr"
echo -e "   - Defunciones: $sumDe\n"

IFS=$OLDIFS


# BIBLIOGRAFÍA:

# https://stackoverflow.com/questions/44704404/select-entries-based-on-multiple-values-in-jq

# https://blog.differentpla.net/blog/2019/01/11/jq-reduce/

# https://stackoverflow.com/questions/5448915/concatenate-output-of-two-commands-into-one-line

# https://www.futurelearn.com/info/courses/linux-for-bioinformatics/0/steps/202962

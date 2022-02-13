#!/bin/bash

# Sobre el dataset escogido:
   # Título: Impacto del COVID por estado de vacunación.
   # Muestra cuántos casos, hospitalizaciones convencionales, hospitalizaciones en críticos y defunciones existen por sexo, edad, fecha y pauta de vacunación.
   # Los datos se refieren a toda Cataluña.
   # El dataset se actualiza a diario.
   # El primer registro es del 1 de enero de 2021.
   # Un mismo paciente se cuenta tantas veces como acontecimientos por los que ha pasado.

# Objetivo del script: mostrar el enlace de descarga, el formato del archivo y una primera visión del dataset con el número de registros
# y el tipo de variable por campo (estos dos últimos, accesibles con la opción -v).

url="https://analisi.transparenciacatalunya.cat/api/views/6izj-g3sb/rows.csv?accessType=DOWNLOAD&sorting=true"
# En: https://analisi.transparenciacatalunya.cat/Salut/Impacte-del-COVID-19-per-estat-de-vacunaci-/6izj-g3sb

nombre_archivo="data_file.csv"

wget -qO $nombre_archivo $url

echo -e "\n\nEnlace de descarga: $url\n"

echo -e "\nNúmero de registros (excluyo fila de nombre de campos) y de columnas:\n\n$(awk -F, 'BEGIN {num_fil=0} /^[^SEXE].*/ {num_fil+=1} END {printf "   Número de filas: %s\n   Número de columnas: %s\n", num_fil, NF}' $nombre_archivo)"

while getopts ":v" opt; do
  case $opt in
    v)
      echo -e "\n\nFormato del archivo: $(file --mime-type --mime-encoding $nombre_archivo)\n"
      echo -e "\nTipo de datos:\n"

      # Con el for comparo cada campo de la fila 2 (podría haber sido cualquier otra fila) con una Regex que clasifica el dato según tipo de variable
      # (en este caso, diferencio entre string, integer y date).

      for i in {1..6}; do if [[ $(awk -F, -v j=$i '{if (NR==2) print $j}' $nombre_archivo) =~ ^[0-9]+$ ]]; then echo "   Columna $i: integer"; elif [[ $(awk -F, -v j=$i '{if (NR==2) print $j}' $nombre_archivo) =~ [0-9]{2}/[0-9]{2}/[0-9]{4} ]]; then echo "   Columna $i: date"; elif [[ $(awk -F, -v j=$i '{if (NR==2) print $j}' $nombre_archivo) =~ [\sa-zA-Z0-9]* ]]; then echo "   Columna $i: string"; fi; done
      ;;
  esac
done



## BIBLIOGRAFÍA:

## https://stackoverflow.com/questions/19740823/how-to-get-csv-dimensions-from-terminal

## https://www.thegeekstuff.com/2010/01/8-powerful-awk-built-in-variables-fs-ofs-rs-ors-nr-nf-filename-fnr/

## https://wiki.bash-hackers.org/howto/getopts_tutorial

## https://stackoverflow.com/questions/46662790/how-to-check-the-type-of-an-awk-variable

## https://unix.stackexchange.com/questions/496994/awk-command-inside-a-for-loop

## https://linuxize.com/post/how-to-compare-strings-in-bash/

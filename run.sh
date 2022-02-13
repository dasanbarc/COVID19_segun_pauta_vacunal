#!/bin/bash

# Objetivo del script: llamar a todos los scripts creados; genera un resumen del dataset y un informe en HTML (tabla);
# añado la opción -c, que permite activar la visualización de la tabla HTML en el navegador con la ejecución de "./run.sh -c".

./a.sh -v
./b.sed
gawk -f c_awk.awk data_file_transf.csv
./c_bash.sh data_file_transf.csv
./d.sh

while getopts ":c" opt; do
  case $opt in
    c)
      firefox informe.html 2> /dev/null
      ;;
  esac
done

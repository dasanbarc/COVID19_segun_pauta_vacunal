#!/bin/bash

# Este script traduce del catalán al castellano el dataset por completo y escinde el campo Fecha en 3 campos nuevos (día, mes, año);
# guarda la salida en data_file_transf.csv y elimina data_file.csv (el dataset descargado).

sed '{
   s/SEXE,EDAT,DATA,ESDEVENIMENT,PAUTA,RECOMPTE/SEXO,EDAD,FECHA,ACONTECIMIENTO,PAUTA,RECUENTO/g
   /^Dona,\([0-9]\+ \(a\|o\) \([0-9]\+\|més\)\|No classificat\),[0-9]\{2\}\/[0-9]\{2\}\/[0-9]\{4\},\(Cas\|Crítics\|Hospitalització\|Defunció\),\(No iniciada\|Parcial\|Completa\),[0-9]\+$/s/Dona/Mujer/g
   /^Home,\([0-9]\+ \(a\|o\) \([0-9]\+\|més\)\|No classificat\),[0-9]\{2\}\/[0-9]\{2\}\/[0-9]\{4\},\(Cas\|Crítics\|Hospitalització\|Defunció\),\(No iniciada\|Parcial\|Completa\),[0-9]\+$/s/Home/Hombre/g
   /^No classificat,No classificat,[0-9]\{2\}\/[0-9]\{2\}\/[0-9]\{4\},\(Cas\|Crítics\|Hospitalització\|Defunció\),\(No iniciada\|Parcial\|Completa\),[0-9]\+$/s/No classificat/No clasificado/g
   /^.*,[0-9]\+ \(a\|o\) més,[0-9]\{2\}\/[0-9]\{2\}\/[0-9]\{4\},\(Cas\|Crítics\|Hospitalització\|Defunció\),\(No iniciada\|Parcial\|Completa\),[0-9]\+$/s/més/más/g
   / /s/ /_/g
   /^.*,.*,[0-9]\{2\}\/[0-9]\{2\}\/[0-9]\{4\},Hospitalització,.*,[0-9]\+$/s/Hospitalització/Hospitalización/g
   /^.*,.*,[0-9]\{2\}\/[0-9]\{2\}\/[0-9]\{4\},Cas,.*,[0-9]\+$/s/Cas/Caso/g
   /^.*,.*,[0-9]\{2\}\/[0-9]\{2\}\/[0-9]\{4\},Crítics,.*,[0-9]\+$/s/Crítics/Críticos/g
   /^.*,.*,[0-9]\{2\}\/[0-9]\{2\}\/[0-9]\{4\},Defunció,.*,[0-9]\+$/s/Defunció/Defunción/g
   /^.*,.*,[0-9]\{2\}\/[0-9]\{2\}\/[0-9]\{4\},.*,.*,[0-9]\+$/s/\//,/g  # Sustituyo "/" por ",".
   s/,FECHA/,DÍA,MES,AÑO/
}' data_file.csv > data_file_transf.csv

rm data_file.csv

#!/bin/bash

# Objetivo del script: crear un documento html (informe.html) que muestre en el navegador el número de acontecimientos COVID según pauta vacunal y edad.

cat <(
echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "  <title>Número de acontecimientos COVID según pauta vacunal y edad</title>"
echo "</head>"
echo "<body>"
echo "  <table border='8'>"
echo "    <caption>Número de acontecimientos COVID según pauta vacunal y edad</caption>"
awk 'BEGIN {FS=",";
            noi1=0; noi2=0; noi3=0; noi4=0;
            par1=0; par2=0; par3=0; par4=0;
            com1=0; com2=0; com3=0; com4=0}
     {if ($7=="No_iniciada" && ($2=="0_a_9" || $2=="10_a_19" || $2=="20_a_29")) noi1+=$8}
     {if ($7=="No_iniciada" && ($2=="30_a_39" || $2=="40_a_49" || $2=="50_a_59")) noi2+=$8}
     {if ($7=="No_iniciada" && ($2=="60_a_69" || $2=="70_a_79" || $2=="80_o_más")) noi3+=$8}
     {if ($7=="No_iniciada" && $2=="No_clasificado") noi4+=$8}
     ##
     {if ($7=="Parcial" && ($2=="0_a_9" || $2=="10_a_19" || $2=="20_a_29")) par1+=$8}
     {if ($7=="Parcial" && ($2=="30_a_39" || $2=="40_a_49" || $2=="50_a_59")) par2+=$8}
     {if ($7=="Parcial" && ($2=="60_a_69" || $2=="70_a_79" || $2=="80_o_más")) par3+=$8}
     {if ($7=="Parcial" && $2=="No_clasificado") par4+=$8}
     ##
     {if ($7=="Completa" && ($2=="0_a_9" || $2=="10_a_19" || $2=="20_a_29")) com1+=$8}
     {if ($7=="Completa" && ($2=="30_a_39" || $2=="40_a_49" || $2=="50_a_59")) com2+=$8}
     {if ($7=="Completa" && ($2=="60_a_69" || $2=="70_a_79" || $2=="80_o_más")) com3+=$8}
     {if ($7=="Completa" && $2=="No_clasificado") com4+=$8}
     END {printf("    <tr><th>Pauta&nbspvacunal</th><th>Edad&nbsp(años)</th><th>Número&nbspde&nbspacontecimientos&nbspCOVID</th></tr>\n");
          printf("    <tr><td style=\"color:green\" rowspan='4'>No&nbspiniciada</td><td>Menos&nbspde&nbsp30</td><td>%i</td></tr>\n", noi1);
          printf("    <tr><td>30-59</td><td>%i</td></tr>\n", noi2);
          printf("    <tr><td>60&nbspo&nbspmás</td><td>%i</td></tr>\n", noi3);
          printf("    <tr><td>No&nbspclasificado</td><td>%i</td></tr>\n", noi4);
          printf("    <tr><td style=\"color:green\" colspan='2'>Total&nbspvacuna&nbspno&nbspiniciada</td><td><strong>%i</strong></td></tr>\n", noi1+noi2+noi3+noi4);
          ##
          printf("    <tr><td style=\"color:blue\" rowspan='4'>Parcial</td><td>Menos&nbspde&nbsp30</td><td>%i</td></tr>\n", par1);
          printf("    <tr><td>30-59</td><td>%i</td></tr>\n", par2);
          printf("    <tr><td>60&nbspo&nbspmás</td><td>%i</td></tr>\n", par3);
          printf("    <tr><td>No&nbspclasificado</td><td>%i</td></tr>\n", par4);
          printf("    <tr><td style=\"color:blue\" colspan='2'>Total&nbspvacuna&nbspparcial</td><td><strong>%i</strong></td></tr>\n", par1+par2+par3+par4);
          ##
          printf("    <tr><td style=\"color:red\" rowspan='4'>Completa</td><td>Menos&nbspde&nbsp30</td><td>%i</td></tr>\n", com1);
          printf("    <tr><td>30-59</td><td>%i</td></tr>\n", com2);
          printf("    <tr><td>60&nbspo&nbspmás</td><td>%i</td></tr>\n", com3);
          printf("    <tr><td>No&nbspclasificado</td><td>%i</td></tr>\n", com4);
          printf("    <tr><td style=\"color:red\" colspan='2'>Total&nbspvacuna&nbspcompleta</td><td><strong>%i</strong></td></tr>\n", com1+com2+com3+com4)}' data_file_transf.csv
echo "  </table>"
echo "</body>"
echo "</html>"
) > informe.html

# Generado el informe, invito al usuario a ver el archivo.html en el navegador firefox (código comentado, ya que finalmente he optado
# por añadir una opción al comando ./run.sh que activa la visualización de la tabla en el navegador):

#echo -e -n "\n"
#read -p "¿Deseas completar el resumen del dataset con la visualización de la tabla 'Número de acontecimientos COVID según pauta vacunal y edad' en firefox? Responde, por favor, sí (S) o no (N)." -n 1 -r -s
#if [[ $REPLY =~ ^[Ss]$ ]]; then
#   firefox informe.html 2>/dev/null;
#   echo -e "\n";
#else
#   echo -e "\n";
#fi



# BIBLIOGRAFÍA:

# https://www.tutorialspoint.com/How-to-set-font-color-in-HTML

# https://www.google.com/amp/s/htmlcheatsheet.com/m/

# https://www.google.com/amp/s/carontestudio.com/blog/listado-de-etiquetas-html/amp/

# https://platzi.com/blog/etiquetas-html-debes-conocer/?utm_source=google&utm_medium=paid&utm_campaign=14603491644&utm_adgroup=&utm_content=&gclsrc=aw.ds&&gclid=CjwKCAiAtdGNBhAmEiwAWxGcUvtf2dXUaSLoNcYoOX3xnUsuietlPHKL-qwJhBw3kd1p2xyTFlY2lhoCRc8QAvD_BwE

# https://developers.google.com/style/html-formatting

# https://www.learnhowtoprogram.com/introduction-to-programming-part-time-react-track/git-html-and-css/html-indentation-and-spacing

# https://unix.stackexchange.com/questions/192042/how-do-i-suppress-error-messages-from-cp/192044

# https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script

# https://stackoverflow.com/questions/4316730/hiding-user-input-on-terminal-in-linux-script

# https://www.teachucomp.com/add-space-in-html-tutorial/

# https://www.w3schools.com/html/html_table_colspan_rowspan.asp

# https://stackoverflow.com/questions/9490992/why-is-awk-not-printing-out-newlines

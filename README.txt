ENUNCIADO DE LA PRÁCTICA

Escoged un objetivo de análisis de datos sobre
un conjunto abierto y elaborad un pequeño proyecto; buscad y elegid
un dataset para su análisis; dicho dataset debe tener un mínimo de
300 registros y un peso inferior a 1.5 MB (sin comprimir); en la práctica
se evaluarán solamente los aspectos de carácter técnico.

A. Cread un script denominado a.sh que descargue el dataset, siempre que
sea posible, y utilizando las herramientas vistas durante el curso muestre:
- La URL de descarga del dataset.
- Formato del o de los ficheros que lo componen.
- Número de columnas y registros.
- Tipo de datos (entero, decimal, fecha, texto, etc).
El script deberá al menos contemplar una opción / argumento de línea de
comandos. Si el script se ejecuta sin opciones, muestra la URL de descarga y
el número de columnas y registros. En cambio, si se incluye en su invocación
la opción -v deberá además mostrar el formato del o de
los ficheros y el tipo de datos de sus columnas. El script debe funcionar usando
la invocación: ./a.sh [-v]

B. Elaborar un script b.ext (con Bash, sed o awk) que implemente un
sistema de filtrado o de transformación sobre los datos haciendo uso de
expresiones regulares complejas. Es necesario definir un objetivo en el
filtro o en la transformación (¿Por qué estamos realizando este filtro o esta
transformación? ¿Qué aporta?). El script debe tener un mínimo de 7 líneas* que hagan transformaciones
con los datos, es decir, sentencias que modifiquen los datos o generen una
estructura nueva a partir de expresiones regulares, grep, sed, etc. No se
computarán como líneas efectivas de código aquellas sentencias que no
manipulen los datos. Por ejemplo, no se computarán sentencias básicas
para visualizar información (echo, print, cat, etc.), comentarios en el
código, asignaciones, construcción de estructuras (if, for, while, fi,
do, done, etc.), etcétera. En definitiva, el script debe demostrar claramente
el dominio adquirido de las herramientas del curso para el tratamiento de
datos. El script debe funcionar usando la invocación: ./b.ext donde ‘ext’
es la extensión correspondiente en cada caso.

C. El proyecto debe incorporar al menos la elaboración de dos scripts (con
los procesos que deseéis). Por ejemplo, hacer más transformaciones
sobre los datos, o corregir posibles errores o incongruencias en los datos,
en el supuesto de que las haya. Cada uno de los dos scripts tendrá que contener un proceso "iterativo"
(con estructuras tipo while o for). Uno de los scripts tiene que estar
escrito en Bash y el otro íntegramente en awk.
Cada uno de los dos script debe tener un mínimo de 7 líneas* que hagan
transformaciones con los datos, es decir, sentencias que modifiquen los
datos o generen una estructura nueva (combinar dos campos en uno
nuevo, filtrar, agregar, ordenar, etc.). A tal efecto, no se computarán
sentencias que no manipulen los datos, como las sentencias básicas para
visualizar información o construir estructuras (echo, print, cat, if, for,
while, fi, do, done, etc.), comentarios, asignaciones, etcétera. En
definitiva, los scripts deben demostrar el dominio adquirido en las
herramientas del curso para el tratamiento de datos.
El script en Bash se ha de adjuntar por medio de un fichero llamado
c_bash.sh, mientras que el script en awk se almacenará en otro fichero
llamado c_awk.awk. Los scripts deben funcionar usando la invocación siguiente:
./c_bash.sh <nombreDelFicheroDeDatos>
gawk -f c_awk.awk <nombreDelFicheroDeDatos>

D. Además, elaborad un script llamado d.sh que genere un documento en
formato de texto plano con formato atractivo o HTML5 con resultados
agregados por categorías o por intervalos.
Por ejemplo, si los datos fueran de acceso a una plataforma en línea, se
podría realizar un informe con el número de usuarios por cada provincia,
por edad o por otra agrupación de los resultados.
No se considerará válido una simple visualización (total o parcial) del
dataset. Debe haber cálculos en forma de agrupaciones o categorías. Se
revisará la veracidad de los cálculos y se valorará la sofisticación de la
maquetación, a saber, los recursos de formato (color, negrita, tablas vs
CSS, etc.). El script debe funcionar usando la invocación: ./d.sh

E. Es necesario que haya un script principal (además de los anteriores),
llamado run.sh que ejecute paso a paso todo el proyecto, llamando a los
scripts anteriores. Debe encargarse de la ejecución de todos los scripts
indicados en los apartados A, B, C, y D.
Debéis tener en consideración que todo debe funcionar sin tener que
editar nada, ni llevar a cabo ninguna acción adicional de ningún tipo.
Intentad que el tiempo máximo de ejecución no supere los 10
segundos. El script debe funcionar usando la invocación: ./run.sh

	* Para alcanzar las 7·3=21 líneas en ocasiones se pierde eficiencia en el programa.

# EVALUACIÓN DE CALIDAD

El primer paso en mi Flujo de Trabajo es conocer y analizar la calidad de mis secuencias.

¿De qué datos estoy partiendo?

## FASTQ

En el Control de Calidad se trabaja con archivos de texto en formato **FASTQ**, estos son generados en la secuenciación de alto rendimiento y almacenan las lecturas de las muestras de ADN en una secuencia de nucleótidos junto con sus puntajes de calidad correspondientes .

El formato FASTQ está elaborado de una manera no tan sencilla de entender si lo ves por primera vez, sin embargo, una guía para desifrarlo es teniendo presente las siguientes reglas:

+-------+-----------------------------------------------------------------------------------------------------------------------------------------------------------+
| Línea | Descripcción                                                                                                                                              |
+=======+===========================================================================================================================================================+
| 1     | Comienza siempre con una '\@' y va seguido de la información de la lectura como el identificador, información del secuenciador y su posición en la celda. |
+-------+-----------------------------------------------------------------------------------------------------------------------------------------------------------+
| 2     | Aquí inicia la secuencia del ADN.                                                                                                                         |
+-------+-----------------------------------------------------------------------------------------------------------------------------------------------------------+
| 3     | Comienza con un '+' que es un separador entre la secuencia y su línea de calidad. A veces contiene la misma información que el la línea 1.                |
+-------+-----------------------------------------------------------------------------------------------------------------------------------------------------------+
| 4     | | Tiene una cadena de caracteres que representan las puntuaciones de calidad. Debe tener el mismo número de caracteres que la línea 2.                    |
+-------+-----------------------------------------------------------------------------------------------------------------------------------------------------------+

Para visualizar las primeras cuatro líneas de uno de los archivos del conjunto de datos primero tenemos que descomprimirlo:

```{bash}
$ cd ~/dc_workshop/data/untrimmed_fastq/

$ gunzip JP4D_R1.fastq.gz

$ head -n 4 JP4D_R1.fastq
```

El caracter 'N' está asociado a un nucleótico, eso significa que no se logró determinar el nucleótico exacto.

Cada nucleótido tiene una puntuación de calidad Phred asociada, esta se refiere a la probabilidad de una identificación de base incorrecta, se representa como un carácter ASCII (una letra, un dígito o un símbolo), cuyo valor ASCII indica la presición de la identificación de bases.

En el siguiente enlace puedes encontrar más imformación sobre las puntuaciones de calidad: [Calidad Phred](https://drive5.com/usearch/manual/quality_score.html)

Esta bien comprender de donde sale la puntuación de cada nucleótido pero realmente no se evalúan visualmente los archivos FASTQ para ello se hace uso de un programa de software llamado FASTQC.

## FASTQC

FASTQC permite visualizar la calidad colectiva de las lecturas dentro de una muestra, mediante un informe con gráficos y estadísticos sobre la calidad de las lecturas podemos describir el contenido de CG%,identificar los adaptadores, lecturas duplicadas, su profundidad, etc...

La siguiente imagen muestra un gráfico generado por FASTQC

![](images/clipboard-4007348979.png){width="525"}

-   El eje "x" muestra la posición de la base en la lectura y el eje "y" muestra la puntuación de calidad. En la imagen de arriba se identifican lecturas de ...pb de longitud, también hay un diagrama de cajas y bigotes o boxplot que muestra la distribución de la puntuacion para todas las lecturas en esa posición.

-   La línea roja horizontal indica la mediana de la puntuación.

-   El recuadro amarillo muestra el rango 3er cuartil. Este rango alberga el 50% de las lecturas, en esa posición, con la puntuación de calidad del recuadro amarillo.

-   Los bigotes muestran toda la gama que cubre hacia los valores más bajos (1er cuartil) o más altos (4to cuartil).

-   En el fondo se visualizan los colores verde(buenas puntuaciones de calidad), amarillo (puntuaciones de calidad aceptables) y rojo (malas puntuaciones de calidad).

## [Ejecución en FASTQC]{.smallcaps}

Ahora se evaluará la calidad de las lecturas que tenemos. Antes, aseguráte de que sigues en el directorio.

```{bash}
$ cd ~/dc_workshop/data/untrimmed_fastq/ 
```

Examina los metadatos de los archivos. Los metadatos hacen referencia a los datos de los datos, es decir se incluye la información de los propietarios del archivo, el estado de los permisos de escritura, lectura y ejecuación, el tamaño y la fecha de modificación. Usa el siguiente comando:

```{bash}
$ ls -ahls
```

FASTQC acepta múltiples nombres de archivo de entrada, y tanto archivos comprimidos como descomprimidos. Usa el siguiente comodín para ejecutar FASTQC en todas los archivos FASTQ del directorio donde te encuentras.

```{bash}
$ fastqc *.fastq*
```

A continuación verá un mensaje de salida en el que visualiza el avance del análisis. Tarda alrededor de 5 minutos en ejecutar todos los análisis en los cuatro archivos FASTQ. Al finalizar el programa crea varios archivos nuevos dentro del directorio en el que nos encontramos. Visualizalos así:

```{bash}
$ ls
```

Para cada archivo de entrada (FASTQ), FASTQC ha creado dos archivos de salidad; uno .zip y otro .html. Este último archivo te redirige a una página wed que muestra un informe resumido de cada una de las muestras.

Es importante tener separados los archivos de datos de entrada y los archivos de los resultados. Mueve los archivos de salida a un nuevo directorio dentro de este directorio, así:

```{bash}
$ mkdir -p ~/dc_workshop/results/fastqc_untrimmed_reads 
$ mv *.zip ~/dc_workshop/results/fastqc_untrimmed_reads/ 
$ mv *.html ~/dc_workshop/results/fastqc_untrimmed_reads/ 
```

Para inspeccionar los archivos de salida generados en FASTQC puedes navegar en este directorio de trabajo:

```{bash}
$ cd ~/dc_workshop/results/fastqc_untrimmed_reads/ 
```

## VISUALIZACIÓN DE LOS RESULTADOS DE FASTQC

Es importante considerar desde dónde estamos trabajando para poder visualizar los resultados de FASTQC:

| Espacio de trabajo | Visualización |
|----|----|
| Computadora local | Abrir archivo HTML en el navegador web |
| Instancia remota | Descarga de archivo HTML a nuestra computadora local y abrirlo en navegador |
| Instancia remota + terminal en RStudio | Abrir archivo HTML en navegador web o descargarlos a computadora local |

## OTRAS SECCIONES EN EL ARCHIVO FASTQC

En total son once los apartados que nos muestra el reporte de FASTQC. A continuación se muestra una tabla en donde podrás consultar información general de cada apartado. Si necesitas revisar más información detallada de cada uno de estos apartados consulta [aquí](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/).

| Apartado | Descripcción |
|----|----|
| "Basic statistics" | Tabla con información acerca de la secuenciación; nombre del archivo, bases totales, secuencias totales, longitud de las secuencias, %GC... |
| "Per base sequence quality" | Gráfico de la visión general del rango de los valores de calidad de todas las bases en cada posición. |
| "Per tile sequence quality" | Gráfico de los patrones en la calidad de las bases a lo largo de las baldosas (las máquinas de secuenciación se dividen en baldosas). |
| "Per sequence quality scores" | Gráfico de la puntuación de calidad por secuencia, se identifican subconjuntos de secuencias con valores de calidad bajos y altos. |
| "Per base sequence content" | Gráfico que traza la proporción de cada base. Se espera poca o ninguna diferencia entre las bases. |
| "Per sequence GC content" | Gráfico que muestra el contenido de GC en toda la longitud de cada secuencia y la compara con un modelo de distribución normal. |
| "Per base N content" | Gráfico que muestra la proporción de bases N en cada posición. |
| "Sequence Length Distribution" | Gráfica que muestra la dristribución de los distintos tamaños de fragmentos que contiene la muestra. |
| "Sequence Duplication Levels" | Gráfico que muestra el grado de duplicación de cada secuencia. |
| "Overrepresented sequences" | En este apartado se enumeran las secuencias que componen más del 0.1% del total, es decir que estan sobrerepresentadas |
| "Adapter Content" | Gráfico que muestra el porsentaje de secuencias de adaptadores que se acumulas al final de la secuencia |

## OTROS ARCHIVOS DE SALIDA GENERADOS POR FASTQC

Además del reporte HTML que nos genera FASTQC hay otros archivos con los que podemos trabajar. Estos archivos están comprimidos, es decir su terminación es .zip

Para descomprimir todos nuestros archivos .zip utilicemos el siguiente código, el cual es un bucle que nos permite descomprimir todos los archivos en un solo paso.

```{bash}
$ for filename in *.zip
> do
> unzip $filename
> done
```

Como resultado de la descomprensión se pueden visualizar varios archivos para cada una de las muestras. Estos archivos se encuentran en un directorio para cada muestra y puedes visualizarlo así:

```{bash}
$ ls -F 
```

Ahora entremos a uno de los directorios y veamos lo que está dentro.

```{bash}
$ ls -F JC1A_R1_fastqc/ 
```

Vamos a centrarnos en el archivo summary.txt. Con el siguiente código obtendremos una vista previa del archivo.

```{bash}
$ less JC1A_R1_fastqc/summary.txt 
```

En este archivo encontraremos una lista de las pruebas que se ejecutaron con FASTQC y además nos indica si la prueba falló o pasó o estuvo en el límite entre fallar y pasar.

## REGISTRO DE LOS RESULTADOS

Para realizar un registro de los resultados que se obtuvieron para todas las muestras en un solo archivo, creemos una carpeta y luego reunimos y aguardamos los archivos summary.txt de cada muestra con el siguiente código:

```{bash}
$ mkdir -p ~/dc_workshop/docs
$ cat */summary.txt > ~/dc_workshop/docs/fastqc_summaries.txt
```

Si quisieras observar todas aquellas muestras que no superaron al menos una de las pruebas, ejecuta el siguiente código para resivir una lista de todas las pruebas fallidas:

```{bash}
$ cd ~/dc_workshop/docs
$ grep FAIL fastqc_summaries.txt
```

## MULTIQC

MULTIQC es una herramienta que nos pertite visualizar la calidad de muchas muestra a la vez. Para explorarla puedes realizarlo [aquí](https://seqera.io/multiqc/).

## AUTOMATIZACIÓN DEL FLUJO DE TRABAJO

Es impredecible el conocer cada uno de los pasos y familiarizarse con el código para cada uno. Una vez que lo consigas podrás hacer scripts que te permitan realizar tareas repetitivas. Por ejemplo:

```{bash}
set -e #Hace que el script se detenga si ocurre un error en elgún comando.

cd ~/dc_workshop/data/untrimmed_fastq/ #Cambia el directorio de trabajo a la carpeta donde están los archivos FASTQ sin recortar (untrimmed).

echo "Running FastQC ..." #Imprime un mensaje en la terminal para informar que FASTQC está corriendo.

fastqc *.fastq* #Ejecuta FASTQC en todas los archivos .fastq o .fastq.gz del directorio actual.

mkdir -p ~/dc_workshop/results/fastqc_untrimmed_reads #Crea la carpeta de resultados si no existe.

echo "Saving FastQC results..." #Imprime un mensaje indicando que los resultados de FASTQC se están guardando.

mv *.zip ~/dc_workshop/results/fastqc_untrimmed_reads/ #Mueve todos los archivos .zip generados por FAStQC al directorio de resultados.

mv *.html ~/dc_workshop/results/fastqc_untrimmed_reads/ #Mueve todos los archivos de informe en formato .html a la misma carpeta de resultados.

cd ~/dc_workshop/results/fastqc_untrimmed_reads/ #Cambia el directorio a la carpeta donde se guardaron los resultados de FASTQC.

echo "Unzipping..." #Muestra un mensaje indicando que se están descomprimiendo los archivos .zip

#Bucle que recorre todos los archivos .zip en el directorio y los descomprime.
for filename in *.zip 
    do
    unzip $filename
    done

echo "Saving summary..." #Muestra un mensaje indicando se se entan guardando los summary.txt

mkdir -p ~/dc_workshop/docs #Crea la carpeta docs si no existe.

cat */summary.txt > ~/dc_workshop/docs/fastqc_summaries.txt #Extrae los archivos summary.txt de cada análisis de FASTQC y los combina en un solo archivo fastqc_summaries.txt dentro de la carpeta docs.
```

## 

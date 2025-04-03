# RECORTE Y FILTRADO

En el paso anterior aprendiste a visualizar la calidad de tus muestras, identificaste las lecturas que no cumplen con los estándares, los adaptadores presentes, la cantidad de cada base y demás características importantes para los pasos posteriores, como la %GC para el proceso de *Binning.*

Ahora podrás limpiar tus lecturas para eliminar todo aquello que pueda interferir para la reconstruccíón del genoma.

## LIMPIEZA DE LECTURAS

La limpieza de lecturas hace referencia al proceso de filtrar aquellas lecturas que están por debajo del umbral de calidad que se aceptará, así como al recorte de bases de mala calidad. Este proceso de recorte y filtrado lo rellavemos a cabo con Trimmomatic, sin embargo, existen otras opcciones como: **Fastp** evalúa y también corríge problemas en las secuencias lo que podría remplazar los procesos de FastQC y Trimmomatic , sin embargo tiene un proceso más automatizado, es decir, menor control del recorte, para mayor información consulta el manual [aquí](https://github.com/OpenGene/fastp); **Trim Galore** también automatiza el recorte de secuencias, combina la eliminación de adaptadores (Cutadapt) y genera reportes de calidad (FastQC), así como elimina lecturas de baja calidad y filtra secuencias cortas, a diferencia de Trimmomatic no requiere archivos adicionales para recortar adaptadores, más información consultado el manual [aquí](https://github.com/FelixKrueger/TrimGalore/blob/master/Docs/Trim_Galore_User_Guide.md).

## TRIMMOMATIC

Trimmomatic es un programa con un control detallado del recorte, lo que quiere decir que se configurar más parámetros, sin embargo no genera reportes. A continuación, antes de presentarte un comando completo para ejecutar Trimmomatic, veamos las opcciones que podemos encontrar.

```{bash}
$ trimmomatic
```

Lo primero que se debe especificar después de ejecutar Trimmomatic es si se esta trabajando con lecturas de extremo emparejado (PE, *pair end)* o de un solo extremo (SE, *single end*), depués indicar el número de procesadores para usar (-threads) para que el recorte sea más rápido, éstos son innecesario pero podrían dar un mayor control sobre el comando. Por último, se deben de escribir los argumentos posicionales, escenciales para especificar el orden de la acción.

En modo extremo emparejado, el programa espera dos archivos de entrada y también el ingreso de los nombres de los archivos de salida. A continuación, mayor información de éstos archivos.

+----------------------------------+-----------------------------------------------------------------------------------------------------------------------------+
| Tipo de archivo                  | Descripcción                                                                                                                |
+==================================+=============================================================================================================================+
| \<ArchivoEntrada1\>              | Archivo de entrada que contiene la lectura *forward* (avance). El nombre del archivo contendrá un \_1 o \_R1 en el nombre.  |
+----------------------------------+-----------------------------------------------------------------------------------------------------------------------------+
| \<ArchivoEntrada2\>              | Archivo de entrada que contiene la lectura *reverse* (reversa). El nombre del archivo contendrá un \_2 o \_R2 en el nombre. |
+----------------------------------+-----------------------------------------------------------------------------------------------------------------------------+
| \<ArchivoSalida1P\>              | Archivo de salida que contiene los pares supervivientes del archivo \_1.                                                    |
+----------------------------------+-----------------------------------------------------------------------------------------------------------------------------+
| \<ArchivoSalida1U\>              | Archivo de salida que contiene las lecturas huérfanas del archivo -1.                                                       |
+----------------------------------+-----------------------------------------------------------------------------------------------------------------------------+
| \<ArchivoSalida2P\>              | Archivo de salida que contiene los pares supervivientes del archivo \_2.                                                    |
+----------------------------------+-----------------------------------------------------------------------------------------------------------------------------+
| \<ArchivoSalida2U\>              | Archivo de salida que contiene las lecturas huérfanas del archivo -2.                                                       |
+----------------------------------+-----------------------------------------------------------------------------------------------------------------------------+

En modo de un solo extremo se espera un archivo de entrada, enseguida se ingresan configuraciones opcionales y al último se ingresa el nombre del archivo de salida.

Los argumentos o parámetros disponibles en Trimmomatic son:

+----------------------------------+-----------------------------------------------------------------------------------------------------+
| Parámetros                       | ¿Qué hace?                                                                                          |
+==================================+=====================================================================================================+
| ILLUMINACLIP                     | Realiza la extracción del adaptador                                                                 |
+----------------------------------+-----------------------------------------------------------------------------------------------------+
| SLIDINGWINDOW                    | Corta una vez qu ela calidad promedio dentro de la ventana cae por debajo de un umbral establecido. |
+----------------------------------+-----------------------------------------------------------------------------------------------------+
| LEADING                          | Corta las bases del inicio de una lectura si están por debajo de un umbral de calidad establecido.  |
+----------------------------------+-----------------------------------------------------------------------------------------------------+
| TRAILING                         | Corta las bases del final de una lectura si están por debajo de un umbral de calidad establecido.   |
+----------------------------------+-----------------------------------------------------------------------------------------------------+
| CROP                             | Corta la lecturas a una longitud espeficicada.                                                      |
+----------------------------------+-----------------------------------------------------------------------------------------------------+
| HEADCROP                         | Corta un número especificado de bases del inicio de la lectura.                                     |
+----------------------------------+-----------------------------------------------------------------------------------------------------+
| MINLEN                           | Elimina una lectura completa si está por debajo de una longitud especificada.                       |
+----------------------------------+-----------------------------------------------------------------------------------------------------+
| TOPHRED33                        | Convierte las puntuaciones de calidad a Phred-33                                                    |
+----------------------------------+-----------------------------------------------------------------------------------------------------+
| TOPHRED64                        | Convierte las puntuaciones de calidad a Phred-64                                                    |
+----------------------------------+-----------------------------------------------------------------------------------------------------+

La comprensión de los parámetros compilados arriba es esencial para la adecuada limpieza de los datos. No todos son utilizados, así que puedes escoger solo aquellos que necesites para tus lecturas. Si necesitas checar información más a detalle consulta el [manual de Trimmomatic](http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf).

Ahora sí, un ejemplo de comando completo para Trimmomatic se verá así:

```{bash}
$ trimmomatic PE -threads 4 SRR_1056_1.fastq SRR_1056_2.fastq \
              SRR_1056_1.trimmed.fastq SRR_1056_1un.trimmed.fastq \
              SRR_1056_2.trimmed.fastq SRR_1056_2un.trimmed.fastq \
              ILLUMINACLIP:SRR_adapters.fa SLIDINGWINDOW:4:20
```

Desglocemos los detalles del código de arriba:

1.  **PE**, le indicamos que el archivo es de extremo emparejado.

2.  **-threads 4**, usará 4 procesadores para ejecutar el comando.

3.  **SRR_1056_1.fastq**, el nombre del primer archivo de entrada (*forward*).

4.  **SRR_1056_2.fastq**, el nombre del segundo archivo de entrada (*reverse*).

5.  **SRR_1056_1.trimmed.fastq**, nombre del archivo de salida para los pares supervivientes del primer archivo de entrada.

6.  **SRR_1056_1un.trimmed.fastq**, nombre del archivo de salida con las lecturas huerfanas del primer archivo de entrada.

7.  **SRR_1056_2.trimmed.fastq**, nombre del archivo de salida para los pares supervivientes del segundo archivo de entrada.

8.  **SRR_1056_2un.trimmed.fastq**, nombre del archivo de salida con las lecturas huerfanas del segundo archivo de entrada.

9.  **ILLUMINACLIP:SRR_adapters.fa**, le indicamos recortar los adaptadores de los archivos de entrada utilizando las secuencias de adaptadores enumeradas en el archivo SRR_adapters.fa.

10. **SLIDINGWINDOW:4:20**, le indica la creación de una ventana deslizante de tamaño 4 que eliminará las bases si su puntuación de Phred es inferior a 20.

Si te fijas nuevamente en el código notarás que se encuentra el caracter \\ , este permite separar los frangmentos en el código. Al escribir un código de entrada larga o que contenda muchos parámetros a modificar, el caracter \\ permite que el código sea más entendible.

Considera que en varias terminales el tiempo de espera para escribir el código es de solo unos segundos, se recomiendo escribir el comando completo en un archivo de texto y luego copiarlo en la terminal.

## EJECUCIÓN DE TRIMMOMATIC

Ejecutemos Trimmomatic en nuestros datos, asegúrate de que estés ubicado en el directorio donde se encuentran tus secuencias sin recortar o editar. Debes de tener cuatro archivos en ese directorio que correspondes a los archivos forward y reverse de las muestras JC1A y JP4D.

```{bash}
$ cd ~/dc_workshop/data/untrimmed_fastq
$ pwd
$ ls
```

Primero, recuerda que FastQC nos mostró la presencia de adaltadores por lo que usaremos el archivo TruSeq3-PE.fa que se encuentra en el directorio actual. También utilizaremos una ventana deslizante de tamaño 4 que elimine las bases si su puntuación Phred está por debajo de 20, ademas indicaremos que queremos descartar cualquier lectura que no tenga al menos 25 bases.

No olvides que descomprimimos anteriormente uno de los archivos, por lo que debemos de comprimirlo nuevamente.

```{bash}
gzip JP4D_R1.fastq
```

Ahora sí, ejecutemos el programa en una de nuestras dos muestras:

```{bash}
$ trimmomatic PE JP4D_R1.fastq.gz JP4D_R2.fastq.gz \
JP4D_R1.trim.fastq.gz  JP4D_R1un.trim.fastq.gz \
JP4D_R2.trim.fastq.gz  JP4D_R2un.trim.fastq.gz \
SLIDINGWINDOW:4:20 MINLEN:35 ILLUMINACLIP:TruSeq3-PE.fa:2:40:15 
```

Al terminar la ejecución obtendremos los archivos de salida en formato Fastq, con un tamaño menor a los archivos de entrada puesto que eliminamos lecturas. Compruebalo con el siguiente comando:

```{bash}
$ ls JP4D* -l -h
```

Como Trimmomatic solo puede trabajar con una muestra a la vez, cuando tenemos más de una podemos ejecutar un bucle que permita ahorranos el tiempo de escribir el código para cada muestra:

```{bash}
$ for infile in *_R1.fastq.gz
do
base=$(basename ${infile} _R1.fastq.gz)
trimmomatic PE ${infile} ${base}_R2.fastq.gz \
${base}_R1.trim.fastq.gz ${base}_R1un.trim.fastq.gz \
${base}_R2.trim.fastq.gz ${base}_R2un.trim.fastq.gz \
SLIDINGWINDOW:4:20 MINLEN:35 ILLUMINACLIP:TruSeq3-PE.fa:2:40:15
done
```

Antes de completar el proceso de recorte y filtrado de las lecturas en nuestras secuencias, mantengamos una organización y movamos los archivos de salida de Trimmomatic a un nuevo subdirectorio dentro del directorio actual:

```{bash}
$ cd ~/dc_workshop/data/untrimmed_fastq
$ mkdir ../trimmed_fastq
$ mv *.trim* ../trimmed_fastq
$ cd ../trimmed_fastq
$ ls
```

Ahora que las muestras han pasado por un control de calidad, si ejecutamos nuevamente FastQC para nuestros archivos de salida de Trimmomatic se espera que los resultados sean diferentes en el reporte y nuestras lecturas estén dentro de la calidad esperada para continuar con el flujo de trabajo.

Puedes ejecutar el siguiente código para visualizar la calidad de los archivos ya recortados:

```{bash}
$ fastqc ~/dc_workshop/data/trimmed_fastq/*.fastq*
$ mkdir ~/Desktop/fastqc_html/trimmed
```

---
title: "Control de Calidad"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# CONTROL DE CALIDAD

El primer paso en mi Flujo de Trabajo es conocer y analizar la calidad de mis secuencias ¿De qué datos estoy partiendo?


## FASTQ

En el Control de Calidad se trabaja con archivos de texto en formato **FASTQ**, estos son generados en la secuenciación de alto rendimiento y almacenan las lecturas de las muestras de ADN en una secuencia de nucleótidos junto con sus puntajes de calidad correspondientes . 

El formato FASTQ está elaborado de una manera no tan sencilla de entender si lo ves por primera vez, sin embargo, una guía para desifrarlo es teniendo presente las siguientes reglas:


|  Línea  |  Descripcción
|---------|
|   1     | Comienza siempre con una '@' y va seguido de la información de la lectura como el identificador, información del secuenciador y su posición en la celda.
|   2     | Aquí inicia la secuencia del ADN
|   3     | Comienza con un '+' que es un separador entre la secuencia y su línea de calidad. A veces contiene la misma información que el la línea 1.
|   4     | Tiene una cadena de caracteres que representan las puntuaciones de calidad.  Debe tener el mismo número de caracteres que la línea 2.


Para visualizar las primeras cuatro líneas de uno de los archivos del conjunto de datos primero tenemos que descomprimirlo:

```{r cars}
$ cd ~/dc_workshop/data/untrimmed_fastq/

$ gunzip JP4D_R1.fastq.gz

$ head -n 4 JP4D_R1.fastq
```


El caracter 'N' está asociado a un nucleótico, eso significa que no se logró determinar el nucleótico exacto.


Cada nucleótido tiene una puntuación de calidad Phred asociada, esta se refiere a la probabilidad de una identificación de base incorrecta, se representa como un carácter ASCII (una letra, un dígito o un símbolo), cuyo valor ASCII indica la presición de la identificación de bases.

En el siguiente enlace puedes encontrar más imformación sobre las puntuaciones de calidad: https://drive5.com/usearch/manual/quality_score.html

Esta bien comprender de donde sale la puntuación de cada nucleótido pero realmente no se evalúan visualmente los archivos FASTQ para ello se hace uso de un programa de software llamado  FASTQC.

##FASTQC

FASTQC permite visualizar la calidad colectiva de las lecturas dentro de una muestra, mediante un informe con gráficos y estadísticos sobre la calidad de las lecturas podemos describir el contenido de CG%,identificar los adaptadores, lecturas duplicadas, su profundidad, etc... 

La siguiente imagen muestra un gráfico generado por FASTQC



El eje "x" muestra la posición de la base en la lectura y el eje "y" muestra la puntuación de calidad. En la imagen de arriba se identifican lecturas de ...pb de longitud, también hay un diagrama de cajas y bigotes o boxplot que muestra la distribución de la puntuacion para todas las lecturas en esa posición. 

La línea roja horizontal indica la mediana de la puntuación.

El recuadro amarillo muestra el rango 3er cuartil. Este rango alberga el 50% de las lecturas, en esa posición, con la puntuación de calidad del recuadro amarillo.

Los bigotes muestran toda la gama que cubre hacia los valores más bajos (1er cuartil) o más altos (4to cuartil).

En el fondo se visualizan los colores verde(buenas puntuaciones de calidad), amarillo (puntuaciones de calidad aceptables) y rojo (malas puntuaciones de calidad).

#Ejecución en FASTQC

Ahora se evaluará la calidad de las lecturas que tenemos. Antes, aseguráte de que sigues en el directorio.

```{r}
$ cd ~/dc_workshop/data/untrimmed_fastq/ 
```

Examina los metadatos de los archivos. Los metadatos hacen referencia a los datos de los datos, es decir se incluye la información de los propietarios del archivo, el estado de los permisos de escritura, lectura y ejecuación, el tamaño y la fecha de modificación. Usa el siguiente comando:

```{r}
$ ls -ahls
```

FASTQC acepta múltiples nombres de archivo de entrada, y tanto archivos comprimidos como descomprimidos. Usa el siguiente comodín para ejecutar FASTQC en todas los archivos FASTQ del directorio donde te encuentras.

```{r}
$ fastqc *.fastq* 
```

A continuación verá un mensaje de salida en el que visualiza el avance del análisis. Tarda alrededor de 5 minutos en ejecutar todos los análisis en los cuatro archivos FASTQ. Al finalizar el programa crea varios archivos nuevos dentro del directorio en el que nos encontramos. Visualizalos así:

```{r}
$ls
```

Para cada archivo de entrada (FASTQ), FASTQC ha creado dos archivos de salidad; uno .zip y otro .html. Este último archivo te redirige a una página wed que muestra un informe resumido de cada una de las muestras.

Es importante tener separados los archivos de datos de entrada y los archivos de los resultados. Mueve los archivos de salida a un nuevo directorio dentro de este directorio, así:

```{r}
$ mkdir -p ~/dc_workshop/results/fastqc_untrimmed_reads 
$ mv *.zip ~/dc_workshop/results/fastqc_untrimmed_reads/ 
$ mv *.html ~/dc_workshop/results/fastqc_untrimmed_reads/ 
```


## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

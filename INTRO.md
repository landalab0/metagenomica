## ¿Qué es la metagenómica?

Se define como una interdisciplina experimental y computacional del el análisis genético que proporciona la taxonomía y el potencial funcional de una comunidad microbiana en un etorno específico (suelo, agua, sangre, etc.)

Existen dos tipos de análisis dependiendo de nuestros objetivos metagenómicos

1\. Secuenciación de escopeta (shotgun): Se analiza todo el contenido genético de una muestra en un etorno específico

2.  Secuencia de Amplicones: Se analiza solo una parte del genoma. En procariotas se usa el ADN ribosomal 16S (16S rDNA) y en eucariotas como lo hongos se usa el DNA ribosomal 18s (18S rDNA) y la región espaciodora transcrita interna (ITS).

*En este taller nos enfocaremos en la **secuenciación shotgun***

## Pasos para el análisis metagenómico por secuenciación de escopeta

-Diseño del estudio: Debe cooncordar con los objetivos de la investigación.

-Recolección de las muestras: Incluye la representatividad y la posible contaminación de las muestras, así como el método de recolección dependiendo del tipo de muestra (microbioma humano/animal o muestras ambientales)

-Manipulación, transporte y almacenamiento de muestras: Un correcto manejo y almacenamiento de las muestras asegura datos confiables y evita sesgos en los resultados.

-Extracción de ADN: El tipo de extracción utilizada dependera tanto del objetivo del estudio como la plataforma de secuenciación utilizada

-Preparación y secuenciación de bibliotecas: En este paso, los genomas son fragmentados y posteriormente secuenciados por alguna plataforma de secuenciación como Ilumina. Para obtener más información acerca de las plataformas de secuenciación puede consultar más información [aquí.](https://www.nature.com/articles/nrmicro2850)

-Control de calidad de los datos: Este paso es crucial ya que genera datos limpios para los análisis posteriores e incluye la eliminación de las secuencias de baja calidad (utilizando la puntuación de Phred \<30) así como la eliminación cebadores y adaptadores. Generealmente se usa el software *Trimmomatic* para este paso.

-Ensamblaje: Este paso consiste en reconstruir genomas completos a partir de secuencias contiguas (*Contigs*)

-Caracterización taxonómica: Describe los taxones de una comunidad microbiana -Análisis funcional: Se puede inferir el metabolismo de los taxones en la comunidad microbiana.

## Aplicaciones

La metagenómica resulta útil para caracterizar a las comunidades microbianas cultivables y no cultivables, tanto taxonómicamente como su potencial funcional en un ambiente particular. Por ejemplo, estos análisis pueden ser útiles en cuestiones clínicas como la el moniterio de la resistencia a los antibióticos o en aspectos ecológicos que incluyen la biodiversidad y las funciones biológicas que pueden desempeñar en los ecosistemas.

## Limitaciones

A pesar de los alcances que puede tener la metagenómica estos análisis resultan costosos, pueden abarcar mucho tiempo y tener atlos niveles de contaminación por cloroplastos, mitocondrias, ribosomas y otros elementos de amplificación no específica

### Referencias

-Liu, Y. X., Qin, Y., Chen, T., Lu, M., Qian, X., Guo, X., & Bai, Y. (2021). A practical guide to amplicon and metagenomic analysis of microbiome data. *Protein & cell*, *12*(5), 315-330.

-Liu, S., Rodriguez, J. S., Munteanu, V., Ronkowski, C., Sharma, N. K., Alser, M., ... & Mangul, S. (2025). Analysis of metagenomic data. *Nature Reviews Methods Primers*, *5*(1), 5.


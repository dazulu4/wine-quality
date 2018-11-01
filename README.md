# Wine Quality
Wine Quality Predictions in **R**

## Problema real

Con base en las mediciones fisicoquímicas poder clasificar la calidad del vino en etapas tempranas del proceso de modo que se pueda corregir o nivelar dichas características para garantizar la producción de un vino de óptima calidad.

## Descripción de los datos

En la referencia anterior, se crearon dos conjuntos de datos, utilizando muestrasde las variantes rojas y blancas del vino portugués Vinho Verde. Las entradas incluyen pruebas objetivas (por ejemplo, valores de pH) y la salida se basa en datos sensoriales (mediana de al menos 3 evaluaciones realizadas por expertos en vino). Cada experto clasificó la calidad del vino entre 0 (muy mal) y 10 (excelente).

En el presente analisis se utiliza el set de vinos de calidad de vinos blancos, en el cual se encuentran 12 variables fisicoquímicas y sensoriales que se especifican a continuacion:

* Fixed acidity: la acidez es la principal propiedad del vino y contribuyen en gran medida al sabor del mismo. Por lo general, se divide en dos grupos: los ácidos volátiles y los ácidos no volátiles o fijos.Esta variable se expresa en g (tartaricacid) / dm3.
* Volatile acidity:la acidez volátil es básicamente el proceso de convertir el vino en vinagre. En los EE. UU., Los límites legales de la Acidez volátil son 1.2 g / L para el vino de mesa rojo y 1.1 g / L para el vino de mesa blanco. La acidez volátil se expresa en g (aceticacid) / dm3.
* Citric acid: Es uno de los ácidos fijos que encontrará en los vinos. Se expresa en g / dm3 en los dos conjuntos de datos.
* Residual sugar: se refiere al azúcar que queda después de que la fermentación se detiene. Se expresa en g / dm3.
* Chlorides: puede ser un importante contribuyente a la salinidad en el vino. Está expresado en g (cloruro de sodio) / dm3.
* Free sulfur dioxide: la parte del dióxido de azufre que se agrega a un vino y que se pierde en él se dice que está limitada, mientras que la parte activa se dice que es libre. El enólogo siempre intentará obtener la mayor proporción de azufre libre para unir. Esta variable se expresa en mg / dm3.
* Total sulfur dioxide: es la suma del dióxido de azufre ligado y libre (SO2). Aquí, se expresa en mg / dm3.
* Density: generalmente se usa como una medida de la conversión de azúcar en alcohol. Aquí, se expresa en g / cm3.
* PH: es una escala numérica para especificar la acidez o basicidad del vino. La mayoría de los vinos tienen un pH entre 2.9 y 3.9 y por lo tanto son ácidos.
* Sulphates: se expresan en g (sulfato de potasio) / dm3.
* Alcohol: Porcentaje que se expresa en % vol.
* Quality: los expertos en vino calificaron la calidad del vino entre 0 (muy mal) y 10 (excelente). El número final es la mediana de al menos tres evaluaciones hechas por esos mismos expertos en vinos.

## Instalación de nodejs para publicación de servicios en Red Hat
```
sudo yum update
sudo yum install nodejs npm
```

## Instalación de pm2 para publicación del servicio
```
sudo npm install -g pm2
```

## Registro del servicio en pm2
```
pm2 start --interpreter="Rscript" Rscript d:/Aplicaciones/R/wine-quality/winequality-plumber.R
```

## Listado de servicios de pm2
```
pm2 list
```

## Detener el servicio de pm2
```
pm2 stop winequality-plumber
```

## Iniciar el servicio de pm2
```
pm2 start winequality-plumber
```

## Ejemplo consumo del servicio
* [Trainer](http://127.0.0.1:10080/quality-train)
* [Predict](http://127.0.0.1:10080/quality-predict?fixed.acidity=0&volatile.acidity=0.27&citric.acid=0.15&residual.sugar=12.5&chlorides=0.045&free.sulfur.dioxide=2&total.sulfur.dioxide=54&density=0.001&pH=1&sulphates=0.01&alcohol=3.8)

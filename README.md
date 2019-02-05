# Wine Quality
Wine Quality Predictions in **R**

## Problema real

Con base en las mediciones fisicoquímicas poder clasificar la calidad del vino en etapas tempranas del proceso de modo que se pueda corregir o nivelar dichas características para garantizar la producción de un vino de óptima calidad.

## Descripción de los datos

En la referencia anterior, se crearon dos conjuntos de datos, utilizando muestras de las variantes rojas y blancas del vino portugués Vinho Verde. Las entradas incluyen pruebas objetivas (por ejemplo, valores de pH) y la salida se basa en datos sensoriales (mediana de al menos 3 evaluaciones realizadas por expertos en vino). Cada experto clasificó la calidad del vino entre 0 (muy mal) y 10 (excelente).

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

## Dependencias del proyecto **R**
* rpart
* jsonlite
* base64enc
* plumber
```
install.packages(c('rpart', 'jsonlite', 'base64enc', 'plumber'))
```

## Endpoints del servicio predictivo

### /train-get (GET)
Ejecuta el script de entrenamiento del modelo predictivo para calidad de vinos. A continuación un ejemplo del resultado del servicio, donde presenta la precisión (Accuracy) del entrenamiento:
```
[
    0.5732
]
```

### /predict-get (GET)
Realiza la predicción de la calidad de un vino según las características de prueba ingresadas en los parámetros GET. A continuación se presentan los parámetros de entrada para el consumo:
```
/predict-get?fixed.acidity=0&volatile.acidity=0.27&citric.acid=0.15&residual.sugar=12.5&chlorides=0.045&free.sulfur.dioxide=2&total.sulfur.dioxide=54&density=0.001&pH=1&sulphates=0.01&alcohol=3.8
```

Finalmente, se presenta el resultado del servicio para predicción de un ejemplo de prueba. El valor resultado corresponde a un número entre 1 y 10 que representa la calidad del vino:
```
[
    "5.46323529411765"
]
```

### /predict-post (POST)
Realiza la predicción de la calidad de un vino según las características de prueba ingresadas en un parámetro POST en formato JSON (Content-Type: application/json). A continuación se presenta un ejemplo del documento JSON con los parámetros de entrada para el consumo:
```
[
    {
        "fixed.acidity": 0,
        "volatile.acidity": 0.27,
        "citric.acid": 0.15,
        "residual.sugar": 12.5,
        "chlorides": 0.045,
        "free.sulfur.dioxide": 2,
        "total.sulfur.dioxide": 54,
        "density": 0.001,
        "pH": 1,
        "sulphates": 0.01,
        "alcohol": 3.8
    },
    {
        "fixed.acidity": 0.1,
        "volatile.acidity": 1.5,
        "citric.acid": 0.05,
        "residual.sugar": 1.5,
        "chlorides": 1.45,
        "free.sulfur.dioxide": 6,
        "total.sulfur.dioxide": 10,
        "density": 0.1,
        "pH": 0.5,
        "sulphates": 0.02,
        "alcohol": 1.9
    }
]
```

Finalmente, se presenta el resultado del servicio para predicción de dos ejemplos de prueba. Los valores resultado corresponden a un número entre 1 y 10 que representa la calidad de los vinos:
```
[
    5.4632,
    4.9945
]
```

## Autenticación del servicio (Authorization Header)
El servicio tiene activada la opción de *Basic Auth* la cual permite, a través de un usuario y contraseña, agregar un primer nivel de seguridad. Las credenciales por defecto son:
```
USERNAME = admin
PASSWORD = admin
```
**Nota:** Tenga en cuenta en el cliente del servicio o si prueba desde Postman enviar el header *Authorization* con el usuario y contraseña codificadas en base64. Igualmente, tenga en consideración que estos atributos se deben pasar en los argumentos de ejecución del Script.

## Despliegue del servicio predictivo
A continuacion se presentará un ejemplo de despliegue o publicación del servicio predictivo en lenguaje R utilizando un servidor local (en la máquina del usuario) que permite intuir como será el comportamiento del servicio en un ambiente similar al productivo, por tanto, se utilizará el servidor de aplicaciones **NodeJS** con el complemento **PM2** para la ejecución de componentes en lenguaje R. Las siguientes son las instrucciones para la instalación del servidor de aplicaciones y los elementos requeridos en el proceso de despliegue.

**Nota:** Los comandos fueron creados para Linux Red Hat. Si requiere instalar los paquetes en otras implementaciones de linux, simplemente cambie *yum* por el gestor de paquetes del sistema operativo.

### Instalación de NodeJS para publicación del servicio
```
sudo yum update
sudo yum install nodejs npm
```

### Instalación de PM2 para publicación del servicio
```
sudo npm install -g pm2
```

**NOTA:** la instrucción *-g* se utiliza para instalación global de pm2, es decir, para todos los usuarios de la máquina.

### Publicación en PM2 del servicio predictivo
```
pm2 start --interpreter="Rscript" Rscript "d:/Aplicaciones/R/wine-quality/winequality-plumber.R" "admin" "admin" "10080" "d:/Aplicaciones/R/wine-quality"
```

### Instrucción de PM2 para listar los servicios
```
pm2 list
```

## Instrucción de PM2 para detener el servicio
```
pm2 stop winequality-plumber
```

## Instrucción de PM2 para iniciar el servicio
```
pm2 start winequality-plumber
```

## Instrucción de PM2 para reiniciar el servicio y comando para actualizar las variables de ambiente
```
pm2 restart winequality-plumber
pm2 restart --update-env winequality-plumber
```

## Ejemplos consumo del servicio predictivo
El archivo [winequality-postman.json](https://github.com/dazulu4/wine-quality/blob/master/winequality-postman.json) contiene ejemplos para el consumo de los endpoints con el fin de que pueda realizar pruebas de los mismos. Debe instalar la herramienta [Postman](https://www.getpostman.com/downloads/) e importar el archivo indicado para ejecutar el ejemplo de consumo de los 3 servicios publicados.

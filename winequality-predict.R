# Working Directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Exploración

## Carga y verificación de los datos
wine <- read.csv("winequality-white.csv", sep = ";")
str(wine)

hist(wine$quality)

# Metodología

# Entrenamiento del modelo¶

##
## conjuntos de entrenamiento y prueba
##
wine_train <- wine[1:3750, ]
wine_test <- wine[3751:4898, ]

##
## Se estima un árbol de regresión
## install.packages("rpart")
##
library(rpart)

##
## la calidad es función de todas las variables
## del data.frame
##
m.rpart <- rpart(quality ~ ., data = wine_train)
m.rpart

summary(m.rpart)

## install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(m.rpart, digits = 3)

rpart.plot(m.rpart,
           digits = 4,
           fallen.leaves = TRUE,
           type = 3,
           extra = 101)

# Evaluación del modelo

##
## Pronóstico para la muestra de prueba
##
p.rpart <- predict(m.rpart, wine_test)

##
## se compara la distribución de la salida
## del árbol contra la salida real
##
summary(p.rpart)

summary(wine_test$quality)

##
## se define el error medio absoluto para
## evaluar el desempeño del modelo
##
MAE <- function(actual, predicted) {
  mean(abs(actual - predicted))
}

MAE(p.rpart, wine_test$quality)

##
## media de la variable de salida
## para la muestra de entrenamiento
##
mean(wine_train$quality)

##
## Valor esperado para el MAE respecto
## a los datos
##
MAE(5.89, wine_test$quality)

# Guardamos el modelo entrenado
save(m.rpart, file='winequality-model.RData')

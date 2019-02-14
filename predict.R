# Exploracion

## Carga y verificacion de los datos
wine <- read.csv("data/data.csv", sep = ";")

# hist(wine$quality)

# Metodologia

# Entrenamiento del modelo

##
## Conjuntos de entrenamiento y prueba
##
wine_train <- wine[1:3750, ]
wine_test <- wine[3751:4898, ]

#wine_train$quality <- as.factor(wine_train$quality)
#wine_test$quality <- as.factor(wine_test$quality)

##
## Se estima un arbol de regresion
## install.packages("rpart")
##
library(rpart)

##
## la calidad es funcion de todas las variables
## del data.frame
##
m.rpart <- rpart(quality ~ ., data = wine_train)
m.rpart

summary(m.rpart)

# Evaluacion del modelo

##
## Pronostico para la muestra de prueba
##
p.rpart <- predict(m.rpart, wine_test)

##
## se compara la distribucion de la salida
## del arbol contra la salida real
##
summary(p.rpart)

summary(wine_test$quality)

##
## se define el error medio absoluto para
## evaluar el desempenio del modelo
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
MAE(5.886933, wine_test$quality)

##
## Guardamos el accuracy del modelo
accuracy <<- MAE(p.rpart, wine_test$quality)
print(paste("Accuracy:", accuracy, sep=" "))

# Serializamos el objeto entrenado con JSON
#m.rpart.json <- serializeJSON(m.rpart)

# Guardamos el modelo entrenado como JSON
#m.rpart.file <- "winequality-model.json"
#writeChar(m.rpart.json, con=m.rpart.file)

# Guardamos el modelo entrenado
save(m.rpart, file='model/model.RData')




#' Servicio de entrenamiento calidad de vinos
#' @get /train-get
#function(){
#  source('winequality-predict.R', encoding = 'UTF-8')
#  return(accuracy)
#}

# Lectura argumentos de ejecucion
#args <- commandArgs(trailingOnly=TRUE)
#if(length(args) == 4) {
#  WORKING_DIR <<- args[4]
#  BASIC_USER <<- args[1]
#  BASIC_PASS <<- args[2]
#  PORT_NUMBER <<- strtoi(args[3])
#} else {
  #stop(paste("Faltan parámetros de entrada", args, sep=": "))
#}

# Working Directory
#setwd("d:/Aplicaciones/R/wine-quality/")

# Cargo variables de ambiente (basic auth)
#basic.auth <- Sys.getenv(c("BASIC_USER", "BASIC_PASS"))
#if(basic.auth["BASIC_USER"] == "" && basic.auth["BASIC_PASS"] == "") {
#  basic.user <- "admin"
#  basic.pass <- "admin"
#} else {
#  basic.user <- basic.auth["BASIC_USER"]
#  basic.pass <- basic.auth["BASIC_PASS"]
#}

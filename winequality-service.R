# Librería requerida para transformaciones JSON
library(jsonlite)

# Working Directory
setwd("d:/Aplicaciones/R/wine-quality/")

# Cargamos el modelo entrenado como una variable global
load(file='winequality-model.RData')

#' Servicio de entrenamiento calidad de vinos
#' @get /train
function(){
  source('winequality-predict.R', encoding = 'UTF-8')
  return(accuracy)
}

#' Servicio de prediccion calidad de vinos con método HTTP GET
#' @param fixed.acidity
#' @param volatile.acidity
#' @param citric.acid
#' @param residual.sugar
#' @param chlorides
#' @param free.sulfur.dioxide
#' @param total.sulfur.dioxide
#' @param density
#' @param pH
#' @param sulphates
#' @param alcohol
#' @get /predict
function(fixed.acidity=0, volatile.acidity=0,
         citric.acid=0, residual.sugar=0,
         chlorides=0, free.sulfur.dioxide=0,
         total.sulfur.dioxide=0, density=0,
         pH=0, sulphates=0, alcohol=0){

  # Construimos el data.frame con las variables de entrada
  wine_test <- data.frame(
    "fixed.acidity" = as.numeric(fixed.acidity), "volatile.acidity" = as.numeric(volatile.acidity),
    "citric.acid" = as.numeric(citric.acid), "residual.sugar" = as.numeric(residual.sugar),
    "chlorides" = as.numeric(chlorides), "free.sulfur.dioxide" = as.numeric(free.sulfur.dioxide),
    "total.sulfur.dioxide" = as.numeric(total.sulfur.dioxide), "density" = as.numeric(density),
    "pH" = as.numeric(pH), "sulphates" = as.numeric(sulphates), "alcohol" = as.numeric(alcohol)
  )

  # Realizamos la prediccion correspondiente
  p.rpart <- predict(m.rpart, wine_test)

  # Retornamos el valor de la prediccion
  return(as.character(p.rpart)[1])
}

#' Servicio de prediccion calidad de vinos con método HTTP POST
#' @serializer contentType list(type='application/json')
#' @post /predict-post
function(req, res) {
  # Construimos el data.frame con las variables de entrada
  wine_test <- as.data.frame(fromJSON(req$postBody))

  # Realizamos la prediccion correspondiente
  p.rpart <- predict(m.rpart, wine_test)
  
  # Retornamos el valor de la prediccion
  return(toJSON(p.rpart))
}

# Working Directory
# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("d:/Aplicaciones/R/wine-quality/")

# Cargamos el modelo entrenado como una variable global
load(file='winequality-model.RData')

#' Servicio de entrenamiento calidad de vinos
#' @get /quality-train
function(){
  source('winequality-predict.R', encoding = 'UTF-8')
  return(accuracy)
}

#' Servicio de prediccion calidad de vinos
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
#' @get /quality-predict
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

# Libreria requerida para transformaciones JSON
library(jsonlite)

# Cargamos el modelo entrenado como una variable global como JSON
#m.rpart.file <- "winequality-model.json"
#m.rpart.json <- readChar(con = m.rpart.file, nchars = file.info(m.rpart.file)$size)
#m.rpart <- unserializeJSON(txt = m.rpart.json)

# Cargamos el modelo entrenado como una variable global
load(file='winequality-model.RData')

#' Servicio de entrenamiento calidad de vinos
#' @get /train-get
#function(){
#  source('winequality-predict.R', encoding = 'UTF-8')
#  return(accuracy)
#}

#' Servicio de prediccion calidad de vinos con metodo HTTP GET
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
#' @get /predict-get
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

#' Servicio de prediccion calidad de vinos con metodo HTTP POST
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

# Libreria requerida para codificación base64 
library(base64enc)

# Codificamos el usuario para autenticación base64 (basic auth)
basic.auth.base64 <- paste("Basic ", base64encode(charToRaw(paste(BASIC_USER, ":", BASIC_PASS, sep=""))), sep="")

# Filtro para autenticación Basic
#* @filter checkAuth
function(req, res){
  if (is.null(req$HTTP_AUTHORIZATION) || 
      !identical(req$HTTP_AUTHORIZATION, basic.auth.base64)){
    res$status <- 401 # Unauthorized
    return(list(error="Authentication required"))
  } else {
    plumber::forward()
  }
}

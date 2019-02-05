#!/usr/bin/env Rscript

# Ejecucion de Plumber (publicacion local de los servicios)
library("plumber")

# Variables del ambiente por defecto
WORKING_DIR <<- "d:/Aplicaciones/R/wine-quality"
BASIC_USER <<- 'admin'
BASIC_PASS <<- 'admin'
PORT_NUMBER <<- 10080

# Lectura argumentos de ejecucion
args <- commandArgs(trailingOnly=TRUE)
if(length(args) == 4) {
  WORKING_DIR <<- args[4]
  BASIC_USER <<- args[1]
  BASIC_PASS <<- args[2]
  PORT_NUMBER <<- strtoi(args[3])
} else {
  #stop(paste("Faltan parámetros de entrada", args, sep=": "))
}

# Publicacion del servicio predictivo
pr <- plumb("winequality-service.R")
pr$run(port=PORT_NUMBER)







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




#!/usr/bin/env Rscript

# Ejecucion de Plumber (publicacion local de los servicios)
library("plumber")

# Lectura argumentos de ejecucion (port)
port = 10080
args = commandArgs(trailingOnly=TRUE)
if(length(args) == 1) {
  port = strtoi(args[1])
}

# Publicacion del servicio predictivo
pr <- plumb("winequality-service.R")
pr$run(port=port)

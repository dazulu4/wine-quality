#!/usr/bin/env Rscript

# Ejecucion de Plumber (publicacion local de los servicios)
library("plumber")
pr <- plumb("winequality-service.R")
pr$run(port=10080)

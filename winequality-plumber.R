#!/usr/bin/env Rscript

# Working Directory
# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("d:/Aplicaciones/R/wine-quality/")

# Ejecucion de Plumber
library("plumber")
pr <- plumb("winequality-service.R")
pr$run(port=10080)


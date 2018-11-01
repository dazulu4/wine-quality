#!/usr/bin/env Rscript

# Working Directory
# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("d:/Aplicaciones/R/wine-quality/")

# Ejecucion de Plumber
library("plumber")
pr <- plumb("winequality-service.R")
pr$run(port=10080)

# Instalacion pm2
# sudo apt-get update
# sudo apt-get install nodejs npm
# sudo npm install -g pm2

# Comandos pm2
# pm2 start --interpreter="Rscript" Rscript d:/Aplicaciones/R/wine-quality/winequality-plumber.R
# pm2 list
# pm2 stop winequality-plumber
# pm2 start winequality-plumber

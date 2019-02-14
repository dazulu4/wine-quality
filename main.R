#!/usr/bin/env Rscript

# Paquetes requeridos para la ejecución
#install.packages(c('rpart', 'jsonlite', 'base64enc', 'plumber'))

# Ejecucion de Plumber (publicacion local de los servicios)
library("plumber")

# Variables del ambiente por defecto
env.vars <- Sys.getenv(c("SURA_APP_PORT", "SURA_BASIC_USER", "SURA_BASIC_PASS"))
port.number <- ifelse(env.vars['SURA_APP_PORT'] != "", env.vars['SURA_APP_PORT'], 8000)
basic.user <- ifelse(env.vars['SURA_BASIC_USER'] != "", env.vars['SURA_BASIC_USER'], 'admin')
basic.pass <- ifelse(env.vars['SURA_BASIC_PASS'] != "", env.vars['SURA_BASIC_PASS'], 'admin')

# Publicacion del servicio predictivo
pr <- plumb("app.R")
pr$run(host="0.0.0.0", port=port.number)

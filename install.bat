set SURA_BASIC_USER=admin
set SURA_BASIC_PASS=admin
pm2 start --interpreter="Rscript" Rscript "d:/Aplicaciones/R/wine-quality/main.R" --name "winequality"
pm2 list
FROM r-base:latest

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/* && \
    R -e "install.packages(c('rpart', 'jsonlite', 'base64enc', 'plumber'))" && \
    git clone https://github.com/dazulu4/wine-quality /R/wine-quality

WORKDIR /R/wine-quality
EXPOSE 8000

CMD ["R", "-e", "WORKING_DIR <<- '/R/wine-quality' ; BASIC_USER <<- 'admin' ; BASIC_PASS <<- 'admin' ; pr <- plumber::plumb('winequality-service.R'); pr\$run(port=8000);"]

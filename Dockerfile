FROM r-base:latest

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/* && \
	mkdir /R && \
    git clone https://github.com/dazulu4/wine-quality.git /R/wine-quality && \
	R -e "install.packages(c('rpart', 'jsonlite', 'base64enc', 'plumber'))"

WORKDIR /R/wine-quality
EXPOSE 8000
ENV SURA_APP_PORT=8000

USER daemon

CMD ["Rscript", "/R/wine-quality/main.R"]

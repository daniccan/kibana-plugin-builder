# FROM ubuntu-with-gosu:latest
FROM gosu/ubuntu:latest

LABEL maintainer "https://github.com/daniccan"

RUN apt-get update \
    && apt-get install -y curl \
        git \
        jq \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

COPY ./entrypoint.sh /entrypoint.sh

CMD ./entrypoint.sh
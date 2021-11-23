## Build snyk client
FROM  fedora:34

LABEL maintainer="Antonio Tolentino - atcjunior@gmail.com"


RUN groupadd -g 65532 snyk; useradd -m -d /snyk -u 65532 -g snyk snyk && \
    curl -s https://static.snyk.io/cli/latest/snyk-linux  -o /usr/local/bin/snyk && \
    chmod 755 /usr/local/bin/snyk
    

USER snyk:snyk

WORKDIR /snyk


ENTRYPOINT ["snyk"]

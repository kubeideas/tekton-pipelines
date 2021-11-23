# Download Stage
FROM fedora:34 as stage


ARG VERSION
ENV URL=https://get.helm.sh/helm-v${VERSION}-linux-amd64.tar.gz

WORKDIR /workspace


RUN curl -Ls ${URL} | tar xvzf -




## Build helm 3 client
FROM  alpine:3

LABEL maintainer="Antonio Tolentino - atcjunior@gmail.com"

RUN addgroup -g 65532 -S helm; adduser -u 65532 -S helm -G helm

WORKDIR /

ADD --chown=65532:65532 helm-entrypoint.sh /
COPY --chown=65532:65532 --from=stage /workspace/linux-amd64/helm /usr/local/bin/helm


USER helm:helm


ENTRYPOINT ["/helm-entrypoint.sh"]

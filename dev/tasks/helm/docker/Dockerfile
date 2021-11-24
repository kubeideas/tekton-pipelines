# Download Stage
FROM fedora:34 as stage

ARG VERSION
ENV URL=https://get.helm.sh/helm-v${VERSION}-linux-amd64.tar.gz

WORKDIR /workspace

RUN curl -Ls ${URL} | tar xvzf -





## Build helm 3 client
FROM  alpine:3

LABEL maintainer="Antonio Tolentino - atcjunior@gmail.com"

WORKDIR /

RUN addgroup -g 65532 -S helm; adduser -u 65532 -S helm -G helm

ADD --chown=helm:helm helm-entrypoint.sh /

COPY --from=stage /workspace/linux-amd64/helm /usr/local/bin/helm

USER helm:helm

ENTRYPOINT ["/helm-entrypoint.sh"]

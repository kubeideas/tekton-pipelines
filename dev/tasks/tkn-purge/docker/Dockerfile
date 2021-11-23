## Build Tekton client
#FROM gcr.io/distroless/static:nonroot
#
#LABEL maintainer="Antonio Tolentino - atcjunior@gmail.com"
#
#WORKDIR /
#
#ADD tmp/tkn .
#
#USER 65532:65532
#
#ENTRYPOINT ["/tkn"]




# Download Stage
FROM fedora:34 as stage


ARG VERSION
ENV URL=https://github.com/tektoncd/cli/releases/download/v${VERSION}/tkn_${VERSION}_Linux_x86_64.tar.gz

WORKDIR /workspace


RUN curl -Ls ${URL} | tar xvzf -


FROM alpine:3

LABEL maintainer="Antonio Tolentino - atcjunior@gmail.com"

WORKDIR /

COPY --chown=65532:65532 --from=stage /workspace/tkn .

USER 65532:65532

ENTRYPOINT ["/tkn"]
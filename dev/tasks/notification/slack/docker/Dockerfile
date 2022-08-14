## Build Slack publisher
FROM  fedora:34

LABEL maintainer="Antonio Tolentino - atcjunior@gmail.com"

ADD --chown=65532:65532 slack_template.json /slack/
ADD --chown=65532:65532 slack_entrypoint.sh /slack/

RUN groupadd -g 65532 slack && \
    useradd -m -u 65532 -g slack slack && \
    chmod 755 /slack/slack_entrypoint.sh

USER slack:slack

WORKDIR /slack

ENTRYPOINT ["/slack/slack_entrypoint.sh"]

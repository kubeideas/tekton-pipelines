## Build sendmail
FROM  fedora:34

LABEL maintainer="Antonio Tolentino - atcjunior@gmail.com"

ADD --chown=65532:65532 sendmail-entrypoint.sh /sendmail/
ADD --chown=65532:65532 *email_template.html /sendmail/

RUN groupadd -g 65532 sendmail && \
    useradd -m -u 65532 -g sendmail sendmail && \
    dnf -y  install mailx && \
    chmod 755 /sendmail/sendmail-entrypoint.sh

USER sendmail:sendmail

WORKDIR /sendmail


ENTRYPOINT ["/sendmail/sendmail-entrypoint.sh"]

FROM fedora:24

# Postfix image for OpenShift.
#
# Volumes:
#  * /var/spool/postfix -
#  * /var/spool/mail -
#  * /var/log/postfix - Postfix log directory
# Environment:
#  * $MYHOSTNAME - Hostname for Postfix image
# Additional packages
#  * findutils are needed in case fedora:24 is loaded from docker.io.

RUN dnf install -y --setopt=tsflags=nodocs postfix findutils && \
    dnf -y clean all

MAINTAINER "Petr Hracek" <phracek@redhat.com>

ENV POSTFIX_SMTP_PORT=10025 POSTFIX_SSL_PORT=10587 POSTFIX_SMTPS_PORT=10465

ADD files /files

RUN /files/postfix_config.sh

EXPOSE 10025 10587 10465

VOLUME ['/var/spool/postfix', '/var/spool/mail', '/var/log']

# Postfix UID based from Fedora
# USER 89

CMD ["/files/start.sh"]

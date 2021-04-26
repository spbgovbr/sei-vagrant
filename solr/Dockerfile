################################################################################
# Dockerfile de construcao do container Solr utilizado pelo SEI e pelo SIP 
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM centos:centos7

ENV TERM xterm

COPY assets /tmp/assets

RUN sh /tmp/assets/install.sh

EXPOSE 8983
CMD ["/entrypoint.sh"]

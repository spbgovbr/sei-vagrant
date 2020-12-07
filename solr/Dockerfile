################################################################################
# Dockerfile de construção do container Solr utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

#TODO: Migrar para container oficial do Java 8 (8-jdk-alpine)
FROM centos:centos7
MAINTAINER Guilherme Andrade Del Cantoni <guilherme.cantoni@economia.gov.br>

############################# INÍCIO DA INSTALAÇÃO #############################
ENV TERM xterm

COPY assets/msttcore-fonts-2.0-3.noarch.rpm /tmp
COPY assets/index/* /tmp/
COPY assets/sei-solr-6.1.0.sh /tmp/sei-solr-6.1.0.sh
COPY install.sh /install.sh
COPY entrypoint.sh /entrypoint.sh

RUN sh /install.sh
############################## FIM DA INSTALACAO ###############################

EXPOSE 8983
CMD ["/entrypoint.sh"]

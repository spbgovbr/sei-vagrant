################################################################################
# Dockerfile de construção do container Solr utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

MAINTAINER PEN - Processo Eletrônico Nacional
FROM openjdk:8

############################# INÍCIO DA INSTALACAO #############################

ENV TERM xterm

# Obtenção do pacote de instalação do Solr
COPY solr-6.1.0.tgz /tmp/
COPY index/* /tmp/
COPY install.sh /install.sh

RUN bash /install.sh

############################## FIM DA INSTALACAO ###############################

EXPOSE 8983
CMD ["/opt/solr/bin/solr", "start", "-f", "-p", "8983"]

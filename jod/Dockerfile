################################################################################
# Dockerfile de construção do container JOD utilizado pelo SEI e SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

MAINTAINER PEN - Processo Eletrônico Nacional
FROM centos:centos6

############################# INÍCIO DA INSTALACAO #############################
ENV TERM xterm

COPY install.sh /install.sh
COPY jodconverter-tomcat-2.2.2.zip /tmp/
COPY entrypoint.sh /entrypoint.sh

RUN bash /install.sh
############################## FIM DA INSTALACAO ###############################

EXPOSE 8080
CMD ["/entrypoint.sh"]

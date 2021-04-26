################################################################################
# Dockerfile de construção do container JOD utilizado pelo SEI e SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

#TODO: Migrar para container oficial do java-7 (7-jdk-alpine)
FROM centos:centos7

############################# INÍCIO DA INSTALAÇÃO #############################
ENV TERM xterm

COPY install.sh /install.sh
COPY entrypoint.sh /entrypoint.sh
COPY assets/jodconverter-tomcat-2.2.2.zip /tmp/

RUN sh /install.sh
############################## FIM DA INSTALACAO ###############################

EXPOSE 8080
CMD ["/entrypoint.sh"]

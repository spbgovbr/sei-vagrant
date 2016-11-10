###########################################################
# Dockerfile de construção do container JOD
# utilizado pelo SEI e pelo SIP
#
# Baseado no CentOS 6.X
############################################################

# Definição da imagem de base para o CentOS 6.X
FROM centos:centos6

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

################## INICIO DA INSTALACAO ######################
# Instalação do JOD Converter seguindo as recomendações descritas na documentação do SEI

COPY install.sh /install.sh
COPY jodconverter-tomcat-2.2.2.zip /tmp/
COPY entrypoint.sh /entrypoint.sh

RUN bash /install.sh

##################### FIM DA INSTALACAO #####################

# Definição do terminal a ser utilizado
ENV TERM xterm

# Exposição da porta de conexão ao Apache
EXPOSE 8080

# Inicialização dos serviços Apache e Memcache
CMD ["/entrypoint.sh"]

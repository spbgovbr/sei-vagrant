###########################################################################
# Dockerfile de construção do container JOD utilizado pelo SEI e pelo SIP #
###########################################################################

# Definição da imagem de base para o OpenJDK 8
FROM openjdk:8

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

################## INICIO DA INSTALACAO ######################
# Instalação do JOD Converter seguindo as recomendações descritas na documentação do SEI

ENV TERM xterm

# Instalação da api de serviços de conversão de documentos
COPY jodconverter-tomcat-2.2.2.zip /opt/

# Script de inicialização do container entrypoint
COPY entrypoint.sh /entrypoint.sh

# Instalação do Jod Converter e Libreoffice
COPY install.sh /install.sh
RUN bash /install.sh

##################### FIM DA INSTALACAO #####################

# Exposição da porta de conexão ao Apache
EXPOSE 8080

# Inicialização dos serviços Apache e Memcache
CMD ["/entrypoint.sh"]

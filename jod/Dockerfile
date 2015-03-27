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
# Ref: https://processoeletronico.gov.br/projects/sei/wiki

# Instalação do pacote Java JDK e utilitários utilizados no provisionamento
RUN yum -y update && \
    yum install -y java-1.7.0-openjdk-devel wget unzip dos2unix libreoffice libreoffice-headless && \
    yum -y clean all

# TODO: Utilizar wget para obter o pacote da web, removendo-o posteriormente para otimizar o tamanho da imagem
# Instalação da api de serviços de conversão de documentos
ADD jodconverter-tomcat-2.2.2.zip /opt/
RUN unzip /opt/jodconverter-tomcat-2.2.2.zip -d /opt && rm /opt/jodconverter-tomcat-2.2.2.zip

# Script de inicialização do container entry-point
ADD entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

##################### FIM DA INSTALACAO #####################

# Exposição da porta de conexão ao Apache
EXPOSE 8080

# Inicialização dos serviços Apache e Memcache
CMD ["/entrypoint.sh"]
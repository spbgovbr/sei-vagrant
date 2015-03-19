###########################################################
# Dockerfile de construção do container Jod 
# utilizado pelo SEI e pelo SIP
#
# Baseado no CentOS 6.X
############################################################

# Definição da imagem de base para o CentOS 6.X
FROM centos:centos6

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

################## INICIO DA INSTALACAO ######################
# Instalação do MySQL seguindo as recomendações descritas na documentação do SEI
# Ref: http://<WIKI DO PROJETO>#<SESSAO DE INSTALAÇÃO DO MYSQL>

# Instalação dos utilitários utilizados no provisionamento
RUN yum install -y wget unzip

# Instalação do pacote Java JDK 
RUN yum -y update java-1.7.0-openjdk-devel && \
    yum install -y java-1.7.0-openjdk-devel

# Instalação do pacote office responsável pela conversão para PDF
RUN yum -y update libreoffice libreoffice-headless && \
    yum install -y libreoffice libreoffice-headless

# Instalação da api de serviços de conversão de documentos
ADD jodconverter-tomcat-2.2.2.zip /opt/
# RUN wget -q -O /opt/jodconverter-tomcat-2.2.2.zip http://sourceforge.net/projects/jodconverter/files/JODConverter/2.2.2/jodconverter-tomcat-2.2.2.zip/download
RUN unzip /opt/jodconverter-tomcat-2.2.2.zip -d /opt && rm /opt/jodconverter-tomcat-2.2.2.zip

# Script de inicialização dos serviços
ADD run.sh /run.sh
RUN chmod +x /run.sh

##################### FIM DA INSTALACAO #####################

# Exposição da porta de conexão ao Apache
EXPOSE 8080

# Inicialização dos serviços Apache e Memcache
CMD ["/run.sh"]
###########################################################
# Dockerfile de construção do container WebApp
# utilizado pelo SEI e pelo SIP
#
# Baseado no CentOS 6.X
############################################################

# Definição da imagem de base para o CentOS 6.X
FROM centos:centos6

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

################## INICIO DA INSTALACAO ######################
# Instalação do SEI seguindo as recomendações descritas na documentação do SEI
# Ref: https://processoeletronico.gov.br/projects/sei/wiki

# Instalação do servidor web Apache 2.2, memcache e demais componentes
RUN yum -y update && \
    yum -y install httpd-2.2.* mysql-5.1.* memcached openssl wget curl unzip gcc java-1.7.0-openjdk libxml2 dos2unix crontabs \
    php-5.3.* php-common php-cli php-pear php-bcmath php-gd php-gmp php-imap php-intl php-ldap php-mbstring php-mysql \ 
    php-odbc php-pdo php-pecl-apc php-pspell php-zlib php-snmp php-soap php-xml php-xmlrpc php-zts php-devel \
	  php-pecl-apc-devel php-pecl-memcache php-calendar php-shmop && \
    yum -y clean all

# Procedimentos para instalação das bibliotecas php-mcrypt
RUN wget http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-6 && \
    wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
    rpm -ivh epel-release-6-8.noarch.rpm && \
    rm -f epel-release-6-8.noarch.rpm RPM-GPG-KEY-EPEL-6 && \
    yum -y install php-mcrypt

# Configuração do charset do Apache
RUN echo "AddDefaultCharset iso-8859-1" | tee -a /etc/httpd/conf/httpd.conf

# Correção do bug do VirtualBox relacionado ao Sendfile. http://docs.vagrantup.com/v2/synced-folders/virtualbox.html
RUN echo "EnableSendfile Off" | tee -a /etc/httpd/conf/httpd.conf

# Instalação do componentes UploadProgress
RUN pecl install uploadprogress && \
    echo "extension=uploadprogress.so" >> /etc/php.d/uploadprogress.ini

# Configuração dos parâmetros do SEI e SIP
ADD ConfiguracaoSEI.php /opt/sei/ConfiguracaoSEI.php
ADD ConfiguracaoSip.php /opt/sip/ConfiguracaoSip.php

# Copia arquivos necessários para a instalação
ADD sei.ini /etc/php.d/sei.ini

RUN mkdir -p /var/sei/arquivos && \
    chmod -R 777 /var/sei/arquivos

# Configuração dos serviços de background do Cron
RUN mkdir /var/log/sei
RUN sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond
RUN echo "*/5 * * * * root /usr/bin/php -c /etc/php.ini /var/www/html/sei/AgendamentoTarefaSEI.php 2>&1 >> /var/log/sei/agendamento_sei.log" >> /etc/cron.d/sei
RUN echo "*/5 * * * * root /usr/bin/php -c /etc/php.ini /var/www/html/sip/AgendamentoTarefaSip.php 2>&1 >> /var/log/sei/agendamento_sip.log" >> /etc/cron.d/sei

# Script de inicialização do container entry-point
ADD entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

##################### FIM DA INSTALACAO #####################

# Definição do terminal a ser utilizado
ENV TERM xterm

# Exposição da porta de conexão ao Apache
EXPOSE 80

# Inicialização dos serviços Apache e Memcache
CMD ["/entrypoint.sh"]

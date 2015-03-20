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
# Instalação do MySQL seguindo as recomendações descritas na documentação do SEI
# Ref: http://sei.processoeletronico.gov.br/wiki/manual_de_instalacao#<SESSAO DE INSTALAÇÃO DO SEI e SIP>

# Instalação do servidor web Apache 2.2, memcache e demais componentes
RUN yum -y update && \
    yum -y install httpd-2.2.* mysql-5.1.* memcached openssl wget curl unzip gcc java-1.7.0-openjdk libxml2

# Configuração do charset do Apache
RUN echo "AddDefaultCharset iso-8859-1" | tee -a /etc/httpd/conf/httpd.conf

# Correção do bug do VirtualBox relacionado ao Sendfile. http://docs.vagrantup.com/v2/synced-folders/virtualbox.html
RUN echo "EnableSendfile Off" | tee -a /etc/httpd/conf/httpd.conf

# Instalação do PHP 5 e demais bibliotecas
RUN yum -y update && \
    yum -y install php-5.3.* php-common php-cli php-pear php-bcmath php-gd php-gmp \
	php-imap php-intl php-ldap php-mbstring php-mysql php-odbc php-pdo php-pecl-apc \
	php-pspell php-zlib php-snmp php-soap php-xml php-xmlrpc php-zts php-devel \
	php-pecl-apc-devel php-pecl-memcache php-calendar php-shmop

# Instalação do componentes UploadProgress
RUN pecl install uploadprogress && \
    echo "extension=uploadprogress.so" >> /etc/php.d/uploadprogress.ini

# Configuração dos parâmetros do SEI e SIP
ADD ConfiguracaoSEI.php /opt/sei/ConfiguracaoSEI.php
ADD ConfiguracaoSip.php /opt/sip/ConfiguracaoSip.php

# Copia arquivos necessários para a instalação
ADD sei.ini /etc/php.d/sei.ini
ADD run.sh /run.sh
RUN chmod +x /run.sh

##################### FIM DA INSTALACAO #####################

# Exposição da porta de conexão ao Apache
EXPOSE 80

# Inicialização dos serviços Apache e Memcache
CMD ["/run.sh"]
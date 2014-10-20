###########################################################
# Dockerfile de construção do container WebApp 
# utilizado pelo SEI e pelo SIP
#
# Baseado no CentOS 6.X
############################################################

# Define a imagem de base para o CentOS 6.X
FROM centos:centos6

# Autor e mantenedor do container
MAINTAINER MPOG\Guilherme Andrade Del Cantoni

# Atualiza o source list do repositório
RUN yum -y update && yum -y upgrade

################## INICIO DA INSTALACAO ######################
# Instalação do MySQL seguindo as recomendações descritas na documentação do SEI
# Ref: http://<WIKI DO PROJETO>#<SESSAO DE INSTALAÇÃO DO MYSQL>

# Instala o servidor web Apache 2.2 e demais utilitários
RUN yum -y install httpd-2.2.* openssl curl unzip gcc java-1.7.0-openjdk libxml2

# Configura charset do Apache
RUN echo "AddDefaultCharset iso-8859-1" | tee -a /etc/httpd/conf/httpd.conf

# Instala serviço de cache Mencached 
RUN yum -y install memcached

# Instala PHP 5 e demais bibliotecas
RUN yum -y install php-5.3.* php-common php-cli php-pear php-bcmath php-gd php-gmp \
	php-imap php-intl php-ldap php-mbstring php-mysql php-odbc php-pdo php-pecl-apc \
	php-pspell php-zlib php-snmp php-soap php-xml php-xmlrpc php-zts php-devel \
	php-pecl-apc-devel php-pecl-memcache php-calendar php-shmop     

#RUN pecl install uploadprogress
#RUN echo "extension=uploadprogress.so" >> /etc/php.d/uploadprogress.ini

# Instala cliente do MySQL
RUN yum -y install mysql-5.1.*


#ADD infra_css/ /var/www/html/infra_css/
#ADD infra_js/ /var/www/html/infra_js/
#ADD infra_php/ /var/www/html/infra_php/
#ADD sei/ /var/www/html/sei/
#ADD sip/ /var/www/html/sip/


#VOLUME /var/www/html/sei/upload
#VOLUME /var/www/html/sip/upload
#VOLUME /var/sei/dados

# Configura parâmetros do SEI
ADD ConfiguracaoSEI.php /var/www/html/sei/ConfiguracaoSEI.php
ADD ConfiguracaoSip.php /var/www/html/sip/ConfiguracaoSip.php
RUN chmod +r /var/www/html/sei/ConfiguracaoSEI.php
RUN chmod +r /var/www/html/sip/ConfiguracaoSip.php

#RUN ln -s /tmp /var/www/html/sei/upload
#RUN ln -s /tmp /var/www/html/sip/upload
RUN mkdir /var/www/html/sei/upload && chmod -R 666 /var/www/html/sei/upload
RUN mkdir /var/www/html/sip/upload && chmod -R 666 /var/www/html/sip/upload

ONBUILD RUN chown apache:apache /var/www/html/sei/ferramentas/wkhtmltopdf-amd64
ONBUILD RUN chmod +x /var/www/html/sei/ferramentas/wkhtmltopdf-amd64

# Copia arquivos necessários para a instalação
ADD sei.ini /etc/php.d/sei.ini
ADD run.sh /run.sh
RUN chmod +x /run.sh

##################### FIM DA INSTALACAO #####################

# Expõe a porta padrão do MySQL Server
EXPOSE 80

# Default port to execute the entrypoint (MongoDB)
CMD ["/run.sh"]
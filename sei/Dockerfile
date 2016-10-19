##############################################################################
# Dockerfile de construção do container WebApp utilizado pelo SEI e pelo SIP #
##############################################################################

# Definição da imagem de base para o CentOS 6.X
FROM php:5.6-apache

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

ENV TERM xterm

################## INICIO DA INSTALACAO ######################
# Instalação do SEI seguindo as recomendações descritas na documentação do SEI

# Instalação do servidor web Apache 2.2, memcache e demais componentes
# RUN yum install -y epel-release && \
#     yum -y update && \
#     yum -y install httpd-2.4.6 mysql-5.6 openssl wget curl unzip gcc java-1.7.0-openjdk libxml2 dos2unix crontabs \
#     php-5.6.5 php-common php-cli php-pear php-bcmath php-gd php-gmp php-imap php-intl php-ldap php-mbstring php-mysqli \ 
#     php-odbc php-pdo php-pecl-apc php-pspell php-zlib php-snmp php-soap php-xml php-xmlrpc php-zts php-devel \
#     php-pecl-apc-devel php-pecl-memcache php-calendar php-shmop php-intl php-mcrypt php-pecl-xdebug \
#     supervisor gearmand libgearman libgearman-devel php-pecl-gearman && \
#     yum -y clean all

# Obtenção do pacote de instalação do Solr 4.0
COPY install.sh /install.sh

RUN bash /install.sh

# Configuração dos parâmetros do SEI e SIP
ADD ConfiguracaoSEI.php /ConfiguracaoSEI.php
ADD ConfiguracaoSip.php /ConfiguracaoSip.php

# Copia arquivos necessários para a instalação
ADD sei.ini /usr/local/etc/php/conf.d
ADD xdebug.ini /usr/local/etc/php/conf.d
ADD sei.conf /etc/apache2/sites-available/sei.conf

RUN a2ensite sei

# Configuração do Gearman e Supervisor, componentes necessários para a integração do SEI com Processo Eletrônico Nacional
ADD supervisord.conf /etc/supervisor/conf.d/processo-eletronico.conf

#RUN mkdir -p /var/sei/arquivos && \
#    chmod -R 777 /var/sei/arquivos

# Configuração dos serviços de background do Cron
#RUN mkdir /var/log/sei
#RUN sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond
#RUN echo "0 * * * * root /usr/bin/php -c /etc/php.ini /opt/sei/scripts/AgendamentoTarefaSEI.php 2>&1 >> /var/log/sei/agendamento_sei.log" >> /etc/cron.d/sei
#RUN echo "0 * * * * root /usr/bin/php -c /etc/php.ini /opt/sip/scripts/AgendamentoTarefaSip.php 2>&1 >> /var/log/sip/agendamento_sip.log" >> /etc/cron.d/sip
#RUN echo "00 01 * * * root rm -rf /opt/sei/temp/*" >> /etc/cron.d/sei
#RUN echo "00 01 * * * root rm -rf /opt/sip/temp/*" >> /etc/cron.d/sip

# Script de inicialização do container entry-point
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

##################### FIM DA INSTALACAO #####################

# Exposição da porta de conexão ao Apache
EXPOSE 80

# Inicialização dos serviços Apache e Memcache
CMD ["/entrypoint.sh"]


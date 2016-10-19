#!/usr/bin/env bash

set -e

yum install -y epel-release && yum -y update

wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
wget https://centos6.iuscommunity.org/ius-release.rpm
rpm -Uvh ius-release*.rpm

yum -y update

yum -y install httpd24u mysql56u memcached openssl wget curl unzip gcc java-1.7.0-openjdk libxml2 crontabs

# Instalação do PHP e demais extenções necessárias para o projeto
yum -y install php56u php56u-common php56u-cli php56u-pear php56u-bcmath php56u-gd php56u-gmp php56u-imap php56u-intl php56u-ldap php56u-mbstring php56u-mysqli \
    php56u-odbc php56u-pdo php56u-pecl-apc php56u-pspell php56u-zlib php56u-snmp php56u-soap php56u-xml php56u-xmlrpc php56u-zts php56u-devel \
    php56u-pecl-apc-devel php56u-pecl-memcache php56u-calendar php56u-shmop php56u-intl php56u-mcrypt php56u-pecl-xdebug

# Instalação do componentes UploadProgress
pecl install uploadprogress && \
echo "extension=uploadprogress.so" >> /etc/php.d/uploadprogress.ini

# Instalação de componentes para teste do Barramento de Seriços do PEN
yum -y install supervisor gearmand libgearman libgearman-devel php56u-pecl-gearman

# Configuração de permissão do diretório de arquivos
mkdir -p /var/sei/arquivos && \
chmod -R 777 /var/sei/arquivos

# Configuração dos serviços de background do Cron
mkdir /var/log/sei
sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond
echo "0 * * * * root /usr/bin/php -c /etc/php.ini /opt/sei/scripts/AgendamentoTarefaSEI.php 2>&1 >> /var/log/sei/agendamento_sei.log" > /etc/cron.d/sei
echo "0 * * * * root /usr/bin/php -c /etc/php.ini /opt/sip/scripts/AgendamentoTarefaSip.php 2>&1 >> /var/log/sip/agendamento_sip.log" > /etc/cron.d/sip
echo "00 01 * * * root rm -rf /opt/sei/temp/*" >> /etc/cron.d/sei
echo "00 01 * * * root rm -rf /opt/sip/temp/*" >> /etc/cron.d/sip

yum -y clean all

exit 0

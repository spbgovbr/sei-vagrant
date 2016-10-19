#!/usr/bin/env bash

set -e

apt-get -y update

apt-get -y install mysql-client wget unzip openjdk-7-jre bzip2 cron \
  php5-common php-pear php5-gd php5-intl php5-ldap php5-mysql php5-memcached php5-curl php5-json php5-dev php5-xdebug php5-mcrypt \
  php-calendar php-soap php-gettext php-pclzip php-file \
  libapache2-mod-php5filter 

# Instalação do componentes UploadProgress
pecl install uploadprogress
echo "extension=uploadprogress.so" > /etc/php5/mods-available/uploadprogress.ini

# Instalação do Supervisor e Gearman para suporte à integração com o PEN
apt-get -y install supervisor
apt-get -y install gearman libgearman7 php5-gearman

# Configuração de permissão do diretório de arquivos
mkdir -p /var/sei/arquivos && \
chmod -R 777 /var/sei/arquivos

# Configuração dos serviços de background do Cron
mkdir /var/log/sei
echo "0 * * * * root /usr/bin/php -c /etc/php.ini /opt/sei/scripts/AgendamentoTarefaSEI.php 2>&1 >> /var/log/sei/agendamento_sei.log" >> /etc/cron.d/sei
echo "0 * * * * root /usr/bin/php -c /etc/php.ini /opt/sip/scripts/AgendamentoTarefaSip.php 2>&1 >> /var/log/sip/agendamento_sip.log" >> /etc/cron.d/sip
echo "00 01 * * * root rm -rf /opt/sei/temp/*" >> /etc/cron.d/sei
echo "00 01 * * * root rm -rf /opt/sip/temp/*" >> /etc/cron.d/sip

exit 0

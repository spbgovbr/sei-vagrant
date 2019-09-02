#!/usr/bin/env bash

set -e

# Instalação dos componentes básicos do servidor web apache
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
yum -y  update
yum -y install epel-release libmcrypt httpd24u mysql56u memcached openssl wget curl unzip gcc java-1.8.0-openjdk libxml2 crontabs mysql

# Instalação do PHP e demais extenções necessárias para o projeto
yum -y install php56w php56w-common php56w-cli php56w-pear php56w-bcmath php56w-gd php56w-gmp php56w-imap php56w-intl php56w-ldap php56w-mbstring php56w-mysqli \
    php56w-odbc php56w-pdo php56w-pecl-apc php56w-pspell php56w-zlib php56w-snmp php56w-soap php56w-xml php56w-xmlrpc php56w-zts php56w-devel \
    php56w-pecl-apc-devel php56w-pecl-memcache php56w-calendar php56w-shmop php56w-intl php56w-mcrypt php56w-pecl-xdebug

# Configuração do pacote de línguas pt_BR
localedef pt_BR -i pt_BR -f ISO-8859-1

# Instalação do componentes UploadProgress
pecl install uploadprogress && \
echo "extension=uploadprogress.so" >> /etc/php.d/uploadprogress.ini

# Instalação de pacote de fontes do windows
rpm -Uvh /tmp/msttcore-fonts-2.0-3.noarch.rpm

# Instalação dos componentes de conexão do Oracle (Oracle Instant Client)
bash /tmp/install_oracle.sh

# Instalação dos componentes de conexão do SQL Server
yum -y install freetds freetds-devel php56w-mssql

# Configuração de permissão do diretório de arquivos
mkdir -p /var/sei/arquivos
chmod -R 777 /var/sei/arquivos

# Configuração dos serviços de background do Cron
mkdir /var/log/sei
sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond
echo "0 * * * * root /usr/bin/php -c /etc/php.ini /opt/sei/scripts/AgendamentoTarefaSEI.php 2>&1 >> /var/log/sei/agendamento_sei.log" > /etc/cron.d/sei
echo "0 * * * * root /usr/bin/php -c /etc/php.ini /opt/sip/scripts/AgendamentoTarefaSip.php 2>&1 >> /var/log/sip/agendamento_sip.log" > /etc/cron.d/sip
echo "00 01 * * * root rm -rf /opt/sei/temp/*" >> /etc/cron.d/sei
echo "00 01 * * * root rm -rf /opt/sip/temp/*" >> /etc/cron.d/sip

# Remover arquivos temporários
rm -rf /tmp/*
yum clean all

# Configuração de permissões de execução no script de inicialização do container
chmod +x /entrypoint.sh

exit 0

#!/usr/bin/env bash
set -e

# Instalação dos componentes básicos do servidor web apache
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install yum-utils
yum -y install epel-release libmcrypt httpd24u mysql56u memcached openssl wget curl unzip gcc java-1.8.0-openjdk libxml2 crontabs mysql

# Instalação do PHP e demais extenções necessárias para o projeto
yum -y install php56 php-pear php56-php-devel php56-php-common php56-php-cli php56-php-pear php56-php-bcmath php56-php-gd php56-php-gmp php56-php-imap php56-php-intl php56-php-ldap php56-php-mbstring php56-php-mysqli \
    php56-php-odbc php56-php-pdo php56-php-pecl-apc php56-php-pspell php56-php-zlib php56-php-snmp php56-php-soap php56-php-xml php56-php-xmlrpc php56-php-zts php56-php-devel \
    php56-php-pecl-apc-devel php56-php-pecl-memcache php56-php-calendar php56-php-shmop php56-php-intl php56-php-mcrypt php56-php-pecl-xdebug

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
yum -y install freetds freetds-devel php56-php-mssql

# Configuração de permissão do diretório de arquivos
mkdir -p /var/sei/arquivos
chmod -R 777 /var/sei/arquivos

# Configuração dos serviços de background do Cron
mkdir /var/log/sei
sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond
echo "* * * * * root /usr/bin/php -c /etc/php.ini /opt/sei/scripts/AgendamentoTarefaSEI.php 2>&1 >> /var/log/sei/agendamento_sei.log" > /etc/cron.d/sei
echo "* * * * * root /usr/bin/php -c /etc/php.ini /opt/sip/scripts/AgendamentoTarefaSip.php 2>&1 >> /var/log/sip/agendamento_sip.log" > /etc/cron.d/sip
echo "00 01 * * * root rm -rf /opt/sei/temp/*" >> /etc/cron.d/sei
echo "00 01 * * * root rm -rf /opt/sip/temp/*" >> /etc/cron.d/sip

# Remover arquivos temporários
rm -rf /tmp/*
yum clean all

# Configuração de permissões de execução no script de inicialização do container
chmod +x /entrypoint.sh

exit 0

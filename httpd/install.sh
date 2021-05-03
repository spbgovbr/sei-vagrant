#!/usr/bin/env bash

# Instalação dos componentes básicos do servidor web apache
yum -y install epel-release yum-utils

# Configurando para instalar a versão 7.3 do PHP e desabilitando a 5.4
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --disable remi-php54
yum-config-manager --enable remi-php73
yum -y  update

yum -y install build-essential libmcrypt httpd memcached openssl wget curl unzip gcc java-1.8.0-openjdk \
                libxml2 crontabs mysql policycoreutils policycoreutils-python setools setools-console \
                setroubleshoot whatprovides netstat net-tools \
                vim git nc libgearman-dev libgearman-devel


# Instalação do PHP e demais extenções necessárias para o projeto
yum -y install php php-pear php-devel php-calendar php-mcrypt php-shmop php-zlib php-zts php-soap php-gd php-bcmath \
               php73.x86_64 php-bcmath.x86_64 php-cli.x86_64 php-common.x86_64 php-devel.x86_64 php-gd.x86_64 \
               php73pat-php-gmp.x86_64 php-imap.x86_64 php-intl.x86_64 php-ldap.x86_64 php-mbstring.x86_64 php-mysqlnd.x86_64 \
               php-mysqli php-mysqli php-odbc.x86_64 php-pdo.x86_64 php-pear.noarch php-pecl-apcu.x86_64 php-pecl-apcu-devel.x86_64 \
               php-pecl-memcache php-pecl-memcache.x86_64 php-pecl-xdebug.x86_64 php-pspell.x86_64 php-snmp.x86_64 \
               php-pecl-igbinary.x86_64 php-pecl-igbinary-devel.x86_64  php-soap.x86_64 php-xml.x86_64 php-xmlrpc.x86_64 php-xdebug               


# Configuração do pacote de línguas pt_BR
localedef pt_BR -i pt_BR -f ISO-8859-1

# Instalação do componentes UploadProgress
tar -zxvf /tmp/uploadprogress.tgz
cd uploadprogress
phpize
./configure --enable-uploadprogress
make
make install
echo "extension=uploadprogress.so" > /etc/php.d/uploadprogress.ini

pecl install xdebug

# Instalação de pacote de fontes do windows
rpm -Uvh /tmp/msttcore-fonts-2.0-3.noarch.rpm

# Instalação dos componentes de conexão do Oracle (Oracle Instant Client)
bash /tmp/install_oracle.sh

# Instalação dos componentes de conexão do SQL Server
yum -y install freetds freetds-devel php-mssql

# Configuração de permissão do diretório de arquivos
mkdir -p /var/sei/arquivos
chmod -R 777 /var/sei/arquivos

# Configuração dos serviços de background do Cron
mkdir /var/log/sei
sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond

# Remover arquivos temporários
rm -rf /tmp/*
yum clean all

# Configuração de permissões de execução no script de inicialização do container
chmod +x /entrypoint.sh

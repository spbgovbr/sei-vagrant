#!/usr/bin/env bash

# Instalação dos componentes básicos do servidor web apache
yum install -y epel-release yum-utils

# Configurando para instalar a versão 7.3 do PHP e desabilitando a 5.4
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --disable remi-php54
yum-config-manager --enable remi-php73
yum update -y 

yum install -y http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum install -y https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox-0.12.6-1.centos7.x86_64.rpm

# Instalação de ferramentas utilitárias e dependências do SEI 4.0
yum install -y build-essential libmcrypt httpd memcached openssl wget curl unzip gcc java-1.8.0-openjdk \
               libxml2 crontabs mysql netstat net-tools vim git nc libgearman-dev libgearman-devel ffmpeg

# Instalação do PHP e demais extenções necessárias para o projeto
yum install -y php php-pear php-devel php-calendar php-mcrypt php-shmop php-zlib php-zts php-soap php-gd php-bcmath \
               php-cli php-common php73pat-php-gmp php-imap php-intl php-ldap php-mbstring \
               php-mysqlnd php-mysqli php-odbc php-pdo php-pecl-apcu php-pecl-apcu-devel php-curl \
               php-pecl-memcache php-pspell php-snmp php-pecl-igbinary php-pecl-igbinary-devel \
               php-xml php-xmlrpc php-zip php-json php-sodium

yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

yum install -y libpq postgresql15 postgresql15-libs php-pgsql php-pecl-pq

# Instalação do XDebug, versão 3
pecl install xdebug-3.0.4

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

# Instalação de pacote de fontes do windows
rpm -Uvh /tmp/msttcore-fonts-2.0-3.noarch.rpm

# Instalação dos componentes de conexão do Oracle (Oracle Instant Client)
bash /tmp/install_oracle.sh

# Instalação dos componentes de conexão do SQL Server
curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo
ACCEPT_EULA=Y yum install -y msodbcsql17
yum install -y libodbc1 unixODBC unixODBC-devel php-mssql php-pdo
pecl install sqlsrv pdo_sqlsrv
printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php.d/20-sqlsrv.ini
printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php.d/30-pdo_sqlsrv.ini

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

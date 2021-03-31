#!/usr/bin/env bash

# Instalação dos componentes básicos do servidor web apache
yum -y install epel-release yum-utils
rpm -Uvh http://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y  update
yum -y install epel-release libmcrypt httpd24u mysql56u memcached openssl wget curl unzip gcc java-1.8.0-openjdk libxml2 crontabs mysql

#configurando para instalar a versão 7.3 do PHP e desabilitando a 5.4
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --disable remi-php54
yum-config-manager --enable remi-php73

# Instalação do PHP e demais extenções necessárias para o projeto
yum -y install php php-pear php-devel php-calendar php-mcrypt php-shmop php-zlib php-zts php73.x86_64 php73-php-bcmath.x86_64 \
               php73-php-cli.x86_64 php73-php-common.x86_64 php73-php-devel.x86_64 php73-php-gd.x86_64 php73-php-gmp.x86_64 \
               php73-php-imap.x86_64 php73-php-intl.x86_64 php73-php-ldap.x86_64 php73-php-mbstring.x86_64 php73-php-mysqlnd.x86_64 php73-php-mysqli php-mysqli \
               php73-php-odbc.x86_64 php73-php-pdo.x86_64 php73-php-pear.noarch php73-php-pecl-apcu.x86_64 php73-php-pecl-apcu-devel.x86_64 \
               php73-php-pecl-memcache.x86_64 php73-php-pecl-xdebug.x86_64 php73-php-pspell.x86_64 php73-php-snmp.x86_64 \
               php73-php-soap.x86_64 php73-php-xml.x86_64 php73-php-xmlrpc.x86_64 php-xdebug


# Configuração do pacote de línguas pt_BR
localedef pt_BR -i pt_BR -f ISO-8859-1

# Instalação do componentes UploadProgress
#pecl install uploadprogress-1.0.3.1 php73-php-pecl-uploadprogress-1.1.3-1.el7.remi.x86_64.rpm
yum -y install centos-release-scl
yum -y --enablerepo=centos-sclo-sclo-testing install sclo-php73-php-pecl-uploadprogress
yum -y php73-php-pecl-uploadprogress-1.1.3-1.el7.remi.x86_64.rpm
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

# Remover arquivos temporáriosy
rm -rf /tmp/*
yum clean all

# Configuração de permissões de execução no script de inicialização do container
chmod +x /entrypoint.sh

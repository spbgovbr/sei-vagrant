#!/usr/bin/env bash

set -e

# Instalação de dependêcias do projeto
yum -y install php-dev libaio systemtap-sdt-devel

# Instala?o dos pacotes Basic e SDK Instant Client
yum install -y /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
yum install -y /tmp/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
yum install -y /tmp/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm

# Configuração de diretório do Oracle Instant Client no dynamic linker/loader
echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf
ldconfig

# Instalação dos OCI8 extension
pecl channel-update pecl.php.net 
export PHP_DTRACE=yes && printf "\n " | pecl install oci8-2.2.0 && unset PHP_DTRACE

# Habilitação da extensão do Oracle 
echo "extension=oci8.so" > /etc/php.d/oci8.ini


exit 0

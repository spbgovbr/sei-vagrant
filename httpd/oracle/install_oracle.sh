#!/usr/bin/env bash

set -e

# Instala?o de depend?cias do projeto
yum -y install libaio

# Instala?o dos pacotes Basic e SDK Instant Client
rpm -Uvh /tmp/oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
rpm -Uvh /tmp/oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm 
rpm -Uvh /tmp/oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm

# Instala?o dos OCI8 extension
printf "\n" | pecl install oci8-2.0.12

# Habilita?o da extens? do Oracle 
echo "extension=oci8.so" > /etc/php.d/oci8.ini

# Configura?o de diret?io do Oracle Instant Client no dynamic linker/loader
echo "/usr/lib/oracle/11.2/client64/lib" > /etc/ld.so.conf.d/oracle-11.conf

exit 0

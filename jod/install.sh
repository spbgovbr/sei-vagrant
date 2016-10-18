#!/usr/bin/env bash

set -e

# Instalação do pacote Java JDK e utilitários utilizados no provisionamento
apt-get -y update
apt-get install -y --no-install-recommends wget unzip dos2unix libreoffice
apt-get -y clean all

# Instalação da api de serviços de conversão de documentos
unzip /opt/jodconverter-tomcat-2.2.2.zip -d /opt 
rm /opt/jodconverter-tomcat-2.2.2.zip

# Script de inicialização do container entry-point
dos2unix /entrypoint.sh 
chmod +x /entrypoint.sh

exit 0

#!/usr/bin/env bash
set -e

# Instalação do pacote Java JDK e utilitários utilizados no provisionamento
yum -y update
yum install -y java-1.7.0-openjdk-devel wget unzip dos2unix libreoffice libreoffice-headless && \
yum -y clean all

# Instalação da api de serviços de conversão de documentos
unzip /tmp/jodconverter-tomcat-2.2.2.zip -d /opt
rm /tmp/jodconverter-tomcat-2.2.2.zip

# Script de inicialização do container entry-point
chmod +x /entrypoint.sh

exit 0

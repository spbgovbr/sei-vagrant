#!/usr/bin/env sh
set -e

# Configuração do pacote de línguas pt_BR
localedef pt_BR -i pt_BR -f ISO-8859-1

# Instalação do utilitários necessários para o provisionamento
yum -y install unzip java-1.7.0-openjdk wget unzip libreoffice libreoffice-headless

# Instalação da api de serviços de conversão de documentos
unzip /tmp/jodconverter-tomcat-2.2.2.zip -d /opt

# Remover arquivos temporários
rm -rf /tmp/*
yum clean all

# Configuração de permissões de execução no script de inicialização do container
chmod +x /entrypoint.sh

exit 0

#!/usr/bin/env sh
set -e

# Instalação do utilitários necessários para o provisionamento
yum -y install unzip java-1.7.0-openjdk

# Instalação da api de serviços de conversão de documentos
unzip /tmp/jodconverter-tomcat-2.2.2.zip -d /opt

# Remover arquivos temporários
rm -rf /tmp/*
yum clean all


# Configuração de permissões de execução no script de inicialização do container
chmod +x /entrypoint.sh

exit 0

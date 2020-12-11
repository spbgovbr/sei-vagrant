#!/usr/bin/env sh

set -e

# Instalação do pacote Java JDK e utilitários utilizados no provisionamento
#apk update && apk add lsof curl bash openjdk8-jre
yum -y update && yum -y install lsof curl wget java-1.8.0-openjdk

# Instalação de pacote de fontes do windows
rpm -Uvh /tmp/msttcore-fonts-2.0-3.noarch.rpm

# Configuração do pacote de línguas pt_BR
localedef pt_BR -i pt_BR -f ISO-8859-1

# Download do Solr, versão 6.1.0
SOLR_URL=https://archive.apache.org/dist/lucene/solr/6.1.0/solr-6.1.0.tgz
wget -nv $SOLR_URL -O /tmp/solr-6.1.0.tgz

# Instalação do Apache Solr 6.1
sh /tmp/sei-solr-6.1.0.sh

# Construção dos índices de protocolos do SEI
/opt/solr/bin/solr start && sleep 15

curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-protocolos&instanceDir=/dados/sei-protocolos&config=sei-protocolos-config.xml&schema=sei-protocolos-schema.xml&dataDir=/dados/sei-protocolos/conteudo'
curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-bases-conhecimento&instanceDir=/dados/sei-bases-conhecimento&config=sei-bases-conhecimento-config.xml&schema=sei-bases-conhecimento-schema.xml&dataDir=/dados/sei-bases-conhecimento/conteudo'
curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-publicacoes&instanceDir=/dados/sei-publicacoes&config=sei-publicacoes-config.xml&schema=sei-publicacoes-schema.xml&dataDir=/dados/sei-publicacoes/conteudo'

# Remover arquivos temporários
rm -rf /tmp/*
yum clean all

# Configuração de permissões de execução no script de inicialização do container
chmod +x /entrypoint.sh

exit 0

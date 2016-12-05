#!/usr/bin/env sh

set -e

# Instalação do pacote Java JDK e utilitários utilizados no provisionamento
#apk update && apk add lsof curl bash openjdk8-jre
yum -y update && yum -y install lsof curl java-1.8.0-openjdk

# Instalação do Apache Solr 6.1
sh /tmp/sei-solr-6.1.0.sh

# Construção dos índices de protocolos do SEI
/opt/solr/bin/solr start && sleep 10

curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-protocolos&instanceDir=/dados/sei-protocolos&config=sei-protocolos-config.xml&schema=sei-protocolos-schema.xml&dataDir=/dados/sei-protocolos/conteudo'
curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-bases-conhecimento&instanceDir=/dados/sei-bases-conhecimento&config=sei-bases-conhecimento-config.xml&schema=sei-bases-conhecimento-schema.xml&dataDir=/dados/sei-bases-conhecimento/conteudo'
curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-publicacoes&instanceDir=/dados/sei-publicacoes&config=sei-publicacoes-config.xml&schema=sei-publicacoes-schema.xml&dataDir=/dados/sei-publicacoes/conteudo'

# Remover arquivos temporários
rm -rf /tmp/*
yum clean all

# Configuração de permissões de execução no script de inicialização do container
chmod +x /entrypoint.sh

exit 0

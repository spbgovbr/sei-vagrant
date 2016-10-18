#!/usr/bin/env bash

set -e

# Instalação do pacote Java JDK e utilitários utilizados no provisionamento
apt-get update && apt-get install -y lsof && apt-get -y clean all

# Instalação do Apache Solr
bash /tmp/sei-solr-6.1.0.sh

# Construção dos índices de protocolos do SEI
/opt/solr/bin/solr start && sleep 20 && \
    curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-protocolos&instanceDir=/dados/sei-protocolos&config=sei-protocolos-config.xml&schema=sei-protocolos-schema.xml&dataDir=/dados/sei-protocolos/conteudo'

# Construção dos índices da base de conhecimento do SEI
/opt/solr/bin/solr start && sleep 20 && \
    curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-bases-conhecimento&instanceDir=/dados/sei-bases-conhecimento&config=sei-bases-conhecimento-config.xml&schema=sei-bases-conhecimento-schema.xml&dataDir=/dados/sei-bases-conhecimento/conteudo'

# Construção dos índices de publicações do SEI
/opt/solr/bin/solr start && sleep 20 && \
    curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-publicacoes&instanceDir=/dados/sei-publicacoes&config=sei-publicacoes-config.xml&schema=sei-publicacoes-schema.xml&dataDir=/dados/sei-publicacoes/conteudo'

# Remover arquivos desnecessários
rm -rf /tmp/*

exit 0

#!/bin/sh

clear

for n in /tmp/solr-6.1.0.tgz /tmp/log4j.properties /tmp/sei-protocolos-config.xml /tmp/sei-protocolos-schema.xml /tmp/sei-bases-conhecimento-config.xml /tmp/sei-bases-conhecimento-schema.xml /tmp/sei-publicacoes-config.xml /tmp/sei-publicacoes-schema.xml
 do
  if [ ! -f $n ]; then
      echo "Arquivo ["$n"] nao encontrado."
      exit 1
  fi
done

cd /tmp

tar -xf /tmp/solr-6.1.0.tgz

cp -Rf /tmp/solr-6.1.0 /opt/solr

mkdir -v /dados

ln -vs /dados /opt/solr/server/solr

cp -Rfv /tmp/log4j.properties /opt/solr/server/resources

mkdir -v /dados/sei-protocolos
mkdir -v /dados/sei-bases-conhecimento
mkdir -v /dados/sei-publicacoes

cp -R /opt/solr/example/files/conf /dados/sei-protocolos
cp -R /opt/solr/example/files/conf /dados/sei-bases-conhecimento
cp -R /opt/solr/example/files/conf /dados/sei-publicacoes

rm -v /dados/sei-protocolos/conf/solrconfig.xml
rm -v /dados/sei-bases-conhecimento/conf/solrconfig.xml
rm -v /dados/sei-publicacoes/conf/solrconfig.xml

cp -v /tmp/sei-protocolos-*.xml /dados/sei-protocolos/conf
cp -v /tmp/sei-bases-conhecimento-*.xml /dados/sei-bases-conhecimento/conf
cp -v /tmp/sei-publicacoes-*.xml /dados/sei-publicacoes/conf

cp -v /opt/solr/example/example-DIH/solr/solr/conf/admin-extra* /dados/sei-protocolos/conf
cp -v /opt/solr/example/example-DIH/solr/solr/conf/admin-extra* /dados/sei-bases-conhecimento/conf
cp -v /opt/solr/example/example-DIH/solr/solr/conf/admin-extra* /dados/sei-publicacoes/conf

mkdir -v /dados/sei-protocolos/conteudo
mkdir -v /dados/sei-bases-conhecimento/conteudo
mkdir -v /dados/sei-publicacoes/conteudo

ln -vs /opt/solr/contrib /dados/sei-protocolos/contrib
ln -vs /opt/solr/dist /dados/sei-protocolos/dist

ln -vs /opt/solr/contrib /dados/sei-bases-conhecimento/contrib
ln -vs /opt/solr/dist /dados/sei-bases-conhecimento/dist

ln -vs /opt/solr/contrib /dados/sei-publicacoes/contrib
ln -vs /opt/solr/dist /dados/sei-publicacoes/dist

rm -R /opt/solr/example

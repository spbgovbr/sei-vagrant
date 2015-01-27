###########################################################
# Dockerfile de construção do container Solr
# utilizado pelo SEI e pelo SIP
#
# Baseado no CentOS 6.X
############################################################

# Definição da imagem de base para o CentOS 6.X
FROM centos:centos6

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

################## INICIO DA INSTALACAO ######################
# Instalação do MySQL seguindo as recomendações descritas na documentação do SEI
# Ref: http://<WIKI DO PROJETO>#<SESSAO DE INSTALAÇÃO DO MYSQL>

# Instalação do pacote Java JDK 
RUN yum update -y java-1.7.0-openjdk && \ 
    yum install -y java-1.7.0-openjdk

# Instalação dos utilitários utilizados no provisionamento
RUN yum install -y wget tar curl which

# Criação de usuário de execução do serviço
RUN useradd solr

# Obtenção do pacote de instalação do Solr 4.0
RUN wget -q -O /opt/solr-4.0.0.tgz http://archive.apache.org/dist/lucene/solr/4.0.0/apache-solr-4.0.0.tgz

# Instalação do Apache Solr
RUN tar xvz -C /opt -f /opt/solr-4.0.0.tgz && mv /opt/apache-solr-4.0.0 /opt/solr && \
    chown -R solr:solr /opt/solr && rm /opt/solr-4.0.0.tgz

# Configuração dos parâmetros default
RUN echo "JAVA_OPTIONS='-Dsolr.solr.home=/opt/solr/example/solr $JAVA_OPTIONS'" | tee -a /etc/default/jetty && \
    echo "JETTY_HOME=/opt/solr/example" | tee -a /etc/default/jetty && \
    echo "JETTY_USER=solr" | tee -a /etc/default/jetty

# Configuração do script de inicialização automática
RUN wget -q -O /etc/init.d/solr https://raw.githubusercontent.com/eclipse/jetty.project/jetty-7/jetty-distribution/src/main/resources/bin/jetty.sh && chmod +x /etc/init.d/solr

# Criação dos diretório de armazenamento de índices
RUN mkdir /var/opt/sei && \
    mkdir /var/opt/sei/sei-protocolos && ln -s /var/opt/sei/sei-protocolos  /opt/solr/example/solr/ && \
    mkdir /var/opt/sei/sei-bases-conhecimento && ln -s /var/opt/sei/sei-bases-conhecimento  /opt/solr/example/solr/ && \
    mkdir /var/opt/sei/sei-publicacoes && ln -s /var/opt/sei/sei-publicacoes /opt/solr/example/solr/

# Copia do conjunto de configurações padrão do Solr 
RUN cp -R /opt/solr/example/solr/collection1/conf /var/opt/sei/sei-protocolos/ && \
    cp -R /opt/solr/example/solr/collection1/conf /var/opt/sei/sei-bases-conhecimento/ && \
    cp -R /opt/solr/example/solr/collection1/conf /var/opt/sei/sei-publicacoes/

# Removeção dos arquivos schema.xml e solrconfig.xml das cópias
RUN rm /var/opt/sei/sei-protocolos/conf/schema.xml && \
    rm /var/opt/sei/sei-protocolos/conf/solrconfig.xml && \
    rm /var/opt/sei/sei-bases-conhecimento/conf/schema.xml && \
    rm /var/opt/sei/sei-bases-conhecimento/conf/solrconfig.xml && \
    rm /var/opt/sei/sei-publicacoes/conf/schema.xml && \
    rm /var/opt/sei/sei-publicacoes/conf/solrconfig.xml

# Configuração dos índices do SEI
ADD index/sei-protocolos-schema.xml /var/opt/sei/sei-protocolos/conf/sei-protocolos-schema.xml
ADD index/sei-bases-conhecimento-schema.xml /var/opt/sei/sei-bases-conhecimento/conf/sei-bases-conhecimento-schema.xml
ADD index/sei-publicacoes-schema.xml /var/opt/sei/sei-publicacoes/conf/sei-publicacoes-schema.xml
ADD index/sei-protocolos-config.xml /var/opt/sei/sei-protocolos/conf/sei-protocolos-config.xml
ADD index/sei-bases-conhecimento-config.xml /var/opt/sei/sei-bases-conhecimento/conf/sei-bases-conhecimento-config.xml
ADD index/sei-publicacoes-config.xml /var/opt/sei/sei-publicacoes/conf/sei-publicacoes-config.xml

# Criação de diretório de conteúdo para os índices
RUN mkdir /var/opt/sei/sei-protocolos/conteudo && \
    mkdir /var/opt/sei/sei-bases-conhecimento/conteudo && \
    mkdir /var/opt/sei/sei-publicacoes/conteudo

# Configuração dos links a instalação do Solr e o índice Protocolo
RUN ln -s /opt/solr/contrib/ /var/opt/sei/sei-protocolos/contrib && \
	ln -s /opt/solr/dist/ /var/opt/sei/sei-protocolos/dist && \
	ln -s /opt/solr/example/lib/ /var/opt/sei/sei-protocolos/lib

# Configuração dos links a instalação do Solr e o índice Base de Conhecimento
RUN ln -s /opt/solr/contrib/ /var/opt/sei/sei-bases-conhecimento/contrib && \
	ln -s /opt/solr/dist/ /var/opt/sei/sei-bases-conhecimento/dist && \
	ln -s /opt/solr/example/lib/ /var/opt/sei/sei-bases-conhecimento/lib

# Configuração dos links a instalação do Solr e o índice Publicações
RUN ln -s /opt/solr/contrib/ /var/opt/sei/sei-publicacoes/contrib && \
	ln -s /opt/solr/dist/ /var/opt/sei/sei-publicacoes/dist && \
	ln -s /opt/solr/example/lib/ /var/opt/sei/sei-publicacoes/lib

# Configuração de log e permissões de pastas
RUN mkdir /var/log/solr
RUN chown solr:solr -R /opt/solr /var/opt/sei /var/log/solr 

# Construção dos índices de protocolos do SEI
RUN service solr start && sleep 20 && \
	curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-protocolos&instanceDir=/var/opt/sei/sei-protocolos&config=sei-protocolos-config.xml&schema=sei-protocolos-schema.xml&dataDir=/var/opt/sei/sei-protocolos/conteudo'

# Construção dos índices da base de conhecimento do SEI
RUN service solr start && sleep 20 && \    
	curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-bases-conhecimento&instanceDir=/var/opt/sei/sei-bases-conhecimento&config=sei-bases-conhecimento-config.xml&schema=sei-bases-conhecimento-schema.xml&dataDir=/var/opt/sei/sei-bases-conhecimento/conteudo'

# Construção dos índices de publicações do SEI
RUN service solr start && sleep 20 && \    
	curl 'http://localhost:8983/solr/admin/cores?action=CREATE&name=sei-publicacoes&instanceDir=/var/opt/sei/sei-publicacoes&config=sei-publicacoes-config.xml&schema=sei-publicacoes-schema.xml&dataDir=/var/opt/sei/sei-publicacoes/conteudo'

# Construção dos índices de publicações do SEI
RUN service solr start && sleep 20 && \ 
    curl 'http://localhost:8983/solr/admin/cores?action=RELOAD&core=sei-protocolos' && \
    curl 'http://localhost:8983/solr/admin/cores?action=RELOAD&core=sei-bases-conhecimento' && \
    curl 'http://localhost:8983/solr/admin/cores?action=RELOAD&core=sei-publicacoes'

##################### FIM DA INSTALACAO #####################
WORKDIR /opt/solr/example

# Exposição da porta de conexão ao Apache
EXPOSE 8983

# Inicialização dos serviços Apache e Memcache
CMD ["java", "-jar", "start.jar"]

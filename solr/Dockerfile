############################################################################
# Dockerfile de construção do container Solr utilizado pelo SEI e pelo SIP #
############################################################################

# Definição da imagem de base para o OpenJDK 8
FROM openjdk:8

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

################## INICIO DA INSTALACAO ######################

ENV TERM xterm

# Obtenção do pacote de instalação do Solr 4.0
COPY install.sh /install.sh
COPY solr-6.1.0.tgz /tmp/
COPY index/* /tmp/

RUN bash /install.sh

##################### FIM DA INSTALACAO #####################

# Exposição da porta de conexão ao Apache
EXPOSE 8983

# Inicialização dos serviços Apache e Memcache
CMD ["/opt/solr/bin/solr", "start", "-f", "-p", "8983"]

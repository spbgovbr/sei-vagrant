############################################################
# Dockerfile de construção do container do MySQL utilizado pelo SEI e pelo SIP
############################################################

# Definição da imagem de base para o CentOS 6.X
FROM centos:centos6

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

################## INICIO DA INSTALACAO ######################
# Instalação do MySQL seguindo as recomendações descritas na documentação do SEI

ENV TERM xterm


COPY install.sh /install.sh
COPY sei-db-ref-executivo/mysql/sei_3_0_0_BD_Ref_Exec.sql /tmp/sei_mysql.sql
COPY sei-db-ref-executivo/mysql/sip_3_0_0_BD_Ref_Exec.sql /tmp/sip_mysql.sql

RUN bash /install.sh

# Exposição da porta de conexão ao MySQL Server
EXPOSE 3306
 
# Inicialização do serviço 
CMD ["/usr/bin/mysqld_safe", "--bind-address=0.0.0.0"]


############################################################
# Dockerfile de construção do container do MySQL utilizado pelo SEI e pelo SIP
############################################################

# Definição da imagem de base para o CentOS 6.X
FROM mysql/mysql-server:5.7

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

################## INICIO DA INSTALACAO ######################
# Instalação do MySQL seguindo as recomendações descritas na documentação do SEI

ENV TERM xterm
ENV MYSQL_ALLOW_EMPTY_PASSWORD 'yes'

COPY install.sh /install.sh
COPY 1-preinstall.sql /tmp/1-preinstall.sql
COPY sei-db-ref-executivo/mysql/sei_3_0_0_BD_Ref_Exec.sql /tmp/2-sei_mysql.sql
COPY sei-db-ref-executivo/mysql/sip_3_0_0_BD_Ref_Exec.sql /tmp/3-sip_mysql.sql
COPY 4-posinstall.sql /tmp/4-posinstall.sql

RUN bash /install.sh


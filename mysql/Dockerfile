############################################################
# Dockerfile de construção do container do MySQL 
# utilizado pelo SEI e pelo SIP
#
# Baseado no CentOS 6.X
############################################################

# Definição da imagem de base para o CentOS 6.X
FROM mysql/mysql-server:5.7

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

################## INICIO DA INSTALACAO ######################
# Instalação do MySQL seguindo as recomendações descritas na documentação do SEI

ENV MYSQL_ALLOW_EMPTY_PASSWORD 'yes'
#ENV MYSQL_DATABASE 'sei'
#ENV MYSQL_USER 'sei_user'
#ENV MYSQL_PASSWORD 'sei_user' 

# Cópia dos backups dos bancos de dados do SEI e SIP
#ADD sei-db-ref-executivo/mysql/sei_2_6_0_BD_Ref_Exec.sql /opt/sei_mysql.sql
#ADD sei-db-ref-executivo/mysql/sip_2_6_0_BD_Ref_Exec.sql /opt/sip_mysql.sql

COPY 1-preinstall.sql /tmp/1-preinstall.sql
COPY sei-db-ref-executivo/mysql/sei_2_6_0_BD_Ref_Exec.sql /tmp/2-sei_mysql.sql
COPY sei-db-ref-executivo/mysql/sip_2_6_0_BD_Ref_Exec.sql /tmp/3-sip_mysql.sql
COPY 4-posinstall.sql /tmp/4-posinstall.sql

#ADD my.cnf /etc/my.cnf
#ADD install.sh /install.sh

# Instalação do MySQL 5.7 e demais componentes
#RUN bash install.sh

RUN cat /tmp/1-preinstall.sql  > /docker-entrypoint-initdb.d/install.sql && \
    echo "USE sei;"           >> /docker-entrypoint-initdb.d/install.sql && \
    cat /tmp/2-sei_mysql.sql  >> /docker-entrypoint-initdb.d/install.sql && \ 
    echo "USE sip;"           >> /docker-entrypoint-initdb.d/install.sql && \
    cat /tmp/3-sip_mysql.sql  >> /docker-entrypoint-initdb.d/install.sql && \
    cat /tmp/4-posinstall.sql >> /docker-entrypoint-initdb.d/install.sql

##################### FIM DA INSTALACAO #####################

# Definição do terminal a ser utilizado
#ENV TERM xterm

# Exposição da porta de conexão ao MySQL Server
#EXPOSE 3306

# Inicialização do serviço 
#CMD ["/usr/bin/mysqld_safe", "--bind-address=0.0.0.0"]

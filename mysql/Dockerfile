############################################################
# Dockerfile de construção do container do MySQL 
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
# Ref: https://processoeletronico.gov.br/projects/sei/wiki

# Instalação do MySQL Server 5.X
RUN yum update -y && \
    yum install -y mysql-server-5.* && \
    yum -y clean all

# Cópia dos backups dos bancos de dados do SEI e SIP
#ADD .tmp/sei_mysql.sql /tmp/sei_mysql.sql
#ADD .tmp/sip_mysql.sql /tmp/sip_mysql.sql
ADD sei-db-ref-executivo/mysql/sei_2_6_0_BD_Ref_Exec.sql /tmp/sei_mysql.sql
ADD sei-db-ref-executivo/mysql/sip_2_6_0_BD_Ref_Exec.sql /tmp/sip_mysql.sql
ADD my.cnf /etc/my.cnf

# Configuração da estrutura inicial do banco de dados
RUN mysql_install_db

# Criação dos bancos de dados do sistema
RUN /etc/init.d/mysqld start && \
    mysqladmin create sip && \
    mysqladmin create sei

# Criação dos usuários utilizados na conexão com SEI e SIP 
RUN /etc/init.d/mysqld start && \
    mysql -e "CREATE USER 'sip_user'@'%' IDENTIFIED BY 'sip_user'" sip && \
    mysql -e "CREATE USER 'sei_user'@'%' IDENTIFIED BY 'sei_user'" sei && \
    mysql -e "GRANT ALL PRIVILEGES ON sip.* TO 'sip_user'@'%'" sip && \
    mysql -e "GRANT ALL PRIVILEGES ON sei.* TO 'sei_user'@'%'" sei 

# Restauração dos bancos de dados
RUN /etc/init.d/mysqld start && cd /tmp && \
    mysql sei < sei_mysql.sql && \
    mysql sip < sip_mysql.sql && \
    rm -f /tmp/sei_mysql.sql /tmp/sip_mysql.sql

# Atualização dos parâmetros do SEI e do SIP
RUN /etc/init.d/mysqld start && \
    mysql -e "update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;" sip && \
    mysql -e "update sistema set pagina_inicial='http://localhost/sip' where sigla='SIP';" sip && \ 
    mysql -e "update sistema set pagina_inicial='http://localhost/sei/inicializar.php', web_service='http://localhost/sei/controlador_ws.php?servico=sip' where sigla='SEI';" sip && \
    mysql -e "update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;" sei

# Temp: Remove registros de auditoria presentes na base de referência
RUN /etc/init.d/mysqld start && \
    mysql -e "delete from auditoria_protocolo;" sei

# Configuração para utilizar autenticação nativa do SEI/SIP
RUN /etc/init.d/mysqld start && \
    mysql -e "update orgao set sin_autenticar='N' where id_orgao=0;" sip

# Atribuição de permissões de acesso externo para o usuário root, senha root
RUN /etc/init.d/mysqld start && \
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"

##################### FIM DA INSTALACAO #####################

# Definição do terminal a ser utilizado
ENV TERM xterm

# Exposição da porta de conexão ao MySQL Server
EXPOSE 3306

# Inicialização do serviço 
CMD ["/usr/bin/mysqld_safe", "--bind-address=0.0.0.0"]

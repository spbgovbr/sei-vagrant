############################################################
# Dockerfile de construção do container do MySQL 
# utilizado pelo SEI e pelo SIP
#
# Baseado no CentOS 6.X
############################################################

# Define a imagem de base para o CentOS 6.X
FROM centos:centos6

# Autor e mantenedor do container
MAINTAINER MPOG\Guilherme Andrade Del Cantoni

# Atualiza o source list do repositório
RUN yum -y update && yum -y upgrade

# Copia arquivos necessários para a instalação
ADD SEI-BD-MySQL-v2.5.1.zip /tmp/SEI-BD-MySQL-v2.5.1.zip
	
################## INICIO DA INSTALACAO ######################
# Instalação do MySQL seguindo as recomendações descritas na documentação do SEI
# Ref: http://<WIKI DO PROJETO>#<SESSAO DE INSTALAÇÃO DO MYSQL>

# Instala o pacote do MySQL Server 5.X
RUN yum install -y mysql-server-5.* unzip

# Configura estrutura inicial do banco de dados
RUN mysql_install_db

# Cria banco de dados e usuários da aplicação
RUN service mysqld start && \
	mysqladmin create sip && \
	mysql -e "CREATE USER 'sip_user'@'%' IDENTIFIED BY '123456'" sip && \
	mysql -e "GRANT ALL PRIVILEGES ON sip.* TO 'sip_user'@'%'" sip && \
	mysqladmin create sei && \
	mysql -e "CREATE USER 'sei_user'@'%' IDENTIFIED BY '123456'" sei && \
	mysql -e "GRANT ALL PRIVILEGES ON sei.* TO 'sei_user'@'%'" sei 

# Restaura banco de dados da aplicação
RUN service mysqld start && \
	cd /tmp && unzip SEI-BD-MySQL-v2.5.1.zip && \	
	mysql sei < sei_2_5_1.sql && \
	mysql sip < sip_2_5_1.sql && \
	rm sei_2_5_1.sql sip_2_5_1.sql SEI-BD-MySQL-v2.5.1.zip

# Remove registros de auditoria presentes na base de referência
RUN service mysqld start && \
	mysql -e "delete from auditoria_protocolo;" sei

# Atualiza parâmetros do SEI e do SIP no banco de dados
RUN service mysqld start && \
	mysql -e "update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;" sip && \
	mysql -e "update sistema set pagina_inicial='http://localhost/sip' where sigla='SIP';" sip && \ 
    mysql -e "update sistema set pagina_inicial='http://localhost/sei/inicializar.php', web_service='http://localhost/sei/controlador_ws.php?servico=sip' where sigla='SEI';" sip && \
    mysql -e "update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;" sei 

# Altera configurações padrões do MySQL
RUN service mysqld start && \
	mysql -e "drop user ''@'localhost'" && \
	mysql -e "drop user ''@$HOSTNAME" && \	
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'" && \
	mysqladmin -u root password '123456' 

##################### FIM DA INSTALACAO #####################

# Expõe a porta padrão do MySQL Server
EXPOSE 3306

# Default port to execute the entrypoint (MongoDB)
CMD ["/usr/bin/mysqld_safe", "--bind-address=0.0.0.0"]

# Atribui o comando padrão do container
# ENTRYPOINT /usr/bin/mysqld_safe
#!/usr/bin/env sh
set -e

yum -y update

# Instalar o MySQL 5.6
yum install -y wget
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm -O /tmp/mysql-community-release-el7-5.noarch.rpm
rpm -ivh /tmp/mysql-community-release-el7-5.noarch.rpm
yum -y install mysql-server

# Inicialização do diretório de armazenamento do MySQL.
# PS: Utilizando configuração insegura apenas para propósito de desenvolvimento
rm -rf /var/lib/mysql/*
chown -R mysql:mysql /var/lib/mysql 
mysql_install_db --user=mysql --datadir="/var/lib/mysql" --rpm --keep-my-cnf

/etc/init.d/mysqld start

/usr/bin/mysqladmin -u root password 'root'

# Criação dos bancos de dados do sistema
mysqladmin create sip
mysqladmin create sei

# Criação dos usuários utilizados na conexão com SEI e SIP
mysql -e "CREATE USER 'sip_user'@'%' IDENTIFIED BY 'sip_user'" sip
mysql -e "CREATE USER 'sei_user'@'%' IDENTIFIED BY 'sei_user'" sei
mysql -e "GRANT ALL PRIVILEGES ON sip.* TO 'sip_user'@'%'" sip
mysql -e "GRANT ALL PRIVILEGES ON sei.* TO 'sei_user'@'%'" sei

# Restauração dos bancos de dados
mysql sei < /tmp/sei_mysql.sql
mysql sip < /tmp/sip_mysql.sql

# Atualização dos parâmetros do SEI e do SIP
mysql -e "update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;" sip
mysql -e "update sistema set pagina_inicial='http://localhost/sip' where sigla='SIP';" sip
mysql -e "update sistema set pagina_inicial='http://localhost/sei/inicializar.php', web_service='http://localhost/sei/controlador_ws.php?servico=sip' where sigla='SEI';" sip
mysql -e "update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;" sei

# Remove registros de auditoria presentes na base de referência
mysql -e "delete from auditoria_protocolo;" sei

# Configuração para utilizar autenticação nativa do SEI/SIP
mysql -e "update orgao set sin_autenticar='N' where id_orgao=0;" sip

# Atribuição de permissões de acesso externo para o usuário root, senha root
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"

# Remover arquivos temporários
rm -rf /tmp/*
yum clean all

# Configuração de permissões de execução no script de inicialização do container
chmod +x /entrypoint.sh

exit 0
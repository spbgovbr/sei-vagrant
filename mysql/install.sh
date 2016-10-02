#!/usr/bin/env bash

set -e
set -u
set -o pipefail

yum update -y

# Instalar o yum repo rpm package
yum install -y wget
wget http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
yum localinstall -y mysql57-community-release-el6-7.noarch.rpm

# Instalação do MySQL Server 5.X
yum install -y mysql-community-server

# Inicialização do diretório de armazenamento do MySQL.
# PS: Utilizando configuração insegura apenas para propósito de desenvolvimento
rm -rf /var/lib/mysql/*
chown -R mysql:mysql /var/lib/mysql
mysqld --user=mysql --initialize-insecure  

# Inicialização do banco de dados
/etc/init.d/mysqld start

# Criação dos bancos de dados do sistema
mysqladmin create sip
mysqladmin create sei

# Criação dos usuários utilizados na conexão com SEI e SIP
mysql -e "CREATE USER 'sip_user'@'%' IDENTIFIED BY 'sip_user'" sip
mysql -e "CREATE USER 'sei_user'@'%' IDENTIFIED BY 'sei_user'" sei
mysql -e "GRANT ALL PRIVILEGES ON sip.* TO 'sip_user'@'%'" sip
mysql -e "GRANT ALL PRIVILEGES ON sei.* TO 'sei_user'@'%'" sei

# Restauração dos bancos de dados
mysql sei < /opt/sei_mysql.sql
mysql sip < /opt/sip_mysql.sql
rm -f /opt/sei_mysql.sql /opt/sip_mysql.sql

# Atualização dos parâmetros do SEI e do SIP
mysql -e "update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;" sip
mysql -e "update sistema set pagina_inicial='http://localhost/sip' where sigla='SIP';" sip
mysql -e "update sistema set pagina_inicial='http://localhost/sei/inicializar.php', web_service='http://localhost/sei/controlador_ws.php?servico=sip' where sigla='SEI';" sip
mysql -e "update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;" sei

# Temp: Remove registros de auditoria presentes na base de referência
mysql -e "delete from auditoria_protocolo;" sei

# Configuração para utilizar autenticação nativa do SEI/SIP
mysql -e "update orgao set sin_autenticar='N' where id_orgao=0;" sip

# Atribuição de permissões de acesso externo para o usuário root, senha root
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"

yum clean -y all


exit 0

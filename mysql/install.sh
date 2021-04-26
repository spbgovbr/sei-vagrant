#!/usr/bin/env sh

mysql_secure_installation <<EOF
root
y
y
root
root
n
n
n
y
EOF

# Criação dos bancos de dados do sistema
#mysqladmin create sip
#mysqladmin create sei

# Criação dos usuários utilizados na conexão com SEI e SIP
mysql -e "CREATE USER 'sip_user'@'%' IDENTIFIED BY 'sip_user'" sip
mysql -e "CREATE USER 'sei_user'@'%' IDENTIFIED BY 'sei_user'" sei
mysql -e "GRANT ALL PRIVILEGES ON sip.* TO 'sip_user'@'%'" sip
mysql -e "GRANT ALL PRIVILEGES ON sei.* TO 'sei_user'@'%'" sei

# Restauração dos bancos de dados
mysql sei < /docker-entrypoint-initdb.d/2_sei_4_0_0_BD_Ref_Exec.sql
mysql sip < /docker-entrypoint-initdb.d/3_sip_4_0_0_BD_Ref_Exec.sql

# Atualização dos parâmetros do SEI e do SIP
mysql -e "update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;" sip
mysql -e "update sistema set pagina_inicial='http://localhost:8000/sip' where sigla='SIP';" sip
mysql -e "update sistema set pagina_inicial='http://localhost:8000/sei/inicializar.php', web_service='http://localhost:8000/sei/controlador_ws.php?servico=sip' where sigla='SEI';" sip
mysql -e "update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;" sei

# Remove registros de auditoria presentes na base de referência
mysql -e "delete from auditoria_protocolo;" sei

# Configuração para utilizar autenticação nativa do SEI/SIP
mysql -e "update orgao set sin_autenticar='N' where id_orgao=0;" sip

# Atribuição de permissões de acesso externo para o usuário root, senha root
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"

exit 0
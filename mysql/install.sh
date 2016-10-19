#!/usr/bin/env bash

set -e

# Constroi script de restauração da base de dados do sistema
cat /tmp/1-preinstall.sql  > /docker-entrypoint-initdb.d/install.sql 

# Script de restauração da base de dados do SEI
echo "USE sei;"           >> /docker-entrypoint-initdb.d/install.sql 
cat /tmp/2-sei_mysql.sql  >> /docker-entrypoint-initdb.d/install.sql 

#Script de restauração da base de dados do SIP
echo "USE sip;"           >> /docker-entrypoint-initdb.d/install.sql 
cat /tmp/3-sip_mysql.sql  >> /docker-entrypoint-initdb.d/install.sql 

# Aplica ajustes nas tabelas de sistema e órgão do SIP e SEI
cat /tmp/4-posinstall.sql >> /docker-entrypoint-initdb.d/install.sql

# Correção de problema com o registro de log de documentos contendo imagens
echo "max_allowed_packet=268435456" >> /etc/my.cnf

exit 0

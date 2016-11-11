#!/usr/bin/env bash

set -e

# Variáveis de ambiente 
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_SID=XE
export NLS_LANG=PORTUGUESE_BRAZIL.WE8MSWIN1252

# Inicialização do servidor
bash /usr/sbin/startup.sh

# Configuração do character set e outros parâmetros iniciais
sqlplus sys/oracle as sysdba @"/tmp/pre-install.sql"

# Restauração das bases de dados do SEI e SIP
imp system/oracle file=/tmp/sei.dmp full=y
imp system/oracle file=/tmp/sip.dmp full=y

# Configuração das bases de dados do sistema
sqlplus sei/sei_user @"/tmp/sei-config.sql"
sqlplus sip/sip_user @"/tmp/sip-config.sql"

exit 0

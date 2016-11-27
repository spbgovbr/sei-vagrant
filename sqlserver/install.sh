#!/usr/bin/env bash
set -e

# Variáveis de ambiente
export ACCEPT_EULA=Y
export SA_PASSWORD='yourStrong(!)Password'

# Instalação do FreeTDS para acesso ao SQL Server
 apt-get -y update && apt-get -y install libodbc1 freetds-dev freetds-bin

/opt/mssql/bin/sqlservr.sh &
sleep 10

tsql -S localhost -U sa -P 'yourStrong(!)Password' < /tmp/restore.sql

# Remover arquivos temporários
rm -rf /tmp/*

exit 0

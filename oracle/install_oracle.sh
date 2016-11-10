# Configuração do Oracle no servidor de aplicação do SEI/SIP

# Instalação de dependências do projeto
yum -y install libaio


# Instalação dos pacotes Basic e SDK Instant Client
rpm -Uvh oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
rpm -Uvh oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm 
rpm -Uvh oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm

# Instalação dos OCI8 extension
printf "\n" | pecl install oci8-2.0.12

# Habilitação da extensão do Oracle 
echo "extension=oci8.so" > /etc/php.d/oci8.ini

# Configuração de diretório do Oracle Instant Client no dynamic linker/loader
echo "/usr/lib/oracle/11.2/client64/lib" > /etc/ld.so.conf.d/oracle-11.conf

# Variáveis de ambiente 
export NLS_LANG=PORTUGUESE_BRAZIL.WE8MSWIN1252


# Configuração do banco de dados Oracle do SEI/SIP

sqlplus sys/oracle as sysdba;


SHUTDOWN;
STARTUP MOUNT;
ALTER SYSTEM ENABLE RESTRICTED SESSION;
ALTER SYSTEM SET JOB_QUEUE_PROCESSES=0;
ALTER DATABASE OPEN;
ALTER DATABASE CHARACTER SET INTERNAL_USE WE8MSWIN1252;
ALTER DATABASE NATIONAL CHARACTER SET INTERNAL_USE AL16UTF16;
SHUTDOWN IMMEDIATE;
STARTUP;



CREATE TABLESPACE SEI DATAFILE '/u01/app/oracle/oradata/XE/sei.dbf' SIZE 20M AUTOEXTEND ON;
CREATE TABLESPACE SIP DATAFILE '/u01/app/oracle/oradata/XE/sip.dbf' SIZE 20M AUTOEXTEND ON;

create user sei identified by sei_user;
create user sip identified by sip_user;

grant all privileges to sei;
grant all privileges to sip;


imp system/oracle file=/tmp/SEI_3.0.0.dmp full=y


drop user sei cascade; 
drop user sip cascade; 




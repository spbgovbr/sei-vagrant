################################################################################
# Dockerfile de construção do container SqlServer utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
# SQL Server para Linux é uma versão experimental e não deve ser utilizada em
# ambiente de produção
################################################################################

FROM liaisonintl/mssql-server-linux

############################# INÍCIO DA INSTALACAO #############################
ENV TERM xterm
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD='yourStrong(!)Password'

COPY sei-db-ref-executivo/sqlserver/v4.0.0/sei_4_0_0_BD_Ref_Exec.bak /tmp/sei_sqlserver.bak
COPY sei-db-ref-executivo/sqlserver/v4.0.0/sip_4_0_0_BD_Ref_Exec.bak /tmp/sip_sqlserver.bak
COPY assets/restore.sql /tmp/restore.sql
COPY install.sh /install.sh

RUN bash /install.sh
############################## FIM DA INSTALACAO ###############################

# Imagem de base já configura a exposição das portas 1521 e inicialização do
# servidor de banco de dados com as configurações padrões

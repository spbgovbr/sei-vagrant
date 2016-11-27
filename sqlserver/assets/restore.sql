
RESTORE DATABASE [sip] FROM  DISK = N'/tmp/sip_sqlserver.bak' WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 5, MOVE 'sip' TO '/var/opt/mssql/data/sip.mdf', MOVE 'sip_log' TO '/var/opt/mssql/data/sip_log.ldf'
GO

RESTORE DATABASE [sei] FROM  DISK = N'/tmp/sei_sqlserver.bak' WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 5, MOVE 'sei' TO '/var/opt/mssql/data/sei.mdf', MOVE 'sei_log' TO '/var/opt/mssql/data/sei_log.ldf'
GO

USE SEI;
GO

CREATE LOGIN sei_user
    WITH PASSWORD = 'sei_user', CHECK_POLICY=OFF;
GO

CREATE USER sei_user FOR LOGIN sei_user;
GO

EXEC sp_addrolemember 'db_owner', 'sei_user'
GO

update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;
GO

delete from auditoria_protocolo;
GO

USE SIP;
GO

CREATE LOGIN sip_user
    WITH PASSWORD = 'sip_user', CHECK_POLICY=OFF;
GO

CREATE USER sip_user FOR LOGIN sip_user;
GO


EXEC sp_addrolemember 'db_owner', 'sip_user'
GO

update orgao set sigla='ABC', descricao='ORGAO ABC' where id_orgao=0;
GO

update sistema set pagina_inicial='http://localhost/sip' where sigla='SIP';
GO

update sistema set pagina_inicial='http://localhost/sei/inicializar.php', web_service='http://localhost/sei/controlador_ws.php?servico=sip' where sigla='SEI';
GO

update orgao set sin_autenticar='N' where id_orgao=0;
GO

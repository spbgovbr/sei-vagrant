create database sei;
create user sei_user with password 'sei_user';
\c sei;
GRANT ALL ON SCHEMA public TO sei_user;
GRANT ALL PRIVILEGES ON DATABASE sei TO sei_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT INSERT, SELECT, UPDATE, DELETE ON TABLES
    TO sei_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON SEQUENCES TO sei_user;

create database sip;
create user sip_user with password 'sip_user';
\c sip;
GRANT ALL ON SCHEMA public TO sip_user;
GRANT ALL PRIVILEGES ON DATABASE sip TO sip_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT INSERT, SELECT, UPDATE, DELETE ON TABLES
    TO sip_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON SEQUENCES TO sip_user;

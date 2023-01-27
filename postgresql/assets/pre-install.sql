-- CREATE DATABASE sei WITH ENCODING 'LATIN1' ;
CREATE DATABASE sei;
create user sei_user with password 'sei_user';
-- \c sei;
-- GRANT ALL PRIVILEGES ON DATABASE sei TO sei_user;
-- GRANT ALL PRIVILEGES ON SCHEMA public TO sei_user;
-- GRANT ALL ON ALL TABLES IN SCHEMA public TO sei_user;

-- CREATE DATABASE sip WITH ENCODING 'LATIN1';
CREATE DATABASE sip;
create user sip_user with password 'sip_user';
-- \c sip;
-- GRANT ALL PRIVILEGES ON DATABASE sip TO sip_user;
-- GRANT ALL PRIVILEGES ON SCHEMA public TO sip_user;
-- GRANT ALL ON ALL TABLES IN SCHEMA public TO sip_user;
USE mysql;

CREATE DATABASE IF NOT EXISTS sei;
CREATE DATABASE IF NOT EXISTS sip;

CREATE USER 'sip_user'@'%' IDENTIFIED BY 'sip_user';
CREATE USER 'sei_user'@'%' IDENTIFIED BY 'sei_user';
GRANT ALL PRIVILEGES ON sip.* TO 'sip_user'@'%';
GRANT ALL PRIVILEGES ON sei.* TO 'sei_user'@'%';



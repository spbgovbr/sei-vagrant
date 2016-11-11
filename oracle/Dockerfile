FROM wnameless/oracle-xe-11g

ENV ORACLE_ALLOW_REMOTE=true
ENV NLS_LANG=PORTUGUESE_BRAZIL.WE8MSWIN1252

COPY install.sh /install.sh
COPY pre-install.sql /tmp/pre-install.sql
COPY SEI_3.0.0.dmp /tmp/sei.dmp
COPY SIP_3.0.0.dmp /tmp/sip.dmp
COPY sei-config.sql /tmp/sei-config.sql
COPY sip-config.sql /tmp/sip-config.sql

RUN bash /install.sh

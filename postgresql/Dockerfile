################################################################################
# Dockerfile de construção do container do MySQL utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM postgres:15 as builder

ARG VERSAO_BASE=v4.0.x.1
ARG REPOSITORIO_BASE=https://github.com/supergovbr/super-db-ref-executivo/blob/master/postgresql/$VERSAO_BASE

############################# INÍCIO DA INSTALACAO #############################
ENV POSTGRES_PASSWORD=P@ssword
ENV POSTGRES_HOST_AUTH_METHOD=scram-sha-256
ENV POSTGRES_INITDB_ARGS=--auth-host=scram-sha-256
ENV PGDATA=/initialized-db

COPY assets/postgres.conf /etc/postgresql/postgresql.conf
COPY assets/pre-install.sql /docker-entrypoint-initdb.d/1_pre-install.sql
ADD $REPOSITORIO_BASE/sei_super_4.0.x.1_BD_Ref_Exec.sql?raw=true /docker-entrypoint-initdb.d/2_sei_4_0_0_BD_Ref_Exec.sql
ADD $REPOSITORIO_BASE/sip_super_4.0.x.1_BD_Ref_Exec.sql?raw=true /docker-entrypoint-initdb.d/3_sip_4_0_0_BD_Ref_Exec.sql
COPY assets/pos-install.sql /docker-entrypoint-initdb.d/9_pos-install.sql

RUN mkdir /initialized-db && chown -R postgres /initialized-db 
RUN chmod -R 777 /docker-entrypoint-initdb.d/
RUN chmod 644 /etc/postgresql/postgresql.conf
RUN sed -i '1i \\\c sei; \n' /docker-entrypoint-initdb.d/2_sei_4_0_0_BD_Ref_Exec.sql
RUN sed -i '1i \\\c sip; \n' /docker-entrypoint-initdb.d/3_sip_4_0_0_BD_Ref_Exec.sql

# RUN su postgres -c "initdb -D /initialized-db"
RUN ["sed", "-i", "s/exec \"$@\"/echo \"not running $@\"/", "/usr/local/bin/docker-entrypoint.sh"]
RUN ["/usr/local/bin/docker-entrypoint.sh", "postgres"]

# ############################## FIM DA INSTALAÇÃO ###########################
FROM postgres:15

COPY --from=builder /initialized-db /var/lib/postgresql/data
COPY --from=builder /etc/postgresql/postgresql.conf /var/lib/postgresql/data/postgresql.conf

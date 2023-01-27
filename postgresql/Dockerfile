################################################################################
# Dockerfile de construção do container do MySQL utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM postgres:15 as builder

ENV POSTGRES_PASSWORD=P@ssword
ENV POSTGRES_HOST_AUTH_METHOD=scram-sha-256
ENV POSTGRES_INITDB_ARGS=--auth-host=scram-sha-256
ENV PGDATA=/initialized-db

# ENV LANG pt_BR.ISO-8859-1
# ENV LC_ALL pt_BR.ISO-8859-1
# RUN localectl set-locale LANG=pt_BR.ISO-8859-1
# RUN sed -i -e 's/# pt_BR ISO-8859-1/pt_BR ISO-8859-1/' /etc/locale.gen
# RUN localedef -i pt_BR -c -f ISO-8859-1 -A /usr/share/locale/locale.alias pt_BR.ISO-8859-1
# RUN localedef pt_BR -i pt_BR -f ISO-8859-1
# RUN dpkg-reconfigure --frontend=noninteractive locales


COPY assets/postgres.conf /etc/postgresql/postgresql.conf
COPY assets/pre-install.sql /docker-entrypoint-initdb.d/1_pre-install.sql
COPY sei-db-ref-executivo/postgresql/v4.0.0/sei_4_0_0_BD_Ref_Exec.sql /docker-entrypoint-initdb.d/2_sei_4_0_0_BD_Ref_Exec.sql
COPY sei-db-ref-executivo/postgresql/v4.0.0/sip_4_0_0_BD_Ref_Exec.sql /docker-entrypoint-initdb.d/3_sip_4_0_0_BD_Ref_Exec.sql
COPY assets/pos-install.sql /docker-entrypoint-initdb.d/9_pos-install.sql

RUN mkdir /initialized-db && chown -R postgres /initialized-db 
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

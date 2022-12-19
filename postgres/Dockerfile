FROM postgres:15

ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_HOST_AUTH_METHOD=scram-sha-256
ENV POSTGRES_INITDB_ARGS=--auth-host=scram-sha-256

ENV LANG pt_BR.ISO-8859-1
RUN sed -i -e 's/# pt_BR ISO-8859-1/pt_BR ISO-8859-1/' /etc/locale.gen
RUN localedef -i pt_BR -c -f ISO-8859-1 -A /usr/share/locale/locale.alias pt_BR.ISO-8859-1
RUN localedef pt_BR -i pt_BR -f ISO-8859-1
RUN dpkg-reconfigure --frontend=noninteractive locales

ADD conf/postgres.conf /etc/postgresql/postgresql.conf

ADD assets/ /docker-entrypoint-initdb.d/

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]

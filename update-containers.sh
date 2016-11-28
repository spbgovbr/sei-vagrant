#!/usr/bin/env sh
set -e

vagrant destroy

#docker stop $(docker ps -q)
#docker rm $(docker ps -a -q)
#docker rmi --force $(docker images -q)

#cd solr
#docker build -t sei3_solr-6.1 .
#docker tag sei3_solr-6.1 guilhermeadc/sei3_solr-6.1:latest
#cd ..

#cd jod
#docker build -t sei3_jod-2.2.2 .
#docker tag  sei3_jod-2.2.2 guilhermeadc/sei3_jod-2.2.2:latest
#cd ..

#cd mysql
#docker build -t sei3_mysql-5.6 .
#docker tag sei3_mysql-5.6 guilhermeadc/sei3_mysql-5.6:latest
#cd ..

#cd oracle
#docker build -t sei3_oracle-11g .
#docker tag  sei3_oracle-11g guilhermeadc/sei3_oracle-11g:latest
#cd ..

#cd httpd
#docker build -t sei3_httpd-2.4 .
#docker tag sei3_httpd-2.4 guilhermeadc/sei3_httpd-2.4:latest
#cd ..

#cd mailcatcher
#docker build -t sei3_mailcatcher .
#docker tag sei3_mailcatcher guilhermeadc/sei3_mailcatcher:latest
#cd ..

#cd memcached
#docker build -t sei3_memcached .
#docker tag sei3_memcached  guilhermeadc/sei3_memcached:latest
#cd ..

#cd sqlserver
#docker build -t sei3_sqlserver-2016 .
#docker tag sei3_sqlserver-2016 guilhermeadc/sei3_sqlserver-2016:latest
#cd ..

docker push guilhermeadc/sei3_solr-6.1 
docker push guilhermeadc/sei3_jod-2.2.2
docker push guilhermeadc/sei3_mysql-5.6
docker push guilhermeadc/sei3_oracle-11g
docker push guilhermeadc/sei3_httpd-2.4
docker push guilhermeadc/sei3_mailcatcher
docker push guilhermeadc/sei3_memcached
docker push guilhermeadc/sei3_sqlserver-2016

vagrant up

exit 0
~                                                                                                                                                                  
~              



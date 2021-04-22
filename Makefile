.PHONY: build-containers build-vm install-vm clean

VERSAO_CONTAINERS='9.0'

build: build-containers build-vm

clean: 
	docker rmi --force sei3_solr-6.1 || true
	docker rmi --force sei3_jod-2.2.2 || true
	docker rmi --force sei3_mysql-5.7 || true
	docker rmi --force sei3_oracle-11g || true
	docker rmi --force sei3_httpd-2.4 || true
	docker rmi --force sei3_mailcatcher || true
	docker rmi --force sei3_sqlserver-2017 || true


build-containers: clean
	docker build -t sei4_solr solr/
	docker tag sei4_solr guilhermeadc/sei4_solr:latest
	docker tag sei4_solr guilhermeadc/sei4_solr:9.0

	docker build -t sei4_jod jod/
	docker tag sei4_jod guilhermeadc/sei4_jod:latest
	docker tag sei4_jod guilhermeadc/sei4_jod:9.0

	docker build -t sei4_mysql mysql/
	docker tag sei4_mysql guilhermeadc/sei4_mysql:latest
	docker tag sei4_mysql guilhermeadc/sei4_mysql:9.0

	docker build -t sei4_oracle oracle/
	docker tag sei4_oracle guilhermeadc/sei4_oracle:latest
	docker tag sei4_oracle guilhermeadc/sei4_oracle:9.0

	docker build -t sei4_httpd httpd/
	docker tag sei4_httpd guilhermeadc/sei4_httpd:latest
	docker tag sei4_httpd guilhermeadc/sei4_httpd:9.0

	docker build -t sei4_mailcatcher mailcatcher
	docker tag sei4_mailcatcher guilhermeadc/sei4_mailcatcher:latest
	docker tag sei4_mailcatcher guilhermeadc/sei4_mailcatcher:9.0

	docker build -t sei4_memcached memcached
	docker tag sei4_memcached  guilhermeadc/sei4_memcached:latest
	docker tag sei4_memcached  guilhermeadc/sei4_memcached:9.0

	docker build -t sei4_sqlserver sqlserver
	docker tag sei4_sqlserver guilhermeadc/sei4_sqlserver:latest
	docker tag sei4_sqlserver guilhermeadc/sei4_sqlserver:9.0

	docker push guilhermeadc/sei4_solr:9.0
	docker push guilhermeadc/sei4_jod:9.0
	docker push guilhermeadc/sei4_mysql:9.0
	docker push guilhermeadc/sei4_oracle:9.0
	docker push guilhermeadc/sei4_httpd:9.0
	docker push guilhermeadc/sei4_mailcatcher:9.0
	docker push guilhermeadc/sei4_memcached:9.0
	docker push guilhermeadc/sei4_sqlserver:9.0

	docker push guilhermeadc/sei4_solr:latest
	docker push guilhermeadc/sei4_jod:latest
	docker push guilhermeadc/sei4_mysql:latest
	docker push guilhermeadc/sei4_oracle:latest
	docker push guilhermeadc/sei4_httpd:latest
	docker push guilhermeadc/sei4_mailcatcher:latest
	docker push guilhermeadc/sei4_memcached:latest
	docker push guilhermeadc/sei4_sqlserver:latest


build-vm:
	rm -rf dist/* || true
	packer build -force sei-vagrant.json	


install-vm:
	vagrant box remove sei-vagrant || true	
	vagrant box add sei-vagrant ./dist/package.box


.PHONY: build-containers build-vm install-vm clean

VERSAO_CONTAINERS='8.0'

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
	docker build -t sei3_solr-6.1 solr/
	docker tag sei3_solr-6.1 guilhermeadc/sei3_solr-6.1:latest
	docker tag sei3_solr-6.1 guilhermeadc/sei3_solr-6.1:$(VERSAO_CONTAINERS)

	docker build -t sei3_jod-2.2.2 jod/
	docker tag  sei3_jod-2.2.2 guilhermeadc/sei3_jod-2.2.2:latest
	docker tag  sei3_jod-2.2.2 guilhermeadc/sei3_jod-2.2.2:$(VERSAO_CONTAINERS)

	docker build -t sei3_mysql-5.7 mysql/
	docker tag sei3_mysql-5.7 guilhermeadc/sei3_mysql-5.7:latest
	docker tag sei3_mysql-5.7 guilhermeadc/sei3_mysql-5.7:$(VERSAO_CONTAINERS)

	docker build -t sei3_oracle-11g oracle/
	docker tag  sei3_oracle-11g guilhermeadc/sei3_oracle-11g:latest
	docker tag  sei3_oracle-11g guilhermeadc/sei3_oracle-11g:$(VERSAO_CONTAINERS)

	docker build -t sei3_httpd-2.4 httpd/
	docker tag sei3_httpd-2.4 guilhermeadc/sei3_httpd-2.4:latest
	docker tag sei3_httpd-2.4 guilhermeadc/sei3_httpd-2.4:$(VERSAO_CONTAINERS)

	docker build -t sei3_mailcatcher mailcatcher
	docker tag sei3_mailcatcher guilhermeadc/sei3_mailcatcher:latest
	docker tag sei3_mailcatcher guilhermeadc/sei3_mailcatcher:$(VERSAO_CONTAINERS)

	docker build -t sei3_memcached memcached
	docker tag sei3_memcached  guilhermeadc/sei3_memcached:latest
	docker tag sei3_memcached  guilhermeadc/sei3_memcached:$(VERSAO_CONTAINERS)

	docker build -t sei3_sqlserver-2017 sqlserver
	docker tag sei3_sqlserver-2017 guilhermeadc/sei3_sqlserver-2017:latest
	docker tag sei3_sqlserver-2017 guilhermeadc/sei3_sqlserver-2017:$(VERSAO_CONTAINERS)

	docker push guilhermeadc/sei3_solr-6.1:$(VERSAO_CONTAINERS)
	docker push guilhermeadc/sei3_jod-2.2.2:$(VERSAO_CONTAINERS)
	docker push guilhermeadc/sei3_mysql-5.7:$(VERSAO_CONTAINERS)
	docker push guilhermeadc/sei3_oracle-11g:$(VERSAO_CONTAINERS)
	docker push guilhermeadc/sei3_httpd-2.4:$(VERSAO_CONTAINERS)
	docker push guilhermeadc/sei3_mailcatcher:$(VERSAO_CONTAINERS)
	docker push guilhermeadc/sei3_memcached:$(VERSAO_CONTAINERS)
	docker push guilhermeadc/sei3_sqlserver-2017:$(VERSAO_CONTAINERS)

	docker push guilhermeadc/sei3_solr-6.1:latest
	docker push guilhermeadc/sei3_jod-2.2.2:latest
	docker push guilhermeadc/sei3_mysql-5.7:latest
	docker push guilhermeadc/sei3_oracle-11g:latest
	docker push guilhermeadc/sei3_httpd-2.4:latest
	docker push guilhermeadc/sei3_mailcatcher:latest
	docker push guilhermeadc/sei3_memcached:latest
	docker push guilhermeadc/sei3_sqlserver-2017:latest


build-vm:
	rm -rf dist/* || true
	packer build -force sei-vagrant.json	


install-vm:
	vagrant box remove sei-vagrant || true	
	vagrant box add sei-vagrant ./dist/package.box


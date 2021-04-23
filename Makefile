.PHONY: build-containers build-vm install-vm clean

VERSAO_CONTAINERS='9.0'

build: build-containers build-vm

clean: 
	docker rmi --force vagrant_sei4_solr || true
	docker rmi --force vagrant_sei4_jod || true
	docker rmi --force vagrant_sei4_mysql || true
	docker rmi --force vagrant_sei4_oracle || true
	docker rmi --force vagrant_sei4_httpd || true
	docker rmi --force vagrant_sei4_mailcatcher || true
	docker rmi --force vagrant_sei4_sqlserver || true


build-containers: clean
	docker build -t vagrant_vagrant_sei4_solr solr/
	docker tag vagrant_sei4_solr processoeletronico/vagrant_vagrant_sei4_solr:latest
	docker tag vagrant_sei4_solr processoeletronico/vagrant_vagrant_sei4_solr:9.0

	docker build -t vagrant_sei4_jod jod/
	docker tag vagrant_sei4_jod processoeletronico/vagrant_sei4_jod:latest
	docker tag vagrant_sei4_jod processoeletronico/vagrant_sei4_jod:9.0

	docker build -t vagrant_sei4_mysql mysql/
	docker tag vagrant_sei4_mysql processoeletronico/vagrant_sei4_mysql:latest
	docker tag vagrant_sei4_mysql processoeletronico/vagrant_sei4_mysql:9.0

	docker build -t vagrant_sei4_oracle oracle/
	docker tag vagrant_sei4_oracle processoeletronico/vagrant_sei4_oracle:latest
	docker tag vagrant_sei4_oracle processoeletronico/vagrant_sei4_oracle:9.0

	docker build -t vagrant_sei4_httpd httpd/
	docker tag vagrant_sei4_httpd processoeletronico/vagrant_sei4_httpd:latest
	docker tag vagrant_sei4_httpd processoeletronico/vagrant_sei4_httpd:9.0

	docker build -t vagrant_sei4_mailcatcher mailcatcher
	docker tag vagrant_sei4_mailcatcher processoeletronico/vagrant_sei4_mailcatcher:latest
	docker tag vagrant_sei4_mailcatcher processoeletronico/vagrant_sei4_mailcatcher:9.0

	docker build -t vagrant_sei4_memcached memcached
	docker tag vagrant_sei4_memcached  processoeletronico/vagrant_sei4_memcached:latest
	docker tag vagrant_sei4_memcached  processoeletronico/vagrant_sei4_memcached:9.0

	docker build -t vagrant_sei4_sqlserver sqlserver
	docker tag vagrant_sei4_sqlserver processoeletronico/vagrant_sei4_sqlserver:latest
	docker tag vagrant_sei4_sqlserver processoeletronico/vagrant_sei4_sqlserver:9.0

	docker push processoeletronico/vagrant_sei4_solr:9.0
	docker push processoeletronico/vagrant_sei4_jod:9.0
	docker push processoeletronico/vagrant_sei4_mysql:9.0
	docker push processoeletronico/vagrant_sei4_oracle:9.0
	docker push processoeletronico/vagrant_sei4_httpd:9.0
	docker push processoeletronico/vagrant_sei4_mailcatcher:9.0
	docker push processoeletronico/vagrant_sei4_memcached:9.0
	docker push processoeletronico/vagrant_sei4_sqlserver:9.0

	docker push processoeletronico/vagrant_sei4_solr:latest
	docker push processoeletronico/vagrant_sei4_jod:latest
	docker push processoeletronico/vagrant_sei4_mysql:latest
	docker push processoeletronico/vagrant_sei4_oracle:latest
	docker push processoeletronico/vagrant_sei4_httpd:latest
	docker push processoeletronico/vagrant_sei4_mailcatcher:latest
	docker push processoeletronico/vagrant_sei4_memcached:latest
	docker push processoeletronico/vagrant_sei4_sqlserver:latest


build-vm:
	rm -rf dist/* || true
	packer build -force sei-vagrant.json	


install-vm:
	vagrant box remove sei-vagrant || true	
	vagrant box add sei-vagrant ./dist/package.box


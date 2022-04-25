.PHONY: build-containers build-vm install-vm clean

VERSAO_CONTAINERS='9.9'

build: build-containers publish-containers build-vm

clean: 
	docker rmi --force vagrant_sei4_solr || true
	docker rmi --force vagrant_sei4_jod || true
	docker rmi --force vagrant_sei4_mysql || true
	docker rmi --force vagrant_sei4_oracle || true
	docker rmi --force vagrant_sei4_httpd || true
	docker rmi --force vagrant_sei4_mailcatcher || true
	docker rmi --force vagrant_sei4_sqlserver || true


build-containers: 
	docker build -t vagrant_sei4_httpd httpd/
	docker tag vagrant_sei4_httpd processoeletronico/vagrant_sei4_httpd:$(VERSAO_CONTAINERS)
	docker tag vagrant_sei4_httpd processoeletronico/vagrant_sei4_httpd:latest

	docker build -t vagrant_sei4_solr solr/
	docker tag vagrant_sei4_solr processoeletronico/vagrant_sei4_solr:$(VERSAO_CONTAINERS)
	docker tag vagrant_sei4_solr processoeletronico/vagrant_sei4_solr:latest

	docker build -t vagrant_sei4_jod jod/
	docker tag vagrant_sei4_jod processoeletronico/vagrant_sei4_jod:$(VERSAO_CONTAINERS)
	docker tag vagrant_sei4_jod processoeletronico/vagrant_sei4_jod:latest

	docker build -t vagrant_sei4_mysql mysql/
	docker tag vagrant_sei4_mysql processoeletronico/vagrant_sei4_mysql:$(VERSAO_CONTAINERS)
	docker tag vagrant_sei4_mysql processoeletronico/vagrant_sei4_mysql:latest

	docker build -t vagrant_sei4_oracle oracle/
	docker tag vagrant_sei4_oracle processoeletronico/vagrant_sei4_oracle:$(VERSAO_CONTAINERS)
	docker tag vagrant_sei4_oracle processoeletronico/vagrant_sei4_oracle:latest

	docker build -t vagrant_sei4_mailcatcher mailcatcher
	docker tag vagrant_sei4_mailcatcher processoeletronico/vagrant_sei4_mailcatcher:$(VERSAO_CONTAINERS)
	docker tag vagrant_sei4_mailcatcher processoeletronico/vagrant_sei4_mailcatcher:latest

	docker build -t vagrant_sei4_memcached memcached
	docker tag vagrant_sei4_memcached  processoeletronico/vagrant_sei4_memcached:$(VERSAO_CONTAINERS)
	docker tag vagrant_sei4_memcached  processoeletronico/vagrant_sei4_memcached:latest

	docker build -t vagrant_sei4_sqlserver sqlserver
	docker tag vagrant_sei4_sqlserver processoeletronico/vagrant_sei4_sqlserver:$(VERSAO_CONTAINERS)
	docker tag vagrant_sei4_sqlserver processoeletronico/vagrant_sei4_sqlserver:latest

publish-containers:
	docker push processoeletronico/vagrant_sei4_httpd:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_sei4_httpd:latest 
	docker push processoeletronico/vagrant_sei4_mysql:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_sei4_mysql:latest 
	docker push processoeletronico/vagrant_sei4_solr:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_sei4_solr:latest 
	docker push processoeletronico/vagrant_sei4_oracle:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_sei4_oracle:latest 
	docker push processoeletronico/vagrant_sei4_sqlserver:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_sei4_sqlserver:latest 
	docker push processoeletronico/vagrant_sei4_jod:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_sei4_jod:latest 
	docker push processoeletronico/vagrant_sei4_memcached:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_sei4_memcached:latest 
	docker push processoeletronico/vagrant_sei4_mailcatcher:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_sei4_mailcatcher:latest 


build-vm:
	rm -rf dist/* || true
	packer build -force sei-vagrant.json


install-vm:
	vagrant box remove sei-vagrant || true	
	vagrant box add sei-vagrant ./dist/package.box


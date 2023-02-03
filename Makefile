.PHONY: build-containers build-vm install-vm clean

VERSAO_CONTAINERS='10.0'

build: build-containers publish-containers build-vm

clean: 
	docker rmi --force vagrant_super4_solr || true
	docker rmi --force vagrant_super4_jod || true
	docker rmi --force vagrant_super4_mysql || true
	docker rmi --force vagrant_super4_oracle || true
	docker rmi --force vagrant_super4_httpd || true
	docker rmi --force vagrant_super4_mailcatcher || true
	docker rmi --force vagrant_super4_sqlserver || true
	docker rmi --force vagrant_super4_postgresql || true


build-containers: 

	docker build -t vagrant_super4_httpd httpd/
	docker tag vagrant_super4_httpd processoeletronico/vagrant_super4_httpd:$(VERSAO_CONTAINERS)
	docker tag vagrant_super4_httpd processoeletronico/vagrant_super4_httpd:latest

	docker build -t vagrant_super4_solr solr/
	docker tag vagrant_super4_solr processoeletronico/vagrant_super4_solr:$(VERSAO_CONTAINERS)
	docker tag vagrant_super4_solr processoeletronico/vagrant_super4_solr:latest

	docker build -t vagrant_super4_jod jod/
	docker tag vagrant_super4_jod processoeletronico/vagrant_super4_jod:$(VERSAO_CONTAINERS)
	docker tag vagrant_super4_jod processoeletronico/vagrant_super4_jod:latest

	docker build -t vagrant_super4_mysql mysql/
	docker tag vagrant_super4_mysql processoeletronico/vagrant_super4_mysql:$(VERSAO_CONTAINERS)
	docker tag vagrant_super4_mysql processoeletronico/vagrant_super4_mysql:latest

	docker build -t vagrant_super4_oracle oracle/
	docker tag vagrant_super4_oracle processoeletronico/vagrant_super4_oracle:$(VERSAO_CONTAINERS)
	docker tag vagrant_super4_oracle processoeletronico/vagrant_super4_oracle:latest

	docker build -t vagrant_super4_sqlserver sqlserver
	docker tag vagrant_super4_sqlserver processoeletronico/vagrant_super4_sqlserver:$(VERSAO_CONTAINERS)
	docker tag vagrant_super4_sqlserver processoeletronico/vagrant_super4_sqlserver:latest

	docker build -t vagrant_super4_postgresql postgresql
	docker tag vagrant_super4_postgresql processoeletronico/vagrant_super4_postgresql:$(VERSAO_CONTAINERS)
	docker tag vagrant_super4_postgresql processoeletronico/vagrant_super4_postgresql:latest

	docker build -t vagrant_super4_mailcatcher mailcatcher
	docker tag vagrant_super4_mailcatcher processoeletronico/vagrant_super4_mailcatcher:$(VERSAO_CONTAINERS)
	docker tag vagrant_super4_mailcatcher processoeletronico/vagrant_super4_mailcatcher:latest

	docker build -t vagrant_super4_memcached memcached
	docker tag vagrant_super4_memcached  processoeletronico/vagrant_super4_memcached:$(VERSAO_CONTAINERS)
	docker tag vagrant_super4_memcached  processoeletronico/vagrant_super4_memcached:latest




publish-containers:
	docker push processoeletronico/vagrant_super4_httpd:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_super4_httpd:latest 
	docker push processoeletronico/vagrant_super4_mysql:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_super4_mysql:latest 
	docker push processoeletronico/vagrant_super4_solr:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_super4_solr:latest 
	docker push processoeletronico/vagrant_super4_oracle:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_super4_oracle:latest 
	docker push processoeletronico/vagrant_super4_sqlserver:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_super4_sqlserver:latest 
	docker push processoeletronico/vagrant_super4_postgresql:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_super4_postgresql:latest 	
	docker push processoeletronico/vagrant_super4_jod:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_super4_jod:latest 
	docker push processoeletronico/vagrant_super4_memcached:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_super4_memcached:latest 
	docker push processoeletronico/vagrant_super4_mailcatcher:$(VERSAO_CONTAINERS) 
	docker push processoeletronico/vagrant_super4_mailcatcher:latest 


build-vm:
	rm -rf dist/* || true
	packer build -force sei-vagrant.json


install-vm:
	vagrant box remove sei-vagrant || true	
	vagrant box add sei-vagrant ./dist/package.box


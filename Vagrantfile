# -*- mode: ruby -*-
# vi: set ft=ruby :

# Referência para os artefatos do SEI utilizados na instalação
SEI_SOURCE_DIR    = "../sei/src"
SEI_DATABASE_DIR  = "../sei/db"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Atribuição do hostname da máquina virtual 
  config.vm.hostname = "sei-vagrant"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "guilhermeadc/centos65"
  config.vm.box_download_checksum = "1014130dff98564ca18dbf7914c89b46"
  config.vm.box_download_checksum_type = "md5"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = true

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  
  # Configuração do redirecionamento entre Máquina Virtual e Host
  # Necessário permissões de root para utilizar a porta 80 (> 1024)
  config.vm.network :forwarded_port, guest: 80, host: 80 # SIP e SEI (Apache)
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # Banco de Dados (Mysql)
  config.vm.network :forwarded_port, guest: 8080,  host: 8080 # Jod Converter (Tomcat)
  config.vm.network :forwarded_port, guest: 8983,  host: 8983 # Solr Indexer (Jetty)

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder SEI_SOURCE_DIR, "/mnt/sei/src", mount_options: ["dmode=777", "fmode=777"]
  config.vm.synced_folder SEI_DATABASE_DIR, "/mnt/sei/db" 
  config.vm.synced_folder ".", "/mnt/sei/ops" 

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode
    # vb.gui = true
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Mensagem informando as portas expostas pela Vagrant
  config.vm.post_up_message = ""

  # Provisionamento da Máquina Virtual responsável por manter os containers do Docker
  config.vm.provision "docker" do |docker|    
    
    # Constrói imagens dos containers utilizados no provicionamento
    docker.build_image "/mnt/sei/ops/mysql", args: "-t 'sei.gov/mysql'"
    docker.build_image "/mnt/sei/ops/sei", args: "-t 'sei.gov/sei'"
    docker.build_image "/mnt/sei/ops/solr", args: "-t 'sei.gov/solr'"
    docker.build_image "/mnt/sei/ops/jod", args: "-t 'sei.gov/jod'"
    # docker.build_image "/mnt/sei/ops/ldap", args: "-t 'sei.gov/ldap'"

    # Provisiona docker containers na máquina virtual
    # docker run -d --name sei_data -v /var/sei/dados centos:centos6 true
    docker.run "sei_data", image: "centos:centos6", 
      daemonize: true, 
      args: "-v /var/sei/dados",
      cmd: "true"

    # docker run -t -i --name sei_db -p 3306:3306 --rm --volumes-from sei_data -v /mnt/sei/db:/mnt/sei/db sei.gov/mysql
    docker.run "sei_db",  image: "sei.gov/mysql:latest", 
      daemonize: true, 
      args: "-p 3306:3306"

    # docker run -t -i --name sei_solr -p 8983:8983 --rm -v /mnt/sei/src/sei/solr:/mnt/sei/index sei.gov/solr
    docker.run "sei_solr", image: "sei.gov/solr:latest",
      daemonize: true, 
      args: "-p 8983:8983 -v /mnt/sei/src/sei/solr:/mnt/sei/index"

    # docker run -t -i --name sei_jod -p 80:80 --rm sei.gov/jod
    docker.run "sei_jod", image: "sei.gov/jod:latest",
      daemonize: true, 
      args: "-p 8080:8080"

    # docker run -t -i --name sei_ldap -p 80:80 --rm -v /mnt/sei/ldap:/mnt/sei/ldap -v /mnt/sei/src:/mnt/sei/src sei.gov/ldap
    # docker.run "sei_ldap", image: "sei.gov/ldap:latest",
    #  daemonize: true, 
    #  args: "-p 80:80 -v /mnt/sei/ldap:/mnt/sei/ldap"    

    # docker run -t -i --name sei_www -p 80:80 --rm --link sei_solr:solr --link sei_db:db --link sei_jod:jod -v /mnt/sei/src:/var/www/html sei.gov/sei
    docker.run "sei_www", image: "sei.gov/sei:latest", 
      daemonize: true, 
      args: "-p 80:80 --link sei_db:db --link sei_solr:solr --link sei_jod:jod -v /mnt/sei/src:/var/www/html -v /mnt/sei/ops/sei:/mnt/sei/ops/sei --volumes-from sei_data"
  end

  config.vm.provision "shell", run: "always", inline: "docker start sei_data sei_db sei_solr sei_jod sei_www"
end

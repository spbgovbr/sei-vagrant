# Ambiente de Desenvolvimento - Vagrant e Docker

O objetivo dessa documentação é descrever os procedimentos para preparar um ambiente de desenvolvimento ou testes do SEI de forma rápida e padronizada através do [Vagrant](https://www.vagrantup.com/ "Clique para acessar") e [Docker](https://www.docker.com). Essas ferramentas permitem que seja provisionado automaticamente todo um ambiente funcional na máquina de trabalho do desenvolvedor, sem que seja necessário a instalação de servidores de aplicação e banco de dados pelo mesmo. Outra vantagem é que esse ambiente é completamente provisionado utilizando máquinas virtuais, necessitando que o desenvolvedor apenas configure sua IDE ou editor de texto preferido.

Antes, gostariamos de reforçar a necessidade que todo o desenvolvimento esteja alinhado com as diretivas e padrões de interface, codificação php e modelagem de banco de dados utilizados pelo SEI. A documentação dos padrões estão disponíveis na comunidade do SEI:

* [Documentação Técnica do SEI](https://www.gov.br/economia/pt-br/assuntos/processo-eletronico-nacional/destaques/material-de-apoio-2/material-de-apoio-sei "Clique para acessar")

Voltando para à configuração do ambiente de desenvolvimento, as tecnologias utilizadas nesse trabalho foram as listadas abaixo. Sugerimos uma breve leitura de suas documentações para melhor entendimento.

* Vagrant - https://www.vagrantup.com/
* Docker - https://www.docker.com/
* VirtualBox - https://www.virtualbox.org/
* Git - https://git-scm.com/

Outros recursos para melhor entendimento das tecnologias citadas acima:

* http://friendsofvagrant.github.io/v1/docs/getting-started/index.html
* https://www.youtube.com/watch?v=zg4EMgcb6H8
* http://pt.slideshare.net/RenanMartinsPimentel/vagrant-26647815
* http://pt.slideshare.net/rogeriopradoj/desenvolvimento-php-com-vagrant-15511228

O provisionamento dos componentes do sistema é implementado através da plataforma de containers do [Docker](https://www.docker.com), portanto, as imagens dos containers podem ser reutilizados isoladamente em outras configurações de infraestrutura para testes, sendo que todos os containers utilizados neste projeto estão publicados no [DockerHub](https://hub.docker.com/r/guilhermeadc/). Um exemplo de utilização dos container do Docker para preparação de ambiente de desenvolvimento do SEI pode ser visto no arquivo [docker-compose.yml](https://github.com/spbgovbr/sei-vagrant/blob/master/docker-compose.yml) utilizado internamento pelo projeto.

O Docker utiliza recursos do Kernel do Linux para gerenciar o isolamento provido pelos container, o que obriga a utilização deste sistema operacional para uso da "virtualização". Para resolver esta limitação é utilizado o Vagrant, responsável por criar uma virtualização para servir de host para o Docker e permitir sua utilização em outr
os Sistemas Operacionais, como Windows e MacOS. Sua função é semelhante ao provido pelos projetos [Boot2Docker](http://boot2docker.io/) e [Docker Machine](https://docs.docker.com/machine/).

Em resumo, o Vagrant é uma ferramenta que permite a construção de máquinas virtuais para desenvolvimento sem que seja necessário a instalação de todos os componentes da infraestrutura (banco de dados, bibliotecas, servidores web, etc) na máquina do desenvolvedor. Entre as vantagens em sua utilização estão:

* Rápido início do projeto de desenvolvimento ou testes por parte do desenvolvedor;
* Padronização do ambiente de desenvolvimento (versões de bibliotecas, banco de dados, servidores de aplicação, etc.);
* Foco nas tarefas de desenvolvimento, e n, reporte ão em questões relacionadas à configuração do ambiente.

O Vagrant trabalha com o conceito de Box, basicamente uma "imagem/iso" para se criar a instância da máquina virtual, onde é definido o sistema operacional e os demais componentes da solução. Para o projeto SEI, foi disponibilizado livremente uma Box contendo todo a ambiente funcional do SEI e seus componentes (SEI, SIP, JOD, Apache Solr), tirando a necessidade do desenvolvedor realizar toda a configuração do sistema e poder se focar apenas no desenvolvimento.

Para configurar o ambiente, será necessário a instalação dos seguintes pré-requisitos:

* **VirtualBox** Download: https://www.virtualbox.org/wiki/Downloads
* **VirtualBox Extensions** Download: https://www.virtualbox.org/wiki/Downloads
* **Vagrant** Download: https://www.vagrantup.com/downloads.html
* **Git** Download: https://git-scm.com/downloads

Todos os componentes acima precisam ser instalados na máquina de desenvolvimento, prestando atenção nas seguintes considerações:

* O VirtualBox Extensions é instalado dentro do VirtualBox, acessando o menu File > Preferences > Extensions. Sugerimos a instalação do Git com a funcionalidade GitBash ativado. Essa ativação é feita pelo Wizard de instalação do software e ele permitirá o acesso direto ao prompt de comando das máquinas virtuais Linux, caso necessário.

## CONFIGURAÇÃO DO AMBIENTE

### 1) Proxy para acesso a internet

Se a máquina localhost (desktop ou notebook) onde vai ser instalado o ambiente padrão de desenvolvimento depender de um proxy para acesso à Internet, é necessário antes configurar o proxy como variável de ambiente conforme abaixo:

    set http_proxy=http://proxy.anp.net
    set https_proxy=http://proxy.anp.net

Se o proxy exigir autenticação é necessário incluir o nome e senha do usuário, conforme este segundo exemplo:

    set http_proxy=http://<usuario>:<senha>@proxy.anp.net
    set https_proxy=http://<usuario>:<senha>@proxy.anp.net

### 2) BIOS da máquina aceitar VM

É necessário que a BIOS da máquina localhost (desktop ou notebook) onde vai ser instalado o ambiente padrão de desenvolvimento esteja com a opção para aceitar virtualização habilitada. Vide exemplo:

    [imagem_exemplo_alteracao_BIOS_permitir_VM]

### 3) Via prompt de comandos, navegue até o diretório onde está contido os códigos-fontes do SEI.

O diretório é o mesmo disponibilizado para instalação e dentro dele deve conter os seguintes diretórios:

    /sei
    /sip
    /infra

Esses arquivos serão compartilhados para dentro das máquinas virtuais criada pelo Vagrant para ativação do sistema.

Com isso, as alterações feitas diretamente nos arquivos php durante do desenvolvimento refletirão de forma automática no ambiente que estará disponível em http://localhost:8000/sei

### 4) Realizar a configuração inicial do Box do Vagrant/VirtualBox

No diretório citado anteriormente, execute o seguinte comando:

Para a versão 4.0.X, execute:

    vagrant init processoeletronico/sei-4.0


Para a versão 3.1.X, execute:

    vagrant init processoeletronico/sei-3.1


Esse comando irá criar uma arquivo de configuração iniciar para o vagrant contendo a referência para o BOX do SEI completamente configurado. Ao final da execução, um arquivo chamado Vagrantfile deverá estar presente no diretório atual.

Outra alternativa para configuração pode ambiente pode ser realizada pelos scripts utilitários criados no ambiente colaborativo. Vide seção INFORMAÇÕES ADICIONAIS >> 2) Scritps utilitários .bat.

### 5) Iniciar o Ambiente de Desenvolvimento Virtualizado

No mesmo diretório, execute o comando:

    # vagrant up

Esse comando irá iniciar a construção do ambiente de desenvolvimento começando pelo download da Box processoeletronico/sei-3.0.0 contendo todo o ambiente preparado para o desenvolvimento.

É normal que a primeira execução desse comando demore vários minutos para ser concluído, pois a imagem/box, com cerca de 2GB, será baixada para a máquina de desenvolvimento. Após o fim da transferência, o ambiente estará disponível em questão de minutos.

Na versão 4.0, é possível indicar qual base de dados será utilizada no ambiente local, as opções disponíveis sendo Oracle, SQLServer e MySQL (padrão). Caso deseja selecionar outro banco de dados, execute o comando _vagrant up_ com o parâmetro _--provision-with [oracle, mysql ou sqlserver]_

    # vagrant up --provision-with [oracle, sqlserver ou mysql]

Após a conclusão do primeiro provisionamento, o ambiente poderá ser destruído e recriado rapidamente já que vagrant armazenará a BOX/Imagem de referência em seu cache.

Ao final da inicialização do ambiente de desenvolvimento, será apresentada a mensagem abaixo, indicando que todos os serviços do SEI já estão em operação na máquina de desenvolvimento:

    ===> default: Starting smtp
    ===> default: Starting jod
    ===> default: Starting mysql
    ===> default: Starting solr
    ===> default: Starting memcached    
    ===> default: Starting http

### 6) Testar a Aplicação

#### SEI
Após a finalização do provisionamento do ambiente e a apresentação das mensagens acima, o SEI estará disponível para testes na máquina local de desenvolvimento através do acesso ao endereço http://localhost:8000/sei. O usuário para acesso será o login: teste / senha: teste, o mesmo configurado na base inicial do sistema.

Importante mencionar que o sistema que está rodando nesse endereço se baseia exatamente no código-fonte do SEI presente na diretório onde foi executado o comando vagrant up. A alteração feita no código-fonte do sistema poderá ser visto instantaneamente no sei através de um simples Refresh no browser do desenvolvedor.

#### SIP
Da mesma forma como descrito anteriormente, o sip estará disponível no endereço http://localhost:8000/sip e o usuário de acesso será o login: teste / senha: teste, o mesmo configurado na base inicial do sistema.

#### BANCOS DE DADOS
O componente chamado db, apresentado logo após o provisionamento do ambiente, se refere ao serviço de banco de dados escolhido durante o provisionamento do ambiente, podendo ser o MySQL (padrão, Oracle ou SQLServer. A base poderá ser acesso por qualquer utilitário de conexão á banco de dados. Este serviço estará com os 2 bancos de dados utilizados pelo SEI (sei e sip) e poderá ser acessados com os seguintes usuários:

##### MySQL
    Usuário Root do MySQL: login:root / senha:P@ssword
    Usuário da Base de Dados do SEI: login: sei_user / senha: sei_user
    Usuário da Base de Dados do SIP: login: sip_user / senha: sip_user

    Ex: mysql -h 127.0.0.1 -u root -p sei

##### Oracle
    Usuário Root do Oracle: login:sys / senha:P@ssword
    Usuário de sistema do Oracle: login:system / senha:P@ssword
    Usuário da Base de Dados do SEI: login: sei_user / senha: sei_user
    Usuário da Base de Dados do SIP: login: sip_user / senha: sip_user

    Ex: sqlplus sys/P@ssword as sysdba

##### SQLServer
    Usuário Root do SQLServer: login:sa / senha:P@ssword
    Usuário da Base de Dados do SEI: login: sei_user / senha: sei_user
    Usuário da Base de Dados do SIP: login: sip_user / senha: sip_user

    Ex: tsql -S 127.0.0.1 -U sa -P P@ssword 


* **Apache Solr** O Apache Solr também estará disponível para testes e poderá ser acessado pelo endereço: http://localhost:8983/solr
* **Memcached** Servidor de cache utilizado pela aplicação SEI e SIP http://localhost:11211
* **Serviço SMTP para visualizar e-mails enviados** O ambiente de desenvolvimento possui um serviço SMTP próprio para disparar os e-mails do sistema. Para visualizar os e-mails enviados acesse: http://localhost:1080

## INFORMAÇÕES ADICIONAIS

A operação do ambiente de desenvolvimento virtualizado pelo vagrant poderá ser feito de 2 formas:

#### 1) Comandos Básicos do Vagrant
Os seguintes comandos poderão ser executados no diretório onde está localizado o código-fonte do SEI para ligar e desligar o ambiente:

    vagrant up

Responsável por inicializar as máquina virtuais e gerenciar o redirecionamento dos serviços para VM para à máquina local de desenvolvimento. Caso não exista nenhum ambiente previamente configurado na máquina local, ele também se encarregará de fazer toda a instalação e provisionamento da máquina virtual.

    vagrant halt

Responsável por desligar as máquina virtuais desligar todos os serviços em execução.

    vagrant reload

Reinicia todo o ambiente de desenvolvimento e sua máquina virtual.

    vagrant destroy

Como o nome diz, destroi todo o ambiente de desenvolvimento utilizado até o momento, apagando todas as informações persistidas no banco de dados. A simples execução do comando vagrant up reconstrói um novo ambiente limpo para o sistema SEI.

    vagrant box update

Atualizar o vagrant com nova imagem da VM atualizada com correções ou evoluções:


#### 2) Scritps utilitários .bat
Para simplificar a operação do ambiente virtual no Windows, o NeiJobson/Anatel criou os seguintes scripts .bat que estão disponíveis no ambiente colaborativo do SEI (https://softwarepublico.gov.br/gitlab/sei/sei-vagrant/tree/master​). Eles poderão ser baixados e copiados para o diretório onde está o código-fonte do sistema, cada um com as seguintes funções:

----------


    provisionar_VM_Dev_Localhost_SEI.bat

Responsável por criar a configuração inicial do ambiente de desenvolvimento do SEI (vagrantfile). Semelhante ao comando vagrant init processoeletronico/sei-3.0.0
Download: https://softwarepublico.gov.br/gitlab/sei/sei-vagrant/raw/master/provisionar_VM_Dev_Localhost_SEI.bat


----------


    iniciar_VM_Dev_Localhost_SEI.bat

Responsável por inicializar as máquina virtuais e gerenciar o redirecionamento dos serviços para VM para à máquina local de desenvolvimento. Caso não exista nenhum ambiente previamente configurado na máquina local, ele também se encarregará de fazer toda a instalação e provisionamento da máquina virtual. Semelhando ao comando vagrant up
Download: https://softwarepublico.gov.br/gitlab/sei/sei-vagrant/raw/master/iniciar_VM_Dev_Localhost_SEI.bat


----------


    parar_VM_Dev_Localhost_SEI.bat

Responsável por desligar as máquina virtuais desligar todos os serviços em execução. Semelhante ao comando vagrant halt
Download:https://softwarepublico.gov.br/gitlab/sei/sei-vagrant/raw/master/parar_VM_Dev_Localhost_SEI.bat


----------


    destruir_VM_Dev_Localhost_SEI.bat

Como o nome diz, destroi todo o ambiente de desenvolvimento utilizado até o momento, apagando todas as informações persistidas no banco de dados. A simples execução do comando vagrant up reconstrói um novo ambiente limpo para o sistema SEI. Semelhante ao comando vagrant destroy.
Download: https://softwarepublico.gov.br/gitlab/sei/sei-vagrant/raw/master/destruir_VM_Dev_Localhost_SEI.bat



# Colabore com o projeto SEI-Vagrant

Para colaborar com o projeto SEI-Vagrant e enviar sugestões de melhorias ou correções de erros, os seguintes passos devem ser realizados para que possamos avaliar e incorporar as melhorias em próximas versões:


### 1) Registrar uma demanda (Issue) no projeto

Este registro é fundamental para documentar a demanda para avaliação pelos responsáveis. Somente os pedidos de 
Merge Request com issue relacionada serão avaliadas.

Para cadastrar uma nova issue no projeto SEI-Vagrant, acesse https://softwarepublico.gov.br/gitlab/sei/sei-vagrant/issues

### 2) Fazer o *fork* do projeto SEI-Vagrant

Crie um novo fork do projeto no GitLab para criar um novo repositório do projeto para ser gerenciado por você, permitindo 
o envio de futuros Merge Request para o projeto princial

### 3) Preparação do ambiente

Depois de criado um fork do projeto, será necessário preparar seu ambiente para desenvolver melhorias na virtualização e
gerar novos ambientes do Vagrant (vagrant box) para publicação. Para isto, será necessário instalar um pacote adicional 
além de todas aquelas já descritas anteriormente neste documento (instalar Virtualbox, Vagrant, git, etc...)

O pacote adicional é o utilitário Packer, utilizado para empacotar as máquinas virtuais do VirtualBox em novas boxes do 
Vagrant para compartilhamento. Esta ferramenta pode ser encontrada em https://www.packer.io/

### 4) Construir e empacotar uma Vagrant Box

Para simplificar o processo de construção dos componentes internos do SEI, sugerimos utilizar os comandos disponíveis no Makefile, localizado na raiz do projeto, para automatizar todos os passos descritos abaixo:

* `make build-containers`: Constrói todas as imagens dos containers da aplicação no docker
* `make publish-containers`: Publica as imagens no dockerhub do projeto (autorização necessária)
* `make build-vm`: Constroi a BOX do vagrant (virtualbox) contendo os containers docker na versão e configuração correta
* `make install-vm`: Instala localmente a box em desenvolvimento para testes, utilizando no nome sei-vagrant

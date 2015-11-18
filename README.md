#Ambiente de Desenvolvimento - Vagrant

O objetivo dessa documentação é descrever os procedimentos para preparar um ambiente de desenvolvimento ou testes do SEI de forma rápida e padronizada através do Vagrant. Essa ferramenta permite que seja provisionado automaticamente todo um ambiente funcional na máquina de trabalho do desenvolvedor, sem que seja necessário a instalação de servidores de aplicação e banco de dados pelo mesmo. Outra vantagem é que esse ambiente é completamente provisionado utilizando máquinas virtuais, necessitando que o desenvolvedor apenas configure sua IDE ou editor de texto preferido.

Antes, gostariamos de reforçar a necessidade que todo o desenvolvimento esteja alinhado com as diretivas e padrões de interface, codificação php e modelagem de banco de dados utilizados pelo SEI. A documentação dos padrões estão disponíveis na comunidade do SEI:

* Documentação Técnica do SEI
* Padrão de Codificação PHP 
* Padrão de Modelagem de Dados

Outra fator importante de ser feito, antes do início dos trabalhos de desenvolvimento, é a indicação da demanda previamente aprovada (Lista de Demandas do Projeto), juntamente com a Especificação de Requisitos, para avaliação, revisão e aprovação do Comitê Gestor. De acordo com o padrão trabalho estabelecido, todos as novas funcionalidades que serão implementadas no SEI precisarão de uma aprovação prévia do Comitê Gestor para que possam ser implementadas e, posteriormente, homologadas e integradas ao sistema.

Voltando para à configuração do ambiente de desenvolvimento, as tecnologias utilizadas nesse trabalho foram as listadas abaixo. Sugerimos uma breve leitura de suas documentações para melhor entendimento.

* ​Virtual Box - https://www.virtualbox.org/
* ​Vagrant - https://www.vagrantup.com/
* ​Git - https://git-scm.com/

Outros recursos para melhor entendimento das tecnologias citadas acima:

* http://friendsofvagrant.github.io/v1/docs/getting-started/index.html
* https://www.youtube.com/watch?v=zg4EMgcb6H8
* http://pt.slideshare.net/RenanMartinsPimentel/vagrant-26647815
* http://pt.slideshare.net/rogeriopradoj/desenvolvimento-php-com-vagrant-15511228

Em resumo, o Vagrant é uma ferramenta que permite a construção de máquinas virtuais para desenvolvimento sem que seja necessário a instalação de todos os componentes da infraestrutura (banco de dados, bibliotecas, servidores web, etc) na máquina do desenvolvedor. Entre as vantagens em sua utilização estão:

* Rápido início do projeto de desenvolvimento ou testes por parte do desenvolvedor;
* Padronização do ambiente de desenvolvimento (versões de bibliotecas, banco de dados, servidores de aplicação, etc.);
* Foco nas tarefas de desenvolvimento, e não em questões relacionadas à configuração do ambiente.

O Vagrant trabalha com o conceito de Box, basicamente uma "imagem/iso" para se criar a instância da máquina virtual, onde é definido o sistema operacional e os demais componentes da solução. Para o projeto SEI, foi disponibilizado livremente uma Box contendo todo a ambiente funcional do SEI e seus componentes (SEI, SIP, JOD, Apache Solr), tirando a necessidade do desenvolvedor realizar toda a configuração do sistema e poder se focar apenas no desenvolvimento.

Para configurar o ambiente, será necessário a instalação dos seguintes pré-requisitos:

* **VirtualBox**
Download: https://www.virtualbox.org/wiki/Download_Old_Builds_4_3

* **VirtualBox Extensions**
Download: http://download.virtualbox.org/virtualbox/4.3.30/Oracle_VM_VirtualBox_Extension_Pack-4.3.30-101610.vbox-extpack

* **Vagrant**
Download: https://www.vagrantup.com/downloads.html

* **Git**
Download: https://git-scm.com/downloads

Todos os componentes acima precisam ser instalados na máquina de desenvolvimento, prestando atenção nas seguintes considerações:

O VirtualBox Extensions é instalado dentro do VirtualBox, acessando o menu File > Preferences > Extensions. Sugerimos a instalação do Git com a funcionalidade GitBash ativado. Essa ativação é feita pelo Wizard de instalação do software e ele permitirá o acesso direto ao prompt de comando das máquinas virtuais Linux, caso necessário.

Feito a instalação dos pré-requisitos, siga os passos abaixo para ativar o ambiente virtual do SEI:
 

##CONFIGURAÇÃO DO AMBIENTE

### 1) Via prompt de comandos, navegue até o diretório onde está contido os códigos-fontes do SEI.

O diretório é o mesmo disponibilizado para instalação e dentro dele deve conter os seguintes diretórios:

    /sei
    /sip
    /infra_php
    /infra_css
    /infra_js

Esses arquivos serão compartilhados para dentro das máquinas virtuais criada pelo Vagrant para ativação do sistema.
Com isso, as alterações feitas diretamente nos arquivos php durante do desenvolvimento refletirão de forma automática no ambiente que estará disponível em http://localhost/sei

### 2) Realizar a configuração inicial do Box do Vagrant/VirtualBox

No diretório citado anteriormente, execute o seguinte comando:

    vagrant init processoeletronico/sei-2.6.0

Esse comando irá criar uma arquivo de configuração iniciar para o vagrant contendo a referência para o BOX do SEI completamente configurado. Ao final da execução, um arquivo chamado Vagrantfile deverá estar presente no diretório atual.

Outra alternativa para configuração pode ambiente pode ser realizada pelos scripts utilitários criados no ambiente colaborativo. Vide seção INFORMAÇÕES ADICIONAIS >> 2) Scritps utilitários .bat.

### 3) Iniciar o Ambiente de Desenvolvimento Virtualizado

No mesmo diretório, execute o comando :

vagrant up

Esse comando irá iniciar a construção do ambiente de desenvolvimento começando pelo download da Box processoeletronico/sei-2.6.0 contendo todo o ambiente preparado para o desenvolvimento.

É normal que a primeira execução desse comando demore vários minutos para ser concluído, pois a imagem/box, com cerca de 2GB, será baixada para a máquina de desenvolvimento. Após o fim da transferência, o ambiente estará disponível em questão de minutos.

Após a conclusão do primeiro provisionamento, o ambiente poderá ser destruído e recriado rapidamente já que vagrant armazenará a BOX/Imagem de referência em seu cache.

Ao final da inicialização do ambiente de desenvolvimento, será apresentada a seguinte mensagem abaixo indicando que todos os serviços do SEI já estão em operação na máquina de desenvolvimento. A mensagem é :

    ===> default: sei_db
    ===> default: sei_solr
    ===> default: sei_jod
    ===> default: sei_www

### 4) Testar a Aplicação

**SEI**
Após a finalização do provisionamento do ambiente e a apresentação das mensagens acima, o SEI estará disponível para testes na máquina local de desenvolvimento através do acesso ao endereço http://localhost/sei. O usuário para acesso será o login: teste / senha: teste, o mesmo configurado na base inicial do sistema.

Importante mencionar que o sistema que está rodando nesse endereço se baseia exatamente no código-fonte do SEI presente na diretório onde foi executado o comando vagrant up. A alteração feita no código-fonte do sistema poderá ser visto instantaneamente no sei através de um simples Refresh no browser do desenvolvedor.

**SIP**
Da mesma forma como descrito anteriormente, o sip estará disponível no endereço http://localhost/sip e o usuário de acesso será o login: teste / senha: teste, o mesmo configurado na base inicial do sistema.

**Banco de dados MySQL**
O componente chamado sei_db , apresentado logo após o provisionamento do ambiente, se refere ao serviço de banco de dados do MySQL que estará acessível na máquina local através da portal 3306. O banco de dados poderá ser acesso pelo MySQL Workbench ou qualquer outra ferramenta de conexão á banco de dados. Este serviço estará com os 2 bancos de dados utilizados pelo SEI (sei e sip) e poderá ser acessados com os seguintes usuários:

    Usuário Root do MySQL: login:root / senha:root
    Usuário da Base de Dados do SEI: login: sei_user / senha: sei_user
    Usuário da Base de Dados do SIP: login: sip_user / senha: sip_user

    Ex: mysql -h 127.0.0.1 -u root -p sei

**Apache Solr**
O Apache Solr também estará disponível para testes e poderá ser acessado pelo endereço http://localhost:8983/solr

**JOD Converter**
O JOD Converter também estará disponível para testes e poderá ser acesso pelo enderelo http://localhost:8080

 

##INFORMAÇÕES ADICIONAIS

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

#### 2) Scritps utilitários .bat
Para simplificar a operação do ambiente virtual no Windows, o NeiJobson/Anatel criou os seguintes scripts .bat que estão disponíveis no ambiente colaborativo do SEI (https://softwarepublico.gov.br/gitlab/sei/sei-vagrant/tree/master​). Eles poderão ser baixados e copiados para o diretório onde está o código-fonte do sistema, cada um com as seguintes funções:


----------


    provisionar_VM_Dev_Localhost_SEI.bat

Responsável por criar a configuração inicial do ambiente de desenvolvimento do SEI (vagrantfile). Semelhante ao comando vagrant init processoeletronico/sei-2.6.0
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

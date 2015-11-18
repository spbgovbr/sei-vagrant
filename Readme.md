<h1>Ambiente de Desenvolvimento - Vagrant</h1>
<p><strong>PS: A documentação encontra-se em construção. Por isso, ainda é necessário revisão de algumas informações. Caso encontre algum dado errado ou informação ambígua, favor notificar a equipe do projeto pelo e-mail <a class="email" href="mailto:processo.eletronico@planejamento.gov.br">processo.eletronico@planejamento.gov.br</a></strong></p>
<p>O objetivo dessa documentação é descrever os procedimentos para preparar um ambiente de desenvolvimento ou testes do SEI de forma rápida e padronizada através do <a class="external" href="https://www.vagrantup.com/">Vagrant</a>. Essa ferramenta permite que seja provisionado automaticamente todo um ambiente funcional na máquina de trabalho do desenvolvedor, sem que seja necessário a instalação de servidores de aplicação e banco de dados pelo mesmo. Outra vantagem é que esse ambiente é completamente provisionado utilizando máquinas virtuais, necessitando que o desenvolvedor apenas configure sua IDE ou editor de texto preferido.</p>
<p>Antes, gostariamos de reforçar a necessidade que todo o desenvolvimento esteja alinhado com as diretivas e padrões de interface, codificação php e modelagem de banco de dados utilizados pelo SEI. A documentação dos padrões estão disponíveis na comunidade do SEI:</p>
<p><a href="https://softwarepublico.gov.br/social/sei/manuais/pagina-inicial-manuais">Documentação Técnica do SEI</a><br /><a href="https://softwarepublico.gov.br/social/sei/manuais/padrao-de-codificacao-php/sumario">Padrão de Codificação PHP</a> <br /><a href="https://softwarepublico.gov.br/social/sei/manuais/padrao-de-modelagem-de-dados/sumario">Padrão de Modelagem de Dados</a></p>
<p>Outra fator importante de ser feito, antes do início dos trabalhos de desenvolvimento, é a indicação da demanda previamente aprovada (<a class="external" href="https://processoeletronico.gov.br/projects/sei/issues?query_id=1">Lista de Demandas do Projeto</a>), juntamente com a Especificação de Requisitos, para avaliação, revisão e aprovação do Comitê Gestor. De acordo com o padrão trabalho estabelecido, todos as novas funcionalidades que serão implementadas no SEI precisarão de uma aprovação prévia do Comitê Gestor para que possam ser implementadas e, posteriormente, homologadas e integradas ao sistema.</p>
<p>Voltando para à configuração do ambiente de desenvolvimento, as tecnologias utilizadas nesse trabalho foram as listadas abaixo. Sugerimos uma breve leitura de suas documentações para melhor entendimento.</p>
<ul>
<li>​Virtual Box - <a class="external" href="https://www.virtualbox.org/">https://www.virtualbox.org/</a></li>
<li>​Vagrant - <a class="external" href="https://www.vagrantup.com/">https://www.vagrantup.com/</a></li>
<li>​Git - <a class="external" href="https://git-scm.com/">https://git-scm.com/</a></li>
</ul>
<p>Outros recursos para melhor entendimento das tecnologias citadas acima:</p>
<ul>
<li>​http://friendsofvagrant.github.io/v1/docs/getting-started/index.html</li>
<li>​https://www.youtube.com/watch?v=zg4EMgcb6H8</li>
<li>​http://pt.slideshare.net/RenanMartinsPimentel/vagrant-26647815</li>
<li>​http://pt.slideshare.net/rogeriopradoj/desenvolvimento-php-com-vagrant-15511228</li>
</ul>
<p>Em resumo, o Vagrant é uma ferramenta que permite a construção de máquinas virtuais para desenvolvimento sem que seja necessário a instalação de todos os componentes da infraestrutura (banco de dados, bibliotecas, servidores web, etc) na máquina do desenvolvedor. Entre as vantagens em sua utilização estão:</p>
<ul>
<li>Rápido início do projeto de desenvolvimento ou testes por parte do desenvolvedor;</li>
<li>Padronização do ambiente de desenvolvimento (versões de bibliotecas, banco de dados, servidores de aplicação, etc.);</li>
<li>Foco nas tarefas de desenvolvimento, e não em questões relacionadas à configuração do ambiente.</li>
</ul>
<p>O Vagrant trabalha com o conceito de Box, basicamente uma "imagem/iso" para se criar a instância da máquina virtual, onde é definido o sistema operacional e os demais componentes da solução. Para o projeto SEI, foi disponibilizado livremente uma Box contendo todo a ambiente funcional do SEI e seus componentes (SEI, SIP, JOD, Apache Solr), tirando a necessidade do desenvolvedor realizar toda a configuração do sistema e poder se focar apenas no desenvolvimento.</p>
<p>Para configurar o ambiente, será necessário a instalação dos seguintes pré-requisitos:</p>
<ul>
<li><strong>​VirtualBox</strong> (testado na versão 4.3. Nas últimas semanas foi disponibilizado a versão 5.0 que ainda não foi utilizada para testes)<br />Download: <a class="external" href="https://www.virtualbox.org/wiki/Download_Old_Builds_4_3">https://www.virtualbox.org/wiki/Download_Old_Builds_4_3</a>​</li>
</ul>
<ul>
<li><strong>VirtualBox Extensions</strong><br />Download: <a class="external" href="http://download.virtualbox.org/virtualbox/4.3.30/Oracle_VM_VirtualBox_Extension_Pack-4.3.30-101610.vbox-extpack">http://download.virtualbox.org/virtualbox/4.3.30/Oracle_VM_VirtualBox_Extension_Pack-4.3.30-101610.vbox-extpack</a></li>
</ul>
<ul>
<li><strong>Vagrant</strong><br />Download: <a class="external" href="https://www.vagrantup.com/downloads.html">https://www.vagrantup.com/downloads.html</a></li>
</ul>
<ul>
<li><strong>Git</strong><br />Download: <a class="external" href="https://git-scm.com/downloads">https://git-scm.com/downloads</a></li>
</ul>
<p>Todos os componentes acima precisam ser instalados na máquina de desenvolvimento, prestando atenção nas seguintes considerações:</p>
<ul>
<li>O <strong>VirtualBox Extensions</strong> é instalado dentro do VirtualBox, acessando o menu <code>File &gt; Preferences &gt; Extensions</code>. Sugerimos a instalação do Git com a funcionalidade GitBash ativado. Essa ativação é feita pelo Wizard de instalação do software e ele permitirá o acesso direto ao prompt de comando das máquinas virtuais Linux, caso necessário.</li>
</ul>
<p>Feito a instalação dos pré-requisitos, siga os passos abaixo para ativar o ambiente virtual do SEI:</p>
<div class="contextual" title="Editar esta seção"> </div>
<p><a name="CONFIGURAÇÃO-DO-AMBIENTE"></a></p>
<h2>CONFIGURAÇÃO DO AMBIENTE</h2>
<p><ins><strong>1) Via prompt de comandos, navegue até o diretório onde está contido os códigos-fontes do SEI.</strong></ins></p>
<p>O diretório é o mesmo disponibilizado para instalação e dentro dele deve conter os seguintes diretórios:</p>
<blockquote>
<p>/sei<br />/sip<br />/infra_php<br />/infra_css<br />/infra_js</p>
</blockquote>
<p>Esses arquivos serão compartilhados para dentro das máquinas virtuais criada pelo Vagrant para ativação do sistema. <br />Com isso, as alterações feitas diretamente nos arquivos php durante do desenvolvimento refletirão de forma automática no ambiente que estará disponível em <a class="external" href="http://localhost/sei">http://localhost/sei</a></p>
<p><ins><strong>2) Realizar a configuração inicial do Box do Vagrant/VirtualBox</strong></ins></p>
<p>No diretório citado anteriormente, execute o seguinte comando:</p>
<blockquote>
<p><code>vagrant init processoeletronico/sei-2.6.0</code></p>
</blockquote>
<p>Esse comando irá criar uma arquivo de configuração iniciar para o vagrant contendo a referência para o <acronym title="Imagem">BOX</acronym> do SEI completamente configurado. Ao final da execução, um arquivo chamado Vagrantfile deverá estar presente no diretório atual.</p>
<p>Outra alternativa para configuração pode ambiente pode ser realizada pelos scripts utilitários criados no ambiente colaborativo. Vide seção INFORMAÇÕES ADICIONAIS &gt;&gt; 2) Scritps utilitários .bat.</p>
<p><ins><strong>3) Iniciar o Ambiente de Desenvolvimento Virtualizado</strong></ins></p>
<p>No mesmo diretório, execute o comando :</p>
<pre><code><code>vagrant up</code></code></pre>
<p>Esse comando irá iniciar a construção do ambiente de desenvolvimento começando pelo download da Box <code>processoeletronico/sei-2.6.0</code> contendo todo o ambiente preparado para o desenvolvimento.</p>
<p>É normal que a primeira execução desse comando demore vários minutos para ser concluído, pois a imagem/box, com cerca de 2GB, será baixada para a máquina de desenvolvimento. Após o fim da transferência, o ambiente estará disponível em questão de minutos.</p>
<p>Após a conclusão do primeiro provisionamento, o ambiente poderá ser destruído e recriado rapidamente já que vagrant armazenará a BOX/Imagem de referência em seu cache.</p>
<p>Ao final da inicialização do ambiente de desenvolvimento, será apresentada a seguinte mensagem abaixo indicando que todos os serviços do SEI já estão em operação na máquina de desenvolvimento. A mensagem é :</p>
<blockquote>
<p>===&gt; default: sei_db<br />===&gt; default: sei_solr<br />===&gt; default: sei_jod<br />===&gt; default: sei_www</p>
</blockquote>
<p><ins><strong>4) Testar a Aplicação</strong></ins></p>
<p><strong>SEI</strong><br />Após a finalização do provisionamento do ambiente e a apresentação das mensagens acima, o SEI estará disponível para testes na máquina local de desenvolvimento através do acesso ao endereço <a class="external" href="http://localhost/sei">http://localhost/sei</a>. O usuário para acesso será o login: teste / senha: teste, o mesmo configurado na base inicial do sistema.</p>
<p>Importante mencionar que o sistema que está rodando nesse endereço se baseia exatamente no código-fonte do SEI presente na diretório onde foi executado o comando vagrant up. A alteração feita no código-fonte do sistema poderá ser visto instantaneamente no sei através de um simples Refresh no browser do desenvolvedor.</p>
<p><strong>SIP</strong><br />Da mesma forma como descrito anteriormente, o sip estará disponível no endereço <a class="external" href="http://localhost/sip">http://localhost/sip</a> e o usuário de acesso será o login: teste / senha: teste, o mesmo configurado na base inicial do sistema.</p>
<p><strong>Banco de dados MySQL</strong><br />O componente chamado sei_db , apresentado logo após o provisionamento do ambiente, se refere ao serviço de banco de dados do MySQL que estará acessível na máquina local através da portal 3306. O banco de dados poderá ser acesso pelo MySQL Workbench ou qualquer outra ferramenta de conexão á banco de dados. Este serviço estará com os 2 bancos de dados utilizados pelo SEI (sei e sip) e poderá ser acessados com os seguintes usuários:</p>
<blockquote>
<p>Usuário Root do MySQL: login:root / senha:root<br />Usuário da Base de Dados do SEI: login: sei_user / senha: sei_user<br />Usuário da Base de Dados do SIP: login: sip_user / senha: sip_user</p>
</blockquote>
<p>​Ex:<code> mysql -h 127.0.0.1 -u root -p sei</code></p>
<p><strong>Apache Solr</strong><br />O Apache Solr também estará disponível para testes e poderá ser acessado pelo endereço <a class="external" href="http://localhost:8983/solr">http://localhost:8983/solr</a></p>
<p><strong>JOD Converter</strong><br />O JOD Converter também estará disponível para testes e poderá ser acesso pelo enderelo <a href="http://localhost:8080">http://localhost:8080</a></p>
<p> </p>
<p><a name="INFORMAÇÕES-ADICIONAIS"></a></p>
<h2>INFORMAÇÕES ADICIONAIS</h2>
<p>A operação do ambiente de desenvolvimento virtualizado pelo vagrant poderá ser feito de 2 formas:</p>
<p><strong>1) Comandos Básicos do Vagrant</strong><br />Os seguintes comandos poderão ser executados no diretório onde está localizado o código-fonte do SEI para ligar e desligar o ambiente:</p>
<blockquote>
<blockquote>
<p><code>vagrant up</code></p>
</blockquote>
</blockquote>
<p>Responsável por inicializar as máquina virtuais e gerenciar o redirecionamento dos serviços para VM para à máquina local de desenvolvimento. Caso não exista nenhum ambiente previamente configurado na máquina local, ele também se encarregará de fazer toda a instalação e provisionamento da máquina virtual.</p>
<blockquote>
<blockquote>
<p><code>vagrant halt</code></p>
</blockquote>
</blockquote>
<p>Responsável por desligar as máquina virtuais desligar todos os serviços em execução.</p>
<blockquote>
<blockquote>
<p><code>vagrant reload</code></p>
</blockquote>
</blockquote>
<p>Reinicia todo o ambiente de desenvolvimento e sua máquina virtual.</p>
<blockquote>
<blockquote>
<p><code>vagrant destroy</code></p>
</blockquote>
</blockquote>
<p>Como o nome diz, destroi todo o ambiente de desenvolvimento utilizado até o momento, apagando todas as informações persistidas no banco de dados. A simples execução do comando vagrant up reconstrói um novo ambiente limpo para o sistema SEI.</p>
<p><strong><ins>2) Scritps utilitários .bat</ins></strong><br />Para simplificar a operação do ambiente virtual no Windows, o NeiJobson/Anatel criou os seguintes scripts .bat que estão disponíveis no ambiente colaborativo do SEI (<a class="external" href="https://gitlab.processoeletronico.gov.br/sei/sei-vagrant/tree/master%E2%80%8B">https://gitlab.processoeletronico.gov.br/sei/sei-vagrant/tree/master​</a>). Eles poderão ser baixados e copiados para o diretório onde está o código-fonte do sistema, cada um com as seguintes funções:</p>
<p><code>provisionar_VM_Dev_Localhost_SEI.bat</code><br />Responsável por criar a configuração inicial do ambiente de desenvolvimento do SEI (vagrantfile). Semelhante ao comando vagrant init processoeletronico/sei-2.6.0<br />Download: <a class="external" href="https://gitlab.processoeletronico.gov.br/sei/sei-vagrant/raw/master/provisionar_VM_Dev_Localhost_SEI.bat">https://gitlab.processoeletronico.gov.br/sei/sei-vagrant/raw/master/provisionar_VM_Dev_Localhost_SEI.bat</a></p>
<p><code>iniciar_VM_Dev_Localhost_SEI.bat</code><br />Responsável por inicializar as máquina virtuais e gerenciar o redirecionamento dos serviços para VM para à máquina local de desenvolvimento. Caso não exista nenhum ambiente previamente configurado na máquina local, ele também se encarregará de fazer toda a instalação e provisionamento da máquina virtual. Semelhando ao comando vagrant up<br />Download: <a class="external" href="https://gitlab.processoeletronico.gov.br/sei/sei-vagrant/raw/master/iniciar_VM_Dev_Localhost_SEI.bat">https://gitlab.processoeletronico.gov.br/sei/sei-vagrant/raw/master/iniciar_VM_Dev_Localhost_SEI.bat</a></p>
<p><code>parar_VM_Dev_Localhost_SEI.bat</code><br />Responsável por desligar as máquina virtuais desligar todos os serviços em execução. Semelhante ao comando vagrant halt<br />Download: <a class="external" href="https://gitlab.processoeletronico.gov.br/sei/sei-vagrant/raw/master/parar_VM_Dev_Localhost_SEI.bat">https://gitlab.processoeletronico.gov.br/sei/sei-vagrant/raw/master/parar_VM_Dev_Localhost_SEI.bat</a></p>
<p><code>destruir_VM_Dev_Localhost_SEI.bat</code><br />Como o nome diz, destroi todo o ambiente de desenvolvimento utilizado até o momento, apagando todas as informações persistidas no banco de dados. A simples execução do comando vagrant up reconstrói um novo ambiente limpo para o sistema SEI. Semelhante ao comando vagrant destroy.<br />Download: <a class="external" href="https://gitlab.processoeletronico.gov.br/sei/sei-vagrant/raw/master/destruir_VM_Dev_Localhost_SEI.bat">https://gitlab.processoeletronico.gov.br/sei/sei-vagrant/raw/master/destruir_VM_Dev_Localhost_SEI.bat</a></p>
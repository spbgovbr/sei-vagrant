<?

require_once dirname(__FILE__).'/SEI.php';

class ConfiguracaoSEI extends InfraConfiguracao  {

 	private static $instance = null;

 	public static function getInstance(){
 	  if (ConfiguracaoSEI::$instance == null) {
 	    ConfiguracaoSEI::$instance = new ConfiguracaoSEI();
 	  }
 	  return ConfiguracaoSEI::$instance;
 	}

 	public function getArrConfiguracoes(){
 	  return array(

 	      'SEI' => array(
 	      	  // Endereço de acesso à aplicação SEI
 	          'URL' => 'http://localhost/sei',

 	          // Habilita melhorias de performance casa aplicação esteja em produção
 	          'Producao' => false,

 	          // Local de armazenamento dos arquivos externos
 	          'RepositorioArquivos' => '/var/sei/arquivos',

 	          // Conjunto de módulos integrados na aplicação. 
 	          // Exemplo: 'Modulos' => array('ModuloA' => dirname(__FILE__).'/moduloa')
 	          'Modulos' => array(),
 	          ),

 	      'PaginaSEI' => array(
 	          'NomeSistema' => 'SEI',
 	          'NomeSistemaComplemento' => 'v2.5.2',
 	          'LogoMenu' => ''),
 	       
 	      'SessaoSEI' => array(
 	          'SiglaOrgaoSistema' => 'ABC',
 	          'SiglaSistema' => 'SEI',
 	          'PaginaLogin' => 'http://localhost/sip/login.php',
 	          'SipWsdl' => 'http://localhost/sip/controlador_ws.php?servico=wsdl',
 	          'https' => false),
 	       
 	      'BancoSEI'  => array(
 	          'Servidor' => getenv("DB_PORT_3306_TCP_ADDR"),
 	          'Porta' => getenv("DB_PORT_3306_TCP_PORT"),
 	          'Banco' => 'sei',
 	          'Usuario' => 'sei_user',
 	          'Senha' => 'sei_user',
 	          'Tipo' => 'MySql'), //MySql ou SqlServer
 	       
 	      'Editor' => array(
 	          'Edoc' => false,
 	          'CarregarAgenteEdoc' => false,
 	          'Interno' => true),

 	      'CacheSEI' => array(
 	          'Servidor' => '127.0.0.1',
 	          'Porta' => '11211'),

              // Endereço do WebService utilizado para busca de cargos e funções externas
              'RH' => array('CargoFuncao' => ''),
 	       
 	      'JODConverter' => array('Servidor' => 'http://'.getenv("JOD_PORT_8080_TCP_ADDR").':'.getenv("JOD_PORT_8080_TCP_PORT").'/converter/service'),

 	      'Edoc' => array('Servidor' => 'http://[Servidor .NET]'),
 	       
 	      'Pesquisa' => array(
 	          'Banco' => false,
 	          'Solr' => true,

 	          /*
 	           Se habilitada SqlServerFullTextSearch criar catálogo com os campos:
 	  indexacao_protocolo.idx_descricao
 	  indexacao_protocolo.idx_participante
 	  indexacao_protocolo.idx_assunto
 	  indexacao_protocolo.idx_unidade_acesso
 	  indexacao_protocolo.idx_unidade_aberto
 	  indexacao_protocolo.idx_assinante
 	  indexacao_protocolo.idx_observacao
 	  indexacao_protocolo.idx_conteudo
 	  indexacao_base_conhecimento.idx_conteudo
 	  indexacao_publicacao.idx_resumo
 	  indexacao_publicacao.idx_conteudo
 	  */
 	          'SqlServerFullTextSearch' => false),

 	      'Solr' => array(
 	          'Servidor' => 'http://'.getenv("SOLR_PORT_8983_TCP_ADDR").':'.getenv("SOLR_PORT_8983_TCP_PORT").'/solr',
 	          'CoreProtocolos' => 'sei-protocolos',
 	          'CoreBasesConhecimento' => 'sei-bases-conhecimento',
 	          'CorePublicacoes' => 'sei-publicacoes'),

 	      'HostWebService' => array(
 	          'Edoc' => array('[Servidor .NET]'),

 	          //Referências (IP e nome na rede) da máquina que hospeda o SIP
 	          'Sip' => array('*'),

 	          //Referências (IP e nome na rede) das máquinas de veículos de publicação externos cadastrados no SEI.
 	          'Publicacao' => array('*'), 

 	          //Referências (IP e nome na rede) da máquina que hospeda o formulário de Ouvidoria personalizado. 
 	          //Se utilizar o formulário padrão do SEI, então configurar com as máquinas dos nós de aplicação do SEI.
 	          'Ouvidoria' => array('*'), 
 	          ),
 	       
 	      'InfraMail' => array(
 	          'Tipo' => '1', //1 = sendmail (neste caso não é necessário configurar os atributos abaixo), 2 = SMTP
 	          'Servidor' => '[Servidor E-Mail]',
 	          'Porta' => '25',
 	          'Codificacao' => '8bit', //8bit, 7bit, binary, base64, quoted-printable
 	          'Autenticar' => false, //se true então informar Usuario e Senha
 	          'Usuario' => '',
 	          'Senha' => '',
 	          'Protegido' => ''),  //campo usado em desenvolvimento, se tiver um email preenchido entao todos os emails enviados terao o destinatario ignorado e substituído por este valor (evita envio incorreto de email) 	       
 	  );
 	}
}
?>

<?

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
 	          'URL' => 'http://[Servidor PHP]/sei',
 	          'Producao' => true,
 	          'RepositorioArquivos' => '/dados'),

 	      'PaginaSEI' => array(
 	          'NomeSistema' => 'SEI',
 	          'NomeSistemaComplemento' => '',
 	          'LogoMenu' => ''),
 	       
 	      'SessaoSEI' => array(
 	          'SiglaOrgaoSistema' => 'ABC',
 	          'SiglaSistema' => 'SEI',
 	          'PaginaLogin' => 'http://[Servidor PHP]/sip/login.php',
 	          'SipWsdl' => 'http://[Servidor PHP]/sip/controlador_ws.php?servico=wsdl',
 	          'https' => false),
 	       
 	      'BancoSEI'  => array(
 	          'Servidor' => '[servidor BD]',
 	          'Porta' => '',
 	          'Banco' => '',
 	          'Usuario' => '',
 	          'Senha' => '',
 	          'Tipo' => ''), //MySql, SqlServer ou Oracle

              'CacheSEI' => array(
                  'Servidor' => '[Servidor Memcache]',
	          'Porta' => '11211'),

 	      'JODConverter' => array('Servidor' => 'http://[Servidor JODConverter]:8080/converter/service'),

 	      'Edoc' => array('Servidor' => 'http://[Servidor .NET]'),
 	       
 	      'Solr' => array(
                  'Servidor' => 'http://'.getenv("SOLR_PORT_8983_TCP_ADDR").':'.getenv("SOLR_PORT_8983_TCP_PORT").'/solr',
                  'CoreProtocolos' => 'sei-protocolos',
                  'TempoCommitProtocolos' => 300,
                  'CoreBasesConhecimento' => 'sei-bases-conhecimento',
                  'TempoCommitBasesConhecimento' => 60,
                  'CorePublicacoes' => 'sei-publicacoes',
                  'TempoCommitPublicacoes' => 60),

	      'HostWebService' => array(
	          'Edoc' => array('[Servidor .NET]'),
		  'Sip' => array('[Servidor PHP]'), 
		  'Publicacao' => array(), 
		  'Ouvidoria' => array(),),
 	       
 	      'InfraMail' => array(
	   	  'Tipo' => '1', 
		  'Servidor' => '[Servidor E-Mail]',
		  'Porta' => '25',
		  'Codificacao' => '8bit', 
		  'MaxDestinatarios' => 999, 
		  'MaxTamAnexosMb' => 999, 
		  'Seguranca' => 'TLS', 
		  'Autenticar' => false, 
		  'Usuario' => 'aaa',
		  'Senha' => 'aaa',
		  'Protegido' => '')
 	  );
 	}
}
?>

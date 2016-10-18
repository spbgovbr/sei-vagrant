<?

class ConfiguracaoSip extends InfraConfiguracao  {

 	private static $instance = null;

 	public static function getInstance(){
 	  if (ConfiguracaoSip::$instance == null) {
 	    ConfiguracaoSip::$instance = new ConfiguracaoSip();
 	  }
 	  return ConfiguracaoSip::$instance;
 	}

 	public function getArrConfiguracoes(){
 	  return array(
 	      'Sip' => array(
 	          'URL' => 'http://[Servidor PHP]/sip',
 	          'Producao' => true),
 	       
 	      'PaginaSip' => array('NomeSistema' => 'SIP'),

 	      'SessaoSip' => array(
 	          'SiglaOrgaoSistema' => 'ABC',
 	          'SiglaSistema' => 'SIP',
 	          'PaginaLogin' => 'http://[Servidor PHP]/sip/login.php',
 	          'SipWsdl' => 'http://[Servidor PHP]/sip/controlador_ws.php?servico=wsdl',
 	          'https' => false),
 	       
 	      'BancoSip'  => array(
 	          'Servidor' => '[Servidor BD]',
 	          'Porta' => '',
 	          'Banco' => '',
 	          'Usuario' => '',
 	          'Senha' => '',
 	          'Tipo' => ''), //MySql, SqlServer ou Oracle

	      'CacheSip' => array(
                  'Servidor' => '[Servidor Memcache]',
                  'Porta' => '11211'),

 	      'HostWebService' => array(
 	          'Replicacao' => array(''),
 	          'Pesquisa' => array(''),
 	          'Autenticacao' => array('')),

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

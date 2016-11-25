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
 	          'URL' => 'http://localhost/sip',
 	          'Producao' => false),

 	      'PaginaSip' => array('NomeSistema' => 'SIP'),

 	      'SessaoSip' => array(
 	          'SiglaOrgaoSistema' => 'ABC',
 	          'SiglaSistema' => 'SIP',
 	          'PaginaLogin' => 'http://localhost/sip/login.php',
 	          'SipWsdl' => 'http://localhost/sip/controlador_ws.php?servico=wsdl',
 	          'https' => false),

 	       // CONFIGURAÇÃO PARA BASE DE DADOS MYSQL
 	      'BancoSip'  => array(
                  'Servidor' => getenv("MYSQL_PORT_3306_TCP_ADDR"),
                  'Porta' => getenv("MYSQL_PORT_3306_TCP_PORT"),
                  'Banco' => 'sip',
                  'Usuario' => 'sip_user',
                  'Senha' => 'sip_user',
                  'Tipo' => 'MySql'), //MySql ou SqlServer),

              // CONFIGURAÇÃO PARA BASE DE DADOS ORACLE
/*              'BancoSip'  => array(
                  'Servidor' => getenv("ORACLE_PORT_1521_TCP_ADDR"),
                  'Porta' => getenv("ORACLE_PORT_1521_TCP_PORT"),
                  'Banco' => 'sip',
                  'Usuario' => 'sip_user',
                  'Senha' => 'sip_user',
                  'Tipo' => 'Oracle'), //MySql ou SqlServer),
*/

	      'CacheSip' => array(
                  'Servidor' => getenv("MEMCACHED_PORT_11211_TCP_ADDR"),
                  'Porta' => getenv("MEMCACHED_PORT_11211_TCP_PORT")),

 	      'HostWebService' => array(
 	          'Replicacao' => array('*'),
 	          'Pesquisa' => array('*'),
 	          'Autenticacao' => array('*')),

 	      'InfraMail' => array(
                  'Tipo' => '2',
                  'Servidor' => getenv("SMTP_PORT_1025_TCP_ADDR"),
                  'Porta' => getenv("SMTP_PORT_1025_TCP_PORT"),
                  'Codificacao' => '8bit',
                  'MaxDestinatarios' => 999,
                  'MaxTamAnexosMb' => 999,
                  'Seguranca' => '',
                  'Autenticar' => false,
                  'Usuario' => '',
                  'Senha' => '',
                  'Protegido' => '')

 	  );
 	}
}
?>

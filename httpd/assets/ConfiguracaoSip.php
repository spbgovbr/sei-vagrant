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
	      // 'BancoSip'  => array(
       //            'Servidor' => 'mysql',
       //            'Porta' => 3306,
       //            'Banco' => 'sip',
       //            'Usuario' => 'sip_user',
       //            'Senha' => 'sip_user',
       //            'Tipo' => 'MySql'), //MySql ou SqlServer),

 
                  // CONFIGURAÇÃO PARA BANCO DE DADOS ORACLE
            // 'BancoSip'  => array(
            //       'Servidor' => 'oracle',
            //       'Porta' => 1521,
            //       'Banco' => 'sip',
            //       'Usuario' => 'sip',
            //       'Senha' => 'sip_user',
            //       'Tipo' => 'Oracle'), //MySql ou SqlServer

                  // CONFIGURAÇÃO PARA BANCO DE DADOS SQL SERVER
            'BancoSip'  => array(
                  'Servidor' => 'sqlserver',
                  'Porta' => 1433,
                  'Banco' => 'sip',
                  'Usuario' => 'sip_user',
                  'Senha' => 'sip_user',
                  'Tipo' => 'SqlServer'), //MySql ou SqlServer


	      'CacheSip' => array(
                  'Servidor' => 'memcached',
                  'Porta' => 11211),

 	      'HostWebService' => array(
 	          'Replicacao' => array('*'),
 	          'Pesquisa' => array('*'),
 	          'Autenticacao' => array('*')),

 	      'InfraMail' => array(
                  'Tipo' => '2',
                  'Servidor' => 'smtp',
                  'Porta' => 1025,
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

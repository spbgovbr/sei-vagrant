<?

require_once dirname(__FILE__).'/Sip.php';

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
 	      	  // Endereço de acesso à aplicação SEI
 	          'URL' => 'http://localhost/sip',

 	          // Habilita melhorias de performance casa aplicação esteja em produção
 	          'Producao' => false),
 	       
 	      'PaginaSip' => array(
 	          'NomeSistema' => 'SIP',
 	          'NomeSistemaComplemento' => 'v2.6.0'),

 	      'SessaoSip' => array(
 	          'SiglaOrgaoSistema' => 'ABC',
 	          'SiglaSistema' => 'SIP',
 	          'PaginaLogin' => 'http://localhost/sip/login.php',
 	          'SipWsdl' => 'http://localhost/sip/controlador_ws.php?servico=wsdl',
 	          'https' => false),
 	       
 	      'BancoSip'  => array(
 	          'Servidor' => getenv("DB_PORT_3306_TCP_ADDR"),
 	          'Porta' => getenv("DB_PORT_3306_TCP_PORT"),
 	          'Banco' => 'sip',
 	          'Usuario' => 'sip_user',
 	          'Senha' => 'sip_user',
 	          'Tipo' => 'MySql'), //MySql ou SqlServer),
 	       
 	      'HostWebService' => array(
 	          'Replicacao' => array('*'), //endereço ou IP da máquina que implementa o serviço de replicação de usuários
 	          'Pesquisa' => array('*'), //endereços/IPs das máquinas do SEI
 	          'Autenticacao' => array('*') //endereços/IPs das máquinas do SEI
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

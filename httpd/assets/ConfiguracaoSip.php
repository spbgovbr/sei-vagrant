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
				'URL' => getenv('HOST_URL').'/sip',
				'Producao' => false,
				'NumLoginSemCaptcha' => 3,
				'TempoLimiteValidacaoLogin' => 60,
				'Modulos' => array(
					//'ABCExemploIntegracao' => 'abc/exemplo',
				),				
			),
			
			'PaginaSip' => array(
				'NomeSistema' => 'SIP',
				'NomeSistemaComplemento' => '',				
			),
			
			'SessaoSip' => array(
				'SiglaOrgaoSistema' => 'ABC',
				'SiglaSistema' => 'SIP',
				'PaginaLogin' => getenv('SEI_HOST_URL').'/sip/login.php',
				'SipWsdl' => 'http://localhost:8080/sip/controlador_ws.php?servico=wsdl',
				'https' => false
			),
			
			'BancoSip'  => array(
				'Servidor' => getenv('DATABASE_HOST'),
				'Porta' => getenv('DATABASE_PORT'),
				'Banco' => getenv('SIP_DATABASE_NAME'),
				'Usuario' => getenv('SIP_DATABASE_USER'),
				'Senha' => getenv('SIP_DATABASE_PASSWORD'),
				'UsuarioScript' => getenv('SIP_DATABASE_USER_SCRIPT'),
				'SenhaScript' => getenv('SIP_DATABASE_PASSWORD_SCRIPT'),
				'Tipo' => getenv('DATABASE_TYPE'), //MySql, SqlServer ou Oracle
				'PesquisaCaseInsensitive' => false,				
			), 	
			
			'BancoAuditoriaSip'  => array(
				'Servidor' => 'mysql',
				'Porta' => '3306',
				'Banco' => 'sip',
				'Usuario' => 'sip_user',
				'Senha' => 'sip_user',
				'Tipo' => 'MySql', //MySql, SqlServer ou Oracle
			),
			
			'CacheSip' => array(
				'Servidor' => 'memcached',			
				'Porta' => '11211',
				'Timeout' => 2,
				'Tempo' => 3600,				
			),
			
			'HostWebService' => array(
				'Replicacao' => array('*'),  //endereÁo ou IP da m·quina que implementa o serviÁo de replicaÁ„o de usu·rios
				'Pesquisa' => array('*'),    //endereÁos/IPs das m·quinas do SEI
				'Autenticacao' => array('*') //endereÁos/IPs das m·quinas do SEI
			), 
				
				'InfraMail' => array(
					'Tipo' => '2', //1 = sendmail (neste caso n„o È necess·rio configurar os atributos abaixo), 2 = SMTP
					'Servidor' => 'smtp',
					'Porta' => '1025',
					'Codificacao' => '8bit', //8bit, 7bit, binary, base64, quoted-printable
					'MaxDestinatarios' => 999, //numero maximo de destinatarios por mensagem
					'MaxTamAnexosMb' => 999, //tamanho maximo dos anexos em Mb por mensagem
					'Seguranca' => '', //TLS, SSL ou vazio
					'Autenticar' => false, //se true ent„o informar Usuario e Senha
					'Usuario' => '',
					'Senha' => '',
					'Protegido' => 'desenv@instituicao.gov.br' //campo usado em desenvolvimento, se tiver um email preenchido entao todos os emails enviados terao o destinatario ignorado e substitu√≠do por este valor (evita envio incorreto de email)
					)
				);
			}
		}
		
		
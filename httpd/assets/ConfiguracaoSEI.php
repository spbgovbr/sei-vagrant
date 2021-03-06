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
				'URL' => getenv('HOST_URL').'/sei',
				'Producao' => false,
				'RepositorioArquivos' => '/var/sei/arquivos',
				
				'DigitosDocumento' => 7,
				'NumLoginUsuarioExternoSemCaptcha' => 3,
				'TamSenhaUsuarioExterno' => 8,
				'DebugWebServices' => 2,
				'MaxMemoriaPdfGb' => 4,
				'Modulos' => array(
					// 'ABCExemploIntegracao' => 'abc/exemplo',
				),			   
			),
			
			'SessaoSEI' => array(
				'SiglaOrgaoSistema' => 'ABC',
				'SiglaSistema' => 'SEI',
				'PaginaLogin' => getenv('HOST_URL') . '/sip/login.php',
				'SipWsdl' => getenv('HOST_URL') . '/sip/controlador_ws.php?servico=wsdl',
				'https' => false
			),
			
			'PaginaSEI' => array(
				'NomeSistema' => 'SEI',
				'NomeSistemaComplemento' => SEI_VERSAO,
				'LogoMenu' => '', 
				'OrgaoTopoJanela' => 'S',
			),
			
			'BancoSEI'  => array(
				'Servidor' => getenv('DATABASE_HOST'),
				'Porta' => getenv('DATABASE_PORT'),
				'Banco' => getenv('SEI_DATABASE_NAME'),
				'Usuario' => getenv('SEI_DATABASE_USER'),
				'Senha' => getenv('SEI_DATABASE_PASSWORD'),
				'UsuarioScript' => getenv('SEI_DATABASE_USER_SCRIPT'),
				'SenhaScript' => getenv('SEI_DATABASE_PASSWORD_SCRIPT'),
				'Tipo' => getenv('DATABASE_TYPE'), //MySql, SqlServer ou Oracle
				'PesquisaCaseInsensitive' => false,
			),
			
			'BancoAuditoriaSEI'  => array(
				'Servidor' => 'mysql',
				'Porta' => '3306',
				'Banco' => 'sei',
				'Usuario' => 'sei_user',
				'Senha' => 'sei_user',
				'Tipo' => 'MySql', //MySql, SqlServer ou Oracle
			),				
			
			'CacheSEI' => array(
				'Servidor' => 'memcached',
				'Porta' => '11211',
				'Timeout' => 2,
				'Tempo' => 3600,					
			),
			
			'Solr' => array(
				'Servidor' => 'http://solr:8983/solr',
				'CoreProtocolos' => 'sei-protocolos',
				'CoreBasesConhecimento' => 'sei-bases-conhecimento',
				'CorePublicacoes' => 'sei-publicacoes',
				'TempoCommitProtocolos' => 300,
				'TempoCommitBasesConhecimento' => 60,
				'TempoCommitPublicacoes' => 60,					
			),				
			
			'JODConverter' => array(
				'Servidor' => 'http://jod/converter/service'
			),
			
			'HostWebService' => array(
				'Sip' => array('*'), //Refer�ncias (IP e nome na rede) de todas as m�quinas que executam o SIP.
				'Publicacao' => array('*'), //Refer�ncias (IP e nome na rede) das m�quinas de ve�culos de publica��o externos cadastrados no SEI.
				'Ouvidoria' => array('*'), //Refer�ncias (IP e nome na rede) da m�quina que hospeda o formul�rio de Ouvidoria personalizado. Se utilizar o formul�rio padr�o do SEI, ent�o configurar com as m�quinas dos nós de aplica��o do SEI.
			),
			
			'InfraMail' => array(
				'Tipo' => '2', //1 = sendmail (neste caso n�o � necess�rio configurar os atributos abaixo), 2 = SMTP
				'Servidor' => 'smtp',
				'Porta' => '1025',
				'Codificacao' => '8bit', //8bit, 7bit, binary, base64, quoted-printable
				'MaxDestinatarios' => 999, //numero maximo de destinatarios por mensagem
				'MaxTamAnexosMb' => 999, //tamanho maximo dos anexos em Mb por mensagem
				'Autenticar' => false, //se true ent�o informar Usuario e Senha
				'Usuario' => '',
				'Senha' => '',
				'Seguranca' => '', //TLS, SSL ou vazio
				'Protegido' => 'desenv@instituicao.gov.br', //campo usado em desenvolvimento, se tiver um email preenchido entao todos os emails enviados terao o destinatario ignorado e substitu�do por este valor (evita envio incorreto de email)
				// 'Dominios' => array(	// Opcional. Permite especificar o conjunto de atributos acima individualmente para cada dom�nio de conta remetente. Se n�o existir um dom�nio mapeado ent�o utilizar� os atributos gerais da chave InfraMail acima.
				// 	'abc.jus.br' => array(
				// 		'Tipo' => '2',
				// 		'Servidor' => '10.1.3.12',
				// 		'Porta' => '25',
				// 		'Codificacao' => '8bit',
				// 		'MaxDestinatarios' => 25,
				// 		'MaxTamAnexosMb' => 15,
				// 		'Seguranca' => 'TLS',
				// 		'Autenticar' => false,
				// 		'Usuario' => '',
				// 		'Senha' => '',
				// 		'Protegido' => '',
				// 	),
				// ),
			),
		);
	}
}


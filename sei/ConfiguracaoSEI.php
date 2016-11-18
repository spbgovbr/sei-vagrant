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
        'URL' => 'http://localhost/sei',
        'Producao' => false,
        'RepositorioArquivos' => '/var/sei/arquivos'),

      'PaginaSEI' => array(
        'NomeSistema' => 'SEI',
        'NomeSistemaComplemento' => SEI_VERSAO,
        'LogoMenu' => ''),

      'SessaoSEI' => array(
        'SiglaOrgaoSistema' => 'ABC',
        'SiglaSistema' => 'SEI',
        'PaginaLogin' => 'http://localhost/sip/login.php',
        'SipWsdl' => 'http://localhost/sip/controlador_ws.php?servico=wsdl',
        'https' => false),

      // CONFIGURAÇÃO PARA BANCO DE DADOS ORACLE
      'BancoSEI'  => array(
        'Servidor' => getenv("MYSQL_PORT_3306_TCP_ADDR"),
        'Porta' => getenv("MYSQL_PORT_3306_TCP_PORT"),
        'Banco' => 'sei',
        'Usuario' => 'sei_user',
        'Senha' => 'sei_user',
        'Tipo' => 'MySql'), //MySql ou SqlServer

        // CONFIGURAÇÃO PARA BANCO DE DADOS ORACLE
        /*      'BancoSEI'  => array(
        'Servidor' => getenv("ORACLE_PORT_1521_TCP_ADDR"),
        'Porta' => getenv("ORACLE_PORT_1521_TCP_PORT"),
        'Banco' => 'sei',
        'Usuario' => 'sei_user',
        'Senha' => 'sei_user',
        'Tipo' => 'Oracle'), //MySql ou SqlServer
        */

        'CacheSEI' => array(
          'Servidor' => getenv("MEMCACHED_PORT_11211_TCP_ADDR"),
          'Porta' => getenv("MEMCACHED_PORT_11211_TCP_PORT")),

        'JODConverter' => array('Servidor' => 'http://'.getenv("JOD_PORT_8080_TCP_ADDR").':'.getenv("JOD_PORT_8080_TCP_PORT").'/converter/service'),

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
          'Edoc' => array('*'),
          'Sip' => array('*'),
          'Publicacao' => array('*'),
          'Ouvidoria' => array('*'),),

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

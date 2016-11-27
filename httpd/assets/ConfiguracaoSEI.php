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
      // 'BancoSEI'  => array(
      //   'Servidor' => 'mysql',
      //   'Porta' => 3306,
      //   'Banco' => 'sei',
      //   'Usuario' => 'sei_user',
      //   'Senha' => 'sei_user',
      //   'Tipo' => 'MySql'), //MySql ou SqlServer

        // CONFIGURAÇÃO PARA BANCO DE DADOS ORACLE
      // 'BancoSEI'  => array(
      //   'Servidor' => 'oracle',
      //   'Porta' => 1521,
      //   'Banco' => 'sei',
      //   'Usuario' => 'sei',
      //   'Senha' => 'sei_user',
      //   'Tipo' => 'Oracle'), //MySql ou SqlServer

      // CONFIGURAÇÃO PARA BANCO DE DADOS SQL SERVER
      'BancoSEI'  => array(
        'Servidor' => 'sqlserver',
        'Porta' => 1433,
        'Banco' => 'sei',
        'Usuario' => 'sei_user',
        'Senha' => 'yourStrong(!)Password',
        'Tipo' => 'SqlServer'), //MySql ou SqlServer

        'CacheSEI' => array(
          'Servidor' => 'memcached',
          'Porta' => 11211),

        'JODConverter' => array('Servidor' => 'http://jod:8080/converter/service'),

        'Edoc' => array('Servidor' => 'http://[Servidor .NET]'),

        'Solr' => array(
          'Servidor' => 'http://solr:8983/solr',
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

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Ubuntu 14.5-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.5 (Ubuntu 14.5-0ubuntu0.22.04.1)
\c sip;
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: administrador_sistema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrador_sistema (
    id_usuario integer NOT NULL,
    id_sistema integer NOT NULL
);


ALTER TABLE public.administrador_sistema OWNER TO sip_user;

--
-- Name: codigo_acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.codigo_acesso (
    id_codigo_acesso character varying(26) NOT NULL,
    id_usuario integer NOT NULL,
    id_usuario_desativacao integer,
    id_sistema integer NOT NULL,
    chave_geracao character varying(32) NOT NULL,
    dth_geracao timestamp without time zone NOT NULL,
    chave_ativacao character varying(60),
    dth_envio_ativacao timestamp without time zone,
    dth_ativacao timestamp without time zone,
    chave_desativacao character varying(60),
    dth_envio_desativacao timestamp without time zone,
    dth_desativacao timestamp without time zone,
    dth_acesso timestamp without time zone,
    email character varying(100),
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.codigo_acesso OWNER TO sip_user;

--
-- Name: codigo_bloqueio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.codigo_bloqueio (
    id_codigo_bloqueio character varying(26) NOT NULL,
    id_codigo_acesso character varying(26) NOT NULL,
    chave_bloqueio character varying(60) NOT NULL,
    dth_envio timestamp without time zone NOT NULL,
    dth_bloqueio timestamp without time zone,
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.codigo_bloqueio OWNER TO sip_user;

--
-- Name: coordenador_perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coordenador_perfil (
    id_perfil integer NOT NULL,
    id_usuario integer NOT NULL,
    id_sistema integer NOT NULL
);


ALTER TABLE public.coordenador_perfil OWNER TO sip_user;

--
-- Name: coordenador_unidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coordenador_unidade (
    id_sistema integer NOT NULL,
    id_usuario integer NOT NULL,
    id_unidade integer NOT NULL
);


ALTER TABLE public.coordenador_unidade OWNER TO sip_user;

--
-- Name: dispositivo_acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dispositivo_acesso (
    id_dispositivo_acesso character varying(26) NOT NULL,
    id_codigo_acesso character varying(26) NOT NULL,
    chave_dispositivo character varying(60) NOT NULL,
    chave_acesso character varying(60),
    dth_liberacao timestamp without time zone,
    user_agent character varying(500) NOT NULL,
    dth_acesso timestamp without time zone NOT NULL,
    ip_acesso character varying(39) NOT NULL,
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.dispositivo_acesso OWNER TO sip_user;

--
-- Name: email_sistema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_sistema (
    id_email_sistema integer NOT NULL,
    id_email_sistema_modulo character varying(50),
    de character varying(250) NOT NULL,
    para character varying(250) NOT NULL,
    assunto character varying(250) NOT NULL,
    conteudo text NOT NULL,
    descricao character varying(250) NOT NULL,
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.email_sistema OWNER TO sip_user;

--
-- Name: hierarquia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hierarquia (
    id_hierarquia integer NOT NULL,
    nome character varying(50) NOT NULL,
    descricao character varying(200),
    dta_inicio timestamp without time zone NOT NULL,
    dta_fim timestamp without time zone,
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.hierarquia OWNER TO sip_user;

--
-- Name: infra_agendamento_tarefa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infra_agendamento_tarefa (
    id_infra_agendamento_tarefa integer NOT NULL,
    descricao character varying(500) NOT NULL,
    comando character varying(255) NOT NULL,
    sta_periodicidade_execucao character(1) NOT NULL,
    periodicidade_complemento character varying(200),
    dth_ultima_execucao timestamp without time zone,
    dth_ultima_conclusao timestamp without time zone,
    sin_sucesso character(1) NOT NULL,
    parametro character varying(250),
    email_erro character varying(250),
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.infra_agendamento_tarefa OWNER TO sip_user;

--
-- Name: infra_auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infra_auditoria (
    id_infra_auditoria bigint NOT NULL,
    id_usuario integer,
    id_orgao_usuario integer,
    id_usuario_emulador integer,
    id_orgao_usuario_emulador integer,
    id_unidade integer,
    id_orgao_unidade integer,
    recurso character varying(50) NOT NULL,
    dth_acesso timestamp without time zone NOT NULL,
    ip character varying(39),
    sigla_usuario character varying(100),
    nome_usuario character varying(100),
    sigla_orgao_usuario character varying(30),
    sigla_usuario_emulador character varying(100),
    nome_usuario_emulador character varying(100),
    sigla_orgao_usuario_emulador character varying(30),
    sigla_unidade character varying(30),
    descricao_unidade character varying(250),
    sigla_orgao_unidade character varying(30),
    servidor character varying(250),
    user_agent text,
    requisicao text,
    operacao text
);


ALTER TABLE public.infra_auditoria OWNER TO sip_user;

--
-- Name: infra_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infra_log (
    id_infra_log bigint NOT NULL,
    dth_log timestamp without time zone,
    texto_log text NOT NULL,
    ip character varying(39),
    sta_tipo character(1) NOT NULL
);


ALTER TABLE public.infra_log OWNER TO sip_user;

--
-- Name: infra_parametro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infra_parametro (
    nome character varying(50) NOT NULL,
    valor character varying(1024)
);


ALTER TABLE public.infra_parametro OWNER TO sip_user;

--
-- Name: infra_regra_auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infra_regra_auditoria (
    id_infra_regra_auditoria integer NOT NULL,
    descricao character varying(250) NOT NULL,
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.infra_regra_auditoria OWNER TO sip_user;

--
-- Name: infra_regra_auditoria_recurso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infra_regra_auditoria_recurso (
    id_infra_regra_auditoria integer NOT NULL,
    recurso character varying(50) NOT NULL
);


ALTER TABLE public.infra_regra_auditoria_recurso OWNER TO sip_user;

--
-- Name: infra_sequencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infra_sequencia (
    nome_tabela character varying(30) NOT NULL,
    qtd_incremento integer NOT NULL,
    num_atual integer NOT NULL,
    num_maximo integer NOT NULL
);


ALTER TABLE public.infra_sequencia OWNER TO sip_user;

--
-- Name: item_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_menu (
    id_menu integer NOT NULL,
    id_item_menu integer NOT NULL,
    id_sistema integer,
    id_menu_pai integer,
    id_item_menu_pai integer,
    id_recurso integer,
    rotulo character varying(50) NOT NULL,
    descricao character varying(200),
    sequencia integer NOT NULL,
    sin_ativo character(1) NOT NULL,
    sin_nova_janela character(1) NOT NULL,
    icone character varying(250)
);


ALTER TABLE public.item_menu OWNER TO sip_user;

--
-- Name: login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login (
    id_login character(128) NOT NULL,
    id_sistema integer NOT NULL,
    id_usuario integer NOT NULL,
    id_usuario_emulador integer,
    dth_login timestamp without time zone NOT NULL,
    hash_interno character(128) NOT NULL,
    hash_usuario character(128) NOT NULL,
    hash_agente character(128) NOT NULL,
    http_client_ip character varying(39),
    remote_addr character varying(39),
    http_x_forwarded_for character varying(39),
    sta_login character(1) NOT NULL,
    user_agent character varying(500) NOT NULL,
    id_dispositivo_acesso character varying(26),
    id_codigo_acesso character varying(26)
);


ALTER TABLE public.login OWNER TO sip_user;

--
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    id_menu integer NOT NULL,
    id_sistema integer NOT NULL,
    nome character varying(50) NOT NULL,
    descricao character varying(200),
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.menu OWNER TO sip_user;

--
-- Name: orgao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orgao (
    id_orgao integer NOT NULL,
    sigla character varying(30) NOT NULL,
    descricao character varying(250) NOT NULL,
    sin_ativo character(1) NOT NULL,
    sin_autenticar character(1) NOT NULL,
    ordem integer NOT NULL
);


ALTER TABLE public.orgao OWNER TO sip_user;

--
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil (
    id_perfil integer NOT NULL,
    id_sistema integer NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text,
    sin_coordenado character(1) NOT NULL,
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.perfil OWNER TO sip_user;

--
-- Name: permissao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissao (
    id_perfil integer NOT NULL,
    id_sistema integer NOT NULL,
    id_usuario integer NOT NULL,
    id_unidade integer NOT NULL,
    id_tipo_permissao integer NOT NULL,
    dta_inicio timestamp without time zone NOT NULL,
    dta_fim timestamp without time zone,
    sin_subunidades character(1) NOT NULL
);


ALTER TABLE public.permissao OWNER TO sip_user;

--
-- Name: recurso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recurso (
    id_sistema integer NOT NULL,
    id_recurso integer NOT NULL,
    nome character varying(50) NOT NULL,
    descricao character varying(200),
    caminho character varying(255) NOT NULL,
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.recurso OWNER TO sip_user;

--
-- Name: recurso_vinculado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recurso_vinculado (
    id_sistema integer NOT NULL,
    id_recurso integer NOT NULL,
    id_sistema_vinculado integer NOT NULL,
    id_recurso_vinculado integer NOT NULL,
    tipo_vinculo integer NOT NULL
);


ALTER TABLE public.recurso_vinculado OWNER TO sip_user;

--
-- Name: regra_auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regra_auditoria (
    id_regra_auditoria integer NOT NULL,
    id_sistema integer NOT NULL,
    descricao character varying(250) NOT NULL,
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.regra_auditoria OWNER TO sip_user;

--
-- Name: rel_hierarquia_unidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rel_hierarquia_unidade (
    id_unidade integer NOT NULL,
    id_hierarquia integer NOT NULL,
    id_hierarquia_pai integer,
    id_unidade_pai integer,
    dta_inicio timestamp without time zone NOT NULL,
    dta_fim timestamp without time zone,
    sin_ativo character(1) NOT NULL
);


ALTER TABLE public.rel_hierarquia_unidade OWNER TO sip_user;

--
-- Name: rel_orgao_autenticacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rel_orgao_autenticacao (
    id_orgao integer NOT NULL,
    id_servidor_autenticacao integer NOT NULL,
    sequencia integer NOT NULL
);


ALTER TABLE public.rel_orgao_autenticacao OWNER TO sip_user;

--
-- Name: rel_perfil_item_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rel_perfil_item_menu (
    id_perfil integer NOT NULL,
    id_sistema integer NOT NULL,
    id_menu integer NOT NULL,
    id_item_menu integer NOT NULL,
    id_recurso integer NOT NULL
);


ALTER TABLE public.rel_perfil_item_menu OWNER TO sip_user;

--
-- Name: rel_perfil_recurso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rel_perfil_recurso (
    id_perfil integer NOT NULL,
    id_sistema integer NOT NULL,
    id_recurso integer NOT NULL
);


ALTER TABLE public.rel_perfil_recurso OWNER TO sip_user;

--
-- Name: rel_regra_auditoria_recurso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rel_regra_auditoria_recurso (
    id_recurso integer NOT NULL,
    id_sistema integer NOT NULL,
    id_regra_auditoria integer NOT NULL
);


ALTER TABLE public.rel_regra_auditoria_recurso OWNER TO sip_user;

--
-- Name: seq_infra_auditoria; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_infra_auditoria
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_infra_auditoria OWNER TO sip_user;

--
-- Name: seq_infra_log; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_infra_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_infra_log OWNER TO sip_user;

--
-- Name: seq_usuario_historico; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_usuario_historico
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario_historico OWNER TO sip_user;

--
-- Name: servidor_autenticacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servidor_autenticacao (
    id_servidor_autenticacao integer NOT NULL,
    nome character varying(50) NOT NULL,
    sta_tipo character varying(10) NOT NULL,
    endereco character varying(100) NOT NULL,
    porta integer NOT NULL,
    sufixo character varying(50),
    usuario_pesquisa character varying(100),
    senha_pesquisa character varying(100),
    contexto_pesquisa character varying(100),
    atributo_filtro_pesquisa character varying(100),
    atributo_retorno_pesquisa character varying(100),
    versao integer NOT NULL
);


ALTER TABLE public.servidor_autenticacao OWNER TO sip_user;

--
-- Name: sistema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sistema (
    id_sistema integer NOT NULL,
    id_orgao integer NOT NULL,
    id_hierarquia integer NOT NULL,
    sigla character varying(15) NOT NULL,
    descricao character varying(200),
    pagina_inicial character varying(255),
    sin_ativo character(1) NOT NULL,
    web_service character varying(255),
    logo text,
    sta_2_fatores character(1) NOT NULL,
    esquema_login character varying(50),
    servicos_liberados character varying(200),
    chave_acesso character varying(60),
    crc character(8)
);


ALTER TABLE public.sistema OWNER TO sip_user;

--
-- Name: tipo_permissao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_permissao (
    id_tipo_permissao integer NOT NULL,
    descricao character varying(50) NOT NULL
);


ALTER TABLE public.tipo_permissao OWNER TO sip_user;

--
-- Name: unidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unidade (
    id_unidade integer NOT NULL,
    id_orgao integer NOT NULL,
    id_origem character varying(50),
    sigla character varying(30) NOT NULL,
    descricao character varying(250) NOT NULL,
    sin_ativo character(1) NOT NULL,
    sin_global character(1) NOT NULL
);


ALTER TABLE public.unidade OWNER TO sip_user;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    id_orgao integer NOT NULL,
    id_origem character varying(50),
    sigla character varying(100) NOT NULL,
    nome character varying(100) NOT NULL,
    sin_ativo character(1) NOT NULL,
    cpf bigint,
    nome_registro_civil character varying(100) NOT NULL,
    nome_social character varying(100),
    email character varying(100),
    sin_bloqueado character(1) NOT NULL
);


ALTER TABLE public.usuario OWNER TO sip_user;

--
-- Name: usuario_historico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_historico (
    id_usuario_historico integer NOT NULL,
    id_codigo_acesso character varying(26),
    id_usuario integer NOT NULL,
    id_usuario_operacao integer NOT NULL,
    dth_operacao timestamp without time zone NOT NULL,
    sta_operacao character(1) NOT NULL,
    motivo character varying(4000)
);


ALTER TABLE public.usuario_historico OWNER TO sip_user;

--
-- Data for Name: administrador_sistema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.administrador_sistema (id_usuario, id_sistema) FROM stdin;
100000001	100000099
100000001	100000100
\.


--
-- Data for Name: codigo_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.codigo_acesso (id_codigo_acesso, id_usuario, id_usuario_desativacao, id_sistema, chave_geracao, dth_geracao, chave_ativacao, dth_envio_ativacao, dth_ativacao, chave_desativacao, dth_envio_desativacao, dth_desativacao, dth_acesso, email, sin_ativo) FROM stdin;
\.


--
-- Data for Name: codigo_bloqueio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.codigo_bloqueio (id_codigo_bloqueio, id_codigo_acesso, chave_bloqueio, dth_envio, dth_bloqueio, sin_ativo) FROM stdin;
\.


--
-- Data for Name: coordenador_perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coordenador_perfil (id_perfil, id_usuario, id_sistema) FROM stdin;
\.


--
-- Data for Name: coordenador_unidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coordenador_unidade (id_sistema, id_usuario, id_unidade) FROM stdin;
\.


--
-- Data for Name: dispositivo_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dispositivo_acesso (id_dispositivo_acesso, id_codigo_acesso, chave_dispositivo, chave_acesso, dth_liberacao, user_agent, dth_acesso, ip_acesso, sin_ativo) FROM stdin;
\.


--
-- Data for Name: email_sistema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_sistema (id_email_sistema, id_email_sistema_modulo, de, para, assunto, conteudo, descricao, sin_ativo) FROM stdin;
1	\N	@sigla_sistema@/@sigla_orgao_sistema@ <@email_sistema@>	@nome_usuario@ <@email_usuario@>	Ativação da Autenticação em 2 Fatores	A autenticação em 2 fatores foi solicitada para sua conta no sistema @sigla_sistema@/@sigla_orgao_sistema@ em @data@ às @hora@.\n\nClique no link abaixo para ativá-la:\n\n@endereco_ativacao@	Ativação da Autenticação em 2 Fatores	S
2	\N	@sigla_sistema@/@sigla_orgao_sistema@ <@email_sistema@>	@nome_usuario@ <@email_usuario@>	Desativação da Autenticação em 2 Fatores	A desativação da autenticação em 2 fatores foi solicitada para sua conta no sistema @sigla_sistema@/@sigla_orgao_sistema@ em @data@ às @hora@.\n\nClique no link abaixo para desativá-la:\n\n@endereco_desativacao@	Desativação da Autenticação em 2 Fatores	S
3	\N	@sigla_sistema@/@sigla_orgao_sistema@ <@email_sistema@>	@email_usuario@	Alerta de Segurança	Sua conta no sistema @sigla_sistema@/@sigla_orgao_sistema@ foi acessada a partir de um novo dispositivo em @data@ às @hora@.\n\nSe você não reconhece esta atividade altere imediatamente a sua senha ou clique no link abaixo para bloquear sua conta no sistema:\n\n@endereco_bloqueio@	Alerta de segurança sobre acesso em outro dispositivo	S
4	\N	@sigla_sistema@/@sigla_orgao_sistema@ <@email_sistema@>	@email_usuario@	Aviso de Bloqueio	Sua conta no sistema @sigla_sistema@/@sigla_orgao_sistema@ foi bloqueada em @data@ às @hora@.	Bloqueio do usuário por link em e-mail de alerta de segurança	S
\.


--
-- Data for Name: hierarquia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hierarquia (id_hierarquia, nome, descricao, dta_inicio, dta_fim, sin_ativo) FROM stdin;
100000018	SEI	Unidades Organizacionais	2014-01-06 00:00:00	\N	S
\.


--
-- Data for Name: infra_agendamento_tarefa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infra_agendamento_tarefa (id_infra_agendamento_tarefa, descricao, comando, sta_periodicidade_execucao, periodicidade_complemento, dth_ultima_execucao, dth_ultima_conclusao, sin_sucesso, parametro, email_erro, sin_ativo) FROM stdin;
1	Remover dados temporários de login	AgendamentoRN::removerDadosLogin	D	1	2014-11-14 08:05:06	2014-11-14 08:05:06	S	\N	\N	S
2	Teste de agendamento SIP	AgendamentoRN::testarAgendamento	N	0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55	2014-11-14 08:05:03	2014-11-14 08:05:04	S	\N	\N	S
3	Replicar todos os usuários para o SEI	AgendamentoRN::replicarTodosUsuariosSEI	D	6	\N	\N	N	\N	\N	N
4	Replicar todas as unidades da hierarquia para o SEI	AgendamentoRN::replicarUnidadesHierarquiaSEI	D	5	\N	\N	N	\N	\N	N
5	Replica regras de auditoria para o SEI.	AgendamentoRN::replicarRegrasAuditoriaSEI	D	7	\N	\N	N	\N	\N	S
\.


--
-- Data for Name: infra_auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infra_auditoria (id_infra_auditoria, id_usuario, id_orgao_usuario, id_usuario_emulador, id_orgao_usuario_emulador, id_unidade, id_orgao_unidade, recurso, dth_acesso, ip, sigla_usuario, nome_usuario, sigla_orgao_usuario, sigla_usuario_emulador, nome_usuario_emulador, sigla_orgao_usuario_emulador, sigla_unidade, descricao_unidade, sigla_orgao_unidade, servidor, user_agent, requisicao, operacao) FROM stdin;
\.


--
-- Data for Name: infra_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infra_log (id_infra_log, dth_log, texto_log, ip, sta_tipo) FROM stdin;
\.


--
-- Data for Name: infra_parametro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infra_parametro (nome, valor) FROM stdin;
EMAIL_ADMINISTRADOR	teste@dominio.gov.br
EMAIL_SISTEMA	naoresponda@dominio.gov.br
ID_PERFIL_SIP_ADMINISTRADOR_SIP	100000931
ID_PERFIL_SIP_ADMINISTRADOR_SISTEMA	100000933
ID_PERFIL_SIP_BASICO	100000932
ID_PERFIL_SIP_COORDENADOR_PERFIL	100000936
ID_PERFIL_SIP_COORDENADOR_UNIDADE	100000946
ID_SISTEMA_SEI	100000100
ID_SISTEMA_SIP	100000099
ID_USUARIO_SIP	1
SEI_VERSAO	4.0.0.1
SIP_2_FATORES_SUFIXOS_EMAIL_NAO_PERMTIDOS	.jus.br, .gov.br
SIP_2_FATORES_TEMPO_DIAS_LINK_BLOQUEIO	10
SIP_2_FATORES_TEMPO_DIAS_VALIDADE_DISPOSITIVO	45
SIP_2_FATORES_TEMPO_MINUTOS_LINK_HABILITACAO	60
SIP_EMAIL_SISTEMA	naoresponda@dominio.gov.br
SIP_MSG_USUARIO_BLOQUEADO	Usuário bloqueado.
SIP_NUM_HISTORICO_ULTIMOS_ACESSOS	10
SIP_TEMPO_DIAS_HISTORICO_ACESSOS	90
SIP_VERSAO	3.0.0.1
\.


--
-- Data for Name: infra_regra_auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infra_regra_auditoria (id_infra_regra_auditoria, descricao, sin_ativo) FROM stdin;
1	Geral	S
\.


--
-- Data for Name: infra_regra_auditoria_recurso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infra_regra_auditoria_recurso (id_infra_regra_auditoria, recurso) FROM stdin;
1	administrador_sistema_cadastrar
1	administrador_sistema_excluir
1	codigo_acesso_desativar
1	codigo_acesso_excluir
1	codigo_acesso_reativar
1	coordenador_perfil_cadastrar
1	coordenador_perfil_excluir
1	coordenador_unidade_cadastrar
1	coordenador_unidade_excluir
1	hierarquia_alterar
1	hierarquia_cadastrar
1	hierarquia_clonar
1	hierarquia_desativar
1	hierarquia_excluir
1	infra_auditoria_listar
1	item_menu_alterar
1	item_menu_cadastrar
1	item_menu_desativar
1	item_menu_excluir
1	login_padrao
1	login_remover
1	login_unificado
1	menu_alterar
1	menu_cadastrar
1	menu_desativar
1	menu_excluir
1	orgao_alterar
1	orgao_cadastrar
1	orgao_desativar
1	orgao_excluir
1	perfil_alterar
1	perfil_cadastrar
1	perfil_clonar
1	perfil_desativar
1	perfil_excluir
1	perfil_montar
1	permissao_alterar
1	permissao_atribuir_em_bloco
1	permissao_cadastrar
1	permissao_copiar
1	permissao_delegar
1	permissao_excluir
1	recurso_alterar
1	recurso_cadastrar
1	recurso_desativar
1	recurso_excluir
1	recurso_gerar
1	recurso_reativar
1	regra_auditoria_alterar
1	regra_auditoria_cadastrar
1	regra_auditoria_desativar
1	regra_auditoria_excluir
1	regra_auditoria_reativar
1	rel_hierarquia_unidade_alterar
1	rel_hierarquia_unidade_cadastrar
1	rel_hierarquia_unidade_desativar
1	rel_hierarquia_unidade_excluir
1	rel_hierarquia_unidade_reativar
1	servidor_autenticacao_alterar
1	servidor_autenticacao_cadastrar
1	servidor_autenticacao_excluir
1	sistema_alterar
1	sistema_cadastrar
1	sistema_clonar
1	sistema_desativar
1	sistema_excluir
1	sistema_gerar_chave_acesso
1	sistema_importar
1	tipo_permissao_alterar
1	tipo_permissao_cadastrar
1	tipo_permissao_excluir
1	unidade_alterar
1	unidade_cadastrar
1	unidade_desativar
1	unidade_excluir
1	unidade_reativar
1	usuario_alterar
1	usuario_cadastrar
1	usuario_desativar
1	usuario_excluir
1	usuario_reativar
\.


--
-- Data for Name: infra_sequencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infra_sequencia (nome_tabela, qtd_incremento, num_atual, num_maximo) FROM stdin;
contexto	1	71	999999999
grupo_rede	1	360	999999999
hierarquia	1	100000018	199999999
infra_agendamento_tarefa	1	5	999999999
item_menu	1	100005695	199999999
menu	1	100000079	199999999
orgao	1	0	999999999
perfil	1	100000949	199999999
recurso	1	100015806	199999999
regra_auditoria	1	5	999999999
servidor_autenticacao	1	2	999999999
sistema	1	100000100	199999999
tipo_permissao	1	3	999999999
unidade	1	110000003	199999999
usuario	1	100000001	199999999
\.


--
-- Data for Name: item_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_menu (id_menu, id_item_menu, id_sistema, id_menu_pai, id_item_menu_pai, id_recurso, rotulo, descricao, sequencia, sin_ativo, sin_nova_janela, icone) FROM stdin;
100000078	100005399	100000099	\N	\N	\N	Menus	Menus	0	S	N	menu.svg
100000078	100005400	100000099	\N	\N	\N	Infra	\N	999	S	N	infra.svg
100000078	100005401	100000099	\N	\N	\N	Órgãos	Órgãos	0	S	N	orgao.svg
100000078	100005402	100000099	\N	\N	\N	Perfis	Perfis	0	S	N	perfil.svg
100000078	100005403	100000099	\N	\N	\N	Sistemas	Sistemas	0	S	N	sistema.svg
100000078	100005404	100000099	\N	\N	\N	Usuários	Usuários	0	S	N	usuario.svg
100000078	100005405	100000099	\N	\N	\N	Unidades	Unidades	0	S	N	unidade.svg
100000078	100005406	100000099	\N	\N	\N	Recursos	Recursos	0	S	N	recurso.svg
100000078	100005407	100000099	\N	\N	\N	Contextos	Contextos	0	S	N	\N
100000078	100005408	100000099	\N	\N	\N	Permissões	Permissões	0	S	N	permissao.svg
100000078	100005409	100000099	\N	\N	\N	Hierarquias	Hierarquias	0	S	N	hierarquia.svg
100000078	100005410	100000099	100000078	100005400	100014405	Log	\N	0	S	N	\N
100000078	100005411	100000099	100000078	100005399	100014369	Novo	Cadastro de Menu	1	S	N	\N
100000078	100005412	100000099	100000078	100005401	100014312	Novo	Cadastro de Órgão	1	S	N	\N
100000078	100005413	100000099	100000078	100005402	100014359	Novo	Cadastro de Perfil	10	S	N	\N
100000078	100005414	100000099	\N	\N	\N	Grupos de Rede	\N	0	S	N	\N
100000078	100005415	100000099	100000078	100005399	100014370	Listar	Lista de Menus	2	S	N	\N
100000078	100005416	100000099	100000078	100005399	100014375	Montar	\N	30	S	N	\N
100000078	100005417	100000099	100000078	100005401	100014313	Listar	Lista de Órgãos	2	S	N	\N
100000078	100005418	100000099	100000078	100005403	100014301	Novo	Cadastro de Sistema	1	S	N	\N
100000078	100005419	100000099	100000078	100005404	100014327	Novo	Cadastro de Usuário	1	S	N	\N
100000078	100005420	100000099	100000078	100005405	100014344	Nova	Cadastro de Unidade	10	S	N	\N
100000078	100005421	100000099	100000078	100005406	100014353	Novo	Cadastro de Recurso	10	S	N	\N
100000078	100005422	100000099	100000078	100005402	100014360	Listar	Lista de Perfis	20	S	N	\N
100000078	100005423	100000099	100000078	100005402	100014395	Clonar	\N	30	S	N	\N
100000078	100005424	100000099	100000078	100005402	100014365	Montar	Montagem dos Recursos do Perfil	40	S	N	\N
100000078	100005425	100000099	\N	\N	\N	Desenvolvimento	\N	0	S	N	\N
100000078	100005427	100000099	100000078	100005408	100014379	Nova	Cadastro de Permissão	10	S	N	\N
100000078	100005428	100000099	100000078	100005403	100014302	Listar	Lista de Sistemas	2	S	N	\N
100000078	100005429	100000099	100000078	100005403	100014393	Clonar	\N	3	S	N	\N
100000078	100005430	100000099	100000078	100005404	100014328	Listar	Lista de Usuários	2	S	N	\N
100000078	100005431	100000099	100000078	100005405	100014345	Listar	Lista de Unidades	20	S	N	\N
100000078	100005432	100000099	100000078	100005406	100014354	Listar	Lista de Recursos	20	S	N	\N
100000078	100005433	100000099	100000078	100005408	\N	Tipos	Tipos de Permissão	40	S	N	\N
100000078	100005435	100000099	100000078	100005409	100014333	Nova	Cadastro de Hierarquia	1	S	N	\N
100000078	100005436	100000099	100000078	100005400	100014418	Parâmetros	\N	0	S	N	\N
100000078	100005437	100000099	100000078	100005400	100014423	Sequências	\N	0	S	N	\N
100000078	100005438	100000099	100000078	100005403	100014394	Importar	\N	4	S	N	\N
100000078	100005439	100000099	100000078	100005404	100014407	Reativar	\N	12	S	N	\N
100000078	100005440	100000099	100000078	100005405	100014408	Reativar	\N	30	S	N	\N
100000078	100005441	100000099	100000078	100005406	100014409	Reativar	\N	30	S	N	\N
100000078	100005442	100000099	100000078	100005409	100014334	Listar	Lista de Hierarquias	2	S	N	\N
100000078	100005443	100000099	100000078	100005409	100014340	Montar	\N	30	S	N	\N
100000078	100005444	100000099	100000078	100005408	100014381	Pessoais	Lista de Permissões Pessoais	30	S	N	\N
100000078	100005446	100000099	100000078	100005402	100014367	Coordenadores	Lista de Coordenadores de Perfis	50	S	N	\N
100000078	100005449	100000099	100000078	100005405	100014351	Coordenadores	Lista de Coordenadores de Unidades	40	S	N	\N
100000078	100005450	100000099	100000078	100005433	100014307	Novo	Cadastro de Tipo de Permissão	1	S	N	\N
100000078	100005451	100000099	100000078	100005408	100014380	Administradas	Lista de Permissões Administradas	20	S	N	\N
100000078	100005452	100000099	100000078	100005403	100014325	Administradores	Lista de Administradores de Sistemas	4	S	N	\N
100000078	100005453	100000099	100000078	100005433	100014308	Listar	Lista de Tipo de Permissão	2	S	N	\N
100000078	100005454	100000099	100000078	100005406	100014396	Gerar Padrão PHP	\N	40	S	N	\N
100000078	100005456	100000099	100000078	100005408	100014412	Atribuição em Bloco	\N	15	S	N	\N
100000078	100005606	100000099	100000078	100005400	100015187	Auditoria	\N	0	S	N	\N
100000078	100005607	100000099	100000078	100005402	100015188	Reativar	\N	30	S	N	\N
100000078	100005609	100000099	100000078	100005400	100015193	Agendamentos	\N	0	S	N	\N
100000078	100005610	100000099	100000078	100005400	100015198	Comparação de Bancos	\N	0	S	N	\N
100000078	100005611	100000099	\N	\N	100015203	Regras de Auditoria	\N	0	S	N	regra_auditoria.svg
100000078	100005618	100000099	100000078	100005401	100015265	Reativar	\N	30	S	N	\N
100000078	100005637	100000099	\N	\N	100015368	Servidores de Autenticação	\N	0	S	N	servidor_autenticacao.svg
100000078	100005650	100000099	100000078	100005403	100015451	Reativar	\N	2	S	N	\N
100000078	100005651	100000099	100000078	100005409	100015452	Reativar	\N	2	S	N	\N
100000078	100005671	100000099	100000078	100005402	100015552	Comparar	\N	80	S	N	\N
100000078	100005672	100000099	100000078	100005400	100015554	Módulos	\N	0	S	N	\N
100000078	100005673	100000099	100000078	100005400	100015555	Cache em Memória	\N	0	S	N	\N
100000078	100005674	100000099	\N	\N	100015560	Acessos	\N	0	S	N	acesso.svg
100000078	100005675	100000099	\N	\N	100015563	E-mails do Sistema	\N	0	S	N	email.svg
100000078	100005676	100000099	\N	\N	100015568	Autenticação em 2 Fatores	\N	0	S	N	2fa.svg
100000079	100005460	100000100	\N	\N	\N	Infra	\N	999	S	N	infra.svg
100000079	100005462	100000100	\N	\N	100014783	Pesquisa	\N	0	S	N	pesquisa.svg
100000079	100005463	100000100	\N	100005471	100015529	Tabela de Assuntos	\N	0	S	N	\N
100000079	100005464	100000100	\N	\N	\N	Relatórios	\N	0	S	N	relatorios.svg
100000079	100005465	100000100	100000079	100005460	100014561	Log	\N	0	S	N	\N
100000079	100005466	100000100	\N	\N	\N	Estatísticas	\N	0	S	N	estatisticas.svg
100000079	100005467	100000100	\N	\N	100014925	Arquivamento	\N	0	S	N	arquivamento.svg
100000079	100005470	100000100	\N	\N	\N	Localizadores	\N	0	S	N	\N
100000079	100005471	100000100	\N	\N	\N	Administração	\N	0	S	N	administracao.svg
100000079	100005472	100000100	\N	100005677	100014815	Internos	\N	0	S	N	\N
100000079	100005474	100000100	\N	\N	100014926	Desarquivamento	\N	0	S	N	desarquivamento.svg
100000079	100005476	100000100	\N	\N	100014749	Iniciar Processo	\N	0	S	N	iniciar_processo.svg
100000079	100005477	100000100	\N	100005677	100014820	Reunião	\N	0	S	N	\N
100000079	100005478	100000100	\N	\N	100014898	Retorno Programado	\N	0	S	N	retorno_programado.svg
100000079	100005479	100000100	\N	100005471	\N	Contatos	\N	0	S	N	\N
100000079	100005480	100000100	100000079	100005460	100014746	Parâmetros	\N	0	S	N	\N
100000079	100005481	100000100	100000079	100005460	100014755	Sequências	\N	0	S	N	\N
100000079	100005483	100000100	100000079	100005667	\N	Estados	\N	20	S	N	\N
100000079	100005484	100000100	\N	\N	100014914	Base de Conhecimento	\N	0	S	N	base_conhecimento.svg
100000079	100005485	100000100	\N	100005677	100014812	Assinatura	\N	0	S	N	\N
100000079	100005487	100000100	100000079	100005470	100014623	Novo	\N	10	S	N	\N
100000079	100005488	100000100	\N	\N	100014751	Controle de Processos	\N	0	S	N	controle_processos.svg
100000079	100005489	100000100	\N	\N	100014862	Processos Sobrestados	\N	0	S	N	processos_sobrestados.svg
100000079	100005490	100000100	100000079	100005470	\N	Tipos	\N	30	S	N	\N
100000079	100005491	100000100	100000079	100005466	100014947	Unidade	\N	20	S	N	\N
100000079	100005492	100000100	100000079	100005470	100014626	Listar	\N	20	S	N	\N
100000079	100005493	100000100	100000079	100005471	100014799	Órgãos	\N	0	S	N	\N
100000079	100005494	100000100	100000079	100005471	\N	Tipos de Documento	\N	0	S	N	\N
100000079	100005495	100000100	\N	\N	100014934	Acompanhamento Especial	\N	0	S	N	acompanhamento_especial.svg
100000079	100005496	100000100	100000079	100005470	\N	Lugares	\N	40	S	N	\N
100000079	100005497	100000100	100000079	100005667	\N	Cidades	\N	30	S	N	\N
100000079	100005498	100000100	100000079	100005471	\N	Unidades	\N	0	S	N	\N
100000079	100005499	100000100	100000079	100005466	100014907	Ouvidoria	\N	10	S	N	\N
100000079	100005500	100000100	100000079	100005471	\N	Usuários	\N	0	S	N	\N
100000079	100005501	100000100	100000079	100005471	100014857	Novidades	\N	0	S	N	\N
100000079	100005502	100000100	100000079	100005483	100014489	Novo	\N	10	S	N	\N
100000079	100005503	100000100	100000079	100005660	100014539	Contatos	\N	0	S	N	\N
100000079	100005504	100000100	100000079	100005479	\N	Cargos	\N	70	S	N	\N
100000079	100005505	100000100	100000079	100005460	100014762	Atributos de Sessão	\N	0	S	N	\N
100000079	100005506	100000100	100000079	100005490	100014594	Novo	\N	10	S	N	\N
100000079	100005507	100000100	100000079	100005483	100014492	Listar	\N	20	S	N	\N
100000079	100005509	100000100	100000079	100005494	100014646	Novo	\N	10	S	N	\N
100000079	100005510	100000100	100000079	100005479	100014515	Reativar	\N	30	S	N	\N
100000079	100005511	100000100	100000079	100005490	100014597	Listar	\N	20	S	N	\N
100000079	100005512	100000100	100000079	100005496	100014610	Novo	\N	10	S	N	\N
100000079	100005513	100000100	100000079	100005497	100014495	Nova	\N	10	S	N	\N
100000079	100005514	100000100	100000079	100005479	100014511	Listar	\N	20	S	N	\N
100000079	100005515	100000100	100000079	100005479	\N	Vocativos	\N	100	S	N	\N
100000079	100005516	100000100	100000079	100005494	100014649	Listar	\N	20	S	N	\N
100000079	100005517	100000100	100000079	100005494	\N	Grupos	\N	40	S	N	\N
100000079	100005519	100000100	100000079	100005490	100014601	Reativar	\N	30	S	N	\N
100000079	100005520	100000100	100000079	100005496	100014613	Listar	\N	20	S	N	\N
100000079	100005521	100000100	100000079	100005497	100014498	Listar	\N	20	S	N	\N
100000079	100005522	100000100	100000079	100005498	100014525	Listar	\N	10	S	N	\N
100000079	100005523	100000100	100000079	100005470	\N	Suportes	\N	50	S	N	\N
100000079	100005524	100000100	100000079	100005479	\N	Tratamentos	\N	90	S	N	\N
100000079	100005525	100000100	100000079	100005500	100014519	Listar	\N	10	S	N	\N
100000079	100005526	100000100	100000079	100005471	\N	Tipos de Processo	\N	0	S	N	\N
100000079	100005527	100000100	100000079	100005494	100014653	Reativar	\N	30	S	N	\N
100000079	100005528	100000100	100000079	100005479	100014508	Novo	\N	10	S	N	\N
100000079	100005529	100000100	100000079	100005496	100014617	Reativar	\N	30	S	N	\N
100000079	100005530	100000100	100000079	100005498	100014529	Reativar	\N	20	S	N	\N
100000079	100005533	100000100	100000079	100005504	100014448	Novo	\N	10	S	N	\N
100000079	100005534	100000100	100000079	100005464	100014801	Contatos Temporários	\N	10	S	N	\N
100000079	100005535	100000100	100000079	100005500	100014577	Reativar	\N	20	S	N	\N
100000079	100005538	100000100	100000079	100005504	100014451	Listar	\N	20	S	N	\N
100000079	100005541	100000100	100000079	100005515	100014464	Novo	\N	10	S	N	\N
100000079	100005542	100000100	100000079	100005517	100014765	Novo	\N	10	S	N	\N
100000079	100005543	100000100	100000079	100005471	100014903	Ordenadores de Despesa	\N	0	S	N	\N
100000079	100005544	100000100	100000079	100005479	\N	Tipos	\N	40	S	N	\N
100000079	100005545	100000100	100000079	100005504	100014455	Reativar	\N	30	S	N	\N
100000079	100005546	100000100	100000079	100005523	100014602	Novo	\N	10	S	N	\N
100000079	100005548	100000100	100000079	100005524	100014472	Novo	\N	10	S	N	\N
100000079	100005549	100000100	100000079	100005515	100014467	Listar	\N	20	S	N	\N
100000079	100005550	100000100	100000079	100005471	100014795	Assinaturas das Unidades	\N	0	S	N	\N
100000079	100005551	100000100	100000079	100005526	100014441	Novo	\N	10	S	N	\N
100000079	100005552	100000100	100000079	100005517	100014768	Listar	\N	20	S	N	\N
100000079	100005553	100000100	100000079	100005523	100014605	Listar	\N	20	S	N	\N
100000079	100005554	100000100	100000079	100005524	100014475	Listar	\N	20	S	N	\N
100000079	100005555	100000100	100000079	100005515	100014471	Reativar	\N	30	S	N	\N
100000079	100005556	100000100	100000079	100005526	100014444	Listar	\N	20	S	N	\N
100000079	100005557	100000100	100000079	100005517	100014772	Reativar	\N	30	S	N	\N
100000079	100005558	100000100	100000079	100005523	100014609	Reativar	\N	30	S	N	\N
100000079	100005559	100000100	100000079	100005524	100014479	Reativar	\N	30	S	N	\N
100000079	100005560	100000100	100000079	100005526	100014480	Reativar	\N	30	S	N	\N
100000079	100005561	100000100	100000079	100005471	100014967	Critérios de Controle Interno	\N	0	S	N	\N
100000079	100005562	100000100	100000079	100005544	100014481	Novo	\N	10	S	N	\N
100000079	100005563	100000100	100000079	100005544	100014484	Listar	\N	20	S	N	\N
100000079	100005565	100000100	100000079	100005544	100014488	Reativar	\N	30	S	N	\N
100000079	100005570	100000100	100000079	100005471	\N	Sistemas	\N	0	S	N	\N
100000079	100005571	100000100	100000079	100005570	100015036	Novo	\N	10	S	N	\N
100000079	100005572	100000100	100000079	100005570	100015039	Listar	\N	20	S	N	\N
100000079	100005573	100000100	100000079	100005570	100015042	Reativar	\N	30	S	N	\N
100000079	100005574	100000100	\N	100005660	100014955	E-Mail	\N	0	S	N	\N
100000079	100005575	100000100	100000079	100005471	\N	Editor	\N	0	S	N	\N
100000079	100005576	100000100	100000079	100005575	\N	Modelos	\N	10	S	N	\N
100000079	100005577	100000100	100000079	100005576	100015043	Novo	\N	10	S	N	\N
100000079	100005578	100000100	100000079	100005576	100015047	Listar	\N	20	S	N	\N
100000079	100005579	100000100	100000079	100005576	100015050	Reativar	\N	30	S	N	\N
100000079	100005580	100000100	100000079	100005576	100015051	Clonar	\N	40	S	N	\N
100000079	100005581	100000100	100000079	100005575	100015056	Estilos	\N	20	S	N	\N
100000079	100005582	100000100	100000079	100005575	100015087	Tarjas	\N	30	S	N	\N
100000079	100005583	100000100	100000079	100005471	\N	Extensões de Arquivos Permitidas	\N	0	S	N	\N
100000079	100005584	100000100	100000079	100005583	100015089	Nova	\N	10	S	N	\N
100000079	100005585	100000100	100000079	100005583	100015092	Listar	\N	20	S	N	\N
100000079	100005586	100000100	100000079	100005583	100015095	Reativar	\N	30	S	N	\N
100000079	100005587	100000100	100000079	100005667	\N	Países	\N	10	S	N	\N
100000079	100005588	100000100	100000079	100005587	100015096	Novo	\N	10	S	N	\N
100000079	100005589	100000100	100000079	100005587	100015100	Listar	\N	20	S	N	\N
100000079	100005590	100000100	100000079	100005659	\N	E-Mail	\N	0	S	N	\N
100000079	100005591	100000100	100000079	100005590	100015102	Novo	\N	10	S	N	\N
100000079	100005592	100000100	100000079	100005590	100015106	Listar	\N	20	S	N	\N
100000079	100005593	100000100	100000079	100005590	100015109	Reativar	\N	30	S	N	\N
100000079	100005594	100000100	100000079	100005494	100015113	Numeração	\N	40	S	N	\N
100000079	100005596	100000100	100000079	100005471	\N	Usuários Externos	\N	0	S	N	\N
100000079	100005597	100000100	100000079	100005596	100015122	Listar	\N	10	S	N	\N
100000079	100005598	100000100	100000079	100005596	100015125	Reativar	\N	20	S	N	\N
100000079	100005599	100000100	\N	\N	100015137	Inspeção Administrativa	\N	0	S	N	inspecao_administrativa.svg
100000079	100005600	100000100	\N	\N	100015159	Favoritos	\N	0	S	N	favoritos.svg
100000079	100005601	100000100	100000079	100005460	100015160	Navegadores	\N	0	S	N	\N
100000079	100005602	100000100	\N	\N	100015166	Textos Padrão	\N	0	S	N	texto_padrao.svg
100000079	100005604	100000100	100000079	100005460	100015169	Indexação	\N	0	S	N	\N
100000079	100005605	100000100	100000079	100005471	100015172	E-mails do Sistema	\N	0	S	N	\N
100000079	100005612	100000100	100000079	100005460	100015235	Auditoria	\N	0	S	N	\N
100000079	100005613	100000100	100000079	100005460	100015239	Agendamentos	\N	0	S	N	\N
100000079	100005614	100000100	100000079	100005460	100015244	Comparação de Bancos	\N	0	S	N	\N
100000079	100005619	100000100	100000079	100005471	100015269	Histórico	\N	0	S	N	\N
100000079	100005620	100000100	\N	\N	100015273	Acompanhamento Ouvidoria	\N	0	S	N	\N
100000079	100005621	100000100	100000079	100005471	\N	Veículos de Publicação	\N	0	S	N	\N
100000079	100005623	100000100	100000079	100005471	100015289	Feriados	\N	0	S	N	\N
100000079	100005624	100000100	100000079	100005621	100015290	Novo	\N	10	S	N	\N
100000079	100005625	100000100	100000079	100005621	100015291	Listar	\N	20	S	N	\N
100000079	100005626	100000100	100000079	100005621	100015295	Reativar	\N	30	S	N	\N
100000079	100005627	100000100	100000079	100005621	100015302	Imprensa Nacional	\N	40	S	N	\N
100000079	100005628	100000100	100000079	100005471	\N	Tipos de Conferência	\N	0	S	N	\N
100000079	100005629	100000100	100000079	100005628	100015345	Novo	\N	10	S	N	\N
100000079	100005630	100000100	100000079	100005628	100015348	Listar	\N	20	S	N	\N
100000079	100005631	100000100	100000079	100005628	100015351	Reativar	\N	30	S	N	\N
100000079	100005632	100000100	100000079	100005466	100015352	Desempenho de Processos	\N	30	S	N	\N
100000079	100005633	100000100	100000079	100005471	\N	Hipóteses Legais	\N	0	S	N	\N
100000079	100005634	100000100	100000079	100005633	100015355	Nova	\N	10	S	N	\N
100000079	100005635	100000100	100000079	100005633	100015359	Listar	\N	20	S	N	\N
100000079	100005636	100000100	100000079	100005633	100015362	Reativar	\N	30	S	N	\N
100000079	100005638	100000100	100000079	100005460	100015376	Velocidades de Transferência de Dados	\N	0	S	N	\N
100000079	100005639	100000100	100000079	100005575	\N	Formatos de Imagem Permitidos	\N	40	S	N	\N
100000079	100005640	100000100	100000079	100005639	100015380	Novo	\N	10	S	N	\N
100000079	100005641	100000100	100000079	100005639	100015382	Listar	\N	20	S	N	\N
100000079	100005642	100000100	100000079	100005639	100015386	Reativar	\N	30	S	N	\N
100000079	100005643	100000100	\N	100005660	100015405	Envio	\N	0	S	N	\N
100000079	100005644	100000100	100000079	100005659	\N	Envio	\N	0	S	N	\N
100000079	100005645	100000100	100000079	100005644	100015409	Novo	\N	10	S	N	\N
100000079	100005646	100000100	100000079	100005644	100015411	Listar	\N	20	S	N	\N
100000079	100005647	100000100	100000079	100005644	100015416	Reativar	\N	30	S	N	\N
100000079	100005648	100000100	100000079	100005471	100015426	Pontos de Controle	\N	0	S	N	\N
100000079	100005649	100000100	\N	\N	100015450	Pontos de Controle	\N	0	S	N	pontos_controle.svg
100000079	100005652	100000100	100000079	100005464	100015455	Acervo de Sigilosos da Unidade	\N	0	S	N	\N
100000079	100005653	100000100	100000079	100005460	100015456	Módulos	\N	0	S	N	\N
100000079	100005654	100000100	100000079	100005460	100015459	Cache em Memória	\N	0	S	N	\N
100000079	100005655	100000100	100000079	100005471	\N	Tipos de Formulários	\N	0	S	N	\N
100000079	100005656	100000100	100000079	100005655	100015472	Listar	\N	0	S	N	\N
100000079	100005657	100000100	100000079	100005655	100015474	Novo	\N	0	S	N	\N
100000079	100005658	100000100	100000079	100005655	100015478	Reativar	\N	0	S	N	\N
100000079	100005659	100000100	100000079	100005471	\N	Grupos Institucionais	\N	0	S	N	\N
100000079	100005660	100000100	\N	\N	\N	Grupos	\N	0	S	N	grupos.svg
100000079	100005661	100000100	\N	\N	100014511	Contatos	\N	0	S	N	contatos.svg
100000079	100005662	100000100	100000079	100005659	100014539	Contatos	\N	0	S	N	\N
100000079	100005663	100000100	100000079	100005662	100015486	Novo	\N	10	S	N	\N
100000079	100005664	100000100	100000079	100005662	100015489	Reativar	\N	30	S	N	\N
100000079	100005665	100000100	100000079	100005662	100015491	Listar	\N	20	S	N	\N
100000079	100005666	100000100	100000079	100005570	100015493	Monitoramento de Serviços	\N	40	S	N	\N
100000079	100005667	100000100	100000079	100005471	\N	Países, Estados e Cidades	\N	0	S	N	\N
100000079	100005668	100000100	\N	\N	100015502	Marcadores	\N	0	S	N	marcadores.svg
100000079	100005669	100000100	100000079	100005466	100015542	Arquivamento	\N	0	S	N	\N
100000079	100005670	100000100	100000079	100005498	100015549	Migrar Dados	\N	30	S	N	\N
100000079	100005677	100000100	\N	\N	\N	Blocos	\N	0	S	N	blocos.svg
100000079	100005678	100000100	\N	\N	100015592	Painel de Controle	\N	0	S	N	painel_controle.svg
100000079	100005679	100000100	100000079	100005479	\N	Títulos	\N	90	S	N	\N
100000079	100005680	100000100	100000079	100005679	100015625	Listar	\N	2	S	N	\N
100000079	100005681	100000100	100000079	100005679	100015627	Novo	\N	1	S	N	\N
100000079	100005682	100000100	100000079	100005679	100015631	Reativar	\N	3	S	N	\N
100000079	100005683	100000100	\N	\N	100015641	Controle de Prazos	\N	0	S	N	controle_prazo.svg
100000079	100005684	100000100	100000079	100005479	\N	Categorias	\N	100	S	N	\N
100000079	100005685	100000100	100000079	100005684	100015649	Listar	\N	20	S	N	\N
100000079	100005686	100000100	100000079	100005684	100015650	Nova	\N	10	S	N	\N
100000079	100005687	100000100	100000079	100005684	100015654	Reativar	\N	30	S	N	\N
100000079	100005688	100000100	100000079	100005471	100015682	Instalações Federação	\N	0	S	N	\N
100000079	100005689	100000100	100000079	100005660	100015760	Federação	\N	0	S	N	\N
100000079	100005690	100000100	100000079	100005659	\N	Federação	\N	0	S	N	\N
100000079	100005691	100000100	100000079	100005690	100015762	Novo	\N	10	S	N	\N
100000079	100005692	100000100	100000079	100005690	100015766	Listar	\N	20	S	N	\N
100000079	100005693	100000100	100000079	100005690	100015768	Reativar	\N	30	S	N	\N
100000079	100005694	100000100	100000079	100005460	100015790	Replicações Federação	\N	0	S	N	\N
100000079	100005695	100000100	100000079	100005471	100015793	Acervo Global de Sigilosos	\N	0	S	N	\N
\.


--
-- Data for Name: login; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login (id_login, id_sistema, id_usuario, id_usuario_emulador, dth_login, hash_interno, hash_usuario, hash_agente, http_client_ip, remote_addr, http_x_forwarded_for, sta_login, user_agent, id_dispositivo_acesso, id_codigo_acesso) FROM stdin;
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (id_menu, id_sistema, nome, descricao, sin_ativo) FROM stdin;
100000078	100000099	Principal	Menu do Sistema de Permissões	S
100000079	100000100	Principal	\N	S
\.


--
-- Data for Name: orgao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orgao (id_orgao, sigla, descricao, sin_ativo, sin_autenticar, ordem) FROM stdin;
0	ABC	Nome Completo do Órgão	S	N	0
\.


--
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perfil (id_perfil, id_sistema, nome, descricao, sin_coordenado, sin_ativo) FROM stdin;
100000931	100000099	Administrador SIP	Administrador	N	S
100000932	100000099	Básico	Básico	N	S
100000933	100000099	Administrador de Sistema	\N	N	S
100000935	100000099	Administrador de Hierarquia	\N	N	S
100000936	100000099	Coordenador de Perfil	Básico	N	S
100000937	100000099	Cadastro de Usuários e Unidades	\N	N	S
100000938	100000100	Básico	Acesso aos recursos básicos para qualquer usuário no SEI. Pode ser combinado com outros perfis, mas sempre tem que ser concedido para qualquer outro perfil funcionar corretamente.	N	S
100000939	100000100	Administrador	Acesso aos recursos de gestão de tabelas básicas da instituição, relatórios de gerenciamento e configurações gerais do SEI.	N	S
100000940	100000100	Informática	Acesso aos recursos específicos para quem trabalha com suporte de informática do SEI.	N	S
100000941	100000100	Arquivamento	Acesso aos recursos específicos para quem trabalha com arquivamento de vias físicas de documentos.	N	S
100000944	100000100	Ouvidoria	Acesso aos recursos específicos para quem trabalha na Ouvidoria do órgão.	N	S
100000945	100000100	Inspeção	Acesso aos recursos específicos para quem trabalha com inspeção administrativa no órgão.	N	S
100000946	100000099	Coordenador de Unidade	\N	N	S
100000947	100000100	Colaborador (Básico sem Assinatura)	Acesso aos recursos básicos para qualquer usuário no SEI, porém, sem permissão para assinatura de documentos.	N	S
100000949	100000100	Acervo de Sigilosos da Unidade	\N	N	S
\.


--
-- Data for Name: permissao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissao (id_perfil, id_sistema, id_usuario, id_unidade, id_tipo_permissao, dta_inicio, dta_fim, sin_subunidades) FROM stdin;
100000931	100000099	100000001	110000000	1	2016-11-28 00:00:00	\N	N
100000932	100000099	100000001	110000000	1	2016-11-28 00:00:00	\N	N
100000933	100000099	100000001	110000000	1	2016-11-28 00:00:00	\N	N
100000938	100000100	100000001	110000000	1	2016-11-28 00:00:00	\N	N
100000939	100000100	100000001	110000000	1	2016-11-28 00:00:00	\N	N
100000940	100000100	100000001	110000000	1	2016-11-28 00:00:00	\N	N
100000941	100000100	100000001	110000000	1	2016-11-28 00:00:00	\N	N
100000945	100000100	100000001	110000000	1	2016-11-28 00:00:00	\N	N
\.


--
-- Data for Name: recurso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recurso (id_sistema, id_recurso, nome, descricao, caminho, sin_ativo) FROM stdin;
100000099	100014301	sistema_cadastrar	Cadastro de Sistema	controlador.php?acao=sistema_cadastrar	S
100000099	100014302	sistema_listar	Lista de Sistemas	controlador.php?acao=sistema_listar	S
100000099	100014303	sistema_consultar	Consulta de Sistema	controlador.php?acao=sistema_consultar	S
100000099	100014304	sistema_alterar	Alteração de Sistema	controlador.php?acao=sistema_alterar	S
100000099	100014305	sistema_excluir	Exclusão de Sistema	controlador.php?acao=sistema_excluir	S
100000099	100014306	sistema_desativar	Desativação de Sistema	controlador.php?acao=sistema_desativar	S
100000099	100014307	tipo_permissao_cadastrar	Cadastro de Tipo de Permissão	controlador.php?acao=tipo_permissao_cadastrar	S
100000099	100014308	tipo_permissao_listar	Lista de Tipos de Permissão	controlador.php?acao=tipo_permissao_listar	S
100000099	100014309	tipo_permissao_consultar	Consulta de Tipo de Permissão	controlador.php?acao=tipo_permissao_consultar	S
100000099	100014310	tipo_permissao_alterar	Alteração de Tipo de Permissão	controlador.php?acao=tipo_permissao_alterar	S
100000099	100014311	tipo_permissao_excluir	Exclusão de Tipo de Permissão	controlador.php?acao=tipo_permissao_excluir	S
100000099	100014312	orgao_cadastrar	Cadastro de Órgão	controlador.php?acao=orgao_cadastrar	S
100000099	100014313	orgao_listar	Lista de Órgãos	controlador.php?acao=orgao_listar	S
100000099	100014314	orgao_consultar	Consulta de Órgão	controlador.php?acao=orgao_consultar	S
100000099	100014315	orgao_alterar	Alteração de Órgão	controlador.php?acao=orgao_alterar	S
100000099	100014316	orgao_excluir	Exclusão de Órgão	controlador.php?acao=orgao_excluir	S
100000099	100014317	orgao_desativar	Desativação de Órgão	controlador.php?acao=orgao_desativar	S
100000099	100014324	administrador_sistema_cadastrar	Cadastro de Administrador de Sistema	controlador.php?acao=administrador_sistema_cadastrar	S
100000099	100014325	administrador_sistema_listar	Lista de Administradores de Sistemas	controlador.php?acao=administrador_sistema_listar	S
100000099	100014326	administrador_sistema_excluir	Exclusão de Administrador de Sistema	controlador.php?acao=administrador_sistema_excluir	S
100000099	100014327	usuario_cadastrar	Cadastro de Usuário	controlador.php?acao=usuario_cadastrar	S
100000099	100014328	usuario_listar	Lista de Usuários	controlador.php?acao=usuario_listar	S
100000099	100014329	usuario_consultar	Consulta de Usuário	controlador.php?acao=usuario_consultar	S
100000099	100014330	usuario_alterar	Alteração de Usuário	controlador.php?acao=usuario_alterar	S
100000099	100014331	usuario_excluir	Exclusão de Usuário	controlador.php?acao=usuario_excluir	S
100000099	100014332	usuario_desativar	Desativação de Usuário	controlador.php?acao=usuario_desativar	S
100000099	100014333	hierarquia_cadastrar	Cadastro de Hierarquia	controlador.php?acao=hierarquia_cadastrar	S
100000099	100014334	hierarquia_listar	Lista de Hierarquias	controlador.php?acao=hierarquia_listar	S
100000099	100014335	hierarquia_consultar	Consulta de Hierarquia	controlador.php?acao=hierarquia_consultar	S
100000099	100014336	hierarquia_alterar	Alteração de Hierarquia	controlador.php?acao=hierarquia_alterar	S
100000099	100014337	hierarquia_excluir	Exclusão de Hierarquia	controlador.php?acao=hierarquia_excluir	S
100000099	100014338	hierarquia_desativar	Desativação de Hierarquia	controlador.php?acao=hierarquia_desativar	S
100000099	100014339	rel_hierarquia_unidade_cadastrar	Cadastro de Unidades na Hierarquia	controlador.php?acao=rel_hierarquia_unidade_cadastrar	S
100000099	100014340	rel_hierarquia_unidade_listar	Lista de Unidades da Hierarquia	controlador.php?acao=rel_hierarquia_unidade_listar	S
100000099	100014341	rel_hierarquia_unidade_alterar	Alteração de Unidade na Hierarquia	controlador.php?acao=rel_hierarquia_unidade_alterar	S
100000099	100014342	rel_hierarquia_unidade_excluir	Exclusão de Unidade na Hierarquia	controlador.php?acao=rel_hierarquia_unidade_excluir	S
100000099	100014343	rel_hierarquia_unidade_desativar	Desativação de Unidade na Hierarquia	controlador.php?acao=rel_hierarquia_unidade_desativar	S
100000099	100014344	unidade_cadastrar	Cadastro de Unidade	controlador.php?acao=unidade_cadastrar	S
100000099	100014345	unidade_listar	Lista de Unidades	controlador.php?acao=unidade_listar	S
100000099	100014346	unidade_consultar	Consulta de Unidade	controlador.php?acao=unidade_consutar	S
100000099	100014347	unidade_alterar	Alteração de Unidade	controlador.php?acao=unidade_alterar	S
100000099	100014348	unidade_excluir	Exclusão de Unidade	controlador.php?acao=unidade_excluir	S
100000099	100014349	unidade_desativar	Desativação de Unidade	controlador.php?acao=unidade_desativar	S
100000099	100014350	coordenador_unidade_cadastrar	Cadastro de Coordenador de Unidade	controlador.php?acao=coordenador_unidade_cadastrar	S
100000099	100014351	coordenador_unidade_listar	Lista de Coordenadores de Unidades	controlador.php?acao=coordenador_unidade_listar	S
100000099	100014352	coordenador_unidade_excluir	Exclusão de Coordenador de Unidade	controlador.php?acao=coordenador_unidade_excluir	S
100000099	100014353	recurso_cadastrar	Cadastro de Recurso	controlador.php?acao=recurso_cadastrar	S
100000099	100014354	recurso_listar	Lista de Recursos	controlador.php?acao=recurso_listar	S
100000099	100014355	recurso_consultar	Consulta de Recurso	controlador.php?acao=recurso_consultar	S
100000099	100014356	recurso_alterar	Alteração de Recurso	controlador.php?acao=recurso_alterar	S
100000099	100014357	recurso_excluir	Exclusão de Recurso	controlador.php?acao=recurso_excluir	S
100000099	100014358	recurso_desativar	Desativação de Recurso	controlador.php?acao=recurso_desativar	S
100000099	100014359	perfil_cadastrar	Cadastro de Perfil	controlador.php?acao=perfil_cadastrar	S
100000099	100014360	perfil_listar	Lista de Perfis	controlador.php?acao=perfil_listar	S
100000099	100014361	perfil_consultar	Consulta de Perfil	controlador.php?acao=perfil_consultar	S
100000099	100014362	perfil_alterar	Alteração de Perfil	controlador.php?acao=perfil_alterar	S
100000099	100014363	perfil_excluir	Exclusão de Perfil	controlador.php?acao=perfil_excluir	S
100000099	100014364	perfil_desativar	Desativação de Perfil	controlador.php?acao=perfil_desativar	S
100000099	100014365	perfil_montar	Montagem de Perfil	controlador.php?acao=perfil_montar	S
100000099	100014366	coordenador_perfil_cadastrar	Cadastro de Coordenador de Perfil	controlador.php?acao=coordenador_perfil_cadastrar	S
100000099	100014367	coordenador_perfil_listar	Lista de Coordenadores de Perfis	controlador.php?acao=coordenador_perfil_listar	S
100000099	100014368	coordenador_perfil_excluir	Exclusão de Coordenador de Perfil	controlador.php?acao=coordenador_perfil_excluir	S
100000099	100014369	menu_cadastrar	Cadastro de Menu	controlador.php?acao=menu_cadastrar	S
100000099	100014370	menu_listar	Lista de Menus	controlador.php?acao=menu_listar	S
100000099	100014371	menu_alterar	Alteração de Menu	controlador.php?acao=menu_alterar	S
100000099	100014372	menu_excluir	Exclusão de Menu	controlador.php?acao=menu_excluir	S
100000099	100014373	menu_desativar	Desativação de Menu	controlador.php?acao=menu_desativar	S
100000099	100014374	item_menu_cadastrar	Cadastro de Item de Menu	controlador.php?acao=item_menu_cadastrar	S
100000099	100014375	item_menu_listar	Lista de Itens de Menu	controlador.php?acao=item_menu_listar	S
100000099	100014376	item_menu_alterar	Alteração de Item de Menu	controlador.php?acao=item_menu_alterar	S
100000099	100014377	item_menu_excluir	Exclusão de Item de Menu	controlador.php?acao=item_menu_excluir	S
100000099	100014378	item_menu_desativar	Desativação de Item de Menu	controlador.php?acao=item_menu_desativar	S
100000099	100014379	permissao_cadastrar	Cadastro de Permissão	controlador.php?acao=permissao_cadastrar	S
100000099	100014380	permissao_listar_administradas	Lista de Permissões Administradas	controlador.php?acao=permissao_listar_administradas	S
100000099	100014381	permissao_listar_pessoais	Lista de Permissões Pessoais	controlador.php?acao=permissao_listar_pessoais	S
100000099	100014382	permissao_consultar	Consulta de Permissão	controlador.php?acao=permissao_consultar	S
100000099	100014383	permissao_alterar	Alteração de Permissão	controlador.php?acao=permissao_alterar	S
100000099	100014384	permissao_copiar	Cópia de Permissões	controlador.php?acao=permissao_copiar	S
100000099	100014385	permissao_excluir	Exclusão de Permissão	controlador.php?acao=permissao_excluir	S
100000099	100014386	permissao_delegar	Delegação de Permissões	controlador.php?acao=permissao_delegar	S
100000099	100014387	rel_perfil_recurso_cadastrar	Cadastro de Recurso de Perfil	controlador.php?acao=rel_perfil_recurso_cadastrar	S
100000099	100014388	rel_perfil_recurso_listar	Lista de Recursos de Perfil	controlador.php?acao=rel_perfil_recurso_listar	S
100000099	100014389	rel_perfil_recurso_excluir	Exclusão de Recurso de Perfil	controlador.php?acao=rel_perfil_recurso_excluir	S
100000099	100014390	rel_perfil_item_menu_cadastrar	Cadastro de Item de Menu em Perfil	controlador.php?acao=rel_perfil_item_menu_cadastrar	S
100000099	100014391	rel_perfil_item_menu_listar	Lista de Itens de Menu em Perfil	controlador.php?acao=rel_perfil_item_menu_listar	S
100000099	100014392	rel_perfil_item_menu_excluir	Exclusão de Item de Menu em Perfil	controlador.php?acao=rel_perfil_item_menu_excluir	S
100000099	100014393	sistema_clonar	\N	controlador.php?acao=sistema_clonar	S
100000099	100014394	sistema_importar	\N	controlador.php?acao=sistema_importar	S
100000099	100014395	perfil_clonar	\N	controlador.php?acao=perfil_clonar	S
100000099	100014396	recurso_gerar	\N	controlador.php?acao=recurso_gerar	S
100000099	100014405	infra_log_listar	\N	controlador.php?acao=infra_log_listar	S
100000099	100014406	infra_log_excluir	\N	controlador.php?acao=infra_log_excluir	S
100000099	100014407	usuario_reativar	\N	controlador.php?acao=usuario_reativar	S
100000099	100014408	unidade_reativar	\N	controlador.php?acao=unidade_reativar	S
100000099	100014409	recurso_reativar	\N	controlador.php?acao=recurso_reativar	S
100000099	100014410	rel_hierarquia_unidade_reativar	\N	controlador.php?acao=rel_hierarquia_unidade_reativar	S
100000099	100014412	permissao_atribuir_em_bloco	\N	controlador.php?acao=permissao_atribuir_em_bloco	S
100000099	100014414	hierarquia_clonar	\N	controlador.php?acao=hierarquia_clonar	S
100000099	100014415	infra_parametro_cadastrar	\N	controlador.php?acao=infra_parametro_cadastrar	S
100000099	100014416	infra_parametro_alterar	\N	controlador.php?acao=infra_parametro_alterar	S
100000099	100014417	infra_parametro_consultar	\N	controlador.php?acao=infra_parametro_consultar	S
100000099	100014418	infra_parametro_listar	\N	controlador.php?acao=infra_parametro_listar	S
100000099	100014419	infra_parametro_excluir	\N	controlador.php?acao=infra_parametro_excluir	S
100000099	100014420	infra_sequencia_cadastrar	\N	controlador.php?acao=infra_sequencia_cadastrar	S
100000099	100014421	infra_sequencia_alterar	\N	controlador.php?acao=infra_sequencia_alterar	S
100000099	100014422	infra_sequencia_consultar	\N	controlador.php?acao=infra_sequencia_consultar	S
100000099	100014423	infra_sequencia_listar	\N	controlador.php?acao=infra_sequencia_listar	S
100000099	100014424	infra_sequencia_excluir	\N	controlador.php?acao=infra_sequencia_excluir	S
100000099	100015173	login_padrao	\N	controlador.php?acao=login_padrao	S
100000099	100015174	login_unificado	\N	controlador.php?acao=login_unificado	S
100000099	100015175	login_remover	\N	controlador.php?acao=login_remover	S
100000099	100015176	infra_regra_auditoria_cadastrar	\N	controlador.php?acao=infra_regra_auditoria_cadastrar	S
100000099	100015177	infra_regra_auditoria_alterar	\N	controlador.php?acao=infra_regra_auditoria_alterar	S
100000099	100015178	infra_regra_auditoria_consultar	\N	controlador.php?acao=infra_regra_auditoria_consultar	S
100000099	100015179	infra_regra_auditoria_listar	\N	controlador.php?acao=infra_regra_auditoria_listar	S
100000099	100015180	infra_regra_auditoria_excluir	\N	controlador.php?acao=infra_regra_auditoria_excluir	S
100000099	100015181	infra_regra_auditoria_desativar	\N	controlador.php?acao=infra_regra_auditoria_desativar	S
100000099	100015182	infra_regra_auditoria_reativar	\N	controlador.php?acao=infra_regra_auditoria_reativar	S
100000099	100015183	infra_regra_auditoria_recurso_cadastrar	\N	controlador.php?acao=infra_regra_auditoria_recurso_cadastrar	S
100000099	100015184	infra_regra_auditoria_recurso_listar	\N	controlador.php?acao=infra_regra_auditoria_recurso_listar	S
100000099	100015185	infra_regra_auditoria_recurso_excluir	\N	controlador.php?acao=infra_regra_auditoria_recurso_excluir	S
100000099	100015186	infra_auditoria_cadastrar	\N	controlador.php?acao=infra_auditoria_cadastrar	S
100000099	100015187	infra_auditoria_listar	\N	controlador.php?acao=infra_auditoria_listar	S
100000099	100015188	perfil_reativar	\N	controlador.php?acao=perfil_reativar	S
100000099	100015190	infra_agendamento_tarefa_cadastrar	\N	controlador.php?acao=infra_agendamento_tarefa_cadastrar	S
100000099	100015191	infra_agendamento_tarefa_alterar	\N	controlador.php?acao=infra_agendamento_tarefa_alterar	S
100000099	100015192	infra_agendamento_tarefa_consultar	\N	controlador.php?acao=infra_agendamento_tarefa_consultar	S
100000099	100015193	infra_agendamento_tarefa_listar	\N	controlador.php?acao=infra_agendamento_tarefa_listar	S
100000099	100015194	infra_agendamento_tarefa_excluir	\N	controlador.php?acao=infra_agendamento_tarefa_excluir	S
100000099	100015195	infra_agendamento_tarefa_executar	\N	controlador.php?acao=infra_agendamento_tarefa_executar	S
100000099	100015196	infra_agendamento_tarefa_desativar	\N	controlador.php?acao=infra_agendamento_tarefa_desativar	S
100000099	100015197	infra_agendamento_tarefa_reativar	\N	controlador.php?acao=infra_agendamento_tarefa_reativar	S
100000099	100015198	infra_banco_comparar	\N	controlador.php?acao=infra_banco_comparar	S
100000099	100015199	recurso_selecionar_auditoria	\N	controlador.php?acao=recurso_selecionar_auditoria	S
100000099	100015200	regra_auditoria_cadastrar	\N	controlador.php?acao=regra_auditoria_cadastrar	S
100000099	100015201	regra_auditoria_alterar	\N	controlador.php?acao=regra_auditoria_alterar	S
100000099	100015202	regra_auditoria_consultar	\N	controlador.php?acao=regra_auditoria_consultar	S
100000099	100015203	regra_auditoria_listar	\N	controlador.php?acao=regra_auditoria_listar	S
100000099	100015204	regra_auditoria_excluir	\N	controlador.php?acao=regra_auditoria_excluir	S
100000099	100015205	regra_auditoria_desativar	\N	controlador.php?acao=regra_auditoria_desativar	S
100000099	100015206	regra_auditoria_reativar	\N	controlador.php?acao=regra_auditoria_reativar	S
100000099	100015207	rel_regra_auditoria_recurso_cadastrar	\N	controlador.php?acao=rel_regra_auditoria_recurso_cadastrar	S
100000099	100015208	rel_regra_auditoria_recurso_consultar	\N	controlador.php?acao=rel_regra_auditoria_recurso_consultar	S
100000099	100015209	rel_regra_auditoria_recurso_excluir	\N	controlador.php?acao=rel_regra_auditoria_recurso_excluir	S
100000099	100015210	rel_regra_auditoria_recurso_listar	\N	controlador.php?acao=rel_regra_auditoria_recurso_listar	S
100000099	100015259	sistema_upload	\N	controlador.php?acao=sistema_upload	S
100000099	100015265	orgao_reativar	\N	controlador.php?acao=orgao_reativar	S
100000099	100015363	servidor_autenticacao_cadastrar	\N	controlador.php?acao=servidor_autenticacao_cadastrar	S
100000099	100015364	servidor_autenticacao_alterar	\N	controlador.php?acao=servidor_autenticacao_alterar	S
100000099	100015365	servidor_autenticacao_excluir	\N	controlador.php?acao=servidor_autenticacao_excluir	S
100000099	100015366	servidor_autenticacao_selecionar	\N	controlador.php?acao=servidor_autenticacao_selecionar	S
100000099	100015367	servidor_autenticacao_consultar	\N	controlador.php?acao=servidor_autenticacao_consultar	S
100000099	100015368	servidor_autenticacao_listar	\N	controlador.php?acao=servidor_autenticacao_listar	S
100000099	100015369	rel_orgao_autenticacao_cadastrar	\N	controlador.php?acao=rel_orgao_autenticacao_cadastrar	S
100000099	100015370	rel_orgao_autenticacao_excluir	\N	controlador.php?acao=rel_orgao_autenticacao_excluir	S
100000099	100015371	rel_orgao_autenticacao_listar	\N	controlador.php?acao=rel_orgao_autenticacao_listar	S
100000099	100015451	sistema_reativar	\N	controlador.php?acao=sistema_reativar	S
100000099	100015452	hierarquia_reativar	\N	controlador.php?acao=hierarquia_reativar	S
100000099	100015551	perfil_importar	\N	controlador.php?acao=perfil_importar	S
100000099	100015552	perfil_comparar	\N	controlador.php?acao=perfil_comparar	S
100000099	100015554	modulo_listar	\N	controlador.php?acao=modulo_listar	S
100000099	100015555	infra_atributo_cache_listar	\N	controlador.php?acao=infra_atributo_cache_listar	S
100000099	100015556	infra_atributo_cache_excluir	\N	controlador.php?acao=infra_atributo_cache_excluir	S
100000099	100015557	infra_atributo_cache_consultar	\N	controlador.php?acao=infra_atributo_cache_consultar	S
100000099	100015558	infra_acesso_usuario_listar	\N	controlador.php?acao=infra_acesso_usuario_listar	S
100000099	100015559	infra_trocar_unidade	\N	controlador.php?acao=infra_trocar_unidade	S
100000099	100015560	login_listar	\N	controlador.php?acao=login_listar	S
100000099	100015561	login_consultar	\N	controlador.php?acao=login_consultar	S
100000099	100015562	email_sistema_alterar	\N	controlador.php?acao=email_sistema_alterar	S
100000099	100015563	email_sistema_listar	\N	controlador.php?acao=email_sistema_listar	S
100000099	100015564	email_sistema_consultar	\N	controlador.php?acao=email_sistema_consultar	S
100000099	100015565	email_sistema_desativar	\N	controlador.php?acao=email_sistema_desativar	S
100000099	100015566	email_sistema_reativar	\N	controlador.php?acao=email_sistema_reativar	S
100000099	100015567	ajuda_variaveis_email_sistema	\N	controlador.php?acao=ajuda_variaveis_email_sistema	S
100000099	100015568	codigo_acesso_listar	\N	controlador.php?acao=codigo_acesso_listar	S
100000099	100015569	codigo_acesso_consultar	\N	controlador.php?acao=codigo_acesso_consultar	S
100000099	100015570	codigo_acesso_excluir	\N	controlador.php?acao=codigo_acesso_excluir	S
100000099	100015571	codigo_acesso_desativar	\N	controlador.php?acao=codigo_acesso_desativar	S
100000099	100015572	codigo_acesso_reativar	\N	controlador.php?acao=codigo_acesso_reativar	S
100000099	100015573	dispositivo_acesso_listar	\N	controlador.php?acao=dispositivo_acesso_listar	S
100000099	100015574	dispositivo_acesso_consultar	\N	controlador.php?acao=dispositivo_acesso_consultar	S
100000099	100015575	codigo_bloqueio_listar	\N	controlador.php?acao=codigo_bloqueio_listar	S
100000099	100015576	codigo_bloqueio_consultar	\N	controlador.php?acao=codigo_bloqueio_consultar	S
100000099	100015577	usuario_historico_listar	\N	controlador.php?acao=usuario_historico_listar	S
100000099	100015578	usuario_historico_consultar	\N	controlador.php?acao=usuario_historico_consultar	S
100000099	100015579	usuario_historico_cadastrar	\N	controlador.php?acao=usuario_historico_cadastrar	S
100000099	100015580	usuario_bloquear	\N	controlador.php?acao=usuario_bloquear	S
100000099	100015581	usuario_desbloquear	\N	controlador.php?acao=usuario_desbloquear	S
100000099	100015582	sistema_gerar_chave_acesso	\N	controlador.php?acao=sistema_gerar_chave_acesso	S
100000099	100015583	sistema_servico_selecionar	\N	controlador.php?acao=sistema_servico_selecionar	S
100000100	100014435	procedimento_gerar	\N	controlador.php?acao=procedimento_gerar	S
100000100	100014436	procedimento_alterar	\N	controlador.php?acao=procedimento_alterar	S
100000100	100014437	procedimento_consultar	\N	controlador.php?acao=procedimento_consultar	S
100000100	100014438	procedimento_listar	\N	controlador.php?acao=procedimento_listar	S
100000100	100014439	procedimento_selecionar	\N	controlador.php?acao=procedimento_selecionar	S
100000100	100014440	procedimento_excluir	\N	controlador.php?acao=procedimento_excluir	S
100000100	100014441	tipo_procedimento_cadastrar	\N	controlador.php?acao=tipo_procedimento_cadastrar	S
100000100	100014442	tipo_procedimento_alterar	\N	controlador.php?acao=tipo_procedimento_alterar	S
100000100	100014443	tipo_procedimento_consultar	\N	controlador.php?acao=tipo_procedimento_consultar	S
100000100	100014444	tipo_procedimento_listar	\N	controlador.php?acao=tipo_procedimento_listar	S
100000100	100014445	tipo_procedimento_selecionar	\N	controlador.php?acao=tipo_procedimento_selecionar	S
100000100	100014446	tipo_procedimento_excluir	\N	controlador.php?acao=tipo_procedimento_excluir	S
100000100	100014447	tipo_procedimento_desativar	\N	controlador.php?acao=tipo_procedimento_desativar	S
100000100	100014448	cargo_cadastrar	\N	controlador.php?acao=cargo_cadastrar	S
100000100	100014449	cargo_alterar	\N	controlador.php?acao=cargo_alterar	S
100000100	100014450	cargo_consultar	\N	controlador.php?acao=cargo_consultar	S
100000100	100014451	cargo_listar	\N	controlador.php?acao=cargo_listar	S
100000100	100014452	cargo_selecionar	\N	controlador.php?acao=cargo_selecionar	S
100000100	100014453	cargo_excluir	\N	controlador.php?acao=cargo_excluir	S
100000100	100014454	cargo_desativar	\N	controlador.php?acao=cargo_desativar	S
100000100	100014455	cargo_reativar	\N	controlador.php?acao=cargo_reativar	S
100000100	100014464	vocativo_cadastrar	\N	controlador.php?acao=vocativo_cadastrar	S
100000100	100014465	vocativo_alterar	\N	controlador.php?acao=vocativo_alterar	S
100000100	100014466	vocativo_consultar	\N	controlador.php?acao=vocativo_consultar	S
100000100	100014467	vocativo_listar	\N	controlador.php?acao=vocativo_listar	S
100000100	100014468	vocativo_selecionar	\N	controlador.php?acao=vocativo_selecionar	S
100000100	100014469	vocativo_excluir	\N	controlador.php?acao=vocativo_excluir	S
100000100	100014470	vocativo_desativar	\N	controlador.php?acao=vocativo_desativar	S
100000100	100014471	vocativo_reativar	\N	controlador.php?acao=vocativo_reativar	S
100000100	100014472	tratamento_cadastrar	\N	controlador.php?acao=tratamento_cadastrar	S
100000100	100014473	tratamento_alterar	\N	controlador.php?acao=tratamento_alterar	S
100000100	100014474	tratamento_consultar	\N	controlador.php?acao=tratamento_consultar	S
100000100	100014475	tratamento_listar	\N	controlador.php?acao=tratamento_listar	S
100000100	100014476	tratamento_selecionar	\N	controlador.php?acao=tratamento_selecionar	S
100000100	100014477	tratamento_excluir	\N	controlador.php?acao=tratamento_excluir	S
100000100	100014478	tratamento_desativar	\N	controlador.php?acao=tratamento_desativar	S
100000100	100014479	tratamento_reativar	\N	controlador.php?acao=tratamento_reativar	S
100000100	100014480	tipo_procedimento_reativar	\N	controlador.php?acao=tipo_procedimento_reativar	S
100000100	100014481	tipo_contato_cadastrar	\N	controlador.php?acao=tipo_contato_cadastrar	S
100000100	100014482	tipo_contato_alterar	\N	controlador.php?acao=tipo_contato_alterar	S
100000100	100014483	tipo_contato_consultar	\N	controlador.php?acao=tipo_contato_consultar	S
100000100	100014484	tipo_contato_listar	\N	controlador.php?acao=tipo_contato_listar	S
100000100	100014485	tipo_contato_selecionar	\N	controlador.php?acao=tipo_contato_selecionar	S
100000100	100014486	tipo_contato_excluir	\N	controlador.php?acao=tipo_contato_excluir	S
100000100	100014487	tipo_contato_desativar	\N	controlador.php?acao=tipo_contato_desativar	S
100000100	100014488	tipo_contato_reativar	\N	controlador.php?acao=tipo_contato_reativar	S
100000100	100014489	uf_cadastrar	\N	controlador.php?acao=uf_cadastrar	S
100000100	100014490	uf_alterar	\N	controlador.php?acao=uf_alterar	S
100000100	100014491	uf_consultar	\N	controlador.php?acao=uf_consultar	S
100000100	100014492	uf_listar	\N	controlador.php?acao=uf_listar	S
100000100	100014493	uf_selecionar	\N	controlador.php?acao=uf_selecionar	S
100000100	100014494	uf_excluir	\N	controlador.php?acao=uf_excluir	S
100000100	100014495	cidade_cadastrar	\N	controlador.php?acao=cidade_cadastrar	S
100000100	100014496	cidade_alterar	\N	controlador.php?acao=cidade_alterar	S
100000100	100014497	cidade_consultar	\N	controlador.php?acao=cidade_consultar	S
100000100	100014498	cidade_listar	\N	controlador.php?acao=cidade_listar	S
100000100	100014499	cidade_selecionar	\N	controlador.php?acao=cidade_selecionar	S
100000100	100014500	cidade_excluir	\N	controlador.php?acao=cidade_excluir	S
100000100	100014508	contato_cadastrar	\N	controlador.php?acao=contato_cadastrar&sin_contexto=N	S
100000100	100014509	contato_alterar	\N	controlador.php?acao=contato_alterar	S
100000100	100014510	contato_consultar	\N	controlador.php?acao=contato_consultar	S
100000100	100014511	contato_listar	\N	controlador.php?acao=contato_listar	S
100000100	100014512	contato_selecionar	\N	controlador.php?acao=contato_selecionar	S
100000100	100014513	contato_excluir	\N	controlador.php?acao=contato_excluir	S
100000100	100014514	contato_desativar	\N	controlador.php?acao=contato_desativar	S
100000100	100014515	contato_reativar	\N	controlador.php?acao=contato_reativar	S
100000100	100014516	usuario_cadastrar	\N	controlador.php?acao=usuario_cadastrar	S
100000100	100014517	usuario_alterar	\N	controlador.php?acao=usuario_alterar	S
100000100	100014518	usuario_consultar	\N	controlador.php?acao=usuario_consultar	S
100000100	100014519	usuario_listar	\N	controlador.php?acao=usuario_listar	S
100000100	100014520	usuario_selecionar	\N	controlador.php?acao=usuario_selecionar	S
100000100	100014521	usuario_excluir	\N	controlador.php?acao=usuario_excluir	S
100000100	100014522	unidade_cadastrar	\N	controlador.php?acao=unidade_cadastrar	S
100000100	100014523	unidade_alterar	\N	controlador.php?acao=unidade_alterar	S
100000100	100014524	unidade_consultar	\N	controlador.php?acao=unidade_consultar	S
100000100	100014525	unidade_listar	\N	controlador.php?acao=unidade_listar	S
100000100	100014526	unidade_selecionar_todas	\N	controlador.php?acao=unidade_selecionar_todas	S
100000100	100014527	unidade_excluir	\N	controlador.php?acao=unidade_excluir	S
100000100	100014528	unidade_desativar	\N	controlador.php?acao=unidade_desativar	S
100000100	100014529	unidade_reativar	\N	controlador.php?acao=unidade_reativar	S
100000100	100014530	rel_grupo_contato_cadastrar	\N	controlador.php?acao=rel_grupo_contato_cadastrar	S
100000100	100014531	rel_grupo_contato_alterar	\N	controlador.php?acao=rel_grupo_contato_alterar	S
100000100	100014532	rel_grupo_contato_consultar	\N	controlador.php?acao=rel_grupo_contato_consultar	S
100000100	100014533	rel_grupo_contato_listar	\N	controlador.php?acao=rel_grupo_contato_listar	S
100000100	100014534	rel_grupo_contato_selecionar	\N	controlador.php?acao=rel_grupo_contato_selecionar	S
100000100	100014535	rel_grupo_contato_excluir	\N	controlador.php?acao=rel_grupo_contato_excluir	S
100000100	100014536	grupo_contato_cadastrar	\N	controlador.php?acao=grupo_contato_cadastrar	S
100000100	100014537	grupo_contato_alterar	\N	controlador.php?acao=grupo_contato_alterar	S
100000100	100014538	grupo_contato_consultar	\N	controlador.php?acao=grupo_contato_consultar	S
100000100	100014539	grupo_contato_listar	\N	controlador.php?acao=grupo_contato_listar	S
100000100	100014540	grupo_contato_selecionar	\N	controlador.php?acao=grupo_contato_selecionar	S
100000100	100014541	grupo_contato_excluir	\N	controlador.php?acao=grupo_contato_excluir	S
100000100	100014542	assunto_cadastrar	\N	controlador.php?acao=assunto_cadastrar	S
100000100	100014543	assunto_alterar	\N	controlador.php?acao=assunto_alterar	S
100000100	100014544	assunto_consultar	\N	controlador.php?acao=assunto_consultar	S
100000100	100014545	assunto_listar	\N	controlador.php?acao=assunto_listar	S
100000100	100014546	assunto_selecionar	\N	controlador.php?acao=assunto_selecionar	S
100000100	100014547	assunto_excluir	\N	controlador.php?acao=assunto_excluir	S
100000100	100014548	assunto_desativar	\N	controlador.php?acao=assunto_desativar	S
100000100	100014549	assunto_reativar	\N	controlador.php?acao=assunto_reativar	S
100000100	100014550	protocolo_gerar	\N	controlador.php?acao=protocolo_cadastrar	S
100000100	100014551	protocolo_alterar	\N	controlador.php?acao=protocolo_alterar	S
100000100	100014552	protocolo_consultar	\N	controlador.php?acao=protocolo_consultar	S
100000100	100014553	protocolo_listar	\N	controlador.php?acao=protocolo_listar	S
100000100	100014554	protocolo_selecionar	\N	controlador.php?acao=protocolo_selecionar	S
100000100	100014555	protocolo_excluir	\N	controlador.php?acao=protocolo_excluir	S
100000100	100014556	contato_imprimir_etiquetas	\N	controlador.php?acao=contato_imprimir_etiquetas	S
100000100	100014557	contato_pdf_etiquetas	\N	controlador.php?acao=contato_pdf_etiquetas	S
100000100	100014558	rel_unidade_tipo_contato_cadastrar	\N	controlador.php?acao=rel_unidade_tipo_contato_cadastrar	S
100000100	100014559	rel_unidade_tipo_contato_listar	\N	controlador.php?acao=rel_unidade_tipo_contato_listar	S
100000100	100014560	rel_unidade_tipo_contato_excluir	\N	controlador.php?acao=rel_unidade_tipo_contato_excluir	S
100000100	100014561	infra_log_listar	\N	controlador.php?acao=infra_log_listar	S
100000100	100014562	rel_tipo_procedimento_assunto_cadastrar	\N	controlador.php?acao=rel_tipo_procedimento_assunto_cadastrar	S
100000100	100014563	rel_tipo_procedimento_assunto_listar	\N	controlador.php?acao=rel_tipo_procedimento_assunto_listar	S
100000100	100014564	rel_tipo_procedimento_assunto_excluir	\N	controlador.php?acao=rel_tipo_procedimento_assunto_excluir	S
100000100	100014565	infra_log_excluir	\N	controlador.php?acao=infra_log_excluir	S
100000100	100014566	participante_cadastrar	\N	controlador.php?acao=participante_cadastrar	S
100000100	100014567	participante_alterar	\N	controlador.php?acao=participante_alterar	S
100000100	100014568	participante_consultar	\N	controlador.php?acao=participante_consultar	S
100000100	100014569	participante_listar	\N	controlador.php?acao=participante_listar	S
100000100	100014570	participante_selecionar	\N	controlador.php?acao=participante_selecionar	S
100000100	100014571	participante_excluir	\N	controlador.php?acao=participante_excluir	S
100000100	100014572	rel_protocolo_assunto_cadastrar	\N	controlador.php?acao=rel_protocolo_assunto_cadastrar	S
100000100	100014573	rel_protocolo_assunto_consultar	\N	controlador.php?acao=rel_protocolo_assunto_consultar	S
100000100	100014574	rel_protocolo_assunto_listar	\N	controlador.php?acao=rel_protocolo_assunto_listar	S
100000100	100014575	rel_protocolo_assunto_excluir	\N	controlador.php?acao=rel_protocolo_assunto_excluir	S
100000100	100014576	usuario_desativar	\N	controlador.php?acao=usuario_desativar	S
100000100	100014577	usuario_reativar	\N	controlador.php?acao=usuario_reativar	S
100000100	100014578	atributo_cadastrar	\N	controlador.php?acao=atributo_cadastrar	S
100000100	100014579	atributo_alterar	\N	controlador.php?acao=atributo_alterar	S
100000100	100014580	atributo_consultar	\N	controlador.php?acao=atributo_consultar	S
100000100	100014581	atributo_listar	\N	controlador.php?acao=atributo_listar	S
100000100	100014582	atributo_selecionar	\N	controlador.php?acao=atributo_selecionar	S
100000100	100014583	atributo_excluir	\N	controlador.php?acao=atributo_excluir	S
100000100	100014584	atributo_desativar	\N	controlador.php?acao=atributo_desativar	S
100000100	100014585	atributo_reativar	\N	controlador.php?acao=atributo_reativar	S
100000100	100014586	dominio_cadastrar	\N	controlador.php?acao=dominio_cadastrar	S
100000100	100014587	dominio_alterar	\N	controlador.php?acao=dominio_alterar	S
100000100	100014588	dominio_consultar	\N	controlador.php?acao=dominio_consultar	S
100000100	100014589	dominio_listar	\N	controlador.php?acao=dominio_listar	S
100000100	100014590	dominio_selecionar	\N	controlador.php?acao=dominio_selecionar	S
100000100	100014591	dominio_excluir	\N	controlador.php?acao=dominio_excluir	S
100000100	100014592	dominio_desativar	\N	controlador.php?acao=dominio_desativar	S
100000100	100014593	dominio_reativar	\N	controlador.php?acao=dominio_reativar	S
100000100	100014594	tipo_localizador_cadastrar	\N	controlador.php?acao=tipo_localizador_cadastrar	S
100000100	100014595	tipo_localizador_alterar	\N	controlador.php?acao=tipo_localizador_alterar	S
100000100	100014596	tipo_localizador_consultar	\N	controlador.php?acao=tipo_localizador_consultar	S
100000100	100014597	tipo_localizador_listar	\N	controlador.php?acao=tipo_localizador_listar	S
100000100	100014598	tipo_localizador_selecionar	\N	controlador.php?acao=tipo_localizador_selecionar	S
100000100	100014599	tipo_localizador_excluir	\N	controlador.php?acao=tipo_localizador_excluir	S
100000100	100014600	tipo_localizador_desativar	\N	controlador.php?acao=tipo_localizador_desativar	S
100000100	100014601	tipo_localizador_reativar	\N	controlador.php?acao=tipo_localizador_reativar	S
100000100	100014602	tipo_suporte_cadastrar	\N	controlador.php?acao=tipo_suporte_cadastrar	S
100000100	100014603	tipo_suporte_alterar	\N	controlador.php?acao=tipo_suporte_alterar	S
100000100	100014604	tipo_suporte_consultar	\N	controlador.php?acao=tipo_suporte_consultar	S
100000100	100014605	tipo_suporte_listar	\N	controlador.php?acao=tipo_suporte_listar	S
100000100	100014606	tipo_suporte_selecionar	\N	controlador.php?acao=tipo_suporte_selecionar	S
100000100	100014607	tipo_suporte_excluir	\N	controlador.php?acao=tipo_suporte_excluir	S
100000100	100014608	tipo_suporte_desativar	\N	controlador.php?acao=tipo_suporte_desativar	S
100000100	100014609	tipo_suporte_reativar	\N	controlador.php?acao=tipo_suporte_reativar	S
100000100	100014610	lugar_localizador_cadastrar	\N	controlador.php?acao=lugar_localizador_cadastrar	S
100000100	100014611	lugar_localizador_alterar	\N	controlador.php?acao=lugar_localizador_alterar	S
100000100	100014612	lugar_localizador_consultar	\N	controlador.php?acao=lugar_localizador_consultar	S
100000100	100014613	lugar_localizador_listar	\N	controlador.php?acao=lugar_localizador_listar	S
100000100	100014614	lugar_localizador_selecionar	\N	controlador.php?acao=lugar_localizador_selecionar	S
100000100	100014615	lugar_localizador_excluir	\N	controlador.php?acao=lugar_localizador_excluir	S
100000100	100014616	lugar_localizador_desativar	\N	controlador.php?acao=lugar_localizador_desativar	S
100000100	100014617	lugar_localizador_reativar	\N	controlador.php?acao=lugar_localizador_reativar	S
100000100	100014618	rel_protocolo_dominio_cadastrar	\N	controlador.php?acao=rel_protocolo_dominio_cadastrar	S
100000100	100015043	modelo_cadastrar	\N	controlador.php?acao=modelo_cadastrar	S
100000100	100014619	rel_protocolo_dominio_consultar	\N	controlador.php?acao=rel_protocolo_dominio_consultar	S
100000100	100014620	rel_protocolo_dominio_listar	\N	controlador.php?acao=rel_protocolo_dominio_listar	S
100000100	100014621	rel_protocolo_dominio_selecionar	\N	controlador.php?acao=rel_protocolo_dominio_selecionar	S
100000100	100014622	rel_protocolo_dominio_excluir	\N	controlador.php?acao=rel_protocolo_dominio_excluir	S
100000100	100014623	localizador_cadastrar	\N	controlador.php?acao=localizador_cadastrar	S
100000100	100014624	localizador_alterar	\N	controlador.php?acao=localizador_alterar	S
100000100	100014625	localizador_consultar	\N	controlador.php?acao=localizador_consultar	S
100000100	100014626	localizador_listar	\N	controlador.php?acao=localizador_listar	S
100000100	100014627	localizador_selecionar	\N	controlador.php?acao=localizador_selecionar	S
100000100	100014628	localizador_excluir	\N	controlador.php?acao=localizador_excluir	S
100000100	100014629	atividade_consultar	\N	controlador.php?acao=atividade_consultar	S
100000100	100014630	atividade_listar	\N	controlador.php?acao=atividade_listar	S
100000100	100014631	atividade_excluir	\N	controlador.php?acao=atividade_excluir	S
100000100	100014632	anexo_cadastrar	\N	controlador.php?acao=anexo_cadastrar	S
100000100	100014633	anexo_consultar	\N	controlador.php?acao=anexo_consultar	S
100000100	100014634	anexo_listar	\N	controlador.php?acao=anexo_listar	S
100000100	100014635	anexo_excluir	\N	controlador.php?acao=anexo_excluir	S
100000100	100014636	procedimento_upload_anexo	\N	controlador.php?acao=procedimento_upload_anexo	S
100000100	100014637	observacao_cadastrar	\N	controlador.php?acao=observacao_cadastrar	S
100000100	100014638	observacao_alterar	\N	controlador.php?acao=observacao_alterar	S
100000100	100014639	observacao_consultar	\N	controlador.php?acao=observacao_consultar	S
100000100	100014640	observacao_listar	\N	controlador.php?acao=observacao_listar	S
100000100	100014641	observacao_selecionar	\N	controlador.php?acao=observacao_selecionar	S
100000100	100014642	observacao_excluir	\N	controlador.php?acao=observacao_excluir	S
100000100	100014643	procedimento_download_anexo	\N	controlador.php?acao=procedimento_download_anexo	S
100000100	100014644	procedimento_remover_anexo	\N	controlador.php?acao=procedimento_remover_anexo	S
100000100	100014646	serie_cadastrar	\N	controlador.php?acao=serie_cadastrar	S
100000100	100014647	serie_alterar	\N	controlador.php?acao=serie_alterar	S
100000100	100014648	serie_consultar	\N	controlador.php?acao=serie_consultar	S
100000100	100014649	serie_listar	\N	controlador.php?acao=serie_listar	S
100000100	100014650	serie_selecionar	\N	controlador.php?acao=serie_selecionar	S
100000100	100014651	serie_excluir	\N	controlador.php?acao=serie_excluir	S
100000100	100014652	serie_desativar	\N	controlador.php?acao=serie_desativar	S
100000100	100014653	serie_reativar	\N	controlador.php?acao=serie_reativar	S
100000100	100014657	procedimento_atualizar_andamento	\N	controlador.php?acao=procedimento_atualizar_andamento	S
100000100	100014658	documento_assinar	\N	controlador.php?acao=documento_assinar	S
100000100	100014659	procedimento_concluir	\N	controlador.php?acao=procedimento_concluir	S
100000100	100014660	procedimento_enviar	\N	controlador.php?acao=procedimento_enviar	S
100000100	100014669	documento_gerar	\N	controlador.php?acao=documento_gerar	S
100000100	100014670	documento_alterar	\N	controlador.php?acao=documento_alterar	S
100000100	100014671	documento_consultar	\N	controlador.php?acao=documento_consultar	S
100000100	100014672	documento_listar	\N	controlador.php?acao=documento_listar	S
100000100	100014673	documento_selecionar	\N	controlador.php?acao=documento_selecionar	S
100000100	100014674	documento_excluir	\N	controlador.php?acao=documento_excluir	S
100000100	100014675	documento_download_anexo	\N	controlador.php?acao=documento_download_anexo	S
100000100	100014676	documento_upload_anexo	\N	controlador.php?acao=documento_upload_anexo	S
100000100	100014677	documento_remover_anexo	\N	controlador.php?acao=documento_remover_anexo	S
100000100	100014681	rel_protocolo_protocolo_cadastrar	\N	controlador.php?acao=rel_protocolo_protocolo_cadastrar	S
100000100	100014682	rel_protocolo_protocolo_consultar	\N	controlador.php?acao=rel_protocolo_protocolo_consultar	S
100000100	100014683	rel_protocolo_protocolo_listar	\N	controlador.php?acao=rel_protocolo_protocolo_listar	S
100000100	100014684	rel_protocolo_protocolo_excluir	\N	controlador.php?acao=rel_protocolo_protocolo_excluir	S
100000100	100014688	procedimento_consultar_historico	\N	controlador.php?acao=procedimento_consultar_historico	S
100000100	100014690	rel_unidade_serie_unidade_cadastrar	\N	controlador.php?acao=rel_unidade_serie_unidade_cadastrar	S
100000100	100014693	procedimento_reabrir	\N	controlador.php?acao=procedimento_reabrir	S
100000100	100014696	documento_enviar_email	\N	controlador.php?acao=documento_enviar_email	S
100000100	100014698	email_upload_anexo	\N	controlador.php?acao=email_upload_anexo	S
100000100	100014699	rel_protocolo_unidade_cadastrar	\N	controlador.php?acao=rel_protocolo_unidade_cadastrar	S
100000100	100014700	rel_protocolo_unidade_listar	\N	controlador.php?acao=rel_protocolo_unidade_listar	S
100000100	100014701	rel_protocolo_unidade_excluir	\N	controlador.php?acao=rel_protocolo_unidade_excluir	S
100000100	100014702	documento_receber	\N	controlador.php?acao=documento_receber	S
100000100	100014703	documento_alterar_recebido	\N	controlador.php?acao=documento_alterar_recebido	S
100000100	100014704	documento_consultar_recebido	\N	controlador.php?acao=documento_consultar_recebido	S
100000100	100014705	procedimento_vincular	\N	controlador.php?acao=procedimento_vincular	S
100000100	100014706	procedimento_pendencia_selecionar	\N	controlador.php?acao=procedimento_pendencia_selecionar	S
100000100	100014707	procedimento_sobrestar	\N	controlador.php?acao=procedimento_sobrestar	S
100000100	100014708	procedimento_remover_sobrestamento	\N	controlador.php?acao=procedimento_remover_sobrestamento	S
100000100	100014709	procedimento_relacionar	\N	controlador.php?acao=procedimento_relacionar	S
100000100	100014710	procedimento_excluir_relacionamento	\N	controlador.php?acao=procedimento_excluir_relacionamento	S
100000100	100014711	publicacao_agendar	\N	controlador.php?acao=publicacao_agendar	S
100000100	100014712	publicacao_alterar_agendamento	\N	controlador.php?acao=publicacao_alterar_agendamento	S
100000100	100014713	publicacao_listar	\N	controlador.php?acao=publicacao_listar	S
100000100	100014719	publicacao_cancelar_agendamento	\N	controlador.php?acao=publicacao_cancelar_agendamento	S
100000100	100014722	publicacao_consultar_agendamento	\N	controlador.php?acao=publicacao_consultar_agendamento	S
100000100	100014725	procedimento_autuar	\N	controlador.php?acao=procedimento_autuar	S
100000100	100014726	procedimento_imprimir_etiqueta	\N	controlador.php?acao=procedimento_imprimir_etiqueta	S
100000100	100014727	procedimento_imprimir_etiqueta_pdf	\N	controlador.php?acao=procedimento_imprimir_etiqueta_pdf	S
100000100	100014728	arquivamento_arquivar	\N	controlador.php?acao=arquivamento_arquivar	S
100000100	100014729	arquivamento_desarquivar	\N	controlador.php?acao=arquivamento_desarquivar	S
100000100	100014730	localizador_imprimir_etiqueta	\N	controlador.php?acao=localizador_imprimir_etiqueta	S
100000100	100014731	localizador_imprimir_etiqueta_pdf	\N	controlador.php?acao=localizador_imprimir_etiqueta_pdf	S
100000100	100014732	localizador_protocolos_listar	\N	controlador.php?acao=localizador_protocolos_listar	S
100000100	100014733	localizador_protocolos_imprimir	\N	controlador.php?acao=localizador_protocolos_imprimir	S
100000100	100014734	localizador_protocolos_imprimir_pdf	\N	controlador.php?acao=localizador_protocolos_imprimir_pdf	S
100000100	100014736	arquivamento_migrar_localizador	\N	controlador.php?acao=arquivamento_migrar_localizador	S
100000100	100014738	rel_protocolo_assunto_alterar	\N	controlador.php?acao=rel_protocolo_assunto_alterar	S
100000100	100014740	publicacao_gerar_relacionada	\N	controlador.php?acao=publicacao_gerar_relacionada	S
100000100	100014741	documento_gerado_selecionar	\N	controlador.php?acao=documento_gerado_selecionar	S
100000100	100014742	documento_recebido_selecionar	\N	controlador.php?acao=documento_recebido_selecionar	S
100000100	100014743	infra_parametro_cadastrar	\N	controlador.php?acao=infra_parametro_cadastrar	S
100000100	100014744	infra_parametro_alterar	\N	controlador.php?acao=infra_parametro_alterar	S
100000100	100014745	infra_parametro_consultar	\N	controlador.php?acao=infra_parametro_consultar	S
100000100	100014746	infra_parametro_listar	\N	controlador.php?acao=infra_parametro_listar	S
100000100	100014747	infra_parametro_selecionar	\N	controlador.php?acao=infra_parametro_selecionar	S
100000100	100014748	infra_parametro_excluir	\N	controlador.php?acao=infra_parametro_excluir	S
100000100	100014749	procedimento_escolher_tipo	\N	controlador.php?acao=procedimento_escolher_tipo	S
100000100	100014750	procedimento_analisar	\N	controlador.php?acao=procedimento_analisar	S
100000100	100014751	procedimento_controlar	\N	controlador.php?acao=procedimento_controlar&reset=1	S
100000100	100014752	infra_sequencia_cadastrar	\N	controlador.php?acao=infra_sequencia_cadastrar	S
100000100	100014753	infra_sequencia_alterar	\N	controlador.php?acao=infra_sequencia_alterar	S
100000100	100014754	infra_sequencia_consultar	\N	controlador.php?acao=infra_sequencia_consultar	S
100000100	100014755	infra_sequencia_listar	\N	controlador.php?acao=infra_sequencia_listar	S
100000100	100014756	infra_sequencia_excluir	\N	controlador.php?acao=infra_sequencia_excluir	S
100000100	100014757	procedimento_trabalhar	\N	controlador.php?acao=procedimento_trabalhar	S
100000100	100014759	arvore_visualizar	\N	controlador.php?acao=arvore_visualizar	S
100000100	100014760	infra_atributo_sessao_cadastrar	\N	controlador.php?acao=infra_atributo_sessao_cadastrar	S
100000100	100014761	infra_atributo_sessao_alterar	\N	controlador.php?acao=infra_atributo_sessao_alterar	S
100000100	100014762	infra_atributo_sessao_listar	\N	controlador.php?acao=infra_atributo_sessao_listar	S
100000100	100014763	infra_atributo_sessao_excluir	\N	controlador.php?acao=infra_atributo_sessao_excluir	S
100000100	100014764	infra_atributo_sessao_reativar	\N	controlador.php?acao=infra_atributo_sessao_reativar	S
100000100	100014765	grupo_serie_cadastrar	\N	controlador.php?acao=grupo_serie_cadastrar	S
100000100	100014766	grupo_serie_alterar	\N	controlador.php?acao=grupo_serie_alterar	S
100000100	100014767	grupo_serie_consultar	\N	controlador.php?acao=grupo_serie_consultar	S
100000100	100014768	grupo_serie_listar	\N	controlador.php?acao=grupo_serie_listar	S
100000100	100014769	grupo_serie_selecionar	\N	controlador.php?acao=grupo_serie_selecionar	S
100000100	100014770	grupo_serie_excluir	\N	controlador.php?acao=grupo_serie_excluir	S
100000100	100014771	grupo_serie_desativar	\N	controlador.php?acao=grupo_serie_desativar	S
100000100	100014772	grupo_serie_reativar	\N	controlador.php?acao=grupo_serie_reativar	S
100000100	100014773	documento_escolher_tipo	\N	controlador.php?acao=documento_escolher_tipo	S
100000100	100014774	bloco_cadastrar	\N	controlador.php?acao=bloco_cadastrar	S
100000100	100014775	bloco_alterar	\N	controlador.php?acao=bloco_alterar	S
100000100	100014776	bloco_consultar	\N	controlador.php?acao=bloco_consultar	S
100000100	100014777	bloco_selecionar_processo	\N	controlador.php?acao=bloco_selecionar_processo	S
100000100	100014778	bloco_excluir	\N	controlador.php?acao=bloco_excluir	S
100000100	100014779	bloco_desativar	\N	controlador.php?acao=bloco_desativar	S
100000100	100014780	bloco_reativar	\N	controlador.php?acao=bloco_reativar	S
100000100	100014781	rel_bloco_protocolo_cadastrar	\N	controlador.php?acao=rel_bloco_protocolo_cadastrar	S
100000100	100014782	bloco_selecionar_documento	\N	controlador.php?acao=bloco_selecionar_documento	S
100000100	100014783	protocolo_pesquisar	\N	controlador.php?acao=protocolo_pesquisar	S
100000100	100014784	agente_carregar	\N	controlador_edoc.php?acao=agente_carregar	S
100000100	100014785	procedimento_listar_relacionamentos	\N	controlador.php?acao=procedimento_listar_relacionamentos	S
100000100	100014786	protocolo_pesquisa_rapida	\N	controlador.php?acao=protocolo_pesquisa_rapida	S
100000100	100014787	assinatura_cadastrar	\N	controlador.php?acao=assinatura_cadastrar	S
100000100	100014788	assinatura_alterar	\N	controlador.php?acao=assinatura_alterar	S
100000100	100014789	assinatura_consultar	\N	controlador.php?acao=assinatura_consultar	S
100000100	100014790	assinatura_listar	\N	controlador.php?acao=assinatura_listar	S
100000100	100014791	assinatura_excluir	\N	controlador.php?acao=assinatura_excluir	S
100000100	100014792	assinante_cadastrar	\N	controlador.php?acao=assinante_cadastrar	S
100000100	100014793	assinante_alterar	\N	controlador.php?acao=assinante_alterar	S
100000100	100014794	assinante_consultar	\N	controlador.php?acao=assinante_consultar	S
100000100	100014795	assinante_listar	\N	controlador.php?acao=assinante_listar	S
100000100	100014796	assinante_selecionar	\N	controlador.php?acao=assinante_selecionar	S
100000100	100014797	assinante_excluir	\N	controlador.php?acao=assinante_excluir	S
100000100	100014798	orgao_consultar	\N	controlador.php?acao=orgao_consultar	S
100000100	100014799	orgao_listar	\N	controlador.php?acao=orgao_listar	S
100000100	100014800	contato_alterar_temporario	\N	controlador.php?acao=contato_alterar_temporario	S
100000100	100014801	contato_relatorio_temporarios	\N	controlador.php?acao=contato_relatorio_temporarios	S
100000100	100014802	documento_visualizar	\N	controlador.php?acao=documento_visualizar	S
100000100	100014803	rel_bloco_protocolo_consultar	\N	controlador.php?acao=rel_bloco_protocolo_consultar	S
100000100	100014804	rel_bloco_protocolo_listar	\N	controlador.php?acao=rel_bloco_protocolo_listar	S
100000100	100014805	rel_bloco_protocolo_excluir	\N	controlador.php?acao=rel_bloco_protocolo_excluir	S
100000100	100014806	rel_bloco_unidade_cadastrar	\N	controlador.php?acao=rel_bloco_unidade_cadastrar	S
100000100	100014807	rel_bloco_unidade_listar	\N	controlador.php?acao=rel_bloco_unidade_listar	S
100000100	100014808	rel_bloco_unidade_excluir	\N	controlador.php?acao=rel_bloco_unidade_excluir	S
100000100	100014809	bloco_cancelar_disponibilizacao	\N	controlador.php?acao=bloco_cancelar_disponibilizacao	S
100000100	100014810	documento_processar	\N	controlador.php?acao=documento_processar	S
100000100	100014811	bloco_assinatura_cadastrar	\N	controlador.php?acao=bloco_assinatura_cadastrar	S
100000100	100014812	bloco_assinatura_listar	\N	controlador.php?acao=bloco_assinatura_listar	S
100000100	100014813	bloco_assinatura_listar_disponibilizados	\N	controlador.php?acao=bloco_assinatura_listar_disponibilizados	S
100000100	100014814	bloco_interno_cadastrar	\N	controlador.php?acao=bloco_interno_cadastrar	S
100000100	100014815	bloco_interno_listar	\N	controlador.php?acao=bloco_interno_listar	S
100000100	100014816	bloco_interno_listar_disponibilizados	\N	controlador.php?acao=bloco_interno_listar_disponibilizados	S
100000100	100014817	bloco_disponibilizar	\N	controlador.php?acao=bloco_disponibilizar	S
100000100	100014818	rel_bloco_unidade_consultar	\N	controlador.php?acao=rel_bloco_unidade_consultar	S
100000100	100014819	bloco_reuniao_cadastrar	\N	controlador.php?acao=bloco_reuniao_cadastrar	S
100000100	100014820	bloco_reuniao_listar	\N	controlador.php?acao=bloco_reuniao_listar	S
100000100	100014821	bloco_reuniao_listar_disponibilizados	\N	controlador.php?acao=bloco_reuniao_listar_disponibilizados	S
100000100	100014822	bloco_listar	\N	controlador.php?acao=bloco_listar	S
100000100	100014824	atributo_andamento_cadastrar	\N	controlador.php?acao=atributo_andamento_cadastrar	S
100000100	100014825	atributo_andamento_consultar	\N	controlador.php?acao=atributo_andamento_consultar	S
100000100	100014826	atributo_andamento_listar	\N	controlador.php?acao=atributo_andamento_listar	S
100000100	100014827	atributo_andamento_excluir	\N	controlador.php?acao=atributo_andamento_excluir	S
100000100	100014828	documento_imprimir_word	\N	controlador.php?acao=documento_imprimir_word	S
100000100	100014829	contato_excluir_temporario	\N	controlador.php?acao=contato_excluir_temporario	S
100000100	100014830	contato_desativar_temporario	\N	controlador.php?acao=contato_desativar_temporario	S
100000100	100014831	rel_assinante_unidade_cadastrar	\N	controlador.php?acao=rel_assinante_unidade_cadastrar	S
100000100	100014832	rel_assinante_unidade_alterar	\N	controlador.php?acao=rel_assinante_unidade_alterar	S
100000100	100014833	rel_assinante_unidade_consultar	\N	controlador.php?acao=rel_assinante_unidade_consultar	S
100000100	100014834	rel_assinante_unidade_listar	\N	controlador.php?acao=rel_assinante_unidade_listar	S
100000100	100014835	rel_assinante_unidade_excluir	\N	controlador.php?acao=rel_assinante_unidade_excluir	S
100000100	100014836	unidade_selecionar_outras	\N	controlador.php?acao=unidade_selecionar_outras	S
100000100	100014837	bloco_assinatura_alterar	\N	controlador.php?acao=bloco_assinatura_alterar	S
100000100	100014838	bloco_reuniao_alterar	\N	controlador.php?acao=bloco_reuniao_alterar	S
100000100	100014839	bloco_interno_alterar	\N	controlador.php?acao=bloco_interno_alterar	S
100000100	100014840	rel_bloco_protocolo_alterar	\N	controlador.php?acao=rel_bloco_protocolo_alterar	S
100000100	100014841	bloco_retornar	\N	controlador.php?acao=bloco_retornar	S
100000100	100014843	procedimento_duplicar	\N	controlador.php?acao=procedimento_duplicar	S
100000100	100014845	bloco_concluir	\N	controlador.php?acao=bloco_concluir	S
100000100	100014847	anotacao_cadastrar	\N	controlador.php?acao=anotacao_cadastrar	S
100000100	100014848	anotacao_alterar	\N	controlador.php?acao=anotacao_alterar	S
100000100	100014849	anotacao_consultar	\N	controlador.php?acao=anotacao_consultar	S
100000100	100014850	anotacao_registrar	\N	controlador.php?acao=anotacao_registrar	S
100000100	100014851	anotacao_excluir	\N	controlador.php?acao=anotacao_excluir	S
100000100	100014852	anotacao_listar	\N	controlador.php?acao=anotacao_listar	S
100000100	100014853	atributo_andamento_alterar	\N	controlador.php?acao=atributo_andamento_alterar	S
100000100	100014854	novidade_cadastrar	\N	controlador.php?acao=novidade_cadastrar	S
100000100	100014855	novidade_alterar	\N	controlador.php?acao=novidade_alterar	S
100000100	100014856	novidade_consultar	\N	controlador.php?acao=novidade_consultar	S
100000100	100014857	novidade_listar	\N	controlador.php?acao=novidade_listar	S
100000100	100014858	novidade_excluir	\N	controlador.php?acao=novidade_excluir	S
100000100	100014859	novidade_cancelar_liberacao	\N	controlador.php?acao=novidade_cancelar_liberacao	S
100000100	100014860	novidade_liberar	\N	controlador.php?acao=novidade_liberar	S
100000100	100014861	novidade_mostrar	\N	controlador.php?acao=novidade_mostrar	S
100000100	100014862	procedimento_sobrestado_listar	\N	controlador.php?acao=procedimento_sobrestado_listar	S
100000100	100014863	arvore_ordenar	\N	controlador.php?acao=arvore_ordenar	S
100000100	100014864	email_unidade_cadastrar	\N	controlador.php?acao=email_unidade_cadastrar	S
100000100	100014865	email_unidade_alterar	\N	controlador.php?acao=email_unidade_alterar	S
100000100	100014866	email_unidade_consultar	\N	controlador.php?acao=email_unidade_consultar	S
100000100	100014867	email_unidade_listar	\N	controlador.php?acao=email_unidade_listar	S
100000100	100014868	email_unidade_excluir	\N	controlador.php?acao=email_unidade_excluir	S
100000100	100014869	acesso_externo_cadastrar	\N	controlador.php?acao=acesso_externo_cadastrar	S
100000100	100014870	acesso_externo_consultar	\N	controlador.php?acao=acesso_externo_consultar	S
100000100	100014871	acesso_externo_listar	\N	controlador.php?acao=acesso_externo_listar	S
100000100	100014872	orgao_alterar	\N	controlador.php?acao=orgao_alterar	S
100000100	100014873	procedimento_enviar_email	\N	controlador.php?acao=procedimento_enviar_email	S
100000100	100014874	email_enviar	\N	controlador.php?acao=email_enviar	S
100000100	100014875	protocolo_cancelar	\N	controlador.php?acao=protocolo_cancelar	S
100000100	100014876	base_conhecimento_cadastrar	\N	controlador.php?acao=base_conhecimento_cadastrar	S
100000100	100014877	base_conhecimento_alterar	\N	controlador.php?acao=base_conhecimento_alterar	S
100000100	100014878	base_conhecimento_consultar	\N	controlador.php?acao=base_conhecimento_consultar	S
100000100	100014879	base_conhecimento_listar	\N	controlador.php?acao=base_conhecimento_listar	S
100000100	100014880	base_conhecimento_excluir	\N	controlador.php?acao=base_conhecimento_excluir	S
100000100	100014881	base_conhecimento_processar	\N	controlador.php?acao=base_conhecimento_processar	S
100000100	100014883	feed_cadastrar	\N	controlador.php?acao=feed_cadastrar	S
100000100	100014884	feed_listar	\N	controlador.php?acao=feed_listar	S
100000100	100014885	feed_excluir	\N	controlador.php?acao=feed_excluir	S
100000100	100014886	rel_protocolo_atributo_cadastrar	\N	controlador.php?acao=rel_protocolo_atributo_cadastrar	S
100000100	100014887	rel_protocolo_atributo_listar	\N	controlador.php?acao=rel_protocolo_atributo_listar	S
100000100	100014888	rel_protocolo_atributo_excluir	\N	controlador.php?acao=rel_protocolo_atributo_excluir	S
100000100	100014892	documento_imprimir_web	\N	controlador.php?acao=documento_imprimir_web	S
100000100	100014893	procedimento_controlar_visualizacao	\N	controlador.php?acao=procedimento_controlar_visualizacao	S
100000100	100014895	retorno_programado_cadastrar	\N	controlador.php?acao=retorno_programado_cadastrar	S
100000100	100014896	retorno_programado_alterar	\N	controlador.php?acao=retorno_programado_alterar	S
100000100	100014897	retorno_programado_consultar	\N	controlador.php?acao=retorno_programado_consultar	S
100000100	100014898	retorno_programado_listar	\N	controlador.php?acao=retorno_programado_listar	S
100000100	100014899	retorno_programado_excluir	\N	controlador.php?acao=retorno_programado_excluir	S
100000100	100014900	ordenador_despesa_cadastrar	\N	controlador.php?acao=ordenador_despesa_cadastrar	S
100000100	100014901	ordenador_despesa_alterar	\N	controlador.php?acao=ordenador_despesa_alterar	S
100000100	100014902	ordenador_despesa_consultar	\N	controlador.php?acao=ordenador_despesa_consultar	S
100000100	100014903	ordenador_despesa_listar	\N	controlador.php?acao=ordenador_despesa_listar	S
100000100	100014904	ordenador_despesa_excluir	\N	controlador.php?acao=ordenador_despesa_excluir	S
100000100	100014905	siscom_grupo_listar	\N	controlador.php?acao=siscom_grupo_listar	S
100000100	100014906	responder_formulario_ouvidoria	\N	controlador.php?acao=responder_formulario_ouvidoria	S
100000100	100014907	gerar_estatisticas_ouvidoria	\N	controlador.php?acao=gerar_estatisticas_ouvidoria	S
100000100	100014908	procedimento_reencaminhar_ouvidoria	\N	controlador.php?acao=procedimento_reencaminhar_ouvidoria	S
100000100	100014909	rel_bloco_unidade_alterar	\N	controlador.php?acao=rel_bloco_unidade_alterar	S
100000100	100014910	base_conhecimento_cancelar_liberacao	\N	controlador.php?acao=base_conhecimento_cancelar_liberacao	S
100000100	100014911	base_conhecimento_download_anexo	\N	controlador.php?acao=base_conhecimento_download_anexo	S
100000100	100014912	base_conhecimento_liberar	\N	controlador.php?acao=base_conhecimento_liberar	S
100000100	100014913	base_conhecimento_nova_versao	\N	controlador.php?acao=base_conhecimento_nova_versao	S
100000100	100014914	base_conhecimento_pesquisar	\N	controlador.php?acao=base_conhecimento_pesquisar	S
100000100	100014915	base_conhecimento_selecionar	\N	controlador.php?acao=base_conhecimento_selecionar	S
100000100	100014916	base_conhecimento_upload_anexo	\N	controlador.php?acao=base_conhecimento_upload_anexo	S
100000100	100014917	base_conhecimento_versoes	\N	controlador.php?acao=base_conhecimento_versoes	S
100000100	100014918	base_conhecimento_visualizar	\N	controlador.php?acao=base_conhecimento_visualizar	S
100000100	100014919	arquivamento_receber	\N	controlador.php?acao=arquivamento_receber	S
100000100	100014920	arquivamento_cancelar_recebimento	\N	controlador.php?acao=arquivamento_cancelar_recebimento	S
100000100	100014923	arquivamento_solicitar_desarquivamento	\N	controlador.php?acao=arquivamento_solicitar_desarquivamento	S
100000100	100014924	arquivamento_cancelar_solicitacao_desarquivamento	\N	controlador.php?acao=arquivamento_cancelar_solicitacao_desarquivamento	S
100000100	100014925	arquivamento_listar	\N	controlador.php?acao=arquivamento_listar	S
100000100	100014926	arquivamento_desarquivamento_listar	\N	controlador.php?acao=arquivamento_desarquivamento_listar	S
100000100	100014927	rel_base_conhec_tipo_proced_cadastrar	\N	controlador.php?acao=rel_base_conhec_tipo_proced_cadastrar	S
100000100	100014928	rel_base_conhec_tipo_proced_listar	\N	controlador.php?acao=rel_base_conhec_tipo_proced_listar	S
100000100	100014929	rel_base_conhec_tipo_proced_excluir	\N	controlador.php?acao=rel_base_conhec_tipo_proced_excluir	S
100000100	100014930	base_conhecimento_listar_associadas	\N	controlador.php?acao=base_conhecimento_listar_associadas	S
100000100	100014931	acompanhamento_cadastrar	\N	controlador.php?acao=acompanhamento_cadastrar	S
100000100	100014932	acompanhamento_alterar	\N	controlador.php?acao=acompanhamento_alterar	S
100000100	100014933	acompanhamento_consultar	\N	controlador.php?acao=acompanhamento_consultar	S
100000100	100014934	acompanhamento_listar	\N	controlador.php?acao=acompanhamento_listar	S
100000100	100014935	acompanhamento_excluir	\N	controlador.php?acao=acompanhamento_excluir	S
100000100	100014936	grupo_acompanhamento_cadastrar	\N	controlador.php?acao=grupo_acompanhamento_cadastrar	S
100000100	100014937	grupo_acompanhamento_alterar	\N	controlador.php?acao=grupo_acompanhamento_alterar	S
100000100	100014938	grupo_acompanhamento_consultar	\N	controlador.php?acao=grupo_acompanhamento_consultar	S
100000100	100014939	grupo_acompanhamento_listar	\N	controlador.php?acao=grupo_acompanhamento_listar	S
100000100	100014940	grupo_acompanhamento_excluir	\N	controlador.php?acao=grupo_acompanhamento_excluir	S
100000100	100014941	atividade_enviar	\N	controlador.php?acao=atividade_enviar	S
100000100	100014942	atividade_gerar	\N	controlador.php?acao=atividade_gerar	S
100000100	100014947	gerar_estatisticas_unidade	\N	controlador.php?acao=gerar_estatisticas_unidade	S
100000100	100014948	estatisticas_detalhar_unidade	\N	controlador.php?acao=estatisticas_detalhar_unidade	S
100000100	100014949	estatisticas_detalhar_ouvidoria	\N	controlador.php?acao=estatisticas_detalhar_ouvidoria	S
100000100	100014951	contato_substituir_temporario	\N	controlador.php?acao=contato_substituir_temporario	S
100000100	100014952	grupo_email_cadastrar	\N	controlador.php?acao=grupo_email_cadastrar	S
100000100	100014953	grupo_email_alterar	\N	controlador.php?acao=grupo_email_alterar	S
100000100	100014954	grupo_email_consultar	\N	controlador.php?acao=grupo_email_consultar	S
100000100	100014955	grupo_email_listar	\N	controlador.php?acao=grupo_email_listar	S
100000100	100014956	grupo_email_selecionar	\N	controlador.php?acao=grupo_email_selecionar	S
100000100	100014957	grupo_email_excluir	\N	controlador.php?acao=grupo_email_excluir	S
100000100	100014963	orgao_selecionar	\N	controlador.php?acao=orgao_selecionar	S
100000100	100014964	controle_interno_cadastrar	\N	controlador.php?acao=controle_interno_cadastrar	S
100000100	100014965	controle_interno_alterar	\N	controlador.php?acao=controle_interno_alterar	S
100000100	100014966	controle_interno_consultar	\N	controlador.php?acao=controle_interno_consultar	S
100000100	100014967	controle_interno_listar	\N	controlador.php?acao=controle_interno_listar	S
100000100	100014968	controle_interno_excluir	\N	controlador.php?acao=controle_interno_excluir	S
100000100	100014969	rel_controle_interno_orgao_cadastrar	\N	controlador.php?acao=rel_controle_interno_orgao_cadastrar	S
100000100	100014970	rel_controle_interno_orgao_listar	\N	controlador.php?acao=rel_controle_interno_orgao_listar	S
100000100	100014971	rel_controle_interno_orgao_excluir	\N	controlador.php?acao=rel_controle_interno_orgao_excluir	S
100000100	100014972	rel_controle_interno_serie_cadastrar	\N	controlador.php?acao=rel_controle_interno_serie_cadastrar	S
100000100	100014973	rel_controle_interno_serie_listar	\N	controlador.php?acao=rel_controle_interno_serie_listar	S
100000100	100014974	rel_controle_interno_serie_excluir	\N	controlador.php?acao=rel_controle_interno_serie_excluir	S
100000100	100014975	rel_controle_interno_unidade_cadastrar	\N	controlador.php?acao=rel_controle_interno_unidade_cadastrar	S
100000100	100014976	rel_controle_interno_unidade_listar	\N	controlador.php?acao=rel_controle_interno_unidade_listar	S
100000100	100014977	rel_controle_interno_unidade_excluir	\N	controlador.php?acao=rel_controle_interno_unidade_excluir	S
100000100	100014978	bloco_escolher	\N	controlador.php?acao=bloco_escolher	S
100000100	100014979	procedimento_atribuicao_cadastrar	\N	controlador.php?acao=procedimento_atribuicao_cadastrar	S
100000100	100014980	procedimento_atribuicao_listar	\N	controlador.php?acao=procedimento_atribuicao_listar	S
100000100	100014981	procedimento_atribuicao_alterar	\N	controlador.php?acao=procedimento_atribuicao_alterar	S
100000100	100014982	bloco_reabrir	\N	controlador.php?acao=bloco_reabrir	S
100000100	100014984	nivel_acesso_permitido_cadastrar	\N	controlador.php?acao=nivel_acesso_permitido_cadastrar	S
100000100	100014985	nivel_acesso_permitido_listar	\N	controlador.php?acao=nivel_acesso_permitido_listar	S
100000100	100014986	nivel_acesso_permitido_excluir	\N	controlador.php?acao=nivel_acesso_permitido_excluir	S
100000100	100014987	acesso_cadastrar	\N	controlador.php?acao=acesso_cadastrar	S
100000100	100014988	acesso_listar	\N	controlador.php?acao=acesso_listar	S
100000100	100014989	acesso_excluir	\N	controlador.php?acao=acesso_excluir	S
100000100	100014991	procedimento_credencial_conceder	\N	controlador.php?acao=procedimento_credencial_conceder	S
100000100	100014992	procedimento_credencial_listar	\N	controlador.php?acao=procedimento_credencial_listar	S
100000100	100014993	procedimento_credencial_transferir	\N	controlador.php?acao=procedimento_credencial_transferir	S
100000100	100014994	indexacao_protocolo_cadastrar	\N	controlador.php?acao=indexacao_protocolo_cadastrar	S
100000100	100014995	indexacao_protocolo_alterar	\N	controlador.php?acao=indexacao_protocolo_alterar	S
100000100	100014996	indexacao_protocolo_listar	\N	controlador.php?acao=indexacao_protocolo_listar	S
100000100	100014997	indexacao_protocolo_excluir	\N	controlador.php?acao=indexacao_protocolo_excluir	S
100000100	100014998	indexacao_base_conhecimento_cadastrar	\N	controlador.php?acao=indexacao_base_conhecimento_cadastrar	S
100000100	100014999	indexacao_base_conhecimento_alterar	\N	controlador.php?acao=indexacao_base_conhecimento_alterar	S
100000100	100015000	indexacao_base_conhecimento_listar	\N	controlador.php?acao=indexacao_base_conhecimento_listar	S
100000100	100015001	indexacao_base_conhecimento_excluir	\N	controlador.php?acao=indexacao_base_conhecimento_excluir	S
100000100	100015007	procedimento_credencial_gerenciar	\N	controlador.php?acao=procedimento_credencial_gerenciar	S
100000100	100015008	procedimento_credencial_cassar	\N	controlador.php?acao=procedimento_credencial_cassar	S
100000100	100015009	procedimento_receber	\N	controlador.php?acao=procedimento_receber	S
100000100	100015010	procedimento_ciencia	\N	controlador.php?acao=procedimento_ciencia	S
100000100	100015011	documento_ciencia	\N	controlador.php?acao=documento_ciencia	S
100000100	100015012	protocolo_ciencia_listar	\N	controlador.php?acao=protocolo_ciencia_listar	S
100000100	100015014	credencial_assinatura_conceder	\N	controlador.php?acao=credencial_assinatura_conceder	S
100000100	100015015	credencial_assinatura_cassar	\N	controlador.php?acao=credencial_assinatura_cassar	S
100000100	100015016	credencial_assinatura_gerenciar	\N	controlador.php?acao=credencial_assinatura_gerenciar	S
100000100	100015017	serie_escolha_cadastrar	\N	controlador.php?acao=serie_escolha_cadastrar	S
100000100	100015018	serie_escolha_listar	\N	controlador.php?acao=serie_escolha_listar	S
100000100	100015019	serie_escolha_excluir	\N	controlador.php?acao=serie_escolha_excluir	S
100000100	100015020	tipo_procedimento_escolha_cadastrar	\N	controlador.php?acao=tipo_procedimento_escolha_cadastrar	S
100000100	100015021	tipo_procedimento_escolha_listar	\N	controlador.php?acao=tipo_procedimento_escolha_listar	S
100000100	100015022	tipo_procedimento_escolha_excluir	\N	controlador.php?acao=tipo_procedimento_escolha_excluir	S
100000100	100015023	procedimento_credencial_renunciar	\N	controlador.php?acao=procedimento_credencial_renunciar	S
100000100	100015024	servico_cadastrar	\N	controlador.php?acao=servico_cadastrar	S
100000100	100015025	servico_alterar	\N	controlador.php?acao=servico_alterar	S
100000100	100015026	servico_consultar	\N	controlador.php?acao=servico_consultar	S
100000100	100015027	servico_excluir	\N	controlador.php?acao=servico_excluir	S
100000100	100015028	servico_listar	\N	controlador.php?acao=servico_listar	S
100000100	100015029	servico_desativar	\N	controlador.php?acao=servico_desativar	S
100000100	100015030	servico_reativar	\N	controlador.php?acao=servico_reativar	S
100000100	100015031	operacao_servico_cadastrar	\N	controlador.php?acao=operacao_servico_cadastrar	S
100000100	100015032	operacao_servico_alterar	\N	controlador.php?acao=operacao_servico_alterar	S
100000100	100015033	operacao_servico_consultar	\N	controlador.php?acao=operacao_servico_consultar	S
100000100	100015034	operacao_servico_listar	\N	controlador.php?acao=operacao_servico_listar	S
100000100	100015035	operacao_servico_excluir	\N	controlador.php?acao=operacao_servico_excluir	S
100000100	100015036	usuario_sistema_cadastrar	\N	controlador.php?acao=usuario_sistema_cadastrar	S
100000100	100015037	usuario_sistema_alterar	\N	controlador.php?acao=usuario_sistema_alterar	S
100000100	100015038	usuario_sistema_consultar	\N	controlador.php?acao=usuario_sistema_consultar	S
100000100	100015039	usuario_sistema_listar	\N	controlador.php?acao=usuario_sistema_listar	S
100000100	100015040	usuario_sistema_excluir	\N	controlador.php?acao=usuario_sistema_excluir	S
100000100	100015041	usuario_sistema_desativar	\N	controlador.php?acao=usuario_sistema_desativar	S
100000100	100015042	usuario_sistema_reativar	\N	controlador.php?acao=usuario_sistema_reativar	S
100000100	100015044	modelo_alterar	\N	controlador.php?acao=modelo_alterar	S
100000100	100015045	modelo_consultar	\N	controlador.php?acao=modelo_consultar	S
100000100	100015046	modelo_selecionar	\N	controlador.php?acao=modelo_selecionar	S
100000100	100015047	modelo_listar	\N	controlador.php?acao=modelo_listar	S
100000100	100015048	modelo_excluir	\N	controlador.php?acao=modelo_excluir	S
100000100	100015049	modelo_desativar	\N	controlador.php?acao=modelo_desativar	S
100000100	100015050	modelo_reativar	\N	controlador.php?acao=modelo_reativar	S
100000100	100015051	modelo_clonar	\N	controlador.php?acao=modelo_clonar	S
100000100	100015052	estilo_cadastrar	\N	controlador.php?acao=estilo_cadastrar	S
100000100	100015053	estilo_alterar	\N	controlador.php?acao=estilo_alterar	S
100000100	100015054	estilo_consultar	\N	controlador.php?acao=estilo_consultar	S
100000100	100015055	estilo_selecionar	\N	controlador.php?acao=estilo_selecionar	S
100000100	100015056	estilo_listar	\N	controlador.php?acao=estilo_listar	S
100000100	100015057	estilo_excluir	\N	controlador.php?acao=estilo_excluir	S
100000100	100015058	secao_modelo_cadastrar	\N	controlador.php?acao=secao_modelo_cadastrar	S
100000100	100015059	secao_modelo_alterar	\N	controlador.php?acao=secao_modelo_alterar	S
100000100	100015060	secao_modelo_consultar	\N	controlador.php?acao=secao_modelo_consultar	S
100000100	100015061	secao_modelo_selecionar	\N	controlador.php?acao=secao_modelo_selecionar	S
100000100	100015062	secao_modelo_listar	\N	controlador.php?acao=secao_modelo_listar	S
100000100	100015063	secao_modelo_excluir	\N	controlador.php?acao=secao_modelo_excluir	S
100000100	100015064	rel_secao_modelo_estilo_cadastrar	\N	controlador.php?acao=rel_secao_modelo_estilo_cadastrar	S
100000100	100015065	rel_secao_modelo_estilo_alterar	\N	controlador.php?acao=rel_secao_modelo_estilo_alterar	S
100000100	100015066	rel_secao_modelo_estilo_consultar	\N	controlador.php?acao=rel_secao_modelo_estilo_consultar	S
100000100	100015067	rel_secao_modelo_estilo_selecionar	\N	controlador.php?acao=rel_secao_modelo_estilo_selecionar	S
100000100	100015068	rel_secao_modelo_estilo_listar	\N	controlador.php?acao=rel_secao_modelo_estilo_listar	S
100000100	100015069	rel_secao_modelo_estilo_excluir	\N	controlador.php?acao=rel_secao_modelo_estilo_excluir	S
100000100	100015070	secao_documento_cadastrar	\N	controlador.php?acao=secao_documento_cadastrar	S
100000100	100015071	secao_documento_alterar	\N	controlador.php?acao=secao_documento_alterar	S
100000100	100015072	secao_documento_consultar	\N	controlador.php?acao=secao_documento_consultar	S
100000100	100015073	secao_documento_listar	\N	controlador.php?acao=secao_documento_listar	S
100000100	100015074	secao_documento_excluir	\N	controlador.php?acao=secao_documento_excluir	S
100000100	100015075	versao_secao_documento_cadastrar	\N	controlador.php?acao=versao_secao_documento_cadastrar	S
100000100	100015076	versao_secao_documento_alterar	\N	controlador.php?acao=versao_secao_documento_alterar	S
100000100	100015077	versao_secao_documento_consultar	\N	controlador.php?acao=versao_secao_documento_consultar	S
100000100	100015078	versao_secao_documento_listar	\N	controlador.php?acao=versao_secao_documento_listar	S
100000100	100015079	versao_secao_documento_excluir	\N	controlador.php?acao=versao_secao_documento_excluir	S
100000100	100015080	editor_montar	\N	controlador.php?acao=editor_montar	S
100000100	100015081	editor_salvar	\N	controlador.php?acao=editor_salvar	S
100000100	100015082	editor_visualizar_codigo_fonte	\N	controlador.php?acao=editor_visualizar_codigo_fonte	S
100000100	100015083	documento_visualizar_conteudo_assinatura	\N	controlador.php?acao=documento_visualizar_conteudo_assinatura	S
100000100	100015084	tarja_assinatura_consultar	\N	controlador.php?acao=tarja_assinatura_consultar	S
100000100	100015085	tarja_assinatura_alterar	\N	controlador.php?acao=tarja_assinatura_alterar	S
100000100	100015086	tarja_assinatura_upload	\N	controlador.php?acao=tarja_assinatura_upload	S
100000100	100015087	tarja_assinatura_listar	\N	controlador.php?acao=tarja_assinatura_listar	S
100000100	100015088	unidade_selecionar_envio_processo	\N	controlador.php?acao=unidade_selecionar_envio_processo	S
100000100	100015089	arquivo_extensao_cadastrar	\N	controlador.php?acao=arquivo_extensao_cadastrar	S
100000100	100015090	arquivo_extensao_alterar	\N	controlador.php?acao=arquivo_extensao_alterar	S
100000100	100015091	arquivo_extensao_consultar	\N	controlador.php?acao=arquivo_extensao_consultar	S
100000100	100015092	arquivo_extensao_listar	\N	controlador.php?acao=arquivo_extensao_listar	S
100000100	100015093	arquivo_extensao_excluir	\N	controlador.php?acao=arquivo_extensao_excluir	S
100000100	100015094	arquivo_extensao_desativar	\N	controlador.php?acao=arquivo_extensao_desativar	S
100000100	100015095	arquivo_extensao_reativar	\N	controlador.php?acao=arquivo_extensao_reativar	S
100000100	100015096	pais_cadastrar	\N	controlador.php?acao=pais_cadastrar	S
100000100	100015097	pais_alterar	\N	controlador.php?acao=pais_alterar	S
100000100	100015098	pais_consultar	\N	controlador.php?acao=pais_consultar	S
100000100	100015099	pais_selecionar	\N	controlador.php?acao=pais_selecionar	S
100000100	100015100	pais_listar	\N	controlador.php?acao=pais_listar	S
100000100	100015101	pais_excluir	\N	controlador.php?acao=pais_excluir	S
100000100	100015102	grupo_email_institucional_cadastrar	\N	controlador.php?acao=grupo_email_institucional_cadastrar	S
100000100	100015103	grupo_email_institucional_alterar	\N	controlador.php?acao=grupo_email_institucional_alterar	S
100000100	100015104	grupo_email_institucional_consultar	\N	controlador.php?acao=grupo_email_institucional_consultar	S
100000100	100015105	grupo_email_institucional_selecionar	\N	controlador.php?acao=grupo_email_institucional_selecionar	S
100000100	100015106	grupo_email_institucional_listar	\N	controlador.php?acao=grupo_email_institucional_listar	S
100000100	100015107	grupo_email_institucional_excluir	\N	controlador.php?acao=grupo_email_institucional_excluir	S
100000100	100015108	grupo_email_institucional_desativar	\N	controlador.php?acao=grupo_email_institucional_desativar	S
100000100	100015109	grupo_email_institucional_reativar	\N	controlador.php?acao=grupo_email_institucional_reativar	S
100000100	100015110	numeracao_cadastrar	\N	controlador.php?acao=numeracao_cadastrar	S
100000100	100015111	numeracao_alterar	\N	controlador.php?acao=numeracao_alterar	S
100000100	100015112	numeracao_consultar	\N	controlador.php?acao=numeracao_consultar	S
100000100	100015113	numeracao_listar	\N	controlador.php?acao=numeracao_listar	S
100000100	100015114	numeracao_excluir	\N	controlador.php?acao=numeracao_excluir	S
100000100	100015115	numeracao_ajustar	\N	controlador.php?acao=numeracao_ajustar	S
100000100	100015116	arquivamento_pesquisar	\N	controlador.php?acao=arquivamento_pesquisar	S
100000100	100015117	procedimento_historico_total	\N	controlador.php?acao=procedimento_historico_total	S
100000100	100015119	usuario_externo_cadastrar	\N	controlador.php?acao=usuario_externo_cadastrar	S
100000100	100015120	usuario_externo_alterar	\N	controlador.php?acao=usuario_externo_alterar	S
100000100	100015121	usuario_externo_consultar	\N	controlador.php?acao=usuario_externo_consultar	S
100000100	100015122	usuario_externo_listar	\N	controlador.php?acao=usuario_externo_listar	S
100000100	100015123	usuario_externo_excluir	\N	controlador.php?acao=usuario_externo_excluir	S
100000100	100015124	usuario_externo_desativar	\N	controlador.php?acao=usuario_externo_desativar	S
100000100	100015125	usuario_externo_reativar	\N	controlador.php?acao=usuario_externo_reativar	S
100000100	100015126	acesso_externo_gerenciar	\N	controlador.php?acao=acesso_externo_gerenciar	S
100000100	100015127	acesso_externo_disponibilizar	\N	controlador.php?acao=acesso_externo_disponibilizar	S
100000100	100015128	acesso_externo_cancelar	\N	controlador.php?acao=acesso_externo_cancelar	S
100000100	100015129	assinatura_externa_gerenciar	\N	controlador.php?acao=assinatura_externa_gerenciar	S
100000100	100015130	assinatura_externa_liberar	\N	controlador.php?acao=assinatura_externa_liberar	S
100000100	100015131	assinatura_externa_cancelar	\N	controlador.php?acao=assinatura_externa_cancelar	S
100000100	100015132	atividade_alterar	\N	controlador.php?acao=atividade_alterar	S
100000100	100015133	orgao_upload	\N	controlador.php?acao=orgao_upload	S
100000100	100015134	rel_controle_interno_tipo_proc_cadastrar	\N	controlador.php?acao=rel_controle_interno_tipo_proc_cadastrar	S
100000100	100015135	rel_controle_interno_tipo_proc_excluir	\N	controlador.php?acao=rel_controle_interno_tipo_proc_excluir	S
100000100	100015136	rel_controle_interno_tipo_proc_listar	\N	controlador.php?acao=rel_controle_interno_tipo_proc_listar	S
100000100	100015137	inspecao_administrativa_gerar	\N	controlador.php?acao=inspecao_administrativa_gerar	S
100000100	100015138	inspecao_administrativa_detalhar	\N	controlador.php?acao=inspecao_administrativa_detalhar	S
100000100	100015139	inspecao_administrativa_geral	\N	controlador.php?acao=inspecao_administrativa_geral	S
100000100	100015140	inspecao_administrativa_orgao	\N	controlador.php?acao=inspecao_administrativa_orgao	S
100000100	100015141	estatisticas_cadastrar	\N	controlador.php?acao=estatisticas_cadastrar	S
100000100	100015142	estatisticas_consultar	\N	controlador.php?acao=estatisticas_consultar	S
100000100	100015143	estatisticas_listar	\N	controlador.php?acao=estatisticas_listar	S
100000100	100015144	estatisticas_excluir	\N	controlador.php?acao=estatisticas_excluir	S
100000100	100015145	procedimento_gerar_pdf	\N	controlador.php?acao=procedimento_gerar_pdf	S
100000100	100015146	exibir_arquivo	\N	controlador.php?acao=exibir_arquivo	S
100000100	100015147	documento_versao_listar	\N	controlador.php?acao=documento_versao_listar	S
100000100	100015148	documento_versao_recuperar	\N	controlador.php?acao=documento_versao_recuperar	S
100000100	100015149	grupo_protocolo_modelo_alterar	\N	controlador.php?acao=grupo_protocolo_modelo_alterar	S
100000100	100015150	grupo_protocolo_modelo_cadastrar	\N	controlador.php?acao=grupo_protocolo_modelo_cadastrar	S
100000100	100015151	grupo_protocolo_modelo_consultar	\N	controlador.php?acao=grupo_protocolo_modelo_consultar	S
100000100	100015152	grupo_protocolo_modelo_excluir	\N	controlador.php?acao=grupo_protocolo_modelo_excluir	S
100000100	100015153	grupo_protocolo_modelo_listar	\N	controlador.php?acao=grupo_protocolo_modelo_listar	S
100000100	100015154	protocolo_modelo_alterar	\N	controlador.php?acao=protocolo_modelo_alterar	S
100000100	100015155	protocolo_modelo_cadastrar	\N	controlador.php?acao=protocolo_modelo_cadastrar	S
100000100	100015156	protocolo_modelo_consultar	\N	controlador.php?acao=protocolo_modelo_consultar	S
100000100	100015157	protocolo_modelo_excluir	\N	controlador.php?acao=protocolo_modelo_excluir	S
100000100	100015158	documento_modelo_selecionar	\N	controlador.php?acao=documento_modelo_selecionar	S
100000100	100015159	protocolo_modelo_listar	\N	controlador.php?acao=protocolo_modelo_listar	S
100000100	100015160	infra_navegador_listar	\N	controlador.php?acao=infra_navegador_listar	S
100000100	100015161	texto_padrao_interno_alterar	\N	controlador.php?acao=texto_padrao_interno_alterar	S
100000100	100015162	texto_padrao_interno_cadastrar	\N	controlador.php?acao=texto_padrao_interno_cadastrar	S
100000100	100015163	texto_padrao_interno_consultar	\N	controlador.php?acao=texto_padrao_interno_consultar	S
100000100	100015164	texto_padrao_interno_excluir	\N	controlador.php?acao=texto_padrao_interno_excluir	S
100000100	100015165	texto_padrao_interno_selecionar	\N	controlador.php?acao=texto_padrao_interno_selecionar	S
100000100	100015166	texto_padrao_interno_listar	\N	controlador.php?acao=texto_padrao_interno_listar	S
100000100	100015169	indexar	\N	controlador.php?acao=indexar	S
100000100	100015170	email_sistema_consultar	\N	controlador.php?acao=email_sistema_consultar	S
100000100	100015171	email_sistema_alterar	\N	controlador.php?acao=email_sistema_alterar	S
100000100	100015172	email_sistema_listar	\N	controlador.php?acao=email_sistema_listar	S
100000100	100015211	usuario_externo_logar	\N	controlador_externo.php?acao=usuario_externo_logar	S
100000100	100015212	usuario_externo_enviar_cadastro	\N	controlador_externo.php?acao=usuario_externo_enviar_cadastro	S
100000100	100015213	usuario_externo_alterar_senha	\N	controlador_externo.php?acao=usuario_externo_alterar_senha	S
100000100	100015214	usuario_externo_sair	\N	controlador_externo.php?acao=usuario_externo_sair	S
100000100	100015215	usuario_externo_gerar_senha	\N	controlador_externo.php?acao=usuario_externo_gerar_senha	S
100000100	100015216	processo_consulta_externa	\N	controlador_externo.php?acao=processo_consulta_externa	S
100000100	100015217	documento_consulta_externa	\N	controlador_externo.php?acao=documento_consulta_externa	S
100000100	100015218	acesso_externo_excluir	\N	controlador.php?acao=acesso_externo_excluir	S
100000100	100015219	procedimento_visualizar	\N	controlador.php?acao=procedimento_visualizar	S
100000100	100015220	infra_regra_auditoria_cadastrar	\N	controlador.php?acao=infra_regra_auditoria_cadastrar	S
100000100	100015222	infra_regra_auditoria_consultar	\N	controlador.php?acao=infra_regra_auditoria_consultar	S
100000100	100015223	infra_regra_auditoria_listar	\N	controlador.php?acao=infra_regra_auditoria_listar	S
100000100	100015227	infra_regra_auditoria_recurso_cadastrar	\N	controlador.php?acao=infra_regra_auditoria_recurso_cadastrar	S
100000100	100015228	infra_regra_auditoria_recurso_listar	\N	controlador.php?acao=infra_regra_auditoria_recurso_listar	S
100000100	100015230	auditoria_protocolo_cadastrar	\N	controlador.php?acao=auditoria_protocolo_cadastrar	S
100000100	100015231	auditoria_protocolo_consultar	\N	controlador.php?acao=auditoria_protocolo_consultar	S
100000100	100015232	auditoria_protocolo_listar	\N	controlador.php?acao=auditoria_protocolo_listar	S
100000100	100015233	auditoria_protocolo_excluir	\N	controlador.php?acao=auditoria_protocolo_excluir	S
100000100	100015234	infra_auditoria_cadastrar	\N	controlador.php?acao=infra_auditoria_cadastrar	S
100000100	100015235	infra_auditoria_listar	\N	controlador.php?acao=infra_auditoria_listar	S
100000100	100015236	infra_agendamento_tarefa_cadastrar	\N	controlador.php?acao=infra_agendamento_tarefa_cadastrar	S
100000100	100015237	infra_agendamento_tarefa_alterar	\N	controlador.php?acao=infra_agendamento_tarefa_alterar	S
100000100	100015238	infra_agendamento_tarefa_consultar	\N	controlador.php?acao=infra_agendamento_tarefa_consultar	S
100000100	100015239	infra_agendamento_tarefa_listar	\N	controlador.php?acao=infra_agendamento_tarefa_listar	S
100000100	100015240	infra_agendamento_tarefa_excluir	\N	controlador.php?acao=infra_agendamento_tarefa_excluir	S
100000100	100015241	infra_agendamento_tarefa_executar	\N	controlador.php?acao=infra_agendamento_tarefa_executar	S
100000100	100015242	infra_agendamento_tarefa_desativar	\N	controlador.php?acao=infra_agendamento_tarefa_desativar	S
100000100	100015243	infra_agendamento_tarefa_reativar	\N	controlador.php?acao=infra_agendamento_tarefa_reativar	S
100000100	100015244	infra_banco_comparar	\N	controlador.php?acao=infra_banco_comparar	S
100000100	100015246	conjunto_estilos_cadastrar	\N	controlador.php?acao=conjunto_estilos_cadastrar	S
100000100	100015247	conjunto_estilos_alterar	\N	controlador.php?acao=conjunto_estilos_alterar	S
100000100	100015248	conjunto_estilos_consultar	\N	controlador.php?acao=conjunto_estilos_consultar	S
100000100	100015249	conjunto_estilos_listar	\N	controlador.php?acao=conjunto_estilos_listar	S
100000100	100015250	conjunto_estilos_item_cadastrar	\N	controlador.php?acao=conjunto_estilos_item_cadastrar	S
100000100	100015251	conjunto_estilos_item_alterar	\N	controlador.php?acao=conjunto_estilos_item_alterar	S
100000100	100015252	conjunto_estilos_item_consultar	\N	controlador.php?acao=conjunto_estilos_item_consultar	S
100000100	100015253	conjunto_estilos_item_listar	\N	controlador.php?acao=conjunto_estilos_item_listar	S
100000100	100015254	pesquisa_solr_ajuda	\N	controlador.php?acao=pesquisa_solr_ajuda	S
100000100	100015267	procedimento_paginar	\N	controlador.php?acao=procedimento_paginar	S
100000100	100015268	tarefa_consultar	\N	controlador.php?acao=tarefa_consultar	S
100000100	100015269	tarefa_listar	\N	controlador.php?acao=tarefa_listar	S
100000100	100015271	tarefa_configurar_historico	\N	controlador.php?acao=tarefa_configurar_historico	S
100000100	100015272	procedimento_finalizar_ouvidoria	\N	controlador.php?acao=procedimento_finalizar_ouvidoria	S
100000100	100015273	acompanhamento_listar_ouvidoria	\N	controlador.php?acao=acompanhamento_listar_ouvidoria	S
100000100	100015274	acompanhamento_gerar_grafico_ouvidoria	\N	controlador.php?acao=acompanhamento_gerar_grafico_ouvidoria	S
100000100	100015275	acompanhamento_detalhar_ouvidoria	\N	controlador.php?acao=acompanhamento_detalhar_ouvidoria	S
100000100	100015276	alerta_cadastrar	\N	controlador.php?acao=alerta_cadastrar	S
100000100	100015277	alerta_alterar	\N	controlador.php?acao=alerta_alterar	S
100000100	100015278	alerta_consultar	\N	controlador.php?acao=alerta_consultar	S
100000100	100015279	alerta_listar	\N	controlador.php?acao=alerta_listar	S
100000100	100015280	alerta_excluir	\N	controlador.php?acao=alerta_excluir	S
100000100	100015281	rel_serie_veiculo_publicacao_consultar	\N	controlador.php?acao=rel_serie_veiculo_publicacao_consultar	S
100000100	100015282	rel_serie_veiculo_publicacao_listar	\N	controlador.php?acao=rel_serie_veiculo_publicacao_listar	S
100000100	100015283	rel_serie_veiculo_publicacao_cadastrar	\N	controlador.php?acao=rel_serie_veiculo_publicacao_cadastrar	S
100000100	100015284	rel_serie_veiculo_publicacao_excluir	\N	controlador.php?acao=rel_serie_veiculo_publicacao_excluir	S
100000100	100015285	feriado_cadastrar	\N	controlador.php?acao=feriado_cadastrar	S
100000100	100015286	feriado_alterar	\N	controlador.php?acao=feriado_alterar	S
100000100	100015287	feriado_excluir	\N	controlador.php?acao=feriado_excluir	S
100000100	100015288	feriado_consultar	\N	controlador.php?acao=feriado_consultar	S
100000100	100015289	feriado_listar	\N	controlador.php?acao=feriado_listar	S
100000100	100015290	veiculo_publicacao_cadastrar	\N	controlador.php?acao=veiculo_publicacao_cadastrar	S
100000100	100015291	veiculo_publicacao_listar	\N	controlador.php?acao=veiculo_publicacao_listar	S
100000100	100015292	veiculo_publicacao_alterar	\N	controlador.php?acao=veiculo_publicacao_alterar	S
100000100	100015293	veiculo_publicacao_excluir	\N	controlador.php?acao=veiculo_publicacao_excluir	S
100000100	100015294	veiculo_publicacao_desativar	\N	controlador.php?acao=veiculo_publicacao_desativar	S
100000100	100015295	veiculo_publicacao_reativar	\N	controlador.php?acao=veiculo_publicacao_reativar	S
100000100	100015296	veiculo_publicacao_consultar	\N	controlador.php?acao=veiculo_publicacao_consultar	S
100000100	100015297	veiculo_publicacao_selecionar	\N	controlador.php?acao=veiculo_publicacao_selecionar	S
100000100	100015298	veiculo_imprensa_nacional_cadastrar	\N	controlador.php?acao=veiculo_imprensa_nacional_cadastrar	S
100000100	100015299	veiculo_imprensa_nacional_alterar	\N	controlador.php?acao=veiculo_imprensa_nacional_alterar	S
100000100	100015300	veiculo_imprensa_nacional_excluir	\N	controlador.php?acao=veiculo_imprensa_nacional_excluir	S
100000100	100015301	veiculo_imprensa_nacional_consultar	\N	controlador.php?acao=veiculo_imprensa_nacional_consultar	S
100000100	100015302	veiculo_imprensa_nacional_listar	\N	controlador.php?acao=veiculo_imprensa_nacional_listar	S
100000100	100015303	veiculo_imprensa_nacional_selecionar	\N	controlador.php?acao=veiculo_imprensa_nacional_selecionar	S
100000100	100015304	secao_imprensa_nacional_cadastrar	\N	controlador.php?acao=secao_imprensa_nacional_cadastrar	S
100000100	100015305	secao_imprensa_nacional_alterar	\N	controlador.php?acao=secao_imprensa_nacional_alterar	S
100000100	100015306	secao_imprensa_nacional_excluir	\N	controlador.php?acao=secao_imprensa_nacional_excluir	S
100000100	100015307	secao_imprensa_nacional_consultar	\N	controlador.php?acao=secao_imprensa_nacional_consultar	S
100000100	100015308	secao_imprensa_nacional_listar	\N	controlador.php?acao=secao_imprensa_nacional_listar	S
100000100	100015309	secao_imprensa_nacional_selecionar	\N	controlador.php?acao=secao_imprensa_nacional_selecionar	S
100000100	100015318	publicacao_legado_consultar	\N	controlador.php?acao=publicacao_legado_consultar	S
100000100	100015319	publicacao_legado_listar	\N	controlador.php?acao=publicacao_legado_listar	S
100000100	100015320	documento_mover	\N	controlador.php?acao=documento_mover	S
100000100	100015321	rel_protocolo_protocolo_alterar	\N	controlador.php?acao=rel_protocolo_protocolo_alterar	S
100000100	100015322	serie_publicacao_cadastrar	\N	controlador.php?acao=serie_publicacao_cadastrar	S
100000100	100015323	serie_publicacao_consultar	\N	controlador.php?acao=serie_publicacao_consultar	S
100000100	100015324	serie_publicacao_listar	\N	controlador.php?acao=serie_publicacao_listar	S
100000100	100015325	unidade_publicacao_cadastrar	\N	controlador.php?acao=unidade_publicacao_cadastrar	S
100000100	100015326	unidade_publicacao_consultar	\N	controlador.php?acao=unidade_publicacao_consultar	S
100000100	100015327	unidade_publicacao_listar	\N	controlador.php?acao=unidade_publicacao_listar	S
100000100	100015328	procedimento_anexar	\N	controlador.php?acao=procedimento_anexar	S
100000100	100015329	procedimento_desanexar	\N	controlador.php?acao=procedimento_desanexar	S
100000100	100015330	procedimento_listar_anexados	\N	controlador.php?acao=procedimento_listar_anexados	S
100000100	100015331	procedimento_anexado_ciencia	\N	controlador.php?acao=procedimento_anexado_ciencia	S
100000100	100015332	protocolo_visualizar	\N	controlador.php?acao=protocolo_visualizar	S
100000100	100015333	estatisticas_detalhar_desempenho	\N	controlador.php?acao=estatisticas_detalhar_desempenho	S
100000100	100015334	estatisticas_detalhar_desempenho_procedimento	\N	controlador.php?acao=estatisticas_detalhar_desempenho_procedimento	S
100000100	100015335	responder_formulario_corregedoria	\N	controlador.php?acao=responder_formulario_corregedoria	S
100000100	100015336	tarja_assinatura_montar	\N	controlador.php?acao=tarja_assinatura_montar	S
100000100	100015337	email_sistema_desativar	\N	controlador.php?acao=email_sistema_desativar	S
100000100	100015338	email_sistema_reativar	\N	controlador.php?acao=email_sistema_reativar	S
100000100	100015339	indexacao_publicacao_cadastrar	\N	controlador.php?acao=indexacao_publicacao_cadastrar	S
100000100	100015340	indexacao_publicacao_listar	\N	controlador.php?acao=indexacao_publicacao_listar	S
100000100	100015341	indexacao_publicacao_excluir	\N	controlador.php?acao=indexacao_publicacao_excluir	S
100000100	100015342	rel_serie_assunto_cadastrar	\N	controlador.php?acao=rel_serie_assunto_cadastrar	S
100000100	100015343	rel_serie_assunto_excluir	\N	controlador.php?acao=rel_serie_assunto_excluir	S
100000100	100015344	rel_serie_assunto_listar	\N	controlador.php?acao=rel_serie_assunto_listar	S
100000100	100015345	tipo_conferencia_cadastrar	\N	controlador.php?acao=tipo_conferencia_cadastrar	S
100000100	100015346	tipo_conferencia_alterar	\N	controlador.php?acao=tipo_conferencia_alterar	S
100000100	100015347	tipo_conferencia_consultar	\N	controlador.php?acao=tipo_conferencia_consultar	S
100000100	100015348	tipo_conferencia_listar	\N	controlador.php?acao=tipo_conferencia_listar	S
100000100	100015349	tipo_conferencia_excluir	\N	controlador.php?acao=tipo_conferencia_excluir	S
100000100	100015350	tipo_conferencia_desativar	\N	controlador.php?acao=tipo_conferencia_desativar	S
100000100	100015351	tipo_conferencia_reativar	\N	controlador.php?acao=tipo_conferencia_reativar	S
100000100	100015352	gerar_estatisticas_desempenho_processos	\N	controlador.php?acao=gerar_estatisticas_desempenho_processos	S
100000100	100015353	assinatura_verificar	\N	controlador.php?acao=assinatura_verificar	S
100000100	100015354	assinatura_download_p7s	\N	controlador.php?acao=assinatura_download_p7s	S
100000100	100015355	hipotese_legal_cadastrar	\N	controlador.php?acao=hipotese_legal_cadastrar	S
100000100	100015356	hipotese_legal_alterar	\N	controlador.php?acao=hipotese_legal_alterar	S
100000100	100015357	hipotese_legal_consultar	\N	controlador.php?acao=hipotese_legal_consultar	S
100000100	100015358	hipotese_legal_selecionar	\N	controlador.php?acao=hipotese_legal_selecionar	S
100000100	100015359	hipotese_legal_listar	\N	controlador.php?acao=hipotese_legal_listar	S
100000100	100015360	hipotese_legal_excluir	\N	controlador.php?acao=hipotese_legal_excluir	S
100000100	100015361	hipotese_legal_desativar	\N	controlador.php?acao=hipotese_legal_desativar	S
100000100	100015362	hipotese_legal_reativar	\N	controlador.php?acao=hipotese_legal_reativar	S
100000100	100015372	velocidade_transferencia_cadastrar	\N	controlador.php?acao=velocidade_transferencia_cadastrar	S
100000100	100015373	velocidade_transferencia_alterar	\N	controlador.php?acao=velocidade_transferencia_alterar	S
100000100	100015374	velocidade_transferencia_consultar	\N	controlador.php?acao=velocidade_transferencia_consultar	S
100000100	100015375	velocidade_transferencia_excluir	\N	controlador.php?acao=velocidade_transferencia_excluir	S
100000100	100015376	velocidade_transferencia_listar	\N	controlador.php?acao=velocidade_transferencia_listar	S
100000100	100015377	assinatura_digital_ajuda	\N	controlador.php?acao=assinatura_digital_ajuda	S
100000100	100015378	unidade_selecionar_reabertura_processo	\N	controlador.php?acao=unidade_selecionar_reabertura_processo	S
100000100	100015379	editor_imagem_upload	\N	controlador.php?acao=editor_imagem_upload	S
100000100	100015380	imagem_formato_cadastrar	\N	controlador.php?acao=imagem_formato_cadastrar	S
100000100	100015381	imagem_formato_consultar	\N	controlador.php?acao=imagem_formato_consultar	S
100000100	100015382	imagem_formato_listar	\N	controlador.php?acao=imagem_formato_listar	S
100000100	100015383	imagem_formato_alterar	\N	controlador.php?acao=imagem_formato_alterar	S
100000100	100015384	imagem_formato_excluir	\N	controlador.php?acao=imagem_formato_excluir	S
100000100	100015385	imagem_formato_desativar	\N	controlador.php?acao=imagem_formato_desativar	S
100000100	100015386	imagem_formato_reativar	\N	controlador.php?acao=imagem_formato_reativar	S
100000100	100015387	rel_secao_mod_cj_estilos_item_cadastrar	\N	controlador.php?acao=rel_secao_mod_cj_estilos_item_cadastrar	S
100000100	100015388	rel_secao_mod_cj_estilos_item_alterar	\N	controlador.php?acao=rel_secao_mod_cj_estilos_item_alterar	S
100000100	100015389	rel_secao_mod_cj_estilos_item_excluir	\N	controlador.php?acao=rel_secao_mod_cj_estilos_item_excluir	S
100000100	100015390	rel_secao_mod_cj_estilos_item_consultar	\N	controlador.php?acao=rel_secao_mod_cj_estilos_item_consultar	S
100000100	100015391	rel_secao_mod_cj_estilos_item_listar	\N	controlador.php?acao=rel_secao_mod_cj_estilos_item_listar	S
100000100	100015392	secao_modelo_desativar	\N	controlador.php?acao=secao_modelo_desativar	S
100000100	100015393	secao_modelo_reativar	\N	controlador.php?acao=secao_modelo_reativar	S
100000100	100015394	email_utilizado_cadastrar	\N	controlador.php?acao=email_utilizado_cadastrar	S
100000100	100015395	email_utilizado_listar	\N	controlador.php?acao=email_utilizado_listar	S
100000100	100015396	email_utilizado_excluir	\N	controlador.php?acao=email_utilizado_excluir	S
100000100	100015397	procedimento_gerar_zip	\N	controlador.php?acao=procedimento_gerar_zip	S
100000100	100015398	unidade_publicacao_excluir	\N	controlador.php?acao=unidade_publicacao_excluir	S
100000100	100015399	serie_publicacao_excluir	\N	controlador.php?acao=serie_publicacao_excluir	S
100000100	100015400	grupo_unidade_cadastrar	\N	controlador.php?acao=grupo_unidade_cadastrar	S
100000100	100015401	grupo_unidade_alterar	\N	controlador.php?acao=grupo_unidade_alterar	S
100000100	100015402	grupo_unidade_consultar	\N	controlador.php?acao=grupo_unidade_consultar	S
100000100	100015403	grupo_unidade_selecionar	\N	controlador.php?acao=grupo_unidade_selecionar	S
100000100	100015404	grupo_unidade_excluir	\N	controlador.php?acao=grupo_unidade_excluir	S
100000100	100015405	grupo_unidade_listar	\N	controlador.php?acao=grupo_unidade_listar	S
100000100	100015406	rel_grupo_unidade_unidade_cadastrar	\N	controlador.php?acao=rel_grupo_unidade_unidade_cadastrar	S
100000100	100015407	rel_grupo_unidade_unidade_excluir	\N	controlador.php?acao=rel_grupo_unidade_unidade_excluir	S
100000100	100015408	rel_grupo_unidade_unidade_listar	\N	controlador.php?acao=rel_grupo_unidade_unidade_listar	S
100000100	100015409	grupo_unidade_institucional_cadastrar	\N	controlador.php?acao=grupo_unidade_institucional_cadastrar	S
100000100	100015410	grupo_unidade_institucional_consultar	\N	controlador.php?acao=grupo_unidade_institucional_consultar	S
100000100	100015411	grupo_unidade_institucional_listar	\N	controlador.php?acao=grupo_unidade_institucional_listar	S
100000100	100015412	grupo_unidade_institucional_selecionar	\N	controlador.php?acao=grupo_unidade_institucional_selecionar	S
100000100	100015413	grupo_unidade_institucional_alterar	\N	controlador.php?acao=grupo_unidade_institucional_alterar	S
100000100	100015414	grupo_unidade_institucional_excluir	\N	controlador.php?acao=grupo_unidade_institucional_excluir	S
100000100	100015415	grupo_unidade_institucional_desativar	\N	controlador.php?acao=grupo_unidade_institucional_desativar	S
100000100	100015416	grupo_unidade_institucional_reativar	\N	controlador.php?acao=grupo_unidade_institucional_reativar	S
100000100	100015417	unidade_tramitacao_selecionar	\N	controlador.php?acao=unidade_tramitacao_selecionar	S
100000100	100015418	email_encaminhar	\N	controlador.php?acao=email_encaminhar	S
100000100	100015419	procedimento_escolher_tipo_relacionado	\N	controlador.php?acao=procedimento_escolher_tipo_relacionado	S
100000100	100015420	procedimento_gerar_relacionado	\N	controlador.php?acao=procedimento_gerar_relacionado	S
100000100	100015421	responder_formulario	\N	controlador.php?acao=responder_formulario	S
100000100	100015422	documento_gerar_multiplo	\N	controlador.php?acao=documento_gerar_multiplo	S
100000100	100015423	situacao_cadastrar	\N	controlador.php?acao=situacao_cadastrar	S
100000100	100015424	situacao_alterar	\N	controlador.php?acao=situacao_alterar	S
100000100	100015425	situacao_consultar	\N	controlador.php?acao=situacao_consultar	S
100000100	100015426	situacao_listar	\N	controlador.php?acao=situacao_listar	S
100000100	100015427	situacao_desativar	\N	controlador.php?acao=situacao_desativar	S
100000100	100015428	situacao_reativar	\N	controlador.php?acao=situacao_reativar	S
100000100	100015429	situacao_excluir	\N	controlador.php?acao=situacao_excluir	S
100000100	100015430	andamento_situacao_lancar	\N	controlador.php?acao=andamento_situacao_lancar	S
100000100	100015431	andamento_situacao_consultar	\N	controlador.php?acao=andamento_situacao_consultar	S
100000100	100015432	andamento_situacao_listar	\N	controlador.php?acao=andamento_situacao_listar	S
100000100	100015433	andamento_situacao_excluir	\N	controlador.php?acao=andamento_situacao_excluir	S
100000100	100015442	rel_situacao_unidade_cadastrar	\N	controlador.php?acao=rel_situacao_unidade_cadastrar	S
100000100	100015443	rel_situacao_unidade_consultar	\N	controlador.php?acao=rel_situacao_unidade_consultar	S
100000100	100015444	rel_situacao_unidade_listar	\N	controlador.php?acao=rel_situacao_unidade_listar	S
100000100	100015445	rel_situacao_unidade_excluir	\N	controlador.php?acao=rel_situacao_unidade_excluir	S
100000100	100015446	andamento_situacao_gerenciar	\N	controlador.php?acao=andamento_situacao_gerenciar	S
100000100	100015447	controle_unidade_gerar_grafico	\N	controlador.php?acao=controle_unidade_gerar_grafico	S
100000100	100015448	controle_unidade_listar	\N	controlador.php?acao=controle_unidade_listar	S
100000100	100015449	controle_unidade_detalhar	\N	controlador.php?acao=controle_unidade_detalhar	S
100000100	100015450	controle_unidade_gerar	\N	controlador.php?acao=controle_unidade_gerar	S
100000100	100015453	procedimento_credencial_cancelar	\N	controlador.php?acao=procedimento_credencial_cancelar	S
100000100	100015454	procedimento_credencial_ativar	\N	controlador.php?acao=procedimento_credencial_ativar	S
100000100	100015455	procedimento_acervo_sigilosos_unidade	\N	controlador.php?acao=procedimento_acervo_sigilosos_unidade	S
100000100	100015456	modulo_listar	\N	controlador.php?acao=modulo_listar	S
100000100	100015457	infra_atributo_cache_consultar	\N	controlador.php?acao=infra_atributo_cache_consultar	S
100000100	100015458	infra_atributo_cache_excluir	\N	controlador.php?acao=infra_atributo_cache_excluir	S
100000100	100015459	infra_atributo_cache_listar	\N	controlador.php?acao=infra_atributo_cache_listar	S
100000100	100015460	email_utilizado_consultar	\N	controlador.php?acao=email_utilizado_consultar	S
100000100	100015461	nivel_acesso_permitido_consultar	\N	controlador.php?acao=nivel_acesso_permitido_consultar	S
100000100	100015462	tipo_procedimento_escolha_consultar	\N	controlador.php?acao=tipo_procedimento_escolha_consultar	S
100000100	100015463	serie_escolha_consultar	\N	controlador.php?acao=serie_escolha_consultar	S
100000100	100015464	acesso_consultar	\N	controlador.php?acao=acesso_consultar	S
100000100	100015465	procedimento_pesquisar	\N	controlador.php?acao=procedimento_pesquisar	S
100000100	100015466	acesso_externo_protocolo_selecionar	\N	controlador.php?acao=acesso_externo_protocolo_selecionar	S
100000100	100015467	acesso_externo_protocolo_detalhe	\N	controlador.php?acao=acesso_externo_protocolo_detalhe	S
100000100	100015468	rel_acesso_ext_protocolo_cadastrar	\N	controlador.php?acao=rel_acesso_ext_protocolo_cadastrar	S
100000100	100015469	rel_acesso_ext_protocolo_consultar	\N	controlador.php?acao=rel_acesso_ext_protocolo_consultar	S
100000100	100015470	rel_acesso_ext_protocolo_listar	\N	controlador.php?acao=rel_acesso_ext_protocolo_listar	S
100000100	100015471	rel_acesso_ext_protocolo_excluir	\N	controlador.php?acao=rel_acesso_ext_protocolo_excluir	S
100000100	100015472	tipo_formulario_listar	\N	controlador.php?acao=tipo_formulario_listar	S
100000100	100015473	tipo_formulario_consultar	\N	controlador.php?acao=tipo_formulario_consultar	S
100000100	100015474	tipo_formulario_cadastrar	\N	controlador.php?acao=tipo_formulario_cadastrar	S
100000100	100015475	tipo_formulario_alterar	\N	controlador.php?acao=tipo_formulario_alterar	S
100000100	100015476	tipo_formulario_excluir	\N	controlador.php?acao=tipo_formulario_excluir	S
100000100	100015477	tipo_formulario_desativar	\N	controlador.php?acao=tipo_formulario_desativar	S
100000100	100015478	tipo_formulario_reativar	\N	controlador.php?acao=tipo_formulario_reativar	S
100000100	100015479	tipo_formulario_visualizar	\N	controlador.php?acao=tipo_formulario_visualizar	S
100000100	100015480	tipo_formulario_clonar	\N	controlador.php?acao=tipo_formulario_clonar	S
100000100	100015481	rel_protocolo_atributo_alterar	\N	controlador.php?acao=rel_protocolo_atributo_alterar	S
100000100	100015482	documento_gerar_circular	\N	controlador.php?acao=documento_gerar_circular	S
100000100	100015483	documento_email_circular	\N	controlador.php?acao=documento_email_circular	S
100000100	100015484	email_enviar_circular	\N	controlador.php?acao=email_enviar_circular	S
100000100	100015485	grupo_contato_institucional_alterar	\N	controlador.php?acao=grupo_contato_institucional_alterar	S
100000100	100015486	grupo_contato_institucional_cadastrar	\N	controlador.php?acao=grupo_contato_institucional_cadastrar	S
100000100	100015487	grupo_contato_institucional_desativar	\N	controlador.php?acao=grupo_contato_institucional_desativar	S
100000100	100015488	grupo_contato_institucional_excluir	\N	controlador.php?acao=grupo_contato_institucional_excluir	S
100000100	100015489	grupo_contato_institucional_reativar	\N	controlador.php?acao=grupo_contato_institucional_reativar	S
100000100	100015490	grupo_contato_institucional_consultar	\N	controlador.php?acao=grupo_contato_institucional_consultar	S
100000100	100015491	grupo_contato_institucional_listar	\N	controlador.php?acao=grupo_contato_institucional_listar	S
100000100	100015492	grupo_contato_institucional_selecionar	\N	controlador.php?acao=grupo_contato_institucional_selecionar	S
100000100	100015493	monitoramento_servico_listar	\N	controlador.php?acao=monitoramento_servico_listar	S
100000100	100015494	monitoramento_servico_excluir	\N	controlador.php?acao=monitoramento_servico_excluir	S
100000100	100015495	contato_definir	\N	controlador.php?acao=contato_definir	S
100000100	100015496	formulario_gerar	\N	controlador.php?acao=formulario_gerar	S
100000100	100015497	formulario_alterar	\N	controlador.php?acao=formulario_alterar	S
100000100	100015498	formulario_consultar	\N	controlador.php?acao=formulario_consultar	S
100000100	100015499	marcador_cadastrar	\N	controlador.php?acao=marcador_cadastrar	S
100000100	100015500	marcador_alterar	\N	controlador.php?acao=marcador_alterar	S
100000100	100015501	marcador_consultar	\N	controlador.php?acao=marcador_consultar	S
100000100	100015502	marcador_listar	\N	controlador.php?acao=marcador_listar	S
100000100	100015503	marcador_excluir	\N	controlador.php?acao=marcador_excluir	S
100000100	100015504	marcador_desativar	\N	controlador.php?acao=marcador_desativar	S
100000100	100015505	marcador_reativar	\N	controlador.php?acao=marcador_reativar	S
100000100	100015506	andamento_marcador_gerenciar	\N	controlador.php?acao=andamento_marcador_gerenciar	S
100000100	100015507	andamento_marcador_consultar	\N	controlador.php?acao=andamento_marcador_consultar	S
100000100	100015508	andamento_marcador_listar	\N	controlador.php?acao=andamento_marcador_listar	S
100000100	100015509	andamento_marcador_excluir	\N	controlador.php?acao=andamento_marcador_excluir	S
100000100	100015510	usuario_validar_acesso	\N	controlador.php?acao=usuario_validar_acesso	S
100000100	100015511	serie_restricao_cadastrar	\N	controlador.php?acao=serie_restricao_cadastrar	S
100000100	100015512	serie_restricao_consultar	\N	controlador.php?acao=serie_restricao_consultar	S
100000100	100015513	serie_restricao_listar	\N	controlador.php?acao=serie_restricao_listar	S
100000100	100015514	serie_restricao_excluir	\N	controlador.php?acao=serie_restricao_excluir	S
100000100	100015515	tipo_proced_restricao_cadastrar	\N	controlador.php?acao=tipo_proced_restricao_cadastrar	S
100000100	100015516	tipo_proced_restricao_consultar	\N	controlador.php?acao=tipo_proced_restricao_consultar	S
100000100	100015517	tipo_proced_restricao_listar	\N	controlador.php?acao=tipo_proced_restricao_listar	S
100000100	100015518	tipo_proced_restricao_excluir	\N	controlador.php?acao=tipo_proced_restricao_excluir	S
100000100	100015519	assunto_proxy_cadastrar	\N	controlador.php?acao=assunto_proxy_cadastrar	S
100000100	100015520	assunto_proxy_alterar	\N	controlador.php?acao=assunto_proxy_alterar	S
100000100	100015521	assunto_proxy_excluir	\N	controlador.php?acao=assunto_proxy_excluir	S
100000100	100015522	assunto_proxy_consultar	\N	controlador.php?acao=assunto_proxy_consultar	S
100000100	100015523	assunto_proxy_listar	\N	controlador.php?acao=assunto_proxy_listar	S
100000100	100015524	tabela_assuntos_ativar	\N	controlador.php?acao=tabela_assuntos_ativar	S
100000100	100015525	tabela_assuntos_cadastrar	\N	controlador.php?acao=tabela_assuntos_cadastrar	S
100000100	100015526	tabela_assuntos_alterar	\N	controlador.php?acao=tabela_assuntos_alterar	S
100000100	100015527	tabela_assuntos_excluir	\N	controlador.php?acao=tabela_assuntos_excluir	S
100000100	100015528	tabela_assuntos_consultar	\N	controlador.php?acao=tabela_assuntos_consultar	S
100000100	100015529	tabela_assuntos_listar	\N	controlador.php?acao=tabela_assuntos_listar	S
100000100	100015530	procedimento_bloquear	\N	controlador.php?acao=procedimento_bloquear	S
100000100	100015531	procedimento_desbloquear	\N	controlador.php?acao=procedimento_desbloquear	S
100000100	100015532	unidade_selecionar_orgao	\N	controlador.php?acao=unidade_selecionar_orgao	S
100000100	100015533	rel_tipo_procedimento_assunto_consultar	\N	controlador.php?acao=rel_tipo_procedimento_assunto_consultar	S
100000100	100015534	rel_serie_assunto_consultar	\N	controlador.php?acao=rel_serie_assunto_consultar	S
100000100	100015535	mapeamento_assunto_gerenciar	\N	controlador.php?acao=mapeamento_assunto_gerenciar	S
100000100	100015536	mapeamento_assunto_cadastrar	\N	controlador.php?acao=mapeamento_assunto_cadastrar	S
100000100	100015537	mapeamento_assunto_excluir	\N	controlador.php?acao=mapeamento_assunto_excluir	S
100000100	100015538	mapeamento_assunto_consultar	\N	controlador.php?acao=mapeamento_assunto_consultar	S
100000100	100015539	mapeamento_assunto_listar	\N	controlador.php?acao=mapeamento_assunto_listar	S
100000100	100015540	arquivamento_excluir	\N	controlador.php?acao=arquivamento_excluir	S
100000100	100015541	arquivamento_consultar	\N	controlador.php?acao=arquivamento_consultar	S
100000100	100015542	gerar_estatisticas_arquivamento	\N	controlador.php?acao=gerar_estatisticas_arquivamento	S
100000100	100015543	estatisticas_detalhar_arquivamento	\N	controlador.php?acao=estatisticas_detalhar_arquivamento	S
100000100	100015544	documento_cancelar	\N	controlador.php?acao=documento_cancelar	S
100000100	100015545	documento_versao_comparar	\N	controlador.php?acao=documento_versao_comparar	S
100000100	100015546	ajuda_variaveis_secao_modelo	\N	controlador.php?acao=ajuda_variaveis_secao_modelo	S
100000100	100015547	ajuda_variaveis_tarjas	\N	controlador.php?acao=ajuda_variaveis_tarjas	S
100000100	100015548	ajuda_variaveis_email_sistema	\N	controlador.php?acao=ajuda_variaveis_email_sistema	S
100000100	100015549	unidade_migrar	\N	controlador.php?acao=unidade_migrar	S
100000100	100015550	estatisticas_grafico_exibir	\N	controlador.php?acao=estatisticas_grafico_exibir	S
100000100	100015553	anexo_download	\N	controlador.php?acao=anexo_download	S
100000100	100015584	acompanhamento_gerenciar	\N	controlador.php?acao=acompanhamento_gerenciar	S
100000100	100015585	acompanhamento_selecionar	\N	controlador.php?acao=acompanhamento_selecionar	S
100000100	100015586	acompanhamento_alterar_grupo	\N	controlador.php?acao=acompanhamento_alterar_grupo	S
100000100	100015587	andamento_marcador_alterar	\N	controlador.php?acao=andamento_marcador_alterar	S
100000100	100015588	andamento_marcador_cadastrar	\N	controlador.php?acao=andamento_marcador_cadastrar	S
100000100	100015589	andamento_marcador_remover	\N	controlador.php?acao=andamento_marcador_remover	S
100000100	100015590	marcador_selecionar	\N	controlador.php?acao=marcador_selecionar	S
100000100	100015591	painel_controle_configurar	\N	controlador.php?acao=painel_controle_configurar	S
100000100	100015592	painel_controle_visualizar	\N	controlador.php?acao=painel_controle_visualizar	S
100000100	100015593	procedimento_configurar_detalhe	\N	controlador.php?acao=procedimento_configurar_detalhe	S
100000100	100015594	rel_usuario_marcador_cadastrar	\N	controlador.php?acao=rel_usuario_marcador_cadastrar	S
100000100	100015595	rel_usuario_marcador_configurar	\N	controlador.php?acao=rel_usuario_marcador_configurar	S
100000100	100015596	rel_usuario_marcador_excluir	\N	controlador.php?acao=rel_usuario_marcador_excluir	S
100000100	100015597	rel_usuario_marcador_listar	\N	controlador.php?acao=rel_usuario_marcador_listar	S
100000100	100015598	rel_usuario_marcador_selecionar	\N	controlador.php?acao=rel_usuario_marcador_selecionar	S
100000100	100015599	rel_usuario_grupo_acomp_cadastrar	\N	controlador.php?acao=rel_usuario_grupo_acomp_cadastrar	S
100000100	100015600	rel_usuario_grupo_acomp_configurar	\N	controlador.php?acao=rel_usuario_grupo_acomp_configurar	S
100000100	100015601	rel_usuario_grupo_acomp_excluir	\N	controlador.php?acao=rel_usuario_grupo_acomp_excluir	S
100000100	100015602	rel_usuario_grupo_acomp_listar	\N	controlador.php?acao=rel_usuario_grupo_acomp_listar	S
100000100	100015603	rel_usuario_grupo_acomp_selecionar	\N	controlador.php?acao=rel_usuario_grupo_acomp_selecionar	S
100000100	100015604	rel_usuario_usuario_unidade_cadastrar	\N	controlador.php?acao=rel_usuario_usuario_unidade_cadastrar	S
100000100	100015605	rel_usuario_usuario_unidade_configurar	\N	controlador.php?acao=rel_usuario_usuario_unidade_configurar	S
100000100	100015606	rel_usuario_usuario_unidade_excluir	\N	controlador.php?acao=rel_usuario_usuario_unidade_excluir	S
100000100	100015607	rel_usuario_usuario_unidade_listar	\N	controlador.php?acao=rel_usuario_usuario_unidade_listar	S
100000100	100015608	rel_usuario_usuario_unidade_selecionar	\N	controlador.php?acao=rel_usuario_usuario_unidade_selecionar	S
100000100	100015609	rel_usuario_tipo_proced_cadastrar	\N	controlador.php?acao=rel_usuario_tipo_proced_cadastrar	S
100000100	100015610	rel_usuario_tipo_proced_configurar	\N	controlador.php?acao=rel_usuario_tipo_proced_configurar	S
100000100	100015611	rel_usuario_tipo_proced_excluir	\N	controlador.php?acao=rel_usuario_tipo_proced_excluir	S
100000100	100015612	rel_usuario_tipo_proced_listar	\N	controlador.php?acao=rel_usuario_tipo_proced_listar	S
100000100	100015613	rel_usuario_tipo_proced_selecionar	\N	controlador.php?acao=rel_usuario_tipo_proced_selecionar	S
100000100	100015614	arquivamento_cancelar	\N	controlador.php?acao=arquivamento_cancelar	S
100000100	100015615	orgao_historico_alterar	\N	controlador.php?acao=orgao_historico_alterar	S
100000100	100015616	orgao_historico_cadastrar	\N	controlador.php?acao=orgao_historico_cadastrar	S
100000100	100015617	orgao_historico_excluir	\N	controlador.php?acao=orgao_historico_excluir	S
100000100	100015618	unidade_historico_alterar	\N	controlador.php?acao=unidade_historico_alterar	S
100000100	100015619	unidade_historico_cadastrar	\N	controlador.php?acao=unidade_historico_cadastrar	S
100000100	100015620	unidade_historico_excluir	\N	controlador.php?acao=unidade_historico_excluir	S
100000100	100015621	orgao_historico_consultar	\N	controlador.php?acao=orgao_historico_consultar	S
100000100	100015622	orgao_historico_listar	\N	controlador.php?acao=orgao_historico_listar	S
100000100	100015623	unidade_historico_consultar	\N	controlador.php?acao=unidade_historico_consultar	S
100000100	100015624	unidade_historico_listar	\N	controlador.php?acao=unidade_historico_listar	S
100000100	100015625	titulo_listar	\N	controlador.php?acao=titulo_listar	S
100000100	100015626	titulo_consultar	\N	controlador.php?acao=titulo_consultar	S
100000100	100015627	titulo_cadastrar	\N	controlador.php?acao=titulo_cadastrar	S
100000100	100015628	titulo_alterar	\N	controlador.php?acao=titulo_alterar	S
100000100	100015629	titulo_excluir	\N	controlador.php?acao=titulo_excluir	S
100000100	100015630	titulo_desativar	\N	controlador.php?acao=titulo_desativar	S
100000100	100015631	titulo_reativar	\N	controlador.php?acao=titulo_reativar	S
100000100	100015632	titulo_selecionar	\N	controlador.php?acao=titulo_selecionar	S
100000100	100015633	contato_gerar_relatorios	\N	controlador.php?acao=contato_gerar_relatorios	S
100000100	100015634	editor_simular	\N	controlador.php?acao=editor_simular	S
100000100	100015635	controle_prazo_definir	\N	controlador.php?acao=controle_prazo_definir	S
100000100	100015636	controle_prazo_concluir	\N	controlador.php?acao=controle_prazo_concluir	S
100000100	100015637	controle_prazo_cadastrar	\N	controlador.php?acao=controle_prazo_cadastrar	S
100000100	100015638	controle_prazo_alterar	\N	controlador.php?acao=controle_prazo_alterar	S
100000100	100015639	controle_prazo_excluir	\N	controlador.php?acao=controle_prazo_excluir	S
100000100	100015640	controle_prazo_consultar	\N	controlador.php?acao=controle_prazo_consultar	S
100000100	100015641	controle_prazo_listar	\N	controlador.php?acao=controle_prazo_listar	S
100000100	100015642	comentario_cadastrar	\N	controlador.php?acao=comentario_cadastrar	S
100000100	100015643	comentario_alterar	\N	controlador.php?acao=comentario_alterar	S
100000100	100015644	comentario_listar	\N	controlador.php?acao=comentario_listar	S
100000100	100015645	comentario_consultar	\N	controlador.php?acao=comentario_consultar	S
100000100	100015646	comentario_excluir	\N	controlador.php?acao=comentario_excluir	S
100000100	100015647	infra_acesso_usuario_listar	\N	controlador.php?acao=infra_acesso_usuario_listar	S
100000100	100015648	categoria_consultar	\N	controlador.php?acao=categoria_consultar	S
100000100	100015649	categoria_listar	\N	controlador.php?acao=categoria_listar	S
100000100	100015650	categoria_cadastrar	\N	controlador.php?acao=categoria_cadastrar	S
100000100	100015651	categoria_alterar	\N	controlador.php?acao=categoria_alterar	S
100000100	100015652	categoria_excluir	\N	controlador.php?acao=categoria_excluir	S
100000100	100015653	categoria_desativar	\N	controlador.php?acao=categoria_desativar	S
100000100	100015654	categoria_reativar	\N	controlador.php?acao=categoria_reativar	S
100000100	100015655	procedimento_credencial_renovar	\N	controlador.php?acao=procedimento_credencial_renovar	S
100000100	100015656	protocolo_modelo_gerenciar	\N	controlador.php?acao=protocolo_modelo_gerenciar	S
100000100	100015657	bloco_navegar	\N	controlador.php?acao=bloco_navegar	S
100000100	100015658	bloco_priorizar	\N	controlador.php?acao=bloco_priorizar	S
100000100	100015659	bloco_revisar	\N	controlador.php?acao=bloco_revisar	S
100000100	100015660	bloco_atribuir	\N	controlador.php?acao=bloco_atribuir	S
100000100	100015661	bloco_comentar	\N	controlador.php?acao=bloco_comentar	S
100000100	100015662	rel_acesso_ext_serie_cadastrar	\N	controlador.php?acao=rel_acesso_ext_serie_cadastrar	S
100000100	100015663	rel_acesso_ext_serie_consultar	\N	controlador.php?acao=rel_acesso_ext_serie_consultar	S
100000100	100015664	rel_acesso_ext_serie_excluir	\N	controlador.php?acao=rel_acesso_ext_serie_excluir	S
100000100	100015665	rel_acesso_ext_serie_listar	\N	controlador.php?acao=rel_acesso_ext_serie_listar	S
100000100	100015666	rel_acesso_ext_serie_detalhar	\N	controlador.php?acao=rel_acesso_ext_serie_detalhar	S
100000100	100015667	grupo_bloco_cadastrar	\N	controlador.php?acao=grupo_bloco_cadastrar	S
100000100	100015668	grupo_bloco_alterar	\N	controlador.php?acao=grupo_bloco_alterar	S
100000100	100015669	grupo_bloco_consultar	\N	controlador.php?acao=grupo_bloco_consultar	S
100000100	100015670	grupo_bloco_excluir	\N	controlador.php?acao=grupo_bloco_excluir	S
100000100	100015671	grupo_bloco_listar	\N	controlador.php?acao=grupo_bloco_listar	S
100000100	100015672	grupo_bloco_desativar	\N	controlador.php?acao=grupo_bloco_desativar	S
100000100	100015673	grupo_bloco_reativar	\N	controlador.php?acao=grupo_bloco_reativar	S
100000100	100015674	bloco_alterar_grupo	\N	controlador.php?acao=bloco_alterar_grupo	S
100000100	100015675	rel_usuario_grupo_bloco_cadastrar	\N	controlador.php?acao=rel_usuario_grupo_bloco_cadastrar	S
100000100	100015676	rel_usuario_grupo_bloco_configurar	\N	controlador.php?acao=rel_usuario_grupo_bloco_configurar	S
100000100	100015677	rel_usuario_grupo_bloco_excluir	\N	controlador.php?acao=rel_usuario_grupo_bloco_excluir	S
100000100	100015678	rel_usuario_grupo_bloco_listar	\N	controlador.php?acao=rel_usuario_grupo_bloco_listar	S
100000100	100015679	rel_usuario_grupo_bloco_selecionar	\N	controlador.php?acao=rel_usuario_grupo_bloco_selecionar	S
100000100	100015680	serie_selecionar_acesso_externo	\N	controlador.php?acao=serie_selecionar_acesso_externo	S
100000100	100015681	servico_gerar_chave_acesso	\N	controlador.php?acao=servico_gerar_chave_acesso	S
100000100	100015682	instalacao_federacao_listar	\N	controlador.php?acao=instalacao_federacao_listar	S
100000100	100015683	instalacao_federacao_consultar	\N	controlador.php?acao=instalacao_federacao_consultar	S
100000100	100015684	instalacao_federacao_cadastrar	\N	controlador.php?acao=instalacao_federacao_cadastrar	S
100000100	100015685	instalacao_federacao_alterar	\N	controlador.php?acao=instalacao_federacao_alterar	S
100000100	100015686	instalacao_federacao_excluir	\N	controlador.php?acao=instalacao_federacao_excluir	S
100000100	100015687	instalacao_federacao_desativar	\N	controlador.php?acao=instalacao_federacao_desativar	S
100000100	100015688	instalacao_federacao_reativar	\N	controlador.php?acao=instalacao_federacao_reativar	S
100000100	100015689	instalacao_federacao_liberar	\N	controlador.php?acao=instalacao_federacao_liberar	S
100000100	100015690	instalacao_federacao_bloquear	\N	controlador.php?acao=instalacao_federacao_bloquear	S
100000100	100015691	instalacao_federacao_selecionar	\N	controlador.php?acao=instalacao_federacao_selecionar	S
100000100	100015692	instalacao_federacao_verificar_conexao	\N	controlador.php?acao=instalacao_federacao_verificar_conexao	S
100000100	100015693	andamento_instalacao_cadastrar	\N	controlador.php?acao=andamento_instalacao_cadastrar	S
100000100	100015694	andamento_instalacao_excluir	\N	controlador.php?acao=andamento_instalacao_excluir	S
100000100	100015695	andamento_instalacao_listar	\N	controlador.php?acao=andamento_instalacao_listar	S
100000100	100015696	andamento_instalacao_consultar	\N	controlador.php?acao=andamento_instalacao_consultar	S
100000100	100015697	acesso_federacao_cadastrar	\N	controlador.php?acao=acesso_federacao_cadastrar	S
100000100	100015698	acesso_federacao_alterar	\N	controlador.php?acao=acesso_federacao_alterar	S
100000100	100015699	acesso_federacao_consultar	\N	controlador.php?acao=acesso_federacao_consultar	S
100000100	100015700	acesso_federacao_listar	\N	controlador.php?acao=acesso_federacao_listar	S
100000100	100015701	acesso_federacao_excluir	\N	controlador.php?acao=acesso_federacao_excluir	S
100000100	100015702	acesso_federacao_gerenciar	\N	controlador.php?acao=acesso_federacao_gerenciar	S
100000100	100015703	acesso_federacao_enviar	\N	controlador.php?acao=acesso_federacao_enviar	S
100000100	100015704	acesso_federacao_cancelar	\N	controlador.php?acao=acesso_federacao_cancelar	S
100000100	100015705	acesso_federacao_desativar	\N	controlador.php?acao=acesso_federacao_desativar	S
100000100	100015706	acesso_federacao_reativar	\N	controlador.php?acao=acesso_federacao_reativar	S
100000100	100015707	tarefa_instalacao_listar	\N	controlador.php?acao=tarefa_instalacao_listar	S
100000100	100015708	tarefa_instalacao_consultar	\N	controlador.php?acao=tarefa_instalacao_consultar	S
100000100	100015709	atributo_instalacao_cadastrar	\N	controlador.php?acao=atributo_instalacao_cadastrar	S
100000100	100015710	atributo_instalacao_listar	\N	controlador.php?acao=atributo_instalacao_listar	S
100000100	100015711	atributo_instalacao_consultar	\N	controlador.php?acao=atributo_instalacao_consultar	S
100000100	100015712	atributo_instalacao_excluir	\N	controlador.php?acao=atributo_instalacao_excluir	S
100000100	100015713	orgao_federacao_cadastrar	\N	controlador.php?acao=orgao_federacao_cadastrar	S
100000100	100015714	orgao_federacao_alterar	\N	controlador.php?acao=orgao_federacao_alterar	S
100000100	100015715	orgao_federacao_excluir	\N	controlador.php?acao=orgao_federacao_excluir	S
100000100	100015716	orgao_federacao_consultar	\N	controlador.php?acao=orgao_federacao_consultar	S
100000100	100015717	orgao_federacao_listar	\N	controlador.php?acao=orgao_federacao_listar	S
100000100	100015718	orgao_federacao_selecionar	\N	controlador.php?acao=orgao_federacao_selecionar	S
100000100	100015719	orgao_federacao_desativar	\N	controlador.php?acao=orgao_federacao_desativar	S
100000100	100015720	orgao_federacao_reativar	\N	controlador.php?acao=orgao_federacao_reativar	S
100000100	100015721	unidade_federacao_cadastrar	\N	controlador.php?acao=unidade_federacao_cadastrar	S
100000100	100015722	unidade_federacao_alterar	\N	controlador.php?acao=unidade_federacao_alterar	S
100000100	100015723	unidade_federacao_excluir	\N	controlador.php?acao=unidade_federacao_excluir	S
100000100	100015724	unidade_federacao_consultar	\N	controlador.php?acao=unidade_federacao_consultar	S
100000100	100015725	unidade_federacao_listar	\N	controlador.php?acao=unidade_federacao_listar	S
100000100	100015726	unidade_federacao_selecionar	\N	controlador.php?acao=unidade_federacao_selecionar	S
100000100	100015727	unidade_federacao_desativar	\N	controlador.php?acao=unidade_federacao_desativar	S
100000100	100015728	unidade_federacao_reativar	\N	controlador.php?acao=unidade_federacao_reativar	S
100000100	100015729	usuario_federacao_cadastrar	\N	controlador.php?acao=usuario_federacao_cadastrar	S
100000100	100015730	usuario_federacao_alterar	\N	controlador.php?acao=usuario_federacao_alterar	S
100000100	100015731	usuario_federacao_excluir	\N	controlador.php?acao=usuario_federacao_excluir	S
100000100	100015732	usuario_federacao_consultar	\N	controlador.php?acao=usuario_federacao_consultar	S
100000100	100015733	usuario_federacao_listar	\N	controlador.php?acao=usuario_federacao_listar	S
100000100	100015734	usuario_federacao_selecionar	\N	controlador.php?acao=usuario_federacao_selecionar	S
100000100	100015735	usuario_federacao_desativar	\N	controlador.php?acao=usuario_federacao_desativar	S
100000100	100015736	usuario_federacao_reativar	\N	controlador.php?acao=usuario_federacao_reativar	S
100000100	100015737	protocolo_federacao_cadastrar	\N	controlador.php?acao=protocolo_federacao_cadastrar	S
100000100	100015738	protocolo_federacao_alterar	\N	controlador.php?acao=protocolo_federacao_alterar	S
100000100	100015739	protocolo_federacao_excluir	\N	controlador.php?acao=protocolo_federacao_excluir	S
100000100	100015740	protocolo_federacao_consultar	\N	controlador.php?acao=protocolo_federacao_consultar	S
100000100	100015741	protocolo_federacao_listar	\N	controlador.php?acao=protocolo_federacao_listar	S
100000100	100015742	protocolo_federacao_selecionar	\N	controlador.php?acao=protocolo_federacao_selecionar	S
100000100	100015743	acao_federacao_cadastrar	\N	controlador.php?acao=acao_federacao_cadastrar	S
100000100	100015744	acao_federacao_alterar	\N	controlador.php?acao=acao_federacao_alterar	S
100000100	100015745	acao_federacao_excluir	\N	controlador.php?acao=acao_federacao_excluir	S
100000100	100015746	acao_federacao_consultar	\N	controlador.php?acao=acao_federacao_consultar	S
100000100	100015747	acao_federacao_listar	\N	controlador.php?acao=acao_federacao_listar	S
100000100	100015748	acao_federacao_desativar	\N	controlador.php?acao=acao_federacao_desativar	S
100000100	100015749	parametro_acao_federacao_cadastrar	\N	controlador.php?acao=parametro_acao_federacao_cadastrar	S
100000100	100015750	parametro_acao_federacao_excluir	\N	controlador.php?acao=parametro_acao_federacao_excluir	S
100000100	100015751	parametro_acao_federacao_consultar	\N	controlador.php?acao=parametro_acao_federacao_consultar	S
100000100	100015752	parametro_acao_federacao_listar	\N	controlador.php?acao=parametro_acao_federacao_listar	S
100000100	100015753	processo_consulta_federacao	\N	controlador.php?acao=processo_consulta_federacao	S
100000100	100015754	documento_consulta_federacao	\N	controlador.php?acao=documento_consulta_federacao	S
100000100	100015755	andamentos_consulta_federacao	\N	controlador.php?acao=andamentos_consulta_federacao	S
100000100	100015756	grupo_federacao_cadastrar	\N	controlador.php?acao=grupo_federacao_cadastrar	S
100000100	100015757	grupo_federacao_alterar	\N	controlador.php?acao=grupo_federacao_alterar	S
100000100	100015758	grupo_federacao_consultar	\N	controlador.php?acao=grupo_federacao_consultar	S
100000100	100015759	grupo_federacao_excluir	\N	controlador.php?acao=grupo_federacao_excluir	S
100000100	100015760	grupo_federacao_listar	\N	controlador.php?acao=grupo_federacao_listar	S
100000100	100015761	grupo_federacao_selecionar	\N	controlador.php?acao=grupo_federacao_selecionar	S
100000100	100015762	grupo_federacao_institucional_cadastrar	\N	controlador.php?acao=grupo_federacao_institucional_cadastrar	S
100000100	100015763	grupo_federacao_institucional_alterar	\N	controlador.php?acao=grupo_federacao_institucional_alterar	S
100000100	100015764	grupo_federacao_institucional_consultar	\N	controlador.php?acao=grupo_federacao_institucional_consultar	S
100000100	100015765	grupo_federacao_institucional_excluir	\N	controlador.php?acao=grupo_federacao_institucional_excluir	S
100000100	100015766	grupo_federacao_institucional_listar	\N	controlador.php?acao=grupo_federacao_institucional_listar	S
100000100	100015767	grupo_federacao_institucional_desativar	\N	controlador.php?acao=grupo_federacao_institucional_desativar	S
100000100	100015768	grupo_federacao_institucional_reativar	\N	controlador.php?acao=grupo_federacao_institucional_reativar	S
100000100	100015769	grupo_federacao_institucional_selecionar	\N	controlador.php?acao=grupo_federacao_institucional_selecionar	S
100000100	100015770	rel_grupo_fed_orgao_fed_cadastrar	\N	controlador.php?acao=rel_grupo_fed_orgao_fed_cadastrar	S
100000100	100015771	rel_grupo_fed_orgao_fed_excluir	\N	controlador.php?acao=rel_grupo_fed_orgao_fed_excluir	S
100000100	100015772	rel_grupo_fed_orgao_fed_listar	\N	controlador.php?acao=rel_grupo_fed_orgao_fed_listar	S
100000100	100015773	rel_grupo_fed_orgao_fed_selecionar	\N	controlador.php?acao=rel_grupo_fed_orgao_fed_selecionar	S
100000100	100015774	sinalizacao_federacao_cadastrar	\N	controlador.php?acao=sinalizacao_federacao_cadastrar	S
100000100	100015775	sinalizacao_federacao_alterar	\N	controlador.php?acao=sinalizacao_federacao_alterar	S
100000100	100015776	sinalizacao_federacao_consultar	\N	controlador.php?acao=sinalizacao_federacao_consultar	S
100000100	100015777	sinalizacao_federacao_excluir	\N	controlador.php?acao=sinalizacao_federacao_excluir	S
100000100	100015778	sinalizacao_federacao_listar	\N	controlador.php?acao=sinalizacao_federacao_listar	S
100000100	100015779	rel_sinalizacao_fed_unidade_cadastrar	\N	controlador.php?acao=rel_sinalizacao_fed_unidade_cadastrar	S
100000100	100015780	rel_sinalizacao_fed_unidade_alterar	\N	controlador.php?acao=rel_sinalizacao_fed_unidade_alterar	S
100000100	100015781	rel_sinalizacao_fed_unidade_consultar	\N	controlador.php?acao=rel_sinalizacao_fed_unidade_consultar	S
100000100	100015782	rel_sinalizacao_fed_unidade_excluir	\N	controlador.php?acao=rel_sinalizacao_fed_unidade_excluir	S
100000100	100015783	rel_sinalizacao_fed_unidade_listar	\N	controlador.php?acao=rel_sinalizacao_fed_unidade_listar	S
100000100	100015784	replicacao_federacao_agendar	\N	controlador.php?acao=replicacao_federacao_agendar	S
100000100	100015785	replicacao_federacao_replicar	\N	controlador.php?acao=replicacao_federacao_replicar	S
100000100	100015786	replicacao_federacao_cadastrar	\N	controlador.php?acao=replicacao_federacao_cadastrar	S
100000100	100015787	replicacao_federacao_alterar	\N	controlador.php?acao=replicacao_federacao_alterar	S
100000100	100015788	replicacao_federacao_consultar	\N	controlador.php?acao=replicacao_federacao_consultar	S
100000100	100015789	replicacao_federacao_excluir	\N	controlador.php?acao=replicacao_federacao_excluir	S
100000100	100015790	replicacao_federacao_listar	\N	controlador.php?acao=replicacao_federacao_listar	S
100000100	100015791	replicacao_federacao_desativar	\N	controlador.php?acao=replicacao_federacao_desativar	S
100000100	100015792	replicacao_federacao_reativar	\N	controlador.php?acao=replicacao_federacao_reativar	S
100000100	100015793	procedimento_acervo_sigilosos_global	\N	controlador.php?acao=procedimento_acervo_sigilosos_global	S
100000100	100015794	pesquisa_cadastrar	\N	controlador.php?acao=pesquisa_cadastrar	S
100000100	100015795	pesquisa_alterar	\N	controlador.php?acao=pesquisa_alterar	S
100000100	100015796	pesquisa_consultar	\N	controlador.php?acao=pesquisa_consultar	S
100000100	100015797	pesquisa_excluir	\N	controlador.php?acao=pesquisa_excluir	S
100000100	100015798	pesquisa_listar	\N	controlador.php?acao=pesquisa_listar	S
100000100	100015799	pesquisa_selecionar	\N	controlador.php?acao=pesquisa_selecionar	S
100000100	100015800	campo_pesquisa_cadastrar	\N	controlador.php?acao=campo_pesquisa_cadastrar	S
100000100	100015801	campo_pesquisa_alterar	\N	controlador.php?acao=campo_pesquisa_alterar	S
100000100	100015802	campo_pesquisa_consultar	\N	controlador.php?acao=campo_pesquisa_consultar	S
100000100	100015803	campo_pesquisa_excluir	\N	controlador.php?acao=campo_pesquisa_excluir	S
100000100	100015804	campo_pesquisa_listar	\N	controlador.php?acao=campo_pesquisa_listar	S
100000100	100015805	infra_trocar_unidade	\N	controlador.php?acao=infra_trocar_unidade	S
100000100	100015806	aviso_mostrar	\N	controlador.php?acao=aviso_mostrar	S
\.


--
-- Data for Name: recurso_vinculado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recurso_vinculado (id_sistema, id_recurso, id_sistema_vinculado, id_recurso_vinculado, tipo_vinculo) FROM stdin;
\.


--
-- Data for Name: regra_auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regra_auditoria (id_regra_auditoria, id_sistema, descricao, sin_ativo) FROM stdin;
1	100000099	Geral	S
2	100000100	Geral	S
3	100000100	Acessos e Usuários Externos	S
4	100000100	Visualização de Processos	S
5	100000100	Visualização de Documentos	S
\.


--
-- Data for Name: rel_hierarquia_unidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rel_hierarquia_unidade (id_unidade, id_hierarquia, id_hierarquia_pai, id_unidade_pai, dta_inicio, dta_fim, sin_ativo) FROM stdin;
110000001	100000018	\N	\N	2013-11-06 00:00:00	\N	S
110000002	100000018	100000018	110000001	2014-01-01 00:00:00	\N	S
110000003	100000018	100000018	110000001	2014-01-01 00:00:00	\N	S
\.


--
-- Data for Name: rel_orgao_autenticacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rel_orgao_autenticacao (id_orgao, id_servidor_autenticacao, sequencia) FROM stdin;
0	1	0
\.


--
-- Data for Name: rel_perfil_item_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rel_perfil_item_menu (id_perfil, id_sistema, id_menu, id_item_menu, id_recurso) FROM stdin;
100000931	100000099	100000078	100005410	100014405
100000931	100000099	100000078	100005411	100014369
100000933	100000099	100000078	100005411	100014369
100000931	100000099	100000078	100005412	100014312
100000931	100000099	100000078	100005413	100014359
100000933	100000099	100000078	100005413	100014359
100000931	100000099	100000078	100005415	100014370
100000933	100000099	100000078	100005415	100014370
100000931	100000099	100000078	100005416	100014375
100000933	100000099	100000078	100005416	100014375
100000931	100000099	100000078	100005417	100014313
100000933	100000099	100000078	100005417	100014313
100000931	100000099	100000078	100005418	100014301
100000931	100000099	100000078	100005419	100014327
100000937	100000099	100000078	100005419	100014327
100000931	100000099	100000078	100005420	100014344
100000935	100000099	100000078	100005420	100014344
100000937	100000099	100000078	100005420	100014344
100000931	100000099	100000078	100005421	100014353
100000933	100000099	100000078	100005421	100014353
100000931	100000099	100000078	100005422	100014360
100000933	100000099	100000078	100005422	100014360
100000931	100000099	100000078	100005423	100014395
100000933	100000099	100000078	100005423	100014395
100000931	100000099	100000078	100005424	100014365
100000933	100000099	100000078	100005424	100014365
100000931	100000099	100000078	100005427	100014379
100000933	100000099	100000078	100005427	100014379
100000936	100000099	100000078	100005427	100014379
100000946	100000099	100000078	100005427	100014379
100000931	100000099	100000078	100005428	100014302
100000933	100000099	100000078	100005428	100014302
100000931	100000099	100000078	100005429	100014393
100000931	100000099	100000078	100005430	100014328
100000933	100000099	100000078	100005430	100014328
100000937	100000099	100000078	100005430	100014328
100000931	100000099	100000078	100005431	100014345
100000933	100000099	100000078	100005431	100014345
100000935	100000099	100000078	100005431	100014345
100000937	100000099	100000078	100005431	100014345
100000931	100000099	100000078	100005432	100014354
100000933	100000099	100000078	100005432	100014354
100000931	100000099	100000078	100005435	100014333
100000931	100000099	100000078	100005436	100014418
100000931	100000099	100000078	100005437	100014423
100000931	100000099	100000078	100005438	100014394
100000931	100000099	100000078	100005439	100014407
100000937	100000099	100000078	100005439	100014407
100000931	100000099	100000078	100005440	100014408
100000935	100000099	100000078	100005440	100014408
100000937	100000099	100000078	100005440	100014408
100000931	100000099	100000078	100005441	100014409
100000933	100000099	100000078	100005441	100014409
100000931	100000099	100000078	100005442	100014334
100000933	100000099	100000078	100005442	100014334
100000931	100000099	100000078	100005443	100014340
100000935	100000099	100000078	100005443	100014340
100000931	100000099	100000078	100005444	100014381
100000932	100000099	100000078	100005444	100014381
100000933	100000099	100000078	100005444	100014381
100000936	100000099	100000078	100005444	100014381
100000946	100000099	100000078	100005444	100014381
100000931	100000099	100000078	100005446	100014367
100000933	100000099	100000078	100005446	100014367
100000931	100000099	100000078	100005449	100014351
100000933	100000099	100000078	100005449	100014351
100000935	100000099	100000078	100005449	100014351
100000931	100000099	100000078	100005450	100014307
100000931	100000099	100000078	100005451	100014380
100000933	100000099	100000078	100005451	100014380
100000936	100000099	100000078	100005451	100014380
100000946	100000099	100000078	100005451	100014380
100000931	100000099	100000078	100005452	100014325
100000933	100000099	100000078	100005452	100014325
100000931	100000099	100000078	100005453	100014308
100000931	100000099	100000078	100005454	100014396
100000933	100000099	100000078	100005454	100014396
100000933	100000099	100000078	100005456	100014412
100000936	100000099	100000078	100005456	100014412
100000946	100000099	100000078	100005456	100014412
100000931	100000099	100000078	100005606	100015187
100000931	100000099	100000078	100005607	100015188
100000931	100000099	100000078	100005609	100015193
100000931	100000099	100000078	100005610	100015198
100000933	100000099	100000078	100005611	100015203
100000931	100000099	100000078	100005618	100015265
100000931	100000099	100000078	100005637	100015368
100000931	100000099	100000078	100005650	100015451
100000931	100000099	100000078	100005651	100015452
100000933	100000099	100000078	100005671	100015552
100000931	100000099	100000078	100005672	100015554
100000931	100000099	100000078	100005673	100015555
100000931	100000099	100000078	100005674	100015560
100000931	100000099	100000078	100005675	100015563
100000931	100000099	100000078	100005676	100015568
100000938	100000100	100000079	100005462	100014783
100000947	100000100	100000079	100005462	100014783
100000939	100000100	100000079	100005463	100015529
100000940	100000100	100000079	100005465	100014561
100000941	100000100	100000079	100005467	100014925
100000938	100000100	100000079	100005472	100014815
100000947	100000100	100000079	100005472	100014815
100000941	100000100	100000079	100005474	100014926
100000938	100000100	100000079	100005476	100014749
100000947	100000100	100000079	100005476	100014749
100000938	100000100	100000079	100005477	100014820
100000947	100000100	100000079	100005477	100014820
100000938	100000100	100000079	100005478	100014898
100000947	100000100	100000079	100005478	100014898
100000940	100000100	100000079	100005480	100014746
100000940	100000100	100000079	100005481	100014755
100000938	100000100	100000079	100005484	100014914
100000947	100000100	100000079	100005484	100014914
100000938	100000100	100000079	100005485	100014812
100000947	100000100	100000079	100005485	100014812
100000941	100000100	100000079	100005487	100014623
100000938	100000100	100000079	100005488	100014751
100000947	100000100	100000079	100005488	100014751
100000938	100000100	100000079	100005489	100014862
100000940	100000100	100000079	100005489	100014862
100000947	100000100	100000079	100005489	100014862
100000938	100000100	100000079	100005491	100014947
100000947	100000100	100000079	100005491	100014947
100000941	100000100	100000079	100005492	100014626
100000939	100000100	100000079	100005493	100014799
100000938	100000100	100000079	100005495	100014934
100000947	100000100	100000079	100005495	100014934
100000944	100000100	100000079	100005499	100014907
100000939	100000100	100000079	100005501	100014857
100000939	100000100	100000079	100005502	100014489
100000938	100000100	100000079	100005503	100014539
100000940	100000100	100000079	100005505	100014762
100000941	100000100	100000079	100005506	100014594
100000939	100000100	100000079	100005507	100014492
100000939	100000100	100000079	100005509	100014646
100000939	100000100	100000079	100005510	100014515
100000941	100000100	100000079	100005511	100014597
100000941	100000100	100000079	100005512	100014610
100000939	100000100	100000079	100005513	100014495
100000939	100000100	100000079	100005514	100014511
100000939	100000100	100000079	100005516	100014649
100000941	100000100	100000079	100005519	100014601
100000941	100000100	100000079	100005520	100014613
100000939	100000100	100000079	100005521	100014498
100000939	100000100	100000079	100005522	100014525
100000940	100000100	100000079	100005522	100014525
100000939	100000100	100000079	100005525	100014519
100000940	100000100	100000079	100005525	100014519
100000939	100000100	100000079	100005527	100014653
100000939	100000100	100000079	100005528	100014508
100000941	100000100	100000079	100005529	100014617
100000939	100000100	100000079	100005530	100014529
100000940	100000100	100000079	100005530	100014529
100000939	100000100	100000079	100005533	100014448
100000939	100000100	100000079	100005534	100014801
100000939	100000100	100000079	100005535	100014577
100000940	100000100	100000079	100005535	100014577
100000939	100000100	100000079	100005538	100014451
100000939	100000100	100000079	100005545	100014455
100000941	100000100	100000079	100005546	100014602
100000939	100000100	100000079	100005548	100014472
100000939	100000100	100000079	100005550	100014795
100000939	100000100	100000079	100005551	100014441
100000939	100000100	100000079	100005552	100014768
100000941	100000100	100000079	100005553	100014605
100000939	100000100	100000079	100005554	100014475
100000939	100000100	100000079	100005556	100014444
100000939	100000100	100000079	100005557	100014772
100000941	100000100	100000079	100005558	100014609
100000939	100000100	100000079	100005559	100014479
100000939	100000100	100000079	100005560	100014480
100000940	100000100	100000079	100005561	100014967
100000939	100000100	100000079	100005562	100014481
100000939	100000100	100000079	100005563	100014484
100000939	100000100	100000079	100005565	100014488
100000939	100000100	100000079	100005571	100015036
100000939	100000100	100000079	100005572	100015039
100000939	100000100	100000079	100005573	100015042
100000938	100000100	100000079	100005574	100014955
100000947	100000100	100000079	100005574	100014955
100000939	100000100	100000079	100005577	100015043
100000939	100000100	100000079	100005578	100015047
100000939	100000100	100000079	100005579	100015050
100000939	100000100	100000079	100005580	100015051
100000939	100000100	100000079	100005581	100015056
100000939	100000100	100000079	100005582	100015087
100000939	100000100	100000079	100005584	100015089
100000939	100000100	100000079	100005585	100015092
100000939	100000100	100000079	100005586	100015095
100000939	100000100	100000079	100005588	100015096
100000939	100000100	100000079	100005589	100015100
100000939	100000100	100000079	100005591	100015102
100000939	100000100	100000079	100005592	100015106
100000939	100000100	100000079	100005593	100015109
100000939	100000100	100000079	100005594	100015113
100000939	100000100	100000079	100005597	100015122
100000939	100000100	100000079	100005598	100015125
100000939	100000100	100000079	100005599	100015137
100000945	100000100	100000079	100005599	100015137
100000938	100000100	100000079	100005600	100015159
100000947	100000100	100000079	100005600	100015159
100000940	100000100	100000079	100005601	100015160
100000938	100000100	100000079	100005602	100015166
100000947	100000100	100000079	100005602	100015166
100000940	100000100	100000079	100005604	100015169
100000939	100000100	100000079	100005605	100015172
100000940	100000100	100000079	100005612	100015235
100000940	100000100	100000079	100005613	100015239
100000940	100000100	100000079	100005614	100015244
100000939	100000100	100000079	100005619	100015269
100000944	100000100	100000079	100005620	100015273
100000939	100000100	100000079	100005623	100015289
100000939	100000100	100000079	100005624	100015290
100000939	100000100	100000079	100005625	100015291
100000939	100000100	100000079	100005626	100015295
100000939	100000100	100000079	100005627	100015302
100000939	100000100	100000079	100005629	100015345
100000939	100000100	100000079	100005630	100015348
100000939	100000100	100000079	100005631	100015351
100000938	100000100	100000079	100005632	100015352
100000947	100000100	100000079	100005632	100015352
100000939	100000100	100000079	100005634	100015355
100000939	100000100	100000079	100005635	100015359
100000939	100000100	100000079	100005636	100015362
100000940	100000100	100000079	100005638	100015376
100000939	100000100	100000079	100005640	100015380
100000939	100000100	100000079	100005641	100015382
100000939	100000100	100000079	100005642	100015386
100000938	100000100	100000079	100005643	100015405
100000947	100000100	100000079	100005643	100015405
100000939	100000100	100000079	100005645	100015409
100000939	100000100	100000079	100005646	100015411
100000939	100000100	100000079	100005647	100015416
100000939	100000100	100000079	100005648	100015426
100000938	100000100	100000079	100005649	100015450
100000947	100000100	100000079	100005649	100015450
100000949	100000100	100000079	100005652	100015455
100000940	100000100	100000079	100005653	100015456
100000940	100000100	100000079	100005654	100015459
100000939	100000100	100000079	100005656	100015472
100000939	100000100	100000079	100005657	100015474
100000939	100000100	100000079	100005658	100015478
100000938	100000100	100000079	100005661	100014511
100000947	100000100	100000079	100005661	100014511
100000939	100000100	100000079	100005662	100014539
100000939	100000100	100000079	100005663	100015486
100000939	100000100	100000079	100005664	100015489
100000939	100000100	100000079	100005665	100015491
100000939	100000100	100000079	100005666	100015493
100000938	100000100	100000079	100005668	100015502
100000941	100000100	100000079	100005669	100015542
100000939	100000100	100000079	100005670	100015549
100000938	100000100	100000079	100005678	100015592
100000939	100000100	100000079	100005680	100015625
100000939	100000100	100000079	100005681	100015627
100000939	100000100	100000079	100005682	100015631
100000938	100000100	100000079	100005683	100015641
100000939	100000100	100000079	100005685	100015649
100000939	100000100	100000079	100005686	100015650
100000939	100000100	100000079	100005687	100015654
100000939	100000100	100000079	100005688	100015682
100000938	100000100	100000079	100005689	100015760
100000939	100000100	100000079	100005691	100015762
100000939	100000100	100000079	100005692	100015766
100000939	100000100	100000079	100005693	100015768
100000940	100000100	100000079	100005694	100015790
100000939	100000100	100000079	100005695	100015793
\.


--
-- Data for Name: rel_perfil_recurso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rel_perfil_recurso (id_perfil, id_sistema, id_recurso) FROM stdin;
100000931	100000099	100014301
100000931	100000099	100014302
100000931	100000099	100014303
100000931	100000099	100014304
100000931	100000099	100014305
100000931	100000099	100014306
100000931	100000099	100014307
100000931	100000099	100014308
100000931	100000099	100014309
100000931	100000099	100014310
100000931	100000099	100014311
100000931	100000099	100014312
100000931	100000099	100014313
100000931	100000099	100014314
100000931	100000099	100014315
100000931	100000099	100014316
100000931	100000099	100014317
100000931	100000099	100014324
100000931	100000099	100014325
100000931	100000099	100014326
100000931	100000099	100014327
100000931	100000099	100014328
100000931	100000099	100014329
100000931	100000099	100014330
100000931	100000099	100014331
100000931	100000099	100014332
100000931	100000099	100014333
100000931	100000099	100014334
100000931	100000099	100014335
100000931	100000099	100014336
100000931	100000099	100014337
100000931	100000099	100014338
100000931	100000099	100014339
100000931	100000099	100014340
100000931	100000099	100014341
100000931	100000099	100014342
100000931	100000099	100014343
100000931	100000099	100014344
100000931	100000099	100014345
100000931	100000099	100014346
100000931	100000099	100014347
100000931	100000099	100014348
100000931	100000099	100014349
100000931	100000099	100014350
100000931	100000099	100014351
100000931	100000099	100014352
100000931	100000099	100014353
100000931	100000099	100014354
100000931	100000099	100014355
100000931	100000099	100014356
100000931	100000099	100014357
100000931	100000099	100014358
100000931	100000099	100014359
100000931	100000099	100014360
100000931	100000099	100014361
100000931	100000099	100014362
100000931	100000099	100014363
100000931	100000099	100014364
100000931	100000099	100014365
100000931	100000099	100014366
100000931	100000099	100014367
100000931	100000099	100014368
100000931	100000099	100014369
100000931	100000099	100014370
100000931	100000099	100014371
100000931	100000099	100014372
100000931	100000099	100014373
100000931	100000099	100014374
100000931	100000099	100014375
100000931	100000099	100014376
100000931	100000099	100014377
100000931	100000099	100014378
100000931	100000099	100014379
100000931	100000099	100014380
100000931	100000099	100014381
100000931	100000099	100014382
100000931	100000099	100014383
100000931	100000099	100014384
100000931	100000099	100014385
100000931	100000099	100014386
100000931	100000099	100014387
100000931	100000099	100014388
100000931	100000099	100014389
100000931	100000099	100014390
100000931	100000099	100014391
100000931	100000099	100014392
100000931	100000099	100014393
100000931	100000099	100014394
100000931	100000099	100014395
100000931	100000099	100014396
100000931	100000099	100014405
100000931	100000099	100014406
100000931	100000099	100014407
100000931	100000099	100014408
100000931	100000099	100014409
100000931	100000099	100014410
100000931	100000099	100014414
100000931	100000099	100014415
100000931	100000099	100014416
100000931	100000099	100014417
100000931	100000099	100014418
100000931	100000099	100014419
100000931	100000099	100014420
100000931	100000099	100014421
100000931	100000099	100014422
100000931	100000099	100014423
100000931	100000099	100014424
100000931	100000099	100015187
100000931	100000099	100015188
100000931	100000099	100015190
100000931	100000099	100015191
100000931	100000099	100015192
100000931	100000099	100015193
100000931	100000099	100015194
100000931	100000099	100015195
100000931	100000099	100015196
100000931	100000099	100015197
100000931	100000099	100015198
100000931	100000099	100015259
100000931	100000099	100015265
100000931	100000099	100015363
100000931	100000099	100015364
100000931	100000099	100015365
100000931	100000099	100015366
100000931	100000099	100015368
100000931	100000099	100015369
100000931	100000099	100015370
100000931	100000099	100015451
100000931	100000099	100015452
100000931	100000099	100015554
100000931	100000099	100015555
100000931	100000099	100015556
100000931	100000099	100015557
100000931	100000099	100015560
100000931	100000099	100015562
100000931	100000099	100015563
100000931	100000099	100015565
100000931	100000099	100015566
100000931	100000099	100015567
100000931	100000099	100015568
100000931	100000099	100015570
100000931	100000099	100015571
100000931	100000099	100015572
100000931	100000099	100015580
100000931	100000099	100015581
100000931	100000099	100015582
100000931	100000099	100015583
100000932	100000099	100014302
100000932	100000099	100014303
100000932	100000099	100014308
100000932	100000099	100014313
100000932	100000099	100014325
100000932	100000099	100014340
100000932	100000099	100014351
100000932	100000099	100014355
100000932	100000099	100014359
100000932	100000099	100014360
100000932	100000099	100014365
100000932	100000099	100014367
100000932	100000099	100014370
100000932	100000099	100014375
100000932	100000099	100014379
100000932	100000099	100014381
100000932	100000099	100014382
100000932	100000099	100014386
100000932	100000099	100014387
100000932	100000099	100014388
100000932	100000099	100015178
100000932	100000099	100015179
100000932	100000099	100015184
100000932	100000099	100015186
100000932	100000099	100015371
100000932	100000099	100015558
100000932	100000099	100015559
100000932	100000099	100015560
100000932	100000099	100015561
100000932	100000099	100015563
100000932	100000099	100015564
100000932	100000099	100015568
100000932	100000099	100015569
100000932	100000099	100015573
100000932	100000099	100015574
100000932	100000099	100015575
100000932	100000099	100015576
100000932	100000099	100015577
100000932	100000099	100015578
100000932	100000099	100015579
100000933	100000099	100014302
100000933	100000099	100014303
100000933	100000099	100014304
100000933	100000099	100014308
100000933	100000099	100014309
100000933	100000099	100014313
100000933	100000099	100014314
100000933	100000099	100014324
100000933	100000099	100014325
100000933	100000099	100014326
100000933	100000099	100014328
100000933	100000099	100014329
100000933	100000099	100014334
100000933	100000099	100014335
100000933	100000099	100014340
100000933	100000099	100014345
100000933	100000099	100014346
100000933	100000099	100014350
100000933	100000099	100014351
100000933	100000099	100014352
100000933	100000099	100014353
100000933	100000099	100014354
100000933	100000099	100014355
100000933	100000099	100014356
100000933	100000099	100014357
100000933	100000099	100014358
100000933	100000099	100014359
100000933	100000099	100014360
100000933	100000099	100014361
100000933	100000099	100014362
100000933	100000099	100014363
100000933	100000099	100014364
100000933	100000099	100014365
100000933	100000099	100014366
100000933	100000099	100014367
100000933	100000099	100014368
100000933	100000099	100014369
100000933	100000099	100014370
100000933	100000099	100014371
100000933	100000099	100014372
100000933	100000099	100014373
100000933	100000099	100014374
100000933	100000099	100014375
100000933	100000099	100014376
100000933	100000099	100014377
100000933	100000099	100014378
100000933	100000099	100014379
100000933	100000099	100014380
100000933	100000099	100014381
100000933	100000099	100014382
100000933	100000099	100014383
100000933	100000099	100014384
100000933	100000099	100014385
100000933	100000099	100014386
100000933	100000099	100014387
100000933	100000099	100014388
100000933	100000099	100014389
100000933	100000099	100014390
100000933	100000099	100014391
100000933	100000099	100014392
100000933	100000099	100014395
100000933	100000099	100014396
100000933	100000099	100014409
100000933	100000099	100014412
100000933	100000099	100015176
100000933	100000099	100015177
100000933	100000099	100015180
100000933	100000099	100015181
100000933	100000099	100015182
100000933	100000099	100015183
100000933	100000099	100015185
100000933	100000099	100015188
100000933	100000099	100015199
100000933	100000099	100015200
100000933	100000099	100015201
100000933	100000099	100015202
100000933	100000099	100015203
100000933	100000099	100015204
100000933	100000099	100015205
100000933	100000099	100015206
100000933	100000099	100015207
100000933	100000099	100015208
100000933	100000099	100015209
100000933	100000099	100015210
100000933	100000099	100015551
100000933	100000099	100015552
100000933	100000099	100015582
100000933	100000099	100015583
100000935	100000099	100014334
100000935	100000099	100014335
100000935	100000099	100014339
100000935	100000099	100014340
100000935	100000099	100014341
100000935	100000099	100014342
100000935	100000099	100014343
100000935	100000099	100014344
100000935	100000099	100014345
100000935	100000099	100014346
100000935	100000099	100014347
100000935	100000099	100014348
100000935	100000099	100014349
100000935	100000099	100014350
100000935	100000099	100014351
100000935	100000099	100014352
100000935	100000099	100014408
100000935	100000099	100014410
100000936	100000099	100014302
100000936	100000099	100014303
100000936	100000099	100014308
100000936	100000099	100014313
100000936	100000099	100014314
100000936	100000099	100014325
100000936	100000099	100014334
100000936	100000099	100014335
100000936	100000099	100014340
100000936	100000099	100014355
100000936	100000099	100014359
100000936	100000099	100014360
100000936	100000099	100014365
100000936	100000099	100014370
100000936	100000099	100014375
100000936	100000099	100014379
100000936	100000099	100014380
100000936	100000099	100014381
100000936	100000099	100014382
100000936	100000099	100014383
100000936	100000099	100014384
100000936	100000099	100014385
100000936	100000099	100014386
100000936	100000099	100014387
100000936	100000099	100014388
100000936	100000099	100014412
100000936	100000099	100015558
100000937	100000099	100014327
100000937	100000099	100014328
100000937	100000099	100014330
100000937	100000099	100014331
100000937	100000099	100014332
100000937	100000099	100014344
100000937	100000099	100014345
100000937	100000099	100014347
100000937	100000099	100014348
100000937	100000099	100014349
100000937	100000099	100014407
100000937	100000099	100014408
100000938	100000100	100014435
100000938	100000100	100014436
100000938	100000100	100014437
100000938	100000100	100014438
100000938	100000100	100014439
100000938	100000100	100014440
100000938	100000100	100014443
100000938	100000100	100014444
100000938	100000100	100014445
100000938	100000100	100014450
100000938	100000100	100014451
100000938	100000100	100014452
100000938	100000100	100014466
100000938	100000100	100014467
100000938	100000100	100014468
100000938	100000100	100014474
100000938	100000100	100014475
100000938	100000100	100014476
100000938	100000100	100014483
100000938	100000100	100014484
100000938	100000100	100014485
100000938	100000100	100014491
100000938	100000100	100014492
100000938	100000100	100014493
100000938	100000100	100014497
100000938	100000100	100014498
100000938	100000100	100014499
100000938	100000100	100014508
100000938	100000100	100014509
100000938	100000100	100014510
100000938	100000100	100014511
100000938	100000100	100014512
100000938	100000100	100014513
100000938	100000100	100014514
100000938	100000100	100014515
100000938	100000100	100014518
100000938	100000100	100014519
100000938	100000100	100014520
100000938	100000100	100014524
100000938	100000100	100014525
100000938	100000100	100014526
100000938	100000100	100014530
100000938	100000100	100014531
100000938	100000100	100014532
100000938	100000100	100014533
100000938	100000100	100014534
100000938	100000100	100014535
100000938	100000100	100014536
100000938	100000100	100014537
100000938	100000100	100014538
100000938	100000100	100014539
100000938	100000100	100014540
100000938	100000100	100014541
100000938	100000100	100014544
100000938	100000100	100014545
100000938	100000100	100014546
100000938	100000100	100014550
100000938	100000100	100014551
100000938	100000100	100014552
100000938	100000100	100014553
100000938	100000100	100014554
100000938	100000100	100014555
100000938	100000100	100014556
100000938	100000100	100014557
100000938	100000100	100014559
100000938	100000100	100014563
100000938	100000100	100014566
100000938	100000100	100014567
100000938	100000100	100014568
100000938	100000100	100014569
100000938	100000100	100014570
100000938	100000100	100014571
100000938	100000100	100014572
100000938	100000100	100014573
100000938	100000100	100014574
100000938	100000100	100014575
100000938	100000100	100014580
100000938	100000100	100014581
100000938	100000100	100014582
100000938	100000100	100014588
100000938	100000100	100014589
100000938	100000100	100014590
100000938	100000100	100014596
100000938	100000100	100014597
100000938	100000100	100014598
100000938	100000100	100014604
100000938	100000100	100014605
100000938	100000100	100014606
100000938	100000100	100014612
100000938	100000100	100014613
100000938	100000100	100014614
100000938	100000100	100014618
100000938	100000100	100014619
100000938	100000100	100014620
100000938	100000100	100014621
100000938	100000100	100014622
100000938	100000100	100014625
100000938	100000100	100014626
100000938	100000100	100014627
100000938	100000100	100014629
100000938	100000100	100014630
100000938	100000100	100014631
100000938	100000100	100014632
100000938	100000100	100014633
100000938	100000100	100014634
100000938	100000100	100014635
100000938	100000100	100014636
100000938	100000100	100014637
100000938	100000100	100014638
100000938	100000100	100014639
100000938	100000100	100014640
100000938	100000100	100014641
100000938	100000100	100014642
100000938	100000100	100014643
100000938	100000100	100014644
100000938	100000100	100014648
100000938	100000100	100014649
100000938	100000100	100014650
100000938	100000100	100014657
100000938	100000100	100014658
100000938	100000100	100014659
100000938	100000100	100014660
100000938	100000100	100014669
100000938	100000100	100014670
100000938	100000100	100014671
100000938	100000100	100014672
100000938	100000100	100014673
100000938	100000100	100014674
100000938	100000100	100014675
100000938	100000100	100014676
100000938	100000100	100014677
100000938	100000100	100014681
100000938	100000100	100014682
100000938	100000100	100014683
100000938	100000100	100014684
100000938	100000100	100014688
100000938	100000100	100014693
100000938	100000100	100014696
100000938	100000100	100014698
100000938	100000100	100014699
100000938	100000100	100014700
100000938	100000100	100014701
100000938	100000100	100014702
100000938	100000100	100014703
100000938	100000100	100014704
100000938	100000100	100014705
100000938	100000100	100014706
100000938	100000100	100014707
100000938	100000100	100014708
100000938	100000100	100014709
100000938	100000100	100014710
100000938	100000100	100014711
100000938	100000100	100014712
100000938	100000100	100014713
100000938	100000100	100014719
100000938	100000100	100014722
100000938	100000100	100014725
100000938	100000100	100014726
100000938	100000100	100014727
100000938	100000100	100014732
100000938	100000100	100014738
100000938	100000100	100014740
100000938	100000100	100014741
100000938	100000100	100014742
100000938	100000100	100014745
100000938	100000100	100014746
100000938	100000100	100014747
100000938	100000100	100014749
100000938	100000100	100014750
100000938	100000100	100014751
100000938	100000100	100014754
100000938	100000100	100014755
100000938	100000100	100014757
100000938	100000100	100014759
100000938	100000100	100014767
100000938	100000100	100014768
100000938	100000100	100014769
100000938	100000100	100014773
100000938	100000100	100014774
100000938	100000100	100014775
100000938	100000100	100014776
100000938	100000100	100014777
100000938	100000100	100014778
100000938	100000100	100014779
100000938	100000100	100014780
100000938	100000100	100014781
100000938	100000100	100014782
100000938	100000100	100014783
100000938	100000100	100014784
100000938	100000100	100014785
100000938	100000100	100014786
100000938	100000100	100014787
100000938	100000100	100014788
100000938	100000100	100014789
100000938	100000100	100014790
100000938	100000100	100014791
100000938	100000100	100014794
100000938	100000100	100014795
100000938	100000100	100014798
100000938	100000100	100014799
100000938	100000100	100014802
100000938	100000100	100014803
100000938	100000100	100014804
100000938	100000100	100014805
100000938	100000100	100014806
100000938	100000100	100014807
100000938	100000100	100014808
100000938	100000100	100014809
100000938	100000100	100014810
100000938	100000100	100014811
100000938	100000100	100014812
100000938	100000100	100014813
100000938	100000100	100014814
100000938	100000100	100014815
100000938	100000100	100014816
100000938	100000100	100014817
100000938	100000100	100014818
100000938	100000100	100014819
100000938	100000100	100014820
100000938	100000100	100014821
100000938	100000100	100014822
100000938	100000100	100014824
100000938	100000100	100014825
100000938	100000100	100014826
100000938	100000100	100014827
100000938	100000100	100014828
100000938	100000100	100014833
100000938	100000100	100014834
100000938	100000100	100014836
100000938	100000100	100014837
100000938	100000100	100014838
100000938	100000100	100014839
100000938	100000100	100014840
100000938	100000100	100014841
100000938	100000100	100014843
100000938	100000100	100014845
100000938	100000100	100014847
100000938	100000100	100014848
100000938	100000100	100014849
100000938	100000100	100014850
100000938	100000100	100014851
100000938	100000100	100014852
100000938	100000100	100014853
100000938	100000100	100014856
100000938	100000100	100014857
100000938	100000100	100014861
100000938	100000100	100014862
100000938	100000100	100014864
100000938	100000100	100014865
100000938	100000100	100014866
100000938	100000100	100014867
100000938	100000100	100014868
100000938	100000100	100014869
100000938	100000100	100014870
100000938	100000100	100014871
100000938	100000100	100014873
100000938	100000100	100014874
100000938	100000100	100014875
100000938	100000100	100014876
100000938	100000100	100014877
100000938	100000100	100014878
100000938	100000100	100014879
100000938	100000100	100014880
100000938	100000100	100014881
100000938	100000100	100014886
100000938	100000100	100014887
100000938	100000100	100014888
100000938	100000100	100014892
100000938	100000100	100014893
100000938	100000100	100014895
100000938	100000100	100014896
100000938	100000100	100014897
100000938	100000100	100014898
100000938	100000100	100014899
100000938	100000100	100014905
100000938	100000100	100014906
100000938	100000100	100014909
100000938	100000100	100014911
100000938	100000100	100014912
100000938	100000100	100014913
100000938	100000100	100014914
100000938	100000100	100014915
100000938	100000100	100014916
100000938	100000100	100014917
100000938	100000100	100014918
100000938	100000100	100014923
100000938	100000100	100014925
100000938	100000100	100014927
100000938	100000100	100014928
100000938	100000100	100014929
100000938	100000100	100014930
100000938	100000100	100014931
100000938	100000100	100014932
100000938	100000100	100014933
100000938	100000100	100014934
100000938	100000100	100014935
100000938	100000100	100014936
100000938	100000100	100014937
100000938	100000100	100014938
100000938	100000100	100014939
100000938	100000100	100014940
100000938	100000100	100014941
100000938	100000100	100014942
100000938	100000100	100014947
100000938	100000100	100014948
100000938	100000100	100014952
100000938	100000100	100014953
100000938	100000100	100014954
100000938	100000100	100014955
100000938	100000100	100014956
100000938	100000100	100014957
100000938	100000100	100014963
100000938	100000100	100014966
100000938	100000100	100014967
100000938	100000100	100014970
100000938	100000100	100014973
100000938	100000100	100014976
100000938	100000100	100014978
100000938	100000100	100014979
100000938	100000100	100014980
100000938	100000100	100014981
100000938	100000100	100014982
100000938	100000100	100014985
100000938	100000100	100014987
100000938	100000100	100014988
100000938	100000100	100014989
100000938	100000100	100014991
100000938	100000100	100014992
100000938	100000100	100014993
100000938	100000100	100014994
100000938	100000100	100014995
100000938	100000100	100014996
100000938	100000100	100014997
100000938	100000100	100014998
100000938	100000100	100014999
100000938	100000100	100015000
100000938	100000100	100015001
100000938	100000100	100015007
100000938	100000100	100015008
100000938	100000100	100015009
100000938	100000100	100015010
100000938	100000100	100015011
100000938	100000100	100015012
100000938	100000100	100015014
100000938	100000100	100015015
100000938	100000100	100015016
100000938	100000100	100015017
100000938	100000100	100015018
100000938	100000100	100015019
100000938	100000100	100015020
100000938	100000100	100015021
100000938	100000100	100015022
100000938	100000100	100015023
100000938	100000100	100015045
100000938	100000100	100015046
100000938	100000100	100015047
100000938	100000100	100015054
100000938	100000100	100015055
100000938	100000100	100015056
100000938	100000100	100015060
100000938	100000100	100015061
100000938	100000100	100015062
100000938	100000100	100015066
100000938	100000100	100015067
100000938	100000100	100015068
100000938	100000100	100015070
100000938	100000100	100015071
100000938	100000100	100015072
100000938	100000100	100015073
100000938	100000100	100015074
100000938	100000100	100015075
100000938	100000100	100015076
100000938	100000100	100015077
100000938	100000100	100015078
100000938	100000100	100015079
100000938	100000100	100015080
100000938	100000100	100015081
100000938	100000100	100015084
100000938	100000100	100015087
100000938	100000100	100015088
100000938	100000100	100015091
100000938	100000100	100015092
100000938	100000100	100015098
100000938	100000100	100015099
100000938	100000100	100015100
100000938	100000100	100015104
100000938	100000100	100015105
100000938	100000100	100015106
100000938	100000100	100015110
100000938	100000100	100015111
100000938	100000100	100015112
100000938	100000100	100015113
100000938	100000100	100015121
100000938	100000100	100015122
100000938	100000100	100015126
100000938	100000100	100015127
100000938	100000100	100015128
100000938	100000100	100015129
100000938	100000100	100015130
100000938	100000100	100015131
100000938	100000100	100015132
100000938	100000100	100015136
100000938	100000100	100015141
100000938	100000100	100015142
100000938	100000100	100015143
100000938	100000100	100015144
100000938	100000100	100015145
100000938	100000100	100015146
100000938	100000100	100015147
100000938	100000100	100015148
100000938	100000100	100015149
100000938	100000100	100015150
100000938	100000100	100015151
100000938	100000100	100015152
100000938	100000100	100015153
100000938	100000100	100015154
100000938	100000100	100015155
100000938	100000100	100015156
100000938	100000100	100015157
100000938	100000100	100015158
100000938	100000100	100015159
100000938	100000100	100015161
100000938	100000100	100015162
100000938	100000100	100015163
100000938	100000100	100015164
100000938	100000100	100015165
100000938	100000100	100015166
100000938	100000100	100015170
100000938	100000100	100015172
100000938	100000100	100015218
100000938	100000100	100015219
100000938	100000100	100015222
100000938	100000100	100015223
100000938	100000100	100015228
100000938	100000100	100015230
100000938	100000100	100015231
100000938	100000100	100015232
100000938	100000100	100015233
100000938	100000100	100015234
100000938	100000100	100015248
100000938	100000100	100015249
100000938	100000100	100015252
100000938	100000100	100015253
100000938	100000100	100015254
100000938	100000100	100015267
100000938	100000100	100015268
100000938	100000100	100015269
100000938	100000100	100015271
100000938	100000100	100015276
100000938	100000100	100015277
100000938	100000100	100015278
100000938	100000100	100015279
100000938	100000100	100015280
100000938	100000100	100015281
100000938	100000100	100015282
100000938	100000100	100015288
100000938	100000100	100015289
100000938	100000100	100015291
100000938	100000100	100015296
100000938	100000100	100015297
100000938	100000100	100015301
100000938	100000100	100015302
100000938	100000100	100015303
100000938	100000100	100015307
100000938	100000100	100015308
100000938	100000100	100015309
100000938	100000100	100015318
100000938	100000100	100015319
100000938	100000100	100015320
100000938	100000100	100015321
100000938	100000100	100015322
100000938	100000100	100015323
100000938	100000100	100015324
100000938	100000100	100015325
100000938	100000100	100015326
100000938	100000100	100015327
100000938	100000100	100015328
100000938	100000100	100015330
100000938	100000100	100015331
100000938	100000100	100015332
100000938	100000100	100015333
100000938	100000100	100015334
100000938	100000100	100015335
100000938	100000100	100015336
100000938	100000100	100015339
100000938	100000100	100015340
100000938	100000100	100015341
100000938	100000100	100015344
100000938	100000100	100015347
100000938	100000100	100015348
100000938	100000100	100015352
100000938	100000100	100015357
100000938	100000100	100015358
100000938	100000100	100015359
100000938	100000100	100015372
100000938	100000100	100015373
100000938	100000100	100015374
100000938	100000100	100015377
100000938	100000100	100015378
100000938	100000100	100015379
100000938	100000100	100015381
100000938	100000100	100015382
100000938	100000100	100015390
100000938	100000100	100015391
100000938	100000100	100015394
100000938	100000100	100015395
100000938	100000100	100015396
100000938	100000100	100015397
100000938	100000100	100015400
100000938	100000100	100015401
100000938	100000100	100015402
100000938	100000100	100015403
100000938	100000100	100015404
100000938	100000100	100015405
100000938	100000100	100015406
100000938	100000100	100015407
100000938	100000100	100015408
100000938	100000100	100015410
100000938	100000100	100015411
100000938	100000100	100015412
100000938	100000100	100015417
100000938	100000100	100015418
100000938	100000100	100015419
100000938	100000100	100015420
100000938	100000100	100015421
100000938	100000100	100015422
100000938	100000100	100015425
100000938	100000100	100015426
100000938	100000100	100015430
100000938	100000100	100015431
100000938	100000100	100015432
100000938	100000100	100015433
100000938	100000100	100015443
100000938	100000100	100015444
100000938	100000100	100015446
100000938	100000100	100015447
100000938	100000100	100015448
100000938	100000100	100015449
100000938	100000100	100015450
100000938	100000100	100015460
100000938	100000100	100015461
100000938	100000100	100015462
100000938	100000100	100015463
100000938	100000100	100015464
100000938	100000100	100015465
100000938	100000100	100015466
100000938	100000100	100015467
100000938	100000100	100015468
100000938	100000100	100015469
100000938	100000100	100015470
100000938	100000100	100015471
100000938	100000100	100015472
100000938	100000100	100015473
100000938	100000100	100015481
100000938	100000100	100015482
100000938	100000100	100015483
100000938	100000100	100015484
100000938	100000100	100015490
100000938	100000100	100015491
100000938	100000100	100015492
100000938	100000100	100015495
100000938	100000100	100015496
100000938	100000100	100015497
100000938	100000100	100015498
100000938	100000100	100015499
100000938	100000100	100015500
100000938	100000100	100015501
100000938	100000100	100015502
100000938	100000100	100015503
100000938	100000100	100015504
100000938	100000100	100015505
100000938	100000100	100015506
100000938	100000100	100015507
100000938	100000100	100015508
100000938	100000100	100015509
100000938	100000100	100015510
100000938	100000100	100015512
100000938	100000100	100015513
100000938	100000100	100015516
100000938	100000100	100015517
100000938	100000100	100015522
100000938	100000100	100015523
100000938	100000100	100015528
100000938	100000100	100015529
100000938	100000100	100015530
100000938	100000100	100015531
100000938	100000100	100015532
100000938	100000100	100015533
100000938	100000100	100015534
100000938	100000100	100015538
100000938	100000100	100015539
100000938	100000100	100015541
100000938	100000100	100015544
100000938	100000100	100015545
100000938	100000100	100015546
100000938	100000100	100015553
100000938	100000100	100015584
100000938	100000100	100015585
100000938	100000100	100015586
100000938	100000100	100015587
100000938	100000100	100015588
100000938	100000100	100015589
100000938	100000100	100015590
100000938	100000100	100015591
100000938	100000100	100015592
100000938	100000100	100015593
100000938	100000100	100015594
100000938	100000100	100015595
100000938	100000100	100015596
100000938	100000100	100015597
100000938	100000100	100015598
100000938	100000100	100015599
100000938	100000100	100015600
100000938	100000100	100015601
100000938	100000100	100015602
100000938	100000100	100015603
100000938	100000100	100015604
100000938	100000100	100015605
100000938	100000100	100015606
100000938	100000100	100015607
100000938	100000100	100015608
100000938	100000100	100015609
100000938	100000100	100015610
100000938	100000100	100015611
100000938	100000100	100015612
100000938	100000100	100015613
100000938	100000100	100015621
100000938	100000100	100015622
100000938	100000100	100015623
100000938	100000100	100015624
100000938	100000100	100015625
100000938	100000100	100015626
100000938	100000100	100015632
100000938	100000100	100015633
100000938	100000100	100015635
100000938	100000100	100015636
100000938	100000100	100015637
100000938	100000100	100015638
100000938	100000100	100015639
100000938	100000100	100015640
100000938	100000100	100015641
100000938	100000100	100015642
100000938	100000100	100015643
100000938	100000100	100015644
100000938	100000100	100015645
100000938	100000100	100015646
100000938	100000100	100015647
100000938	100000100	100015648
100000938	100000100	100015649
100000938	100000100	100015655
100000938	100000100	100015656
100000938	100000100	100015657
100000938	100000100	100015658
100000938	100000100	100015659
100000938	100000100	100015660
100000938	100000100	100015661
100000938	100000100	100015662
100000938	100000100	100015663
100000938	100000100	100015664
100000938	100000100	100015665
100000938	100000100	100015666
100000938	100000100	100015667
100000938	100000100	100015668
100000938	100000100	100015669
100000938	100000100	100015670
100000938	100000100	100015671
100000938	100000100	100015672
100000938	100000100	100015673
100000938	100000100	100015674
100000938	100000100	100015675
100000938	100000100	100015676
100000938	100000100	100015677
100000938	100000100	100015678
100000938	100000100	100015679
100000938	100000100	100015680
100000938	100000100	100015682
100000938	100000100	100015683
100000938	100000100	100015684
100000938	100000100	100015685
100000938	100000100	100015691
100000938	100000100	100015695
100000938	100000100	100015696
100000938	100000100	100015697
100000938	100000100	100015698
100000938	100000100	100015699
100000938	100000100	100015700
100000938	100000100	100015701
100000938	100000100	100015702
100000938	100000100	100015703
100000938	100000100	100015705
100000938	100000100	100015706
100000938	100000100	100015707
100000938	100000100	100015708
100000938	100000100	100015710
100000938	100000100	100015711
100000938	100000100	100015713
100000938	100000100	100015714
100000938	100000100	100015715
100000938	100000100	100015716
100000938	100000100	100015717
100000938	100000100	100015718
100000938	100000100	100015719
100000938	100000100	100015720
100000938	100000100	100015721
100000938	100000100	100015722
100000938	100000100	100015723
100000938	100000100	100015724
100000938	100000100	100015725
100000938	100000100	100015726
100000938	100000100	100015727
100000938	100000100	100015728
100000938	100000100	100015729
100000938	100000100	100015730
100000938	100000100	100015731
100000938	100000100	100015732
100000938	100000100	100015733
100000938	100000100	100015734
100000938	100000100	100015735
100000938	100000100	100015736
100000938	100000100	100015737
100000938	100000100	100015738
100000938	100000100	100015739
100000938	100000100	100015740
100000938	100000100	100015741
100000938	100000100	100015742
100000938	100000100	100015743
100000938	100000100	100015744
100000938	100000100	100015745
100000938	100000100	100015746
100000938	100000100	100015747
100000938	100000100	100015748
100000938	100000100	100015749
100000938	100000100	100015750
100000938	100000100	100015751
100000938	100000100	100015752
100000938	100000100	100015753
100000938	100000100	100015754
100000938	100000100	100015755
100000938	100000100	100015756
100000938	100000100	100015757
100000938	100000100	100015758
100000938	100000100	100015759
100000938	100000100	100015760
100000938	100000100	100015761
100000938	100000100	100015764
100000938	100000100	100015766
100000938	100000100	100015769
100000938	100000100	100015770
100000938	100000100	100015771
100000938	100000100	100015772
100000938	100000100	100015773
100000938	100000100	100015774
100000938	100000100	100015775
100000938	100000100	100015776
100000938	100000100	100015777
100000938	100000100	100015778
100000938	100000100	100015779
100000938	100000100	100015780
100000938	100000100	100015781
100000938	100000100	100015782
100000938	100000100	100015783
100000938	100000100	100015784
100000938	100000100	100015785
100000938	100000100	100015786
100000938	100000100	100015787
100000938	100000100	100015788
100000938	100000100	100015789
100000938	100000100	100015790
100000938	100000100	100015791
100000938	100000100	100015792
100000938	100000100	100015794
100000938	100000100	100015795
100000938	100000100	100015796
100000938	100000100	100015797
100000938	100000100	100015798
100000938	100000100	100015799
100000938	100000100	100015800
100000938	100000100	100015801
100000938	100000100	100015802
100000938	100000100	100015803
100000938	100000100	100015804
100000938	100000100	100015805
100000938	100000100	100015806
100000939	100000100	100014441
100000939	100000100	100014442
100000939	100000100	100014443
100000939	100000100	100014444
100000939	100000100	100014445
100000939	100000100	100014446
100000939	100000100	100014447
100000939	100000100	100014448
100000939	100000100	100014449
100000939	100000100	100014450
100000939	100000100	100014451
100000939	100000100	100014452
100000939	100000100	100014453
100000939	100000100	100014454
100000939	100000100	100014455
100000939	100000100	100014464
100000939	100000100	100014465
100000939	100000100	100014466
100000939	100000100	100014467
100000939	100000100	100014468
100000939	100000100	100014469
100000939	100000100	100014470
100000939	100000100	100014471
100000939	100000100	100014472
100000939	100000100	100014473
100000939	100000100	100014474
100000939	100000100	100014475
100000939	100000100	100014476
100000939	100000100	100014477
100000939	100000100	100014478
100000939	100000100	100014479
100000939	100000100	100014480
100000939	100000100	100014481
100000939	100000100	100014482
100000939	100000100	100014483
100000939	100000100	100014484
100000939	100000100	100014485
100000939	100000100	100014486
100000939	100000100	100014487
100000939	100000100	100014488
100000939	100000100	100014489
100000939	100000100	100014490
100000939	100000100	100014491
100000939	100000100	100014492
100000939	100000100	100014493
100000939	100000100	100014494
100000939	100000100	100014495
100000939	100000100	100014496
100000939	100000100	100014497
100000939	100000100	100014498
100000939	100000100	100014499
100000939	100000100	100014500
100000939	100000100	100014508
100000939	100000100	100014509
100000939	100000100	100014510
100000939	100000100	100014511
100000939	100000100	100014512
100000939	100000100	100014513
100000939	100000100	100014514
100000939	100000100	100014515
100000939	100000100	100014516
100000939	100000100	100014517
100000939	100000100	100014519
100000939	100000100	100014521
100000939	100000100	100014522
100000939	100000100	100014523
100000939	100000100	100014524
100000939	100000100	100014525
100000939	100000100	100014527
100000939	100000100	100014528
100000939	100000100	100014529
100000939	100000100	100014530
100000939	100000100	100014531
100000939	100000100	100014532
100000939	100000100	100014533
100000939	100000100	100014534
100000939	100000100	100014535
100000939	100000100	100014536
100000939	100000100	100014537
100000939	100000100	100014538
100000939	100000100	100014539
100000939	100000100	100014540
100000939	100000100	100014541
100000939	100000100	100014542
100000939	100000100	100014543
100000939	100000100	100014545
100000939	100000100	100014547
100000939	100000100	100014548
100000939	100000100	100014549
100000939	100000100	100014556
100000939	100000100	100014557
100000939	100000100	100014558
100000939	100000100	100014559
100000939	100000100	100014560
100000939	100000100	100014562
100000939	100000100	100014564
100000939	100000100	100014576
100000939	100000100	100014577
100000939	100000100	100014578
100000939	100000100	100014579
100000939	100000100	100014583
100000939	100000100	100014584
100000939	100000100	100014585
100000939	100000100	100014586
100000939	100000100	100014587
100000939	100000100	100014591
100000939	100000100	100014592
100000939	100000100	100014593
100000939	100000100	100014596
100000939	100000100	100014597
100000939	100000100	100014598
100000939	100000100	100014646
100000939	100000100	100014647
100000939	100000100	100014648
100000939	100000100	100014649
100000939	100000100	100014650
100000939	100000100	100014651
100000939	100000100	100014652
100000939	100000100	100014653
100000939	100000100	100014765
100000939	100000100	100014766
100000939	100000100	100014767
100000939	100000100	100014768
100000939	100000100	100014769
100000939	100000100	100014770
100000939	100000100	100014771
100000939	100000100	100014772
100000939	100000100	100014778
100000939	100000100	100014792
100000939	100000100	100014793
100000939	100000100	100014794
100000939	100000100	100014795
100000939	100000100	100014796
100000939	100000100	100014797
100000939	100000100	100014798
100000939	100000100	100014799
100000939	100000100	100014800
100000939	100000100	100014801
100000939	100000100	100014829
100000939	100000100	100014830
100000939	100000100	100014831
100000939	100000100	100014832
100000939	100000100	100014833
100000939	100000100	100014834
100000939	100000100	100014835
100000939	100000100	100014854
100000939	100000100	100014855
100000939	100000100	100014856
100000939	100000100	100014857
100000939	100000100	100014858
100000939	100000100	100014859
100000939	100000100	100014860
100000939	100000100	100014861
100000939	100000100	100014863
100000939	100000100	100014872
100000939	100000100	100014900
100000939	100000100	100014901
100000939	100000100	100014902
100000939	100000100	100014903
100000939	100000100	100014904
100000939	100000100	100014910
100000939	100000100	100014951
100000939	100000100	100014952
100000939	100000100	100014953
100000939	100000100	100014954
100000939	100000100	100014955
100000939	100000100	100014956
100000939	100000100	100014957
100000939	100000100	100014984
100000939	100000100	100014986
100000939	100000100	100015024
100000939	100000100	100015025
100000939	100000100	100015026
100000939	100000100	100015027
100000939	100000100	100015028
100000939	100000100	100015029
100000939	100000100	100015030
100000939	100000100	100015031
100000939	100000100	100015032
100000939	100000100	100015033
100000939	100000100	100015034
100000939	100000100	100015035
100000939	100000100	100015036
100000939	100000100	100015037
100000939	100000100	100015038
100000939	100000100	100015039
100000939	100000100	100015040
100000939	100000100	100015041
100000939	100000100	100015042
100000939	100000100	100015043
100000939	100000100	100015044
100000939	100000100	100015047
100000939	100000100	100015048
100000939	100000100	100015049
100000939	100000100	100015050
100000939	100000100	100015051
100000939	100000100	100015052
100000939	100000100	100015053
100000939	100000100	100015056
100000939	100000100	100015057
100000939	100000100	100015058
100000939	100000100	100015059
100000939	100000100	100015063
100000939	100000100	100015064
100000939	100000100	100015065
100000939	100000100	100015069
100000939	100000100	100015083
100000939	100000100	100015085
100000939	100000100	100015086
100000939	100000100	100015087
100000939	100000100	100015089
100000939	100000100	100015090
100000939	100000100	100015092
100000939	100000100	100015093
100000939	100000100	100015094
100000939	100000100	100015095
100000939	100000100	100015096
100000939	100000100	100015097
100000939	100000100	100015100
100000939	100000100	100015101
100000939	100000100	100015102
100000939	100000100	100015103
100000939	100000100	100015106
100000939	100000100	100015107
100000939	100000100	100015108
100000939	100000100	100015109
100000939	100000100	100015113
100000939	100000100	100015114
100000939	100000100	100015115
100000939	100000100	100015119
100000939	100000100	100015120
100000939	100000100	100015122
100000939	100000100	100015123
100000939	100000100	100015124
100000939	100000100	100015125
100000939	100000100	100015133
100000939	100000100	100015137
100000939	100000100	100015138
100000939	100000100	100015139
100000939	100000100	100015171
100000939	100000100	100015172
100000939	100000100	100015246
100000939	100000100	100015247
100000939	100000100	100015250
100000939	100000100	100015251
100000939	100000100	100015269
100000939	100000100	100015283
100000939	100000100	100015284
100000939	100000100	100015285
100000939	100000100	100015286
100000939	100000100	100015287
100000939	100000100	100015289
100000939	100000100	100015290
100000939	100000100	100015291
100000939	100000100	100015292
100000939	100000100	100015293
100000939	100000100	100015294
100000939	100000100	100015295
100000939	100000100	100015298
100000939	100000100	100015299
100000939	100000100	100015300
100000939	100000100	100015302
100000939	100000100	100015304
100000939	100000100	100015305
100000939	100000100	100015306
100000939	100000100	100015329
100000939	100000100	100015337
100000939	100000100	100015338
100000939	100000100	100015342
100000939	100000100	100015343
100000939	100000100	100015345
100000939	100000100	100015346
100000939	100000100	100015348
100000939	100000100	100015349
100000939	100000100	100015350
100000939	100000100	100015351
100000939	100000100	100015353
100000939	100000100	100015354
100000939	100000100	100015355
100000939	100000100	100015356
100000939	100000100	100015359
100000939	100000100	100015360
100000939	100000100	100015361
100000939	100000100	100015362
100000939	100000100	100015380
100000939	100000100	100015382
100000939	100000100	100015383
100000939	100000100	100015384
100000939	100000100	100015385
100000939	100000100	100015386
100000939	100000100	100015387
100000939	100000100	100015388
100000939	100000100	100015389
100000939	100000100	100015392
100000939	100000100	100015393
100000939	100000100	100015398
100000939	100000100	100015399
100000939	100000100	100015409
100000939	100000100	100015411
100000939	100000100	100015413
100000939	100000100	100015414
100000939	100000100	100015415
100000939	100000100	100015416
100000939	100000100	100015423
100000939	100000100	100015424
100000939	100000100	100015426
100000939	100000100	100015427
100000939	100000100	100015428
100000939	100000100	100015429
100000939	100000100	100015442
100000939	100000100	100015445
100000939	100000100	100015472
100000939	100000100	100015474
100000939	100000100	100015475
100000939	100000100	100015476
100000939	100000100	100015477
100000939	100000100	100015478
100000939	100000100	100015479
100000939	100000100	100015480
100000939	100000100	100015485
100000939	100000100	100015486
100000939	100000100	100015487
100000939	100000100	100015488
100000939	100000100	100015489
100000939	100000100	100015491
100000939	100000100	100015493
100000939	100000100	100015494
100000939	100000100	100015511
100000939	100000100	100015514
100000939	100000100	100015515
100000939	100000100	100015518
100000939	100000100	100015519
100000939	100000100	100015520
100000939	100000100	100015521
100000939	100000100	100015524
100000939	100000100	100015525
100000939	100000100	100015526
100000939	100000100	100015527
100000939	100000100	100015529
100000939	100000100	100015535
100000939	100000100	100015536
100000939	100000100	100015537
100000939	100000100	100015547
100000939	100000100	100015548
100000939	100000100	100015549
100000939	100000100	100015614
100000939	100000100	100015615
100000939	100000100	100015616
100000939	100000100	100015617
100000939	100000100	100015618
100000939	100000100	100015619
100000939	100000100	100015620
100000939	100000100	100015625
100000939	100000100	100015627
100000939	100000100	100015628
100000939	100000100	100015629
100000939	100000100	100015630
100000939	100000100	100015631
100000939	100000100	100015634
100000939	100000100	100015649
100000939	100000100	100015650
100000939	100000100	100015651
100000939	100000100	100015652
100000939	100000100	100015653
100000939	100000100	100015654
100000939	100000100	100015681
100000939	100000100	100015682
100000939	100000100	100015686
100000939	100000100	100015687
100000939	100000100	100015688
100000939	100000100	100015689
100000939	100000100	100015690
100000939	100000100	100015692
100000939	100000100	100015693
100000939	100000100	100015694
100000939	100000100	100015704
100000939	100000100	100015709
100000939	100000100	100015712
100000939	100000100	100015762
100000939	100000100	100015763
100000939	100000100	100015765
100000939	100000100	100015766
100000939	100000100	100015767
100000939	100000100	100015768
100000939	100000100	100015793
100000940	100000100	100014484
100000940	100000100	100014509
100000940	100000100	100014516
100000940	100000100	100014517
100000940	100000100	100014518
100000940	100000100	100014519
100000940	100000100	100014520
100000940	100000100	100014521
100000940	100000100	100014522
100000940	100000100	100014523
100000940	100000100	100014524
100000940	100000100	100014525
100000940	100000100	100014526
100000940	100000100	100014527
100000940	100000100	100014528
100000940	100000100	100014529
100000940	100000100	100014559
100000940	100000100	100014561
100000940	100000100	100014565
100000940	100000100	100014576
100000940	100000100	100014577
100000940	100000100	100014578
100000940	100000100	100014579
100000940	100000100	100014580
100000940	100000100	100014581
100000940	100000100	100014582
100000940	100000100	100014583
100000940	100000100	100014584
100000940	100000100	100014585
100000940	100000100	100014707
100000940	100000100	100014708
100000940	100000100	100014711
100000940	100000100	100014712
100000940	100000100	100014719
100000940	100000100	100014740
100000940	100000100	100014743
100000940	100000100	100014744
100000940	100000100	100014745
100000940	100000100	100014746
100000940	100000100	100014747
100000940	100000100	100014748
100000940	100000100	100014752
100000940	100000100	100014753
100000940	100000100	100014754
100000940	100000100	100014755
100000940	100000100	100014756
100000940	100000100	100014760
100000940	100000100	100014761
100000940	100000100	100014762
100000940	100000100	100014763
100000940	100000100	100014764
100000940	100000100	100014799
100000940	100000100	100014862
100000940	100000100	100014883
100000940	100000100	100014884
100000940	100000100	100014885
100000940	100000100	100014893
100000940	100000100	100014910
100000940	100000100	100014964
100000940	100000100	100014965
100000940	100000100	100014966
100000940	100000100	100014967
100000940	100000100	100014968
100000940	100000100	100014969
100000940	100000100	100014970
100000940	100000100	100014971
100000940	100000100	100014972
100000940	100000100	100014973
100000940	100000100	100014974
100000940	100000100	100014975
100000940	100000100	100014976
100000940	100000100	100014977
100000940	100000100	100015082
100000940	100000100	100015083
100000940	100000100	100015117
100000940	100000100	100015134
100000940	100000100	100015135
100000940	100000100	100015160
100000940	100000100	100015169
100000940	100000100	100015235
100000940	100000100	100015236
100000940	100000100	100015237
100000940	100000100	100015238
100000940	100000100	100015239
100000940	100000100	100015240
100000940	100000100	100015241
100000940	100000100	100015242
100000940	100000100	100015243
100000940	100000100	100015244
100000940	100000100	100015375
100000940	100000100	100015376
100000940	100000100	100015398
100000940	100000100	100015399
100000940	100000100	100015456
100000940	100000100	100015457
100000940	100000100	100015458
100000940	100000100	100015459
100000940	100000100	100015790
100000941	100000100	100014594
100000941	100000100	100014595
100000941	100000100	100014596
100000941	100000100	100014597
100000941	100000100	100014598
100000941	100000100	100014599
100000941	100000100	100014600
100000941	100000100	100014601
100000941	100000100	100014602
100000941	100000100	100014603
100000941	100000100	100014605
100000941	100000100	100014607
100000941	100000100	100014608
100000941	100000100	100014609
100000941	100000100	100014610
100000941	100000100	100014611
100000941	100000100	100014612
100000941	100000100	100014613
100000941	100000100	100014614
100000941	100000100	100014615
100000941	100000100	100014616
100000941	100000100	100014617
100000941	100000100	100014623
100000941	100000100	100014624
100000941	100000100	100014625
100000941	100000100	100014626
100000941	100000100	100014627
100000941	100000100	100014628
100000941	100000100	100014728
100000941	100000100	100014729
100000941	100000100	100014730
100000941	100000100	100014731
100000941	100000100	100014732
100000941	100000100	100014733
100000941	100000100	100014734
100000941	100000100	100014736
100000941	100000100	100014919
100000941	100000100	100014920
100000941	100000100	100014923
100000941	100000100	100014924
100000941	100000100	100014925
100000941	100000100	100014926
100000941	100000100	100015116
100000941	100000100	100015540
100000941	100000100	100015542
100000941	100000100	100015543
100000941	100000100	100015550
100000944	100000100	100014893
100000944	100000100	100014907
100000944	100000100	100014908
100000944	100000100	100014949
100000944	100000100	100015272
100000944	100000100	100015273
100000944	100000100	100015274
100000944	100000100	100015275
100000945	100000100	100015137
100000945	100000100	100015138
100000945	100000100	100015140
100000946	100000099	100014302
100000946	100000099	100014303
100000946	100000099	100014308
100000946	100000099	100014313
100000946	100000099	100014314
100000946	100000099	100014325
100000946	100000099	100014334
100000946	100000099	100014335
100000946	100000099	100014340
100000946	100000099	100014355
100000946	100000099	100014359
100000946	100000099	100014360
100000946	100000099	100014365
100000946	100000099	100014370
100000946	100000099	100014375
100000946	100000099	100014379
100000946	100000099	100014380
100000946	100000099	100014381
100000946	100000099	100014382
100000946	100000099	100014383
100000946	100000099	100014384
100000946	100000099	100014385
100000946	100000099	100014386
100000946	100000099	100014387
100000946	100000099	100014388
100000946	100000099	100014412
100000946	100000099	100015558
100000947	100000100	100014435
100000947	100000100	100014436
100000947	100000100	100014437
100000947	100000100	100014438
100000947	100000100	100014439
100000947	100000100	100014440
100000947	100000100	100014443
100000947	100000100	100014444
100000947	100000100	100014445
100000947	100000100	100014450
100000947	100000100	100014451
100000947	100000100	100014452
100000947	100000100	100014466
100000947	100000100	100014467
100000947	100000100	100014468
100000947	100000100	100014474
100000947	100000100	100014475
100000947	100000100	100014476
100000947	100000100	100014483
100000947	100000100	100014484
100000947	100000100	100014485
100000947	100000100	100014491
100000947	100000100	100014492
100000947	100000100	100014493
100000947	100000100	100014497
100000947	100000100	100014498
100000947	100000100	100014499
100000947	100000100	100014508
100000947	100000100	100014509
100000947	100000100	100014510
100000947	100000100	100014511
100000947	100000100	100014512
100000947	100000100	100014513
100000947	100000100	100014514
100000947	100000100	100014515
100000947	100000100	100014518
100000947	100000100	100014519
100000947	100000100	100014520
100000947	100000100	100014524
100000947	100000100	100014525
100000947	100000100	100014526
100000947	100000100	100014530
100000947	100000100	100014531
100000947	100000100	100014532
100000947	100000100	100014533
100000947	100000100	100014534
100000947	100000100	100014535
100000947	100000100	100014536
100000947	100000100	100014537
100000947	100000100	100014538
100000947	100000100	100014539
100000947	100000100	100014540
100000947	100000100	100014541
100000947	100000100	100014544
100000947	100000100	100014545
100000947	100000100	100014546
100000947	100000100	100014550
100000947	100000100	100014551
100000947	100000100	100014552
100000947	100000100	100014553
100000947	100000100	100014554
100000947	100000100	100014555
100000947	100000100	100014556
100000947	100000100	100014557
100000947	100000100	100014559
100000947	100000100	100014563
100000947	100000100	100014566
100000947	100000100	100014567
100000947	100000100	100014568
100000947	100000100	100014569
100000947	100000100	100014570
100000947	100000100	100014571
100000947	100000100	100014572
100000947	100000100	100014573
100000947	100000100	100014574
100000947	100000100	100014575
100000947	100000100	100014580
100000947	100000100	100014581
100000947	100000100	100014582
100000947	100000100	100014588
100000947	100000100	100014589
100000947	100000100	100014590
100000947	100000100	100014596
100000947	100000100	100014597
100000947	100000100	100014598
100000947	100000100	100014604
100000947	100000100	100014605
100000947	100000100	100014606
100000947	100000100	100014612
100000947	100000100	100014613
100000947	100000100	100014614
100000947	100000100	100014618
100000947	100000100	100014619
100000947	100000100	100014620
100000947	100000100	100014621
100000947	100000100	100014622
100000947	100000100	100014625
100000947	100000100	100014626
100000947	100000100	100014627
100000947	100000100	100014629
100000947	100000100	100014630
100000947	100000100	100014631
100000947	100000100	100014632
100000947	100000100	100014633
100000947	100000100	100014634
100000947	100000100	100014635
100000947	100000100	100014636
100000947	100000100	100014637
100000947	100000100	100014638
100000947	100000100	100014639
100000947	100000100	100014640
100000947	100000100	100014641
100000947	100000100	100014642
100000947	100000100	100014643
100000947	100000100	100014644
100000947	100000100	100014648
100000947	100000100	100014649
100000947	100000100	100014650
100000947	100000100	100014657
100000947	100000100	100014659
100000947	100000100	100014660
100000947	100000100	100014669
100000947	100000100	100014670
100000947	100000100	100014671
100000947	100000100	100014672
100000947	100000100	100014673
100000947	100000100	100014674
100000947	100000100	100014675
100000947	100000100	100014676
100000947	100000100	100014677
100000947	100000100	100014681
100000947	100000100	100014682
100000947	100000100	100014683
100000947	100000100	100014684
100000947	100000100	100014688
100000947	100000100	100014693
100000947	100000100	100014696
100000947	100000100	100014698
100000947	100000100	100014699
100000947	100000100	100014700
100000947	100000100	100014701
100000947	100000100	100014702
100000947	100000100	100014703
100000947	100000100	100014704
100000947	100000100	100014705
100000947	100000100	100014706
100000947	100000100	100014707
100000947	100000100	100014708
100000947	100000100	100014709
100000947	100000100	100014710
100000947	100000100	100014711
100000947	100000100	100014712
100000947	100000100	100014713
100000947	100000100	100014719
100000947	100000100	100014722
100000947	100000100	100014725
100000947	100000100	100014726
100000947	100000100	100014727
100000947	100000100	100014732
100000947	100000100	100014738
100000947	100000100	100014740
100000947	100000100	100014741
100000947	100000100	100014742
100000947	100000100	100014745
100000947	100000100	100014746
100000947	100000100	100014747
100000947	100000100	100014749
100000947	100000100	100014750
100000947	100000100	100014751
100000947	100000100	100014754
100000947	100000100	100014755
100000947	100000100	100014757
100000947	100000100	100014759
100000947	100000100	100014767
100000947	100000100	100014768
100000947	100000100	100014769
100000947	100000100	100014773
100000947	100000100	100014774
100000947	100000100	100014775
100000947	100000100	100014776
100000947	100000100	100014777
100000947	100000100	100014778
100000947	100000100	100014779
100000947	100000100	100014780
100000947	100000100	100014781
100000947	100000100	100014782
100000947	100000100	100014783
100000947	100000100	100014784
100000947	100000100	100014785
100000947	100000100	100014786
100000947	100000100	100014787
100000947	100000100	100014788
100000947	100000100	100014789
100000947	100000100	100014790
100000947	100000100	100014794
100000947	100000100	100014795
100000947	100000100	100014798
100000947	100000100	100014799
100000947	100000100	100014802
100000947	100000100	100014803
100000947	100000100	100014804
100000947	100000100	100014805
100000947	100000100	100014806
100000947	100000100	100014807
100000947	100000100	100014808
100000947	100000100	100014809
100000947	100000100	100014810
100000947	100000100	100014811
100000947	100000100	100014812
100000947	100000100	100014813
100000947	100000100	100014814
100000947	100000100	100014815
100000947	100000100	100014816
100000947	100000100	100014817
100000947	100000100	100014818
100000947	100000100	100014819
100000947	100000100	100014820
100000947	100000100	100014821
100000947	100000100	100014822
100000947	100000100	100014824
100000947	100000100	100014825
100000947	100000100	100014826
100000947	100000100	100014827
100000947	100000100	100014828
100000947	100000100	100014833
100000947	100000100	100014834
100000947	100000100	100014836
100000947	100000100	100014837
100000947	100000100	100014838
100000947	100000100	100014839
100000947	100000100	100014840
100000947	100000100	100014841
100000947	100000100	100014843
100000947	100000100	100014845
100000947	100000100	100014847
100000947	100000100	100014848
100000947	100000100	100014849
100000947	100000100	100014850
100000947	100000100	100014851
100000947	100000100	100014852
100000947	100000100	100014853
100000947	100000100	100014856
100000947	100000100	100014857
100000947	100000100	100014861
100000947	100000100	100014862
100000947	100000100	100014864
100000947	100000100	100014865
100000947	100000100	100014866
100000947	100000100	100014867
100000947	100000100	100014868
100000947	100000100	100014869
100000947	100000100	100014870
100000947	100000100	100014871
100000947	100000100	100014873
100000947	100000100	100014874
100000947	100000100	100014875
100000947	100000100	100014876
100000947	100000100	100014877
100000947	100000100	100014878
100000947	100000100	100014879
100000947	100000100	100014880
100000947	100000100	100014881
100000947	100000100	100014886
100000947	100000100	100014887
100000947	100000100	100014888
100000947	100000100	100014892
100000947	100000100	100014893
100000947	100000100	100014895
100000947	100000100	100014896
100000947	100000100	100014897
100000947	100000100	100014898
100000947	100000100	100014899
100000947	100000100	100014905
100000947	100000100	100014906
100000947	100000100	100014909
100000947	100000100	100014911
100000947	100000100	100014912
100000947	100000100	100014913
100000947	100000100	100014914
100000947	100000100	100014915
100000947	100000100	100014916
100000947	100000100	100014917
100000947	100000100	100014918
100000947	100000100	100014923
100000947	100000100	100014925
100000947	100000100	100014927
100000947	100000100	100014928
100000947	100000100	100014929
100000947	100000100	100014930
100000947	100000100	100014931
100000947	100000100	100014932
100000947	100000100	100014933
100000947	100000100	100014934
100000947	100000100	100014935
100000947	100000100	100014936
100000947	100000100	100014937
100000947	100000100	100014938
100000947	100000100	100014939
100000947	100000100	100014940
100000947	100000100	100014941
100000947	100000100	100014942
100000947	100000100	100014947
100000947	100000100	100014948
100000947	100000100	100014952
100000947	100000100	100014953
100000947	100000100	100014954
100000947	100000100	100014955
100000947	100000100	100014956
100000947	100000100	100014957
100000947	100000100	100014963
100000947	100000100	100014966
100000947	100000100	100014967
100000947	100000100	100014970
100000947	100000100	100014973
100000947	100000100	100014976
100000947	100000100	100014978
100000947	100000100	100014979
100000947	100000100	100014980
100000947	100000100	100014981
100000947	100000100	100014982
100000947	100000100	100014985
100000947	100000100	100014987
100000947	100000100	100014988
100000947	100000100	100014989
100000947	100000100	100014991
100000947	100000100	100014992
100000947	100000100	100014993
100000947	100000100	100014994
100000947	100000100	100014995
100000947	100000100	100014996
100000947	100000100	100014997
100000947	100000100	100014998
100000947	100000100	100014999
100000947	100000100	100015000
100000947	100000100	100015001
100000947	100000100	100015007
100000947	100000100	100015008
100000947	100000100	100015009
100000947	100000100	100015010
100000947	100000100	100015011
100000947	100000100	100015012
100000947	100000100	100015014
100000947	100000100	100015015
100000947	100000100	100015016
100000947	100000100	100015017
100000947	100000100	100015018
100000947	100000100	100015019
100000947	100000100	100015020
100000947	100000100	100015021
100000947	100000100	100015022
100000947	100000100	100015023
100000947	100000100	100015045
100000947	100000100	100015046
100000947	100000100	100015047
100000947	100000100	100015054
100000947	100000100	100015055
100000947	100000100	100015056
100000947	100000100	100015060
100000947	100000100	100015061
100000947	100000100	100015062
100000947	100000100	100015066
100000947	100000100	100015067
100000947	100000100	100015068
100000947	100000100	100015070
100000947	100000100	100015071
100000947	100000100	100015072
100000947	100000100	100015073
100000947	100000100	100015074
100000947	100000100	100015075
100000947	100000100	100015076
100000947	100000100	100015077
100000947	100000100	100015078
100000947	100000100	100015079
100000947	100000100	100015080
100000947	100000100	100015081
100000947	100000100	100015084
100000947	100000100	100015087
100000947	100000100	100015088
100000947	100000100	100015091
100000947	100000100	100015092
100000947	100000100	100015098
100000947	100000100	100015099
100000947	100000100	100015100
100000947	100000100	100015104
100000947	100000100	100015105
100000947	100000100	100015106
100000947	100000100	100015110
100000947	100000100	100015111
100000947	100000100	100015112
100000947	100000100	100015113
100000947	100000100	100015121
100000947	100000100	100015122
100000947	100000100	100015126
100000947	100000100	100015127
100000947	100000100	100015128
100000947	100000100	100015132
100000947	100000100	100015136
100000947	100000100	100015141
100000947	100000100	100015142
100000947	100000100	100015143
100000947	100000100	100015144
100000947	100000100	100015145
100000947	100000100	100015146
100000947	100000100	100015147
100000947	100000100	100015148
100000947	100000100	100015149
100000947	100000100	100015150
100000947	100000100	100015151
100000947	100000100	100015152
100000947	100000100	100015153
100000947	100000100	100015154
100000947	100000100	100015155
100000947	100000100	100015156
100000947	100000100	100015157
100000947	100000100	100015158
100000947	100000100	100015159
100000947	100000100	100015161
100000947	100000100	100015162
100000947	100000100	100015163
100000947	100000100	100015164
100000947	100000100	100015165
100000947	100000100	100015166
100000947	100000100	100015170
100000947	100000100	100015172
100000947	100000100	100015218
100000947	100000100	100015219
100000947	100000100	100015222
100000947	100000100	100015223
100000947	100000100	100015228
100000947	100000100	100015230
100000947	100000100	100015231
100000947	100000100	100015232
100000947	100000100	100015233
100000947	100000100	100015234
100000947	100000100	100015248
100000947	100000100	100015249
100000947	100000100	100015252
100000947	100000100	100015253
100000947	100000100	100015254
100000947	100000100	100015267
100000947	100000100	100015268
100000947	100000100	100015269
100000947	100000100	100015271
100000947	100000100	100015276
100000947	100000100	100015277
100000947	100000100	100015278
100000947	100000100	100015279
100000947	100000100	100015280
100000947	100000100	100015281
100000947	100000100	100015282
100000947	100000100	100015288
100000947	100000100	100015289
100000947	100000100	100015291
100000947	100000100	100015296
100000947	100000100	100015297
100000947	100000100	100015301
100000947	100000100	100015302
100000947	100000100	100015303
100000947	100000100	100015307
100000947	100000100	100015308
100000947	100000100	100015309
100000947	100000100	100015318
100000947	100000100	100015319
100000947	100000100	100015320
100000947	100000100	100015321
100000947	100000100	100015322
100000947	100000100	100015323
100000947	100000100	100015324
100000947	100000100	100015325
100000947	100000100	100015326
100000947	100000100	100015327
100000947	100000100	100015328
100000947	100000100	100015330
100000947	100000100	100015331
100000947	100000100	100015332
100000947	100000100	100015333
100000947	100000100	100015334
100000947	100000100	100015335
100000947	100000100	100015336
100000947	100000100	100015339
100000947	100000100	100015340
100000947	100000100	100015341
100000947	100000100	100015344
100000947	100000100	100015347
100000947	100000100	100015348
100000947	100000100	100015352
100000947	100000100	100015357
100000947	100000100	100015358
100000947	100000100	100015359
100000947	100000100	100015372
100000947	100000100	100015373
100000947	100000100	100015374
100000947	100000100	100015377
100000947	100000100	100015378
100000947	100000100	100015379
100000947	100000100	100015381
100000947	100000100	100015382
100000947	100000100	100015390
100000947	100000100	100015391
100000947	100000100	100015394
100000947	100000100	100015395
100000947	100000100	100015396
100000947	100000100	100015397
100000947	100000100	100015400
100000947	100000100	100015401
100000947	100000100	100015402
100000947	100000100	100015403
100000947	100000100	100015404
100000947	100000100	100015405
100000947	100000100	100015406
100000947	100000100	100015407
100000947	100000100	100015408
100000947	100000100	100015410
100000947	100000100	100015411
100000947	100000100	100015412
100000947	100000100	100015417
100000947	100000100	100015418
100000947	100000100	100015419
100000947	100000100	100015420
100000947	100000100	100015421
100000947	100000100	100015422
100000947	100000100	100015425
100000947	100000100	100015426
100000947	100000100	100015430
100000947	100000100	100015431
100000947	100000100	100015432
100000947	100000100	100015433
100000947	100000100	100015443
100000947	100000100	100015444
100000947	100000100	100015446
100000947	100000100	100015447
100000947	100000100	100015448
100000947	100000100	100015449
100000947	100000100	100015450
100000947	100000100	100015460
100000947	100000100	100015461
100000947	100000100	100015462
100000947	100000100	100015463
100000947	100000100	100015464
100000947	100000100	100015465
100000947	100000100	100015466
100000947	100000100	100015467
100000947	100000100	100015468
100000947	100000100	100015469
100000947	100000100	100015470
100000947	100000100	100015471
100000947	100000100	100015472
100000947	100000100	100015473
100000947	100000100	100015481
100000947	100000100	100015482
100000947	100000100	100015483
100000947	100000100	100015484
100000947	100000100	100015490
100000947	100000100	100015491
100000947	100000100	100015492
100000947	100000100	100015495
100000947	100000100	100015496
100000947	100000100	100015497
100000947	100000100	100015498
100000947	100000100	100015499
100000947	100000100	100015500
100000947	100000100	100015501
100000947	100000100	100015502
100000947	100000100	100015503
100000947	100000100	100015504
100000947	100000100	100015505
100000947	100000100	100015506
100000947	100000100	100015507
100000947	100000100	100015508
100000947	100000100	100015509
100000947	100000100	100015510
100000947	100000100	100015512
100000947	100000100	100015513
100000947	100000100	100015516
100000947	100000100	100015517
100000947	100000100	100015522
100000947	100000100	100015523
100000947	100000100	100015528
100000947	100000100	100015529
100000947	100000100	100015530
100000947	100000100	100015531
100000947	100000100	100015532
100000947	100000100	100015533
100000947	100000100	100015534
100000947	100000100	100015538
100000947	100000100	100015539
100000947	100000100	100015541
100000947	100000100	100015544
100000947	100000100	100015545
100000947	100000100	100015546
100000947	100000100	100015584
100000947	100000100	100015585
100000947	100000100	100015586
100000947	100000100	100015587
100000947	100000100	100015588
100000947	100000100	100015589
100000947	100000100	100015590
100000947	100000100	100015591
100000947	100000100	100015592
100000947	100000100	100015593
100000947	100000100	100015594
100000947	100000100	100015595
100000947	100000100	100015596
100000947	100000100	100015597
100000947	100000100	100015598
100000947	100000100	100015599
100000947	100000100	100015600
100000947	100000100	100015601
100000947	100000100	100015602
100000947	100000100	100015603
100000947	100000100	100015604
100000947	100000100	100015605
100000947	100000100	100015606
100000947	100000100	100015607
100000947	100000100	100015608
100000947	100000100	100015609
100000947	100000100	100015610
100000947	100000100	100015611
100000947	100000100	100015612
100000947	100000100	100015613
100000947	100000100	100015621
100000947	100000100	100015622
100000947	100000100	100015623
100000947	100000100	100015624
100000947	100000100	100015625
100000947	100000100	100015626
100000947	100000100	100015632
100000947	100000100	100015633
100000947	100000100	100015635
100000947	100000100	100015636
100000947	100000100	100015637
100000947	100000100	100015638
100000947	100000100	100015639
100000947	100000100	100015640
100000947	100000100	100015641
100000947	100000100	100015642
100000947	100000100	100015643
100000947	100000100	100015644
100000947	100000100	100015645
100000947	100000100	100015646
100000947	100000100	100015647
100000947	100000100	100015648
100000947	100000100	100015649
100000947	100000100	100015655
100000947	100000100	100015656
100000947	100000100	100015657
100000947	100000100	100015658
100000947	100000100	100015659
100000947	100000100	100015660
100000947	100000100	100015661
100000947	100000100	100015662
100000947	100000100	100015663
100000947	100000100	100015664
100000947	100000100	100015665
100000947	100000100	100015666
100000947	100000100	100015667
100000947	100000100	100015668
100000947	100000100	100015669
100000947	100000100	100015670
100000947	100000100	100015671
100000947	100000100	100015672
100000947	100000100	100015673
100000947	100000100	100015674
100000947	100000100	100015675
100000947	100000100	100015676
100000947	100000100	100015677
100000947	100000100	100015678
100000947	100000100	100015679
100000947	100000100	100015680
100000947	100000100	100015682
100000947	100000100	100015683
100000947	100000100	100015684
100000947	100000100	100015685
100000947	100000100	100015691
100000947	100000100	100015695
100000947	100000100	100015696
100000947	100000100	100015697
100000947	100000100	100015698
100000947	100000100	100015699
100000947	100000100	100015700
100000947	100000100	100015701
100000947	100000100	100015702
100000947	100000100	100015703
100000947	100000100	100015705
100000947	100000100	100015706
100000947	100000100	100015707
100000947	100000100	100015708
100000947	100000100	100015710
100000947	100000100	100015711
100000947	100000100	100015713
100000947	100000100	100015714
100000947	100000100	100015715
100000947	100000100	100015716
100000947	100000100	100015717
100000947	100000100	100015718
100000947	100000100	100015719
100000947	100000100	100015720
100000947	100000100	100015721
100000947	100000100	100015722
100000947	100000100	100015723
100000947	100000100	100015724
100000947	100000100	100015725
100000947	100000100	100015726
100000947	100000100	100015727
100000947	100000100	100015728
100000947	100000100	100015729
100000947	100000100	100015730
100000947	100000100	100015731
100000947	100000100	100015732
100000947	100000100	100015733
100000947	100000100	100015734
100000947	100000100	100015735
100000947	100000100	100015736
100000947	100000100	100015737
100000947	100000100	100015738
100000947	100000100	100015739
100000947	100000100	100015740
100000947	100000100	100015741
100000947	100000100	100015742
100000947	100000100	100015743
100000947	100000100	100015744
100000947	100000100	100015745
100000947	100000100	100015746
100000947	100000100	100015747
100000947	100000100	100015748
100000947	100000100	100015749
100000947	100000100	100015750
100000947	100000100	100015751
100000947	100000100	100015752
100000947	100000100	100015753
100000947	100000100	100015754
100000947	100000100	100015755
100000947	100000100	100015756
100000947	100000100	100015757
100000947	100000100	100015758
100000947	100000100	100015759
100000947	100000100	100015760
100000947	100000100	100015761
100000947	100000100	100015764
100000947	100000100	100015766
100000947	100000100	100015769
100000947	100000100	100015770
100000947	100000100	100015771
100000947	100000100	100015772
100000947	100000100	100015773
100000947	100000100	100015774
100000947	100000100	100015775
100000947	100000100	100015776
100000947	100000100	100015777
100000947	100000100	100015778
100000947	100000100	100015779
100000947	100000100	100015780
100000947	100000100	100015781
100000947	100000100	100015782
100000947	100000100	100015783
100000947	100000100	100015784
100000947	100000100	100015785
100000947	100000100	100015786
100000947	100000100	100015787
100000947	100000100	100015788
100000947	100000100	100015789
100000947	100000100	100015790
100000947	100000100	100015791
100000947	100000100	100015792
100000947	100000100	100015794
100000947	100000100	100015795
100000947	100000100	100015796
100000947	100000100	100015797
100000947	100000100	100015798
100000947	100000100	100015799
100000947	100000100	100015800
100000947	100000100	100015801
100000947	100000100	100015802
100000947	100000100	100015803
100000947	100000100	100015804
100000947	100000100	100015805
100000947	100000100	100015806
100000949	100000100	100015453
100000949	100000100	100015454
100000949	100000100	100015455
\.


--
-- Data for Name: rel_regra_auditoria_recurso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rel_regra_auditoria_recurso (id_recurso, id_sistema, id_regra_auditoria) FROM stdin;
100014301	100000099	1
100014304	100000099	1
100014305	100000099	1
100014306	100000099	1
100014307	100000099	1
100014310	100000099	1
100014311	100000099	1
100014312	100000099	1
100014315	100000099	1
100014316	100000099	1
100014317	100000099	1
100014324	100000099	1
100014326	100000099	1
100014327	100000099	1
100014330	100000099	1
100014331	100000099	1
100014332	100000099	1
100014333	100000099	1
100014336	100000099	1
100014337	100000099	1
100014338	100000099	1
100014339	100000099	1
100014341	100000099	1
100014342	100000099	1
100014343	100000099	1
100014344	100000099	1
100014347	100000099	1
100014348	100000099	1
100014349	100000099	1
100014350	100000099	1
100014352	100000099	1
100014353	100000099	1
100014356	100000099	1
100014357	100000099	1
100014358	100000099	1
100014359	100000099	1
100014362	100000099	1
100014363	100000099	1
100014364	100000099	1
100014365	100000099	1
100014366	100000099	1
100014368	100000099	1
100014369	100000099	1
100014371	100000099	1
100014372	100000099	1
100014373	100000099	1
100014374	100000099	1
100014376	100000099	1
100014377	100000099	1
100014378	100000099	1
100014379	100000099	1
100014383	100000099	1
100014384	100000099	1
100014385	100000099	1
100014386	100000099	1
100014393	100000099	1
100014394	100000099	1
100014395	100000099	1
100014396	100000099	1
100014407	100000099	1
100014408	100000099	1
100014409	100000099	1
100014410	100000099	1
100014412	100000099	1
100014414	100000099	1
100015173	100000099	1
100015174	100000099	1
100015175	100000099	1
100015187	100000099	1
100015200	100000099	1
100015201	100000099	1
100015204	100000099	1
100015205	100000099	1
100015206	100000099	1
100015363	100000099	1
100015364	100000099	1
100015365	100000099	1
100015570	100000099	1
100015571	100000099	1
100015572	100000099	1
100015582	100000099	1
100014435	100000100	2
100014436	100000100	2
100014440	100000100	2
100014441	100000100	2
100014442	100000100	2
100014446	100000100	2
100014447	100000100	2
100014448	100000100	2
100014449	100000100	2
100014453	100000100	2
100014454	100000100	2
100014455	100000100	2
100014464	100000100	2
100014465	100000100	2
100014469	100000100	2
100014470	100000100	2
100014471	100000100	2
100014472	100000100	2
100014473	100000100	2
100014477	100000100	2
100014478	100000100	2
100014479	100000100	2
100014480	100000100	2
100014481	100000100	2
100014482	100000100	2
100014486	100000100	2
100014487	100000100	2
100014488	100000100	2
100014489	100000100	2
100014490	100000100	2
100014494	100000100	2
100014495	100000100	2
100014496	100000100	2
100014500	100000100	2
100014508	100000100	2
100014509	100000100	2
100014513	100000100	2
100014514	100000100	2
100014515	100000100	2
100014516	100000100	2
100014517	100000100	2
100014521	100000100	2
100014522	100000100	2
100014523	100000100	2
100014527	100000100	2
100014528	100000100	2
100014529	100000100	2
100014536	100000100	2
100014537	100000100	2
100014541	100000100	2
100014542	100000100	2
100014543	100000100	2
100014547	100000100	2
100014548	100000100	2
100014549	100000100	2
100014565	100000100	2
100014576	100000100	2
100014577	100000100	2
100014578	100000100	2
100014579	100000100	2
100014583	100000100	2
100014584	100000100	2
100014585	100000100	2
100014586	100000100	2
100014587	100000100	2
100014591	100000100	2
100014592	100000100	2
100014593	100000100	2
100014594	100000100	2
100014595	100000100	2
100014599	100000100	2
100014600	100000100	2
100014601	100000100	2
100014602	100000100	2
100014603	100000100	2
100014607	100000100	2
100014608	100000100	2
100014609	100000100	2
100014610	100000100	2
100014611	100000100	2
100014615	100000100	2
100014616	100000100	2
100014617	100000100	2
100014623	100000100	2
100014624	100000100	2
100014628	100000100	2
100014646	100000100	2
100014647	100000100	2
100014651	100000100	2
100014652	100000100	2
100014653	100000100	2
100014658	100000100	2
100014669	100000100	2
100014670	100000100	2
100014674	100000100	2
100014675	100000100	5
100014702	100000100	2
100014703	100000100	2
100014709	100000100	2
100014710	100000100	2
100014711	100000100	2
100014712	100000100	2
100014719	100000100	2
100014736	100000100	2
100014743	100000100	2
100014744	100000100	2
100014748	100000100	2
100014752	100000100	2
100014753	100000100	2
100014756	100000100	2
100014760	100000100	2
100014761	100000100	2
100014763	100000100	2
100014764	100000100	2
100014765	100000100	2
100014766	100000100	2
100014770	100000100	2
100014771	100000100	2
100014772	100000100	2
100014774	100000100	2
100014775	100000100	2
100014778	100000100	2
100014779	100000100	2
100014780	100000100	2
100014792	100000100	2
100014793	100000100	2
100014797	100000100	2
100014802	100000100	5
100014828	100000100	2
100014843	100000100	2
100014850	100000100	2
100014851	100000100	2
100014854	100000100	2
100014855	100000100	2
100014858	100000100	2
100014859	100000100	2
100014860	100000100	2
100014863	100000100	2
100014864	100000100	2
100014865	100000100	2
100014868	100000100	2
100014869	100000100	2
100014872	100000100	2
100014876	100000100	2
100014877	100000100	2
100014880	100000100	2
100014892	100000100	2
100014895	100000100	2
100014896	100000100	2
100014899	100000100	2
100014900	100000100	2
100014901	100000100	2
100014904	100000100	2
100014907	100000100	2
100014908	100000100	2
100014910	100000100	2
100014912	100000100	2
100014913	100000100	2
100014931	100000100	2
100014932	100000100	2
100014935	100000100	2
100014936	100000100	2
100014937	100000100	2
100014940	100000100	2
100014947	100000100	2
100014951	100000100	2
100014952	100000100	2
100014953	100000100	2
100014957	100000100	2
100014964	100000100	2
100014965	100000100	2
100014968	100000100	2
100014984	100000100	2
100014986	100000100	2
100015024	100000100	2
100015025	100000100	2
100015027	100000100	2
100015029	100000100	2
100015030	100000100	2
100015031	100000100	2
100015032	100000100	2
100015035	100000100	2
100015043	100000100	2
100015044	100000100	2
100015048	100000100	2
100015049	100000100	2
100015050	100000100	2
100015051	100000100	2
100015052	100000100	2
100015053	100000100	2
100015057	100000100	2
100015058	100000100	2
100015059	100000100	2
100015063	100000100	2
100015083	100000100	2
100015085	100000100	2
100015089	100000100	2
100015090	100000100	2
100015093	100000100	2
100015094	100000100	2
100015095	100000100	2
100015096	100000100	2
100015097	100000100	2
100015101	100000100	2
100015110	100000100	2
100015111	100000100	2
100015114	100000100	2
100015115	100000100	2
100015120	100000100	2
100015123	100000100	2
100015137	100000100	2
100015145	100000100	2
100015149	100000100	2
100015150	100000100	2
100015152	100000100	2
100015154	100000100	2
100015155	100000100	2
100015157	100000100	2
100015161	100000100	2
100015162	100000100	2
100015164	100000100	2
100015171	100000100	2
100015211	100000100	3
100015212	100000100	3
100015213	100000100	3
100015214	100000100	3
100015215	100000100	3
100015216	100000100	3
100015217	100000100	3
100015218	100000100	2
100015219	100000100	4
100015235	100000100	2
100015271	100000100	2
100015272	100000100	2
100015273	100000100	2
100015274	100000100	2
100015275	100000100	2
100015285	100000100	2
100015286	100000100	2
100015287	100000100	2
100015290	100000100	2
100015292	100000100	2
100015293	100000100	2
100015294	100000100	2
100015295	100000100	2
100015298	100000100	2
100015299	100000100	2
100015300	100000100	2
100015304	100000100	2
100015305	100000100	2
100015306	100000100	2
100015337	100000100	2
100015338	100000100	2
100015345	100000100	2
100015346	100000100	2
100015349	100000100	2
100015350	100000100	2
100015351	100000100	2
100015352	100000100	2
100015353	100000100	2
100015354	100000100	2
100015355	100000100	2
100015356	100000100	2
100015360	100000100	2
100015361	100000100	2
100015362	100000100	2
100015375	100000100	2
100015380	100000100	2
100015383	100000100	2
100015384	100000100	2
100015385	100000100	2
100015386	100000100	2
100015392	100000100	2
100015393	100000100	2
100015394	100000100	2
100015396	100000100	2
100015397	100000100	2
100015400	100000100	2
100015401	100000100	2
100015404	100000100	2
100015409	100000100	2
100015413	100000100	2
100015414	100000100	2
100015415	100000100	2
100015416	100000100	2
100015423	100000100	2
100015424	100000100	2
100015427	100000100	2
100015428	100000100	2
100015429	100000100	2
100015453	100000100	2
100015454	100000100	2
100015455	100000100	2
100015474	100000100	2
100015475	100000100	2
100015476	100000100	2
100015477	100000100	2
100015478	100000100	2
100015480	100000100	2
100015482	100000100	2
100015485	100000100	2
100015486	100000100	2
100015487	100000100	2
100015488	100000100	2
100015489	100000100	2
100015494	100000100	2
100015496	100000100	2
100015497	100000100	2
100015499	100000100	2
100015500	100000100	2
100015503	100000100	2
100015504	100000100	2
100015505	100000100	2
100015510	100000100	2
100015524	100000100	2
100015525	100000100	2
100015526	100000100	2
100015527	100000100	2
100015530	100000100	2
100015531	100000100	2
100015535	100000100	2
100015536	100000100	2
100015537	100000100	2
100015544	100000100	2
100015549	100000100	2
100015614	100000100	2
100015615	100000100	2
100015616	100000100	2
100015617	100000100	2
100015618	100000100	2
100015619	100000100	2
100015620	100000100	2
100015637	100000100	2
100015638	100000100	2
100015639	100000100	2
100015642	100000100	2
100015643	100000100	2
100015646	100000100	2
100015684	100000100	2
100015685	100000100	2
100015686	100000100	2
100015687	100000100	2
100015688	100000100	2
100015689	100000100	2
100015690	100000100	2
100015703	100000100	2
100015704	100000100	2
100015753	100000100	2
100015754	100000100	2
100015756	100000100	2
100015757	100000100	2
100015759	100000100	2
100015762	100000100	2
100015763	100000100	2
100015765	100000100	2
100015767	100000100	2
100015768	100000100	2
100015793	100000100	2
\.


--
-- Data for Name: servidor_autenticacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.servidor_autenticacao (id_servidor_autenticacao, nome, sta_tipo, endereco, porta, sufixo, usuario_pesquisa, senha_pesquisa, contexto_pesquisa, atributo_filtro_pesquisa, atributo_retorno_pesquisa, versao) FROM stdin;
1	Exemplo_Conexao_AD_1	AD	hostnamedoservidor.dominio.gov.br	389	@dominio.gov.br	sei_sip_ldap_ad@dominio.gov.br	\N	DC=xxx,DC=yyy,DC=zzz	userPrincipalName	distinguishedName	3
2	Exemplo_Conexao_AD_2	AD	hostnamedoservidor.dominio.gov.br	389	@dominio.gov.br	sei_sip_ldap_ad@dominio.gov.br	\N	DC=xxx,DC=yyy,DC=zzz	userPrincipalName	distinguishedName	3
\.


--
-- Data for Name: sistema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sistema (id_sistema, id_orgao, id_hierarquia, sigla, descricao, pagina_inicial, sin_ativo, web_service, logo, sta_2_fatores, esquema_login, servicos_liberados, chave_acesso, crc) FROM stdin;
100000099	0	100000018	SIP	Sistema de Permissões	http://localhost:8000/sip	S	\N	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	P	dsgov	\N	$2a$12$VGlzUNkiuuSRRarooGKzzOOvZnMKz/bNIz.721dwe/dq75CGyfj6S	d27791b8
100000100	0	100000018	SEI	Sistema Eletrônico de Informações	http://localhost:8000/sei/inicializar.php	S	http://localhost:8000/sei/controlador_ws.php?servico=sip	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	P	dsgov	1,2,3,4,5,6	$2a$12$U1UYoWD3Yer2fedJEGOti.YN.cCBByAqI21tsrQ5Qi9.VcTfn4thS	7babf862
\.


--
-- Data for Name: tipo_permissao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_permissao (id_tipo_permissao, descricao) FROM stdin;
1	Não Delegável
2	Delegável
3	Delegável uma vez
\.


--
-- Data for Name: unidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unidade (id_unidade, id_orgao, id_origem, sigla, descricao, sin_ativo, sin_global) FROM stdin;
110000000	0	\N	*	Unidade Global	S	S
110000001	0	\N	TESTE	Unidade de Teste 1	S	N
110000002	0	\N	TESTE_1_1	Unidade de Testes 1.1	S	N
110000003	0	\N	TESTE_1_2	Unidade de Testes 1.2	S	N
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id_usuario, id_orgao, id_origem, sigla, nome, sin_ativo, cpf, nome_registro_civil, nome_social, email, sin_bloqueado) FROM stdin;
1	0	\N	SIP	Sistema de Permissões	S	\N	Sistema de Permissões	\N	\N	N
100000001	0	\N	teste	Usuário de Testes	S	\N	Usuário de Testes	\N	\N	N
\.


--
-- Data for Name: usuario_historico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_historico (id_usuario_historico, id_codigo_acesso, id_usuario, id_usuario_operacao, dth_operacao, sta_operacao, motivo) FROM stdin;
\.


--
-- Name: seq_infra_auditoria; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_infra_auditoria', 1, false);


--
-- Name: seq_infra_log; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_infra_log', 1, false);


--
-- Name: seq_usuario_historico; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_usuario_historico', 1, false);


--
-- Name: administrador_sistema pk_administrador_sistema; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrador_sistema
    ADD CONSTRAINT pk_administrador_sistema PRIMARY KEY (id_sistema, id_usuario);


--
-- Name: codigo_acesso pk_codigo_acesso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_acesso
    ADD CONSTRAINT pk_codigo_acesso PRIMARY KEY (id_codigo_acesso);


--
-- Name: codigo_bloqueio pk_codigo_bloqueio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_bloqueio
    ADD CONSTRAINT pk_codigo_bloqueio PRIMARY KEY (id_codigo_bloqueio);


--
-- Name: coordenador_perfil pk_coordenador_perfil; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordenador_perfil
    ADD CONSTRAINT pk_coordenador_perfil PRIMARY KEY (id_perfil, id_sistema, id_usuario);


--
-- Name: coordenador_unidade pk_coordenador_unidade; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordenador_unidade
    ADD CONSTRAINT pk_coordenador_unidade PRIMARY KEY (id_sistema, id_unidade, id_usuario);


--
-- Name: dispositivo_acesso pk_dispositivo_acesso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispositivo_acesso
    ADD CONSTRAINT pk_dispositivo_acesso PRIMARY KEY (id_dispositivo_acesso);


--
-- Name: email_sistema pk_email_sistema; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_sistema
    ADD CONSTRAINT pk_email_sistema PRIMARY KEY (id_email_sistema);


--
-- Name: hierarquia pk_hierarquia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hierarquia
    ADD CONSTRAINT pk_hierarquia PRIMARY KEY (id_hierarquia);


--
-- Name: infra_agendamento_tarefa pk_infra_agendamento_tarefa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_agendamento_tarefa
    ADD CONSTRAINT pk_infra_agendamento_tarefa PRIMARY KEY (id_infra_agendamento_tarefa);


--
-- Name: infra_auditoria pk_infra_auditoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_auditoria
    ADD CONSTRAINT pk_infra_auditoria PRIMARY KEY (id_infra_auditoria);


--
-- Name: infra_log pk_infra_log; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_log
    ADD CONSTRAINT pk_infra_log PRIMARY KEY (id_infra_log);


--
-- Name: infra_parametro pk_infra_parametro; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_parametro
    ADD CONSTRAINT pk_infra_parametro PRIMARY KEY (nome);


--
-- Name: infra_regra_auditoria pk_infra_regra_auditoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_regra_auditoria
    ADD CONSTRAINT pk_infra_regra_auditoria PRIMARY KEY (id_infra_regra_auditoria);


--
-- Name: infra_regra_auditoria_recurso pk_infra_regra_auditoria_rec; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_regra_auditoria_recurso
    ADD CONSTRAINT pk_infra_regra_auditoria_rec PRIMARY KEY (id_infra_regra_auditoria, recurso);


--
-- Name: infra_sequencia pk_infra_sequencia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_sequencia
    ADD CONSTRAINT pk_infra_sequencia PRIMARY KEY (nome_tabela);


--
-- Name: item_menu pk_item_menu; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_menu
    ADD CONSTRAINT pk_item_menu PRIMARY KEY (id_item_menu, id_menu);


--
-- Name: login pk_login; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT pk_login PRIMARY KEY (id_login, id_sistema, id_usuario);


--
-- Name: menu pk_menu; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT pk_menu PRIMARY KEY (id_menu);


--
-- Name: orgao pk_orgao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orgao
    ADD CONSTRAINT pk_orgao PRIMARY KEY (id_orgao);


--
-- Name: perfil pk_perfil; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT pk_perfil PRIMARY KEY (id_perfil, id_sistema);


--
-- Name: permissao pk_permissao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissao
    ADD CONSTRAINT pk_permissao PRIMARY KEY (id_perfil, id_sistema, id_unidade, id_usuario);


--
-- Name: recurso pk_recurso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recurso
    ADD CONSTRAINT pk_recurso PRIMARY KEY (id_recurso, id_sistema);


--
-- Name: recurso_vinculado pk_recurso_vinculado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recurso_vinculado
    ADD CONSTRAINT pk_recurso_vinculado PRIMARY KEY (id_recurso, id_recurso_vinculado, id_sistema, id_sistema_vinculado);


--
-- Name: regra_auditoria pk_regra_auditoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regra_auditoria
    ADD CONSTRAINT pk_regra_auditoria PRIMARY KEY (id_regra_auditoria);


--
-- Name: rel_hierarquia_unidade pk_rel_hierarquia_unidade; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_hierarquia_unidade
    ADD CONSTRAINT pk_rel_hierarquia_unidade PRIMARY KEY (id_hierarquia, id_unidade);


--
-- Name: rel_orgao_autenticacao pk_rel_orgao_autenticacao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_orgao_autenticacao
    ADD CONSTRAINT pk_rel_orgao_autenticacao PRIMARY KEY (id_orgao, id_servidor_autenticacao);


--
-- Name: rel_perfil_item_menu pk_rel_perfil_item_menu; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_perfil_item_menu
    ADD CONSTRAINT pk_rel_perfil_item_menu PRIMARY KEY (id_item_menu, id_menu, id_perfil, id_recurso, id_sistema);


--
-- Name: rel_perfil_recurso pk_rel_perfil_recurso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_perfil_recurso
    ADD CONSTRAINT pk_rel_perfil_recurso PRIMARY KEY (id_perfil, id_recurso, id_sistema);


--
-- Name: rel_regra_auditoria_recurso pk_rel_regra_auditoria_recurso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_regra_auditoria_recurso
    ADD CONSTRAINT pk_rel_regra_auditoria_recurso PRIMARY KEY (id_recurso, id_regra_auditoria, id_sistema);


--
-- Name: servidor_autenticacao pk_servidor_autenticacao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servidor_autenticacao
    ADD CONSTRAINT pk_servidor_autenticacao PRIMARY KEY (id_servidor_autenticacao);


--
-- Name: sistema pk_sistema; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sistema
    ADD CONSTRAINT pk_sistema PRIMARY KEY (id_sistema);


--
-- Name: tipo_permissao pk_tipo_permissao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_permissao
    ADD CONSTRAINT pk_tipo_permissao PRIMARY KEY (id_tipo_permissao);


--
-- Name: unidade pk_unidade; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT pk_unidade PRIMARY KEY (id_unidade);


--
-- Name: usuario pk_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (id_usuario);


--
-- Name: usuario_historico pk_usuario_historico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_historico
    ADD CONSTRAINT pk_usuario_historico PRIMARY KEY (id_usuario_historico);


--
-- Name: ak_orgao_sigla; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ak_orgao_sigla ON public.orgao USING btree (sigla);


--
-- Name: ak_perfil_nome; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ak_perfil_nome ON public.perfil USING btree (id_sistema, nome);


--
-- Name: ak_recurso_nome; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ak_recurso_nome ON public.recurso USING btree (id_sistema, nome);


--
-- Name: ak_sistema_sigla_orgao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ak_sistema_sigla_orgao ON public.sistema USING btree (id_orgao, sigla);


--
-- Name: ak_unidade_sigla_orgao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ak_unidade_sigla_orgao ON public.unidade USING btree (id_orgao, sigla, sin_ativo);


--
-- Name: ak_usuario_sigla_orgao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ak_usuario_sigla_orgao ON public.usuario USING btree (id_orgao, sigla, sin_ativo);


--
-- Name: fk_admin_sistema_sistema; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_admin_sistema_sistema ON public.administrador_sistema USING btree (id_sistema);


--
-- Name: fk_admin_sistema_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_admin_sistema_usuario ON public.administrador_sistema USING btree (id_usuario);


--
-- Name: fk_auditoria_recurso_recurso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_auditoria_recurso_recurso ON public.rel_regra_auditoria_recurso USING btree (id_recurso, id_sistema);


--
-- Name: fk_auditoria_sistema; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_auditoria_sistema ON public.regra_auditoria USING btree (id_sistema);


--
-- Name: fk_cod_acesso_usu_desativacao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_cod_acesso_usu_desativacao ON public.codigo_acesso USING btree (id_usuario_desativacao);


--
-- Name: fk_cod_bloqueio_cod_acesso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_cod_bloqueio_cod_acesso ON public.codigo_bloqueio USING btree (id_codigo_acesso);


--
-- Name: fk_codigo_acesso_sistema; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_codigo_acesso_sistema ON public.codigo_acesso USING btree (id_sistema);


--
-- Name: fk_codigo_acesso_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_codigo_acesso_usuario ON public.codigo_acesso USING btree (id_usuario);


--
-- Name: fk_coordenador_perfil_perfil; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_coordenador_perfil_perfil ON public.coordenador_perfil USING btree (id_perfil, id_sistema);


--
-- Name: fk_coordenador_perfil_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_coordenador_perfil_usuario ON public.coordenador_perfil USING btree (id_usuario);


--
-- Name: fk_coordenador_unidade_sistema; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_coordenador_unidade_sistema ON public.coordenador_unidade USING btree (id_sistema);


--
-- Name: fk_coordenador_unidade_unidade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_coordenador_unidade_unidade ON public.coordenador_unidade USING btree (id_unidade);


--
-- Name: fk_coordenador_unidade_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_coordenador_unidade_usuario ON public.coordenador_unidade USING btree (id_usuario);


--
-- Name: fk_disp_acesso_cod_acesso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_disp_acesso_cod_acesso ON public.dispositivo_acesso USING btree (id_codigo_acesso);


--
-- Name: fk_inf_reg_aud_rec_inf_reg_aud; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_inf_reg_aud_rec_inf_reg_aud ON public.infra_regra_auditoria_recurso USING btree (id_infra_regra_auditoria);


--
-- Name: fk_item_menu_item_menu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_item_menu_item_menu ON public.item_menu USING btree (id_item_menu_pai, id_menu_pai);


--
-- Name: fk_item_menu_menu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_item_menu_menu ON public.item_menu USING btree (id_menu);


--
-- Name: fk_item_menu_recurso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_item_menu_recurso ON public.item_menu USING btree (id_recurso, id_sistema);


--
-- Name: fk_login_codigo_acesso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_login_codigo_acesso ON public.login USING btree (id_codigo_acesso);


--
-- Name: fk_login_dispositivo_acesso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_login_dispositivo_acesso ON public.login USING btree (id_dispositivo_acesso);


--
-- Name: fk_login_sistema; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_login_sistema ON public.login USING btree (id_sistema);


--
-- Name: fk_login_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_login_usuario ON public.login USING btree (id_usuario);


--
-- Name: fk_login_usuario_emulador; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_login_usuario_emulador ON public.login USING btree (id_usuario_emulador);


--
-- Name: fk_menu_sistema; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_menu_sistema ON public.menu USING btree (id_sistema);


--
-- Name: fk_perfil_sistema; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_perfil_sistema ON public.perfil USING btree (id_sistema);


--
-- Name: fk_permissao_perfil; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_permissao_perfil ON public.permissao USING btree (id_perfil, id_sistema);


--
-- Name: fk_permissao_tipo_permissao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_permissao_tipo_permissao ON public.permissao USING btree (id_tipo_permissao);


--
-- Name: fk_permissao_unidade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_permissao_unidade ON public.permissao USING btree (id_unidade);


--
-- Name: fk_permissao_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_permissao_usuario ON public.permissao USING btree (id_usuario);


--
-- Name: fk_recurso_sistema; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_recurso_sistema ON public.recurso USING btree (id_sistema);


--
-- Name: fk_recurso_vinculado_recurso_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_recurso_vinculado_recurso_1 ON public.recurso_vinculado USING btree (id_recurso_vinculado, id_sistema_vinculado);


--
-- Name: fk_recurso_vinculado_recurso_2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_recurso_vinculado_recurso_2 ON public.recurso_vinculado USING btree (id_recurso, id_sistema);


--
-- Name: fk_rel_auditoria_recurso_audit; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_rel_auditoria_recurso_audit ON public.rel_regra_auditoria_recurso USING btree (id_regra_auditoria);


--
-- Name: fk_rel_hie_uni_hierarquia; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_rel_hie_uni_hierarquia ON public.rel_hierarquia_unidade USING btree (id_hierarquia);


--
-- Name: fk_rel_hie_uni_rel_hie_uni; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_rel_hie_uni_rel_hie_uni ON public.rel_hierarquia_unidade USING btree (id_hierarquia_pai, id_unidade_pai);


--
-- Name: fk_rel_hie_uni_unidade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_rel_hie_uni_unidade ON public.rel_hierarquia_unidade USING btree (id_unidade);


--
-- Name: fk_rel_orgao_aut_autenticacao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_rel_orgao_aut_autenticacao ON public.rel_orgao_autenticacao USING btree (id_servidor_autenticacao);


--
-- Name: fk_rel_orgao_aut_orgao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_rel_orgao_aut_orgao ON public.rel_orgao_autenticacao USING btree (id_orgao);


--
-- Name: fk_rel_per_ite_men_rel_per_rec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_rel_per_ite_men_rel_per_rec ON public.rel_perfil_item_menu USING btree (id_perfil, id_recurso, id_sistema);


--
-- Name: fk_rel_perfil_item_menu_it_men; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_rel_perfil_item_menu_it_men ON public.rel_perfil_item_menu USING btree (id_item_menu, id_menu);


--
-- Name: fk_rel_perfil_recurso_perfil; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_rel_perfil_recurso_perfil ON public.rel_perfil_recurso USING btree (id_perfil, id_sistema);


--
-- Name: fk_rel_perfil_recurso_recurso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_rel_perfil_recurso_recurso ON public.rel_perfil_recurso USING btree (id_recurso, id_sistema);


--
-- Name: fk_sistema_hierarquia; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_sistema_hierarquia ON public.sistema USING btree (id_hierarquia);


--
-- Name: fk_sistema_orgao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_sistema_orgao ON public.sistema USING btree (id_orgao);


--
-- Name: fk_unidade_orgao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_unidade_orgao ON public.unidade USING btree (id_orgao);


--
-- Name: fk_usuario_historico_cod_acess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_usuario_historico_cod_acess ON public.usuario_historico USING btree (id_codigo_acesso);


--
-- Name: fk_usuario_historico_usu_oper; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_usuario_historico_usu_oper ON public.usuario_historico USING btree (id_usuario_operacao);


--
-- Name: fk_usuario_historico_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_usuario_historico_usuario ON public.usuario_historico USING btree (id_usuario);


--
-- Name: fk_usuario_orgao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_usuario_orgao ON public.usuario USING btree (id_orgao);


--
-- Name: i01_codigo_acesso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i01_codigo_acesso ON public.codigo_acesso USING btree (dth_ativacao);


--
-- Name: i01_codigo_bloqueio; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i01_codigo_bloqueio ON public.codigo_bloqueio USING btree (dth_envio);


--
-- Name: i01_dispositivo_acesso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i01_dispositivo_acesso ON public.dispositivo_acesso USING btree (dth_acesso);


--
-- Name: i01_hierarquia; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i01_hierarquia ON public.hierarquia USING btree (id_hierarquia, sin_ativo);


--
-- Name: i01_infra_auditoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i01_infra_auditoria ON public.infra_auditoria USING btree (recurso);


--
-- Name: i01_infra_log; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i01_infra_log ON public.infra_log USING btree (dth_log, sta_tipo);


--
-- Name: i01_orgao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i01_orgao ON public.orgao USING btree (id_orgao, sin_ativo);


--
-- Name: i01_rel_perfil_item_menu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i01_rel_perfil_item_menu ON public.rel_perfil_item_menu USING btree (id_perfil, id_sistema);


--
-- Name: i02_dispositivo_acesso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i02_dispositivo_acesso ON public.dispositivo_acesso USING btree (dth_liberacao);


--
-- Name: i02_infra_auditoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i02_infra_auditoria ON public.infra_auditoria USING btree (dth_acesso);


--
-- Name: i02_menu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i02_menu ON public.menu USING btree (id_menu, sin_ativo);


--
-- Name: i02_recurso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i02_recurso ON public.recurso USING btree (id_recurso, id_sistema, sin_ativo);


--
-- Name: i02_unidade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i02_unidade ON public.unidade USING btree (id_unidade, sin_ativo);


--
-- Name: i02_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i02_usuario ON public.usuario USING btree (id_usuario, sin_ativo);


--
-- Name: i03_infra_auditoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i03_infra_auditoria ON public.infra_auditoria USING btree (sigla_usuario);


--
-- Name: i03_recurso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i03_recurso ON public.recurso USING btree (id_recurso, id_sistema, nome, sin_ativo);


--
-- Name: i03_sistema; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i03_sistema ON public.sistema USING btree (id_sistema, sin_ativo);


--
-- Name: i03_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i03_usuario ON public.usuario USING btree (id_origem);


--
-- Name: i04_infra_auditoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i04_infra_auditoria ON public.infra_auditoria USING btree (sigla_unidade);


--
-- Name: i04_item_menu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i04_item_menu ON public.item_menu USING btree (id_item_menu, id_menu, sin_ativo);


--
-- Name: i04_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i04_login ON public.login USING btree (id_login, id_sistema, id_usuario, sta_login);


--
-- Name: i04_recurso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i04_recurso ON public.recurso USING btree (id_recurso, sin_ativo);


--
-- Name: i04_rel_hierarquia_unidade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i04_rel_hierarquia_unidade ON public.rel_hierarquia_unidade USING btree (id_hierarquia, id_unidade, sin_ativo);


--
-- Name: i04_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i04_usuario ON public.usuario USING btree (cpf);


--
-- Name: i05_item_menu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i05_item_menu ON public.item_menu USING btree (id_recurso);


--
-- Name: i05_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i05_login ON public.login USING btree (id_login, id_sistema, id_usuario, dth_login);


--
-- Name: i05_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i05_usuario ON public.usuario USING btree (id_usuario, id_orgao, id_origem);


--
-- Name: i06_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i06_login ON public.login USING btree (hash_usuario, dth_login, sta_login);


--
-- Name: i06_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i06_usuario ON public.usuario USING btree (id_usuario, id_orgao, cpf);


--
-- Name: i07_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i07_login ON public.login USING btree (dth_login);


--
-- Name: administrador_sistema fk_admin_sistema_sistema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrador_sistema
    ADD CONSTRAINT fk_admin_sistema_sistema FOREIGN KEY (id_sistema) REFERENCES public.sistema(id_sistema);


--
-- Name: administrador_sistema fk_admin_sistema_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrador_sistema
    ADD CONSTRAINT fk_admin_sistema_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- Name: rel_regra_auditoria_recurso fk_auditoria_recurso_recurso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_regra_auditoria_recurso
    ADD CONSTRAINT fk_auditoria_recurso_recurso FOREIGN KEY (id_recurso, id_sistema) REFERENCES public.recurso(id_recurso, id_sistema);


--
-- Name: regra_auditoria fk_auditoria_sistema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regra_auditoria
    ADD CONSTRAINT fk_auditoria_sistema FOREIGN KEY (id_sistema) REFERENCES public.sistema(id_sistema);


--
-- Name: codigo_acesso fk_cod_acesso_usu_desativacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_acesso
    ADD CONSTRAINT fk_cod_acesso_usu_desativacao FOREIGN KEY (id_usuario_desativacao) REFERENCES public.usuario(id_usuario);


--
-- Name: codigo_bloqueio fk_cod_bloqueio_cod_acesso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_bloqueio
    ADD CONSTRAINT fk_cod_bloqueio_cod_acesso FOREIGN KEY (id_codigo_acesso) REFERENCES public.codigo_acesso(id_codigo_acesso);


--
-- Name: codigo_acesso fk_codigo_acesso_sistema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_acesso
    ADD CONSTRAINT fk_codigo_acesso_sistema FOREIGN KEY (id_sistema) REFERENCES public.sistema(id_sistema);


--
-- Name: codigo_acesso fk_codigo_acesso_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_acesso
    ADD CONSTRAINT fk_codigo_acesso_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- Name: coordenador_perfil fk_coordenador_perfil_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordenador_perfil
    ADD CONSTRAINT fk_coordenador_perfil_perfil FOREIGN KEY (id_perfil, id_sistema) REFERENCES public.perfil(id_perfil, id_sistema);


--
-- Name: coordenador_perfil fk_coordenador_perfil_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordenador_perfil
    ADD CONSTRAINT fk_coordenador_perfil_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- Name: coordenador_unidade fk_coordenador_unidade_sistema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordenador_unidade
    ADD CONSTRAINT fk_coordenador_unidade_sistema FOREIGN KEY (id_sistema) REFERENCES public.sistema(id_sistema);


--
-- Name: coordenador_unidade fk_coordenador_unidade_unidade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordenador_unidade
    ADD CONSTRAINT fk_coordenador_unidade_unidade FOREIGN KEY (id_unidade) REFERENCES public.unidade(id_unidade);


--
-- Name: coordenador_unidade fk_coordenador_unidade_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordenador_unidade
    ADD CONSTRAINT fk_coordenador_unidade_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- Name: dispositivo_acesso fk_disp_acesso_cod_acesso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispositivo_acesso
    ADD CONSTRAINT fk_disp_acesso_cod_acesso FOREIGN KEY (id_codigo_acesso) REFERENCES public.codigo_acesso(id_codigo_acesso);


--
-- Name: infra_regra_auditoria_recurso fk_inf_reg_aud_rec_inf_reg_aud; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infra_regra_auditoria_recurso
    ADD CONSTRAINT fk_inf_reg_aud_rec_inf_reg_aud FOREIGN KEY (id_infra_regra_auditoria) REFERENCES public.infra_regra_auditoria(id_infra_regra_auditoria);


--
-- Name: item_menu fk_item_menu_item_menu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_menu
    ADD CONSTRAINT fk_item_menu_item_menu FOREIGN KEY (id_item_menu_pai, id_menu_pai) REFERENCES public.item_menu(id_item_menu, id_menu);


--
-- Name: item_menu fk_item_menu_menu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_menu
    ADD CONSTRAINT fk_item_menu_menu FOREIGN KEY (id_menu) REFERENCES public.menu(id_menu);


--
-- Name: item_menu fk_item_menu_recurso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_menu
    ADD CONSTRAINT fk_item_menu_recurso FOREIGN KEY (id_recurso, id_sistema) REFERENCES public.recurso(id_recurso, id_sistema);


--
-- Name: login fk_login_codigo_acesso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT fk_login_codigo_acesso FOREIGN KEY (id_codigo_acesso) REFERENCES public.codigo_acesso(id_codigo_acesso);


--
-- Name: login fk_login_dispositivo_acesso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT fk_login_dispositivo_acesso FOREIGN KEY (id_dispositivo_acesso) REFERENCES public.dispositivo_acesso(id_dispositivo_acesso);


--
-- Name: login fk_login_sistema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT fk_login_sistema FOREIGN KEY (id_sistema) REFERENCES public.sistema(id_sistema);


--
-- Name: login fk_login_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT fk_login_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- Name: login fk_login_usuario_emulador; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT fk_login_usuario_emulador FOREIGN KEY (id_usuario_emulador) REFERENCES public.usuario(id_usuario);


--
-- Name: menu fk_menu_sistema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT fk_menu_sistema FOREIGN KEY (id_sistema) REFERENCES public.sistema(id_sistema);


--
-- Name: perfil fk_perfil_sistema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT fk_perfil_sistema FOREIGN KEY (id_sistema) REFERENCES public.sistema(id_sistema);


--
-- Name: permissao fk_permissao_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissao
    ADD CONSTRAINT fk_permissao_perfil FOREIGN KEY (id_perfil, id_sistema) REFERENCES public.perfil(id_perfil, id_sistema);


--
-- Name: permissao fk_permissao_tipo_permissao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissao
    ADD CONSTRAINT fk_permissao_tipo_permissao FOREIGN KEY (id_tipo_permissao) REFERENCES public.tipo_permissao(id_tipo_permissao);


--
-- Name: permissao fk_permissao_unidade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissao
    ADD CONSTRAINT fk_permissao_unidade FOREIGN KEY (id_unidade) REFERENCES public.unidade(id_unidade);


--
-- Name: permissao fk_permissao_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissao
    ADD CONSTRAINT fk_permissao_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- Name: recurso fk_recurso_sistema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recurso
    ADD CONSTRAINT fk_recurso_sistema FOREIGN KEY (id_sistema) REFERENCES public.sistema(id_sistema);


--
-- Name: recurso_vinculado fk_recurso_vinculado_recurso_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recurso_vinculado
    ADD CONSTRAINT fk_recurso_vinculado_recurso_1 FOREIGN KEY (id_recurso_vinculado, id_sistema_vinculado) REFERENCES public.recurso(id_recurso, id_sistema);


--
-- Name: recurso_vinculado fk_recurso_vinculado_recurso_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recurso_vinculado
    ADD CONSTRAINT fk_recurso_vinculado_recurso_2 FOREIGN KEY (id_recurso, id_sistema) REFERENCES public.recurso(id_recurso, id_sistema);


--
-- Name: rel_regra_auditoria_recurso fk_rel_auditoria_recurso_audit; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_regra_auditoria_recurso
    ADD CONSTRAINT fk_rel_auditoria_recurso_audit FOREIGN KEY (id_regra_auditoria) REFERENCES public.regra_auditoria(id_regra_auditoria);


--
-- Name: rel_hierarquia_unidade fk_rel_hie_uni_hierarquia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_hierarquia_unidade
    ADD CONSTRAINT fk_rel_hie_uni_hierarquia FOREIGN KEY (id_hierarquia) REFERENCES public.hierarquia(id_hierarquia);


--
-- Name: rel_hierarquia_unidade fk_rel_hie_uni_rel_hie_uni; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_hierarquia_unidade
    ADD CONSTRAINT fk_rel_hie_uni_rel_hie_uni FOREIGN KEY (id_hierarquia_pai, id_unidade_pai) REFERENCES public.rel_hierarquia_unidade(id_hierarquia, id_unidade);


--
-- Name: rel_hierarquia_unidade fk_rel_hie_uni_unidade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_hierarquia_unidade
    ADD CONSTRAINT fk_rel_hie_uni_unidade FOREIGN KEY (id_unidade) REFERENCES public.unidade(id_unidade);


--
-- Name: rel_orgao_autenticacao fk_rel_orgao_aut_autenticacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_orgao_autenticacao
    ADD CONSTRAINT fk_rel_orgao_aut_autenticacao FOREIGN KEY (id_servidor_autenticacao) REFERENCES public.servidor_autenticacao(id_servidor_autenticacao);


--
-- Name: rel_orgao_autenticacao fk_rel_orgao_aut_orgao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_orgao_autenticacao
    ADD CONSTRAINT fk_rel_orgao_aut_orgao FOREIGN KEY (id_orgao) REFERENCES public.orgao(id_orgao);


--
-- Name: rel_perfil_item_menu fk_rel_per_ite_men_rel_per_rec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_perfil_item_menu
    ADD CONSTRAINT fk_rel_per_ite_men_rel_per_rec FOREIGN KEY (id_perfil, id_recurso, id_sistema) REFERENCES public.rel_perfil_recurso(id_perfil, id_recurso, id_sistema);


--
-- Name: rel_perfil_item_menu fk_rel_perfil_item_menu_it_men; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_perfil_item_menu
    ADD CONSTRAINT fk_rel_perfil_item_menu_it_men FOREIGN KEY (id_item_menu, id_menu) REFERENCES public.item_menu(id_item_menu, id_menu);


--
-- Name: rel_perfil_recurso fk_rel_perfil_recurso_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_perfil_recurso
    ADD CONSTRAINT fk_rel_perfil_recurso_perfil FOREIGN KEY (id_perfil, id_sistema) REFERENCES public.perfil(id_perfil, id_sistema);


--
-- Name: rel_perfil_recurso fk_rel_perfil_recurso_recurso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_perfil_recurso
    ADD CONSTRAINT fk_rel_perfil_recurso_recurso FOREIGN KEY (id_recurso, id_sistema) REFERENCES public.recurso(id_recurso, id_sistema);


--
-- Name: sistema fk_sistema_hierarquia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sistema
    ADD CONSTRAINT fk_sistema_hierarquia FOREIGN KEY (id_hierarquia) REFERENCES public.hierarquia(id_hierarquia);


--
-- Name: sistema fk_sistema_orgao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sistema
    ADD CONSTRAINT fk_sistema_orgao FOREIGN KEY (id_orgao) REFERENCES public.orgao(id_orgao);


--
-- Name: unidade fk_unidade_orgao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT fk_unidade_orgao FOREIGN KEY (id_orgao) REFERENCES public.orgao(id_orgao);


--
-- Name: usuario_historico fk_usuario_historico_cod_acess; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_historico
    ADD CONSTRAINT fk_usuario_historico_cod_acess FOREIGN KEY (id_codigo_acesso) REFERENCES public.codigo_acesso(id_codigo_acesso);


--
-- Name: usuario_historico fk_usuario_historico_usu_oper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_historico
    ADD CONSTRAINT fk_usuario_historico_usu_oper FOREIGN KEY (id_usuario_operacao) REFERENCES public.usuario(id_usuario);


--
-- Name: usuario_historico fk_usuario_historico_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_historico
    ADD CONSTRAINT fk_usuario_historico_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- Name: usuario fk_usuario_orgao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_orgao FOREIGN KEY (id_orgao) REFERENCES public.orgao(id_orgao);


--
-- PostgreSQL database dump complete
--


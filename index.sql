CREATE TABLE public.usuarios (
                cpf   VARCHAR(11) NOT NULL,
                senha VARCHAR(55) NOT NULL,
                email VARCHAR(55) NOT NULL,
                nome  VARCHAR(55) NOT NULL,
                CONSTRAINT pk_ususarios PRIMARY KEY (cpf)
);
COMMENT ON TABLE public.usuarios IS 'Tabela dos usuarios cadastrados no Certificado Digital UVV';
COMMENT ON COLUMN public.usuarios.cpf IS 'CPF dos usuários cadastrados';
COMMENT ON COLUMN public.usuarios.senha IS 'Senha de login dos usuarios';
COMMENT ON COLUMN public.usuarios.email IS 'Email dos usuarios';
COMMENT ON COLUMN public.usuarios.nome IS 'Nome de login dos usuarios';

ALTER TABLE usuarios
ADD CONSTRAINT cc_usuarios_cpf
    CHECK (cpf IS NOT NULL);
ALTER TABLE usuarios
ADD CONSTRAINT cc_usuarios_senha
    CHECK (senha IS NOT NULL AND
           senha ~ '[A-Z]'   AND
           senha ~ '[a-z]'   AND
           senha ~ '[0-9]'   AND
           senha ~ '^.{8,}$');
ALTER TABLE usuarios
ADD CONSTRAINT cc_usuarios_email
    CHECK (email IS NOT NULL AND email ~ '^[^@]+@[^@]+$');
ALTER TABLE usuarios
ADD CONSTRAINT cc_usuarios_nome
    CHECK (nome IS NOT NULL);


CREATE TABLE public.alunos (
                cpf             VARCHAR(11) NOT NULL,
                data_nascimento DATE        NOT NULL,
                curso           VARCHAR(55) NOT NULL,
                matricula       NUMERIC(9)  NOT NULL,
                CONSTRAINT alunos_pk PRIMARY KEY (cpf)
);
COMMENT ON TABLE public.alunos IS 'Tabela de alunos cadastrados no Certificado Digital UVV';
COMMENT ON COLUMN public.alunos.cpf IS 'CPF dos alunos cadastrados';
COMMENT ON COLUMN public.alunos.data_nascimento IS 'Data de nascimento dos alunos cadastrados';
COMMENT ON COLUMN public.alunos.curso IS 'Curso dos alunos cadastrados';
COMMENT ON COLUMN public.alunos.matricula IS 'Número de matricula dos alunos cadastrados';

ALTER TABLE alunos
ADD CONSTRAINT cc_alunos_cpf
    CHECK (cpf IS NOT NULL);
ALTER TABLE alunos
ADD CONSTRAINT cc_alunos_data_nascimento
    CHECK (data_nascimento IS NOT NULL);
ALTER TABLE alunos
ADD CONSTRAINT cc_alunos_curso
    CHECK (curso IS NOT NULL);
ALTER TABLE alunos
ADD CONSTRAINT cc_alunos_matricula
    CHECK (matricula IS NOT NULL);


CREATE TABLE public.certificado (
                id_certificado      VARCHAR(55)   NOT NULL,
                imagem              BYTEA         NOT NULL,
                data_de_emissao     DATE          NOT NULL,
                titulo_certificados VARCHAR(55)   NOT NULL,
                data_de_expiracao   DATE          NOT NULL,
                horas               NUMERIC(55,2) NOT NULL,
                cpf                 VARCHAR(11)   NOT NULL,
                CONSTRAINT certificado_pk PRIMARY KEY (id_certificado)
);
COMMENT ON TABLE public.certificado IS 'Tabela de certificados enviados';
COMMENT ON COLUMN public.certificado.id_certificado IS 'Identificador único de cada certificado';
COMMENT ON COLUMN public.certificado.imagem IS 'Imagem de cada certificado';
COMMENT ON COLUMN public.certificado.data_de_emissao IS 'Data que o certificado foi emitido';
COMMENT ON COLUMN public.certificado.titulo_certificados IS 'Título de cada certificado';
COMMENT ON COLUMN public.certificado.data_de_expiracao IS 'Data de expiracao do certificado';
COMMENT ON COLUMN public.certificado.horas IS 'Numero total de horas contabilizadas';
COMMENT ON COLUMN public.certificado.cpf IS 'CPF dos alunos cadastrados';

ALTER TABLE certificado
ADD CONSTRAINT cc_certificado_id_certificado
    CHECK (id_certificado IS NOT NULL);
ALTER TABLE certificado
ADD CONSTRAINT cc_certificado_imagem
    CHECK (imagem IS NOT NULL);
ALTER TABLE certificado
ADD CONSTRAINT cc_certificado_data_de_emissao
    CHECK (data_de_emissao IS NOT NULL);
ALTER TABLE certificado
ADD CONSTRAINT cc_certificado_titulo_certificados
    CHECK (titulo_certificados IS NOT NULL);
ALTER TABLE certificado
ADD CONSTRAINT cc_certificado_data_de_expiracao
    CHECK (data_de_expiracao IS NOT NULL);
ALTER TABLE certificado
ADD CONSTRAINT cc_certificado_horas
    CHECK (horas IS NOT NULL);
ALTER TABLE certificado
ADD CONSTRAINT cc_certificado_cpf
    CHECK (cpf IS NOT NULL);


CREATE TABLE public.avaliador (
                cpf VARCHAR(11) NOT NULL,
                CONSTRAINT avaliador_pk PRIMARY KEY (cpf)
);
COMMENT ON TABLE public.avaliador IS 'Tabela dos avaliadores cadastrados no Certificado DIgital UVV';
COMMENT ON COLUMN public.avaliador.cpf IS 'CPF dos avaliadores cadastrados';

ALTER TABLE avaliador
ADD CONSTRAINT cc_avaliador_cpf
    CHECK (cpf IS NOT NULL);


CREATE TABLE public.avaliacao (
                id_avaliacao        VARCHAR(55) NOT NULL,
                cpf                 VARCHAR(11) NOT NULL,
                id_certificado      VARCHAR(55) NOT NULL,
                resultado_avaliacao VARCHAR(55) NOT NULL,
                CONSTRAINT avaliacao_pk PRIMARY KEY (id_avaliacao)
);
COMMENT ON TABLE public.avaliacao IS 'Tabela que armazena dados de avaliação dos certificados';
COMMENT ON COLUMN public.avaliacao.id_avaliacao IS 'Identificador único para avaliação';
COMMENT ON COLUMN public.avaliacao.cpf IS 'CPF dos avaliadores cadastrados';
COMMENT ON COLUMN public.avaliacao.id_certificado IS 'Identificador único criado para cada certificado';
COMMENT ON COLUMN public.avaliacao.resultado_avaliacao IS 'Resultado da aprovação ou negação do certificado';

ALTER TABLE avaliacao
ADD CONSTRAINT cc_avaliacao_id_avaliacao
    CHECK (id_avaliacao IS NOT NULL);
ALTER TABLE avaliacao
ADD CONSTRAINT cc_avaliacao_cpf
    CHECK (cpf IS NOT NULL);
ALTER TABLE avaliacao
ADD CONSTRAINT cc_avaliacao_id_certificado
    CHECK (id_certificado IS NOT NULL);
ALTER TABLE avaliacao
ADD CONSTRAINT cc_avaliacao_resultado_avaliacao
    CHECK (resultado_avaliacao IS NOT NULL);


ALTER TABLE public.avaliador ADD CONSTRAINT usuarios_avaliador_fk
FOREIGN KEY (cpf)
REFERENCES public.usuarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.alunos ADD CONSTRAINT usuarios_alunos_fk
FOREIGN KEY (cpf)
REFERENCES public.usuarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.certificado ADD CONSTRAINT alunos_certificado_fk
FOREIGN KEY (cpf)
REFERENCES public.alunos (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.avaliacao ADD CONSTRAINT certificado_avaliacao_fk
FOREIGN KEY (id_certificado)
REFERENCES public.certificado (id_certificado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.avaliacao ADD CONSTRAINT avaliador_avaliacao_fk
FOREIGN KEY (cpf)
REFERENCES public.avaliador (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

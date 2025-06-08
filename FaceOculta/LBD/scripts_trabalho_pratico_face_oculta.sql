--esta tabela é apenas para alimentar um comboBox dinamicamente solicitado pela professora denilce; 
-- tem como objetivo gerar relatorios para a função admin da plataforma para realizar o acompanhamento  
-- dos alunos;
CREATE TABLE local_trabalho( 
    id_local_trabalho  NUMBER GENERATED ALWAYS AS IDENTITY, 
    empresa varchar(50) NOT NULL
);

ALTER TABLE local_trabalho ADD CONSTRAINT PK_local_trabalho
    PRIMARY KEY(id_local_trabalho); 

-----------------------------------------------------

CREATE TABLE TipoUsuario (
    id_tipo_usuario NUMBER GENERATED ALWAYS AS IDENTITY,
    nome varchar2(50) NOT NULL
);

ALTER TABLE TipoUsuario ADD CONSTRAINT PK_TipoUsuario
    PRIMARY KEY(id_tipo_usuario);
------------------------------------------------------
CREATE TABLE Usuario (
    Id_Usuario            NUMBER GENERATED ALWAYS AS IDENTITY, 
    Nome                  VARCHAR2(80) NOT NULL,
    Email                 VARCHAR2(50) NOT NULL,
    Senha                 VARCHAR2(20) NOT NULL,
    Bio                   VARCHAR2(200),
    Foto                  VARCHAR2(255),
    RecebeNotificacao     SMALLINT DEFAULT 0 NOT NULL, -- sempre começar o checkBox no front como false
    Egressos              SMALLINT DEFAULT 0 NOT NULL, -- sempre começar o checkBox no front como false
    Id_TipoUsuario        NUMBER NOT NULL,
    User_Enabled          SMALLINT DEFAULT 0 NOT NULL, -- se usuario está aprovado na plataforma
    status_usuario        VARCHAR2(20) NOT NULL, -- definido como enum no diagrama de classes
    id_LocalTrabalho      NUMBER
);

ALTER TABLE Usuario ADD CONSTRAINT PK_Id_Usuario 
    PRIMARY KEY(Id_Usuario);

ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_TipoUsuario
    FOREIGN KEY (Id_TipoUsuario)
    REFERENCES TipoUsuario (id_tipo_usuario);

ALTER TABLE USUARIO ADD CONSTRAINT FK_Usuario_LocalTrabalho
    FOREIGN KEY (id_LocalTrabalho)
    REFERENCES LOCAL_TRABALHO (ID_LOCAL_TRABALHO);

---------------------------------

CREATE TABLE Eventos (
    Id_evento        NUMBER GENERATED ALWAYS AS IDENTITY,
    Titulo           VARCHAR2(100) NOT NULL,
    DataInicio       DATE NOT NULL,
    DataFim          DATE NOT NULL,
    Local_evento     VARCHAR2(150),
    Descricao        VARCHAR2(1000),
    Fotos            VARCHAR2(255), 
    fk_Usuario_Id    NUMBER NOT NULL
);

ALTER TABLE Eventos ADD CONSTRAINT FK_Eventos_Usuario
    FOREIGN KEY (fk_Usuario_Id)
    REFERENCES Usuario (Id_Usuario);

ALTER TABLE Eventos ADD CONSTRAINT PK_Id_evento
    PRIMARY KEY(Id_evento);
---------------------------------------------------------- 
CREATE TABLE Vagas (
    Id_vagas       NUMBER GENERATED ALWAYS AS IDENTITY,
    Titulo         VARCHAR2(100) NOT NULL,
    Descricao      VARCHAR2(1000),
    Empresa        VARCHAR2(100),
    Fotos          VARCHAR2(255), 
    fk_Usuario_Id  NUMBER NOT NULL
);

ALTER TABLE Vagas ADD CONSTRAINT FK_Vagas_Usuario
    FOREIGN KEY (fk_Usuario_Id)
    REFERENCES Usuario (Id_Usuario);
---------------------------------------------------------- 

CREATE TABLE LinksRedes (
    id_link        NUMBER GENERATED ALWAYS AS IDENTITY,
    endereco       VARCHAR2(255) NOT NULL,
    tipo_rede      VARCHAR2(50) NOT NULL,--definido como enum no diagrama de classes
    fk_id_usuario  NUMBER NOT NULL
);

ALTER TABLE LinksRedes ADD CONSTRAINT PK_LinksRedes
    PRIMARY KEY(id_link);

ALTER TABLE LinksRedes ADD CONSTRAINT FK_LinksRedes_Usuario
    FOREIGN KEY (fk_id_usuario)
    REFERENCES Usuario (Id_Usuario);
-----------------------------------------------------------------------

CREATE TABLE Notificacao (
    id_notificacao NUMBER GENERATED ALWAYS AS IDENTITY,
    titulo VARCHAR2(50) NOT NULL,
    descricao VARCHAR2(100),
    data_envio DATE 
); 
ALTER TABLE Notificacao ADD CONSTRAINT PK_notificacao
    PRIMARY KEY(id_notificacao);  
-------------------------------------------------------------------------- 

CREATE TABLE Cursos (
    Id_curso NUMBER GENERATED ALWAYS AS IDENTITY,
    Nome VARCHAR2 (255),
    Sigla VARCHAR2(10)
); 
ALTER TABLE Cursos ADD CONSTRAINT PK_Cursos
    PRIMARY KEY(Id_curso);   
---------------------------------------------------------------------------- 

CREATE TABLE Usuario_curso (
    fk_Cursos_ID NUMBER,
    fk_Usuario_Id NUMBER,
    id_Usuario_curso NUMBER GENERATED ALWAYS AS IDENTITY
);
 
ALTER TABLE Usuario_curso ADD CONSTRAINT PK_Usuario_curso
    PRIMARY KEY(id_Usuario_curso);

ALTER TABLE Usuario_curso ADD CONSTRAINT FK_Usuario_curso_CURSO
    FOREIGN KEY (fk_Cursos_ID)
    REFERENCES Cursos (Id_curso);
 
ALTER TABLE Usuario_curso ADD CONSTRAINT FK_Usuario_curso_USUARIO
    FOREIGN KEY (fk_Usuario_Id)
    REFERENCES Usuario (Id_Usuario);

------------------------------------------------------------------------------- 

CREATE TABLE conversa (
    id_mensagem NUMBER GENERATED ALWAYS AS IDENTITY,
    remetente NUMBER NOT NULL,
    destinatario NUMBER NOT NULL,
    id_origem NUMBER,
    mensagem VARCHAR2(500)
);
ALTER TABLE conversa ADD CONSTRAINT PK_mensagem
    PRIMARY KEY(id_mensagem); 

ALTER TABLE conversa ADD CONSTRAINT FK_remetente
    FOREIGN KEY (remetente)
    REFERENCES Usuario (Id_Usuario);
 
ALTER TABLE conversa ADD CONSTRAINT FK_destinatario
    FOREIGN KEY (destinatario)
    REFERENCES Usuario (Id_Usuario);

alter table conversa ADD CONSTRAINT FK_id_origem --auto relacionamento de mensagens
    FOREIGN KEY (id_origem)
    REFERENCES conversa (id_mensagem); 

-- questÃ£o 2  letra C 

INSERT INTO TipoUsuario (nome) VALUES ('Aluno');
INSERT INTO TipoUsuario (nome) VALUES ('Administrador');
INSERT INTO TipoUsuario (nome) VALUES ('Professor');

---------

INSERT INTO local_trabalho (empresa)
VALUES ('InfoTech');

INSERT INTO local_trabalho (empresa)
VALUES ('SoftSolutions');

INSERT INTO local_trabalho (empresa)
VALUES ('DataCorp');

INSERT INTO local_trabalho (empresa)
VALUES ('WebDesigners');

INSERT INTO local_trabalho (empresa)
VALUES ('BackSolutions');

INSERT INTO local_trabalho (empresa)
VALUES ('Google Inc.');

-------

INSERT INTO Usuario (Nome, Email, Senha, Bio, Foto, RecebeNotificacao, Egressos, Id_TipoUsuario, User_Enabled, status_usuario, id_LocalTrabalho)
VALUES ('Carlos Silva', 'carlos@email.com', 'senha123', 'Aluno do 3º semestre', NULL, 1, 1, 1, 1, 'ativo',1);

INSERT INTO Usuario (Nome, Email, Senha, Bio, Foto, RecebeNotificacao, Egressos, Id_TipoUsuario, User_Enabled, status_usuario, id_LocalTrabalho)
VALUES ('Ana Lima', 'ana@email.com', 'senha456', 'Professora de banco de dados', NULL, 1, 1, 3, 1, 'ativo',2);

INSERT INTO Usuario (Nome, Email, Senha, Bio, Foto, RecebeNotificacao, Egressos, Id_TipoUsuario, User_Enabled, status_usuario, id_LocalTrabalho)
VALUES ('João Souza', 'joao@email.com', 'senha789', 'Administrador do sistema', NULL, 0, 0, 2, 1, 'ativo',3);

INSERT INTO Usuario (Nome, Email, Senha, Bio, Foto, RecebeNotificacao, Egressos, Id_TipoUsuario, User_Enabled, status_usuario, id_LocalTrabalho)
VALUES ('Maria Fernanda', 'maria@email.com', 'senhaabc', 'Aluna de ADS', NULL, 1, 0, 1, 0, 'pendente',4);

INSERT INTO Usuario (Nome, Email, Senha, Bio, Foto, RecebeNotificacao, Egressos, Id_TipoUsuario, User_Enabled, status_usuario, id_LocalTrabalho)
VALUES ('Ricardo Costa', 'ricardo@email.com', 'senhaxyz', 'Professor de Java', NULL, 1, 1, 3, 1, 'ativo',4);


------
INSERT INTO Eventos (Titulo, DataInicio, DataFim, Local_evento, Descricao, Fotos, fk_Usuario_Id)
VALUES ('Semana de Tecnologia', DATE '2025-06-10', DATE '2025-06-14', 'Auditório 1', 'Evento anual com palestras e workshops', NULL, 2);

INSERT INTO Eventos (Titulo, DataInicio, DataFim, Local_evento, Descricao, Fotos, fk_Usuario_Id)
VALUES ('Oficina de Spring Boot', DATE '2025-07-01', DATE '2025-07-01', 'Lab 3', 'Introdução ao Spring Boot', NULL, 5);

INSERT INTO Eventos (Titulo, DataInicio, DataFim, Local_evento, Descricao, Fotos, fk_Usuario_Id)
VALUES ('Encontro de Egressos', DATE '2025-08-05', DATE '2025-08-05', 'Salão Nobre', 'Conexão entre ex-alunos', NULL, 3);

INSERT INTO Eventos (Titulo, DataInicio, DataFim, Local_evento, Descricao, Fotos, fk_Usuario_Id)
VALUES ('Palestra de Carreira', DATE '2025-09-01', DATE '2025-09-01', 'Auditório 2', 'Dicas para o mercado de trabalho', NULL, 1);

INSERT INTO Eventos (Titulo, DataInicio, DataFim, Local_evento, Descricao, Fotos, fk_Usuario_Id)
VALUES ('Feira de Estágios', DATE '2025-10-20', DATE '2025-10-21', 'Campus Central', 'Conexão com empresas', NULL, 4);

---------------

INSERT INTO Vagas (Titulo, Descricao, Empresa, Fotos, fk_Usuario_Id)
VALUES ('Estágio em TI', 'Suporte técnico e manutenção', 'InfoTech', NULL, 2);

INSERT INTO Vagas (Titulo, Descricao, Empresa, Fotos, fk_Usuario_Id)
VALUES ('Desenvolvedor Java Junior', 'Manutenção e criação de APIs', 'SoftSolutions', NULL, 5);

INSERT INTO Vagas (Titulo, Descricao, Empresa, Fotos, fk_Usuario_Id)
VALUES ('Analista de Dados', 'SQL, Python e Power BI', 'DataCorp', NULL, 5);

INSERT INTO Vagas (Titulo, Descricao, Empresa, Fotos, fk_Usuario_Id)
VALUES ('Front-end Developer', 'React e UX/UI', 'WebDesigners', NULL, 1);

INSERT INTO Vagas (Titulo, Descricao, Empresa, Fotos, fk_Usuario_Id)
VALUES ('Backend com Spring', 'Projetos em Java Spring', 'BackSolutions', NULL, 2);

--------

INSERT INTO LinksRedes (endereco, tipo_rede, fk_id_usuario)
VALUES ('https://linkedin.com/in/carlos', 'LinkedIn', 1);

INSERT INTO LinksRedes (endereco, tipo_rede, fk_id_usuario)
VALUES ('https://github.com/ana', 'GitHub', 2);

INSERT INTO LinksRedes (endereco, tipo_rede, fk_id_usuario)
VALUES ('https://linkedin.com/in/joao', 'LinkedIn', 3);

INSERT INTO LinksRedes (endereco, tipo_rede, fk_id_usuario)
VALUES ('https://instagram.com/maria', 'Instagram', 4);

INSERT INTO LinksRedes (endereco, tipo_rede, fk_id_usuario)
VALUES ('https://github.com/ricardo', 'GitHub', 5);

-------

INSERT INTO Notificacao (titulo, descricao, data_envio) 
VALUES ('Nova Vaga Disponível', 'Confira a nova vaga publicada.', SYSDATE);

INSERT INTO Notificacao (titulo, descricao, data_envio) 
VALUES ('Evento Confirmado', 'Semana de Tecnologia confirmada!', SYSDATE);

INSERT INTO Notificacao (titulo, descricao, data_envio) 
VALUES ('Atualização de Perfil', 'Não se esqueça de atualizar seu perfil.', SYSDATE);

INSERT INTO Notificacao (titulo, descricao, data_envio) 
VALUES ('Cadastro Pendente', 'Confirme seu e-mail.', SYSDATE);

INSERT INTO Notificacao (titulo, descricao, data_envio) 
VALUES ('Novo Curso', 'Curso de Cloud Computing disponível.', SYSDATE);

-------

INSERT INTO Cursos (Nome, Sigla) VALUES ('Análise e Desenvolvimento de Sistemas', 'ADS');
INSERT INTO Cursos (Nome, Sigla) VALUES ('Fabricação Mecânica', 'FMEC');
INSERT INTO Cursos (Nome, Sigla) VALUES ('Logística', 'LOG');
INSERT INTO Cursos (Nome, Sigla) VALUES ('Projetos Mecânicos', 'PMEC');
INSERT INTO Cursos (Nome, Sigla) VALUES ('Polímeros', 'POL');

-------

INSERT INTO Usuario_curso (fk_Cursos_ID, fk_Usuario_Id) VALUES (1, 1);
INSERT INTO Usuario_curso (fk_Cursos_ID, fk_Usuario_Id) VALUES (3, 2);
INSERT INTO Usuario_curso (fk_Cursos_ID, fk_Usuario_Id) VALUES (2, 3);
INSERT INTO Usuario_curso (fk_Cursos_ID, fk_Usuario_Id) VALUES (1, 4);
INSERT INTO Usuario_curso (fk_Cursos_ID, fk_Usuario_Id) VALUES (4, 5);

------

INSERT INTO conversa (remetente, destinatario, id_origem, mensagem) VALUES (1, 2, NULL, 'Oi, tudo bem?');
INSERT INTO conversa (remetente, destinatario, id_origem, mensagem) VALUES (2, 1, 1, 'Tudo sim, e você?');
INSERT INTO conversa (remetente, destinatario, id_origem, mensagem) VALUES (3, 4, NULL, 'Olá, já está aprovada sua conta.');
INSERT INTO conversa (remetente, destinatario, id_origem, mensagem) VALUES (4, 3, 3, 'Obrigado!');
INSERT INTO conversa (remetente, destinatario, id_origem, mensagem) VALUES (5, 1, NULL, 'Boa sorte na entrevista!');


-------

SELECT * FROM USUARIO; 
SELECT * FROM CONVERSA; 
SELECT * FROM EVENTOS; 
SELECT * FROM VAGAS; 
SELECT * FROM LINKSREDES;
SELECT * FROM local_trabalho; 
SELECT * FROM NOTIFICACAO; 
select * from cursos;
select * from Usuario_curso;
select * from TipoUsuario;

---------------------------------------------------------------------- 
-- questão 2  letra D 

--Usuario
create index indice_id_usuario on usuario (Id_Usuario);

--mensagem: criação para fazer o pai da arvore
create index indice_origem_mensagem on conversa(id_origem)

------------------------------------------------

-- questão 3 letra A 

SELECT u.Nome AS Nome_Usuario, c.Nome AS Nome_Curso
FROM Usuario_curso us
INNER JOIN Usuario u 
    ON us.fk_Usuario_Id = u.Id_Usuario
INNER JOIN Cursos c 
    ON us.fk_Cursos_ID = c.Id_curso; 

-- questão 3 letra B
SELECT count(*) as total_eventos from eventos where TO_CHAR(DataInicio,'YYYY')='2025' 


-- questão 3 letra C 
-- só irá retornar o usuario 5, usuario que ninguem quer conversar
SELECT u.Nome, u.Id_Usuario
FROM Usuario u
LEFT JOIN conversa c
    ON u.Id_Usuario = c.destinatario
WHERE c.destinatario IS NULL;

-- questão 3 letra D
-- usuario participativos na plataforma, que fizeram pelo menos uma publicação de vaga OU evento, não retornará o ID 4
SELECT u.Nome, u.Id_Usuario
FROM Usuario u
JOIN Eventos e ON u.Id_Usuario = e.fk_Usuario_Id

UNION

SELECT u.Nome, u.Id_Usuario
FROM Usuario u
JOIN Vagas v ON u.Id_Usuario = v.fk_Usuario_Id;

--questão 3 letra E
--voltará apenas o usuário ID 3 pois ele não tem vagas publicadas, apenas eventos
SELECT u.Nome, u.Id_Usuario
FROM Usuario u
JOIN Eventos e ON u.Id_Usuario = e.fk_Usuario_Id

MINUS

SELECT u.Nome, u.Id_Usuario
FROM Usuario u
JOIN Vagas v ON u.Id_Usuario = v.fk_Usuario_Id;

--questão 3 letra F
--retorna apenas os usuários que possuem vagas E eventos
SELECT u.Nome, u.Id_Usuario
FROM Usuario u
JOIN Eventos e ON u.Id_Usuario = e.fk_Usuario_Id

INTERSECT

SELECT u.Nome, u.Id_Usuario
FROM Usuario u
JOIN Vagas v ON u.Id_Usuario = v.fk_Usuario_Id;

--questão 4 letra A
--retorna apenas os locais de trabalho que possuem usuários
SELECT * FROM LOCAL_TRABALHO
WHERE ID_LOCAL_TRABALHO IN (SELECT ID_LocalTrabalho FROM USUARIO);

--questão 4 letra B
--retorna apenas os locais de trabalho que NÃO possuem usuários
SELECT * FROM LOCAL_TRABALHO LT
WHERE NOT EXISTS (SELECT 1 from usuario U where U.ID_LOCALTRABALHO = LT.ID_LOCAL_TRABALHO);

--questão 4 letra C
--altera todos os criadores de eventos para o usuário do tipo ADMINISTRADOR (ID 2)
UPDATE eventos set fk_usuario_id = (select id_usuario from usuario where ID_TIPOUSUARIO = 2 AND ROWNUM = 1);

--questão 4 letra D
--deleta todas as vagas que foram criadas por usuários do tipo ALUNO (ID 1)
DELETE FROM VAGAS WHERE FK_USUARIO_ID IN (SELECT ID_USUARIO FROM USUARIO WHERE ID_TIPOUSUARIO = 1);

--questão 5 letra A
--lista todos os alunos do curso que será informado na procedure: ADS, FMEC, LOG, PMEC, POL
CREATE OR REPLACE PROCEDURE SP_ConsultaAlunosCurso(PSiglaCurso VARCHAR2) AS
VID_CURSO CURSOS.ID_CURSO%TYPE;
BEGIN
    SELECT ID_CURSO INTO VID_CURSO FROM CURSOS WHERE SIGLA LIKE UPPER(PSiglaCurso);
    
    FOR X IN(
        SELECT U.NOME NOME, UC.FK_CURSOS_ID ID_CURSO, C.NOME CURSO, U.EGRESSOS EGRESSO FROM USUARIO U
        INNER JOIN USUARIO_CURSO UC
        ON UC.FK_USUARIO_ID = U.ID_USUARIO
        INNER JOIN CURSOS C
        ON C.ID_CURSO = UC.FK_CURSOS_ID
        WHERE UC.FK_CURSOS_ID = VID_CURSO
    )
    LOOP
        IF X.EGRESSO = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Aluno: '||X.NOME||' | Curso: '|| X.CURSO||' | Egresso? SIM');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Aluno: '||X.NOME||' | Curso: '|| X.CURSO||' | Egresso? NÃO');
        END IF;
    END LOOP;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Curso não encontrado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;

--deverá ser informado no exec qual a sigla do curso que deseja ver os usuários: ADS, FMEC, LOG, PMEC, POL
SET SERVEROUTPUT ON;
EXEC SP_ConsultaAlunosCurso('ads');

--questão 5 letra B
--essa função retorna a quantidade de mensagens trocadas entre dois usuários
CREATE OR REPLACE FUNCTION Conta_Mensagens(P_ID1 IN CONVERSA.REMETENTE%TYPE, P_ID2 IN CONVERSA.REMETENTE%TYPE)
RETURN VARCHAR2 IS
V_CONTADOR NUMBER;
V_VERIFICA_REMETENTE USUARIO.ID_USUARIO%TYPE;
V_VERIFICA_DESTINATARIO USUARIO.ID_USUARIO%TYPE;
BEGIN
    SELECT ID_USUARIO INTO V_VERIFICA_REMETENTE FROM USUARIO WHERE ID_USUARIO = P_ID1;
    SELECT ID_USUARIO INTO V_VERIFICA_DESTINATARIO FROM USUARIO WHERE ID_USUARIO = P_ID2;

    SELECT COUNT(*) INTO V_CONTADOR FROM CONVERSA WHERE ((REMETENTE = P_ID1 AND DESTINATARIO = P_ID2) OR (REMETENTE = P_ID2 AND DESTINATARIO = P_ID1));
    RETURN (''||V_CONTADOR);
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Usuário inexistente!';
END;

SELECT Conta_Mensagens(1,5) from dual;

--questão 5 letra C
--sempre que um usuário for aprovado no sistema após o seu cadastro, será gerado um log de quem aprovou ele junto de seu nome
CREATE TABLE TABLOG(
ID_LOG NUMBER GENERATED ALWAYS AS IDENTITY,
USUARIO VARCHAR2(50),
DATALOG DATE,
DESCRICAO VARCHAR2(100)
)

CREATE OR REPLACE TRIGGER Usuario_Aprovado
AFTER UPDATE OF USER_ENABLED ON USUARIO
FOR EACH ROW
WHEN (NEW.USER_ENABLED = 1)
BEGIN    
    INSERT INTO TABLOG (USUARIO, DATALOG, DESCRICAO) VALUES (USER, SYSDATE, 'Usuário '||:NEW.NOME||' teve seu cadastro aprovado!');
END;

UPDATE USUARIO SET USER_ENABLED = 1 WHERE ID_USUARIO = 4;

--questão 5 letra D
--essa trigger cancela todo o insert do evento se a data de início for maior que a data de fim
CREATE OR REPLACE TRIGGER Verifica_Data_Evento
BEFORE INSERT ON EVENTOS
FOR EACH ROW
BEGIN
    IF :NEW.DATAINICIO > :NEW.DATAFIM THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data de início do evento é maior do que a de fim, favor alterar!');
    END IF;
END;

INSERT INTO EVENTOS (TITULO, DATAINICIO, DATAFIM, LOCAL_EVENTO, DESCRICAO, FOTOS, FK_USUARIO_ID)
VALUES ('teste de trigger', DATE '2025-06-07', DATE '2025-06-06', 'MINHA CASA', 'É SÓ UM TESTE, SE FUNCIONAR DEU BOM', NULL, 1);

select * from eventos;
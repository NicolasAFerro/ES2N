/* Integrantes: 

GABRIEL BELLATO - RA: 00304823130 
LEONARDO BARBOSA DA SILVA - RA: 0030482313035 
NICOLAS ALEXANDRINO FERRO - RA: 0030482313036 */

-- questão 2  letra B
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
    status_usuario        VARCHAR2(20) NOT NULL -- definido como enum no diagrama de classes
);

ALTER TABLE Usuario ADD CONSTRAINT PK_Id_Usuario 
    PRIMARY KEY(Id_Usuario);

ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_TipoUsuario
    FOREIGN KEY (Id_TipoUsuario)
    REFERENCES TipoUsuario (id_tipo_usuario)
    

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
--esta tabela é apenas para alimentar um comboBox dinamicamente solicitado pela professora denilce; 
-- tem como objetivo gerar relatorios para a função admin da plataforma para realizar o acompanhamento  
-- dos alunos;
CREATE TABLE local_trabalho( 
    id_local_trabalho  NUMBER GENERATED ALWAYS AS IDENTITY, 
    empresa varchar(50) NOT NULL
)
ALTER TABLE local_trabalho ADD CONSTRAINT PK_local_trabalho
    PRIMARY KEY(id_local_trabalho); 

------------------------------------------------------------------------ 

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

-- questão 2  letra C 

INSERT INTO TipoUsuario (nome) VALUES ('Aluno');
INSERT INTO TipoUsuario (nome) VALUES ('Administrador');
INSERT INTO TipoUsuario (nome) VALUES ('Professor');

INSERT INTO Usuario (Nome, Email, Senha, Bio, Foto, RecebeNotificacao, Egressos, Id_TipoUsuario, User_Enabled, status_usuario)
VALUES 
('Carlos Silva', 'carlos@email.com', 'senha123', 'Aluno do 3º semestre', NULL, 1, 0, 1, 1, 'ativo'),
('Ana Lima', 'ana@email.com', 'senha456', 'Professora de banco de dados', NULL, 1, 1, 3, 1, 'ativo'),
('João Souza', 'joao@email.com', 'senha789', 'Administrador do sistema', NULL, 0, 0, 2, 1, 'ativo'),
('Maria Fernanda', 'maria@email.com', 'senhaabc', 'Aluna de ADS', NULL, 1, 0, 1, 0, 'pendente'),
('Ricardo Costa', 'ricardo@email.com', 'senhaxyz', 'Professor de Java', NULL, 1, 1, 3, 1, 'ativo');

INSERT INTO Eventos (Titulo, DataInicio, DataFim, Local_evento, Descricao, Fotos, fk_Usuario_Id)
VALUES 
('Semana de Tecnologia', DATE '2025-06-10', DATE '2025-06-14', 'Auditório 1', 'Evento anual com palestras e workshops', NULL, 2),
('Oficina de Spring Boot', DATE '2025-07-01', DATE '2025-07-01', 'Lab 3', 'Introdução ao Spring Boot', NULL, 5),
('Encontro de Egressos', DATE '2025-08-05', DATE '2025-08-05', 'Salão Nobre', 'Conexão entre ex-alunos', NULL, 3),
('Palestra de Carreira', DATE '2025-09-01', DATE '2025-09-01', 'Auditório 2', 'Dicas para o mercado de trabalho', NULL, 1),
('Feira de Estágios', DATE '2025-10-20', DATE '2025-10-21', 'Campus Central', 'Conexão com empresas', NULL, 4);

INSERT INTO Vagas (Titulo, Descricao, Empresa, Fotos, fk_Usuario_Id)
VALUES 
('Estágio em TI', 'Suporte técnico e manutenção', 'InfoTech', NULL, 3),
('Desenvolvedor Java Junior', 'Manutenção e criação de APIs', 'SoftSolutions', NULL, 3),
('Analista de Dados', 'SQL, Python e Power BI', 'DataCorp', NULL, 3),
('Front-end Developer', 'React e UX/UI', 'WebDesigners', NULL, 3),
('Backend com Spring', 'Projetos em Java Spring', 'BackSolutions', NULL, 3);

INSERT INTO LinksRedes (endereco, tipo_rede, fk_id_usuario)
VALUES 
('https://linkedin.com/in/carlos', 'LinkedIn', 1),
('https://github.com/ana', 'GitHub', 2),
('https://linkedin.com/in/joao', 'LinkedIn', 3),
('https://instagram.com/maria', 'Instagram', 4),
('https://github.com/ricardo', 'GitHub', 5);

INSERT INTO local_trabalho (empresa)
VALUES 
('InfoTech'),
('SoftSolutions'),
('DataCorp'),
('WebDesigners'),
('BackSolutions');


INSERT INTO Notificacao (titulo, descricao, data_envio)
VALUES 
('Nova Vaga Disponível', 'Confira a nova vaga publicada.', SYSDATE),
('Evento Confirmado', 'Semana de Tecnologia confirmada!', SYSDATE),
('Atualização de Perfil', 'Não se esqueça de atualizar seu perfil.', SYSDATE),
('Cadastro Pendente', 'Confirme seu e-mail.', SYSDATE),
('Novo Curso', 'Curso de Cloud Computing disponível.', SYSDATE);

INSERT INTO Cursos (Nome, Sigla)
VALUES 
('Análise e Desenvolvimento de Sistemas', 'ADS'),
('Fabricação Mecânica', 'FMEC'),
('Logistica', 'Log'),
('Projetos Mecânicos', 'PMEC'),
('Polimeros', 'POL');


INSERT INTO Usuario_curso (fk_Cursos_ID, fk_Usuario_Id)
VALUES 
(1, 1),
(3, 2),
(2, 3),
(1, 4),
(4, 5);


INSERT INTO conversa (remetente, destinatario, id_origem, mensagem)
VALUES 
(1, 2, NULL, 'Oi, tudo bem?'),
(2, 1, 1, 'Tudo sim, e você?'),
(3, 4, NULL, 'Olá, já está aprovada sua conta.'),
(4, 3, 3, 'Obrigado!'),
(5, 1, NULL, 'Boa sorte na entrevista!');


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
create  index indice_id_usuario on usuario (Id_Usuario);

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

-- questão 3 letra d 
-- usuario participativos na plataforma, que fizeram pelo menos uma publicação de vaga e evento
SELECT u.Nome, u.Id_Usuario
FROM Usuario u
JOIN Eventos e ON u.Id_Usuario = e.fk_Usuario_Id

UNION

SELECT u.Nome, u.Id_Usuario
FROM Usuario u
JOIN Vagas v ON u.Id_Usuario = v.fk_Usuario_Id;
---------------------------------------------------------------
-- CRIANDO A ESTRUTURA COM A TABELA ASSOCIATIVA [CURSOS_PROFESSORES]
-- Relação N para N entre as tabelas
--	Permitindo que um professor possa lecionar em varios cursos e um curso possa pertencer a vários professores!

DROP TABLE IF EXISTS ALUNOS, CURSOS, PROFESSORES,DEPARTAMENTOS;

CREATE TABLE ALUNOS(
	ID SERIAL PRIMARY KEY,
	IDCURSO INTEGER, --FK da tabela CURSOS
	RA VARCHAR NOT NULL UNIQUE,
	NOME VARCHAR NOT NULL,
	DATACADASTRO DATE NOT NULL,
	EMAIL VARCHAR UNIQUE,
	TELEFONE VARCHAR UNIQUE,
	ENDERECO VARCHAR,
	INICIOCURSO DATE,
	CONCLUSAOCURSO DATE,
	STATUS VARCHAR(1) NOT NULL DEFAULT 'C' 
);

CREATE TABLE CURSOS (
	ID SERIAL PRIMARY KEY,
	CODIGO VARCHAR (5) NOT NULL UNIQUE,
	NOME VARCHAR NOT NULL,
	DESCRICAO VARCHAR NOT NULL,
	CARGAHORARIA INTEGER NOT NULL,
	MODALIDADE VARCHAR,
	NIVEL VARCHAR
);

CREATE TABLE PROFESSORES(
	ID SERIAL PRIMARY KEY,
	IDDEPARTAMENTO INTEGER, --FK da tabela DEPARTAMENTO
	CODIGO VARCHAR NOT NULL UNIQUE,
	NOME VARCHAR NOT NULL,
	DATANASCIMENTO DATE,
	EMAIL VARCHAR UNIQUE,
	DATACADASTRO DATE,
	COORDENADOR BOOLEAN DEFAULT FALSE,
	DESLIGAMENTO BOOLEAN DEFAULT FALSE,
	DATADESLIGAMENTO DATE
);

CREATE TABLE DEPARTAMENTOS (
	ID SERIAL PRIMARY KEY,
	NOME VARCHAR NOT NULL,
	CODIGO VARCHAR NOT NULL UNIQUE
);

CREATE TABLE CURSOS_PROFESSORES (
	IDPROFESSOR INTEGER,
	IDCURSO INTEGER,
	PRIMARY KEY (IDPROFESSOR,IDCURSO),
	FOREIGN KEY (IDPROFESSOR) REFERENCES PROFESSORES (ID),	
	FOREIGN KEY (IDCURSO) REFERENCES CURSOS (ID)	
);


INSERT INTO DEPARTAMENTOS (NOME, CODIGO) VALUES
	('Departamento Academico', 'AC'),
	('Departamento de Recursos Humanos', 'RH'),
	('Departamento de Marketing', 'MK'),
	('Departamento Financeiro', 'FN'),
	('Departamento de Logística', 'LG'),
	('Departamento de Tecnologia da Informação', 'TI');


INSERT INTO PROFESSORES 
	(IDDEPARTAMENTO, CODIGO, NOME, DATANASCIMENTO, EMAIL, DATACADASTRO, COORDENADOR)
VALUES
	(1, 'PROF001', 'João Silva', '1985-01-02', 'joaosilva@univale.com.br', '2010-05-20', false),
	(1, 'PROF002', 'Maria Souza', '1978-03-15', 'mariasouza@univale.com.br', '2008-10-16', true), --COORDENADOR ANALISE
	(1, 'PROF003', 'Pedro Rocha', '1990-06-25', 'pedrorocha@univale.com.br', '2015-01-10', false),
	(1, 'PROF004', 'Lucas Rodrigues', '1989-02-12', 'lucasrodrigues@univale.com.br', '2013-09-18', false),
	(1, 'PROF005', 'Mariana Ferreira', '1992-04-20', 'marianaferreira@univale.com.br', '2018-06-05', true), --CORDENADOR ENFERMAGEM
	(1, 'PROF006', 'Rafaela Monteiro', '1988-07-30', 'rafaelamonteiro@univale.com.br', '2014-03-22', false),
	(1, 'PROF007', 'Thiago Lima', '1975-11-08', 'thiagolima@univale.com.br', '2007-01-15', true), -- COORDENADOR ADMINISTRAÇÃO
	(1, 'PROF008', 'Vanessa Santos', '1980-12-28', 'vanessasantos@univale.com.br', '2011-11-11', false);

INSERT INTO CURSOS 
	(CODIGO, NOME, DESCRICAO, CARGAHORARIA, MODALIDADE, NIVEL)
VALUES
	('ADS01', 'Analise e Desenvolvimento de Sistemas', 'Curso de 4 anos para formação em TI', 3200, 'EAD', 'Superior'),
	('ADM01', 'Administração', 'Curso de 4 anos para formação em Administração', 3200, 'Presencial', 'Superior'),
	('ENF01', 'Enfermagem', 'Curso de 3 anos para formação em Enfermagem', 2300, 'Presencial', 'Superior');


INSERT INTO ALUNOS 
	(IDCURSO, RA, NOME, DATACADASTRO, EMAIL, TELEFONE, ENDERECO, INICIOCURSO, CONCLUSAOCURSO, STATUS) 
VALUES
  -- Alunos do curso 1 (Analise Desenvolvimento de Sistemas)
  (1, '000001', 'Lucas Souza', '2023-09-02', 'lucas.souza@univale.com.br', '(11) 99999-1111', 'Rua das Flores, 123, São Paulo', '2023-09-02', NULL, 'C'),
  (1, '000002', 'Mariana Silva', '2023-09-02', 'mariana.silva@univale.com.br', '(21) 99999-2222', 'Avenida das Palmeiras, 456, Rio de Janeiro', '2023-09-02', NULL, 'C'),
  (1, '000003', 'Rodrigo Santos', '2023-09-02', 'rodrigo.santos@univale.com.br', '(31) 99999-3333', 'Rua das Orquídeas, 789, Belo Horizonte', '2023-09-02', NULL, 'C'),
  (1, '000004', 'Fernanda Oliveira', '2023-09-02', 'fernanda.oliveira@univale.com.br', '(51) 99999-4444', 'Rua das Acácias, 321, Porto Alegre', '2023-09-02', NULL, 'C'),
  (1, '000005', 'Jorge Fernandes', '2023-09-02', 'jorge.fernandes@univale.com.br', '(19) 99999-5555', 'Avenida das Laranjeiras, 147, Campinas', '2023-09-02', NULL, 'C'),
  
  -- Alunos do curso 2 (Administração)
  (2, '000006', 'Carla Rodrigues', '2022-08-02', 'carla.rodrigues@univale.com.br', '(71) 99999-6666', 'Rua das Mangueiras, 654, Salvador', '2022-08-02', NULL, 'C'),
  (2, '000007', 'José Santos', '2022-08-02', 'jose.santos@univale.com.br', '(81) 99999-7777', 'Avenida das Orquídeas, 987, Recife', '2022-08-02', NULL, 'C'),
  (2, '000008', 'Gabriel Pereira', '2022-08-02', 'gabriel.pereira@univale.com.br', '(85) 99999-8888', 'Rua das Violetas, 369, Fortaleza', '2022-08-02', NULL, 'C'),
  (2, '000009', 'Ana Oliveira', '2022-08-02', 'ana.oliveira@univale.com.br', '(27) 99999-9999', 'Avenida das Palmeiras, 987, Vitória', '2022-08-02', NULL, 'C'),
  (2, '000010', 'Diego Fernandes', '2022-08-02', 'diego.fernandes@univale.com.br', '(48) 99999-1010', 'Rua das Flores, 369, Florianópolis', '2022-08-02', NULL, 'C'),
  
  -- Alunos do curso 3 (Enfermagem)
  (3, '000011', 'Camila Santos', '2023-09-02', 'camila.santos@univale.com.br', '(61) 99999-1111', 'Avenida das Orquídeas, 123, Brasília', '2023-09-02', NULL, 'C'),
  (3, '000012', 'Luciano Oliveira', '2023-09-02', 'luciano.oliveira@univale.com.br', '(41) 99999-2222', 'Rua das Mangueiras, 456, Curitiba', '2023-09-02', NULL, 'C'),
  (3, '000013', 'Isabela Souza', '2023-09-02', 'isabela.souza@univale.com.br', '(43) 99999-1212', 'Rua das Flores, 789, Joinville', '2023-09-02', NULL, 'C'),
  (3, '000014', 'Lucas Oliveira', '2023-09-02', 'lucas.oliveira@univale.com.br', '(16) 99999-1313', 'Avenida das Laranjeiras, 456, Ribeirão Preto', '2023-09-02', NULL, 'C'),
  (3, '000015', 'Melissa Oliveira', '2023-09-02', 'melissa.oliveira@univale.com.br', '(16) 99992-1411', 'Avenida das Laranjeiras, 456, Ribeirão Preto', '2023-09-02', NULL, 'C');


SELECT * FROM CURSOS_PROFESSORES;
SELECT * FROM CURSOS;
SELECT * FROM PROFESSORES;
SELECT * FROM PROFESSORES WHERE COORDENADOR = TRUE;


-- 1 ADS, 2 ADMIN, 3 ENFERM.
-- COORDENADORES 2,5,7
INSERT INTO CURSOS_PROFESSORES
	(IDPROFESSOR, IDCURSO)
VALUES
	(1,1),
	(2,3),
	(2,2),
	(3,1),
	(4,2),
	(5,1),
	(5,2),
	(5,3),
	(6,2),
	(7,1),
	(7,3),
	(8,3);

SELECT * FROM CURSOS_PROFESSORES;

SELECT 
	PROFESSORES.ID AS ID_PROF,
	PROFESSORES.NOME,
	CURSOS.ID AS ID_CURSO,
	CURSOS.NOME AS CURSO,
	PROFESSORES.COORDENADOR
FROM
	PROFESSORES
INNER JOIN	CURSOS_PROFESSORES
	ON PROFESSORES.ID = CURSOS_PROFESSORES.IDPROFESSOR
INNER JOIN	CURSOS
	ON CURSOS.ID = CURSOS_PROFESSORES.IDCURSO
WHERE PROFESSORES.COORDENADOR = FALSE;
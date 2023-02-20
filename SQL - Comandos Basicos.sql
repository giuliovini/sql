--------------------------------------------------------
--Criando uma BASE DE DADOS;

--Sintaxe:
CREATE DATABASE NOME_BASE;
--Exemplo:
CREATE DATABASE AULASQL2;


--Apagando um BANCO de DADOS
--Sintaxe:
DROP DATABASE NOME_BASE;
--Exemplo:
DROP DATABASE AULASQL2;


--------------------------------------------------------
--Criação e Alteração de uma TABELA;

--Sintaxe:
CREATE TABLE NOME_TABELA ( 
	CAMPO1 TIPO_de_DADO,
	CAMPO2 TIPO_de_DADO,
	CAMPO3 TIPO_de_DADO
	);
--Exemplo criação de TABELA
CREATE TABLE CLIENTE (
	ID SERIAL PRIMARY KEY,
	NOME VARCHAR(150),
	CPF VARCHAR (11),
	CODIGO INTEGER,
	ENDERECO VARCHAR (60),
	EMAIL VARCHAR (60)
);


--Apagando uma TABELA
--Sintaxe:
DROP TABLE NOME_TABELA;
--Exemplo:
DROP TABLE CLIENTE;


--ADICIONANDO uma COLUNA nova em uma TABELA;
--Sintaxe:
ALTER TABLE NOME_TABELA ADD COLUMN NOME_COLUNA TIPO_DE_DADO;
--Exemplo:
ALTER TABLE CLIENTE ADD COLUMN TIPOCLIENTE VARCHAR(8); 
ALTER TABLE CLIENTE ADD COLUMN TIPOSANGUINIO CHAR(2);  


--CHAVE PRIMARIA
--ADICIONANDO uma CHAVE PRIMARIA em uma TABELA que ainda não possui, ou não foi informada em sua criação.
--Sintaxe:
ALTER TABLE NOME_TABELA ADD COLUMN NOME_COLUNA TIPO_DE_DADO PRIMARY KEY;
--Exemplo:
ALTER TABLE CLIENTE ADD COLUMN ID SERIAL NOT NULL PRIMARY KEY;


--APAGANDO uma COLUNA de uma TABELA;
--Sintaxe:
ALTER TABLE NOME_TABELA DROP COLUMN NOME_COLUNA;
--Exemplo:
ALTER TABLE CLIENTE DROP COLUMN TIPOSANGUINIO;


--ALTERANDO um TIPO_DE_DADO de uma COLUNA.
--Sintaxe:
ALTER TABLE NOME_TABELA ALTER COLUMN NOME_COLUNA TYPE TIPO_DE_DADO;
--Exemplo:
ALTER TABLE CLIENTE ALTER COLUMN EMAIL TYPE VARCHAR(50);


--ALTERANDO um CAMPO para tipo UNIQUE 
--Sintaxe:
ALTER TABLE NOME_TABELA ADD CONSTRAINT NOME_DA_CONSTRAINT UNIQUE (CAMPO);
--Exemplo:
ALTER TABLE CLIENTE ADD CONSTRAINT CLIENTE_CPF_UNIQUE UNIQUE (CPF);
ALTER TABLE CLIENTE ADD CONSTRAINT CLIENTE_CODIGO_UNIQUE UNIQUE (CODIGO);

------------------------------------------------------------------------------------------------------------------
--INSERINDO dados em uma TABELA
--Sintaxe:
INSERT INTO NOME_TABELA (COLUNA1,COLUNA2,COLUNA3) VALUES (VALOR1,VALOR2,VALOR3);
--Exemplo:
INSERT INTO CLIENTE (NOME,CPF,CODIGO,ENDERECO,EMAIL,TIPOCLIENTE) VALUES ('Gabriel Barbosa','01141223695',101,'Rua A','gabriel.barbosa@univale.com.br','FISICA');

--INSERINDO varios REGISTROS no mesmo INSERT:
--Exemplo:
INSERT INTO CLIENTE 
	(NOME,CPF,CODIGO,ENDERECO,EMAIL,TIPOCLIENTE) 
VALUES
 ('Valeria Alves','55679929392',102,'Rua C','valeria.alves@univale.com.br','JURIDICA'),
 ('Caio Silva','78202709342',103,'Rua F','caio.silva@univale.com.br','FISICA'),
 ('Maria Dolores','25254008792',104,'Rua A','maria.dolores@univale.com.br','JURIDICA');

--Site para GERAR CPFs e alimentar TABELAS para testes  
--https://ogeradordecpf.com.br

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------ 
--	RECUPERANDO informações de uma TABELA, ou CONSULTANDO informações de uma ou mais TABELAS!
--
--	S E L E C T

--Sintaxe:
SELECT * FROM NOME_TABELA;
--  [ * ] Representa todas as COLUNAS de uma TABELA;

SELECT * FROM CLIENTE;

--Resultado: 
/*
+---+-----------------------+---------------+-------+-----------+-------------------------------------+
| ID|	NOME				|	CPF			|CODIGO	| ENDERECO  |	EMAIL							  |
+---+-----------------------+---------------+-------+-----------+-------------------------------------+
| 1	| "Gabriel Barbosa"		|"01141223695"	|101	|"Rua A"	|"gabriel.barbosa@univale.com.br"	  |
| 3	| "Valeria Alves"		|"55679929392"	|102	|"Rua C"	|"valeria.alves@univale.com.br"       |
| 4	| "Caio Silva"			|"78202709342"	|103	|"Rua F"	|"caio.silva@univale.com.br"          |
| 5	| "Maria Dolores"		|"25254008792"	|104	|"Rua A"	|"maria.dolores@univale.com.br"       |
-------------------------------------------------------------------------------------------------------  */


--Selecionando COLUNAS desejadas apenas:
--Sintaxe:
SELECT COLUNA1,COLUNA2 FROM NOME_TABELA;

SELECT CODIGO,NOME,EMAIL FROM CLIENTE;
--A Ordem das colunas quem define é você.

--CLAUSULA "WHERE" -> Aplica CONDIÇÕES na CONSULTA!
--Expressões Lógicas e Condições de operações
SELECT * FROM CLIENTE WHERE CODIGO = 101; 				--igual
SELECT * FROM CLIENTE WHERE TIPOCLIENTE = 'JURIDICA'; 	--igual
SELECT * FROM CLIENTE WHERE TIPOCLIENTE = 'FISICA'; 	--igual
SELECT * FROM CLIENTE WHERE CODIGO > 101; 				--maior que
SELECT * FROM CLIENTE WHERE CODIGO < 102;				--menor que
SELECT * FROM CLIENTE WHERE CODIGO >= 101;				--maior ou igual
SELECT * FROM CLIENTE WHERE CODIGO <= 103;				--menor ou igual 
SELECT * FROM CLIENTE WHERE CODIGO <> 101; 				--diferente de 



--Expressões Lógicas
--
--AND, retorna somente se as duas condições forem VERDADEIRAS
SELECT * FROM CLIENTE WHERE CODIGO = 101 AND CPF ='01141223695';
SELECT * FROM CLIENTE WHERE ID > 1 AND CODIGO < 105;
--OR, retorna valores somente qualquer uma das condições forem VERDADEIRA
SELECT * FROM CLIENTE WHERE ENDERECO = 'Rua A' OR ENDERECO = 'Rua F';
SELECT * FROM CLIENTE WHERE ENDERECO = 'Rua F' OR CODIGO > 103;


---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-- ATUALIZANDO REGISTROS no Banco de Dados 
-- UPDATE

--Sintaxe:
UPDATE NOME_TABELA SET CAMPO = VALOR WHERE "CONDIÇÕES"
--Exemplo:
UPDATE CLIENTE SET EMAIL = 'maria2023@gmail.com' WHERE ID = 4
UPDATE CLIENTE SET NOME = 'Caio Silva Andrade Ribeiro' WHERE ID = 3

 
--------------------------------------
--------------------------------------
--DELETANDO REGISTROS no Banco de Dados
--DELETE

--Sintaxe:
DELETE FROM NOME_TABELA WHERE CONDIÇÃO
--Exemplo:
DELETE FROM CLIENTE WHERE ID = 4

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
--CONTROLANDO UMA TRANSAÇÃO
BEGIN TRANSACTION
	SELECT * FROM CLIENTE; --Verificando registros antes
	DELETE FROM CLIENTE WHERE ID = 3;   --Deletando um registro
	SELECT * FROM CLIENTE; --Verificando como ficou os registros 
ROLLBACK --Desfaz tudo que foi executado dentro da TRANSAÇÃO
COMMIT --Grava tudo que foi feito dentro da TRANSAÇÃO
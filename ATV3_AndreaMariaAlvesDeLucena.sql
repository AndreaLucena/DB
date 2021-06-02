3ª ATIVIDADE PROJETO BANCO DE DADOS

1) Considerando a DATABASE disponível em https://github.com/DIOGOBRODRIGUES/DBP_3MA2021_1/blob/master/aula5.sql
Desenvolva uma função que insere um novo aluno na tabela “Aluno” e retorne o nome do aluno Inserido.

/*******************************/
DELIMITER %%
CREATE FUNCTION inserir_aluno (codCurso INT, dataNasc DATE, totCred INT, mgp DOUBLE (10, 2), nomeAluno VARCHAR (30), emailAluno VARCHAR (30) RETURNS VARCHAR (30))

DETERMINISTIC
BEGIN
    INSERT INTO aluno (cod_curso, dat_nasc, tot_cred, mgp, nom_alun, email) VALUES (codCurso, dataNasc, totCred, mgp, nomeAluno, emailAluno)
    RETURN nomeAluno;
END %%
DELIMITER; 

SELECT inserir_aluno (3, '1985-07-17', 80, 8.00, 'Andrea Alves', 'kibagana@gmail.com',) AS 'Aluno(a) novo(a)';

2) Desenvolva um procedimento em MYSQL que imprima a sequência de 5 números utilizando a estrutura de repetição WHILE.

/*******************************/
DELIMITER %%
CREATE PROCEDURE proc_while()

BEGIN
DECLARE contador INT DEFAULT 1;
DECLARE str VARCHAR (20) DEFAULT ' ';
    WHILE contador <+ 5 DO
     SET str = CONCAT (str, contador, ',');
     SET contador = contador + 1;
    END WHILE;
    SELECT str;
END %%
DELIMITER; 

CALL proc_while();

3) Faça um procedimento em MYSQL que use a estrutura de repetição REPEAT para concatenar números de 1 a 9 (função concatenar em MySQL “CONCAT”);

/*******************************/
DELIMITER %%
CREATE PROCEDURE proc_repeat()

BEGIN
DECLARE contador INT DEFAULT 1;
DECLARE result VARCHAR (50) DEFAULT ' ';
REPEAT
    SET result = CONCAT (result, contador, ' ');
    SET contador = contador + 1;
    UNTIL contador > 9
END REPEAT;
    SELECT result;
END %%
DELIMITER; 

CALL proc_repeat();



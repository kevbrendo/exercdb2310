create database exercicio1610;

use exercicio1610;

-- Criação da tabela Alunos
CREATE TABLE Alunos (
    AlunoID INT PRIMARY KEY,
    Nome VARCHAR(255),
    DataNascimento DATE,
    Email VARCHAR(255)
);

-- Criação da tabela Cursos
CREATE TABLE Cursos (
    CursoID INT PRIMARY KEY,
    NomeCurso VARCHAR(255),
    Departamento VARCHAR(255)
);

-- Criação da tabela Professores
CREATE TABLE Professores (
    ProfessorID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Especialidade VARCHAR(255)
);

-- Criação da tabela de relacionamento AlunosCursos (N:N)
CREATE TABLE AlunosCursos (
    AlunoID INT,
    CursoID INT,
    PRIMARY KEY (AlunoID, CursoID),
    FOREIGN KEY (AlunoID) REFERENCES Alunos(AlunoID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);

-- Criação da tabela de relacionamento ProfessoresCursos (N:N)
CREATE TABLE ProfessoresCursos (
    ProfessorID INT,
    CursoID INT,
    PRIMARY KEY (ProfessorID, CursoID),
    FOREIGN KEY (ProfessorID) REFERENCES Professores(ProfessorID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);


DELIMITER //

-- Criação da stored procedure para inserir dados de Alunos com geração automática de e-mail
-- Criação da stored procedure para inserir dados de Alunos com geração automática de e-mail único
CREATE PROCEDURE InserirAluno(
    IN p_AlunoID INT,
    IN p_NomeCompleto VARCHAR(255),
    IN p_DataNascimento DATE
)
BEGIN
    DECLARE p_Nome VARCHAR(255);
    DECLARE p_Sobrenome VARCHAR(255);
    DECLARE p_EmailBase VARCHAR(255);
    DECLARE p_Email VARCHAR(255);
    DECLARE i INT;
    
    SET p_Nome = SUBSTRING_INDEX(p_NomeCompleto, ' ', 1); -- Pega o primeiro nome
    SET p_Sobrenome = SUBSTRING(p_NomeCompleto, LENGTH(p_Nome) + 2); -- Pega o sobrenome a partir do espaço
    
    SET p_EmailBase = CONCAT(LOWER(REPLACE(p_Nome, ' ', '.')), '.', LOWER(REPLACE(p_Sobrenome, ' ', '.'));

    -- Inicializa um contador para gerar e-mails únicos
    SET i = 0;

    -- Verifica se o e-mail já existe na tabela
    REPEAT
        SET i = i + 1;
        SET p_Email = IF(i = 1, p_EmailBase, CONCAT(p_EmailBase, i));
    UNTIL NOT EXISTS (SELECT 1 FROM Alunos WHERE Email = p_Email) END REPEAT;

    INSERT INTO Alunos (AlunoID, Nome, DataNascimento, Email)
    VALUES (p_AlunoID, p_NomeCompleto, p_DataNascimento, p_Email);
END //

-- Criação da stored procedure para inserir dados de Cursos
CREATE PROCEDURE InserirCurso(
    IN p_CursoID INT,
    IN p_NomeCurso VARCHAR(255),
    IN p_Departamento VARCHAR(255)
)
BEGIN
    INSERT INTO Cursos (CursoID, NomeCurso, Departamento)
    VALUES (p_CursoID, p_NomeCurso, p_Departamento);
END //

-- Criação da stored procedure para inserir dados de Professores
CREATE PROCEDURE InserirProfessor(
    IN p_ProfessorID INT,
    IN p_Nome VARCHAR(255),
    IN p_Especialidade VARCHAR(255)
)
BEGIN
    INSERT INTO Professores (ProfessorID, Nome, Especialidade)
    VALUES (p_ProfessorID, p_Nome, p_Especialidade);
END //

DELIMITER ;
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

-- Inserindo dados na tabela Alunos
INSERT INTO Alunos (AlunoID, Nome, DataNascimento, Email)
VALUES
    (1, 'Maria Silva', '2000-01-15', 'maria.silva@email.com'),
    (2, 'José Santos', '1999-08-22', 'jose.santos@email.com'),
    (3, 'Ana Rocha', '2001-03-10', 'ana.rocha@email.com'),
    (4, 'Pedro Oliveira', '2002-12-30', 'pedro.oliveira@email.com'),
    (5, 'Luísa Pereira', '2000-07-03', 'luisa.pereira@email.com'),
    (6, 'Miguel Fernandes', '1999-06-17', 'miguel.fernandes@email.com'),
    (7, 'Rita Costa', '2001-04-25', 'rita.costa@email.com'),
    (8, 'Daniel Martins', '1998-11-11', 'daniel.martins@email.com'),
    (9, 'Sofia Alves', '2003-02-08', 'sofia.alves@email.com'),
    (10, 'Tiago Pereira', '2002-09-19', 'tiago.pereira@email.com'),
    (11, 'Catarina Ribeiro', '2000-07-05', 'catarina.ribeiro@email.com'),
    (12, 'Hugo Rodrigues', '1999-12-02', 'hugo.rodrigues@email.com'),
    (13, 'Carolina Silva', '2001-10-14', 'carolina.silva@email.com'),
    (14, 'Gonçalo Santos', '2003-03-27', 'goncalo.santos@email.com'),
    (15, 'Beatriz Oliveira', '1998-05-20', 'beatriz.oliveira@email.com'),
    (16, 'André Pereira', '2001-08-23', 'andre.pereira@email.com'),
    (17, 'Mariana Fernandes', '2000-04-29', 'mariana.fernandes@email.com'),
    (18, 'Nuno Costa', '1999-06-06', 'nuno.costa@email.com'),
    (19, 'Inês Martins', '2002-02-14', 'ines.martins@email.com'),
    (20, 'Gustavo Alves', '2000-11-07', 'gustavo.alves@email.com');

-- Inserindo dados na tabela Cursos
INSERT INTO Cursos (CursoID, NomeCurso, Departamento)
VALUES
    (1, 'Engenharia Elétrica', 'Engenharia'),
    (2, 'Medicina', 'Ciências da Saúde'),
    (3, 'Ciências Políticas', 'Ciências Sociais'),
    (4, 'Arquitetura', 'Artes e Design'),
    (5, 'Economia', 'Negócios'),
    (6, 'Química', 'Ciências Naturais'),
    (7, 'Filosofia', 'Humanidades'),
    (8, 'Psicologia', 'Ciências Comportamentais'),
    (9, 'História da Arte', 'Artes'),
    (10, 'Matemática Aplicada', 'Matemática'),
    (11, 'Engenharia Mecânica', 'Engenharia'),
    (12, 'Jornalismo', 'Comunicação'),
    (13, 'Música', 'Artes'),
    (14, 'Biologia Marinha', 'Ciências Naturais'),
    (15, 'Direito', 'Ciências Jurídicas'),
    (16, 'Administração de Empresas', 'Negócios'),
    (17, 'Linguística', 'Linguística'),
    (18, 'Física', 'Ciências Naturais'),
    (19, 'Engenharia de Software', 'Tecnologia da Informação'),
    (20, 'Inglês', 'Línguas Estrangeiras');

-- Inserindo dados na tabela Professores
INSERT INTO Professores (ProfessorID, Nome, Especialidade)
VALUES
    (1, 'Joana Mendes', 'Matemática'),
    (2, 'António Pereira', 'História'),
    (3, 'Marta Ferreira', 'Física'),
    (4, 'Rui Santos', 'Economia'),
    (5, 'Luísa Alves', 'Inglês'),
    (6, 'Pedro Ribeiro', 'Biologia'),
    (7, 'Carla Costa', 'Química'),
    (8, 'André Fernandes', 'Filosofia'),
    (9, 'Sofia Santos', 'Psicologia'),
    (10, 'Carlos Oliveira', 'Artes'),
    (11, 'José Mendonça', 'Engenharia Elétrica'),
    (12, 'Ana Rodrigues', 'Medicina'),
    (13, 'Gonçalo Silva', 'Ciências Políticas'),
    (14, 'Isabel Pereira', 'Arquitetura'),
    (15, 'Nuno Ribeiro', 'Jornalismo'),
    (16, 'Teresa Almeida', 'Música'),
    (17, 'Daniel Ferreira', 'Direito'),
    (18, 'Helena Costa', 'Administração de Empresas'),
    (19, 'Ricardo Matos', 'Linguística'),
    (20, 'Catarina Ribeiro', 'Engenharia Mecânica');

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

    SET p_EmailBase = CONCAT(LOWER(REPLACE(p_Nome, ' ', '.')), '.', LOWER(REPLACE(p_Sobrenome, ' ', '.')));

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

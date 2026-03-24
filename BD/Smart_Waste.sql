CREATE DATABASE Smart_Waste;
USE Smart_Waste;

-- TABELA: empresa
CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cnpj VARCHAR(20),
    email VARCHAR(100),
    telefone VARCHAR(20)
);

-- TABELA: usuario
CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- TABELA: local
CREATE TABLE local (
    idLocal INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao VARCHAR(150),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- TABELA: lixeira
CREATE TABLE lixeira (
    idLixeira INT PRIMARY KEY AUTO_INCREMENT,
    identificacao VARCHAR(50),
    capacidadeMaxima FLOAT,
    fkLocal INT,
    FOREIGN KEY (fkLocal) REFERENCES local(idLocal)
);

-- TABELA: tipoResiduo
CREATE TABLE tipoResiduo (
    idTipo INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50)
);

-- TABELA: sensor
CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(50),
    status VARCHAR(20),
    fkLixeira INT,
    FOREIGN KEY (fkLixeira) REFERENCES lixeira(idLixeira)
);

-- TABELA: leitura (dados do sensor)
CREATE TABLE leitura (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    volumeAtual FLOAT,
    percentualPreenchido FLOAT,
    dataHora DATETIME,
    fkSensor INT,
    fkTipo INT,
    FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
    FOREIGN KEY (fkTipo) REFERENCES tipoResiduo(idTipo)
);

-- TABELA: alerta
CREATE TABLE alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    nivel VARCHAR(50),
    mensagem VARCHAR(200),
    dataHora DATETIME,
    fkLixeira INT,
    FOREIGN KEY (fkLixeira) REFERENCES lixeira(idLixeira)
);

-- TABELA: contato
CREATE TABLE contato (
    idContato INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100),
    assunto VARCHAR(150),
    mensagem TEXT,
    dataEnvio DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- INSERTS INICIAIS
INSERT INTO tipoResiduo (descricao) VALUES
('A - Infectante'),
('B - Químico'),
('C - Radioativo'),
('D - Comum'),
('E - Perfurocortante');
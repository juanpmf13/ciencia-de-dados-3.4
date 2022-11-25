
-- DROP DATABASE oficina;
CREATE DATABASE oficina;

use oficina;

CREATE TABLE Clients(
	idClient INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    endereço VARCHAR(40) NOT NULL,
    contato VARCHAR(11) NOT NULL
);

CREATE TABLE Mecanico(
	idMecanico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    registro VARCHAR(45),
    endereco VARCHAR(45),
    especialidade VARCHAR(30)
);

CREATE TABLE equipe(
	idEquipe INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30)
);

CREATE TABLE Carro(
	idCarro INT PRIMARY KEY AUTO_INCREMENT,
    idCarroClient INT,
    modelo VARCHAR(20) NOT NULL,
    placa VARCHAR(8),
    chaci VARCHAR(40),
    CONSTRAINT fk_carro_client FOREIGN KEY (idCarroClient) REFERENCES Clients(idClient)
);

CREATE TABLE Pecas(
	idPecas INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30),
    preco FLOAT
);

CREATE TABLE OS(
	idOS INT PRIMARY KEY AUTO_INCREMENT,
    idOSCarro INT NOT NULL,
    idOSEquipe INT NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    dataEntrega DATE,
    valor FLOAT,
    status VARCHAR(45),
    dataEmissao DATE NOT NULL,
    CONSTRAINT fk_OS_carro FOREIGN KEY (idOSCarro) REFERENCES Carro(idCarro),
    CONSTRAINT fk_OS_equipe FOREIGN KEY (idOSEquipe) REFERENCES Equipe(idEquipe)
);

CREATE TABLE equipeMecanico(
	idEMMecanico INT NOT NULL,
    idEMEquipe INT NOT NULL,
    CONSTRAINT fk_em_mecanico FOREIGN KEY (idEMMecanico) REFERENCES Mecanico(idMecanico),
    CONSTRAINT fk_em_equipe FOREIGN KEY (idEMEquipe) REFERENCES Equipe(idEquipe)
);

CREATE TABLE PecaOS(
	idPPecas INT NOT NULL,
    idPOS INT NOT NULL,
    quantidade INT,
    CONSTRAINT pk_pecaos PRIMARY KEY(idPPecas,idPOS),
    CONSTRAINT fk_pecaos_pecas FOREIGN KEY(idPPecas) REFERENCES Pecas(idPecas),
    CONSTRAINT fk_pecaos_os FOREIGN KEY(idPOS) REFERENCES OS(idOS)
    );
    
CREATE TABLE Servico(
	idServico INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255),
    autorizacao BOOLEAN DEFAULT FALSE,
    avaliacao VARCHAR(45)
);

CREATE TABLE OsServico(
	idOsSOS INT,
    idOsServico INT,
    CONSTRAINT fk_osservico_os FOREIGN KEY(idOsSOS) REFERENCES OS(idOS),
    CONSTRAINT fk_osservico_servico FOREIGN KEY(idOsServico) REFERENCES Servico(idServico)
);

CREATE TABLE Avalicao(
	idAvalicao INT PRIMARY KEY,
    idAvaliacaoEquipe INT,
    idAvaliacaoServico INT,
    descricao VARCHAR(255),
    CONSTRAINT fk_avaliacao_equipe FOREIGN KEY(idAvaliacaoEquipe) REFERENCES Equipe(idEquipe),
    CONSTRAINT fk_avaliacao_servico FOREIGN KEY(idAvaliacaoServico) REFERENCES Servico(idServico)
);
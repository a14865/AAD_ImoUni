CREATE TABLE Distrito(
	id_distrito INT IDENTITY(1,1) PRIMARY KEY,
	distrito VARCHAR(30)
);

CREATE TABLE Concelho(
	id_concelho INT IDENTITY(1,1) PRIMARY KEY,
	concelho VARCHAR(30) NOT NULL,
	id_distrito INT NOT NULL,
	FOREIGN KEY (id_distrito) REFERENCES Distrito(id_distrito)
);

CREATE TABLE CodigoPostal(
	id_codigopostal INT IDENTITY(1,1) PRIMARY KEY,
	codigopostal VARCHAR(8) NOT NULL,
	id_concelho INT NOT NULL,
	FOREIGN KEY (id_concelho) REFERENCES Concelho(id_concelho)
);

CREATE TABLE Estado(
	id_estado INT IDENTITY(1,1) PRIMARY KEY,
	descricaoestado VARCHAR(30) NOT NULL
);

CREATE TABLE TipoImovel(
	id_tipoimovel INT IDENTITY(1,1) PRIMARY KEY,
	descricaotipo VARCHAR(30) NOT NULL
);

CREATE TABLE Modalidade(
	id_modalidade INT IDENTITY(1,1) PRIMARY KEY,
	descricaomodalidade VARCHAR(30) NOT NULL
);

CREATE TABLE Agente(
	id_agente INT IDENTITY(1,1) PRIMARY KEY,
	nomeagente VARCHAR(255) NOT NULL,
	telefone VARCHAR(16) NOT NULL,
	nifagente VARCHAR(9),
	percentagemcomissao FLOAT NOT NULL
);

CREATE TABLE Cliente(
	id_cliente INT IDENTITY(1,1)PRIMARY KEY,
	nomecliente VARCHAR(255) NOT NULL,
	moradacliente VARCHAR(255) NOT NULL,
	id_codigopostal INT NOT NULL,
	nifcliente VARCHAR(9) NOT NULL,
	telefone VARCHAR(16) NOT NULL,
	email VARCHAR(50),
	FOREIGN KEY (id_codigopostal) REFERENCES CodigoPostal(id_codigopostal)
);

CREATE TABLE CatalogoImovel(
	id_imovel INT IDENTITY(1,1) PRIMARY KEY,
	id_tipoimovel INT NOT NULL,
	morada VARCHAR(255) NOT NULL,
	id_codigopostal INT NOT NULL,
	nquartos INT NOT NULL,
	area INT NOT NULL,
	nwc INT NOT NULL,
	garagem BIT NOT NULL,
	piscina BIT NOT NULL,
	id_estado INT NOT NULL,
	id_modalidade INT NOT NULL,
	matriz VARCHAR(20) NOT NULL,
	valor DECIMAL(10,2) NOT NULL,-- Maximo 7 digitos, Minimo 2 digitos
	datacarteira DATE NOT NULL,
	id_agente INT NOT NULL,
	id_proprietario INT NOT NULL,
	latitude DECIMAL(9,6) NOT NULL,
	longitude DECIMAL(9,6) NOT NULL,
	Ativo BIT NOT NULL,
	FOREIGN KEY (id_tipoimovel) REFERENCES TipoImovel(id_tipoimovel),
	FOREIGN KEY (id_codigopostal) REFERENCES CodigoPostal(id_codigopostal),
	FOREIGN KEY (id_estado) REFERENCES Estado(id_estado),
	FOREIGN KEY (id_modalidade) REFERENCES Modalidade(id_modalidade),
	FOREIGN KEY (id_agente) REFERENCES Agente(id_agente),
	FOREIGN KEY (id_proprietario) REFERENCES Cliente(id_cliente)
);

CREATE TABLE TipoDocumento(
	id_documento INT IDENTITY(1,1)PRIMARY KEY,
	tipodocumento VARCHAR(50) NOT NULL
);

CREATE TABLE TipoTransacao(
	id_tipotransacao INT IDENTITY(1,1) PRIMARY KEY,
	tipotransacao VARCHAR(50) NOT NULL
);

CREATE TABLE MetodoPagamento(
	id_metodopagamento INT IDENTITY(1,1)PRIMARY KEY,
	metodopagamento VARCHAR(50) NOT NULL
);

CREATE TABLE Transacao(
	id_transacao INT IDENTITY(1,1) PRIMARY KEY,
	id_imovel INT NOT NULL,
	id_ativo INT NOT NULL,
	id_passivo INT NOT NULL,
	id_agente INT NOT NULL,
	id_tipotransacao INT NOT NULL,
	duracao INT,
	valor DECIMAL (10,2) NOT NULL,
	datatransacao DATE NOT NULL,
	datacontrato DATE NOT NULL,
	FOREIGN KEY (id_imovel) REFERENCES CatalogoImovel(id_imovel),
	FOREIGN KEY (id_ativo) REFERENCES Cliente(id_cliente),
	FOREIGN KEY (id_passivo) REFERENCES Cliente(id_cliente),
	FOREIGN KEY (id_agente) REFERENCES Agente(id_agente),
	FOREIGN KEY (id_tipotransacao) REFERENCES TipoTransacao(id_tipotransacao)
);

CREATE TABLE PagamentoComissao(
	id_pagamentocomissao INT IDENTITY(1,1) PRIMARY KEY,
	datapagamentocomissao DATE NOT NULL,
	valor DECIMAL(7,3) NOT NULL,
	id_metodopagamento INT NOT NULL,
	id_transacao INT NOT NULL,
	FOREIGN KEY (id_metodopagamento) REFERENCES MetodoPagamento(id_metodopagamento),
	FOREIGN KEY (id_transacao) REFERENCES Transacao(id_transacao)
);

CREATE TABLE Documentos(
	id_transacao INT,
	id_documento INT,
	datarececao DATE NOT NULL,
	validade DATE NOT NULL,
	PRIMARY KEY (id_transacao, id_documento),
	FOREIGN KEY (id_transacao) REFERENCES Transacao(id_transacao),
	FOREIGN KEY (id_documento) REFERENCES TipoDocumento(id_documento)
);

CREATE TABLE Preferencias(
	id_preferencia INT IDENTITY(1,1) PRIMARY KEY,
	id_cliente INT,
	id_agente INT,
	nquartos INT NOT NULL,
	nwc INT NOT NULL,
	area INT,
	garagem BIT NOT NULL,
	piscina BIT NOT NULL,
	id_modalidade INT,
	valor_minimo DECIMAL (10,2),
	valor_maximo DECIMAL (10,2),
	id_concelho INT,
	FOREIGN KEY (id_modalidade) REFERENCES Modalidade(id_modalidade),
	FOREIGN KEY (id_concelho) REFERENCES Concelho(id_concelho),
	FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
	FOREIGN KEY (id_agente) REFERENCES Agente(id_agente)
);

CREATE TABLE EstadoProposta(
	id_estadoproposta INT IDENTITY(1,1) PRIMARY KEY,
	descricaoestado VARCHAR(30) NOT NULL
);

CREATE TABLE Proposta(
	id_proposta INT IDENTITY(1,1) PRIMARY KEY,
	valorproposta DECIMAL(10,2) NOT NULL,
	dataproposta DATE NOT NULL,
	id_cliente INT NOT NULL,
	id_imovel INT NOT NULL,
	id_agente INT NOT NULL,
	id_estadoproposta INT NOT NULL,
	observacoes VARCHAR(255),
	FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
	FOREIGN KEY (id_imovel) REFERENCES CatalogoImovel(id_imovel),
	FOREIGN KEY (id_agente) REFERENCES Agente(id_agente),
	FOREIGN KEY (id_estadoproposta) REFERENCES EstadoProposta(id_estadoproposta)
);

ALTER TABLE Transacao
ADD id_proposta INT;

ALTER TABLE Transacao
ADD FOREIGN KEY (id_proposta) REFERENCES Proposta(id_proposta);
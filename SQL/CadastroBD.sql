CREATE TABLE[pessoa](
    idPessoa INT (1,1) PRIMARY KEY,
    nome VARCHAR(255) ,
    logradouro VARCHAR(255),
    cidade VARCHAR(255),
    estado CHAR(2),
    telefone VARCHAR(11),
    email VARCHAR(255),   
);

CREATE TABLE [pessoa_fisica](
    idPessoaFisica INT (1,1) PRIMARY KEY,
    cpf VARCHAR(11),
    FOREIGN KEY(IdPessoaFisica) REFERENCES Pessoa(idPessoa)
);

CREATE TABLE [pessoa_juridica](
    idPessoaJuridica INT (1,1) PRIMARY KEY,
    FOREIGN KEY (idPessoaJuridica) REFERENCES Pessoa(idPessoa)   
); 

CREATE TABLE[produto](
    idProduto INT (1,1) PRIMARY KEY,
    nome VARCHAR(255),
    quantidade INT,
    precoVenda NUMERIC,    
);

CREATE TABLE[usuario](
    idOperador INT (1,1) PRIMARY KEY,
    nome VARCHAR(25),
    senha VARCHAR(25),
);    

CREATE TABLE[MovimentoCompra](
    idMovimentoCopmpra INT (1,1) PRIMARY KEY,
    precoUnitario NUMERIC,
    quantidade INT,
    idOperador INT,
    idFornecedor INT,
    idProduto INT,
    FOREIGN KEY (idOperador) REFERENCES Usuario(idOperador),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idFornecedor) REFERENCES PessoaJuridica(idPessoaJuridica), 
);

CREATE TABLE MovimentoVenda(
    quantidade INT,
    precoUnitario NUMERIC,
    idMovimentoVenda INT PRIMARY KEY, 
    idProduto INT,
    idComprador INT,
    idOperador INT,
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idComprador) REFERENCES PessoaFisica(idPessoaFisica),
    FOREIGN KEY (idOperador) REFERENCES Usuario(idOperador),
);

CREATE SEQUENCE IdSequencePessoa
    START WITH 1
    INCREMENT BY 1;




INSERT INTO Usuario(idOperador, nome, senha) VALUES (1, "op1","op1");
INSERT INTO Usuario(idOperador, nome, senha) VALUES (2, "op2","op2");

INSERT INTO Produto(idProduto, nome, quantidade, precoVenda) VALUES (1,"Banana",100, 5.00);
INSERT INTO Produto(idProduto, nome, quantidade, precoVenda) VALUES (2,"Laranja",500, 2.00);
INSERT INTO Produto(idProduto, nome, quantidade, precoVenda) VALUES (3,"Manga",800, 4.00);

INSERT INTO Pessoa(idPessoa, nome, logradouro, cidade, estado, telefone, email) VALUES (7,"Joao","Rua 12, casa3, Quitanda","Riacho do Sul", "PA","1111-1111","email@example.com");
INSERT INTO PessoaFisica (idPessoaFisica, cpf) VALUES (7,"11111111111");

INSERT INTO Pessoa (idPessoa, nome, logradouro, cidade, estado, telefone, email) VALUES (15,"JJC","Rua 11, Centro","Riacho do Norte", "PA", "2222-2222", "email@example.com");
INSERT INTO PessoaJuridica (idPessoaJuridica, cnpj) VALUES (15, "222222222222");


INSERT INTO MovimentoVenda (idMovimentoVenda, idProduto, idComprador, idOperador, quantidade, precoUnitario) VALUES (1, 1, 7, 1, 20, 4.00);
INSERT INTO MovimentoVenda (idMovimentoVenda, idProduto, idComprador, idOperador, quantidade, precoUnitario) VALUES (4, 1, 7, 1, 15, 2.00);
INSERT INTO MovimentoVenda (idMovimentoVenda, idProduto, idComprador, idOperador, quantidade, precoUnitario) VALUES (5, 1, 7, 2, 10, 3.00);



INSERT INTO MovimentoCompra(idMovimentoCompra, idProduto, idFornecedor, idOperador, quantidade, precoUnitario) VALUES(7, 1, 15, 1, 15, 5.00);
INSERT INTO MovimentoCompra(idMovimentoCompra, idProduto, idFornecedor, idOperador, quantidade, precoUnitario) VALUES(8, 1, 15, 1, 20, 4.00);



SELECT * FROM Pessoa INNER JOIN PessoaFisica ON Pessoa.idPessoa = PessoaFisica.idPessoaFisica;
SELECT * FROM Pessoa INNER JOIN PessoaJuridica ON Pessoa.idPessoa = PessoaJuridica.idPessoaJuridica;
SELECT idProduto, SUM(quantidade*precoUnitario) AS TotalEntradas FROM MovimentoCompra GROUP BY idProduto;
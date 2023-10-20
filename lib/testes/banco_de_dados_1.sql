CREATE TABLE depto_localizacoes (
    dnumero INTEGER NOT NULL,
    dlocal VARCHAR(255) NOT NULL,
    PRIMARY KEY (dlocal),
    FOREIGN KEY (dnumero) REFERENCES departamento(dnumero)
);

CREATE TABLE departamento (
    dnumero INTEGER NOT NULL,
    dnome VARCHAR(255) NOT NULL,
    cpf_gerente VARCHAR(11) NOT NULL,
    data_inicio_gerente DATE,
    PRIMARY KEY (dnumero),
    FOREIGN KEY (cpf_gerente) REFERENCES funcionario(cpf)
);

CREATE TABLE dependente (
    fcpf VARCHAR(11) NOT NULL,
    nome_dependente VARCHAR(255) NOT NULL,
    sexo CHAR(1),
    datanasc DATE,
    parentesco VARCHAR(255),
    PRIMARY KEY (nome_dependente),
    FOREIGN KEY (fcpf) REFERENCES funcionario(cpf)
);

CREATE TABLE funcionario (
    cpf VARCHAR(11) NOT NULL,
    pnome VARCHAR(255) NOT NULL,
    minicial CHAR(1),
    unome VARCHAR(255),
    datanasc DATE,
    endereco VARCHAR(255),
    sexo CHAR(1),
    salario DECIMAL(10, 2) NOT NULL,
    cpf_supervisor VARCHAR(11),
    dnr INTEGER NOT NULL,
    PRIMARY KEY (cpf),
    FOREIGN KEY (cpf_supervisor) REFERENCES funcionario(cpf),
    FOREIGN KEY (dnr) REFERENCES departamento(dnumero)
);

CREATE TABLE projeto (
    projnumero INTEGER NOT NULL,
    projnome VARCHAR(255),
    projlocal VARCHAR(255),
    dnum INTEGER NOT NULL,
    PRIMARY KEY (projnumero),
    FOREIGN KEY (dnum) REFERENCES departamento(dnumero)
);

CREATE TABLE trabalha_em (
    kfcpf VARCHAR(11) NOT NULL,
    pnr INTEGER NOT NULL,
    horas DOUBLE,
    PRIMARY KEY (kfcpf, pnr),
    FOREIGN KEY (kfcpf) REFERENCES funcionario(cpf),
    FOREIGN KEY (pnr) REFERENCES projeto(projnumero)
);


-- INSERTS

INSERT INTO departamento VALUES (1, 'Pesquisa', '12345678901', '1995-01-01');
INSERT INTO departamento VALUES (2, 'Desenvolvimento', '12345678902', '1995-02-01');
INSERT INTO departamento VALUES (3, 'Vendas', '12345678903', '1995-03-01');

INSERT INTO funcionario VALUES ('12345678901', 'Franklin', 'T', 'Wong', '1955-12-08', '638 Voss', 'M', 40000.00, NULL, 5);
INSERT INTO funcionario VALUES ('12345678902', 'Joyce', 'A', 'English', '1962-07-31', '5631 Rice, Houston, TX', 'F', 25000.00, '12345678901', 5);
INSERT INTO funcionario VALUES ('12345678903', 'Ramesh', 'K', 'Narayan', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000.00, '12345678901', 5);
INSERT INTO funcionario VALUES ('99999999999', 'Luis', 'T', 'Silva', '1955-12-08', '638 Voss', 'M', 4000.00, 06005678901, 5);


INSERT INTO projeto VALUES (1, 'Projeto 1', 'Bellaire', 1);
INSERT INTO projeto VALUES (2, 'Projeto 2', 'Sugarland', 2);
INSERT INTO projeto VALUES (3, 'Projeto 3', 'Houston', 3);


INSERT INTO trabalha_em VALUES ('12345678901', 1, 32.5);
INSERT INTO trabalha_em VALUES ('12345678902', 1, 7.5);
INSERT INTO trabalha_em VALUES ('12345678902', 2, 10.0);

INSERT INTO dependente VALUES ('12345678901', 'Alice', 'F', '1986-04-05', 'Filha');
INSERT INTO dependente VALUES ('12345678901', 'Theodore', 'M', '1983-10-25', 'Filho');
INSERT INTO dependente VALUES ('12345678903', 'Joy', 'F', '1958-05-03', 'Cônjuge');

INSERT INTO depto_localizacoes VALUES (1, 'Houston');
INSERT INTO depto_localizacoes VALUES (2, 'Stafford');
INSERT INTO depto_localizacoes VALUES (3, 'Bellaire');


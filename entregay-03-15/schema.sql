DROP TABLE evento_reposicao;
DROP TABLE responsavel_por;
DROP TABLE retalhista;
DROP TABLE planograma;
DROP TABLE prateleira;
DROP TABLE instalada_em;
DROP TABLE ponto_de_retalho;
DROP TABLE IVM;
DROP TABLE tem_categoria;
DROP TABLE produto;
DROP TABLE tem_outra;
DROP TABLE super_categoria;
DROP TABLE categoria_simples;
DROP TABLE categoria;

CREATE TABLE categoria(
    nome VARCHAR(30) NOT NULL,
    PRIMARY KEY (nome)
    -- O valor do atributo nome de qualquer registo da relação categoria tem de existir em na
    -- relação categoria_simples ou na relação super_categoria
);

CREATE TABLE categoria_simples(
    nome VARCHAR(30) NOT NULL,
    PRIMARY KEY(nome),
    FOREIGN KEY(nome) REFERENCES categoria(nome)
    -- O valor do aributo nome de qualquer registo de categoria_simples não pode existir em
    -- super_categoria
);

CREATE TABLE super_categoria(
    nome VARCHAR(30) NOT NULL,
    PRIMARY KEY(nome),
    FOREIGN KEY(nome) REFERENCES categoria(nome)
    -- O valor do atributo nome de qualquer registo tem de existir no atributo
    -- super_categoria da relação constituída
);

CREATE TABLE tem_outra(
    super_categoria VARCHAR(30) NOT NULL,
    categoria VARCHAR(30) NOT NULL,
    PRIMARY KEY(categoria),
    FOREIGN KEY(super_categoria) REFERENCES super_categoria(nome),
    FOREIGN KEY(categoria) REFERENCES categoria(nome),
    CHECK(super_categoria != categoria)
    -- não podem existir valores repetidos dos atributos super_categoria e categoria numa
    -- sequência de registos relacionados pela FK categoria

    -- Para qualquer registo desta relação, verifica-se que os atributos super_categoria e
    -- categoria são distintos.
);

CREATE TABLE produto(
    ean NUMERIC(13) NOT NULL,
    descr TEXT NOT NULL,
    cat VARCHAR(30) NOT NULL,
    PRIMARY KEY(ean),
    FOREIGN KEY(cat) REFERENCES categoria(nome),
    CHECK(ean > 0)
    -- O valor do atributo ean existente em qualquer registo da relação produto tem de existir
    -- também no atributo ean da relação tem_categoria
);

CREATE TABLE tem_categoria(
    ean NUMERIC(13) NOT NULL,
    nome VARCHAR(30) NOT NULL,
    FOREIGN KEY(ean) REFERENCES produto(ean),
    FOREIGN KEY(nome) REFERENCES categoria(nome)
);


CREATE TABLE IVM(
    num_serie INTEGER NOT NULL,
    fabricante VARCHAR(30) NOT NULL,
    PRIMARY KEY (num_serie,fabricante)
);

CREATE TABLE ponto_de_retalho(
    nome VARCHAR(30) NOT NULL,
    distrito VARCHAR(30) NOT NULL,
    concelho VARCHAR(30) NOT NULL,
    PRIMARY KEY (nome)
);


CREATE TABLE instalada_em(
    num_serie INTEGER NOT NULL,
    fabricante VARCHAR(30) NOT NULL,
    local VARCHAR(30) NOT NULL,
    PRIMARY KEY(num_serie,fabricante),
    FOREIGN KEY(num_serie, fabricante) REFERENCES IVM(num_serie,fabricante),
    FOREIGN KEY(local) REFERENCES ponto_de_retalho(nome)
);


CREATE TABLE prateleira(
    nro INTEGER NOT NULL,
    num_serie INTEGER NOT NULL,
    fabricante VARCHAR(30) NOT NULL,
    altura VARCHAR(6) NOT NULL,
    nome VARCHAR(30) NOT NULL,
    PRIMARY KEY(nro,num_serie,fabricante),
    FOREIGN KEY(num_serie,fabricante) REFERENCES IVM(num_serie,fabricante),
    FOREIGN KEY(nome) REFERENCES categoria(nome)
);


CREATE TABLE planograma(
    ean NUMERIC(13) NOT NULL,
    nro INTEGER NOT NULL,
    num_serie INTEGER NOT NULL,
    fabricante VARCHAR(30) NOT NULL,
    faces INTEGER NOT NULL,
    unidades INTEGER NOT NULL,
    loc INTEGER NOT NULL,
    PRIMARY KEY(ean,nro,num_serie,fabricante),
    FOREIGN KEY (ean) REFERENCES produto(ean),
    FOREIGN KEY (nro,num_serie,fabricante) REFERENCES prateleira(nro,num_serie,fabricante),
    CHECK (faces >= 0),
    CHECK (loc >= 0)
);

CREATE TABLE retalhista(
    tin INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
	PRIMARY KEY (tin),
    UNIQUE (name)
);

CREATE TABLE responsavel_por(
    nome_cat VARCHAR(30) NOT NULL,
    tin INTEGER NOT NULL,
    num_serie INTEGER NOT NULL,
    fabricante VARCHAR(30) NOT NULL,
    PRIMARY KEY(num_serie,fabricante),
    FOREIGN KEY(num_serie,fabricante) REFERENCES IVM(num_serie,fabricante),
    FOREIGN KEY(tin) REFERENCES retalhista(tin),
    FOREIGN KEY(nome_cat) REFERENCES categoria(nome)
);

CREATE TABLE evento_reposicao(
    ean NUMERIC(13) NOT NULL,
    nro INTEGER NOT NULL,
    num_serie INTEGER NOT NULL,
    fabricante VARCHAR(30) NOT NULL,
    instante TIMESTAMP NOT NULL,
    unidades INTEGER NOT NULL,
    tin INTEGER NOT NULL,
    PRIMARY KEY(ean, nro, num_serie,fabricante,instante),
    FOREIGN KEY(ean,nro,num_serie,fabricante) REFERENCES planograma(ean,nro,num_serie,fabricante),
    FOREIGN KEY(tin) REFERENCES retalhista(tin)
    -- o valor do atributo unidades de um registo X desta relação não pode exceder o valor do
    -- atributo unidades do registo da relação planograma referido pelo registo X
);
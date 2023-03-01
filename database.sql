
-- /* CRIAR DATABASE*/
DROP DATABASE IF EXISTS montadora_db;
CREATE DATABASE IF NOT EXISTS  montadora_db;

USE montadora_db;

-- /* CRIAR AS TABELAS*/

DROP TABLE IF EXISTS tb_versao;
CREATE TABLE tb_versao (
	cod_versao varchar(5),
	nome_versao varchar(12),
    PRIMARY KEY (cod_versao)
    );
    
    INSERT INTO tb_versao VALUES 
		('ZN394','ZEN'),
		('LF958','LIFE'),
        ('OT462','OUTSIDER'),
        ('IT461','INTENSE')
        ;
        
DROP TABLE IF EXISTS tb_planta;
CREATE TABLE tb_planta (
	cod_planta varchar(10),
	nome_planta varchar(15),
    PRIMARY KEY (cod_planta)
    );
    
INSERT INTO tb_planta VALUES
		('CUR77','CURITIBA'),
        ('COR66','CORDOBA'),
        ('SOF58','SOFASA')
        ;

DROP TABLE IF EXISTS tb_concessionaria;
CREATE TABLE tb_concessionaria (
	cod_concessionaria int,
	cidade_concessionaria varchar(30),
	estado_concessionaria varchar(2),
	nome_concessionaria varchar(50),
    PRIMARY KEY (cod_concessionaria)
    );

INSERT INTO tb_concessionaria VALUES
	(5,'CASCAVEL','PR','OPEN VEICULOS CASCAVEL'),
	(4,'BELO HORIZONTE','MG','MINAS FRANCE SAVASSI'),
    (1,'CURITIBA','PR','GLOBO VEICULOS VILA ISABEL'),
    (2,'SAO JOSE DOS PINHAIS','PR','GLOBO VEICULOS SAO JOSE DOS PINHAIS'),
    (3,'RIO DE JANEIRO','RJ','LEAUTO BOTAFOGO')
    ;
    

DROP TABLE IF EXISTS tb_comprador;
CREATE TABLE tb_comprador (
	cod_comprador int,
	nome_comprador varchar(30),
	sobrenome_comprador varchar(30),
    PRIMARY KEY (cod_comprador)
    );
    
    INSERT INTO tb_comprador VALUES
		(95321, 'GUILHERME','MARQUES'),
        (39039, 'MARIA','BEZERRA'),
        (89880, 'DIENIFER','BODELON'),
        (98081, 'PLINIO','SILVESTRE'),
        (96291, 'JOAO','CARVALHO'),
		(23483, 'PEDRO','OLIVEIRA'),
        (89269, 'JULIA','MEIRELIS'),
        (29941, 'DALILA','MARQUETTE'),
        (45813, 'ELOIR','VEIGA'),
        (94073, 'LUCAS','JAKUBIAK')
        ;
		
DROP TABLE IF EXISTS tb_problema;
CREATE TABLE tb_problema (
	cod_problema int,
	descr_problema varchar(100),
    PRIMARY KEY (cod_problema)
    );

INSERT INTO tb_problema VALUES
	(314,'MOTOR:RUIDO'),
    (315,'MOTOR:CONSUMO EXCESSIVO DE COMBUSTIVEL'),
    (316,'AR CONDICIONADO:FALTA EFICACIA'),
    (317,'BANCO:ASSENTO MOTORISTA DESCONFORTAVEL'),
    (318,'NAVEGACAO: MULTIMIDIA DIFICIL DE ENTENDER'),
    (319,'NAVEGACAO: MULTIMIDIA TRAVA/CONGELA'),
    (320,'PORTA MALAS: RUIDO'),
    (321,'AR CONDICIONADO: FUNCIONAMENTO INTERMITENTE'),
    (322,'CARROCERIA: RUIDO PORTA LATERAL')
    ;

DROP TABLE IF EXISTS tb_solucao;
CREATE TABLE tb_solucao (
	cod_solucao varchar(30),
    descr_solucao varchar(100),
    PRIMARY KEY (cod_solucao)
    );

INSERT INTO tb_solucao VALUES
	('QC0009250','TROCA DE COMPRESSOR AR CONDICIONADO'),
    ('QC0005631','ESPUMA EXTRA PORTAS LATERAIS'),
    ('QC0007833','COLUNA REFORCO LADO MOTORISTA'),
    ('QX0000000','SEM SOLUCAO')
    ;
    
DROP TABLE IF EXISTS tb_telefone;
CREATE TABLE tb_telefone (
cod_comprador int,
telefone_comprador varchar(12),
PRIMARY KEY (cod_comprador),
FOREIGN KEY (cod_comprador) REFERENCES tb_comprador(cod_comprador)
);

INSERT INTO tb_telefone VALUES 
		(95321,'90997-4114'),
        (39039,'99506-1505'),
        (89880,'96357-3263'),
        (98081,'92706-6653'),
        (96291,'92976-5049'),
		(23483,'90555-5248'),
        (89269,'95212-1284'),
        (29941,'93039-2337'),
        (45813,'97892-9137'),
        (94073,'93383-5743')
        ;


DROP TABLE IF EXISTS tb_modelo;
CREATE TABLE tb_modelo (
cod_modelo varchar(3),
nome_modelo varchar(15),
cod_versao varchar(15),
PRIMARY KEY (cod_modelo,cod_versao),
FOREIGN KEY (cod_versao) REFERENCES tb_versao(cod_versao)
);


INSERT INTO tb_modelo VALUES 
	('B99','SANDERO','ZN394'),
    ('L99','LOGAN','ZN394'),
    ('L99','LOGAN','LF958'),
    ('KKK','KWID','ZN394'),
    ('KKK','KWID','OT462'),
    ('KKK','KWID','IT461'),
    ('HDU','DUSTER','ZN394'),
	('HDU','DUSTER','IT461')
    ;
    
DROP TABLE IF EXISTS tb_modelo_comprador;
CREATE TABLE tb_modelo_comprador (
cod_comprador int,
cod_modelo varchar(3),
PRIMARY KEY (cod_modelo, cod_comprador),
FOREIGN KEY (cod_modelo) REFERENCES tb_modelo(cod_modelo),
FOREIGN KEY (cod_comprador) REFERENCES tb_comprador(cod_comprador)
);

INSERT INTO tb_modelo_comprador VALUES
		(95321,'HDU'),
		(39039,'KKK'),
		(89880,'KKK'),
        (98081,'L99'),
        (96291,'B99'),
		(23483,'B99'),
        (89269,'KKK'),
        (29941,'KKK'),
        (45813,'HDU'),
        (94073,'L99')
        ;

DROP TABLE IF EXISTS tb_problema_solucao;
CREATE TABLE tb_problema_solucao (
cod_solucao varchar(30),
cod_problema int,
PRIMARY KEY (cod_solucao, cod_problema),
FOREIGN KEY (cod_solucao) REFERENCES tb_solucao(cod_solucao),
FOREIGN KEY (cod_problema) REFERENCES tb_problema(cod_problema)
);

INSERT INTO tb_problema_solucao VALUES
	('QC0009250',316),
    ('QC0009250',321),
    ('QX0000000',314),
    ('QX0000000',315),
	('QC0005631','322'),
    ('QC0007833','322')
    ;
DROP TABLE IF EXISTS tb_veiculo;
CREATE TABLE tb_veiculo (
cod_chassi varchar(30),
quilometros_rodados int,
data_fabricacao date,
data_compra date,
cod_comprador int,
cod_modelo varchar(3),
cod_versao varchar(5),
cod_planta varchar(10),
cod_concessionaria int,
PRIMARY KEY (cod_chassi),
FOREIGN KEY (cod_comprador) REFERENCES tb_comprador(cod_comprador),
FOREIGN KEY (cod_modelo) REFERENCES tb_modelo(cod_modelo),
FOREIGN KEY (cod_versao) REFERENCES tb_versao(cod_versao),
FOREIGN KEY (cod_planta) REFERENCES tb_planta(cod_planta),
FOREIGN KEY (cod_concessionaria) REFERENCES tb_concessionaria(cod_concessionaria)
);

INSERT INTO tb_veiculo VALUES
('1HGCM56897A153798',500,'2019-05-21','2020-03-23',95321,'HDU','IT461','SOF58',3),
('5TDBK3EH4DS188897',300,'2019-10-01','2020-04-06',39039,'KKK','IT461','CUR77',5),
('1YVHP81H695M28957',450,'2019-10-21','2020-07-10',89880,'KKK','IT461','SOF58',1),
('KNDUP131326318928',120,'2019-04-24','2020-07-14',98081,'L99','LF958','COR66',5),
('1HGCR2F78EA249331',287,'2019-10-28','2020-08-14',96291,'B99','ZN394','CUR77',2),
('2GNALBEK3C6196522',432,'2019-12-24','2020-09-04',23483,'B99','ZN394','COR66',3),
('2HGFA1F5XAH585636',400,'2019-04-24','2020-09-09',89269,'KKK','ZN394','CUR77',4),
('2GNALBEC6B1249850',620,'2019-06-27','2020-09-10',29941,'KKK','OT462','SOF58',1),
('KNDJF724077331674',1200,'2019-09-25','2020-10-28',45813,'HDU','ZN394','CUR77',5),
('1C4NJPBA6ED609885',822,'2019-09-12','2020-12-02',94073,'L99','LF958','COR66',2)
;

DROP TABLE IF EXISTS tb_problema_veiculo;
CREATE TABLE tb_problema_veiculo (
cod_chassi varchar(30),
cod_comprador int,
cod_problema int,
PRIMARY KEY (cod_chassi, cod_comprador),
FOREIGN KEY (cod_comprador) REFERENCES tb_comprador(cod_comprador),
FOREIGN KEY (cod_problema) REFERENCES tb_problema(cod_problema),
FOREIGN KEY (cod_chassi) REFERENCES tb_veiculo(cod_chassi)
);

--  YEAR - MONTH DAY = 00 00 00

INSERT INTO tb_problema_veiculo VALUES
('1HGCM56897A153798',95321,314),
('5TDBK3EH4DS188897',39039,320),
('1YVHP81H695M28957',89880,315),
('KNDUP131326318928',98081,320),
('1HGCR2F78EA249331',96291,NULL),
('2GNALBEK3C6196522',23483,314),
('2HGFA1F5XAH585636',89269,318),
('2GNALBEC6B1249850',29941,314),
('KNDJF724077331674',45813,322),
('1C4NJPBA6ED609885',94073,319)
;
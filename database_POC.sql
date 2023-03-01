-- projeto jonas

-- Primeiro select
-- Problema mais frequente

SELECT 
    tb_problema_veiculo.cod_problema,
    tb_problema.descr_problema,
    COUNT(*) AS contador_problema
FROM 
    tb_problema_veiculo
JOIN 
    tb_problema
     ON 
tb_problema.cod_problema = tb_problema_veiculo.cod_problema
GROUP BY 
tb_problema.descr_problema
ORDER BY
contador_problema DESC
;

-- POC query 1
-- (314,'MOTOR:RUIDO') em tb_problema
-- cod_problema é FK em tb_problema_veiculo
-- cod_chassi e cod_comprador são PK em tb_problema_veiculo
-- INSERT INTO tb_problema_veiculo VALUES
-- ('1HGCM56897A153798',95321,314),
-- ('5TDBK3EH4DS188897',39039,320),
-- ('1YVHP81H695M28957',89880,315),
-- ('KNDUP131326318928',98081,320),
-- ('1HGCR2F78EA249331',96291,NULL),
-- ('2GNALBEK3C6196522',23483,314),
-- ('2HGFA1F5XAH585636',89269,318),
-- ('2GNALBEC6B1249850',29941,314),
-- ('KNDJF724077331674',45813,322),
-- ('1C4NJPBA6ED609885',94073,319)

-- o codigo 314 aparece em 3 relações de chassi e comprador

SELECT 
tb_problema_veiculo.cod_chassi,
tb_problema_veiculo.cod_comprador,

COUNT(*) AS "problema mais comum"

FROM tb_problema_veiculo

WHERE cod_problema = 314 

-- /*Resultado deve dar 3*/ ---> correto
;

-- Segundo
-- Modelo mais vendido

SELECT 
     tb_veiculo.cod_modelo,
    COUNT(*) AS Mais_vendidos
FROM 
    tb_veiculo
    
   GROUP BY 
        tb_veiculo.cod_modelo
        
    ORDER BY Mais_vendidos DESC
    ; 
    
    -- POC query 2
	-- Na tb_modelo:
    -- ('KKK','KWID','ZN394')
	-- ('KKK','KWID','OT462')
	-- ('KKK','KWID','IT461')
    -- cod_modelo é FK em tb_veiculo
    /*
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
    */
    -- o modelo KKK está relacionado a 4 num_chassi (PK em tb_veiculo) em tb_veiculo
    
    SELECT
    tb_veiculo.cod_chassi,
    tb_veiculo.cod_modelo,
    
    COUNT(*) AS "problema mais comum"
    
    FROM tb_veiculo
    
    WHERE cod_modelo = "KKK"
    -- /*Resultado deve dar 4*/ ---> correto
    ;
    
    -- Terceiro 
    -- Problemas reportados com solução
    
   SELECT 
    tb_problema_veiculo.cod_problema,
    tb_problema_solucao.cod_solucao,
    tb_solucao.descr_solucao
FROM 
    tb_problema_solucao
JOIN 
tb_solucao
    ON
    tb_solucao.cod_solucao =  tb_problema_solucao.cod_solucao
JOIN 
    tb_problema_veiculo
     ON 
   tb_problema_veiculo.cod_problema =  tb_problema_solucao.cod_problema 
GROUP BY 
tb_problema_solucao.cod_problema
ORDER BY
tb_solucao.descr_solucao
;

 -- POC query 3
 -- da tabela tb_problema_solucao
 /* ('QC0009250',316),
    ('QC0009250',321),
    ('QX0000000',314),
    ('QX0000000',315),
	('QC0005631','322'),
    ('QC0007833','322')
    */
    -- 5 problemas diferentes tem solução (314,315,316,321 e 322)
    -- da tb_problema_veiculo
    /*
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
 */
-- cod_problema e FK em tb_problema_veiculo
-- os problemas que não tem solução e foram reportados foram 320,318,319
-- os problemas que foram reportados e tem solução foram 314,315, e 322 (3)


SELECT COUNT(distinct cod_problema) 

FROM tb_problema_solucao 

WHERE cod_problema IN (314,315,322)

-- resultado deve dar 3 ----> correto
;

    -- Quarto query
    -- Versão mais comum por modelo
    
    SELECT 
    tb_veiculo.cod_modelo,
    tb_veiculo.cod_versao,
 tb_versao.nome_versao,
COUNT(tb_veiculo.cod_versao) AS qtd_versao
FROM 
tb_veiculo
LEFT JOIN 
tb_versao
 ON  tb_versao.cod_versao  = tb_veiculo.cod_versao
GROUP BY
 tb_versao.nome_versao,
 tb_veiculo.cod_modelo
ORDER BY
qtd_versao DESC,
cod_modelo
;

 -- POC query 4
-- da tb_veiculo
/* 
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

da tb_versao
('ZN394','ZEN'),
('LF958','LIFE'),
('OT462','OUTSIDER'),
('IT461','INTENSE')
*/
-- cod_modelo é FK
-- cod_versao é FK
-- cod_chassi é PK
/* 
4 KKK = 2 intense / 1 zen / 1 outsider
2 L99 = 2 life
2 B99 = 2 zen
2 HDU = 1 intense / 1 zen
*/

SELECT 
tb_veiculo.cod_modelo,
tb_veiculo.cod_versao,
COUNT(*) AS QNT_VERSAO

FROM tb_veiculo
WHERE cod_modelo = "L99"

GROUP BY tb_veiculo.cod_versao
/*Resultado deve seguir a relação está relação previamente estabelecida apenas mudando a condição de "WHERE" 
4 KKK = 2 intense / 1 zen / 1 outsider
2 L99 = 2 life
2 B99 = 2 zen
2 HDU = 1 intense / 1 zen
-----> correto
*/
;

-- Quinto query
-- Quilometros rodados por veículo

SELECT  
    tb_comprador.cod_comprador,
    tb_veiculo.quilometros_rodados, 
    tb_veiculo.cod_modelo
FROM 
    tb_veiculo
JOIN 
tb_comprador
ON  
    tb_comprador.cod_comprador = tb_veiculo.cod_comprador
GROUP BY 
tb_comprador.cod_comprador
ORDER BY  
    quilometros_rodados DESC
    ;
    
    -- POC query 5
    -- se trata de uma extração direta onde o atributo = informação requerida
    -- atributo simples da tb_veiculo
    
    SELECT
    tb_veiculo.cod_chassi,
    tb_veiculo.cod_modelo,
    tb_veiculo.quilometros_rodados
    
    FROM tb_veiculo
    
    ORDER BY quilometros_rodados DESC
    ;
    
-- Sexto query
-- Planta mais comum a venda de veículos

SELECT  
tb_veiculo.cod_planta, 
tb_planta.nome_planta,
COUNT(tb_veiculo.cod_planta) AS numero_vendas
FROM 
tb_veiculo
JOIN 
tb_planta
ON  
tb_veiculo.cod_planta = tb_planta.cod_planta
GROUP BY 
	tb_veiculo.cod_planta
ORDER BY 
	numero_vendas DESC
    ;
    
  -- POC query 6
  -- ('CUR77','CURITIBA'), da tb_planta
  -- da tb_veiculo temos:
  /*('1HGCM56897A153798',500,'2019-05-21','2020-03-23',95321,'HDU','IT461','SOF58',3),
('5TDBK3EH4DS188897',300,'2019-10-01','2020-04-06',39039,'KKK','IT461','CUR77',5),
('1YVHP81H695M28957',450,'2019-10-21','2020-07-10',89880,'KKK','IT461','SOF58',1),
('KNDUP131326318928',120,'2019-04-24','2020-07-14',98081,'L99','LF958','COR66',5),
('1HGCR2F78EA249331',287,'2019-10-28','2020-08-14',96291,'B99','ZN394','CUR77',2),
('2GNALBEK3C6196522',432,'2019-12-24','2020-09-04',23483,'B99','ZN394','COR66',3),
('2HGFA1F5XAH585636',400,'2019-04-24','2020-09-09',89269,'KKK','ZN394','CUR77',4),
('2GNALBEC6B1249850',620,'2019-06-27','2020-09-10',29941,'KKK','OT462','SOF58',1),
('KNDJF724077331674',1200,'2019-09-25','2020-10-28',45813,'HDU','ZN394','CUR77',5),
('1C4NJPBA6ED609885',822,'2019-09-12','2020-12-02',94073,'L99','LF958','COR66',2)
*/
-- cod_planta é FK em tb_veiculo
-- cod_chassi é PK em  tb_veiculo
-- temos 4 chassis atrelados a planta de curitiba = CUR77

SELECT
tb_veiculo.cod_chassi,
tb_veiculo.cod_planta,
COUNT(*) as qnt_planta

FROM tb_veiculo

WHERE cod_planta = "CUR77"

-- deve dar 4 ---> correto
;

    -- Setimo
    -- Concessionarias que mais venderam
SELECT  
    tb_veiculo.cod_concessionaria,
    tb_concessionaria.nome_concessionaria,
    tb_concessionaria.estado_concessionaria,
    count(*) AS total_vendas
FROM 
   tb_veiculo
JOIN  tb_concessionaria
    ON
     tb_veiculo.cod_concessionaria =  tb_concessionaria.cod_concessionaria
GROUP BY 
tb_veiculo.cod_concessionaria
ORDER BY 
    total_vendas DESC
    ;
    -- POC query 7
    -- da tb_veiculos temos:
    /* 
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
*/
-- cod_concessionaria é FK na tb_veiculo
-- cod_chassi é PK na tb_veiculo
-- da tb_concessionaria:
/*
(5,'CASCAVEL','PR','OPEN VEICULOS CASCAVEL'),
(4,'BELO HORIZONTE','MG','MINAS FRANCE SAVASSI'),
(1,'CURITIBA','PR','GLOBO VEICULOS VILA ISABEL'),
(2,'SAO JOSE DOS PINHAIS','PR','GLOBO VEICULOS SAO JOSE DOS PINHAIS'),
(3,'RIO DE JANEIRO','RJ','LEAUTO BOTAFOGO')
*/
-- segundo o select a concessionaria de codigo 5 teve 3 vendas total
-- na tb_veiculos temos 3 chassis atrelados ao cod_concessionaria 5.

SELECT
tb_veiculo.cod_chassi,
tb_veiculo.cod_concessionaria,
COUNT(*) AS qnt_vendas

FROM tb_veiculo

WHERE cod_concessionaria = 5

-- devemos encontrar 3 ---> correto
;

    -- Oitavo 
    -- Veiculos sem nenhum problema reportado
    
SELECT 
	cod_chassi,cod_comprador,cod_problema, 
		SUM( CASE when  cod_problema is NULL
        THEN 1
        ELSE 0
        END) AS sum_qualidade
        from  tb_problema_veiculo

    ORDER BY cod_problema  DESC
    
    ;
    
    -- POC query 8
    -- da tb_problema_veiculo
    /*
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
*/
-- temos apenas 1 chassi sem ter um problema reportado
-- tendo a PK como o cod_chassi e o cod_comprador
-- o cod_problema é FK
-- basta verificar qual chassi tem um cod_problema igual a NULL

SELECT 
tb_problema_veiculo.cod_chassi,
tb_problema_veiculo.cod_comprador,
tb_problema_veiculo.cod_problema

FROM tb_problema_veiculo

WHERE cod_problema IS NULL

-- Devemos encotrar o chassi 1HGCR2F78EA249331 ---> correto
;
    
    -- Nona
    -- Tempo entre fabricação e venda
    
    SELECT
    tb_veiculo.cod_chassi,
    tb_veiculo.data_fabricacao,
    tb_veiculo.data_compra,
    
    TIMESTAMPDIFF (MONTH,data_fabricacao, data_compra) AS quantidade_meses
    
    FROM
    tb_veiculo
    
    ORDER BY quantidade_meses DESC
    ;
    
     -- POC query 9
     -- da tb_veiculo:
/*
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
*/
-- temos a data_fabricacao como um atributo simples
-- temas a data_compra como atributo simples
-- podemos verificar a diferença entre as duas datas de um chassi aleatorio para verificar se o SELECT esta correto
-- chassi 5TDBK3EH4DS188897 ---> data fabricação: out/2019 ; data de compra: abril/2020 = temos 6 meses de diferença, assim como mostra a instrução select.

-- Decima
-- modelo mais comum por estado

SELECT
tb_veiculo.cod_modelo,
tb_veiculo.cod_concessionaria,
tb_concessionaria.estado_concessionaria,
COUNT(*) AS total_por_estado


FROM tb_concessionaria

JOIN 
tb_veiculo ON
tb_veiculo.cod_concessionaria = tb_concessionaria.cod_concessionaria

GROUP BY estado_concessionaria

ORDER BY total_por_estado DESC

;

-- POC query 10,
-- da tb_veiculo
 /* 
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
*/
-- e da tb_concessionaria:
/*
(5,'CASCAVEL','PR','OPEN VEICULOS CASCAVEL'),
(4,'BELO HORIZONTE','MG','MINAS FRANCE SAVASSI'),
(1,'CURITIBA','PR','GLOBO VEICULOS VILA ISABEL'),
(2,'SAO JOSE DOS PINHAIS','PR','GLOBO VEICULOS SAO JOSE DOS PINHAIS'),
(3,'RIO DE JANEIRO','RJ','LEAUTO BOTAFOGO')
*/
-- os cod_concessionaria 5,1, e 2 referem se ao estado do PR
-- o cod_concessionaria 4 refere se a MG.
-- o cod 3 refere se ao RJ.
-- a concessionaria cod_concessionaria 4 é atrelada a um unico chassi na tb_veiculo com o cod_modelo sendo KKK
-- a concessionaria cod_concessionaria 3 é atrelado a 2 chassis na tb_veiculo com sendo o cod_modelo HDU e B99
-- a concessionaria cod_concessionaria 1, 2 e 5 são atrelados a 7 chassis na tb_veiculo sendo o cod_modelo mais comum o KKK.

SELECT 
tb_veiculo.cod_chassi,
tb_veiculo.cod_modelo,
tb_veiculo.cod_concessionaria,
COUNT(cod_modelo) AS qnd_vendida

FROM tb_veiculo

WHERE cod_concessionaria IN (1,2,5)

GROUP BY cod_modelo
ORDER BY qnd_vendida DESC

-- 7 veiculos no total sendo o KKK o mais vendido no PR (cod_concessionaria 1,2 e 5) ---> correto

;

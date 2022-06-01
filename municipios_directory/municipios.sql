select * from regiao r 
select * from municipio m 
select * from estado e
select * from indice i 


--1 - municipios que não pertencem a regiao norte

select m.nomemunicipio, e.nomeestado from municipio m join estado e on m.codestado = e.codestado where not exists
(select * from regiao r where r.codregiao = e.codregiao and r.codregiao = 1);


--2 - municipios que possuem o mesmo nome

select m.nomemunicipio, m.codmunicipio from municipio m where exists 
(select m2.nomemunicipio from municipio m2 where m2.nomemunicipio = m.nomemunicipio 
and m2.codmunicipio != m.codmunicipio);


--3 - media de municipios por regiao

select nomeregiao, round(avg(contagem_municipios), 1) from 
(select codregiao, count(m.codmunicipio) as contagem_municipios 
from estado e join municipio m on m.codestado = e.codestado group by e.codestado) r2 join regiao r on r2.codregiao = r.codregiao 
group by r.codregiao;


--4 - sigla dos estados com as respectivas quantidades de municipios

select siglaestado , count(m.codmunicipio) as contagem_municipios 
from estado e join municipio m on m.codestado = e.codestado group by e.codestado;


--5 - municipio com as pessoas mais idosas REVER

select nomemunicipio,  max(idh_longevidade) as mais_longevo from indice i
join municipio m on m.codmunicipio = i.codmunicipio 
group by m.codmunicipio order by max(idh_longevidade) desc limit 1;


--6 - ano em que salvador obteve o melhor indice de instrução REVER

select nomemunicipio, ano, max(idh_educacao) as instrucao_max from indice i
join municipio m on m.codmunicipio = i.codmunicipio 
where m.nomemunicipio = 'Salvador'
group by i.ano, m.nomemunicipio order by max(idh_educacao) desc limit 1;


--7 - qual o municipio com a melhor distribuição de renda REVER

select nomemunicipio,  max(idh_renda) as maior_renda from indice i
join municipio m on m.codmunicipio = i.codmunicipio 
group by m.codmunicipio order by max(idh_renda) desc limit 1;

--8 - quais estados possuem municipios com IDH geral maior que 0.8

select siglaestado, idh_geral from estado e 
join municipio m on e.codestado = m.codestado 
join indice i on m.codmunicipio = i.codmunicipio 
where i.idh_geral > 0.8;

--9 - qual o maior IDH de educação por estado

select siglaestado, max(idh_educacao) from estado e join municipio m on e.codestado = m.codestado 
join indice i on m.codmunicipio = i.codmunicipio 
group by e.siglaestado;

--10 - relatorio de todos IDHs da bahia de 91 e 2000, inclusive com a diferença entre os mesmos

--select m.nomemunicipio , ano, idh_geral, idh_renda, idh_longevidade, idh_educacao from estado e 
--join municipio m on e.codestado = m.codestado 
--join indice i on m.codmunicipio = i.codmunicipio 
--where siglaestado = 'BA'

SELECT	
nomemunicipio,
    i2.idh_geral - i.idh_geral   AS diferenca_idh_geral,
    i2.idh_renda - i.idh_renda   AS diferenca_idh_renda,
    i2.idh_longevidade - i.idh_longevidade   AS diferenca_idh_longevidade,
    i2.idh_educacao - i.idh_educacao   AS diferenca_idh_educacao
FROM
(SELECT * from indice i where ano = 1991) i
CROSS JOIN
(select * from indice i2 where ano = 2000) i2
join municipio m
on m.codmunicipio = i.codmunicipio 
join estado e 
on e.codestado = m.codestado 
where e.siglaestado = 'BA';

--select * from indice i 

--11 - relatorio comparativo entre as medias dos IDHs de SC e AL de 2000 e 91

select siglaestado as estado, round(avg(idh_educacao), 3) as media_idh_educacao, 
 round(avg(idh_geral), 3) as media_idh_geral,  round(avg(idh_renda), 3) as media_idh_renda,
 round(avg(idh_longevidade), 3) as media_idh_longevidade, i.ano 
from estado e join municipio m on e.codestado = m.codestado 
join indice i on m.codmunicipio = i.codmunicipio where siglaestado = 'SC' or siglaestado = 'AL'
group by i.ano, e.siglaestado;

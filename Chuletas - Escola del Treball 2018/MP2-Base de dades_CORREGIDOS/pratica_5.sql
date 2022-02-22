-- 1.- Quantes oficines tenim a cada regió?

select count(*),region from oficinas group by region;

 count | region 
-------+--------
     3 | Este
     2 | Oeste
(2 rows)


-- 2.- Quants representants de ventes hi ha a cada oficina?

select count(*),oficina_rep from repventas where oficina_rep is NOT NULL group by oficina_rep;

-- 3.- Quants representants de ventes té assignats cada cap de respresentants?

select count(*),director from repventas where director is not null group by director;

 count | director 
-------+----------
     3 |      106
     2 |      108
     1 |      101
     3 |      104
(4 rows)

-- 4.- Quina és, per cada oficina, la suma de les quotes dels seus representants? I la mitjana de les quotes per oficina?

select oficina_rep,sum(cuota) from repventas where oficina_rep is not null group by oficina_rep;

 oficina_rep |    sum    
-------------+-----------
          12 | 775000.00
          21 | 700000.00
          11 | 575000.00
          13 | 350000.00
          22 | 300000.00
(5 rows)


select oficina_rep,avg(cuota) from repventas where oficina_rep is not null group by oficina_rep;

 oficina_rep |         avg         
-------------+---------------------
          12 | 258333.333333333333
          21 | 350000.000000000000
          11 | 287500.000000000000
          13 | 350000.000000000000
          22 | 300000.000000000000
(5 rows)



-- 5.- Quin és el representant que té la quota més alta de cada oficina?

select num_empl,max(cuota),oficina_rep from repventas where oficina_rep is NOT NULL group by num_empl;

-- 6.- Quants clients representa cada venedor-repventas?

select count(*),rep_clie from clientes group by rep_clie;

-- 7.- Quin és el client de cada  venedor-repventas amb el límit de crèdit més alt?

select max(limite_credito),rep_clie from clientes group by rep_clie;

-- 8.- Per cada codi de fàbrica diferents, quants productes hi ha?

select distinct id_fab,count(id_producto) from productos group by id_fab;

-- 9.- Per cada codi de producte diferent, a quantes fàbriques es fabrica?

select distinct id_producto,count(id_fab) from productos group by id_producto;

-- 10.- Per cada nom de producte diferent, quants codis (if_fab + id_prod) tenim?

select distinct descripcion,count(*) from productos group by descripcion;

-- 11.- Per cada producte (if_fab + id_prod), quantes comandes tenim?

select fab,producto,count(*) from pedidos group by fab,producto;

-- 12.- Per cada client, quantes comandes tenim?

select clie,count(*) from pedidos group by clie;

-- 13.- Quantes comandes ha realitzat cada representant de vendes?

select rep,count(*) from pedidos group by rep;

-- 14.- Quina és la comanda promig de cada venedor?

select rep,avg(importe) from pedidos group by rep;

-- 15.- Quin és el rang de quotes asignades a cada oficina? ( es a dir, el mínim i el màxim)

select oficina_rep,min(cuota),max(cuota) from repventas where oficina_rep is NOT NULL group by oficina_rep;

-- 16.- Quants venedors estan asignats a cada oficina?

select count(*),oficina_rep from repventas where oficina_rep is NOT NULL group by oficina_rep;

-- 17.- Quants clients són atesos per (tenen com a representant oficial a) cada venedor?

select count(*),rep_clie from clientes group by rep_clie;

-- 18.- Calcula el total de l'import de les comandes per cada venedor i per cada client.

select clie,rep,sum(importe) from pedidos group by clie,rep;

-- 19.- El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.

select clie,rep,sum(importe) from pedidos group by clie,rep order by clie,rep;

-- 20.- Calcula les comandes (imports) totals per a cada venedor.


select sum(importe),rep from pedidos group by rep;

-- 21.- Quin és l'import promig de les comandes per cada venedor, les comandes dels quals sumen més de 30 000?


select avg(importe),rep from pedidos group by rep having sum(importe)>30000;


-- 22.- Per cada oficina amb 2 o més persones, calculeu la quota
-- total i les vendes totals per a tots els venedors que treballen a la oficina

select oficina_rep,sum(cuota),sum(ventas) from repventas where oficina_rep is not null group by oficina_rep having count(*)>=2;



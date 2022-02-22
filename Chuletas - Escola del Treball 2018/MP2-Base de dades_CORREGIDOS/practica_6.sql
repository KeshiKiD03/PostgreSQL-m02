-- 1.- Quantes oficines tenim a cada regió amb un nom de ciutat que contingui una 'a'?

select count(*),region from oficinas where ciudad ilike '%a%' group by region;


-- 2.- Quants representants de ventes amb un objectiu superior a 10000 hi ha a cada oficina ?

select count(*),oficina from oficinas where objetivo>10000 and oficina is not null group by oficina;

-- 3.- Per cada codi de fàbrica diferent, quants productes hi ha amb un preu superior a 50?

select id_fab,count(*) from productos where precio>50 group by id_fab;

-- 4.- Visualitza cada codi de fàbrica diferent amb més de 6 productes-

select id_fab,count(*) from productos group by id_fab having count(*)>6;

-- 5.- Per cada codi de producte diferent, a quantes fàbriques es fabrica?

select id_producto,count(*) from productos group by id_producto;

-- 6.- Quantes comades superiors a 10000 ha fet cada representant de ventes?

select rep,count(*) from pedidos where importe>1000 group by rep;

-- 7.- Quins codis de representant han fet comades amb un import total superior a 40000?

select rep,importe from pedidos group by rep,importe having sum(importe)>40000;

-- 8.- Quins codis de representant han fet més de dues comandes?

select rep,coun(*) from pedidos group by rep having count(*)>2;

-- 9.- Quins codis de representant han venut a més de 2 clients diferents?

select rep from pedidos group by rep having count(distinct clie)>2;

-- 10.-  Quins codis de representant han venut productes de més d'una fàbrica?

select rep from pedidos group by rep having count(fab)>2;

-- 11.- Quins codis de representant han venut comandes de més de 6 unitats a més de 2 clients diferents ?

select rep from pedidos where cant>6 group by rep having count(distinct clie)>2;

-- 12.- Quins codis de representant han fet més de 1 coamanda amb un 'import superior a 2000?

select rep from pedidos where importe>2000 group by rep having count(*)>1;









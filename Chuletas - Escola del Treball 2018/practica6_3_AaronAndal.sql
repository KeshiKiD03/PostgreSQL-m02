Consultes simples o monotaula

-- 4.1- Quina és la quota promig mostrada com a "prom_cuota" i la venda promig mostrades com a "prom_ventas" dels venedors?

SELECT round(avg(cuota),2) as "prom_cuota", round(avg(ventas),2) as "prom_ventas" FROM repventas;

-- 4.2- Quin és el rendiment de quota promig dels venedors (percentatge de les vendes respecte la quota)?

training=# SELECT round((ventas/cuota*100),0) || '%' AS "Percentatge" FROM repventas;
 ?column? 
----------
 105%
 131%
 135%
 109%
 71%
 102%
 
 103%
 104%
 62%
(10 rows)


-- 4.3- Quines són les quotes totals com a "t_cuota" i vendes totals com a "t_ventas" de tots els venedors?



-- 4.4- Calcula el preu mig dels productes del fabricant amb identificador "aci".



-- 4.5- Quines són les quotes assignades mínima i màxima?



-- 4.6- Quina és la data de comanda més antiga?



-- 4.7- Quin és el major rendiment de vendes de tots els venedors?



-- 4.8- Quants clients hi ha?



-- 4.9- Quants venedors superen la seva quota?



-- 4.10- Quantes comandes de més de 25000 hi ha en els registres?



-- 4.11-



-- 4.12- Trobar l'import mitjà de les comandes, l'import total de les comandes, l'import mitjà de les comandes com a percentatge del límit de crèdit del client i l'import mitjà de comandes com a percentatge de la quota del venedor.



-- 4.13- Compta les files que hi ha a repventas, les files del camp vendes i les del camp quota.



-- 4.14- Mostra que la suma de restar (vendes menys quota) és diferent que sumar vendes i restar-li la suma de quotes.



-- 4.15- Quants títols diferents tenen els venedors?



-- 4.16- Quantes oficines de vendes tenen venedors que superen les seves quotes?



-- 4.17- Seleccionar de la taula clients quants clients diferents i venedors diferents hi ha.



-- 4.18- De la taula comandes seleccionar quantes comandes diferents i clients diferents hi ha



-- 4.19- Calcular la mitjana dels imports de les comandes.



-- 4.20- Calcula la mitjana de l'import d'una comanda realitzada pel client amb nom d'empresa "Acme Mfg."



-- 4.21- Quina és la comanda promig de cada venedor?



-- 4.22- Quin és el rang (màxim i mínim) de quotes dels venedors per cada oficina?



-- 4.23- Quants venedors estan asignats a cada oficina?



-- 4.24- Per cada venedor calcular quants clients diferents ha atès (ha fet comandes)?



-- 4.25- Calcula el total dels imports de les comandes fetes per cada client a cada venedor.



-- 4.26- El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.



-- 4.27- Calcula les comandes totals per a cada venedor.



-- 4.28- Quin és l'import promig de les comandes per cada venedor que les seves comandes sumen més de 30000?



-- 4.29- Per cada oficina amb dos o més empleats, calcular la quota total i les vendes totals per a tots els venedors que treballen a la oficina (volem que mostrar la ciutat de l'oficina a la consulta)



-- 4.30- Mostra el preu, les existències i la quantitat total de les comandes de cada producte per als quals la quantitat total demanada està per sobre del 75% de les existències.



-- 4.31- Es desitja un llistat d'identificadors de fabricants de productes. Només volem tenir en compte els productes de preu superior a 54. Només volem que apareguin els fabricants amb un nombre total d'unitats superior a 300.

training=# SELECT id_fab FROM productos WHERE precio > 54 AND existencias > 300; 
 id_fab 
--------
(0 rows)


training=# SELECT id_fab, sum(existencias) FROM productos WHERE precio > 54 GROUP BY id_fab HAVING sum(existencias) > 300;
 id_fab | sum 
--------+-----
 aci    | 843
(1 row)

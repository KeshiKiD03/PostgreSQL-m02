1. Selecciona els treballadors que han venut menys quantitat de productes que la Sue Smith

SELECT DISTINCT(num_empl), nombre
FROM repventas
JOIN pedidos on num_empl = rep
WHERE cant < (SELECT sum(cant) FROM pedidos JOIN repventas on rep = num_empl WHERE nombre = 'Sue Smith');

-- Els treballadors que han venut menys que ...
SELECT sum(cant), rep FROM pedidos GROUP BY rep
HAVING sum(cant) < ( -- Buscamos a Sue Smith y su suma de cant
                    SELECT sum(cant) FROM pedidos WHERE rep = 
                    (SELECT num_empl FROm repventas WHERE nombre = 'Sue Smith'));

2. Llista els treballadors que han venut mes en import que la Sue Smith, la Mary Jones i els Will Adams


-- El ALL es para multiregistro mira todos los resultados y tiene que cumplir la condicion para todos ellos.
-- El ANY es para multiregistro mira todos los resultados y tiene que cumplir almenos uno para salir.

SELECT sum(importe), rep
FROM pedidos
GROUP BY rep
HAVING sum(importe) > ALL( SELECT sum(importe) FROM pedidos  WHERE rep IN (SELECT num_empl
                                                                      FROM repventas 
                                                                      WHERE nombre = 'Sue Smith' or nombre = 'Mary Jones' or nombre = 'Bill Adams') GROUP BY rep);

3. Llista els treballadors que han venut mes que alguns dels seguents : Sue Smith, la Mary Jones i els Will Adams

SELECT sum(importe), rep
FROM pedidos
GROUP BY rep
HAVING sum(importe) > ANY( SELECT sum(importe) FROM pedidos  WHERE rep IN (SELECT num_empl
                                                                      FROM repventas 
                                                                      WHERE nombre = 'Sue Smith' or nombre = 'Mary Jones' or nombre = 'Bill Adams') GROUP BY rep);
-- CLAU = IDENTIFICADOR UNIC
SELECT nombre, num_empl, ventas
FROM repventas
WHERE ventas > ANY (SELECT ventas FROM repventas  WHERE nombre = 'Sue Smith' or nombre = 'Mary Jones' or nombre = 'Bill Adams');



4. Llista els treballadors que han fet mes comandes que els seus directors.



SELECT rep, count(*) as "Cuantitat Comandes"
FROM pedidos as p1
GROUP BY 1
HAVING count(*) > (SELECT count(*) FROM pedidos as p2 WHERE p2.rep = (SELECT director FROM repventas WHERE p1.rep = num_empl));
-------

SELECT num_empl, (SELECT count(*) as "Num ventes" FROM pedidos WHERE rep = num_empl), director, (SELECT count(*) as "Num ventes Dir" FROM pedidos WHERE rep = director)
FROM repventas
ORDER BY 2;


5. Llista els treballadors que en el r[anking de ventes estan entre el Dan Roberts i la Mary Jones

SELECT nombre 
FROM repventas as r1
JOIN pedidos as p1 on p1.rep = r1.num_empl
GROUP BY r1.num_empl
HAVING sum(p1.importe) >= (SELECT sum(p2.importe) FROM pedidos as p2 JOIN repventas as r2 on p2.rep = r2.num_empl WHERE r2.nombre = 'Mary Jones') and sum(p1.importe) <=
(SELECT sum(p3.importe) FROM pedidos as p3 JOIN repventas as r3 on p3.rep = r3.num_empl WHERE r3.nombre = 'Dan Roberts');




-- Total ventes de tots
-- Total ventes Dan y Mary



6. Mostra les oficines (codi i ciutat) tals que el seu objectiu sigui inferior o igual a les quotes de tots els seus treballadors.

SELECT oficina, ciudad 
FROM oficinas
WHERE objetivo <= ALL(SELECT cuota FROM repventas where oficina_rep = oficina );


7. Llista els representants de vendes (codi de treballador i nom) que tenen un director més jove que algun dels seus empleats.

SELECT e.num_empl, e.nombre
FROM repventas e
JOIN repventas d on d.num_empl = e.director
WHERE d.edad < ANY( SELECT edad FROM repventas WHERE director = d.num_empl);

SELECT e.num_empl, e.nombre
FROM repventas e
WHERE edad < ANY( SELECT edad FROM repventas WHERE director = num_empl);

-- Per treure els directors:
SELECT e.num_empl, e.nombre FROM repventas e WHERE e.num_empl IN(SELECT DISTINCT d.director FROM repventas d)
-- 
AND e.edad < ANY( SELECT edad FROM repventas r WHERE r.director = e.num_empl );


8. Mostrar el codi de treballador, el seu nom i un camp anomenat i_m. 
El camp i_m és l''import més gran de les comandes que ha fet aquest treballador. 
Només s''han de llistar els treballadors que tinguin tots els clients amb alguna comanda amb import 
superior a la mitjana dels imports de totes les comandes.

SELECT num_empl, nombre, (SELECT MAX(importe) FROM pedidos WHERE rep = num_empl) as "m"
FROM repventas
WHERE ALL
(SELECT AVG(importe) FROM pedidos JOIN clientes on num_clie = clie 


9. Mostra el codi de fabricant i de producte i un camp de nom n_p. 
n_p és el nombre de comandes que s'han fet d'aquell producte. 
Només s''han de llistar aquells productes tals que se n''ha fet alguna comanda amb una quantitat inferior a les seves existències. 
En el llistat només han d''aparèixer els tres productes amb més comandes, 
ordenats per codi de fabricant i de producte.

SELECT id_fab, id_producto, (SELECT count(*) FROM pedidos WHERE id_fab = fab and id_producto = producto) as "n_p"
FROM productos
-- Si existe este sql lo sacara
WHERE EXISTS(SELECT num_pedido FROM pedidos WHERE id_producto = producto AND id_fab = fab AND cant < existencias)
ORDER BY 1,2;

10. Mostra el codi de client, el nom de client, un camp c_r i un camp n_p. 
El camp c_r ha de mostrar la quota del representant de vendes del client. 
El camp n_p ha demostrar el nombre de comandes que ha fet aquest client. 
Només s'han de mostrar els clients que l'import total de totes les seves comandes sigui superior a 
la mitjana de l''import de totes les comandes.

SELECT num_clie, empresa, 
(SELECT cuota FROM repventas WHERE rep_clie = num_empl) AS "c_r", 
(SELECT count(*) FROM pedidos WHERE num_clie = clie) AS "n_p"
 FROM clientes
 WHERE (SELECT SUM(importe) FROM pedidos WHERE clie = num_clie) > (SELECT AVG(importe) FROM pedidos);


SELECT num_clie, empresa, 
(SELECT cuota FROM repventas WHERE rep_clie = num_empl) AS "c_r", 
(SELECT count(*) FROM pedidos WHERE num_clie = clie) AS "n_p"
 FROM clientes
 WHERE num_clie IN (SELECT clie FROM pedidos GROUP BY clie HAVING SUM(importe) > (SELECT AVG(importe) FROM pedidos));

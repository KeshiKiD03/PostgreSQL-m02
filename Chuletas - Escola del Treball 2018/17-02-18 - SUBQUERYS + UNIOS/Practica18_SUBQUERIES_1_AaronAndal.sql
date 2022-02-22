-------------------------------------------------------------------------------
--          Subconsultes
-------------------------------------------------------------------------------


-- 5.1- Llista els venedors que tinguin una quota igual o inferior a l'objectiu de l'oficina de vendes d'Atlanta.

SELECT nombre 
FROM repventas 
WHERE cuota <= (SELECT objetivo 
                FROM oficinas 
                WHERE ciudad = 'Atlanta');

-- 5.2- Tots els clients, identificador i nom de l'empresa, que han estat atesos per (que han fet comanda amb) Bill Adams.

SELECT DISTINCT num_clie, empresa FROM clientes 
JOIN pedidos ON clie = num_clie
JOIN repventas ON rep = num_empl
WHERE nombre = 'Bill Adams';

SELECT DISTINCT num_clie, empresa FROM clientes 
JOIN pedidos ON clie = num_clie
WHERE rep = (SELECT num_empl
             FROM repventas
             WHERE nombre = 'Bill Adams');

SELECT num_clie, empresa
FROM clientes
WHERE num_clie IN (SELECT clie
                   FROM pedidos
                   WHERE rep = (SELECT num_empl
                                FROM repventas
                                WHERE nombre = 'Bill Adams'));

-- El IN busca en una llista

-- 5.3- Venedors amb quotes que siguin iguals o superiors a l'objectiu de llur oficina de vendes.

SELECT nombre, cuota, objetivo
FROM repventas
JOIN oficinas ON oficina = oficina_rep
WHERE cuota >= objetivo;

SELECT nombre
FROM repventas
WHERE cuota >= (SELECT objetivo
                FROM oficinas
                WHERE oficina = oficina_rep);

-- 5.4- Mostrar l'identificador de l'oficina i la ciutat de les oficines on l'objectiu de vendes de l'oficina excedeix la suma de quotes dels venedors d'aquella oficina.

SELECT oficina, ciudad
FROM oficinas
WHERE objetivo > (SELECT SUM(cuota)
                  FROM repventas
                  WHERE oficina_rep = oficina);

-- 5.5- Llista dels productes del fabricant amb identificador "aci" que les existències superen les existències del producte amb identificador de producte "41004" i identificador de fabricant "aci".

SELECT id_producto, id_fab, descripcion
FROM productos
WHERE id_fab = 'aci'
AND existencias > (SELECT existencias 
                   FROM productos 
                   WHERE (id_fab, id_producto) = ('aci','41004'));

-- 5.6- Llistar els venedors que han acceptat una comanda que representa més del 10% de la seva quota.

SELECT num_empl, nombre
FROM repventas 
JOIN pedidos ON rep = num_empl
WHERE importe > 0.1 * cuota;

SELECT num_empl, nombre
FROM repventas 
WHERE cuota * 0.1 < ANY (SELECT importe
                         FROM pedidos
                         WHERE rep = num_empl);

SELECT DISTINCT rep
FROM pedidos
WHERE importe > (SELECT cuota * 0.1
                 FROM repventas
                 WHERE rep = num_empl);

-- 5.7- Llistar el nom i l'edat de totes les persones de l'equip de vendes que no dirigeixen una oficina.

SELECT nombre, edad
FROM repventas
WHERE num_empl NOT IN (SELECT dir
                       FROM oficinas);

-- 5.8- Llistar aquelles oficines, i els seus objectius, que tots els seus venedors tinguin unes vendes que superen el 50% de l'objectiu de l'oficina.

SELECT oficina, ciudad, objetivo
FROM oficinas
WHERE 0.5 * objetivo < ALL (SELECT ventas
                            FROM repventas
                            WHERE oficina_rep= oficina);

-- 5.9- Llistar aquells clients que els seus representants de vendes estàn assignats a oficines de la regió est.

SELECT num_clie, empresa
FROM clientes                                   
JOIN repventas ON rep_clie = num_empl
JOIN oficinas ON oficina_rep = oficina
WHERE Region = 'Este';

SELECT num_clie, empresa
FROM clientes
WHERE rep_clie IN (SELECT num_empl
                   FROM repventas
                   WHERE oficina_rep IN (SELECT oficina 
                                         FROM oficinas 
                                         WHERE region = 'Este'));

-- 5.10- Llistar els venedors que treballen en oficines que superen el seu objectiu.

SELECT num_empl, nombre 
FROM repventas
WHERE oficina_rep IN (SELECT oficina
                      FROM oficinas
                      WHERE ventas > objetivo);

-- 5.11- Llistar els venedors que treballen en oficines que superen el seu objectiu. Mostrar també les següents dades de l'oficina: ciutat i la diferència entre les vendes i l'objectiu. Ordenar el resultat per aquest últim valor. Proposa dues sentències SQL, una amb subconsultes i una sense.

SELECT num_empl, nombre, ciudad, oficinas.ventas - objetivo AS dif
FROM repventas 
JOIN oficinas ON oficina_rep = oficina
WHERE oficina_rep IN (SELECT oficina
                      FROM oficinas
                      WHERE ventas > objetivo)
ORDER BY dif;

SELECT num_empl, nombre, ciudad, oficinas.ventas - objetivo AS dif
FROM repventas 
JOIN oficinas ON oficina_rep = oficina
WHERE oficinas.ventas > objetivo
ORDER BY dif;

-- 5.12- Llista els venedors que no treballen en oficines dirigides per Larry Fitch, o que no treballen a cap oficina. Sense usar consultes multitaula.

SELECT num_empl, nombre 
FROM repventas
WHERE oficina_rep IS NULL
OR oficina_rep NOT IN (SELECT oficina 
                       FROM oficinas 
                       WHERE dir = (SELECT num_empl 
                                    FROM repventas 
                                    WHERE nombre = 'Larry Fitch'));

-- 5.13- Llistar els venedors que no treballen en oficines dirigides per Larry Fitch, o que no treballen a cap oficina. Mostrant també la ciutat de l'oficina on treballa l'empleat i l'identificador del director de la oficina. Proposa dues sentències SQL, una amb subconsultes i una sense.

ELECT num_empl, nombre, ciudad 
FROM repventas 
JOIN oficinas ON oficina_rep = oficina
WHERE oficina_rep IS NULL
OR oficina_rep NOT IN (SELECT oficina 
                       FROM oficinas 
                       WHERE dir = (SELECT num_empl 
                                    FROM repventas 
                                    WHERE nombre = 'Larry Fitch'));

SELECT e.num_empl, e.nombre, ciudad 
FROM repventas e 
JOIN oficinas ON oficina_rep = oficina 
JOIN repventas d ON dir = d.num_empl
WHERE e.oficina_rep IS NULL OR d.nombre <> 'Larry Fitch';

-- 5.14- Llistar tots els clients que han realitzat comandes del productes de la família ACI Widgets entre gener i juny del 1990. Els productes de la famíla ACI Widgets són aquells que tenen identificador de fabricant "aci" i que l'identificador del producte comença per "4100".

SELECT empresa 
FROM clientes 
WHERE num_clie IN (SELECT DISTINCT clie
                   FROM pedidos 
                   WHERE fab = 'aci' AND producto LIKE '4100%' 
                   AND fecha_pedido BETWEEN '01-01-1990' AND '30-06-1990');

SELECT DISTINCT  empresa
FROM pedidos 
JOIN clientes ON num_clie = clie
WHERE fab = 'aci' AND producto LIKE '4100%' 
AND fecha_pedido BETWEEN '01-01-1990' AND '30-06-1990';

-- 5.15- Llistar els clients que no tenen cap comanda.

SELECT empresa
FROM clientes
WHERE num_clie NOT IN (SELECT clie
                       FROM pedidos);

-- 5.16- Llistar els clients que tenen assignat el venedor que porta més temps a contractat.

SELECT empresa
FROM clientes
WHERE rep_clie = (SELECT num_empl
                    FROM repventas 
                    WHERE contrato = (SELECT MIN(contrato) 
                                      FROM repventas));

-- 5.17- Llistar els clients assignats a Sue Smith que no han fet cap comanda amb un import superior a 30000. Proposa una sentència SQL sense usar multitaula i una altre en que s'usi multitaula i subconsultes.

SELECT empresa
FROM clientes 
WHERE rep_clie = (SELECT num_empl 
                  FROM repventas
                  WHERE nombre = 'Sue Smith') 
AND NOT EXISTS (SELECT num_pedido 
                FROM pedidos
                WHERE clie = num_clie
                AND importe > 30000);

SELECT empresa FROM clientes 
JOIN repventas ON rep_clie = num_empl 
WHERE nombre = 'Sue Smith' 
AND NOT EXISTS (SELECT num_pedido 
                FROM pedidos
                WHERE clie = num_clie
                AND importe > 30000);

-- 5.18- Llistar l'identificador i el nom dels directors d'empleats que tenen més de 40 anys i que dirigeixen un venedor que té unes vendes superiors a la seva pròpia quota.

SELECT nombre 
FROM repventas 
WHERE edad > 40 AND num_empl IN (SELECT director 
                                 FROM repventas 
                                 WHERE ventas > cuota);

-- 5.19- Llista d'oficines on hi hagi algun venedor tal que la seva quota representi més del 50% de l'objectiu de l'oficina

SELECT ciudad 
FROM oficinas
WHERE objetivo * 0.5 < ANY (SELECT cuota 
                            FROM repventas 
                            WHERE oficina_rep = oficina);

-- 5.20- Llista d'oficines on tots els venedors tinguin la seva quota superior al 55% de l'objectiu de l'oficina.

SELECT ciudad 
FROM oficinas
WHERE objetivo * 0.55 < ALL (SELECT cuota 
                             FROM repventas 
                             WHERE oficina_rep = oficina);

-- 5.21- Transforma el següent JOIN a una comanda amb subconsultes:
-- SELECT num_pedido, importe, clie, num_clie, limite_credito
-- FROM pedidos JOIN clientes
-- ON clie = num_clie;

SELECT num_pedido, importe, clie, 
       (SELECT num_clie FROM clientes WHERE clie = num_clie), 
       (SELECT limite_credito FROM clientes WHERE clie = num_clie) 
FROM pedidos;

-- 5.22- Transforma el següent JOIN a una comanda amb subconsultes:
-- SELECT empl.nombre, empl.cuota, dir.nombre, dir.cuota
-- FROM repventas AS empl JOIN repventas AS dir
-- ON empl.director = dir.num_empl
-- WHERE empl.cuota > dir.cuota;

SELECT empl.nombre, empl.cuota, 
       (SELECT dir.nombre FROM repventas dir WHERE empl.director = dir.num_empl), 
       (SELECT dir.cuota FROM repventas dir WHERE empl.director = dir.num_empl)
FROM repventas empl
WHERE empl.cuota > (SELECT dir.cuota FROM repventas dir WHERE empl.director = dir.num_empl);

-- 5.23- Transforma la següent consulta amb un ANY a una consulta amb un EXISTS i també en una altre consulta amb un ALL:
-- SELECT oficina FROM oficinas WHERE ventas*0.8 < ANY (SELECT ventas FROM repventas WHERE oficina_rep = oficina);

SELECT oficina 
FROM oficinas 
WHERE EXISTS (SELECT * 
              FROM repventas 
              WHERE oficina_rep = oficina AND oficinas.ventas * 0.8 < ventas);
   
SELECT oficina 
FROM oficinas 
WHERE NOT ventas*0.8 >= ALL (SELECT ventas 
                             FROM repventas 
                             WHERE oficina_rep = oficina);
   
-- 5.24- Transforma la següent consulta amb un ALL a una consutla amb un EXISTS i també en una altre consulta amb un ANY:
-- SELECT num_clie FROM clientes WHERE limite_credito < ALL (SELECT importe FROM pedidos WHERE num_clie = clie);

SELECT num_clie 
FROM clientes 
WHERE NOT limite_credito >= ANY (SELECT importe 
                                 FROM pedidos 
                                 WHERE num_clie = clie);
                                 
SELECT num_clie 
FROM clientes WHERE NOT EXISTS (SELECT * 
                                FROM pedidos 
                                WHERE num_clie = clie AND limite_credito >= importe);

-- 5.25- Transforma la següent consulta amb un EXISTS a una consulta amb un ALL i també a una altre consulta amb un ANY:
-- SELECT num_clie, empresa FROM clientes WHERE EXISTS (SELECT * FROM repventas WHERE rep_clie = num_empl AND edad BETWEEN 40 AND 50);

SELECT num_clie, empresa 
FROM clientes 
WHERE rep_clie = ANY (SELECT num_empl 
                      FROM repventas 
                      WHERE edad BETWEEN 40 AND 50);
                      
SELECT num_clie, empresa 
FROM clientes 
WHERE NOT rep_clie <> ALL (SELECT num_empl 
                           FROM repventas 
                           WHERE edad BETWEEN 40 AND 50);

-- 5.26- Transforma la següent consulta amb subconsultes a una consulta sense subconsultes.
-- SELECT * FROM productos WHERE id_fab IN(SELECT fab FROM pedidos WHERE cant > 30) AND id_producto IN(SELECT producto FROM pedidos WHERE cant > 30);

SELECT productos.* 
FROM productos 
JOIN pedidos ON id_fab = fab AND id_producto = producto 
WHERE cant > 30;

-- 5.27- Transforma la següent consulta amb subconsultes a una consulta sense subconsultes.
-- SELECT num_empl, nombre FROM repventas WHERE num_empl = ANY ( SELECT rep_clie FROM clientes WHERE empresa LIKE '%Inc.');

SELECT num_empl, nombre 
FROM repventas 
JOIN clientes ON rep_clie = num_empl 
WHERE empresa LIKE '%Inc.';

-- 5.28- Transforma la següent consulta amb un IN a una consulta amb un EXISTS i també a una altre consulta amb un ALL.
-- SELECT num_empl, nombre FROM repventas WHERE num_empl IN(SELECT director FROM repventas);

SELECT num_empl, nombre 
FROM repventas d 
WHERE EXISTS (SELECT * 
              FROM repventas e 
              WHERE d.num_empl = e.director);
              
SELECT num_empl, nombre 
FROM repventas 
WHERE NOT num_empl <> ALL(SELECT director FROM repventas);

-- 5.29- Modifica la següent consulta perquè mostri la ciutat de l'oficina, proposa una consulta simplificada.
-- SELECT num_pedido FROM pedidos WHERE rep IN
-- (
--     SELECT num_empl FROM repventas WHERE ventas >
--     (
--         SELECT avg(ventas) FROM repventas
--     )
--     AND oficina_rep IN
--     (
--         SELECT oficina FROM oficinas WHERE region ILIKE 'este'
--     )
-- );


Comandes fetes per venedors que les seves vendes siguin superiors a la mitja de totes les vendes i que treballin a oficines de la regió Est.

SELECT num_pedido, ciudad 
FROM pedidos
JOIN repventas ON rep = num_empl
JOIN oficinas ON oficina_rep = oficina
WHERE region ILIKE 'este'
AND repventas.ventas > (SELECT avg(ventas) FROM repventas);

-- 5.30- Transforma la següent consulta amb subconsultes a una consulta amb les mínimes subconsultes possibles.
-- SELECT num_clie, empresa, (SELECT nombre FROM repventas WHERE rep_clie = num_empl) AS rep_nombre FROM clientes WHERE rep_clie = ANY (SELECT num_empl FROM repventas WHERE ventas > (SELECT MAX(cuota) FROM repventas));

SELECT num_clie, empresa, 
       (SELECT nombre FROM repventas WHERE rep_clie = num_empl) AS rep_nombre 
FROM clientes 
WHERE rep_clie = ANY (SELECT num_empl 
                      FROM repventas 
                      WHERE ventas > (SELECT MAX(cuota) FROM repventas));

SELECT num_clie, empresa, 
       (SELECT nombre FROM repventas WHERE rep_clie = num_empl) AS rep_nombre 
FROM clientes 
WHERE rep_clie IN (SELECT num_empl 
                      FROM repventas 
                      WHERE ventas > (SELECT MAX(cuota) FROM repventas));

SELECT num_clie, empresa, nombre AS rep_nombre 
FROM clientes 
LEFT JOIN repventas ON rep_clie = num_empl 
WHERE rep_clie IN (SELECT num_empl 
                   FROM repventas 
                   WHERE ventas > (SELECT MAX(cuota) FROM repventas));

SELECT num_clie, empresa, nombre AS rep_nombre 
FROM clientes 
LEFT JOIN repventas ON rep_clie = num_empl 
WHERE ventas > (SELECT MAX(cuota) FROM repventas);




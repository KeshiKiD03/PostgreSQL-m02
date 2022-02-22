-------------------------------------------------------------------------------
--          Subconsultes
-------------------------------------------------------------------------------


-- 5.1- Llista els venedors que tinguin una quota igual o inferior a l'objectiu de l'oficina de vendes d'Atlanta.



-- 5.2- Tots els clients, identificador i nom de l'empresa, que han estat atesos per (que han fet comanda amb) Bill Adams.



-- 5.3- Venedors amb quotes que siguin iguals o superiors a l'objectiu de llur oficina de vendes.



-- 5.4- Mostrar l'identificador de l'oficina i la ciutat de les oficines on l'objectiu de vendes de l'oficina excedeix la suma de quotes dels venedors d'aquella oficina.



-- 5.5- Llista dels productes del fabricant amb identificador "aci" que les existències superen les existències del producte amb identificador de producte "41004" i identificador de fabricant "aci".


-- 5.6- Llistar els venedors que han acceptat una comanda que representa més del 10% de la seva quota.



-- 5.7- Llistar el nom i l'edat de totes les persones de l'equip de vendes que no dirigeixen una oficina.

-- 5.8- Llistar aquelles oficines, i els seus objectius, que tots els seus venedors tinguin unes vendes que superen el 50% de l'objectiu de l'oficina.


-- 5.9- Llistar aquells clients que els seus representants de vendes estàn assignats a oficines de la regió est.


-- 5.10- Llistar els venedors que treballen en oficines que superen el seu objectiu.


-- 5.11- Llistar els venedors que treballen en oficines que superen el seu objectiu. Mostrar també les següents dades de l'oficina: ciutat i la diferència entre les vendes i l'objectiu. Ordenar el resultat per aquest últim valor. Proposa dues sentències SQL, una amb subconsultes i una sense.




-- 5.12- Llista els venedors que no treballen en oficines dirigides per Larry Fitch, o que no treballen a cap oficina. Sense usar consultes multitaula.


-- 5.13- Llistar els venedors que no treballen en oficines dirigides per Larry Fitch, o que no treballen a cap oficina. Mostrant també la ciutat de l'oficina on treballa l'empleat i l'identificador del director de la oficina. Proposa dues sentències SQL, una amb subconsultes i una sense.


-- 5.14- Llistar tots els clients que han realitzat comandes del productes de la família ACI Widgets entre gener i juny del 1990. Els productes de la famíla ACI Widgets són aquells que tenen identificador de fabricant "aci" i que l'identificador del producte comença per "4100".

-- 5.15- Llistar els clients que no tenen cap comanda.


-- 5.16- Llistar els clients que tenen assignat el venedor que porta més temps a contractat.


-- 5.17- Llistar els clients assignats a Sue Smith que no han fet cap comanda amb un import superior a 30000. Proposa una sentència SQL sense usar multitaula i una altre en que s'usi multitaula i subconsultes.



-- 5.18- Llistar l'identificador i el nom dels directors d'empleats que tenen més de 40 anys i que dirigeixen un venedor que té unes vendes superiors a la seva pròpia quota.

-- 5.19- Llista d'oficines on hi hagi algun venedor tal que la seva quota representi més del 50% de l'objectiu de l'oficina


-- 5.20- Llista d'oficines on tots els venedors tinguin la seva quota superior al 55% de l'objectiu de l'oficina.


-- 5.21- Transforma el següent JOIN a una comanda amb subconsultes:
-- SELECT num_pedido, importe, clie, num_clie, limite_credito
-- FROM pedidos JOIN clientes
-- ON clie = num_clie;



-- 5.22- Transforma el següent JOIN a una comanda amb subconsultes:
-- SELECT empl.nombre, empl.cuota, dir.nombre, dir.cuota
-- FROM repventas AS empl JOIN repventas AS dir
-- ON empl.director = dir.num_empl
-- WHERE empl.cuota > dir.cuota;


-- 5.23- Transforma la següent consulta amb un ANY a una consulta amb un EXISTS i també en una altre consulta amb un ALL:
-- SELECT oficina FROM oficinas WHERE ventas*0.8 < ANY (SELECT ventas FROM repventas WHERE oficina_rep = oficina);


-- 5.24- Transforma la següent consulta amb un ALL a una consutla amb un EXISTS i també en una altre consulta amb un ANY:
-- SELECT num_clie FROM clientes WHERE limite_credito < ALL (SELECT importe FROM pedidos WHERE num_clie = clie);



-- 5.25- Transforma la següent consulta amb un EXISTS a una consulta amb un ALL i també a una altre consulta amb un ANY:
-- SELECT num_clie, empresa FROM clientes WHERE EXISTS (SELECT * FROM repventas WHERE rep_clie = num_empl AND edad BETWEEN 40 AND 50);



-- 5.26- Transforma la següent consulta amb subconsultes a una consulta sense subconsultes.
-- SELECT * FROM productos WHERE id_fab IN(SELECT fab FROM pedidos WHERE cant > 30) AND id_producto IN(SELECT producto FROM pedidos WHERE cant > 30);


-- 5.27- Transforma la següent consulta amb subconsultes a una consulta sense subconsultes.
-- SELECT num_empl, nombre FROM repventas WHERE num_empl = ANY ( SELECT rep_clie FROM clientes WHERE empresa LIKE '%Inc.');


-- 5.28- Transforma la següent consulta amb un IN a una consulta amb un EXISTS i també a una altre consulta amb un ALL.
-- SELECT num_empl, nombre FROM repventas WHERE num_empl IN(SELECT director FROM repventas);



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



-- 5.30- Transforma la següent consulta amb subconsultes a una consulta amb les mínimes subconsultes possibles.
-- SELECT num_clie, empresa, (SELECT nombre FROM repventas WHERE rep_clie = num_empl) AS rep_nombre FROM clientes WHERE rep_clie = ANY (SELECT num_empl FROM repventas WHERE ventas > (SELECT MAX(cuota) FROM repventas));


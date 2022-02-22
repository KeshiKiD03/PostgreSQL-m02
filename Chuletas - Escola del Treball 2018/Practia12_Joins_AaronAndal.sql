1. Per cada comanda que tenim, visualitzar la ciutat de l'oficina del representant de ventes  que l'ha fet,
 el nom del representant que l'ha fet, l''import i el nom de l'empresa que ha comprat el producte. Mostrar-ho
 ordenat pels 2 primers camps demanats.
 

SELECT o.ciudad, r.nombre, cl.empresa, pe.importe
FROM pedidos pe
JOIN clientes cl
ON pe.clie = cl.num_clie
JOIN repventas r
ON pe.rep = r.num_empl
LEFT JOIN oficinas o
ON r.oficina_rep = o.oficina
ORDER BY o.ciudad, r.nombre;
   ciudad    |    nombre     |      empresa      | importe  
-------------+---------------+-------------------+----------
 Atlanta     | Bill Adams    | Acme Mfg.         |   702.00
 Atlanta     | Bill Adams    | Acme Mfg.         |  3276.00
 Atlanta     | Bill Adams    | Acme Mfg.         | 27500.00
 Atlanta     | Bill Adams    | Acme Mfg.         |  4104.00
 Atlanta     | Bill Adams    | JCP Inc.          |  3745.00
 Chicago     | Dan Roberts   | Ian & Schmidt     | 22500.00
 Chicago     | Dan Roberts   | First Corp.       |  3978.00
 Chicago     | Dan Roberts   | Holm & Landis     |   150.00
 Chicago     | Paul Cruz     | JCP Inc.          |  2100.00
 Chicago     | Paul Cruz     | JCP Inc.          |   600.00
 Denver      | Nancy Angelli | Peter Brothers    |  2430.00
 Denver      | Nancy Angelli | Chen Associates   | 31350.00
 Denver      | Nancy Angelli | Peter Brothers    |   652.00
 Los Angeles | Larry Fitch   | Zetacorp          | 45000.00
 Los Angeles | Larry Fitch   | Orion Corp        |  7100.00
 Los Angeles | Larry Fitch   | Midwest Systems   |  1420.00
 Los Angeles | Larry Fitch   | Zetacorp          |  2925.00
 Los Angeles | Larry Fitch   | Midwest Systems   |   760.00
 Los Angeles | Larry Fitch   | Midwest Systems   |   776.00
 Los Angeles | Larry Fitch   | Midwest Systems   |   652.00
 Los Angeles | Sue Smith     | Orion Corp        | 15000.00
 Los Angeles | Sue Smith     | Rico Enterprises  |  3750.00
 Los Angeles | Sue Smith     | Fred Lewis Corp.  |  1896.00
 Los Angeles | Sue Smith     | Fred Lewis Corp.  |  2130.00
 New York    | Mary Jones    | Holm & Landis     |  1480.00
 New York    | Mary Jones    | Holm & Landis     |  5625.00
 New York    | Sam Clark     | Jones Mfg.        |  1458.00
 New York    | Sam Clark     | J.P. Sinclair     | 31500.00
             | Tom Snyder    | Ace International |   632.00
             | Tom Snyder    | Ace International | 22500.00
(30 rows)


2. Mostrar la quantitat de comandes que cada representant ha fet per client i l'import total de comandes que cada venedor ha venut a cada client.
 Mostrar la ciutat de l'oficina del representant de ventes, el nom del representant, 
 el nom del client, la quantitat de comandes representant-client i
  el total de l''import de les seves comandes per client.
 Ordenar resulats per ciutat, representant i client.
 
SELECT count(*), sum(pe.importe), o.ciudad, r.nombre, cl.empresa, count(*), sum(pe.importe)
FROM pedidos pe
JOIN repventas r
ON pe.rep = r.num_empl
JOIN clientes cl
ON pe.clie = cl.num_clie
JOIN oficinas o
ON r.oficina_rep = o.oficina
GROUP BY o.ciudad, r.num_empl, cl.num_clie
ORDER BY o.ciudad, r.nombre, cl.empresa;

--- CORREGIR
  

3. Mostrar la quantitat de representants de ventes que hi ha a la regió Este i  la quantitat de 
 representants de ventes que hi ha a la regió Oeste.
 
SELECT count(r.num_empl), o.region
FROM repventas r
JOIN oficinas o
ON r.oficina_rep = o.oficina
WHERE (o.region = 'Este' OR o.region = 'Oeste')
GROUP BY o.region;
 count | region 
-------+--------
     6 | Este
     3 | Oeste
(2 rows)


4. Mostrar la quantitat de representatns de ventes que hi ha a les diferents ciutats-oficines.
Mostrar la regió, la ciutat i el número de representants.



5. Mostrar la quantitat de representants de ventes que hi ha a les diferents ciutats-oficines
 i la quantitat de clients que tenen associats als representants d''aquestes ciutats-oficines.
Mostrar la regió, la ciutat, el número de representants i el número de clients.



6. Mostrar els noms de les empreses que han comprat productes de les fàbriques imm i rei amb un preu
de catàleg (no de compra) inferior a 80 o superior a 1000. Mostrar l'empresa' el fabricant, el codi
de producte i el preu


7. Mostrar les empreses amb un nom que no comenci ni per I ni per J que entre totes les seves compres ens han comprat per un total
superior a 20000



8. Mostrar les comandes que els clients han fet a representants de ventes que no són el que tenen assignat.
Mostrar l'import de la comanda, el nom del client, el nom del representant de ventes que ha fet 
la comanda i el nom del representant de ventes que el client té assignat.'



9. Mostrar les dades del producte (5 camps) del qual se n'han venut més unitats.'



10. Per cada representant de ventes mostrar el seu nom, el nom del seu cap i el nom del cap
de l''oficina on treballa.




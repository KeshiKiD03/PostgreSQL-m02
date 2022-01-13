--  CORRECCIO EXAMEN 1 UF2 25-02-2021 Cristian Condolo
-- ======================================================
-- 1. Mostrar els noms de les empreses amb un nom que no comenci ni per I ni oer J entre totes les seves compres ens han comprat per un total superior a 20000.
select empresa,sum(importe) from clientes
    join pedidos on num_clie=clie
where empresa not like 'I%' and empresa not like 'J%'
group by empresa
having sum(importe) > 20000;

      empresa      |   sum    
-------------------+----------
 Chen Associates   | 31350.00
 Orion Corp        | 22100.00
 Ace International | 23132.00
 Acme Mfg.         | 35582.00
 Zetacorp          | 47925.00
(5 rows)

select nombre,sum(importe) from repventas
    join pedidos on num_empl=rep
    join clientes on num_clie=clie
where nombre not like 'I%' and nombre not like 'J%'
group by nombre
having sum(importe) > 25000;

    nombre     |   sum    
---------------+----------
 Larry Fitch   | 58633.00
 Nancy Angelli | 34432.00
 Bill Adams    | 39327.00
 Dan Roberts   | 26628.00
 Sam Clark     | 32958.00
(5 rows)

-- 2. Mostrar les comandes que els clients han fet a representants de ventes que no són el que tenen assignat. Mostra l'import de la comanda, el nom del client,
-- el nom del representant de ventes que ha fet la comanda, la seva oficina si en té, el nom del representant de ventes que el client té assignat i la seva 
-- oficina si en té.
select num_pedido,importe,empresa,pedido.num_empl,pedido.oficina_rep,cliente.num_empl,cliente.oficina_rep from pedidos
    join clientes on clie=num_clie
    join repventas pedido on rep=pedido.num_empl
    join repventas cliente on rep_clie=cliente.num_empl
where not pedido.num_empl=cliente.num_empl;

 num_pedido | importe  |     empresa     | num_empl | oficina_rep | num_empl | oficina_rep 
------------+----------+-----------------+----------+-------------+----------+-------------
     113012 |  3745.00 | JCP Inc.        |      105 |          13 |      103 |          12
     113024 |  7100.00 | Orion Corp      |      108 |          21 |      102 |          21
     113069 | 31350.00 | Chen Associates |      107 |          22 |      103 |          12
     113055 |   150.00 | Holm & Landis   |      101 |          12 |      109 |          11
     113042 | 22500.00 | Ian & Schmidt   |      101 |          12 |      104 |          12
(5 rows)

-- 3. Mostrar tots els productes de catàleg de productes de l'empresa, amb tots els seus camps, ordenats de menor a major preu, el total d'unitats que s'han venut
-- i quants clients diferents els han comprat.
select productos.*,sum(cant),count(distinct clie) from productos
    left join pedidos on id_producto=producto and id_fab=fab
group by id_fab,id_producto
order by 4;

 id_fab | id_producto |    descripcion    | precio  | existencias | sum | count 
--------+-------------+-------------------+---------+-------------+-----+-------
 aci    | 4100x       | Ajustador         |   25.00 |          37 |  30 |     2
 imm    | 887h        | Soporte Riostra   |   54.00 |         223 |     |     0
 aci    | 41001       | Articulo Tipo 1   |   55.00 |         277 |     |     0
 aci    | 41002       | Articulo Tipo 2   |   76.00 |         167 |  64 |     2
 rei    | 2a45c       | V Stago Trinquete |   79.00 |         210 |  32 |     2
 aci    | 41003       | Articulo Tipo 3   |  107.00 |         207 |  35 |     1
 aci    | 41004       | Articulo Tipo 4   |  117.00 |         139 |  68 |     2
 qsa    | xk48a       | Reductor          |  117.00 |          37 |     |     0
 qsa    | xk48        | Reductor          |  134.00 |         203 |     |     0
 fea    | 112         | Cubierta          |  148.00 |         115 |  10 |     1
 bic    | 41672       | Plate             |  180.00 |           0 |     |     0
 bic    | 41089       | Retn              |  225.00 |          78 |     |     0
 fea    | 114         | Bancada Motor     |  243.00 |          15 |  16 |     2
 imm    | 887p        | Perno Riostra     |  250.00 |          24 |     |     0
 rei    | 2a44g       | Pasador Bisagra   |  350.00 |          14 |   6 |     1
 qsa    | xk47        | Reductor          |  355.00 |          38 |  28 |     3
 imm    | 887x        | Retenedor Riostra |  475.00 |          32 |     |     0
 bic    | 41003       | Manivela          |  652.00 |           3 |   2 |     2
 imm    | 773c        | Riostra 1/2-Tm    |  975.00 |          28 |   3 |     1
 imm    | 775c        | Riostra 1-Tm      | 1425.00 |           5 |  22 |     1
 imm    | 779c        | Riostra 2-Tm      | 1875.00 |           9 |   5 |     2
 aci    | 4100z       | Montador          | 2500.00 |          28 |  15 |     2
 aci    | 4100y       | Extractor         | 2750.00 |          25 |  11 |     1
 rei    | 2a44l       | Bisagra Izqda.    | 4500.00 |          12 |   7 |     1
 rei    | 2a44r       | Bisagra Dcha.     | 4500.00 |          12 |  15 |     2
(25 rows)

select productos.*,sum(cant),count(distinct rep) from productos
    left join pedidos on id_producto=producto and id_fab=fab
group by id_fab,id_producto
order by 4;

 id_fab | id_producto |    descripcion    | precio  | existencias | sum | count 
--------+-------------+-------------------+---------+-------------+-----+-------
 aci    | 4100x       | Ajustador         |   25.00 |          37 |  30 |     2
 imm    | 887h        | Soporte Riostra   |   54.00 |         223 |     |     0
 aci    | 41001       | Articulo Tipo 1   |   55.00 |         277 |     |     0
 aci    | 41002       | Articulo Tipo 2   |   76.00 |         167 |  64 |     2
 rei    | 2a45c       | V Stago Trinquete |   79.00 |         210 |  32 |     2
 aci    | 41003       | Articulo Tipo 3   |  107.00 |         207 |  35 |     1
 aci    | 41004       | Articulo Tipo 4   |  117.00 |         139 |  68 |     2
 qsa    | xk48a       | Reductor          |  117.00 |          37 |     |     0
 qsa    | xk48        | Reductor          |  134.00 |         203 |     |     0
 fea    | 112         | Cubierta          |  148.00 |         115 |  10 |     1
 bic    | 41672       | Plate             |  180.00 |           0 |     |     0
 bic    | 41089       | Retn              |  225.00 |          78 |     |     0
 fea    | 114         | Bancada Motor     |  243.00 |          15 |  16 |     2
 imm    | 887p        | Perno Riostra     |  250.00 |          24 |     |     0
 rei    | 2a44g       | Pasador Bisagra   |  350.00 |          14 |   6 |     1
 qsa    | xk47        | Reductor          |  355.00 |          38 |  28 |     2
 imm    | 887x        | Retenedor Riostra |  475.00 |          32 |     |     0
 bic    | 41003       | Manivela          |  652.00 |           3 |   2 |     2
 imm    | 773c        | Riostra 1/2-Tm    |  975.00 |          28 |   3 |     1
 imm    | 775c        | Riostra 1-Tm      | 1425.00 |           5 |  22 |     1
 imm    | 779c        | Riostra 2-Tm      | 1875.00 |           9 |   5 |     2
 aci    | 4100z       | Montador          | 2500.00 |          28 |  15 |     2
 aci    | 4100y       | Extractor         | 2750.00 |          25 |  11 |     1
 rei    | 2a44l       | Bisagra Izqda.    | 4500.00 |          12 |   7 |     1
 rei    | 2a44r       | Bisagra Dcha.     | 4500.00 |          12 |  15 |     2
(25 rows)

-- 4. Per cadascun del clients mostrar el nom del representant de ventes que té assignat, i a més a més les següents dades si existeixen: el nom del seu director
-- si en té, el nom del cap de l'oficina on treballa si té oficina i el nom del cap de l'oficina on treballa el seu director si té i si el seu director té oficina.

-- 5. Mostrar la quantitat de comandes que cada representant ha fet per client i el total d'unitat de producte de cada venedor ha venut a cada client. Mostrar la
-- regió de l'oficina del representant de ventes, el nom del representant, el nom del client, la quantitat de comandes representant-client i el total d'unitats de
-- producte per client. Ordenat resultats per regió, representant i client.
select ciudad,nombre,empresa,count(clie),sum(importe) from pedidos
    join repventas on rep=num_empl 
    left join oficinas on oficina_rep=oficina
    join clientes on clie=num_clie
group by nombre,ciudad,empresa
order by 1,2,3;

   ciudad    |    nombre     |      empresa      | count |   sum    
-------------+---------------+-------------------+-------+----------
 Atlanta     | Bill Adams    | Acme Mfg.         |     4 | 35582.00
 Atlanta     | Bill Adams    | JCP Inc.          |     1 |  3745.00
 Chicago     | Dan Roberts   | First Corp.       |     1 |  3978.00
 Chicago     | Dan Roberts   | Holm & Landis     |     1 |   150.00
 Chicago     | Dan Roberts   | Ian & Schmidt     |     1 | 22500.00
 Chicago     | Paul Cruz     | JCP Inc.          |     2 |  2700.00
 Denver      | Nancy Angelli | Chen Associates   |     1 | 31350.00
 Denver      | Nancy Angelli | Peter Brothers    |     2 |  3082.00
 Los Angeles | Larry Fitch   | Midwest Systems   |     4 |  3608.00
 Los Angeles | Larry Fitch   | Orion Corp        |     1 |  7100.00
 Los Angeles | Larry Fitch   | Zetacorp          |     2 | 47925.00
 Los Angeles | Sue Smith     | Fred Lewis Corp.  |     2 |  4026.00
 Los Angeles | Sue Smith     | Orion Corp        |     1 | 15000.00
 Los Angeles | Sue Smith     | Rico Enterprises  |     1 |  3750.00
 New York    | Mary Jones    | Holm & Landis     |     2 |  7105.00
 New York    | Sam Clark     | Jones Mfg.        |     1 |  1458.00
 New York    | Sam Clark     | J.P. Sinclair     |     1 | 31500.00
             | Tom Snyder    | Ace International |     2 | 23132.00
(18 rows)

-- 6. Mostrar la quantitat de representant de ventes que hi ha a les diferents ciutats-oficines i la quantitat de comandes que han fet aquestes representants d'aquestes
-- ciutats-oficines.
-- Mostrar la regió, la ciutat, el número de representants i el número de comandes.
select region,ciudad,count(distinct num_empl),count(*) from oficinas
    join repventas on oficina=oficina_rep
    join pedidos on num_empl=rep
group by region,ciudad;

 region |   ciudad    | count | count 
--------+-------------+-------+-------
 Este   | Atlanta     |     1 |     5
 Este   | Chicago     |     2 |     5
 Este   | New York    |     2 |     4
 Oeste  | Denver      |     1 |     3
 Oeste  | Los Angeles |     2 |    11
(5 rows)

select region,ciudad,count(distinct num_empl),count(distinct num_clie) from oficinas
    join repventas on oficina=oficina_rep
    join clientes on rep_clie=num_empl
group by region,ciudad;

 region |   ciudad    | count | count 
--------+-------------+-------+-------
 Este   | Atlanta     |     1 |     2
 Este   | Chicago     |     3 |     7
 Este   | New York    |     2 |     4
 Oeste  | Denver      |     1 |     1
 Oeste  | Los Angeles |     2 |     6
(5 rows)

-- 7. Mostrar la quantitat de representants de ventes que hi ha a la regió Este, la quantitat de representants de ventes que hi ha a la regió Oeste i la quantitat de 
-- representants que no estan assignats a cap regió. Nomes es vol comptar als representants que -no- tenen ciutat assignada o que tenen un 'N' minúscula o majúscula
-- al nom de la seva ciutat i tenen una 'm' o una 'a' minúscula o majúscula al seu nom.
select region, count(num_empl) from repventas
    left join oficinas on oficina_rep=oficina
where oficina_rep is null
or (ciudad ilike '%n%'  and (nombre like '%n%' or nombre ilike '%a%'))
group by region; region | count 
--------+-------
        |     1
 Este   |     3
 Oeste  |     2
(3 rows)

-- 8. Mostrar els noms de les empreses que han comprat productes de les fàbriques imm i rei amb un preu de catàleg ( no de compra ) inferior a 1500 o superior a 2000.
-- Mostrar l'empresa, el fabricant, el codi de producte, el preu, el nom del representant de ventes que ha fet la comanda i el nom del seu director.
select empresa,id_fab,id_producto,precio,empleado.nombre,director.nombre from pedidos
    join clientes on clie=num_clie
    join productos on producto=id_producto and fab=id_fab
    join repventas empleado on rep=empleado.num_empl
    join repventas director on empleado.director=director.num_empl
where (id_fab='imm' or id_fab='rei') and (precio < 1500 or precio > 2000);

      empresa      | id_fab | id_producto | precio  |    nombre     |   nombre    
-------------------+--------+-------------+---------+---------------+-------------
 Zetacorp          | rei    | 2a44r       | 4500.00 | Larry Fitch   | Sam Clark
 Zetacorp          | imm    | 773c        |  975.00 | Larry Fitch   | Sam Clark
 Chen Associates   | imm    | 775c        | 1425.00 | Nancy Angelli | Larry Fitch
 Ace International | rei    | 2a45c       |   79.00 | Tom Snyder    | Dan Roberts
 JCP Inc.          | rei    | 2a44g       |  350.00 | Paul Cruz     | Bob Smith
 Fred Lewis Corp.  | rei    | 2a45c       |   79.00 | Sue Smith     | Larry Fitch
 Ian & Schmidt     | rei    | 2a44r       | 4500.00 | Dan Roberts   | Bob Smith
(7 rows)

select empresa,id_fab,id_producto,precio,empleado.nombre,director.nombre from pedidos
    join clientes on clie=num_clie
    join productos on producto=id_producto and fab=id_fab
    join repventas empleado on rep=empleado.num_empl
    join repventas director on empleado.director=director.num_empl
where (id_fab='imm' or id_fab='rei') and (precio < 80 or precio > 1000);

      empresa      | id_fab | id_producto | precio  |    nombre     |   nombre    
-------------------+--------+-------------+---------+---------------+-------------
 Zetacorp          | rei    | 2a44r       | 4500.00 | Larry Fitch   | Sam Clark
 Chen Associates   | imm    | 775c        | 1425.00 | Nancy Angelli | Larry Fitch
 Ace International | rei    | 2a45c       |   79.00 | Tom Snyder    | Dan Roberts
 Rico Enterprises  | imm    | 779c        | 1875.00 | Sue Smith     | Larry Fitch
 Fred Lewis Corp.  | rei    | 2a45c       |   79.00 | Sue Smith     | Larry Fitch
 Holm & Landis     | imm    | 779c        | 1875.00 | Mary Jones    | Sam Clark
 Ian & Schmidt     | rei    | 2a44r       | 4500.00 | Dan Roberts   | Bob Smith
(7 rows)

-- 9. Per cadascuna de les comandes que tenim, visualitzar la regió de l'oficina del representant de ventes que ha fet la comanda ( si el representant no té 
-- oficina assignada aquest camp es mostrará viut ), el nom del representant que l'ha fet, l'import i el nom de l'empresa que ha comprat el producte. Mostrar-ho
-- ordenat pels 2 primers camps demanats.
select num_pedido,region,nombre,importe,empresa from pedidos
    join repventas on rep=num_empl 
    left join oficinas on oficina_rep=oficina
    join clientes on clie=num_clie
order by 2,3;

 num_pedido | region |    nombre     | importe  |      empresa      
------------+--------+---------------+----------+-------------------
     112983 | Este   | Bill Adams    |   702.00 | Acme Mfg.
     112963 | Este   | Bill Adams    |  3276.00 | Acme Mfg.
     112987 | Este   | Bill Adams    | 27500.00 | Acme Mfg.
     113027 | Este   | Bill Adams    |  4104.00 | Acme Mfg.
     113012 | Este   | Bill Adams    |  3745.00 | JCP Inc.
     113042 | Este   | Dan Roberts   | 22500.00 | Ian & Schmidt
     112968 | Este   | Dan Roberts   |  3978.00 | First Corp.
     113055 | Este   | Dan Roberts   |   150.00 | Holm & Landis
     113058 | Este   | Mary Jones    |  1480.00 | Holm & Landis
     113003 | Este   | Mary Jones    |  5625.00 | Holm & Landis
     113057 | Este   | Paul Cruz     |   600.00 | JCP Inc.
     112975 | Este   | Paul Cruz     |  2100.00 | JCP Inc.
     112961 | Este   | Sam Clark     | 31500.00 | J.P. Sinclair
     112989 | Este   | Sam Clark     |  1458.00 | Jones Mfg.
     113045 | Oeste  | Larry Fitch   | 45000.00 | Zetacorp
     113024 | Oeste  | Larry Fitch   |  7100.00 | Orion Corp
     113051 | Oeste  | Larry Fitch   |  1420.00 | Midwest Systems
     113007 | Oeste  | Larry Fitch   |  2925.00 | Zetacorp
     112992 | Oeste  | Larry Fitch   |   760.00 | Midwest Systems
     113049 | Oeste  | Larry Fitch   |   776.00 | Midwest Systems
     113013 | Oeste  | Larry Fitch   |   652.00 | Midwest Systems
     113069 | Oeste  | Nancy Angelli | 31350.00 | Chen Associates
     113062 | Oeste  | Nancy Angelli |  2430.00 | Peter Brothers
     112997 | Oeste  | Nancy Angelli |   652.00 | Peter Brothers
     113065 | Oeste  | Sue Smith     |  2130.00 | Fred Lewis Corp.
     112979 | Oeste  | Sue Smith     | 15000.00 | Orion Corp
     113048 | Oeste  | Sue Smith     |  3750.00 | Rico Enterprises
     112993 | Oeste  | Sue Smith     |  1896.00 | Fred Lewis Corp.
     110036 |        | Tom Snyder    | 22500.00 | Ace International
     113034 |        | Tom Snyder    |   632.00 | Ace International
(30 rows)

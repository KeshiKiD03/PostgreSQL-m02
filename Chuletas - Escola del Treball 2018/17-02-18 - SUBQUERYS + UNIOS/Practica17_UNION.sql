-- PRÀCTICA 17. WHERE + GROUP BY + JOIN + UNION
-- 1. Visualitzar tota la informació de cada client demanat i la quantitat de comanes que ha fet; la informació de les compres realitzades per cada client i el total d'import comprat per cada client. Si un client no ha comprat mai no s'han de mostrar els seus totals. La informació ha de sortir ordenada per codi de client. Els clients que es demanen són :
-- Clients amb un nom acabat amb 'International' o amb un nom acabat amb 'Corp.' o amb un nom que no comenci ni en 'A' ni en 'B' ni en 'C' ni en 'D' ni en 'O' ni en 'P' ni en 'J'.
training=# SELECT 'Client:' AS tip, clientes.*, count(*) AS comandes, null AS Import FROM clientes JOIN pedidos ON num_clie=clie 
WHERE (empresa NOT ILIKE 'a%' AND empresa NOT ILIKE 'b%' AND empresa NOT ILIKE 'c%' AND empresa NOT ILIKE 'd%' AND empresa NOT ILIKE 'o%' AND empresa NOT ILIKE 'p%' AND empresa NOT ILIKE 'j%') 
OR empresa ILIKE '%Corp.' OR empresa ILIKE '%International' GROUP BY num_clie 
UNION 
SELECT 'Compra:', clie, null, null, null, null, importe FROM clientes JOIN pedidos ON num_clie=clie 
WHERE (empresa NOT ILIKE 'a%' AND empresa NOT ILIKE 'b%' AND empresa NOT ILIKE 'c%' AND empresa NOT ILIKE 'd%' AND empresa NOT ILIKE 'o%' AND empresa NOT ILIKE 'p%' AND empresa NOT ILIKE 'j%') 
OR empresa ILIKE '%Corp.' OR empresa ILIKE '%International' 
UNION 
SELECT 'XXXTotal', clie, null, null, null, null, sum(importe) FROM clientes JOIN pedidos ON num_clie=clie 
WHERE (empresa NOT ILIKE 'a%' AND empresa NOT ILIKE 'b%' AND empresa NOT ILIKE 'c%' AND empresa NOT ILIKE 'd%' AND empresa NOT ILIKE 'o%' AND empresa NOT ILIKE 'p%' AND empresa NOT ILIKE 'j%') 
OR empresa ILIKE '%Corp.' OR empresa ILIKE '%International' GROUP BY clie 
ORDER BY 2,1;
   tip    | num_clie |      empresa      | rep_clie | limite_credito | comandes |  import  
----------+----------+-------------------+----------+----------------+----------+----------
 Client:  |     2102 | First Corp.       |      101 |       65000.00 |        1 |         
 Compra:  |     2102 |                   |          |                |          |  3978.00
 XXXTotal |     2102 |                   |          |                |          |  3978.00
 Client:  |     2106 | Fred Lewis Corp.  |      102 |       65000.00 |        2 |         
 Compra:  |     2106 |                   |          |                |          |  1896.00
 Compra:  |     2106 |                   |          |                |          |  2130.00
 XXXTotal |     2106 |                   |          |                |          |  4026.00
 Client:  |     2107 | Ace International |      110 |       35000.00 |        2 |         
 Compra:  |     2107 |                   |          |                |          |   632.00
 Compra:  |     2107 |                   |          |                |          | 22500.00
 XXXTotal |     2107 |                   |          |                |          | 23132.00
 Client:  |     2108 | Holm & Landis     |      109 |       55000.00 |        3 |         
 Compra:  |     2108 |                   |          |                |          |   150.00
 Compra:  |     2108 |                   |          |                |          |  5625.00
 Compra:  |     2108 |                   |          |                |          |  1480.00
 XXXTotal |     2108 |                   |          |                |          |  7255.00
 Client:  |     2112 | Zetacorp          |      108 |       50000.00 |        2 |         
 Compra:  |     2112 |                   |          |                |          | 45000.00
 Compra:  |     2112 |                   |          |                |          |  2925.00
 XXXTotal |     2112 |                   |          |                |          | 47925.00
 Client:  |     2113 | Ian & Schmidt     |      104 |       20000.00 |        1 |         
 Compra:  |     2113 |                   |          |                |          | 22500.00
 XXXTotal |     2113 |                   |          |                |          | 22500.00
 Client:  |     2118 | Midwest Systems   |      108 |       60000.00 |        4 |         
 Compra:  |     2118 |                   |          |                |          |   760.00
 Compra:  |     2118 |                   |          |                |          |   776.00
 Compra:  |     2118 |                   |          |                |          |  1420.00
 Compra:  |     2118 |                   |          |                |          |   652.00
 XXXTotal |     2118 |                   |          |                |          |  3608.00
 Client:  |     2120 | Rico Enterprises  |      102 |       50000.00 |        1 |         
 Compra:  |     2120 |                   |          |                |          |  3750.00
 XXXTotal |     2120 |                   |          |                |          |  3750.00
(32 rows)

-- 2. Visualitzar tota la informació de cada producte demanat i la quantitat de comandes fetes per aquell producte, la informació de les ventes fetes de cada producte i el total de l'import venut de 
-- cada producte. Si un producte no s'ha venut també ha de sortir. La informació ha d'estar ordenada per codi de fàbrica i codi de producte. Els productes que es demanen són : 
-- Productes de les fàbriques rei, aci i qsa amb preus entre 75 i 200.
training=# SELECT 'Producte:' AS tip, productos.*, count(fab) AS comandes, null AS Venedor, null AS Quantitat, null AS Import FROM productos LEFT JOIN pedidos ON id_fab=fab AND id_producto=producto 
WHERE (id_fab='rei' OR id_fab='aci' OR id_fab='qsa') AND (precio >=75 AND precio <=200) GROUP BY id_fab, id_producto 
UNION 
SELECT 'Venta:', id_fab, id_producto, null, null, null, clie, rep, cant, importe  FROM productos JOIN pedidos ON id_fab=fab AND id_producto=producto 
WHERE (id_fab='rei' OR id_fab='aci' OR id_fab='qsa') AND (precio >=75 AND precio <=200) 
UNION 
SELECT 'Total', id_fab, id_producto,null, null, null, null, null, null, sum(importe)  FROM productos JOIN pedidos ON id_fab=fab AND id_producto=producto 
WHERE (id_fab='rei' OR id_fab='aci' OR id_fab='qsa') AND (precio >=75 AND precio <=200) GROUP BY id_fab, id_producto 
ORDER BY id_fab, id_producto, tip;
    tip    | id_fab | id_producto |    descripcion    | precio | existencias | comandes | venedor | quantitat | import  
-----------+--------+-------------+-------------------+--------+-------------+----------+---------+-----------+---------
 Producte: | aci    | 41002       | Articulo Tipo 2   |  76.00 |         167 |        2 |         |           |        
 Venta:    | aci    | 41002       |                   |        |             |     2103 |     105 |        54 | 4104.00
 Venta:    | aci    | 41002       |                   |        |             |     2118 |     108 |        10 |  760.00
 Total     | aci    | 41002       |                   |        |             |          |         |           | 4864.00
 Producte: | aci    | 41003       | Articulo Tipo 3   | 107.00 |         207 |        1 |         |           |        
 Venta:    | aci    | 41003       |                   |        |             |     2111 |     105 |        35 | 3745.00
 Total     | aci    | 41003       |                   |        |             |          |         |           | 3745.00
 Producte: | aci    | 41004       | Articulo Tipo 4   | 117.00 |         139 |        3 |         |           |        
 Venta:    | aci    | 41004       |                   |        |             |     2103 |     105 |         6 |  702.00
 Venta:    | aci    | 41004       |                   |        |             |     2102 |     101 |        34 | 3978.00
 Venta:    | aci    | 41004       |                   |        |             |     2103 |     105 |        28 | 3276.00
 Total     | aci    | 41004       |                   |        |             |          |         |           | 7956.00
 Producte: | qsa    | xk48        | Reductor          | 134.00 |         203 |        0 |         |           |        
 Producte: | qsa    | xk48a       | Reductor          | 117.00 |          37 |        0 |         |           |        
 Producte: | rei    | 2a45c       | V Stago Trinquete |  79.00 |         210 |        2 |         |           |        
 Venta:    | rei    | 2a45c       |                   |        |             |     2107 |     110 |         8 |  632.00
 Venta:    | rei    | 2a45c       |                   |        |             |     2106 |     102 |        24 | 1896.00
 Total     | rei    | 2a45c       |                   |        |             |          |         |           | 2528.00
(18 rows)

-- 3. Visualitzar tota la informació de cada venedor demanat i la quantitat de comanes que ha fet; la informació de totes les ventes realitzades per cada venedor i el total d'import venut per cada venedor. Si un venedor no ha venut res també s'ha de mostrar. La informació ha de sortir ordenada per codi de venedor. Els venedors que es demanen són :
-- Venedors majors de 32 anys, amb un nom començat per 'S' or per 'B' o per 'N' 
training=# SELECT 'Info venedor' , num_empl , nombre , edad , oficina_rep , titulo , contrato , director , cuota , ventas , count(pedidos.*) , null , null , null , null , null , null , null
FROM repventas
LEFT JOIN pedidos ON num_empl = rep
WHERE edad > 32 AND (nombre LIKE 'S%' OR nombre LIKE 'B%' OR nombre LIKE 'N%')
GROUP BY num_empl
UNION
SELECT 'Info ventas' , rep , null , null , null , null , null , null , null , null , null , num_pedido , fecha_pedido , clie , fab , producto , cant , importe 
FROM repventas
LEFT JOIN pedidos ON num_empl = rep
WHERE edad > 32 AND (nombre LIKE 'S%' OR nombre LIKE 'B%' OR nombre LIKE 'N%')
UNION
SELECT 'Total ventas' , rep , null , null , null , null , null , null , null , null , null , null , null , null , null , null , null , sum(importe)
FROM repventas
LEFT JOIN pedidos ON num_empl = rep
WHERE edad > 32 AND (nombre LIKE 'S%' OR nombre LIKE 'B%' OR nombre LIKE 'N%')
GROUP BY rep
ORDER BY 2 , 1;
   ?column?   | num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   | count | ?column? |  ?column?  | ?column? | ?column? | ?column? | ?column? | ?column? 
--------------+----------+---------------+------+-------------+------------+------------+----------+-----------+-----------+-------+----------+------------+----------+----------+----------+----------+----------
 Info venedor |      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 |     4 |          |            |          |          |          |          |         
 Info ventas  |      102 |               |      |             |            |            |          |           |           |       |   113048 | 1990-02-10 |     2120 | imm      | 779c     |        2 |  3750.00
 Info ventas  |      102 |               |      |             |            |            |          |           |           |       |   112979 | 1989-10-12 |     2114 | aci      | 4100z    |        6 | 15000.00
 Info ventas  |      102 |               |      |             |            |            |          |           |           |       |   113065 | 1990-02-27 |     2106 | qsa      | xk47     |        6 |  2130.00
 Info ventas  |      102 |               |      |             |            |            |          |           |           |       |   112993 | 1989-01-04 |     2106 | rei      | 2a45c    |       24 |  1896.00
 Total ventas |      102 |               |      |             |            |            |          |           |           |       |          |            |          |          |          |          | 22776.00
 Info venedor |      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 |     0 |          |            |          |          |          |          |         
 Info venedor |      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 |     5 |          |            |          |          |          |          |         
 Info ventas  |      105 |               |      |             |            |            |          |           |           |       |   113027 | 1990-01-22 |     2103 | aci      | 41002    |       54 |  4104.00
 Info ventas  |      105 |               |      |             |            |            |          |           |           |       |   112983 | 1989-12-27 |     2103 | aci      | 41004    |        6 |   702.00
 Info ventas  |      105 |               |      |             |            |            |          |           |           |       |   112963 | 1989-12-17 |     2103 | aci      | 41004    |       28 |  3276.00
 Info ventas  |      105 |               |      |             |            |            |          |           |           |       |   112987 | 1989-12-31 |     2103 | aci      | 4100y    |       11 | 27500.00
 Info ventas  |      105 |               |      |             |            |            |          |           |           |       |   113012 | 1990-01-11 |     2111 | aci      | 41003    |       35 |  3745.00
 Total ventas |      105 |               |      |             |            |            |          |           |           |       |          |            |          |          |          |          | 39327.00
 Info venedor |      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 |     2 |          |            |          |          |          |          |         
 Info ventas  |      106 |               |      |             |            |            |          |           |           |       |   112989 | 1990-01-03 |     2101 | fea      | 114      |        6 |  1458.00
 Info ventas  |      106 |               |      |             |            |            |          |           |           |       |   112961 | 1989-12-17 |     2117 | rei      | 2a44l    |        7 | 31500.00
 Total ventas |      106 |               |      |             |            |            |          |           |           |       |          |            |          |          |          |          | 32958.00
 Info venedor |      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 |     3 |          |            |          |          |          |          |         
 Info ventas  |      107 |               |      |             |            |            |          |           |           |       |   113062 | 1990-02-24 |     2124 | fea      | 114      |       10 |  2430.00
 Info ventas  |      107 |               |      |             |            |            |          |           |           |       |   113069 | 1990-03-02 |     2109 | imm      | 775c     |       22 | 31350.00
 Info ventas  |      107 |               |      |             |            |            |          |           |           |       |   112997 | 1990-01-08 |     2124 | bic      | 41003    |        1 |   652.00
 Total ventas |      107 |               |      |             |            |            |          |           |           |       |          |            |          |          |          |          | 34432.00
 Info ventas  |          |               |      |             |            |            |          |           |           |       |          |            |          |          |          |          |         
 Total ventas |          |               |      |             |            |            |          |           |           |       |          |            |          |          |          |          |         
(25 rows)


-- 4. Visualitzar tota la informació de cada oficina demanada i el número de venedors que té; la informació de tots els venedors assignats a la oficina i el número de cliens assignat a cada venedor; i la informació de tots els clients assignats a cada venedor. Si una oficina no té venedors també ha de sortir. Si un venedor no té clients assignats ha de sortir igualment. La informació ha de sortir ordenada per codi d'oficina i codi de venedor. Les oficines que es demanen són:
-- Oficines de ciutats que continguin alguna 'a' o alguna 'e' i amb un objectiu més gran de 300.000 
training=# SELECT 'Oficina:' AS tip, oficinas.*,  count(*) AS venedors,0 AS venedor, null AS nomvenedor, null AS numclient, 0 AS codclient, null AS nomclient FROM oficinas 
LEFT JOIN repventas ON oficina=oficina_rep WHERE (ciudad ILIKE '%a%' OR ciudad ILIKE '%e%') AND objetivo > 300000 GROUP BY oficina 
UNION 
SELECT 'Teballador:', oficina, null, null, null, null, null, null, num_empl, nombre, count(*), null, null FROM oficinas 
LEFT JOIN repventas ON oficina=oficina_rep LEFT JOIN clientes on num_empl= rep_clie WHERE (ciudad ILIKE '%a%' OR ciudad ILIKE '%e%') AND objetivo > 300000 GROUP BY oficina, num_empl 
UNION 
SELECT 'Client:', oficina , null, null, null, null, null, null, num_empl, null, null, num_clie, empresa FROM oficinas LEFT JOIN repventas ON oficina=oficina_rep 
LEFT JOIN clientes on num_empl= rep_clie WHERE (ciudad ILIKE '%a%' OR ciudad ILIKE '%e%') and objetivo > 300000 
ORDER BY 2,9, 1; 
     tip     | oficina |   ciudad    | region | dir | objetivo  |  ventas   | venedors | venedor | nomvenedor  | numclient | codclient |    nomclient     
-------------+---------+-------------+--------+-----+-----------+-----------+----------+---------+-------------+-----------+-----------+------------------
 Oficina:    |      11 | New York    | Este   | 106 | 575000.00 | 692637.00 |        2 |       0 |             |           |         0 | 
 Client:     |      11 |             |        |     |           |           |          |     106 |             |           |      2117 | J.P. Sinclair
 Client:     |      11 |             |        |     |           |           |          |     106 |             |           |      2101 | Jones Mfg.
 Teballador: |      11 |             |        |     |           |           |          |     106 | Sam Clark   |         2 |           | 
 Client:     |      11 |             |        |     |           |           |          |     109 |             |           |      2119 | Solomon Inc.
 Client:     |      11 |             |        |     |           |           |          |     109 |             |           |      2108 | Holm & Landis
 Teballador: |      11 |             |        |     |           |           |          |     109 | Mary Jones  |         2 |           | 
 Oficina:    |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00 |        3 |       0 |             |           |         0 | 
 Client:     |      12 |             |        |     |           |           |          |     101 |             |           |      2105 | AAA Investments
 Client:     |      12 |             |        |     |           |           |          |     101 |             |           |      2102 | First Corp.
 Client:     |      12 |             |        |     |           |           |          |     101 |             |           |      2115 | Smithson Corp.
 Teballador: |      12 |             |        |     |           |           |          |     101 | Dan Roberts |         3 |           | 
 Client:     |      12 |             |        |     |           |           |          |     103 |             |           |      2109 | Chen Associates
 Client:     |      12 |             |        |     |           |           |          |     103 |             |           |      2111 | JCP Inc.
 Client:     |      12 |             |        |     |           |           |          |     103 |             |           |      2121 | QMA Assoc.
 Teballador: |      12 |             |        |     |           |           |          |     103 | Paul Cruz   |         3 |           | 
 Client:     |      12 |             |        |     |           |           |          |     104 |             |           |      2113 | Ian & Schmidt
 Teballador: |      12 |             |        |     |           |           |          |     104 | Bob Smith   |         1 |           | 
 Oficina:    |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00 |        1 |       0 |             |           |         0 | 
 Client:     |      13 |             |        |     |           |           |          |     105 |             |           |      2103 | Acme Mfg.
 Client:     |      13 |             |        |     |           |           |          |     105 |             |           |      2122 | Three-Way Lines
 Teballador: |      13 |             |        |     |           |           |          |     105 | Bill Adams  |         2 |           | 
 Oficina:    |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00 |        2 |       0 |             |           |         0 | 
 Client:     |      21 |             |        |     |           |           |          |     102 |             |           |      2106 | Fred Lewis Corp.
 Client:     |      21 |             |        |     |           |           |          |     102 |             |           |      2114 | Orion Corp
 Client:     |      21 |             |        |     |           |           |          |     102 |             |           |      2120 | Rico Enterprises
 Client:     |      21 |             |        |     |           |           |          |     102 |             |           |      2123 | Carter & Sons
 Teballador: |      21 |             |        |     |           |           |          |     102 | Sue Smith   |         4 |           | 
 Client:     |      21 |             |        |     |           |           |          |     108 |             |           |      2112 | Zetacorp
 Client:     |      21 |             |        |     |           |           |          |     108 |             |           |      2118 | Midwest Systems
 Teballador: |      21 |             |        |     |           |           |          |     108 | Larry Fitch |         2 |           | 
(31 rows)

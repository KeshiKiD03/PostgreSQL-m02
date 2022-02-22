-- Aaron Andal
-- Examen M02 JOIN
-- 19/01/18
-- 1

training=# SELECT o.region, re.num_empl, re.nombre, cl.num_clie, cl.empresa, sum(pe.cant) AS "Ha comprat en total"
FROM oficinas o
RIGHT JOIN repventas re
ON o.oficina = re.oficina_rep
RIGHT JOIN clientes cl
ON re.num_empl = cl.rep_clie
LEFT JOIN pedidos pe
ON cl.num_clie = pe.clie
GROUP BY o.region, re.num_empl, cl.num_clie;
 region | num_empl |    nombre     | num_clie |      empresa      | Ha comprat en total 
--------+----------+---------------+----------+-------------------+---------------------
 Este   |      109 | Mary Jones    |     2108 | Holm & Landis     |                  19
 Oeste  |      102 | Sue Smith     |     2123 | Carter & Sons     |                    
 Oeste  |      108 | Larry Fitch   |     2112 | Zetacorp          |                  13
 Este   |      109 | Mary Jones    |     2119 | Solomon Inc.      |                    
 Este   |      103 | Paul Cruz     |     2111 | JCP Inc.          |                  65
 Oeste  |      102 | Sue Smith     |     2120 | Rico Enterprises  |                   2
 Oeste  |      102 | Sue Smith     |     2106 | Fred Lewis Corp.  |                  30
 Oeste  |      107 | Nancy Angelli |     2124 | Peter Brothers    |                  11
 Este   |      106 | Sam Clark     |     2101 | Jones Mfg.        |                   6
 Este   |      101 | Dan Roberts   |     2115 | Smithson Corp.    |                    
 Oeste  |      108 | Larry Fitch   |     2118 | Midwest Systems   |                  17
 Este   |      104 | Bob Smith     |     2113 | Ian & Schmidt     |                   5
        |      110 | Tom Snyder    |     2107 | Ace International |                  17
 Oeste  |      102 | Sue Smith     |     2114 | Orion Corp        |                  26
 Este   |      105 | Bill Adams    |     2103 | Acme Mfg.         |                  99
 Este   |      105 | Bill Adams    |     2122 | Three-Way Lines   |                    
 Este   |      106 | Sam Clark     |     2117 | J.P. Sinclair     |                   7
 Este   |      103 | Paul Cruz     |     2121 | QMA Assoc.        |                    
 Este   |      101 | Dan Roberts   |     2102 | First Corp.       |                  34
 Este   |      103 | Paul Cruz     |     2109 | Chen Associates   |                  22
 Este   |      101 | Dan Roberts   |     2105 | AAA Investments   |                    
(21 rows)

-- La empresa Ace International amb num_clie 2107 té assignat comn  REPVENTAS a Tom Snyder amb num_empl 110 en la cual no té cap oficina assignada, asi mateix no està en cap regió, per això no surt la regió, tanmateix fem que aparegui el Tom Snyder amb el RIGHT JOIN a repventas i a clientes. També fem un LEFT JOIN de clientes perqué hi han empreses (clients) que no han han fet comandes.


-- 2

-- part 1

SELECT re.num_empl, re.nombre, dirofi.num_empl, dirofi.nombre AS "Cap de l oficina"
FROM oficinas o  
RIGHT JOIN repventas re
ON o.oficina = re.oficina_rep
LEFT JOIN repventas dirofi
ON o.dir = dirofi.num_empl;
 num_empl |    nombre     | num_empl | Cap de l oficina 
----------+---------------+----------+------------------
      105 | Bill Adams    |      105 | Bill Adams
      109 | Mary Jones    |      106 | Sam Clark
      102 | Sue Smith     |      108 | Larry Fitch
      106 | Sam Clark     |      106 | Sam Clark
      104 | Bob Smith     |      104 | Bob Smith
      101 | Dan Roberts   |      104 | Bob Smith
      110 | Tom Snyder    |          | 
      108 | Larry Fitch   |      108 | Larry Fitch
      103 | Paul Cruz     |      104 | Bob Smith
      107 | Nancy Angelli |      108 | Larry Fitch
(10 rows)

-- part 2

SELECT re.num_empl, re.nombre, dir.num_empl, dir.nombre AS "Cap de l oficina", dirrep.num_empl, dirrep.nombre "Cap del venedor"
FROM oficinas o  
RIGHT JOIN repventas re
ON o.oficina = re.oficina_rep
LEFT JOIN repventas dir
ON o.dir = dir.num_empl
JOIN repventas dirrep
ON re.director = dirrep.num_empl;
 num_empl |    nombre     | num_empl | Cap de l oficina | num_empl | Cap del venedor 
----------+---------------+----------+------------------+----------+-----------------
      105 | Bill Adams    |      105 | Bill Adams       |      104 | Bob Smith
      109 | Mary Jones    |      106 | Sam Clark        |      106 | Sam Clark
      102 | Sue Smith     |      108 | Larry Fitch      |      108 | Larry Fitch
      106 | Sam Clark     |      106 | Sam Clark        |          | 
      104 | Bob Smith     |      104 | Bob Smith        |      106 | Sam Clark
      101 | Dan Roberts   |      104 | Bob Smith        |      104 | Bob Smith
      110 | Tom Snyder    |          |                  |      101 | Dan Roberts
      108 | Larry Fitch   |      108 | Larry Fitch      |      106 | Sam Clark
      103 | Paul Cruz     |      104 | Bob Smith        |      104 | Bob Smith
      107 | Nancy Angelli |      108 | Larry Fitch      |      108 | Larry Fitch
(10 rows)

-- part 3

SELECT re.num_empl, re.nombre, dir.num_empl, dir.nombre AS "Cap de l oficina", dirrep.num_empl, dirrep.nombre "Cap del venedor", sum(pe.importe)
FROM oficinas o  
RIGHT JOIN repventas re
ON o.oficina = re.oficina_rep
LEFT JOIN repventas dir
ON o.dir = dir.num_empl
LEFT JOIN repventas dirrep
ON re.director = dirrep.num_empl
JOIN pedidos pe
ON pe.rep = re.num_empl
JOIN productos pr 
ON pe.fab = pr.id_fab AND pe.producto = pr.id_producto
WHERE pr.id_fab = 'aci' AND pr.precio > 100 AND pr.descripcion ILIKE '%a%a%'
GROUP BY re.num_empl, dir.num_empl, dirrep.num_empl;


-- 3 

SELECT pr.descripcion, cl.empresa, o.oficina, o.ciudad AS "Ciutat del repventa que ha fet la comanda", re.num_empl, re.nombre AS "Repventa que ha fet la comanda", dirofi.num_empl, dirofi.nombre AS "Cap de l oficina", orep.oficina, orep.ciudad AS "Ciutat del repventa que té el client", dirrep.nombre "Director del repventa"
FROM pedidos pe
JOIN productos pr
ON pe.fab = pr.id_fab AND pe.producto = pr.id_producto
JOIN clientes cl
ON pe.clie = cl.num_clie
JOIN repventas re
ON re.num_empl = pe.rep
JOIN oficinas o
ON re.oficina_rep = o.oficina
LEFT JOIN repventas dirofi
ON o.dir = dirofi.num_empl
JOIN





-- 4 

SELECT cl.num_clie, cl.empresa, pr.descripcion
FROM clientes cl
JOIN pedidos pe
ON cl.num_clie = pe.clie
JOIN productos pr
ON pe.fab = pr.id_fab AND pe.producto = pr.id_producto
WHERE (cl.empresa LIKE '%e%' OR cl.empresa LIKE '%p%' OR cl.empresa LIKE '%r%') AND NOT (cl.empresa LIKE '%u%' OR cl.empresa LIKE '%t%');
 num_clie |     empresa      |    descripcion    
----------+------------------+-------------------
     2117 | J.P. Sinclair    | Bisagra Izqda.
     2101 | Jones Mfg.       | Bancada Motor
     2103 | Acme Mfg.        | Articulo Tipo 4
     2103 | Acme Mfg.        | Articulo Tipo 4
     2114 | Orion Corp       | Reductor
     2114 | Orion Corp       | Montador
     2103 | Acme Mfg.        | Articulo Tipo 2
     2106 | Fred Lewis Corp. | V Stago Trinquete
     2106 | Fred Lewis Corp. | Reductor
     2103 | Acme Mfg.        | Extractor
(10 rows)



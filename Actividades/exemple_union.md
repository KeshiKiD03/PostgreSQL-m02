**Feu una consulta que mostri les oficines que tinguin un treballador que sigui director de Vendes i les oficines que siguin de la regió ‘Est’ i ordenades de manera ascendent:**
training=> SELECT oficina FROM oficines WHERE regio = 'Est'
UNION
SELECT oficina_rep FROM rep_vendes WHERE carrec = 'Dir Vendes' ORDER BY 1;
 oficina
---------
      11
      12
      13
      21
(4 rows)

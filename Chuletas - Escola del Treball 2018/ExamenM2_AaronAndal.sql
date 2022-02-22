-- EXAMEN M02 BASE DE DADES
-- 30/10/17
-- AARON ANDAL

-- 1

SELECT oficina, ventas, objetivo, ciudad FROM oficinas WHERE ventas > objetivo AND (ciudad ILIKE '%a%' AND ciudad ILIKE '%n%');


-- 2

SELECT nombre, oficina_rep FROM repventas WHERE (nombre LIKE 'S%' OR nombre LIKE 'B%') AND oficina_rep IN (21, 11, 12);

SELECT nombre, oficina_rep FROM repventas WHERE (nombre LIKE 'S%' OR nombre LIKE 'B%') AND (oficina_rep = 21 OR oficina_rep = 11 OR oficina_rep = 12);

-- 3 

SELECT id_fab, descripcion, existencias, precio FROM productos WHERE (id_fab = 'rei' OR id_fab = 'aci' OR id_fab = 'bic') AND existencias < 10 AND precio > 600;

-- 4 

SELECT id_fab, descripcion, precio FROM productos WHERE (id_fab = 'rei' AND precio BETWEEN 600 AND 700) OR (id_fab = 'aci' AND precio BETWEEN 700 AND 800);

SELECT id_fab, descripcion, precio FROM productos WHERE (id_fab = 'rei' AND precio >= 600 AND precio <= 700) OR (id_fab = 'aci' AND precio >= 700 AND precio <= 800);

Exercicis SQL PRÀCTICA 2

1. SELECT oficina, ciudad, objetivo, ventas FROM oficinas;

2. SELECT * FROM oficinas WHERE region = ‘Este’;

3. SELECT objetivo, ciudad, ventas FROM oficinas WHERE region = ‘Este’ ORDER BY ciudad;

4. SELECT ciudad, objetivo, ventas FROM oficinas WHERE ventas > objetivo;

5. SELECT nombre, cuota, ventas, num_empl FROM repventas WHERE num_empl = 107;

6. SELECT nombre, contrato, ventas FROM repventas WHERE ventas > 300000;

7. SELECT * FROM repventas WHERE num_empl = 104;

8. SELECT * nombre, contrato FROM repventas WHERE contrato < ‘1998-01-01’;

9. SELECT oficina, ciudad FROM oficinas WHERE NOT oficina != 800000;

10. SELECT empresa, limite_credito FROM clientes WHERE num_clie = 2107;

11. SELECT id_fab AS "Identificador fabricant", id_producto AS "Identificador producte", descripcion AS "Descripcio del producte" FROM productos;

12. SELECT id_fab, id_producto, descripcion FROM productos WHERE id_fab LIKE ‘%i’;
	SELECT id_fab AS "Identificador fabricant", id_producto AS "Identificador producte", descripcion AS "Descripcio del producte" FROM productos WHERE id_fab LIKE '%i';

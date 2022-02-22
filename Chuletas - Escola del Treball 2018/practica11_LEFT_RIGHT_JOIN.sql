-- Escriu 20 parelles de selects, el primer de la parella serà un SELECT  sense LEFT JOIN ni RIGHT JOIN que com a resultat dongui menys registres que el mateix SELECT amb LEFT JOIN, aquest últim serà el segon SELECT de la parella
-- Explica perquè els resultats són diferents.

SELECT num.empl, nombre FROM repventas WHERE oficina_rep IS NOT NULL;

SELECT re.num_empl, re.nombre, o.oficina FROM repventas re LEFT JOIN oficinas o ON re.oficina_rep = o.oficina;

----------

SELECT 

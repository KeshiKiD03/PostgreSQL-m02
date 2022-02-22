COUNT
    Compta el nombre de registres

    Nombre de venedors amb codi d''empleat
        SELECT COUNT(num_empl) FROM repventas;
        
    Nombre de venedors amb nom d''empleat
        SELECT COUNT(nombre) FROM repventas;

    Nombre de venedors
        SELECT COUNT(*) FROM repventas;

    Nombre de venedors amb oficina associada
        SELECT COUNT(oficina_rep) FROM repventas;

    Nombre de venedors que tenen la lletra a (majúscula o minúscula) en el seu nom
        SELECT COUNT(*) FROM repventas
        WHERE nombre ILIKE '%a%';


SUM
    Suma els valors de tots els camps de la columna que especifiquem

    Suma de les vendes de totes les oficines
        SELECT SUM(ventas) FROM oficinas;

    Suma de les vendes i suma dels objetius de totes les oficines
        SELECT SUM(ventas), SUM(objetivo) FROM oficinas;
        
    Suma de les vendes de totes aquelles oficines que les seves vendes siguin inferiors a 500000
        SELECT SUM(ventas)                              
        FROM oficinas
        WHERE ventas < 500000;

AVG
    Calcula la mitjana aritmètica de tots els camps de la columna que especifiquem

    Calcula la mitjana de les vendes de totes les oficines
        SELECT AVG(ventas) FROM oficinas;

    Calcula la mitjana de les vendes i la mitjana dels objetius de totes les oficines
        SELECT AVG(ventas), AVG(objetivo) FROM oficinas;
            
    Calcula la mitjana aritmètica de les vendes de totes aquelles oficines que les seves vendes siguin inferiors a 500000
        SELECT AVG(ventas)                              
        FROM oficinas
        WHERE ventas < 500000;

MIN, MAX
    Mostra les vendes de l''oficina que ha tingut menys vendes
        SELECT MIN(ventas) FROM oficinas;
        
    Mostra les vendes de l''oficina que ha tingut més vendes
        SELECT MAX(ventas) FROM oficinas;
      
    Mostra les vendes de l''oficina que ha tingut menys vendes i de les que ha obtingut més vendes
        SELECT MIN(ventas), MAX(ventas) FROM oficinas;

GROUP BY
    Calcula la funció resum agrupant les files amb el mateix valor del camp indicat.
    
    Calcula el diners gastats per cada client
        SELECT clie, SUM(importe)
        FROM pedidos;
        
        Dóna error!!!
        
        SELECT clie, SUM(importe)
        FROM pedidos
        GROUP BY clie;
        

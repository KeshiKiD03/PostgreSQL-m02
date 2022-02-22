[INNER] JOIN
    Retorna les files de les dues taules que tenen coincidència

    Relació entre dues taules: Llistar totes les comandes mostrant el seu número, import, número de clienti límit de crèdit del client.    
    SELECT num_pedido, importe, empresa, limite_credito
      FROM pedidos, clientes
     WHERE clie = num_clie;
     
     SELECT num_pedido, importe, empresa, limite_credito
      FROM pedidos JOIN clientes
        ON clie = num_clie;
     
    Relació entre dues taules: Llistar els venedors que tenen assignada una oficina i la ciutat i regió on treballen
    SELECT nombre, ciudad, region
      FROM repventas, oficinas
     WHERE oficina_rep = oficina;
    
    SELECT nombre, ciudad, region
      FROM repventas JOIN oficinas
        ON oficina_rep = oficina;
    
    Relació entre dues taules i una condició: Llistar totes les comandes mostrant el seu número, import, número de client i límit de crèdit del client on el límit de crèdit del client sigui superior a 40000
    SELECT num_pedido, importe, empresa, limite_credito
      FROM pedidos, clientes
     WHERE clie = num_clie
       AND limite_credito > 40000;
       
    SELECT num_pedido, importe, empresa, limite_credito
      FROM pedidos JOIN clientes
        ON clie = num_clie
     WHERE limite_credito > 40000;
        
    Llistar les comandes superiors a 25000 (número de comanda i import), mostrant el nom del client que va fer la comanda i el nom del venedor assignat a aquest client
    SELECT num_pedido, importe, empresa, nombre
      FROM pedidos, clientes, repventas
     WHERE clie = num_clie
       AND rep_clie = num_empl
       AND importe > 25000;
       
     SELECT num_pedido, importe, empresa, nombre
      FROM pedidos
      JOIN clientes ON clie = num_clie
      JOIN repventas ON rep_clie = num_empl
     WHERE importe > 25000;
     

LEFT [OUTER] JOIN
    Retorna totes les files de la taula esquerra i les coincidències de la taula dreta. Si no hi ha coincidència es mostra NULL.
    
    Llistar tots els venedors i la ciutat i regió on treballen, si s escau
    SELECT nombre, ciudad, region
      FROM repventas LEFT JOIN oficinas
        ON oficina_rep = oficina;

RIGHT [OUTER] JOIN
    Retorna totes les files de la taula dreta i les coincidències de la taula esquerra. Si no hi ha coincidència es mostra NULL.
    
    Llistar tots els venedors i la ciutat i regió on treballen, si s escau
    SELECT nombre, ciudad, region
      FROM oficinas RIGHT JOIN repventas
        ON oficina_rep = oficina;

FULL [OUTER] JOIN
    Retorna totes les files de les dues taules. Si no hi ha coincidència es mostra NULL.
    
    Llistar totes les comandes amb la descripció dels seus productes. Si un producte no està a cap comanda també hem de llistar la seva descripció.
    SELECT num_pedido, descripcion
      FROM pedidos FULL JOIN productos
      ON id_fab=fab AND id_producto=producto;
      
    Amb aquesta consulta veiem una inconsistència en les dades. La saps trobar?
    
taula.camp
    Podem dessignar de quina taula és cada camp
    
    Llistar les oficines amb les seves ciutats i les seves vendes així com el director de l oficina i les ventes del director.
    SELECT ciudad, oficinas.ventas, nombre, repventas.ventas
      FROM oficinas, repventas
     WHERE dir = num_empl;
     
    SELECT ciudad, oficinas.ventas, nombre, repventas.ventas
      FROM oficinas JOIN repventas
        ON dir = num_empl;
     
    SELECT oficinas.ciudad, oficinas.ventas, repventas.nombre, repventas.ventas
      FROM oficinas, repventas
    WHERE oficinas.dir = repventas.num_empl;
    
    SELECT oficinas.ciudad, oficinas.ventas, repventas.nombre, repventas.ventas
      FROM oficinas JOIN repventas
        ON oficinas.dir = repventas.num_empl;
    
Alias dels noms de taula
    SELECT ciudad, o.ventas, nombre, r.ventas
      FROM oficinas o, repventas r
     WHERE dir = num_empl;
     
     SELECT ciudad, o.ventas, nombre, r.ventas
      FROM oficinas o JOIN repventas r
        ON dir = num_empl;
     
    SELECT o.ciudad, o.ventas, r.nombre, r.ventas
      FROM oficinas o, repventas r
     WHERE o.dir = r.num_empl;

    SELECT o.ciudad, o.ventas, r.nombre, r.ventas
      FROM oficinas o JOIN repventas r
        ON o.dir = r.num_empl;

-- 1 ¿Quina es la quota mitjana y las vendes mitjanas de tots els empleats?

select num_empl,avg(cuota),avg(ventas) from repventas group by num_empl;

-- 2 Trobar l'import mitjà de comandes,l'import total de comandes i el preu mig de venda.

select avg(importe),sum(importe),avg(importe/cant) from pedidos;

-- 3 Trobar el preu mitjà dels productes del fabricant aci.

select avg(precio) from productos where id_fab='aci';

-- 4 Quin es l'import total de les comandes realizades per l'empleat amb identificador 105?

select sum(importe) from pedidos where rep=105;

-- 5 Trobar la data en que es va realitzar la primera comando.

select min(fecha_pedido) from pedidos;

-- 6 Trobar quantes comandes hi ha de més 25000.

select count(*) from pedidos where importe>25000;

-- 7 Llistar quants empleats estan assignats a cada oficina, indicar el identificador d'oficina, i quants té assignats.

select oficina_rep,count(*) from repventas where oficina_rep is not null group by oficina_rep;

-- 8 Per a cada empleat, identificador, import venut a cada client, identificador de client.

select rep,sum(importe),clie from pedidos group by rep,clie;

-- 9 Per a cada empleat on les comandes sumin més de 30000, trobar l'import mitjà de cada comanda.

select rep,avg(importe) from pedidos group by rep having sum(importe)>30000;

-- 10 Quina quantitat d'oficines tenen empleats amb vendes superiors a la seva quota.

select count(distinct oficina_rep) from repventas where oficina_rep is not null and ventas>cuota;



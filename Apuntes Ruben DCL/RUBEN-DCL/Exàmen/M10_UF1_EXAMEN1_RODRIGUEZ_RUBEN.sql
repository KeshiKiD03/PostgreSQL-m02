PRIMERA PART: DCL. DATA CONTROL LANGUAGE.

TENIM

Una base de dades d’una llibreria. Amb dues taules LLIBRES i PROVEIDORS. (NO CAL CREAR-LES!)

EXPLICA quina configuració ha de tenir Postgres i quines sentències s’han d’executar per obtenir el següent escenari. Utilitzeu noms que siguin descriptius.

FITXERS QUE UTILITZAREM:
/etc/postgresql/13/main/pg_hba.conf
/var/lib/pgsql/data/postgresql.conf

Els usuaris guardaran les seves contrasenyes al postgresql.

Dins del fitxer postgresql.conf:
listen_addresses='*'

Reiniciem:
$ systemctl restart postgresql

Un usuari administrador de la base de dades:

    Ha de poder veure i modificar totes les taules.  
    Ha de poder crear nous usuaris i assignar els permisos corresponents.
    llibreria=# CREATE ROLE administrador WITH OPTION superuser createrole;
    lliberia=# GRANT SELECT, UPDATE, INSERT, DELETE ON llibres,proveidors TO administrador;
    
    (AQUESTES DUES LÍNES RESPONEN ALS 2 ENUNCIATS)
    
    Només pot treballar en local i es connectarà amb l’usuari de sistema.
    Dins del fitxer pg_hba.conf:
	host    llibreria     administrador        10.200.243.224/32     ident
	host    llibreria     all                         0.0.0.0/0      reject

	Reiniciem:
	$ systemctl restart postgresql

Un grup d’usuaris de manteniment (que tindrà dos usuaris, els dos llibreters)

    Han de poder veure i modificar totes les taules
    llibreria=# CREATE ROLE manteniment;
	llibreria=# CREATE USER manteniment1 WITH PASSWORD 'manteniment1';
	llibreria=# CREATE USER manteniment2 WITH PASSWORD 'manteniment2';
	llibreria=# GRANT manteniment TO manteniment1,manteniment2;
	llibreria=# GRANT SELECT, UPDATE, INSERT, DELETE ON llibres,proveidors TO manteniment;

    S’han de poder connectar des de qualsevol ordinador de la llibreria (192.168.30.*)
    Dins del fitxer pg_hba.conf:
	host    llibreria     +manteniment        192.168.30.0/24       md5
	host    llibreria     all                      0.0.0.0/0        reject

	Reiniciem:
	$ systemctl restart postgresql


Un grup d’usuaris de consulta (de moment tindrà 2 usuaris)

    Només poden consultar la taula de llibres
    llibreria=# CREATE ROLE consulta;
	llibreria=# CREATE USER user1 WITH PASSWORD 'user1';
	llibreria=# CREATE USER user2 WITH PASSWORD 'user2';
	llibreria=# GRANT consulta TO user1,user2;
	llibreria=# GRANT SELECT ON llibres TO manteniment;
	
    S’han de poder connectar des de qualsevol ordinador de la llibreria (192.168.30.*)
    No cal que demani password
    Dins del fitxer pg_hba.conf:
    host    llibreria     +consulta           192.168.30.0/24       trust
	host    llibreria     all                      0.0.0.0/0        reject

	Reiniciem:
	$ systemctl restart postgresql

L'usuari de l'aplicació web:

    Només pot consultar la taula de llibres
    llibreria=# CREATE USER web WITH PASSWORD 'web';
	llibreria=# GRANT SELECT ON llibres TO web;

    Només s'ha de poder connectar des de l'ordinador que té el servidor web. (192.168.30.21).
    Dins del fitxer pg_hba.conf:
	host    llibreria     web        192.168.30.21/32     md5
	host    llibreria     all              0.0.0.0/0      reject

	Reiniciem:
	$ systemctl restart postgresql


Escriu també les sentències que caldria executar per comprovar el correcte funcionament i si donen error o no.

-- COMPROVACIONS CONNEXIONS
-- Administrador
psql -h <ip-server> -U administrador llibreria -- OK des de 10.200.243.224. ERROR altrament

-- Manteniment
psql -h <ip_server> -U manteniment1 llibreria -- OK des de 192.168.30.*. Demana password. ERROR altrament

-- Metges
psql -h <ip_server> -U user1 llibreria -- OK des de 192.168.30.*. NO demanarà password. ERROR altrament

-- Servidor Web
psql -h <ip-server> -U web llibreria -- OK des de 192.168.30.21. Demana password. ERROR altrament

-- COMPROVACIONS SQL
-- usuari administrador
SELECT * FROM llibres; -- Ok
SELECT * FROM proveidors; -- Ok
INSERT llibres...  -- Ok
INSERT proveidors...  -- Ok
DELETE FROM llibres...	-- Ok
DELETE FROM proveidors...	-- Ok
UPDATE llibres...	-- Ok
UPDATE proveidors...	-- Ok
INSERT INTO llibres...	-- Ok
INSERT INTO proveidors...	-- Ok

-- Manteniment
SELECT * FROM llibres; -- Ok
SELECT * FROM proveidors; -- Ok
INSERT llibres...  -- Ok
INSERT proveidors...  -- Ok
DELETE FROM llibres...	-- Ok
DELETE FROM proveidors...	-- Ok
UPDATE llibres...	-- Ok
UPDATE proveidors...	-- Ok
INSERT INTO llibres...	-- Ok
INSERT INTO proveidors...	-- Ok

-- Consulta
-- Desde qualsevol ip
psql -h <ip_server> -U user1 llibreria -- Ok
psql -h <ip_server> -U user2 llibreria -- Ok
SELECT * FROM llibres; -- Ok
SELECT * FROM proveidors; -- ERROR
INSERT llibres...  -- ERROR
INSERT proveidors...  -- ERROR
DELETE FROM llibres...	-- ERROR
DELETE FROM proveidors...	-- ERROR
UPDATE llibres...	-- ERROR
UPDATE proveidors...	-- ERROR
INSERT INTO llibres...	-- ERROR
INSERT INTO proveidors...	-- ERROR

-- Usuari aplicació web
-- Desde la ip que hem posat (192.168.30.21)
psql -h <ip_server> -U web llibreria -- Ok
SELECT * FROM llibres; -- Ok
SELECT * FROM proveidors; -- ERROR
INSERT llibres...  -- ERROR
INSERT proveidors...  -- ERROR
DELETE FROM llibres...	-- ERROR
DELETE FROM proveidors...	-- ERROR
UPDATE llibres...	-- ERROR
UPDATE proveidors...	-- ERROR
INSERT INTO llibres...	-- ERROR
INSERT INTO proveidors...	-- ERROR


Finalment volem que els usuaris de manteniment (que has creat abans) també puguin crear usuaris. Escriu la/les comanda/es necessària/es.
training=# ALTER ROLE manteniment WITH createrole;

---------------------------------------------------------------------------------------------------------------------------------------------

SEGONA PART: PROCEDURES.

Consideracions:

La qualitat del codi és important: bona indentació, noms adequats de les variables, comentaris adequats
1. Funció descompte_client

    Paràmetre entrada: codiclient (enter)
    Sortida: descompte (enter)
    Tasca: calcular percentatge de descompte a aplicar
        Calcularem el % de descompte a aplicar en funció de l’import total de les compres (pedidos) del client.
        Si el client ha gastat menys de 10.000 li aplicarem un descompte del 10.
        Si el client ha gastat menys de 20.000 li aplicarem un descompte del 20.
        Si el client ha gastat menys de 30.000 li aplicarem un descompte del 30.
        Si ha gastat més li aplicarem un descompte del 40%.
        Si el client no existeix ha de retornar 0.

Mostreu el resultat de cridar-la 2 cops

(1 punt)

training=# CREATE OR REPLACE FUNCTION codiclient(clie_cod integer) RETURNS integer AS 
$$
DECLARE
    DESC_1 CONSTANT integer := 10;
    DESC_2 CONSTANT integer := 20;
    DESC_3 CONSTANT integer := 30;
    DESC_4 CONSTANT integer := 40;
    descompte numeric := 0;   
    fila RECORD; 
BEGIN
	FOR fila in SELECT importe 
	             FROM pedido 
	            WHERE cliecod = clie_cod 
	LOOP 
		IF NOT FOUND clie_cod THEN
			descompte := 0;
		END IF;
		IF fila.importe < 10000 THEN
				descompte := fila.importe - round(fila.importe * DESC_1 / 100, 2);
		ELSIF fila.importe < 20000 THEN
				descompte := fila.importe - round(fila.importe * DESC_2 / 100, 2);
		ELSIF fila.importe < 30000 THEN
				descompte := fila.importe - round(fila.importe * DESC_3 / 100, 2);
		ELSIF fila.importe >= 30000 THEN
				descompte := fila.importe - round(fila.importe * DESC_4 / 100, 2);
		END IF;
	END LOOP;
RETURN descompte;
END;
$$
LANGUAGE 'plpgsql';

training=# SELECT codiclient(2101);
 codiclient 
------------
       1312
(1 row)

training=# SELECT codiclient(2117);
 codiclient 
------------
      18900
(1 row)


2. Funció recomana_oferta

    Paràmetre entrada: codiclient (enter)
    Sortida: text de l’oferta
    Tasca: recomanar un producte pel client
        Buscar el fabricant a qui el client ha fet l’últim “pedido”.
        D’aquest fabricant buscarem el producte amb més existències
        Informarem del nom del client, el codi i descripció del producte i del preu de venda al qual aplicarem el descompte calculat a la funció anterior.

El text de sortida ha de ser semblant a:

training=> select recomana_oferta(2111);
                               recomana_oferta                                
------------------------------------------------------------------------------
 Client JCP Inc.. Li oferim el producte: aci-4100y(Extractor). Descompte: 10%
(1 fila)

Mostreu el resultat de cridar-la 2 cops

(3 punts)

training=# CREATE OR REPLACE FUNCTION recomana_oferta(clie_cod integer) RETURNS text AS
$$
DECLARE
	llistat text := '';
	percentatge text := '%';
	fila RECORD;
	DESC_1 CONSTANT integer := 10;
    DESC_2 CONSTANT integer := 20;
    DESC_3 CONSTANT integer := 30;
    DESC_4 CONSTANT integer := 40;
BEGIN
	FOR fila IN SELECT c.nombre, pe.fabcod, pe.prodcod, pr.descrip 
				 FROM cliente c
				 JOIN pedido pe ON c.cliecod = pe.cliecod
				 JOIN producto pr ON (pe.fabcod, pe.prodcod) = (pr.fabcod, pr.prodcod) WHERE c.cliecod = clie_cod
	LOOP
		-- descompte_aplicar := cliecod(clie_cod);
		-- RAISE NOTICE 'AAA';
		llistat := llistat || format(E'Client %s... Li oferim el producte: %s-%s(%s). Descompte: %s%s\n', fila.nombre, fila.fabcod, fila.prodcod, fila.descrip, codiclient(clie_cod), percentatge);
	END LOOP;
RETURN llistat;
END;
$$
LANGUAGE 'plpgsql';


3. Funció personal_oficina

    Paràmetre entrada: num-oficina (enter)
    Sortida: un llistat del personal de l’oficina amb el format següent (més avall):

(4 punts)

Mostreu el resultat de cridar-la amb una altra oficina

training=# select personal_oficina(11::smallint);
                                  personal_oficina
------------------------------------------------------------------------------------
 Oficina : New York(11) - Este                                                     +
 ==============================                                                    +
 Data del llistat: 11/12/2021                                                      +
                                                                                   +
 Nom (id)                Fecha contrato    Edad   Puesto                           +
 ----------------------------------------------------------------------------------+
 Mary Jones (109)            12/10/1989      31   Representante Ventas             +
    Jefe:Sam Clark                                                                 +
                                                                                   +
 Sam Clark (106)             14/06/1988      52   VP Ventas                        +
                                                                                   +
 ==================================================================================+
 Total:  2 representants                                                           +
 Mitjana d’edat:  41.50                                                            +
 ==================================================================================+

(1 fila)

FUNCIÓ PER PRINTAR LINEAS:
training=# CREATE OR REPLACE FUNCTION lineas (simbol text, longitud integer) RETURNS text AS
$$
DECLARE
    texto text := '';
    i integer;
BEGIN
    FOR i IN 1..longitud LOOP
        texto := texto || simbol;
    END LOOP;
RETURN texto;
END;
$$
LANGUAGE 'plpgsql';

-------------------------------------------------------------------------------------------------

training=# CREATE OR REPLACE function num_oficina(ofi_num oficina.ofinum%TYPE) RETURNS text AS
$$
DECLARE
	llistat text := '';
	fila RECORD;
	n_representants integer := 0;
	m_edad numeric := 0;
	nom_oficina oficina.ciudad%TYPE;
	num_oficina oficina.ofinum%TYPE;
	regio oficina.region%TYPE;
	fecha text;
	linea1 text;
	linea2 text;
	linea3 text;
	linea4 text;
BEGIN
	nom_oficina := (SELECT ciudad FROM oficina WHERE ofinum = $1);
	num_oficina := (SELECT ofinum FROM oficina WHERE ofinum = $1);
	regio := (SELECT region FROM oficina WHERE ofinum = $1);
	fecha := current_date;
	linea1 := lineas('-', 100);
	linea2 := lineas(' ', 100);
	linea3 := lineas('=', 40);
	linea4 := lineas('=', 100);
	llistat := llistat || format(E'%s: \n', linea1);
	llistat := llistat || format(E'Oficina: %s(%s) - %s\n' , nom_oficina, num_oficina, regio);
	llistat := llistat || format(E'%s \n', linea3);
	llistat := llistat || format(E'Data del llistat: %s \n\n', fecha);
	llistat := llistat || format(E'%s: \n', linea2);
	llistat := llistat || format(E'Nom(id) 	Fecha contrato 	Edad Puesto \n');
	llistat := llistat || format(E'%s \n', linea1);
	llistat := llistat || format(E'Jefe: \n');
	llistat := llistat || format(E'%s: \n', linea2);
	FOR fila IN SELECT r1.nombre, r1.repcod, r1.fcontrato, r1.edad, r1.puesto, r2.jefe 
				 FROM repventa r1 
				 JOIN repventa r2 ON r1.repcod = r2.jefe
				 JOIN oficina o ON r1.ofinum = o.ofinum
				WHERE o.ofinum = ofi_num
	LOOP
		llistat := llistat || format(E'%s(%s) %s %s %s \n', fila.nombre, fila.repcod, fila.fcontrato, fila.edad, fila.puesto);
		llistat := llistat || format(E'%s\n', fila.jefe);
	END LOOP;
	n_representants := n_representants + count(fila.jefe);
	m_edad := m_edad + round(AVG(fila.edad),2);
	llistat := llistat || format(E'%s: \n', linea4);
	llistat := llistat || format(E'%s \n', linea3);
	llistat := llistat || format(E'Total: %s \n', n_representants);
	llistat := llistat || format(E'Mitjana d edat: %s \n', m_edad);
	llistat := llistat || format(E'%s \n', linea3);
RETURN llistat;
END;
$$
LANGUAGE 'plpgsql';

training=# SELECT num_oficina(11::smallint);
                                             num_oficina                                               
--------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------: +
 Oficina: New York(11) - Este                                                                          +
 ========================================                                                              +
 Data del llistat: 2021-12-20                                                                          +
                                                                                                       +
                                                                                                     : +
 Nom(id)         Fecha contrato  Edad Puesto                                                           +
 ----------------------------------------------------------------------------------------------------  +
 Jefe:                                                                                                 +
                                                                                                     : +
 Sam Clark(106) 1988-06-14 52 VP Ventas                                                                +
 106                                                                                                   +
 Sam Clark(106) 1988-06-14 52 VP Ventas                                                                +
 106                                                                                                   +
 Sam Clark(106) 1988-06-14 52 VP Ventas                                                                +
 106                                                                                                   +
 ====================================================================================================: +
 ========================================                                                              +
 Total: 1                                                                                              +
 Mitjana d edat: 52.00                                                                                 +
 ========================================                                                              +
 
(1 row)

training=# SELECT num_oficina(12::smallint);
                                              num_oficina                                               
--------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------: +
 Oficina: Chicago(12) - Este                                                                           +
 ========================================                                                              +
 Data del llistat: 2021-12-20                                                                          +
                                                                                                       +
                                                                                                     : +
 Nom(id)         Fecha contrato  Edad Puesto                                                           +
 ----------------------------------------------------------------------------------------------------  +
 Jefe:                                                                                                 +
                                                                                                     : +
 Bob Smith(104) 1987-05-19 33 Dir Ventas                                                               +
 104                                                                                                   +
 Bob Smith(104) 1987-05-19 33 Dir Ventas                                                               +
 104                                                                                                   +
 Dan Roberts(101) 1986-10-20 45 Representante Ventas                                                   +
 101                                                                                                   +
 Bob Smith(104) 1987-05-19 33 Dir Ventas                                                               +
 104                                                                                                   +
 ====================================================================================================: +
 ========================================                                                              +
 Total: 1                                                                                              +
 Mitjana d edat: 33.00                                                                                 +
 ========================================                                                              +
 
(1 row)


4. Funció canvia_directors()

    La funció no rep cap paràmetre i no retorna res
    Tasca: Canviar els directors de tots les oficines.
        El nou director serà el representant d’aquella oficina que té més vendes.

(2 punts) Escriure també la sentència per executar la funció.

INACABAT !

training=# CREATE OR REPLACE FUNCTION canvia_directors() RETURNS text AS
$$
DECLARE
	fila RECORD;
	new_director integer;
BEGIN
	FOR fila IN SELECT repcod 
			     FROM repventa
				 JOIN oficina ON repcod = director
				WHERE ...
	LOOP
	IF FOUND THEN
         UPDATE director
         SET director = new_director
         WHERE ...;
         RETURN ...;
RETURN;
END;
$$
LANGUAGE 'plpgsql';

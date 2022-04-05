# Accés i permisos

1. Editar el fichero ``pg_hba.conf`` y luego el ``postgresql.conf`` en ``/etc/postgresql/13/main/pg_hba.conf``

2. Reiniciar Postgresql.

3. Acceder como POSTGRESQL (ROOT)

4. Crear un usuario igual al suyo de inicio. CREATE USER nombre WITH PASSWORD 'user' CREATEDB;

5. Aceder desde el _Cliente_.

## Exercici 1

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
d'executar per permetre la connexió des de *qualsevol ordinador* de l'aula i que
un company des del seu **ordinador** pugui accedir al postgresql del teu ordinador
usant varis usuaris amb les seves **contrasenya emmagatzemades** al **postgresql**.
Explica com comprovar el correcte funcionament.

**Solució:**

Suposem que estem a una aula `10.200.244.0/24`

``Keshi: 172.18.0.0/16 - Docker``

+ Costat servidor. Com a _root_.

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint la línia:

	```
	host    all        all             10.200.244.0/24        md5
	```

	Editem el fitxer `/etc/postgresql/13/main/postgresql.conf` i modifiquem la línia:

	```
	listen_addresses='*'
	```
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```
	Ens connectem a la base de dades `template1` i afegim el nostre usuari:

	```
	psql template1
	CREATE USER julio WITH PASSWORD 'passwordsuperbo' CREATEDB;
	```

	```
	psql template1
	CREATE USER julio WITH PASSWORD 'passwordsuperbo' CREATEDB; -- Con permisos para crear BD
	```

+ Costat client.

	Accedim amb el nostre usuari:
	
	```
	psql -h ip_servidor -U julio template1
	```

	```
	psql -h 172.18.0.3 -U aaron template1
	```

	`ÀCCESO OK D1`

## Exercici 2

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per tal que ``cap usuari`` es ``pugui connectar`` a ``cap base de dades`` des d'un ordinador`` concret de l'aula``, però s'ha d'acceptar connexions des de tots els altres ``ordinadors`` de ``l'aula``. Explica com comprovar el correcte funcionament.

**Solució:**

1. Un PC es IP/32.

2. Modificamos pg_hba.conf con un `reject` a un ordenador.

3. __IMPORTANTE --> `EL ORDEN IMPORTA`__ - Acceder desde un ordenador.

Suposem que no volem connexions des de `192.168.1.224`

+ Costat servidor.

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:
	
	```
	# Orden matters
	# Reject a todos los usuarios y bases de datos desde un PC pero permites al resto de su red
	host    all        all             192.168.1.224/32   reject
	host    all        all             192.168.1.0/24	 md5
	```

	```
	host    all        all             172.18.0.2/32   reject
	host    all        all             172.18.0.0/16	 md5
	```

	Editem el fitxer `/etc/postgresql/13/main/postgresql.conf` i modifiquem la línia:

	```
	listen_addresses='*'
	```
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```
	Ens connectem a la base de dades `template1` i afegim el nostre usuari:

	```
	psql template1
	CREATE USER julio WITH PASSWORD 'passwordsuperbo' CREATEDB;
	```

+ Costat client.

	Si accedim amb el nostre usuari des de `192.168.1.224`:
	
	```
	psql -h 192.168.1.143 -U julio template1
	```

	Ens mostrarà el rebuig:

	```
	psql -U julio -h 192.168.1.143 training
	psql: error: FATAL:  pg_hba.conf rejects connection for host "192.168.1.224", user "julio", database "training", SSL on
	FATAL:  pg_hba.conf rejects connection for host "192.168.1.224", user "julio", database "training", SSL off
	```

	En canvi des de qualsevol altre IP diferent a aquesta però dintre del rang ens acceptarà la connexió.

	**Pregunta 1**, amb resposta al final. Creus que l'ordre importa? És a dir funcionaria si les directives les posem així:

	```
	host    all        all             192.168.1.0/24	 md5
	host    all        all             192.168.1.224/32   reject
	```

## Exercici 3

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per tal que un usuari anomenat __"con_rem"__ només pugui accedir a la base de dades amb el __mateix nom__ des d'un ordinador concret de __l'aula sense usar contrasenya__.

``No s'ha de permetre`` la connexió ``amb aquest usuari`` des d'altres ordinadors, però si amb ``altres usuaris``. Explica com comprovar el correcte funcionament.

**Solució:**

1. 1ª línea: TYPE: host DB: con_rem USER: con_rem ADD: ip_con_rem METHOD: trust

* Trust: **SIN PASSWORD**

## Permite a con_rem acceder a su BD desde ese ordenador solo y sin password

2. 2ª línea: TYPE: host DB: con_rem USER: con_rem ADD: 0.0.0.0/0 METHOD: reject

* ALL HOST: 0.0.0.0/0

* Same que el de antes pero 0.0.0.0/0 rejec --> No podrá acceder desde otro PC

## No permite acceder a con_rem a su BD con_rem desde otro ordenador


3. 3ª línea: TYPE: host DB: con_rem USER: con_rem ADD: 0.0.0.0/0 METHOD: reject

* ALL HOST: 0.0.0.0/0

4. Si los usuarios no existen en la BD, hay que crearlos con un ``CREATE USER`` --> ``TIENE LOGIN`` y luego un ``CREATE DB`` de la misma.

## Cualquier otro usuario puede acceder a la BD con_rem

Suposem que l'ordinador concret és `192.168.0.23`

+ Costat servidor.

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:

	```

	# Permite a con_rem acceder a su BD desde ese ordenador solo y sin password

	host    con_rem     con_rem          172.18.0.2/32   trust
	
	# No permite acceder a con_rem a su BD con_rem desde otro ordenador

	host    con_rem     con_rem          0.0.0.0/0		 reject

	# Cualquier otro usuario puede acceder a la BD con_rem
	host    con_rem     all             0.0.0.0/0		 trust
	```
	
	Editem el fitxer `/etc/postgresql/13/main/postgresql.conf` i modifiquem la línia:

	```
	listen_addresses='*'
	```
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```
	Ens connectem a la base de dades `template1` i afegim els usuaris i la base de dades:

	```
	CREATE USER con_rem;
	CREATE USER otheruser;
	CREATE DATABASE con_rem;
	```

+ Costat client.

	Des de `172.18.0.2`:
	```
	psql -h ip_servidor -U con_rem con_rem
	```

	Des de `192.168.0.23`:
	```
	psql -h ip_servidor -U con_rem con_rem
	```


	Ens deixa entrar
	```
	psql -h ip_servidor -U otheruser con_rem
	```
	Ens deixa entrar

	Des d'una màquina diferent a `172.18.0.2`:
	```
	psql -h ip_servidor -U con_rem con_rem
	```
	Error
	```
	psql -h ip_servidor -U otheruser con_rem
	```
	Ens deixa entrar



## Exercici 4

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per tal que un __usuari pugui accedir__ a __totes les bases de dades__ amb __poders absoluts__ (``SUPERUSER``) des d'un ordinador en concret. 

No __s'ha de permetre__ __la connexió__ amb aquest usuari des d'altres ordinadors, però si amb altres usuaris. 

L'usuari s'ha d'anomenar "``rem_admin``" i la contrasenya emmagatzemada al postgresql ha de ser "``ra``". Explica com comprovar el correcte funcionament.


**Solució:**

Suposant que l'ordinador concret és 192.168.0.23


+ Costat servidor

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:

	```
	# rem_admin puede entrar a todas las BD desde su PC con password Md5

	host    all		rem_admin	192.168.0.23/32 md5
	
	# rem_admin no puede entrar desde otro ORDENADOR.

	host    all		rem_admin	0.0.0.0/0		reject

	# Otros usuarios si pueden entrar
	host	all		all			0.0.0.0/0		trust
	```
	
	Editem el fitxer `/etc/postgresql/13/main/postgresql.conf` i modifiquem la línia:

	```
	listen_addresses='*'
	```
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```
	Ens connectem a la base de dades `template1` i afegim l'usuari rem_admin amb els permisos corresponents:

	```
	CREATE USER rem_admin SUPERUSER PASSWORD 'ra';
	CREATE USER other_user;
	```

+ Costat client.

	Des de `192.168.0.23`:
	```
	psql -h ip_servidor -U rem_admin training
	```
	Ens deixa entrar
	```
	psql -h ip_servidor -U otheruser training
	```
	Ens deixa entrar

	Des d'una màquina diferent a `192.168.0.23`:
	```
	psql -h ip_servidor -U rem_admin training
	```
	Error
	```
	psql -h ip_servidor -U otheruser training
	```
	Ens deixa entrar
	
	Per veure que té poders absoluts:

	```
	DROP DATABASE training;
	CREATE DATABASE training;
	```

## Exercici 5

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per tal que un __usuari__ pugui __accedir__ a __totes__ les bases de dades des de __qualsevol ordinador__ de l'aula. 

L'usuari s'ha d'anomenar "semi_admin" i la
contrasenya, emmagatzemada al postgresql, ha de ser "sa". Aquest usuari ha de
tenir permisos per a poder __crear bases de dades__ i __nous usuaris__. Explica com comprovar el correcte funcionament.

Keshi:

* Server:

pg_hba.conf:
```
host 		all			semi_admin		172.18.0.2/16		md5
```

postgresql.conf
```
listen_addresses='*'
```

```
su -l postgres ; psql template1
```

```sql
CREATE USER semi_admin WITH PASSWORD 'sa' CREATEDB CREATEROLE;
```

\du --> Revisar


* Cliente:

```
psql -h 172.18.0.2 -U semi_admin template1;
```


+ Costat servidor

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:

	```
	host    all		semi_admin	192.168.0.0/24		md5
	```
	
	Editem el fitxer `/etc/postgresql/13/main/postgresql.conf` i modifiquem la línia:

	```
	listen_addresses='*'
	```
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```
	Ens connectem a la base de dades `template1` i afegim l'usuari semi_admin amb els permisos corresponents:

	```
	CREATE USER semi_admin PASSWORD 'sa';
	```

+ Costat client.

	```
	psql -h ip_servidor -U semi_admin training
	```
	Ens deixa entrar

	Per veure que té els permisos demanats:

	```
	CREATE DATABASE test_db;
	CREATE USER test_user;
	DROP DATABASE test_db;
	DROP USER test_user;
	```

## Exercici 6

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per tal que un usuari només pugui accedir a la base de dades "db123"
des de qualsevol ordinador. L'usuari s'ha d'anomenar "us123" i la contrasenya,
emmagatzemada al postgresql, ha de ser "123". 

L'usuari només pot tenir 2 connexions simultànies i només s'ha de poder connectar fins el 31-12-2022, inclòs. Explica com comprovar el correcte funcionament.


pg_hba.conf

```
host 	db123		us123		172.16.0.0/16		md5
```

editar el fichero postgresql.conf

reiniciar

iniciar como postgres

crear el usuario --> CREATE USER db123 WITH PASSWORD '123' CONNECTION LIMIT 2 VALID UNTIL '2022-12-31'



+ Costat servidor

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:

	```
	host    db123	us123	0.0.0.0/0	md5
	```
	
	Editem el fitxer `/etc/postgresql/13/main/postgresql.conf` i modifiquem la línia:

	```
	listen_addresses='*'
	```
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```
	Ens connectem a la base de dades `template1` i afegim l'usuari us123 amb els permisos corresponents:

	```
	CREATE USER us123 PASSWORD '123' CONNECTION LIMIT 2 VALID UNTIL '2022-12-31';
	```

+ Costat client.

	```
	psql -h ip_servidor -U us123 training
	```
	ERROR
	```
	psql -h ip_servidor -U us123 db123
	```
	Ens deixa entrar

	Repetim la instrucció anterior des d'una altra terminal:
	```
	psql -h ip_servidor -U us123 db123
	```
	Ens deixa entrar
	
	Executem per 3a vegada la mateixa instrucció:
	```
	psql -h ip_servidor -U us123 db123
	```
	ERROR
	
	Ara juguem amb la data. Canviem la data límit per una data del passat i comprovem que al intentar connectar-se dona un error.

	Vigilem de no estar connectats a la base de dades abans de fer el canvi

## Exercici 7

Explica quines sentències s'han d'executar per tal que un usuari anomenat
"magatzem" només pugui modificar les dades de la col·lumna "estoc" de la taula
"productes" de la base de dades "training" propietat del vostre usuari. La
contrasenya de l'usuari s'ha d'emmagatzemar al sistema gestor de base de dades.
Explica com comprovar el correcte funcionament.


+ Costat servidor

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:

	```
	host    training	magatzem	127.0.0.1/32	md5
	```
	
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```
	Ens connectem a la base de dades `training` i afegim l'usuari magatzem amb els permisos corresponents:

	```
	CREATE USER magatzem PASSWORD 'magatzempw';
	GRANT UPDATE (estoc) ON productes TO magatzem;
	```




+ Costat client.

	```
	psql -h localhost -U magatzem training
	training=> SELECT * FROM productes;
	ERROR:  permission denied for table productes
	training=> UPDATE productes SET estoc = 3;
	UPDATE 25
	training=> UPDATE productes SET descripcio = 'producte cuqui';
	ERROR:  permission denied for table productes
	```

## Exercici 8

Explica quines sentències s'han d'executar per tal que un usuari anomenat "rrhh"
només pugui modificar les dades de la taula "rep_vendes" de la base de dades "training"
propietat del vostre usuari. La contrasenya de l'usuari s'ha d'emmagatzemar al
sistema gestor de base de dades. Explica com comprovar el correcte funcionament.


+ Costat servidor

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:

	```
	host		all		all    127.0.0.1/32		md5
	```
	
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```
	Ens connectem a la base de dades `training` i afegim l'usuari rrhh amb els permisos corresponents:

	```
	CREATE USER rrhh PASSWORD 'rrhhpw';
	GRANT UPDATE ON rep_vendes TO rrhh;
	```

+ Costat client.

	```
	psql -h localhost -U rrhh training
	training=> SELECT * FROM rep_vendes;
	ERROR:  permission denied for table productes
	training=> UPDATE rep_vendes SET cuota = 300000, ventas=500000;
	UPDATE 10
	```

## Exercici 9

Explica quines sentències s'han d'executar per tal que un usuari anomenat
"lectura" no pugui modificar les dades ni l'estructura de la base de dades "training" propietat del vostre usuari. La contrasenya de l'usuari s'ha d'emmagatzemar al
sistema gestor de base de dades. Explica com comprovar el correcte funcionament.

+ Costat servidor

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:

	```
	host		all		all    127.0.0.1/32		md5
	```
	
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```
	Ens connectem a la base de dades `training` i afegim l'usuari lecturapw amb els permisos corresponents:

	```
	CREATE USER lectura PASSWORD 'lecturapw';
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO lectura;
	```

+ Costat client.

	```
	psql -h localhost -U lectura training
	training=> SELECT * FROM oficines;
		 oficina |   ciutat    | regio | director | objectiu  |  vendes   
		---------+-------------+-------+----------+-----------+-----------
			  22 | Denver      | Oest  |      108 | 300000.00 | 186042.00
			  11 | New York    | Est   |      106 | 575000.00 | 692637.00
			  12 | Chicago     | Est   |      104 | 800000.00 | 735042.00
			  13 | Atlanta     | Est   |      105 | 350000.00 | 367911.00
			  21 | Los Angeles | Oest  |      108 | 725000.00 | 835915.00
		(5 rows)
	training=> UPDATE oficines SET objetivo = 50000;
	ERROR:  permission denied for table oficines
	```
	S'hauria de fer el mateix amb les altres taules.

## Exercici 10

Explica quines sentències s'han d'executar per tal que un usuari anomenat
"gestor" pugui modificar les dades i l'estructura de la base de dades training
propietat del vostre usuari. La contrasenya de l'usuari s'ha d'emmagatzemar al
sistema gestor de base de dades. Aquest usuari no pot tenir permisos de
superusuari.  Explica com comprovar el correcte funcionament.


+ Costat servidor

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:

	```
	host		all		all    127.0.0.1/32		md5
	```
	
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```
	Ens connectem a la base de dades `training` i afegim l'usuari lecturapw amb els permisos corresponents:

	```
	CREATE USER gestor PASSWORD 'gestorpw';
	```
	I ara creem la següent estructura

	```
	training=# CREATE ROLE training_group;
	CREATE ROLE
	training=# ALTER TABLE clients OWNER TO training_group;
	ALTER TABLE
	training=# ALTER TABLE rep_vendes OWNER TO training_group;
	ALTER TABLE
	training=# ALTER TABLE comandes OWNER TO training_group;
	ALTER TABLE
	training=# ALTER TABLE productes OWNER TO training_group;
	ALTER TABLE
	training=# ALTER TABLE oficines OWNER TO training_group;
	ALTER TABLE
	training=# GRANT training_group TO jamoros, gestor;
	GRANT ROLE
	```

+ Costat client.

	```
	psql -U gestor -h 127.0.0.1 training
	training=> ...
	```

## Exercici 11

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per obtenir el següent escenari:

+ Els noms assignats han de ser descriptius.

+ Una base de dades d'una empresa de transport que te una taula per
  emmagatzemar els vehicles amb els següents camps:

	- Camp que identifica el vehicle.

	- Camp que indica la data de compra del vehicle.

	- Camp que indica si el vehicle està disponible o bé per algun motiu està
	  al taller, quan s'afegeix un nou vehicle a la taula aquest camp ha de dir
que el vehicle està disponible.

+ Els usuaris guarden les seves contrasenyes al postgresql.

+ L'usuari administrador:

	- Ha de ser un superusuari del postgresql

	- Només s'ha de poder connectar des d'un ordinador concret. 

+ L'usuari del taller:
	
	- Només ha de poder modificar les dades referents a l'estat del vehicle.
	
	- Només s'ha de poder connectar des d'un ordinador en concret. 

+ L'usuari de compres:

	- Ha de poder afegir vehicles a la taula dels vehicles, però no ha de poder
	  modificar les dades referents a l'estat del vehicle.

	- Només s'ha de poder connectar des de la xarxa local.

+ Explica com comprovar el correcte funcionament.

**Solució:**


Suposarem que l'usuari administrador i l'usuari del taller només es poden
connectar des dels hosts `192.168.0.23` i  `192.168.0.24` respectivament.

+ Costat servidor

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:

	```
	host    transport  admin		192.168.0.23/32   md5
	host    transport  garage		192.168.0.24/32   md5
	host    transport  sales		192.168.0.0/24    md5
	```

	Editem el fitxer `/etc/postgresql/13/main/postgresql.conf` i modifiquem la línia:

	```
	listen_addresses='*'
	```
	
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```

	Ens connectem a la base de dades `template1` i creem la base de dades
`transport` i ens connectem a aquesta:

	```
	psql template1
	CREATE DATABASE transport;
	\c transport
	```
	
	I ara creem la taula vehicles:

	```
	CREATE TABLE vehicles (
		PRIMARY KEY(id_vehicle),
		id_vehicle	VARCHAR(10),
		sale_date	DATE,
		available	BOOLEAN		DEFAULT true
	);
	```
	
	Creem els usuaris admin, garage i sales amb els seus respectius permisos.

	```
	CREATE USER admin SUPERUSER PASSWORD 'adminpw';
	CREATE USER garage PASSWORD 'garagepw';
	CREATE USER sales PASSWORD 'salespw';
	GRANT SELECT(id_vehicle), UPDATE (available) ON vehicles TO garage;
	GRANT INSERT ON vehicles TO sales;
	```

+ Costat client.

	Des d'aquí farem les **comprovacions** pertinents:

	+ Des de 192.168.0.23, l'usuari admin:
	
		```
		psql -U admin -h ip_server
		SELECT *
		  FROM vehicles;
		INSERT INTO vehicles
		VALUES ('aaa','2022-02-18');
		INSERT INTO vehicles
		VALUES ('bbb','2022-02-18');
		```

	+ Des de 192.168.0.24, l'usuari garage:

		```
		psql -U garage -h ip_server
		SELECT *
		  FROM vehicles;
		```
		**error**

		```
		INSERT INTO vehicles
		VALUES ('ccc','2022-03-16');
		```
		**error**

		```
		UPDATE vehicles
		   SET available = false;
		```
	+ Des de qualsevol oridnador de la xarxa, l'usuari sales:

		```
		psql -U sales -h ip_server
		INSERT INTO vehicles
		VALUES ('ccc','2022-03-17');
		```

	+ Cal comprovar que no es pot fer des dels ordinadors prohibits.

	

## Exercici 12

Explica quina configuració ha de tenir el postgresql i quines sentències s'han executat per obtenir el següent escenari:

+ Els noms assignats han de ser descriptius.

+ Una base de dades d'una pàgina web amb notícies breus i articles.

+ La base de dades ha de tenir dues taules, una per emmagatzemar les notícies breus i l'altra per emmagatzemar els articles.

+ Els usuaris guarden les seves contrasenyes al postgresql.

+ L'usuari administrador:

	- Només ha de poder tenir una connexió activa.

	- Ha de poder veure i modificar l'estructura i les dades de la base de dades.

	- Ha de poder accedir des de qualsevol lloc.

	- Ha de poder crear nous usuaris i assingar-los els permisos corresponents.

	- No pot tenir permisos de superusuari.

+ L'usuari de l'aplicació web:
	
	- Només ha de poder llegir la base de dades.

	- Només s'ha de poder connectar des de l'ordinador que te el servidor web.

+ L'usuari de gestió de la web:

	- Ha de poder veure i modificar les dades de la base de dades.

	- S'ha de poder connectar des de qualsevol ordinador de la xarxa local.

+ L'usuari de notícies:

	- Ha de poder veure les taules però només ha de poder modificar la taula de notícies breus.

	- S'ha de poder connectar des de qualsevol lloc.

+ L'usuari d'articles:

	- Ha de poder veure les taules però només ha de poder modificar la taula d'articles.

	- Només s'ha de poder connectar des de la xarxa local. 

+ Explica com comprovar el correcte funcionament.

**Solució:**

Suposarem que l'usuari administrador i l'usuari del taller només es poden
connectar des dels hosts `192.168.0.23` i  `192.168.0.24` respectivament.

+ Costat servidor

	Editem el fitxer `/etc/postgresql/13/main/pg_hba.conf` afegint les línies:

	```
	host    news    admin			0.0.0.0/0		md5
	host    news    web_app			192.168.0.23/32	md5
	host    news    web_manager		192.168.0.0/24	md5
	host    news    short_news_user	0.0.0.0/0		md5
	host    news    articles_user	192.168.0.0/24	md5
	```

	Editem el fitxer `/etc/postgresql/13/main/postgresql.conf` i modifiquem la línia:

	```
	listen_addresses='*'
	```
	
	Reiniciem el servei postgresql perquè torni a llegir els fitxers de configuració:

	```
	systemctl restart postgresql
	```

	Continuem al costat servidor, canviem a usuari administrador de la base de dades, potsgres.

	```
	su -l postgres
	```

	Ens connectem a la base de dades `template1` i creem la base de dades
`news` i ens connectem a aquesta:

	```
	psql template1
	CREATE DATABASE news;
	\c news
	```
	
	I ara creem les taules short_news i articles:

	```
	CREATE TABLE short_news (
		PRIMARY KEY(id),
		id			INT,
		title		VARCHAR(50),
		description	VARCHAR(300)
	);
	
	CREATE TABLE articles (
		PRIMARY KEY(id),
		id 			INT,
		title		VARCHAR(50),
		description TEXT
	);
	```
	
	Creem els usuaris admin, web_app, web_manager, short_news_user i articles_user amb els seus passwords.

	```
	CREATE USER admin CONNECTION LIMIT 1 CREATEROLE PASSWORD 'adminpw';
	CREATE USER web_app PASSWORD 'web_apppw';
	CREATE USER web_manager PASSWORD 'web_managerpw';
	CREATE USER short_news_user PASSWORD 'short_news_userpw';
	CREATE USER articles_user PASSWORD 'articles_userpw';
	```
	
	Fem l'usuari admin propietari de la base de dades, així com de les dues taules:

	```
	ALTER DATABASE news OWNER TO admin;
	ALTER TABLE short_news OWNER TO admin;
	ALTER TABLE articles OWNER TO admin;
	```

	Establim el gruix de permisos demanats:

	```
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO web_app, short_news_user, articles_user;
	GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO web_manager;
	GRANT INSERT, UPDATE, DELETE ON short_news TO short_news_user;
	GRANT INSERT, UPDATE, DELETE ON articles TO articles_user;
	```

+ Costat client.

	Fem les **comprovacions** amb localhost però s'hauria de fer amb IP's de la
xarxa adient, ens centrem més en els permisos dels usuaris:

	+ Amb l'usuari admin:

		```
		psql -U admin -h 127.0.0.1 news
		Password for user admin: 
		psql (13.5 (Debian 13.5-0+deb11u1))
		SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
		Type "help" for help.
		
		news=> SELECT *
		news->   FROM short_news;
		 id | title | description 
		----+-------+-------------
		(0 rows)

		news=> SELECT *
		news->   FROM articles;
		 id | title | description 
		----+-------+-------------
		(0 rows)

		news=> INSERT INTO short_news
		news-> VALUES (1, 'title sn 1', 'desc sn 1');
		INSERT 0 1
		news=> INSERT INTO short_news
		news-> VALUES (2, 'title sn 2', 'desc sn 2');
		INSERT 0 1
		news=> INSERT INTO articles
		news-> VALUES (1, 'title a1', 'desc a 1');
		INSERT 0 1
		news=> INSERT INTO articles
		news-> VALUES (2, 'title a2', 'desc a 2');
		INSERT 0 1
		```
	
	+ Usuari web_app:

		```
		psql -U web_app -h 127.0.0.1 news
		...
		news=> SELECT *
		news->   FROM short_news;
		 id |   title    | description 
		----+------------+-------------
		  1 | title sn 1 | desc sn 1
		  2 | title sn 2 | desc sn 2
		(2 rows)

		news=> SELECT *
		news->   FROM articles;
		 id |  title   | description 
		----+----------+-------------
		  1 | title a1 | desc a 1
		  2 | title a2 | desc a 2
		(2 rows)

		news=> INSERT INTO short_news
		news-> VALUES (3, 'title sn 3', 'desc sn 3');
		ERROR:  permission denied for table short_news
		```
	
	+ Usuari web_manager

		```
		psql -U web_manager -h 127.0.0.1 news
		...
		
		news=> SELECT *
		news->   FROM short_news;
		 id |   title    | description 
		----+------------+-------------
		  1 | title sn 1 | desc sn 1
		  2 | title sn 2 | desc sn 2
		(2 rows)

		news=> INSERT INTO short_news
		news-> VALUES (3, 'title sn 3', 'desc sn 3');
		INSERT 0 1
		news=> UPDATE short_news
		news->    SET title = 'ddd';
		UPDATE 3
		news=> DELETE FROM short_news;
		DELETE 3
		```
	
	+ Usuari short_news_user

		```
		psql -U short_news_user -h 127.0.0.1 news
		...
		
		news=> SELECT *
		news->   FROM short_news;
		 id | title | description 
		----+-------+-------------
		(0 rows)

		news=> SELECT *
		  FROM short_news;
		 id | title | description 
		----+-------+-------------
		(0 rows)

		news=> SELECT *
		  FROM articles;
		 id |  title   | description 
		----+----------+-------------
		  1 | title a1 | desc a 1
		  2 | title a2 | desc a 2
		(2 rows)

		news=> INSERT INTO short_news
		news-> VALUES(1,'aaa','aaaa');
		INSERT 0 1
		news=> INSERT INTO articles  
		VALUES(1,'aaa','aaaa');
		ERROR:  permission denied for table articles
		```
	
	+ Usuari articles_user

		```	
		psql -U articles_user -h 127.0.0.1 news
		...

		news=> SELECT *
		news->   FROM short_news;
		 id | title | description 
		----+-------+-------------
		  1 | aaa   | aaaa
		(1 row)

		news=> SELECT *
		news-> 	 FROM articles;
		 id |  title   | description 
		----+----------+-------------
		  1 | title a1 | desc a 1
		  2 | title a2 | desc a 2
		(2 rows)

		news=> INSERT INTO short_news
		VALUES(1,'aaa','aaaa');
		ERROR:  permission denied for table short_news
		news=> INSERT INTO articles
		VALUES(3,'ccc','cccc');
		INSERT 0 1
		```

## EXTRES

**Pregunta 1**

No funcionaria, o sigui _order matters_. El sistema llegeix la 1a directiva que faci referència a la IP origen `192.168.1.223`, usuari `julio` i base de dades `template1` i intenta conectar-se, tant si funciona com si no, la següent directiva ja no es mira.

Extret de la [documentació de postgresql 13](https://www.postgresql.org/docs/13/auth-pg-hba-conf.html):

> The first record with a matching connection type, client address, requested database, and user name is used to perform authentication. There is no “fall-through” or “backup”: if one record is chosen and the authentication fails, subsequent records are not considered.



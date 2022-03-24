# CHEATSHEET KESHI [13]

# DCL

# Data Control Language (DCL):  permisos

DCL és un subllenguatge dintre de SQL que permet a l'administrador de la BD
controlar l'accés a les dades d'aquesta.


## GRANT

Per veure privilegis concedits:

```
\dp
```

Donar permisos a taules:

```SQL
GRANT { { SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER }
    [, ...] | ALL [ PRIVILEGES ] }
    ON { [ TABLE ] table_name [, ...]
         | ALL TABLES IN SCHEMA schema_name [, ...] }
    TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
```

Les bases de dades tenen esquemes i els esquemes tenen les taules. Si no hem creat un esquema explícitament, les nostres taules estan a l'esquema de nom *public*.


**Exemples:**

> Permetre veure, inserir i esborrar registres de la taula repventas a l'usuari rrhh:

```SQL
GRANT SELECT, INSERT, DELETE ON repventas TO rrhh;
```

> Permetre la gestió de totes les dades de totes les taules a l'usuari _tworker_

```SQL
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tworker;
```

> Donar permisos a columnes:

```SQL
GRANT { { SELECT | INSERT | UPDATE | REFERENCES } ( column_name [, ...] )
    [, ...] | ALL [ PRIVILEGES ] ( column_name [, ...] ) }
    ON [ TABLE ] table_name [, ...]
    TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
```

**Exemple:**

Permetre veure i modificar les columnes objectiu i vendes de la taula oficines a l'usuari director

```SQL
GRANT SELECT, UPDATE (objectiu, vendes) ON oficinas TO director;
```

> Donar permisos a bases de dades:

```SQL
GRANT { { CREATE | CONNECT | TEMPORARY | TEMP } [, ...] | ALL [ PRIVILEGES ] }
    ON DATABASE database_name [, ...]
    TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
```

> Donar permisos a esquemes:

```SQL
GRANT { { CREATE | USAGE } [, ...] | ALL [ PRIVILEGES ] }
    ON SCHEMA schema_name [, ...]
    TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
```

> Donar els permisos d'un rol a un altre ("afegir" un rol a un altre):

```SQL
GRANT rol_pare [, ...] TO rol_fill [, ...]
```

Per tal de tenir tots els permisos en una base de dades el més fàcil és ser propietaris d'aquesta i de totes les seves taules. 

Si han de tenir permisos dos usuaris, es pot crear un rol (que simuli un grup), fer que aquest rol sigui el propietari de la base de dades i la taula i fer que els dos usuaris tinguin els permisos d'aquest grup.

**Exemple:**

> Donar tots els permisos de la base de dades training a l'usuari tmanager i a l'usuari tadmin:

```SQL
CREATE ROLE tgroup;
ALTER DATABASE training OWNER TO tmanager;
ALTER TABLE clientes OWNER TO tmanager;
ALTER TABLE oficinas OWNER TO tmanager;
ALTER TABLE repventas OWNER TO tmanager;
ALTER TABLE productos OWNER TO tmanager;
ALTER TABLE pedidos OWNER TO tmanager;
GRANT tgroup TO tmanager, tadmin;
```

## REVOKE

Serveix per treure privilegis. Té una sintaxi molt similar a GRANT:

>Treure permisos `permisos de taules`:
```SQL
REVOKE [ GRANT OPTION FOR ]
    { { SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER }
    [, ...] | ALL [ PRIVILEGES ] }
    ON { [ TABLE ] table_name [, ...]
         | ALL TABLES IN SCHEMA schema_name [, ...] }
    FROM { [ GROUP ] role_name | PUBLIC } [, ...]
    [ CASCADE | RESTRICT ]
```

> Treure `permisos a columnes`:
```
REVOKE [ GRANT OPTION FOR ]
    { { SELECT | INSERT | UPDATE | REFERENCES } ( column_name [, ...] )
    [, ...] | ALL [ PRIVILEGES ] ( column_name [, ...] ) }
    ON [ TABLE ] table_name [, ...]
    FROM { [ GROUP ] role_name | PUBLIC } [, ...]
    [ CASCADE | RESTRICT ]
```

> Treure `permisos de bases de dades`:
```SQL
REVOKE [ GRANT OPTION FOR ]
    { { CREATE | CONNECT | TEMPORARY | TEMP } [, ...] | ALL [ PRIVILEGES ] }
    ON DATABASE database_name [, ...]
    FROM { [ GROUP ] role_name | PUBLIC } [, ...]
    [ CASCADE | RESTRICT ]
```

> Treure `permisos d'esquemes`:
```SQL
REVOKE [ GRANT OPTION FOR ]
    { { CREATE | USAGE } [, ...] | ALL [ PRIVILEGES ] }
    ON SCHEMA schema_name [, ...]
    FROM { [ GROUP ] role_name | PUBLIC } [, ...]
    [ CASCADE | RESTRICT ]
```

> Donar els `permisos d'un rol` a un altre ("`afegir`" un `rol a un altre`):
```SQL
REVOKE [ ADMIN OPTION FOR ]
    role_name [, ...] FROM role_name [, ...]
    [ CASCADE | RESTRICT ]
```

S'ha d'anar amb compte perquè per defecte tothom té els privilegis de USAGE i CREATE en l'esquema PUBLIC. Per treure el privilegi de crear hauríem de fer:

```SQL
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
```

## Altres permisos

Però tot està relacionat, de manera que el DDL també te algunes instruccions que ens permet gestionar l'accés a la BD.

Per exemple, si volem:

+ canviar de propietari una base de dades:

```SQL
ALTER DATABASE db_name OWNER TO username;
```

+ canviar de propietari les taules d'una base de dades:

```SQL
ALTER TABLE table_name OWNER TO username;
```

**Exemple:**

+ Donar tots els permisos de la base de dades training a l'usuari tmanager:

```SQL
ALTER DATABASE training OWNER TO tmanager;

ALTER TABLE clientes OWNER TO tmanager;

ALTER TABLE oficinas OWNER TO tmanager;

ALTER TABLE repventas OWNER TO tmanager;

ALTER TABLE productos OWNER TO tmanager;

ALTER TABLE pedidos OWNER TO tmanager;
```


## LINKS

+ [Resum de receptes, tot i que fa referència a un VPS, no fa res diferent del que fem nosaltres](https://www.digitalocean.com/community/tutorials/how-to-use-roles-and-manage-grant-permissions-in-postgresql-on-a-vps-2)


---------------------------------------------------------------------------------

## RUBEN DCL

[Revisa la documentación de RubenDCL](ApuntsDCL(Ruben).pdf)

[Revisa la documentación de RubenDCL](ResumDCL.pdf)

### Resumen

PostgreSql permet diversos tipus d'autenticació definits al fitxer
__/etc/postgresql/13/main/pg_hba.conf__ (o __/var/lib/pgsql/data/pg_hba.conf__ en versions antigues) A cada línia d'aquest fitxer s'especifica:

* si s'accedeix localment o remotament

* a quines bases de dades es pot accedir

* quins usuaris hi poden accedir

* quines adreces (IP) poden accedir

* el mètode d'autenticació

Per fer accessos remots, hem de dir a Postgresql que escolti a les adreces de xarxa que volem en el fitxer __/var/lib/pgsql/data/postgresql.conf__:

### Per defecte:
`listen_addresses='localhost'`

#### Per escoltar tot:
`listen_addresses='*'`

#### Per escoltar IPs determinades:
`listen_addresses='192.168.0.24, 192.168.0.26'`

CADA COP que toquem fitxers de configuració hem de reiniciar el servei de Postgresql:

#### `systemctl restart postgresql`


#### Accés:
`$ psql -h <ip_servidor|nom_servidor> -U <nom_usuari> <nom_bd>`

#### PER VEURE les BBDD:
training=> \l

#### PER VEURE els USUARIS:
training=> \du

#### PER VEURE els PRIVILEGIS:
training=> \dp

`peer`: Tothom que es connecti en local utilitzarà la validació de sistema.

`ident`: L’autenticació és basa en el sistema operatiu, si l’usuari existeix, ja haurà demanat l’autenticació per entrar a la xarxa, llavors, serà usuari existent, i li deixarà entrar,

`md5`: Demanarà usuari i password.

`trust`: No demanarà res.

`reject`: No deixarà entrar.

#### Podem restrinigr (__PER IP__) que només el servidor web consulti les dades de la BBDD.

Podem accedir a la BBDD d’un company/a mitjançant l’accés remot, hem de modificar el següent fitxer: `/etc/postgresql/13/main/postgresql.conf`

####  Descomentar valor listen_addresses i posar-li el valor `*`

`listen_addresses = '*'`

#### Descomentar el valor port

`port=5432`

Modificar el fitxer `/var/lib/pgsql/data/pg_hba.conf` i afegir una línia a l'apartat IPv4 local connections: Per exemple:

`host  all   all   192.168.0.83/32   trust`

(D'aquesta manera només permetem l'accés a la base de dades al pc amb la ip
192.168.0.83. Comprova la direcció sencera. 

Si en comptes de posar /32, posem /24 només comprovaria els 3 primers grups i deixaria entrar totes les ip de la classe: 192.168.0.*)

Fer restart del servei postgres

`systemctl restart postgresql`

Des del client

Ara ja podem entrar a la base de dades remotament

`psql -h 192.168.0.83 -p 5432 -U postgres training`

`passwd` → Ens permet cambiar la contrasenya DINS DE POSTGRES!

`host  all   guest 10.200.244.229/32 pam `

> → NO ENS DEIXARÀ PERQUE GUEST ÉS UN USUARI LOCAL, NO ESTÀ REGISTRAT AL SERVIDOR (GANDHI)

`host all    isx46994723 10.200.244.229/32 pam `

> → ENS DEIXA PERQUE SOM UN USUARI REGISTRAT AL SERVIDOR (GANDHI)

---------------------------------------------------------------------------------------------------------------------------
```
CREATE TABLE vehicles (
            id_vehicle varchar(10) PRIMARY KEY,
            sale_date date,
            available boolean DEFAULT true
            <etiqueta> <tipus> <NULL/NOT NULL> <camp per defecte(default) + valor>
);
```
local all   all   192.168.0.83/32

1 - type (local / host)

2 - database

3 - user

4 - ip-addres + mask

5 - method

\df → llistar funcions

\x → expandir SELECT



# GRANT

⭐️ **SINTAXIS** ⭐️
-------------------

-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

-------------------

# REVOKE

⭐️ **SINTAXIS** ⭐️
-------------------

-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

-------------------

# Aaron Andal

# Accés i permisos

## Exercici 1

Explica quina configuració ha de tenir el **postgresql** i quines sentències s'han d'executar per **permetre la connexió** des de qualsevol **ordinador de l'aula** i que un **company** des del seu **ordinador** **pugui accedir** al **postgresql** del teu ordinador **usant varis usuaris** amb les seves **contrasenya** emmagatzemades al **postgresql**. 

Explica com comprovar el correcte funcionament.

**En el servidor de ``PostgreSQL Aaron``:**

**Editem el fitxer ``pg_hba.conf``:**
```
host    all        all             10.200.244.0/24        md5
```

*Podràn accedir tots els ordinadors de la Xarxa ``10.200.244.0/24``*

**Editem el fitxer ``/etc/postgresql/postgresql.conf``:**
```
listen_addresses='*'
```

**Reiniciem el PostgreSQL**

```
systemctl restart postgresql
```

**Iniciem sessió amb l'usuari Postgres**

```
su postgres
```

**Accedir a la Template1**


```
$ psql template1
```

**Crear USUARI**

```
CREATE USER isx36579183 WITH PASSWORD 'jupiter' CREATEDB ;
```

**Des d'un ``client del company``:**
```
$ psql -h 10.200.244.205 -U isx36579183 template1
```

## Exercici 2

Explica quina configuració ha de tenir el postgresql i quines sentències s'han executat per tal que **cap usuari** es ^^ a cap base de dades des d'un **ordinador concret de l'aula**, però **s'ha d'acceptar connexions** des de tots els altres ordinadors de l'aula. 

Explica com comprovar el correcte funcionament.

Suposant que no volem connexions des de 10.200.243.23

**En el servidor d'Aaron 10.200.244.205:**

**Editem el fitxer pg_hba.conf del servidor PostgreSQL d'Aaron:**
```
host    all        all             10.200.244.204/32   reject
host    all        all             10.200.244.0/24    md5
```

**Fitxer postgresql.conf del servidor PostgreSQL d'Aaron:**
```
listen_addresses='*'
```

**Reiniciem PostgreSQL**

```
systemctl restart postgresql
```

**Iniciar sessió**

```
su postgres
```

**Iniciar a la BBDD**

```
$ psql template1
```

```
template1=> CREATE USER proba WITH PASSWORD 'jupiter' CREATEDB;
```

**Des de ``10.200.243.204``:**

```
$ psql -h 10.200.244.205 -U proba template1
```

**Donarà error perque tenim el REJECT en ``pg_hba.conf``**

**Des de l'ordinador ``10.200.244.206``:**

```
$ psql -h 10.200.244.205 -U proba template1
```

**Ens ``deixarà entrar``.**

## Exercici 3

Explica quina configuració ha de tenir el postgresql i quines sentències s'han executat per tal que un usuari anomenat "**conrem**" ``només`` **pugui accedir a la base de dades amb el mateix nom** des d'un **ordinador concret** de l'aula **sense usar contrasenya**.

**No s'ha de permetre la connexió** amb aquest **usuari** des d'altres ordinadors, però ``si amb altres usuaris``. 

Explica com comprovar el correcte funcionament.

**Suposant que l'ordinador concret és 10.200.244.206**

**En el servidor d'Aaron:**

**Fitxer pg_hba.conf d'Aaron (PostgreSQL):**
```
host    conrem     conrem          10.200.244.206/32   trust
host    conrem     conrem          0.0.0.0/0           reject
host    conrem     all             0.0.0.0/0           trust
```

**Fitxer postgresql.conf d'Aaron (PostgreSQL):**
```
listen_addresses='*'
```

**Reiniciem PostgreSQL**

```
systemctl restart postgresql
```

**Iniciar sessió**

```
su postgres
```

**Iniciar sessió a la BBDD**

**Fem les operacions DDL**

```
$ psql template1
template1=> CREATE USER conrem;
template1=> CREATE USER otheruser;
template1=> CREATE DATABASE conrem;
template1=> \c conrem;
```

**Des de 10.200.244.206:**
```
$ psql -h 10.200.244.205 -U conrem conrem
```

**Ens deixa entrar**

```
$ psql -h 10.200.244.205 -U proba conrem
```

**Ens deixa entrar**

**Des d'una altra màquina (10.200.244.230):**

```
$ psql -h 10.200.244.228 -U conrem conrem
```

**Error**

```
$ psql -h 10.200.244.228 -U proba conrem
```

**Ens deixa entrar**

## Exercici 4

Explica quina configuració ha de tenir el postgresql i quines sentències s'han executat per tal que un **usuari** pugui accedir a totes les bases de dades amb **``poders absoluts``** des d'un **``ordinador en concret``**. **``No s'ha de permetre``** la connexió amb aquest usuari **``des d'altres ordinadors``**, però si amb **``altres usuaris``**. L'usuari s'ha d'anomenar **``"remadmin"``** i la contrasenya **emmagatzemada** al postgresql ha de ser **``"ra"``**.

Explica com comprovar el correcte funcionament.

**Suposant que l'ordinador concret és 10.200.243.206**

**En el servidor d'Aaron:**

**Fitxer pg_hba.conf:**
```
host    all        remadmin        10.200.243.206/32   md5
host    all        remadmin        0.0.0.0/0           reject
host    all        all             0.0.0.0/0           trust
```

**Fitxer postgresql.conf:**
```
listen_addresses='*'
```

**Reiniciem**

```
systemctl restart postgresql

su postgres
```

**Realitzem la ``creació d'usuari``**

```
$ psql template1
template1=> CREATE USER remadmin SUPERUSER PASSWORD 'ra';
template1=> CREATE USER otheruser;
```

**Des de ``10.200.243.206``:**
```
$ psql -h 10.200.244.205 -U remadmin training
```

**Ens ``deixa entrar``**

```
$ psql -h 10.200.244.205 -U otheruser training
```

**Ens ``deixa entrar``**

**Des d'una altra màquina (10.200.244.204):**
```
$ psql -h 10.200.244.205 -U remadmin training
```

**``Error``**

```
$ psql -h 10.200.244.205 -U otheruser training
```

**Ens ``deixa entrar``**

**Per veure que té ``poders absoluts``:**

```
template1=> DROP DATABASE training;
template1=> CREATE DATABASE training;
...
```

**Veiem que te ``poders to do DCL``**

## Exercici 5

Explica quina configuració ha de tenir el postgresql i quines sentències s'han executat per tal que un **``usuari``** pugui **``accedir a totes les bases de dades``** des de **``qualsevol ordinador de l'aula``**. 

L'usuari s'ha d'anomenar **``"semiadmin"``** i la **``contrasenya, emmagatzemada``** al postgresql, ha de ser **``"sa"``**. `

Aquest usuari ha de tenir **``permisos``** per a poder **``crear bases de dades``** i **``nous usuaris``**. 

Explica com comprovar el correcte funcionament.

**En el servidor d'Aaron:**

**Fitxer `pg_hba.conf:`**
```
host    all        semiadmin        10.200.244.0/24    md5
```

**Fitxer `postgresql.conf:`**
```
listen_addresses='*'
```

**Reiniciem PostgreSQL**

**Creem ``l'usuari semiadmin``**

```
systemctl restart postgresql
su postgres

$ psql template1

template1=> CREATE USER semiadmin CREATEDB CREATEROLE PASSWORD 'sa';
template1=> CREATE USER otheruser;
```

**Provem l'accés amb ``semiadmin`` a ``training``**
```
$ psql -h 10.200.244.205 -U semiadmin training
```

**Ens ``deixa entrar``**

**Per veure ``els permisos``:**
```
template1=> CREATE DATABASE testdb;
template1=> CREATE USER testuser;
template1=> DROP DATABASE testdb;
template1=> DROP USER testuser;
```

## Exercici 6

Explica quina configuració ha de tenir el postgresql i quines sentències s'han executat per tal que un **``usuari només``** pugui accedir a la **``base de dades "db123"``** des de **``qualsevol ordinador``**. 

L'usuari s'ha d'anomenar **``"us123"``** i la contrasenya, emmagatzemada al postgresql, ha de ser **``"123"``**. 

L'usuari només pot **``tenir 2 connexions simultànies``** i només s'ha de poder connectar fins el **``31-12-2012``**, inclòs. 

Explica com comprovar el correcte funcionament.

**En el servidor d'Aaron:**

**Fitxer pg_hba.conf:**
```
host    db123        us123        0.0.0.0/0    md5
```

**Fitxer postgresql.conf:**
```
listen_addresses='*'
```

**Reiniciem el PostgreSQL**

```
systemctl restart postgresql
su postgres

$ psql template1

template1=> CREATE USER us123 PASSWORD '123' CONNECTION LIMIT 2 VALID UNTIL '2021-12-31';
```

**Provem l'accés**

```
$ psql -h 10.200.244.205 -U us123 training
```

**ERROR**

```
$ psql -h 10.200.244.205 -U us123 db123
```

**Ens deixa accedir només a **``db123``****

```
$ psql -h 10.200.244.205 -U us123 db123
```

**(Des d'un altre terminal)**

**Ens deixa accedir**

```
$ psql -h 10.200.244.205 -U us123 db123
```

**(Des d'un altre terminal)**

**ERROR**

**(Posem ``data del passat`` al fitxer de configuració i no estem connectats enlloc)**
```
$ psql -h 10.200.244.205 -U us123 db123
```

**(Des d'un altre terminal)**

**ERROR**

## Exercici 7

Explica quines sentències s'han d'executar per tal que un usuari anomenat **``"almacen"``** només pugui **``modificar les dades``** de la col·lumna **``"existencias"``** de la taula **``"productos"``** de la base de dades **``"training"``** propietat del vostre usuari. 

La **``contrasenya``** de l'usuari s'ha d'emmagatzemar al sistema gestor de base de dades.

Explica com comprovar el correcte funcionament.

**En el servidor d'Aaron**

**Fitxer pg_hba.conf - Localhost accés a TOT:**
```
host    all             all             127.0.0.1/32            md5
```

**Reiniciem el PostgreSQL i creem l'usuari almacen amb password**

```
systemctl restart postgresql
su postgres

$ psql training

training=> CREATE USER almacen PASSWORD 'almacenpassword';
training=> exit
```

**Iniciem a la BBDD de Training i fem el ``GRANT UPDATE`` de la taula ``producto`` a ``l'usuari ALMACEN``**

```
$ psql training
training=> GRANT UPDATE (exist) ON productes TO almacen;
```

**Provem l'accés a l'usuari ``almacen`` a la BD training**

```
$ psql -h 127.0.0.1 -U almacen training
training=> SELECT *
             FROM productes;
ERROR:  permission denied for relation productes
```

**``No té permisos`` de ``SELECT`` pero si ``d'UPDATE``**

```
training=> UPDATE productes
              SET exist = 3;
UPDATE 25
```

```
training=> UPDATE productes
             SET preu = 3;
ERROR:  permission denied for relation productes
```

## Exercici 8

Explica quines sentències s'han d'executar per tal que un usuari anomenat **``"rrhh"``** només pugui modificar les dades de la taula **``"repventas"``** de la base de dades **``"training"``** propietat del vostre usuari. 

La contrasenya de l'usuari s'ha d'emmagatzemar al sistema gestor de base de dades. 

Explica com comprovar el correcte funcionament.

**En el servidor d'Aaron**

**Fitxer pg_hba.conf:**
```
host    all             all             127.0.0.1/32            md5
```

**Reiniciem el PostgreSQL i creem l'usuari ``rrhh``**

```
systemctl restart postgresql
su postgres
$ psql training
training=> CREATE USER rrhh PASSWORD 'rrhhpw';
CREATE ROLE
```

**Li donem permisos a la taula ``repventa`` a ``rrhh``**

```
$ psql training
training=> GRANT UPDATE ON repvendes TO rrhh;
GRANT
```

**``No té permisos`` de ``SELECT`` pero si ``d'UPDATE``**

```
$ psql -h 127.0.0.1 -U rrhh training
training=> SELECT *
             FROM repvendes;
ERROR:  permission denied for relation repvendes
```

**Fem ``l'UPDATE``**

```
training=> UPDATE repvendes SET quota = 300000, vendes=500000;
UPDATE 10
```

## Exercici 9

Explica quines sentències s'han d'executar per tal que un usuari anomenat **``"lectura"``** *``no pugui modificar les dades``* ni ``l'estructura de la base de dades "training"`` propietat del ``vostre usuari``. 

La contrasenya de l'usuari s'ha d'emmagatzemar al sistema gestor de base de dades. 

Explica com comprovar el correcte funcionament.

**En el servidor d'Aaron**

**Fitxer pg_hba.conf:**
```
host    all             all             127.0.0.1/32            md5
```

**Reiniciem el Servidor i creem l'usuari ``lectura``**

```
systemctl restart postgresql
su postgres
$ psql training
training=> CREATE USER lectura PASSWORD 'lecturapw';
```

**Li donem permisos de ``SELECT`` a totes les ``TAULES`` a ``LECTURA``**

```
$ psql training
training=> GRANT SELECT ON ALL TABLES IN SCHEMA public TO lectura;
```

**Provem l'accés i fem un ``SELECT`` per veure que hi tenim ``PERMIS``**

```
$ psql -h 127.0.0.1 -U lectura training
training=> SELECT *
             FROM oficines;
 oficina  |   ciutat    | regio | director | objectiu  |  vendes
---------+-------------+--------+----------+-----------+-----------
      22 | Denver      | Oest  |      107 | 300000.00 | 186042.00
      11 | New York    | Est   |      109 | 575000.00 | 692637.00
      12 | Chicago     | Est   |      101 | 800000.00 | 735042.00
      13 | Atlanta     | Est   |      105 | 350000.00 | 367911.00
      21 | Los Angeles | Oest  |      102 | 725000.00 | 835915.00
(5 rows)
```

**Fem un update per veure que no tenim permís de ``MODIFCACIÓ CRUD``**

```
training=> UPDATE oficines
             SET objectiu = 50000;
ERROR:  permission denied for table objectiu
```

**``Esmentada abans``**

```
training=> INSERT INTO oficines (oficina, ciutat, regio)
           VALUES (111,'sdfaa','sfasd ')
ERROR:  permission denied for table oficines
```

## Exercici 10

Explica quines sentències s'han d'executar per tal que un usuari anomenat **``"gestor"``** pugui ``modificar les dades`` i ``l'estructura de la base de dades`` ``training`` propietat del vostre usuari. 

La contrasenya de l'usuari s'ha d'emmagatzemar al sistema gestor de base de dades. Aquest usuari no pot tenir permisos de superusuari. 

Explica com comprovar el correcte funcionament.

**En el servidor d'Aaron**

**Fitxer pg_hba.conf:**
```
host    all             all             127.0.0.1/32            md5
```

**Reiniciem el PostgreSQL**

**Creem l'usuari ``GESTOR`` i li donem permisos al GRUP = ``training_group``**

```
systemctl restart postgresql
su postgres
$ psql training
training=> CREATE USER gestor PASSWORD 'gestorpw';
CREATE ROLE
```
```
training=> ALTER TABLE clients OWNER TO training_group;
ALTER TABLE
```
```
training=> ALTER TABLE repvendes OWNER TO training_group;
ALTER TABLE
```
```
training=> ALTER TABLE comandes OWNER TO training_group;
ALTER TABLE
```
```
training=> ALTER TABLE productes OWNER TO training_group;
ALTER TABLE
```
```
training=> ALTER TABLE oficines OWNER TO training_group;
ALTER TABLE
```
```
training=> GRANT training_group TO isx36579183, gestor;
GRANT ROLE
```

**Accedim i provem**

```
$ psql training
training=> SELECT *
             FROM oficines;
 oficina  |   ciutat    | regio | director | objectiu  |  vendes
---------+-------------+--------+----------+-----------+-----------
      22 | Denver      | Oest  |      107 | 300000.00 | 186042.00
      11 | New York    | Est   |      109 | 575000.00 | 692637.00
      12 | Chicago     | Est   |      101 | 800000.00 | 735042.00
      13 | Atlanta     | Est   |      105 | 350000.00 | 367911.00
      21 | Los Angeles | Oest  |      102 | 725000.00 | 835915.00
(5 rows)

$ psql -U gestor -h 127.0.0.1 training
training=> SELECT *
             FROM oficines;
 ofinum  |   ciudad    | region | director | objetivo  |  ventas
---------+-------------+--------+----------+-----------+-----------
      22 | Denver      | Oeste  |      107 | 300000.00 | 186042.00
      11 | New York    | Este   |      109 | 575000.00 | 692637.00
      12 | Chicago     | Este   |      101 | 800000.00 | 735042.00
      13 | Atlanta     | Este   |      105 | 350000.00 | 367911.00
      21 | Los Angeles | Oeste  |      102 | 725000.00 | 835915.00
(5 rows)
```

## Exercici 11

Explica quina configuració ha de tenir el postgresql i quines sentències s'han executat per obtenir el següent escenari:

Els noms assignats han de ser descriptius.

Una base de dades d'una empresa de transport que te una taula per emmagatzemar els vehicles amb els següents camps:
 * Camp que `identifica` el vehicle.
 * Camp que indica la `data de compra` del vehicle.
 * Camp que indica si el vehicle `està disponible` o bé per algun motiu està al taller, quan s'afegeix un `nou vehicle` a la taula aquest camp ha de dir que el vehicle `està disponible`.

Els usuaris guarden les seves contrasenyes al postgresql.

L'usuari `administrador` ha de ser un superusuari del postgresql però només s'ha de poder connectar des d'un ordinador.

L'usuari del taller:
 * Només ha de poder `modificar dades` les referents a `l'estat del vehicle`.
 * Només ha de poder connectar des `d'un ordinador en concret`.

L'usuari de compres:
 * Ha de poder afegir `vehicles` a la `taula` dels vehicles, però `no` ha de poder `modificar` les dades referents a `l'estat del vehicle`.
 * Només s'ha de poder connectar des de la `xarxa local`.

Explica com comprovar el correcte funcionament.


**Creem la BBDD que es diu ``transport``:**

```
template1=> CREATE DATABASE transport;
CREATE DATABASE
```
**Ens connectem a la BBDD esmentada i creem la taula ``'vehicles'`` amb els seus camps.**
```
template1=> \c transport
You are now connected to database "transport" as user "isx36579183".
transport=> CREATE TABLE vehicles (
    PRIMARY KEY (id_vehicle),
    id_vehicle               VARCHAR(10),
    sale_date                DATE,
    available                BOOLEAN      DEFAULT true
);

CREATE TABLE
```


```
transport=> \d
          List of relations
 Schema |   Name   | Type  |  Owner
--------+----------+-------+----------
 public | vehicles | table | isx48062351
(1 row)

transport=> SELECT *
             FROM vehicles;
 id_vehicle | sale_date | available
------------+-----------+-----------
(0 rows)
```

**Inserim alguns `valors` per poder-hi treballar: (En els que són true, no cal que possem el `valor boolean` ja que ho hem especificat a l'hora de crear la taula)**
```
transport=> INSERT INTO vehicles (id_vehicle, sale_date)
            VALUES ('1245-LLL','2017-05-21');
INSERT 0 1
```
```
transport=> INSERT INTO vehicles (id_vehicle, sale_date, available)
            VALUES ('6987-KJJ','2021-10-4', 'False');
INSERT 0 1
```
```
transport=> INSERT INTO vehicles (id_vehicle, sale_date, available)
            VALUES ('5000-PKP','2021-07-02', 'False');
INSERT 0 1
```
```
transport=> INSERT INTO vehicles (id_vehicle, sale_date)
            VALUES ('4633-BB','2009-01-26');
INSERT 0 1
```
```
transport=> SELECT *
              FROM vehicles;
 id_vehicle | sale_date  | available
------------+------------+-----------
 1245-LLL   | 2017-05-21 | t
 6987-KJJ   | 2021-10-04 | f
 5000-PKP   | 2021-07-02 | f
 4633-BB    | 2009-01-26 | t
(4 rows)
```

**Creem un ``superusuari`` de nom ``'admin'``, fem que tingui tots els ``privilegis`` i ens fiquem en la ``seva sessió``:**
```
template1=> CREATE ROLE admin SUPERUSER WITH PASSWORD 'jupiter';
CREATE ROLE
```

**Li afegim tots els `permisos` a totes els `tables` amb `schema public` a l'usuari `admin`**

```
template1=> GRANT ALL PRIVILEGES ON ALL TABLES in schema public TO admin;
GRANT

$ sudo psql -U admin transport;
```

**Dins del fitxer pg_hba.conf possem com ``administrador`` el superusuari pero que ``només és pugui connectar`` des ``d'un ordinador``:**
```
host    transport     admin       10.200.244.205/32     md5
host    transport     admin       0.0.0.0/0             reject
```
**Com a usuari ``'admin'``, fem que l'usuari de taller només pugui modificar les dades referents a ``l'estat del vehicle`` i que només pugui ``connectar-se`` des ``d'un ordinador en concret``.**
```
transport=> CREATE USER usuari_taller PASSWORD 'jupiter';
```
```
transport=> GRANT UPDATE (available) ON vehicles TO usuari_taller;
```
**Dins del fitxer pg_hba.conf:**
```
host    transport     usuari_taller        10.200.244.227/32       md5
host    transport     usuari_taller        0.0.0.0/0               reject
```

**Com a usuari '`admin`', fem que l'usuari de compres pugui `afegir vehicles` a la taula dels vehicles, però no ha de poder modificar les dades referents a `l'estat del vehicle` i només s'ha de poder connectar des de la `xarxa local`:**
```
transport=> CREATE USER usuari_compres PASSWORD 'jupiter';
```
```
transport=> GRANT INSERT ON vehicles TO usuari_compres;
```
**Dins del fitxer pg_hba.conf**:
```
host    transport    usuari_compres     10.200.244.0/24   md5
```
**Comprovem que tot funciona correctament:**
```
$ sudo psql -h 10.200.244.205 -U admin vehicles;
```
**PODRÀ ACCEDIR JA QUE ESTÀ ENTRANT AMB LA SEVA IP. (10.200.244.205)**
```
$ sudo psql -h 10.200.244.205 -U admin vehicles;
```
**AQUEST ORDINADOR TÉ UNA IP DIFFERENT (192.168.1.1) LLAVORS... NO PODRÀ ACCEDIR PERQUÈ NO ESTÀ AMB L'ORDINADOR CORRESPONENT PERQUÈ PUGI ENTRAR.**
```
$ sudo psql -h 10.200.244.205 -U usuari_compres vehicles;
```
**PODRÀ ACCEDIR JA QUE LA IP EN QÜESTIÓ (10.200.244.204), `ESTÀ DINS DEL RANG` PER PODER ENTRAR.**
```
$ sudo psql -h 10.200.244.205 -U usuari_compres vehicles;
```
**`NO PODRÀ ACCEDIR` JA QUE LA IP EN QÜESTIÓ (10.200.244.204), `NO ÉS LA CORRESPONENT` A LA QUE HEM POSSAT AL FITXER PG_HBA.CONF PER PODER ENTRAR.**
```
$ sudo psql -h 10.200.244.205 -U usuari_taller vehicles;
```
**PODRÀ ACCEDIR JA QUE ESTÀ ENTRANT AMB LA SEVA IP. (10.200.244.227)**
```
$ sudo psql -h 10.200.243.224 -U usuari_taller vehicles;
```

**Comprovem els privilegis dels usuaris creats abans:**
```
transport=> SET ROLE usuari_compres;
```
```
transport=> INSERT INTO vehicles (id_vehicle,sale_date)
            VALUES ('7777-MNM', '21-07-19');
INSERT 0 1
```
```
transport=> UPDATE vehicles
               SET id_vehicle=22222
```

**DONARÀ ERROR DEGUT A QUE NOMÉS TÉ PERMISOS D'INCERSIÓ, `NO POT MODIFICAR CAP DADA`!!!!!!!!**
```
transport=> \q
transport=> SET ROLE usuari_taller;
transport=> UPDATE vehicles
              SET available=false;
UPDATE
```
**PODRÀ JA QUE `TE PERMISOS` PER CAMBIAR EL VALOR DEL CAMP `'available'`**
```
transport=> UPDATE vehicles SET id_vehicle=false;
```
**`DONARÀ ERROR` DEGUT A QUE NOMÉS TÉ PERMISOS PER `MODIFICAR  LES DADES` DEL CAMP `'available'`**
```
transport=> \q
```




## Exercici 12

Explica quina configuració ha de tenir el postgresql i quines sentències s'han executat per obtenir el següent escenari:

Els noms assignats han de ser descriptius.

Una base de dades d'una pàgina web amb notícies breus i articles.

La base de dades ha de tenir dos taules, una per emmagatzemar les notícies breus i l'altre per emmagatzemar els articles.

Els usuaris guarden les seves contrasenyes al postgresql.

L'usuari administrador:
 * Només ha de poder tenir una connexió activa.
 * Ha de poder veure i modificar l'estructura i les dades de la base de dades.
 * Ha de poder accedir des de qualsevol lloc.
 * Ha de poder crear nous usuaris i assingar-los els permisos corresponents.
 * No pot tenir permisos de superusuari.

L'usuari de l'aplicació web:
 * Només ha de poder llegir la base de dades.
 * Només s'ha de poder connectar des de l'ordinador que te el servidor web.

L'usuari de gestió de la web:
 * Ha de poder veure i modificar les dades de la base de dades.
 * S'ha de poder connectar des de qualsevol ordinador de la xarxa local.

L'usuari de notícies:
 * Ha de poder veure les taules però només ha de poder modificar la taula de notícies breus.
 * S'ha de poder connectar des de qualsevol lloc.

L'usuari d'articles:
 * Ha de poder veure les taules però només ha de poder modificar la taula d'articles.
 * Només s'ha de poder connectar des de la xarxa local.

Explica com comprovar el correcte funcionament.


**Creem la BBDD anomenada noticies:**

```
template1=> CREATE DATABASE noticies;
CREATE DATABASE
```
**Ens connectem a la BBDD en qüestió i creem la taula 'noticies' amb el seu camp i fem el mateix amb la taula 'articles'.**
```
template1=> \c noticies
You are now connected to database "transport" as user "isx36579183".
noticies=> CREATE TABLE lastnews (
    PRIMART KEY (id),
    id               INT,
    title            VARCHAR(50),
    noticies_breus   VARCHAR(100)
);
CREATE TABLE

noticies=> CREATE TABLE articles (
    PRIMARY KEY (id),
    id               INT,
    title            VARCHAR(50),
    description      TEXT
);
CREATE TABLE
```
**Inserim alguns valors per poder treballar:**
```
noticies=> INSERT INTO lastnews (noticies_breus)
           VALUES ('Ucrania està sent atacada');
INSERT 0 1

noticies=> INSERT INTO articles (id)
           VALUES (00001);
INSERT 0 1
```
**Fem que els usuaris guardin les seves contrasenyes al postgresql. L'usuari administrador només ha de poder tenir una connexió activa i ha de poder veure i modificar l'estructura i les dades de la base de dades.**
```
$ psql template1
template1=> \c noticies
noticies=> CREATE USER admin PASSWORD 'admin' NOSUPERUSER CONNECTION LIMIT 1;
CREATE USER
noticies=> CREATE ROLE grup_admin;
CREATE ROLE
noticies=> ALTER TABLE articles,news OWNER TO grup_admin;
ALTER TABLE
noticies=> GRANT grup_admin TO admin;
GRANT
```
**L'admin ha de poder accedir des de qualsevol lloc:**

**Dins del fitxer pg_hba.conf:**
```
host    admin      noticies           0.0.0.0/0     md5
```
**Dins del fitxer postgresql.conf:**
```
listen_addresses='*'
```
**Reiniciem:**
```
$ sudo systemctl restart postgresql
```
**L'admin ha de poder crear nous usuaris i assingar els permisos corresponents:**
```
noticies=> GRANT CREATEROLE TO admin;
GRANT
```
**Amb l'usuari administrator creat anteriorment:**
```
$ psql -h 127.0.0.1 -U admin noticies;

noticies=> CREATE USER user1 PASSWORD 'user1';
CREATE USER
```
**L'usuari de l'aplicació web només ha de poder llegir la base de dades i només s'ha de poder connectar des de l'ordinador que te el servidor web.**
```
noticies=> GRANT SELECT TO user1 ;
GRANT
```
**Dins del fitxer postgresql.conf:**
```
host    user1    noticies           10.200.244.0/32     md5
```
**Reiniciem:**
```
$ sudo systemctl restart postgresql
```
**L'usuari de gestió de la web ha de poder veure i modificar les dades de la base de dades.**
```
noticies=> CREATE USER user2 PASSWORD 'user2';
CREATE USER
noticies=> GRANT SELECT,UPDATE TO user2 ;
GRANT
```
**S'ha de poder connectar des de qualsevol ordinador de la xarxa local:**

**Dins del fitxer postgresql.conf:**
```
host    user2    noticies            10.200.244.0/24     md5
```
**Reiniciem:**
```
$ sudo systemctl restart postgresql
```
**L'usuari de notícies ha de poder veure les taules però només ha de poder modificar la taula de notícies breus.**
```
noticies=> CREATE USER user3 PASSWORD 'user3';
CREATE USER
noticies=> GRANT SELECT ON lastnews TO user3;
GRANT
noticies=> GRANT SELECT UPDATE INSERT DELETE ON noticies_breus TO user3;
GRANT
```
**L'usuari s'ha de poder connectar des de qualsevol lloc.**

**Dins del fitxer postgresql.conf:**
```
host    user3   noticies            0.0.0.0/0     md5
```
**Reiniciem:**
```
$ sudo systemctl restart postgresql
```
**L'usuari d'articles ha de poder veure les taules però només ha de poder modificar la taula d'articles.**
```
noticies=> CREATE USER user4 PASSWORD 'user4';
CREATE USER
noticies=> GRANT SELECT ON articles TO user4;
GRANT
```
**Només s'ha de poder connectar des de la xarxa local.**

**Dins del fitxer postgresql.conf:**
```
host    user4   noticies            10.200.244.0/24     md5
```
**Reiniciem:**
```
$ sudo systemctl restart postgresql
```
**Comprovem el funcionament:**
**CONSOLA 1: (PODRÀ ACCEDIR JA QUE TÉ PERMISOS PER ACCEDIR DES DE QUALSEVOL LLOC)**
```
$ psql -h 127.0.0.1 -U admin noticies
```
**CONSOLA 2: (NO PODRÀ JA QUE TÉ LIMITAT L'ACCÉS PER NOMÉS ENTRAR DES DE UN LLOC)**
```
$ psql -h 127.0.0.1 -U admin noticies
```
```
noticies=> ADD COLUMN exemple varchar(1) TO articles;
```
**PODRÀ JA QUE TÉ ELS PERMISOS NECESSARIS**
```
noticies=> SELECT *
             FROM lastnews;
```
**AQUEST ORDINADOR ESTÀ DINS DE LA MATEIXA XARXA LOCAL (10.200.244.204), PODRÀ ACCEDIR.**
```
$ psql -h 10.200.244.205 -U user4 noticies
```
**AQUEST ORDINADOR ESTÀ DINS DE LA MATEIXA XARXA LOCAL (10.200.244.206), PODRÀ ACCEDIR.**
```
$ psql -h 10.200.244.205 -U user4 noticies
```
**AQUEST ORDINADOR ESTÀ DESDE UNA IP DIFERENT (10.200.243.50), NO PODRÀ ACCEDIR.**
```
$ psql -h 10.200.244.205 -U user4 noticies
```
**AQUEST ORDINADOR ESTÀ DINS DE LA MATEIXA XARXA LOCAL (10.200.244.226), PODRÀ ACCEDIR**
```
$ psql -h 10.200.244.205 -U user3 noticies
```
**AQUEST ORDINADOR ESTÀ DINS DE LA MATEIXA XARXA LOCAL (10.200.244.232), PODRÀ ACCEDIR.**
```
$ psql -h 10.200.244.205 -U user3 noticies
```
**AQUEST ORDINADOR ESTÀ DINS DE LA MATEIXA XARXA LOCAL (10.200.244.230), PODRÀ ACCEDIR**
```
$ psql -h 10.200.244.205 -U user2 noticies
```
**AQUEST ORDINADOR ESTÀ DINS DE LA MATEIXA XARXA LOCAL (10.200.244.231), PODRÀ ACCEDIR.**
```
$ psql -h 10.200.244.205 -U user2 noticies
```
**AQUEST ORDINADOR ESTÀ DESDE UNA IP DIFERENT (10.200.243.40), NO PODRÀ ACCEDIR.**
```
$ psql -h 10.200.244.205 -U user2 noticies
```
**AQUEST ORDINADOR ESTÀ DESDE UNA IP DIFERENT (10.200.243.40), NO PODRÀ ACCEDIR.**
```
$ psql -h 10.200.244.228 -U user2 noticies
```

```
noticies=> SET ROLE user4;
SET ROLE
```
**PODRÀ JA QUE TE ELS PERMISOS PER FER AQUESTA ACCIÓ.**
```
noticies=> SELECT *
             FROM articles;
```
**PODRÀ JA QUE TE ELS PERMISOS PER FER AQUESTA ACCIÓ.**
```
noticies=> SELECT *
             FROM lastnews;
```
**PODRÀ JA QUE TE ELS PERMISOS PER FER AQUESTA ACCIÓ.**
```
noticies=> UPDATE articles
              SET description = '12345';
UPDATE
```
**NO PODRÀ JA QUE NO TE PERMISOS PER MODIFICAR EL CAMP EN QÜESTIÓ.**
```
noticies=> UPDATE lastnews
              SET noticies_breus='prova';
```
```
noticies=> \q
```
```
noticies=> SET ROLE user2;
SET ROLE
```
**PODRÀ JA QUE TE ELS PERMISOS PER FER AQUESTA ACCIÓ.**
```
noticies=> SELECT *
             FROM articles;
```
**PODRÀ JA QUE TE ELS PERMISOS PER FER AQUESTA ACCIÓ.**
```
noticies=> SELECT *
             FROM lastnews;
```
**PODRÀ JA QUE TE ELS PERMISOS PER FER AQUESTA ACCIÓ.**
```
noticies=> UPDATE articles
              SET description='12344';
UPDATE
```
**PODRÀ JA QUE TE ELS PERMISOS PER FER AQUESTA ACCIÓ.**
```
noticies=> UPDATE lastnews
              SET noticies_breus = 'prova2';
UPDATE
```
```
noticies=> \q
```
```
noticies=> SET ROLE user3;
SET ROLE
```
**PODRÀ JA QUE TE ELS PERMISOS PER FER AQUESTA ACCIÓ.**
```
noticies=> SELECT *
             FROM articles;
```
**PODRÀ JA QUE TE ELS PERMISOS PER FER AQUESTA ACCIÓ.**
```
noticies=> SELECT *
             FROM lastnews;
```
**NO PODRÀ JA QUE NO TE PERMISOS PER MODIFICAR EL CAMP EN QÜESTIÓ.**
```
noticies=> UPDATE articles
              SET description='12333';
ERROR
```
**PODRÀ JA QUE TE ELS PERMISOS PER FER AQUESTA ACCIÓ.**
```
noticies=> UPDATE lastnews
              SET noticies_breus='prova3';
UPDATE
```
```
noticies=> \q
```

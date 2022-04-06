# Aaron Andal 
# Examen M02 Transacciones - DCL - Backup - Acceso y bloqueos
# 06.04.22

[INDEX:](file:///usr/share/doc/postgresql-doc-13/html/index.html)

[CONCURRENCIA:](file:///usr/share/doc/postgresql-doc-13/html/mvcc.html)

[TRANSACCIONES:](file:///usr/share/doc/postgresql-doc-13/html/transaction-iso.html)

[ACCES-LOCK:](file:///usr/share/doc/postgresql-doc-13/html/explicit-locking.html)

[ROLE MEMBERS:](file:///usr/share/doc/postgresql-doc-13/html/role-membership.html)

[CLIENT AUTHENTICATION - PG_HBA CONF:](file:///usr/share/doc/postgresql-doc-13/html/auth-pg-hba-conf.html)

[BACKUP:](file:///usr/share/doc/postgresql-doc-13/html/backup-dump.html)

__Ho faré amb Contenidors DOCKER la primera part__

`sudo docker network create 2hisx`

`sudo docker run --rm --name postgres0 -h postgres0 --net 2hisx -it keshikid03/mykeshipostgres:latest`

> IP: 172.18.0.2/16

`sudo docker run --rm --name postgres1 -h postgres1 --net 2hisx -it keshikid03/mykeshipostgres:latest`

> IP: 172.18.0.3/16

> DOCKER NETWORK: 172.18.0.0/16 - 2HISX

`service postgresql start`

# 1 Exercici 1

Expliqueu les modificacions que s'han de fer en un sistema gestor de bases de dades postgresql per tal que:

Els usuaris __no especificats__ `no` s'han de poder connectar a __cap base__ de dades des de cap adreça IPv4.

Existeixi un usuari __anomenat "a10"__ amb contrasenya "10" guardada al sistema gestor de bases.

Existeixi un altre usuari anomenat __"b20"__ amb contrasenya __"20"__ guardada al sistema gestor de bases de dades.

L'usuari __"a10"__ ha de poder accedir a qualsevol __base de dades __usant la contrasenya des de qualsevol adreça IP de la xarxa __10.1.0.0/16__.

L'usuari __"a10"__ ha de poder accedir a la base de dades amb el mateix nom que l'usuari __sense usar contrasenya__ des de l'adreça IP 10.1.2.3.

L'usuari __"a10"__ no __ha de poder accedir des__ de qualsevol altre lloc que no siguin els __anteriorment especificats__.

L'usuari __"b20"__ no ha de poder accedir a la base de dades __"b"__ des de les adreces IP de la xarxa 10.1.2.0/24.

L'usuari __"b20"__ ha de poder accedir a qualsevol base de dades des de qualsevol altre lloc __amb contrasenya__.

L'usuari "b20" no ha de poder accedir a partir del 6 d'abril de 2022.

Expliqueu també com comprovaríeu el correcte funcionament.


```sql
-- Amb l'usuari root modifiquem el /etc/postgresql/13/main/pg_hba.conf (Cada exercici estarà separar excepte si el demanen)
--
-- Els usuaris __no especificats__ `no` s'han de poder connectar a __cap base__ de dades des de cap adreça IPv4.
host    all     all     0.0.0.0/0       reject

-- (1) Existeixi un usuari __anomenat "a10"__ amb contrasenya "10" guardada al sistema gestor de bases.
host    all     a10     172.18.0.3      md5

-- 172.18.0.3/16 es un altre contenidor Docker amb postgres

-- (2) Existeixi un altre usuari anomenat __"b20"__ amb contrasenya __"20"__ guardada al sistema gestor de bases de dades.
host    all     b20     172.18.0.3      md5

-- 172.18.0.3/16 es un altre contenidor Docker amb postgres


-- (3) L'usuari "a10" ha de poder accedir a qualsevol base de dades usant la contrasenya des de qualsevol adreça IP de la xarxa 10.1.0.0/16.
host    all     a10     10.1.0.0/16     md5


-- (4) L'usuari __"a10"__ ha de poder accedir a la base de dades amb el mateix nom que l'usuari __sense usar contrasenya__ des de l'adreça IP 10.1.2.3.
host    a10     a10     10.1.2.3/32     trust


-- (5) L'usuari "a10" no ha de poder accedir des de qualsevol altre lloc que no siguin els anteriorment especificats.
host    all     a10     10.1.2.3/32       trust
host    all     a10     10.1.0.0/16     reject
-- L'ordre importa, si posem primer el REJECT, farà el reject de tot i no podrà accedir cap dispositiu de la xarxa 10.1.0.0/16


-- (6) L'usuari "b20" no ha de poder accedir a la base de dades "b" des de les adreces IP de la xarxa 10.1.2.0/24.
host    b     b20     10.1.2.0/24       reject


-- (7) L'usuari "b20" ha de poder accedir a qualsevol base de dades des de qualsevol altre lloc amb contrasenya.
host    all     b20     0.0.0.0/0      md5

-- (8) L'usuari "b20" no ha de poder accedir a partir del 6 d'abril de 2022.
host    all     b20     172.18.0.3/16 

-- 172.18.0.3/16 es un altre contenidor Docker amb postgres
--

--



-- També modifiquem el postgresql.conf

listen_address = '*'


-- Reiniciem el postgresql cada cop que hi fem una modificació

systemctl restart postgresql
```

## CREATE & ALTERS

```sql
sudo -u psql template1;

-- (1) Crear l'usuari a10
CREATE USER a10 WITH PASSWORD '10';
```

```sql
sudo -u psql template1;

-- (2) Crear l'usuari b20
CREATE USER b20 WITH PASSWORD '20';
```

```sql
sudo -u psql template1;

-- (4) Crear la database de l'usuari a10
CREATE DATABASE a10;
```

```sql
sudo -u psql template1;

-- (8) L'usuari "b20" no ha de poder accedir a partir del 6 d'abril de 2022.
ALTER USER b20 VALID UNTIL '2022-04-06';
```


# 2 Exercici 2

Suposant que tenim una base de dades amb __3 taules__ anomenades __"proveidors"__, __"productes"__ i __"clients"__ propietat de l'usuari __"distribuidor"__. 

```sql
sudo -u postgres psql template1


CREATE DATABASE empresa;

\c empresa

-- Accedim a la BD

CREATE USER distribuidor WITH PASSWORD 'distribuidor';

CREATE TABLE proveidors(
    -- DDL SENTENCE
);

CREATE TABLE productes (

    -- DDL SENTENCE
);

CREATE TABLE clients (
    -- DDL SENTENCE
);

ALTER TABLE proveidors OWNER TO distribuidor;
ALTER TABLE productes OWNER TO distribuidor;
ALTER TABLE clients OWNER TO distribuidor;
```


Quines sentències s'han d'executar per implementar el següent escenari:

Un usuari anomenat __"admin"__ amb poders absoluts.

```sql
CREATE ROLE admin WITH PASSWORD 'admin' LOGIN SUPERUSER;

-- Comprobació

template1=# CREATE ROLE admin WITH PASSWORD 'admin' SUPERUSER;
CREATE ROLE

\du --> Veure usuaris

 Role name |                         Attributes                         | Member of 
-----------+------------------------------------------------------------+-----------
 admin     | Superuser                                                  | {}
```

Un usuari anomenat "gestor" que ha de poder modificar les dades i l'estructura de la base de dades, només ha de poder realitzar 2 connexions concurrents.

```sql
CREATE USER gestor WITH PASSWORD 'gestor' CONNECTION LIMIT 2 CREATEDB; 
CREATE ROLE

--

GRANT UPDATE, DELETE, INSERT, SELECT ON ALL TABLES IN SCHEMA public TO gestor;
GRANT


-- Comprobació

\du

 gestor       | Create DB                                                 +| {}
              | 2 connections  
```

Un usuari anomenat __"lectura"__ que només ha de poder llegir les dades de la base de dades.

```SQL
CREATE USER lectura WITH PASSWORD 'lectura';

\du

 lectura      |                                                            | {}


GRANT SELECT ON ALL TABLES IN SCHEMA public TO lectura;

CREATE ROLE
GRANT

```

Un usuari anomenat "compres" que ha de poder __consultar tota la base de dades__ però només ha de poder modificar (afegir, editar i esborrar) les dades de les taules __"proveidors" i "productes"__. + 

```sql
CREATE USER compres WITH PASSWORD 'compres';

GRANT SELECT, UPDATE , DELETE , INSERT ON proveidors TO lectura;
GRANT

GRANT SELECT, UPDATE , DELETE , INSERT ON productes TO lectura;
GRANT
```

Un usuari anomenat __"vendes"__ que ha de poder consultar i modificar __(afegir, editar i esborrar) __ les dades de la taula "clients", només ha de poder modificar (editar) la columna "estoc" de la taula "productes" especificant quin producte a partir de la columna "id_prod" i no ha de poder veure les dades de la taula "proveidors" (assegurar-se que se li treu aquest privilegi).

```sql
CREATE USER vendes WITH PASSWORD 'vendes';

GRANT SELECT, UPDATE , DELETE , INSERT ON clients TO vendes;

GRANT UPDATE (estoc) ON productes IN SCHEMA public TO vendes;

REVOKE SELECT ON proveidors to vendes;
```

Expliqueu també com comprovaríeu el correcte funcionament.

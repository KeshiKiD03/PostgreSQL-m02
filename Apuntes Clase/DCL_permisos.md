# Data Control Language (DCL):  permisos

DCL és un subllenguatge dintre de SQL que permet a l'administrador de la BD
controlar l'accés a les dades d'aquesta.


## GRANT

Per veure privilegis concedits:

```
\dp
```

Donar permisos a taules:

```
GRANT { { SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER }
    [, ...] | ALL [ PRIVILEGES ] }
    ON { [ TABLE ] table_name [, ...]
         | ALL TABLES IN SCHEMA schema_name [, ...] }
    TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
```

Les bases de dades tenen esquemes i els esquemes tenen les taules. Si no hem creat un esquema explícitament, les nostres taules estan a l'esquema de nom *public*.


**Exemples:**

Permetre veure, inserir i esborrar registres de la taula repventas a l'usuari rrhh:

```
GRANT SELECT, INSERT, DELETE ON repventas TO rrhh;
```

Permetre la gestió de totes les dades de totes les taules a l'usuari _tworker_

```
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tworker;
```

Donar permisos a columnes:

```
GRANT { { SELECT | INSERT | UPDATE | REFERENCES } ( column_name [, ...] )
    [, ...] | ALL [ PRIVILEGES ] ( column_name [, ...] ) }
    ON [ TABLE ] table_name [, ...]
    TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
```

**Exemple:**

Permetre veure i modificar les columnes objectiu i vendes de la taula oficines a l'usuari director

```
GRANT SELECT, UPDATE (objectiu, vendes) ON oficinas TO director;
```

Donar permisos a bases de dades:

```
GRANT { { CREATE | CONNECT | TEMPORARY | TEMP } [, ...] | ALL [ PRIVILEGES ] }
    ON DATABASE database_name [, ...]
    TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
```

Donar permisos a esquemes:

```
GRANT { { CREATE | USAGE } [, ...] | ALL [ PRIVILEGES ] }
    ON SCHEMA schema_name [, ...]
    TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
```

Donar els permisos d'un rol a un altre ("afegir" un rol a un altre):

```
GRANT rol_pare [, ...] TO rol_fill [, ...]
```

Per tal de tenir tots els permisos en una base de dades el més fàcil és ser propietaris d'aquesta i de totes les seves taules. Si han de tenir permisos dos usuaris, es pot crear un rol (que simuli un grup), fer que aquest rol sigui el propietari de la base de dades i la taula i fer que els dos usuaris tinguin els permisos d'aquest grup.

**Exemple:**

Donar tots els permisos de la base de dades training a l'usuari tmanager i a l'usuari tadmin:

```
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

Treure permisos permisos de taules:
```
REVOKE [ GRANT OPTION FOR ]
    { { SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER }
    [, ...] | ALL [ PRIVILEGES ] }
    ON { [ TABLE ] table_name [, ...]
         | ALL TABLES IN SCHEMA schema_name [, ...] }
    FROM { [ GROUP ] role_name | PUBLIC } [, ...]
    [ CASCADE | RESTRICT ]
```

Treure permisos a columnes:
```
REVOKE [ GRANT OPTION FOR ]
    { { SELECT | INSERT | UPDATE | REFERENCES } ( column_name [, ...] )
    [, ...] | ALL [ PRIVILEGES ] ( column_name [, ...] ) }
    ON [ TABLE ] table_name [, ...]
    FROM { [ GROUP ] role_name | PUBLIC } [, ...]
    [ CASCADE | RESTRICT ]
```

Treure permisos de bases de dades:
```
REVOKE [ GRANT OPTION FOR ]
    { { CREATE | CONNECT | TEMPORARY | TEMP } [, ...] | ALL [ PRIVILEGES ] }
    ON DATABASE database_name [, ...]
    FROM { [ GROUP ] role_name | PUBLIC } [, ...]
    [ CASCADE | RESTRICT ]
```

Treure permisos d'esquemes:
```
REVOKE [ GRANT OPTION FOR ]
    { { CREATE | USAGE } [, ...] | ALL [ PRIVILEGES ] }
    ON SCHEMA schema_name [, ...]
    FROM { [ GROUP ] role_name | PUBLIC } [, ...]
    [ CASCADE | RESTRICT ]
```

Donar els permisos d'un rol a un altre ("afegir" un rol a un altre):
```
REVOKE [ ADMIN OPTION FOR ]
    role_name [, ...] FROM role_name [, ...]
    [ CASCADE | RESTRICT ]
```

S'ha d'anar amb compte perquè per defecte tothom té els privilegis de USAGE i CREATE en l'esquema PUBLIC. Per treure el privilegi de crear hauríem de fer:

```
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
```

## Altres permisos

Però tot està relacionat, de manera que el DDL també te algunes instruccions que ens permet gestionar l'accés a la BD.

Per exemple, si volem:

+ canviar de propietari una base de dades:

```
ALTER DATABASE db_name OWNER TO username;
```

+ canviar de propietari les taules d'una base de dades:

```
ALTER TABLE table_name OWNER TO username;
```

**Exemple:**

+ Donar tots els permisos de la base de dades training a l'usuari tmanager:

```
ALTER DATABASE training OWNER TO tmanager;
ALTER TABLE clientes OWNER TO tmanager;
ALTER TABLE oficinas OWNER TO tmanager;
ALTER TABLE repventas OWNER TO tmanager;
ALTER TABLE productos OWNER TO tmanager;
ALTER TABLE pedidos OWNER TO tmanager;
```


## LINKS

+ [Resum de receptes, tot i que fa referència a un VPS, no fa res diferent del que fem nosaltres](https://www.digitalocean.com/community/tutorials/how-to-use-roles-and-manage-grant-permissions-in-postgresql-on-a-vps-2)



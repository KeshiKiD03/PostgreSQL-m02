# KESHI CHEATSHEET [14]

# Aaron Andal

# Còpies de seguretat i restauració (Backup & restore)

# Backup lògic


## Eines de PostgreSQL

Quan el sistema gestor de Base de Dades Relacional (SGBDR o RDBMS en anglès) és PostgreSQL, les ordres clàssiques per fer la còpia de base de dades són:

+ `pg_dump` per copiar una base de dades del SGBDR a un fitxer script o de tipus arxiu 

+ `pg_dumpall` per copiar totes les bases de dades del SGBDR a un fitxer script
  SQL


Anàlogament, quan volem restaurar una base de dades si el fitxer destí ha estat un script SQL farem la restauració amb l'ordre `pg_restore`, mentre que si el fitxer destí és de tipus binari l'ordre a utilitzar serà `pg_restore -Fc o pg_restore -C (Si se quiere crear una nueva DataBase)`.


Anem a jugar dintre del nostre SGBDR. Respon i després *executa lesinstruccions comprovant empíricament que són correctes*.

The pg_dump supports other output formats as well. You can specify the output format using the `-F` option, where `c` means custom format archive file, `d` means directory format archive, and `t` means tar format archive file: all formats are suitable for input into `pg_restore`.


## Pregunta 1. 

Quina instrucció ens fa una còpia de seguretat lògica de la base de dades training (de tipus script SQL) ?

`pg_dump -v -Fc training > training.dump`

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_dump -v -Fc training > 25-03-22training.dump
pg_dump: last built-in OID is 16383
pg_dump: reading extensions
pg_dump: identifying extension members
pg_dump: reading schemas
pg_dump: reading user-defined tables
pg_dump: reading user-defined functions
pg_dump: reading user-defined types
pg_dump: reading procedural languages
pg_dump: reading user-defined aggregate functions
pg_dump: reading user-defined operators
pg_dump: reading user-defined access methods
pg_dump: reading user-defined operator classes
pg_dump: reading user-defined operator families
pg_dump: reading user-defined text search parsers
pg_dump: reading user-defined text search templates
pg_dump: reading user-defined text search dictionaries
pg_dump: reading user-defined text search configurations
....
```

## Pregunta 2.

El mateix d'abans però ara el destí és un directori.

`pg_dump -v -F d training -f trainingdumpdir`

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_dump -v -F d training -f trainingdumpdir

pg_dump: last built-in OID is 16383
pg_dump: reading extensions
pg_dump: identifying extension members
pg_dump: reading schemas
pg_dump: reading user-defined tables
pg_dump: reading user-defined functions
pg_dump: reading user-defined types
pg_dump: reading procedural languages
pg_dump: reading user-defined aggregate functions
pg_dump: reading user-defined operators
pg_dump: reading user-defined access methods
pg_dump: reading user-defined operator classes
pg_dump: reading user-defined operator families
pg_dump: reading user-defined text search parsers

....
```

## Pregunta 3.

El mateix d'abans però ara el destí és un fitxer tar.

`pg_dump -v -Ft training > training.tar`

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_dump -v -Ft training > training.tar
pg_dump: last built-in OID is 16383
pg_dump: reading extensions
pg_dump: identifying extension members
pg_dump: reading schemas
pg_dump: reading user-defined tables
pg_dump: reading user-defined functions
pg_dump: reading user-defined types
pg_dump: reading procedural languages
....
```

## Pregunta 4. 

El mateix d'abans però ara el destí és un fitxer tar però la base de dades és mooolt gran.

`pg_dumpall -v -Ft > training.tar`

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_dumpall -v -t > trainingAll.tar
pg_dumpall: executing SELECT pg_catalog.set_config('search_path', '', false);
pg_dumpall: executing SELECT oid, spcname, pg_catalog.pg_get_userbyid(spcowner) AS spcowner, pg_catalog.pg_tablespace_location(oid), (SELECT array_agg(acl ORDER BY row_n) FROM   (SELECT acl, row_n FROM      unnest(coalesce(spcacl,acldefault('t',spcowner)))      WITH ORDINALITY AS perm(acl,row_n)    WHERE NOT EXISTS (      SELECT 1      FROM unnest(acldefault('t',spcowner))        AS init(init_acl)      WHERE acl = init_acl)) AS spcacls)  AS spcacl, (SELECT array_agg(acl ORDER BY row_n) FROM   (SELECT acl, row_n FROM      unnest(acldefault('t',spcowner))      WITH ORDINALITY AS initp(acl,row_n)    WHERE NOT EXISTS (      SELECT 1      FROM unnest(coalesce(spcacl,acldefault('t',spcowner)))        AS permp(orig_acl)      WHERE acl = orig_acl)) AS rspcacls)  AS rspcacl, array_to_string(spcoptions, ', '),pg_catalog.shobj_description(oid, 'pg_tablespace') FROM pg_catalog.pg_tablespace WHERE spcname !~ '^pg_' ORDER BY 1
```

## Pregunta 5

Imagina que vols fer la mateixa ordre d'abans però vols optimitzar el temps d'execució. 

No pots esperar tant de temps en fer el backup. 

Quina ordre aconseguirà treballar en paral·lel? 

Fes la mateixa ordre d'abans però atacant la info de les 5 taules de la base de dades al mateix temps.

`pg_dump -F t training -j 5 | gzip > traiing_bkp4.tar.gz`

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_dump -F t training -j 5 | gzip > traiing_bkp4.tar.gz
pg_dump: error: parallel backup only supported by the directory format
```

> NO PODEMOS HACERLA PORQUE SOLO SOPORTA EL FORMATO -d de directorios

## Pregunta 6

Si no indiquem usuari ni tipus de fitxer quin és el valor per defecte?

`pg_dump --dbname=training --file=traiing_bkp4.sql`

`file training`

```
isx36579183@j05:~/Documents/m02/dataBases$ pg_dump --dbname=training --file=training_bkp4.sql

isx36579183@j05:~/Documents/m02/dataBases$ file 

training_bkp4.sql 
training_bkp4.sql: ASCII text
```

ASCII

## Pregunta 7

Fes una còpia de seguretat lògica només de la taula _comandes_ de tipus script SQL.



## Pregunta 8

Fes una còpia de seguretat lògica només de la taula _rep_vendes_ de tipus binari.

## Pregunta 9 

Elimina la taula _comandes_ de la base de dades _training_. 

## Pregunta 10

Elimina la taula *rep_vendes* de la base de dades training. 

Quina ordre restaura la taula *rep_vendes* (recorda que el fitxer és binari)

## Pregunta 11

Després de fer una còpia de tota la base de dades training en format binari, elimina-la. 

Hi ha l'ordre de bash `dropdb` (en realitat és un wrapper de DROP DATABASE). I de manera anàloga també n'hi ha l'ordre de bash `createdb`.
Sense utilitzar aquesta última i amb una única ordre restaura la base de dades training.


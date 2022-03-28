# CHEATSHEET KESHI [14]

# BACKUPS I RESTORE

# Còpies de seguretat i restauració (Backup & restore)


![imatge de Dilbert explicant com fer un recovery](comics-dilbert-hacker-more-in-comments-868986.gif)


L'assegurament de la informació és una tasca molt complexa que abarca molts
camps d'actuació. Alguns ja els hem vist al llarg del curs, bona política de
permisos dels usuaris, passwords guardats a la base de dades de postgreSQL,
oferiment de vistes en comptes de taules als usuaris o alguns tan senzills com
[tenir actualitzats els paquets de
software](http://www.securitybydefault.com/2012/06/vulnerabilidad-grave-en-mysqlmariadb.html)

En aquest tema ens centrarem en les còpies de seguretat d'una base de dades, la qual cosa ens serà
útil tant si hi ha algun problema a la base de dades, com si volem exportar la
base de dades a un altre server.


Abans de centrar-nos en els backups de bases de dades, pot ser una bona idea fer un cop d'ull als [backup's dels sistemes en general](https://gitlab.com/hisx-m05-fonaments-maquinari/uf2-public/-/raw/master/4-Backups/backups_teoria.md)


## Tipus de còpies de seguretat

Algunes recomanacions:

+ Una bona política de backup consisteix en fer la implementació d'aquesta des de
del primer dia. Sinó a més de patir el desastre, haurem de sentir els profetes del dilluns.

+ És clau estudiar de quines dades farem backups i com afectarà el temps de
restauració en el negoci per poder decidir el tipus de backup que més ens convé.


Una possible clasificació dels backups en funció de **què** desem: còpia de
seguretat lògica i còpia de seguretat física.

### Còpia de seguretat lògica

+ Una còpia de seguretat lògica conté còpies d'informació d'una base de dades
(com poden ser taules, esquemes i procedures). 

+ Aquestes còpies d'informació s'extreuen en fitxers mitjançant eines
d'exportació. I després es restauren amb eines d'importacio.

+ Si la nostra necessitat consisteix a restaurar o moure la nostra base de dades
a un altre entorn o plataforma els backups lògics són una bona opció.

+ Les dades de les taules també poden ser exportades en fitxers fent servir SQL.

+ Al backup lògic no hi haurà cap informació relacionada amb l'entorn a on està
instal·lada la base de dades.

+ Recomanable quan volem fer una migració a una altra versió d'un mateix SGBDR.

### Còpia de seguretat física

+ Es fa una còpia de tots els fitxers (físics) que defineixen la base de dades
(fitxers de dades, fitxers de control, fitxers logs, binaris ...) en un únic
element/document.

+ Aquest tipus de còpies són les recomandes per gestionar backups de SGBD de
  mida gran.


#### Quan utilitzar backup físic o lògic?

> Imaginem-nos que donem servei a una empresa amb un dels nostres productes que
consisteix en un sistema de missatges d'email que es recolza en una base de
dades. El nostre client, un dia vol recuperar un dels emails que sembla que ha
esborrat de manera accidental.

+ En aquesta situació recórrer a la restauració de tot el sistema  mitjançant un
backup físic és molt exagerat. Una recuperació d'un dels elements de la base de
dades, el que fa referència a les dades de la safata d'entrada (inbox) seria
molt més adient. Aquesta recuperació _granular_ és la que ens proporciona el
*backup lògic*.

+ D'altra banda en escenaris de *desastres totals* necessitem viatjar al passat,
aquí la nostra màquina del temps consistirà en un *backup físic*.

Una altra possible classificació dels backups en funció de **com** es fa la
còpia: cold backup i hot backup.

### Cold Backup

+ Una còpia de segureta en fred és aquella que es fa quan no hi ha cap fitxer
  de la base de dades obert. Això a PostgreSQL vol dir que el servidor s'ha de
  parar.

+ Un cop es para la base de dades es fa la còpia. Això te el desavantatge de
  que hem de parar i per tant no està disponible per als usuaris. D'altra banda
  les dades no canvien durant el procés de còpia, de manera que no hi ha
  problemes d'inconsistència quan es torna a engegar.


### Hot Backup

+ Es fa la còpia sense parar la base de dades. Recomanable en sistemes que han
  de donar servei 24h.
+ Hi ha backup's en calent que van registrant els canvis que s'han fet de
  manera paral·lela mentre es feia la còpia de seguretat. D'aquesta manera
  s'afegiexen aquests canvis a la còpia de seguretat perquè no hi hagi
  inconsistències.



## Links

+ [Database Backups 101: Logical vs Physical
  Backups](https://backup.ninja/news/Database-Backups-101-Logical-vs-Physical-Backups)

+ [What is the difference between physical and logical
  backup](https://stackoverflow.com/questions/39123563/what-is-the-difference-between-physical-and-logical-backup)

+ [Physical vs Logical Backups in
  PostgreSQL](https://supabase.com/blog/2020/07/17/postgresql-physical-logical-backups)

+ [Backup And Recovery](https://en.wikibooks.org/wiki/PostgreSQL/BackupAndRecovery)

+ [Administració d'un SGBD
  IOC](https://ioc.xtec.cat/materials/FP/Recursos/fp_asx_m10_/web/fp_asx_m10_htmlindex/WebContent/u3/a4/continguts.html)


## COMO CREAR UN SUPER USUARIO

https://tableplus.com/blog/2018/10/how-to-create-superuser-in-postgresql.html 

---------------------------------------------------------------------------------

# Còpies de seguretat i restauració (Backup & restore) // Exercicis

# Backup lògic


## Eines de PostgreSQL

Quan el sistema gestor de Base de Dades Relacional (SGBDR o RDBMS en anglès) és PostgreSQL, les ordres clàssiques per fer la còpia de base de dades són:

+ `pg_dump` per copiar una base de dades del SGBDR a un fitxer script o de tipus arxiu 

+ `pg_dumpall` per copiar totes les bases de dades del SGBDR a un fitxer script
  SQL


Anàlogament, quan volem restaurar una base de dades si el fitxer destí ha estat un script SQL farem la restauració amb l'ordre `pg_restore`, mentre que si el fitxer destí és de tipus binari l'ordre a utilitzar serà `pg_restore -Fc o pg_restore -C (Si se quiere crear una nueva DataBase)`.


Anem a jugar dintre del nostre SGBDR. Respon i després *executa lesinstruccions comprovant empíricament que són correctes*.

Man `pg_dump`

The pg_dump supports other output formats as well. You can specify the output format using the `-F` option, where `c` means custom format archive file, `d` means directory format archive, and `t` means tar format archive file: all formats are suitable for input into `pg_restore`.

```yaml
EXAMPLES
       To dump a database called mydb into a SQL-script file:

           $ pg_dump mydb > db.sql

       To reload such a script into a (freshly created) database named newdb:

           $ psql -d newdb -f db.sql

       To dump a database into a custom-format archive file:

           $ pg_dump -Fc mydb > db.dump

       To dump a database into a directory-format archive:

           $ pg_dump -Fd mydb -f dumpdir

       To dump a database into a directory-format archive in parallel with 5 worker jobs:

           $ pg_dump -Fd mydb -j 5 -f dumpdir

       To reload an archive file into a (freshly created) database named newdb:

           $ pg_restore -d newdb db.dump

       To reload an archive file into the same database it was dumped from, discarding the current contents of that database:

           $ pg_restore -d postgres --clean --create db.dump

       To dump a single table named mytab:

           $ pg_dump -t mytab mydb > db.sql

       To dump all tables whose names start with emp in the detroit schema, except for the table named employee_log:

           $ pg_dump -t 'detroit.emp*' -T detroit.employee_log mydb > db.sql

       To dump all schemas whose names start with east or west and end in gsm, excluding any schemas whose names contain the word test:

           $ pg_dump -n 'east*gsm' -n 'west*gsm' -N '*test*' mydb > db.sql

       The same, using regular expression notation to consolidate the switches:

           $ pg_dump -n '(east|west)*gsm' -N '*test*' mydb > db.sql

       To dump all database objects except for tables whose names begin with ts_:

           $ pg_dump -T 'ts_*' mydb > db.sql

       To specify an upper-case or mixed-case name in -t and related switches, you need to double-quote the name; else it will be folded to lower case
       (see Patterns below). But double quotes are special to the shell, so in turn they must be quoted. Thus, to dump a single table with a mixed-case
       name, you need something like

           $ pg_dump -t "\"MixedCaseName\"" mydb > mytab.sql

```


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

`pg_dump --dbname=training --file=training_bkp4.sql`

`file training_bkp4.sql`

```
isx36579183@j05:~/Documents/m02/dataBases$ pg_dump --dbname=training --file=training_bkp4.sql

isx36579183@j05:~/Documents/m02/dataBases$ file training_bkp4 sql 
training_bkp4.sql: ASCII text
```

> ASCII

## Pregunta 7

Fes una còpia de seguretat lògica només de la taula _comandes_ de tipus script SQL.

```yaml
pg_dump --help | grep "\-t, "
  -t, --table=PATTERN          dump the specified table(s) only
```

```yaml
pg_dump --dbname=training -t comandes --username=isx36579183 --format=plain --file=training_bkp5.sql
```
```yaml
isx36579183@j05:~/Documents/m02/dataBases$ ls -la
total 76
drwxr-xr-x  3 isx36579183 hisx2  4096 Mar 25 08:40 .
drwx--x--x 21 isx36579183 hisx2  4096 Mar 25 08:34 ..
drwxr-xr-x  2 isx36579183 hisx2  4096 Mar 25 08:18 backups
-rw-r--r--  1 isx36579183 hisx2 26112 Mar 25 08:28 training_bkp2.tar
-rw-r--r--  1 isx36579183 hisx2  4425 Mar 25 08:31 training_bkp3.tar.gz
-rw-r--r--  1 isx36579183 hisx2  9876 Mar 25 08:37 training_bkp4.sql
-rw-r--r--  1 isx36579183 hisx2  3289 Mar 25 08:40 training_bkp5.sql
-rw-r--r--  1 isx36579183 hisx2  9876 Mar 25 08:37 training_bkp.sql
```

## Pregunta 8

Fes una còpia de seguretat lògica només de la taula `_rep_vendes_` de `tipus binari`.

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_dump --dbname=training -t rep_vendes --username=isx36579183 --format=custom --file=training_bkp6.bin
```

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ ls -la
total 80
drwxr-xr-x  3 isx36579183 hisx2  4096 Mar 25 08:52 .
drwx--x--x 21 isx36579183 hisx2  4096 Mar 25 08:34 ..
drwxr-xr-x  2 isx36579183 hisx2  4096 Mar 25 08:18 backups
-rw-r--r--  1 isx36579183 hisx2 26112 Mar 25 08:28 training_bkp2.tar
-rw-r--r--  1 isx36579183 hisx2  4425 Mar 25 08:31 training_bkp3.tar.gz
-rw-r--r--  1 isx36579183 hisx2  9876 Mar 25 08:37 training_bkp4.sql
-rw-r--r--  1 isx36579183 hisx2  3289 Mar 25 08:42 training_bkp5.sql
-rw-r--r--  1 isx36579183 hisx2  3330 Mar 25 08:51 training_bkp6.bin
-rw-r--r--  1 isx36579183 hisx2  9876 Mar 25 08:37 training_bkp.sql

```

## Pregunta 9

Elimina la taula _comandes_ de la base de dades _training_.

Quina ordre restaura la taula *comandes*:

```sql
training=> \d
             List of relations
 Schema |    Name    | Type  |    Owner
--------+------------+-------+-------------
 public | clients    | table | isx36579183
 public | comandes   | table | isx36579183
 public | oficines   | table | isx36579183
 public | productes  | table | isx36579183
 public | rep_vendes | table | isx36579183
(5 rows)
```

```sql
training=> DROP TABLE comandes;
DROP TABLE
```
```sql
training=> \d
             List of relations
 Schema |    Name    | Type  |    Owner
--------+------------+-------+-------------
 public | clients    | table | isx36579183
 public | oficines   | table | isx36579183
 public | productes  | table | isx36579183
 public | rep_vendes | table | isx36579183
(4 rows)
```
```yaml
isx36579183@j05:~/Documents/m02/dataBases$ psql --dbname=training --username=isx36579183 < training_bkp5.sql

training=# \d
             List of relations
 Schema |    Name    | Type  |    Owner
--------+------------+-------+-------------
 public | clients    | table | isx36579183
 public | comandes   | table | isx36579183
 public | oficines   | table | isx36579183
 public | productes  | table | isx36579183
 public | rep_vendes | table | isx36579183
(5 rows)
```

## Pregunta 10

Fes un cop d'ull al backup tar creat a l'exercici 3 (per exemple amb l'ordre `tar xvf` ). 

Creus que a partir d'aquest fitxer es `podria restaurar` només una taula? 

Si és així, escriu i comprova-ho amb rep_vendes (abans hauràs d'eliminar la taula amb `DROP`)

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ tar xvf training_bkp2.tar
toc.dat
3020.dat
3021.dat
3018.dat
3017.dat
3019.dat
restore.sql
```

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ ls -la \*.dat restore\*
-rw------- 1 isx36579183 hisx2  821 Mar 25 08:28 3017.dat
-rw------- 1 isx36579183 hisx2  206 Mar 25 08:28 3018.dat
-rw------- 1 isx36579183 hisx2  729 Mar 25 08:28 3019.dat
-rw------- 1 isx36579183 hisx2  671 Mar 25 08:28 3020.dat
-rw------- 1 isx36579183 hisx2 1427 Mar 25 08:28 3021.dat
-rw------- 1 isx36579183 hisx2 7328 Mar 25 08:28 restore.sql
-rw------- 1 isx36579183 hisx2 8266 Mar 25 08:28 toc.dat

training=# \d
             List of relations
 Schema |    Name    | Type  |    Owner
--------+------------+-------+-------------
 public | clients    | table | isx36579183
 public | comandes   | table | isx36579183
 public | oficines   | table | isx36579183
 public | productes  | table | isx36579183
 public | rep_vendes | table | isx36579183
(5 rows)
```

```sql
training=# DROP TABLE rep_vendes CASCADE;
NOTICE:  drop cascades to 3 other objects
DETAIL:  drop cascades to constraint fk_clients_rep_clie on table clients
drop cascades to constraint fk_comandes_rep on table comandes
drop cascades to constraint fk_oficina_director on table oficines
DROP TABLE

training=# \d
            List of relations
 Schema |   Name    | Type  |    Owner
--------+-----------+-------+-------------
 public | clients   | table | isx36579183
 public | comandes  | table | isx36579183
 public | oficines  | table | isx36579183
 public | productes | table | isx36579183
(4 rows)
```


```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_restore -d training -Ft -t rep_vendes < fitxer.tar

training=# \d
             List of relations
 Schema |    Name    | Type  |    Owner
--------+------------+-------+-------------
 public | clients    | table | isx36579183
 public | comandes   | table | isx36579183
 public | oficines   | table | isx36579183
 public | productes  | table | isx36579183
 public | rep_vendes | table | isx36579183
(5 rows)
```

## Pregunta 11

Elimina la taula *rep_vendes* de la base de dades training.

Quina ordre restaura la taula *rep_vendes* (recorda que el fitxer és binari)

```yaml
training=# \d
             List of relations
 Schema |    Name    | Type  |    Owner
--------+------------+-------+-------------
 public | clients    | table | isx36579183
 public | comandes   | table | isx36579183
 public | oficines   | table | isx36579183
 public | productes  | table | isx36579183
 public | rep_vendes | table | isx36579183
(5 rows)
```

```sql
training=# DROP TABLE rep_vendes CASCADE;
NOTICE:  drop cascades to 3 other objects
DETAIL:  drop cascades to constraint fk_clients_rep_clie on table clients
drop cascades to constraint fk_oficina_director on table oficines
drop cascades to constraint fk_comandes_rep on table comandes
DROP TABLE

training=# \d
            List of relations
 Schema |   Name    | Type  |    Owner
--------+-----------+-------+-------------
 public | clients   | table | isx36579183
 public | comandes  | table | isx36579183
 public | oficines  | table | isx36579183
 public | productes | table | isx36579183
(4 rows)
```

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_restore -Fc -d training training_bkp6.bin

training=# \d
             List of relations
 Schema |    Name    | Type  |    Owner
--------+------------+-------+-------------
 public | clients    | table | isx36579183
 public | comandes   | table | isx36579183
 public | oficines   | table | isx36579183
 public | productes  | table | isx36579183
 public | rep_vendes | table | isx36579183
(5 rows)
```

## Pregunta 12

Després de fer una `còpia` de tota la base de dades training en format binari, elimina-la.

Hi ha l'ordre de bash `dropdb` (en realitat és un wrapper de DROP DATABASE). I de manera anàloga també n'hi ha l'ordre de bash `createdb`.

Sense utilitzar aquesta última i amb una única ordre restaura la base de dades `training`.

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_dump --dbname=training format=custom --file=training_bkp7.bin

isx36579183@j05:~/Documents/m02/dataBases$ ls -la
total 92
drwxr-xr-x  3 isx36579183 hisx2  4096 Mar 25 09:08 .
drwx--x--x 21 isx36579183 hisx2  4096 Mar 25 08:34 ..
drwxr-xr-x  2 isx36579183 hisx2  4096 Mar 25 08:18 backups
-rw-r--r--  1 isx36579183 hisx2 26112 Mar 25 08:28 training_bkp2.tar
-rw-r--r--  1 isx36579183 hisx2  4425 Mar 25 08:31 training_bkp3.tar.gz
-rw-r--r--  1 isx36579183 hisx2  9876 Mar 25 08:37 training_bkp4.sql
-rw-r--r--  1 isx36579183 hisx2  3289 Mar 25 08:42 training_bkp5.sql
-rw-r--r--  1 isx36579183 hisx2  3330 Mar 25 08:51 training_bkp6.bin
-rw-r--r--  1 isx36579183 hisx2  9013 Mar 25 09:08 training_bkp7.bin
-rw-r--r--  1 isx36579183 hisx2  9876 Mar 25 08:37 training_bkp.sql
```

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ dropdb training
```

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_restore -C -f training_bkp7.bin

training=# \d
             List of relations
 Schema |    Name    | Type  |    Owner
--------+------------+-------+-------------
 public | clients    | table | isx36579183
 public | comandes   | table | isx36579183
 public | oficines   | table | isx36579183
 public | productes  | table | isx36579183
 public | rep_vendes | table | isx36579183
(5 rows)
```

## Pregunta 13

Per defecte, si n'hi ha un error quan fem la `restauració` psql `ignora` l'`error` i continuarà `executant`-se. Si volem que pari just quan hi hagi l'errada quina opció afegirem a l'ordre psql:

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_restore -Fc -d -e training training_bkp8.bin

-e (exit-on-error) --> A l'hora que envia les comandes sql, ens envía un error.
```

## Pregunta 14

Si es vol que la `restauració` es faci en `mode` `transacció`, és a dir o es `fa` `tot` o `no` es `fa` `res`, com seria l'ordre?

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_restore -aC backup.sql
```

## Pregunta 15

Quina ordre em permet fer un `backup` de `totes` les `bases` de `dades` d'un `cluster`? Es necessita ser l'`administrador` de la base de dades?

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_dumpall > backup_all_db.sql

Sí, requereix de permisos d'administrador.
```

## Pregunta 16

Quina ordre em permet `restaurar` totes les `bases` de `dades` d'un `cluster` a partir del fitxer `backup_all_db.sql` ? Es `necessita` ser l'`administrador` de la base de dades?

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ psql < backup_all_db.sql

Sí, requereix de permisos d'administrador.
```

## Pregunta 17

Quina ordre em `permet` fer una còpia de `seguretat` de tipus `tar` la `base` de `dades` `training` que es troba a `192.168.0.123` ? Canvia la IP per la de l'ordinador del teu company.

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_dump -h 10.200.244.206 -U isx36579183 -F t training > training_bkp_company.tar

isx36579183@j05:~/Documents/m02/dataBases$ tar tf training_bkp_company.tar
toc.dat
3020.dat
3021.dat
3018.dat
3017.dat
3019.dat
restore.sql
```

## Pregunta 18

Es pot fer un backup de la base de dades `training` del `server1` i que es `restauri` on the f`ly a `server2`?

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ pg_dump -h 10.200.244.229 training > training_bkp2_company.sql || psql training < training_bkp2_company.sql
```

```yaml
isx36579183@j05:~/Documents/m02/dataBases$ cat training_bkp2_company.sql | less
--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1)
-- Dumped by pg_dump version 13.4 (Debian 13.4-0+deb11u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';
...
:
```


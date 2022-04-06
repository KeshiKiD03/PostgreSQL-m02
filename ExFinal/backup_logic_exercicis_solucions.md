# Backup lògic


## Eines de PostgreSQL

Quan el sistema gestor de Base de Dades Relacional (SGBDR o RDBMS en anglès) és
PostgreSQL, les ordres clàssiques per fer la còpia de base de dades són:

+ `pg_dump` per copiar una base de dades del SGBDR a un fitxer script o de
  tipus arxiu 

+ `pg_dumpall` per copiar totes les bases de dades del SGBDR a un fitxer script
  SQL


Anàlogament, quan volem restaurar una base de dades si el fitxer destí ha estat un script SQL farem la restauració amb l'ordre `psql`, mentre que si el fitxer destí és de tipus binari l'ordre a utilitzar serà `pg_restore`.

![diagrama backup i restauració lògica amb Postgresql](PostgreSQL_dump_restore.svg.png)


Anem a jugar dintre del nostre SGBDR. Respon i després *executa les
instruccions comprovant empíricament que són correctes*.


## Pregunta 1. 

Quina instrucció ens fa una còpia de seguretat lògica de la base de dades training (de tipus script SQL) ?

```
pg_dump -d training -f training.sql
```

## Pregunta 2.

El mateix d'abans però ara el destí és un directori.

```
pg_dump -d training -F d training -f training_dir
```

## Pregunta 3.

El mateix d'abans però ara el destí és un fitxer tar.

```
pg_dump training -F t  -f training.tar
```


## Pregunta 4. 

El mateix d'abans però ara el destí és un fitxer tar però la base de dades és mooolt gran.

I com restauraries la base de dades a partir del fitxer obtingut.


A més de l'opció -f nom_de_fitxer (o --filename nom_de_fitxer) també podem
redirigir a la sortida estàndard. En aquest cas ho farem així i abans farem
servir una pipe per comprimir:

```
pg_dump  training2 -F t | gzip >  training2.tgz
```

Per restaurar:

```
gunzip -c training2.tgz | pg_restore -d training
```

Recordeu que -c és perquè gunzip en comptes de descomprimir i crear un fitxer
descomprimit al directori actual, descomprimeixi i escrigui el seu contingut
per la sortida estàndard ( i en aquest cas ho reculli pg_restore per l'entrada
estàndard gràcies a la pipe).


## Pregunta 5

Imagina que vols fer la mateixa ordre d'abans però vols optimitzar el temps
d'execució. No pots esperar tant de temps en fer el backup. Quina ordre
aconseguirà treballar en paral·lel? Fes la mateixa ordre d'abans però atacant
la info de les 5 taules de la base de dades al mateix temps.


La opció és `-j 5`.

Si ho intentem fer ens mostra un missatge, que es pot confirmar al `man`, a on
diu que aquesta opció només funciona per a directoris.


## Pregunta 6

Si no indiquem usuari ni tipus de fitxer quin és el valor per defecte?


El tipus de fitxer serà un fitxer de text (plain text) i l'usuari el que
executa l'ordre.


## Pregunta 7

Fes una còpia de seguretat lògica només de la taula _comandes_ de tipus script SQL.

```
pg_dump training -t comandes -f comandes.sql
```

## Pregunta 8

Fes una còpia de seguretat lògica només de la taula _rep_vendes_ de tipus binari.

```
pg_dump training2 -t rep_vendes -F c -f rep_vendes.dat
```

## Pregunta 9 

Elimina la taula _comandes_ de la base de dades _training_. 

Quina ordre restaura la taula _comandes_? (recorda que el fitxer és un script SQL) 

```
psql -d training < comandes.sql
```

## Pregunta 10

Fes un cop d'ull al backup tar creat a l'exercici 3 (per exemple amb l'ordre `tar xvf` ). Creus que a partir d'aquest fitxer es podria restaurar només una taula? Si és així, escriu i comprova-ho amb rep_vendes (abans hauràs d'eliminar la taula amb `DROP`)


Sí que es pot (el tar ens mostra diferents fitxers, alguns amb les dades de la
taula i altres amb l'estructura de les taules)

```
pg_restore -d training -t rep_vendes training.tar 
```


## Pregunta 11

Elimina la taula *rep_vendes* de la base de dades training. 

Quina ordre restaura la taula *rep_vendes* (recorda que el fitxer és binari)

```
pg_restore -d training -F c -t rep_vendes  < rep_vendes.dat
```


## Pregunta 12

Després de fer una còpia de tota la base de dades training en format binari, elimina-la. 

Hi ha l'ordre de bash `dropdb` (en realitat és un wrapper de DROP DATABASE). I de manera anàloga també n'hi ha l'ordre de bash `createdb`.
Sense utilitzar aquesta última i amb una única ordre restaura la base de dades training.


L'interessant d'aquest exercici és que un cop hem descobert que l'opció -C crea la base de dades si no està creada, la temptació és fer:


```
pg_restore -C -d training training.dat
```

Però clar per crear la base de dades primer ens hem de connectar a una base de
dades que existeixi, com per exemple template1, i des d'allà si que podrà
crear-se training.

Així doncs una possible solució seria:

```
pg_restore -C  -d template1  training2.dat
```

## Pregunta 13

Per defecte, si n'hi ha un error quan fem la restauració `psql` ignora l'error i continuarà executant-se. Si volem que pari just quan hi hagi l'errada quina opció afegirem a l'ordre `psql` ?


```
psql -d training --set ON_ERROR_STOP=on < training.sql
```

## Pregunta 14

Si es vol que la restauració es faci en mode transacció, és a dir o es fa tot o no es fa res, com seria l'ordre?

```
psql --single-transaction training < training.sql
```

o

```
psql -1 training < training.sql`
```

## Pregunta 15

Quina ordre em permet fer un backup de **totes** les bases de dades d'un cluster? Es necessita ser l'administrador de la base de dades?

```
pg_dumpall -f backup_all_db.sql
```

## Pregunta 16

Quina ordre em permet restaurar **totes** les bases de dades d'un cluster a partir del fitxer `backup_all_db.sql`? Es necessita ser l'administrador de la base de dades?

```
pg_dumpall -f backup_all_db.sql
```

## Pregunta 17

Quina ordre em permet fer una còpia de seguretat de tipus `tar` la base de dades `training` que es troba a 192.168.0.123 ? Canvia la IP per la de l'ordinador del teu company.

```
pg_dump -h 192.168.0.123 -U isxxxxxx -Ft training < training192_168_0_123.tar
```

Es pot restaurar també remotament però no és el més recomanable. Més segur
copiar (remotament) i després restaurar localment.


## Pregunta 18

Es pot fer un backup de la base de dades training del server1 i que es restauri _on the fly_ a server2?

```
pg_dump -h server1 training | psql -h server2 training
```

## LINKS

+ [SQL Dump](https://www.postgresql.org/docs/13/backup-dump.html)
+ [PostgreSQL: Backup And Recovery](https://en.wikibooks.org/wiki/PostgreSQL/BackupAndRecovery)
+ [PostgreSQL pg_dump Backup and pg_restore Restore Guide](https://snapshooter.com/learn/postgresql/pg_dump_pg_restore)
+ [PostgreSQL Prático/Administração/Backup e Restore](https://pt.wikibooks.org/wiki/PostgreSQL_Pr%C3%A1tico/Administra%C3%A7%C3%A3o/Backup_e_Restore)
+ [How To Backup PostgreSQL Databases on an Ubuntu VPS](https://www.digitalocean.com/community/tutorials/how-to-backup-postgresql-databases-on-an-ubuntu-vps)
+ [How To Backup and Restore PostgreSQL Database using pg_dump and psql](https://dbtut.com/index.php/2020/12/04/how-to-backup-and-restore-postgresql-database-using-pg_dump-and-psql/)


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




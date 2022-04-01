z# Guia d'instal·lació i configuració bàsica de Borg a Debian

**ATENCIÓ AQUEST DOCUMENT S'HA CORROMPUT AMB CADENES '????', COM QUE EL PROFESSOR NO VA FER UN BACKUP HAUREU DE RECUPERAR VOSALTRES LA INFORMACIÓ PERDUDA.**

https://borgbackup.readthedocs.io/en/stable/quickstart.html 

https://borgbackup.readthedocs.io/en/stable/installation.html

https://packages.debian.org/stretch/borgbackup 


## Què és Borg?

+ Borg és un programa de backups (còpias de seguretat) que elimina dades
redundants (duplicades).

+ Aquesta darrera característica fa de Borg una eina molt adient pels backups
diaris ja que només s'emmagatzemen els canvis respecte a la versió anterior.

+ Borg també permet utilitzar compressió i xifratge autenticat.


## Instal·lació del paquet borg a Debian stable

El paquet es troba al nostre repositori de manera que fare, servir l'ordre habitual, podem fer un `apt-get update` abans si ho considerem necessari: 


```yaml
apt-get install borgbackup
```


## Creació d'un repositori 

###  Inicialització d'un repositori


Inicialitzem el repositori:

```
mkdir /var/tmp/Borg
```

```yaml
borg init --encryption=repokey /path/to/repo
```

```yaml
borg init --encryption=repokey /var/tmp/Borg
```

> Enter net passphrase: "keshi"

```
isx36579183@j05:~/Documents/m02$ borg init --encryption=repokey /var/tmp/Borg

Enter new passphrase: 
Enter same passphrase again: 
Do you want your passphrase to be displayed for verification? [yN]: y
Your passphrase (between double-quotes): "keshi"
Make sure the passphrase displayed above is exactly what you wanted.

By default repositories initialized with this version will produce security
errors if written to with an older version (up to and including Borg 1.0.8).

If you want to use these older versions, you can disable the check by running:
borg upgrade --disable-tam Borg

See https://borgbackup.readthedocs.io/en/stable/changes.html#pre-1-0-9-manifest-spoofing-vulnerability for details about the security implications.

IMPORTANT: you will need both KEY AND PASSPHRASE to access this repo!
Use "borg key export" to export the key, optionally in printable format.
Write down the passphrase. Store both at safe place(s).
```

> PASSPHRASE: keshi

+ la opció `-e repoquey` la veurem també com `--encription=repokey`.

+ el valor d'encriptació repokey és el recomanat si volem compatibilitat amb versions antigues. Altrament farem servir_authenticated_ per exemple. 

```
sudo apt-get install borgbackup-doc
```

[Mésinfo](file:///usr/share/doc/borgbackup-doc/html/usage/init.html#borg-init) 

+ La repokey, es desa al fitxer `config` que hi ha dintre del repositori `/var/tmp/Borg`, com que no només necessitarem el password sinó també aquesta key, no oblidem de copiar-la i guardar-la a un lloc segur. Si ens oblidem de copiar-la fora del repositori, ens podem trobar amb una situació equivalent a quedar-nos fora del  cotxe tancat amb la clau a dins.

Fem un exemple de còpia de la clau, o sigui exportació,:

```yaml
sudo borg key export /var/tmp/Borg $HOME/Documents/m02/key_m02
```

```yaml
cd $HOME/Documents/m02/ && cat key_m02
```

[Més opcions en aquest enllaç](https://borgbackup.readthedocs.io/en/stable/usage/key.html#borg-key-export)

_No feu servir el format d'exportació de redirecció_ 


+ Si el repositori fos remot anàlogament faríem:

```yaml
sudo borg key import user@isx36579183:/var/tmp/Borg
```

```yaml
cd /var/tmp/ && sudo borg key export Borg guest@j06:/home/guest/Documents/key_j05
```

### Creació de l'arxiu backup

Si fem un backup totalment físic\*, parem primer el servei, sinó podríem estem jugant a la loteria per obtenir un backup corrupte. 

#### Esbrinem a on es troben les dades de les bases desades

```
sudo -u postgres psql template1
```

```
show data_directory
```

```
template1=# show data_directory
template1-# ;
       data_directory        
-----------------------------
 /var/lib/postgresql/13/main
(1 row)
```

```
    template1=# SHOW config_file ;
                   config_file
    -----------------------------------------
     /etc/postgresql/13/main/postgresql.conf
    (1 row)

```

#### Parem el servei de PostgreSQL

```
sudo systemctl stop postgresql
```

#### Obtenim que les dades es troben a /vara/lib/postgresql/13/main

+ De què volem fer backup?
	Dades de les bases de dades? Configuració?

+ On es troba aquesta info?

	Hint: com a administrador de la base de dades, puc fer servir l'ordre `show
...` per mostrar tot el que vulgui. Em puc ajudar del tabulador



	Creació del backup _Dijous_:

	```
    sudo borg create --list /var/tmp/Borg::Dijous /var/lib/postgresql/13/main /etc/postgresql/13/main
	```

	### **Llistem**

	```
	sudo borg list /var/tmp/Borg::Dijous
	```

	### **Delete**

	```
	sudo borg delete /var/tmp/Borg::Dijous
	```


	És interessant observar que no hi haurà problemes amb aquest dos directoris. Es desa la ruta absoluta.

	D'aquesta manera el sistema ens mostrarà:

```
Enter passphrase for key /path/to/repo: 
Creating archive at "/path/to/repo::Dijous"
------------------------------------------------------------------------------
Archive name: Dijous
Archive fingerprint: 2ec218120706a2ccff730b94fcd51bb59f6bc47ae95ec24e0fb773a56fa7ea18
Time (start): Wed, 2022-03-30 17:47:19
Time (end):   Wed, 2022-03-30 17:47:21
Duration: 1.43 seconds
Number of files: 3937
Utilization of max. archive size: 0%
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
This archive:              142.87 MB             29.48 MB             16.54 MB
All archives:              142.87 MB             29.48 MB             16.54 MB

                       Unique chunks         Total chunks
Chunk index:                     755                 3302
------------------------------------------------------------------------------
```

### Restauració (utilitzant l'arxiu de backup) 


Ens carreguem primer els dos directoris `/etc/postgresql/13/main/`  `/var/lib/postgresql/13/main`:

Mirem de parar el servei de postgresl

```
systemctl stop postgresql
```

```
sudo rm -rf /etc/postgresql/13/main/
sudo rm -rf /var/lib/postgresql/13/main
```

Comprovem que ja no tenim accés a les bases de dades template1, training ...


Si no fem res abans el backup es farà al directori on ens trobem:



```yaml
psql template1

psql: error: could not connect to server: No such file or directory
Is the server running locally and accepting
connections on Unix domain socket "/var/run/postgresql/.s.PGSQL.5432"?
```
```yaml
sudo borg extract /var/tmp/Borg::Dijous
```

```yaml
sudo chown -R postgres:postgres /etc/postgresl/13/main
```

```yaml
sudo chown -R postgres:postgres /etc/postgresql/13/main/
```

```yaml
sudo systemctl start postgresql
```
```yaml
psql template1
```

Ens demana la contrasenya i voilà

Engeguem el servei de postgresl i ja ens hauria de funcionar tot un altre cop


\* = parlem de backup totalment físic perquè hi ha una altra opció molt interessant que és un híbrid: fer un backup lògic amb `pg_dumpall` i després un backup físic d'aquest fitxer.


### Restauració a un dels diferents dies de Backup

+ Creem un primer backup, li direm Dilluns


	Parem el servei:

	```
	sudo systemctl stop postgresql
	```

	Inicialitzem el repo: (Estem a /var/tmp/)
	```
	sudo borg init --encryption=repokey Borg
	```
	
	Exportem la clau per si de cas:

	```
	sudo borg key export Borg $HOME/Documents/m02/key_m02
	```

	Creem el primer backup (Dilluns)
	```
	sudo borg create Borg::Dilluns backup.sql
	```

+ Eliminem un registre d'una taula d'una base de dades i un altre registre
  d'una taula d'una altra base de dades

	```
    postgres=# \c scott
    scott=# BEGIN;
    scott=*# DROP TABLE salgrade ;
    DROP TABLE

    scott=# \c training
    training=*# DROP TABLE rep_vendes CASCADE;
	```


+ Creem un segon backup, li direm Dimarts

	Parem el servei
	
	
	```
	sudo systemctl stop postgresql
	```

	Creem el segon backup (Dimarts)
    ```
    sudo borg create Borg::Dimarts backup.sql
    ```
	

+ Eliminem un registre més

	```
	DROP TABLE oficines CASCADE;
	```

+ Restaurem a Dimarts

	Parem el servei:
	
	``` 
	sudo systemctl stop postgresql
	``` 
	
	Ens col·loquem a `$HOME/Documents/m02` i restaurem:

	# Revisar aquí ruta

	```
	sudo borg extract $HOME/Documents/m02::Dimarts
	```
	
	Engeguem el servei:

	```
	sudo systemctl start postgresql
	``` 

	Comprovem que el registre que havíem eliminat al pas anterior hi és, però els que havíem eliminat abans de la còpia de Dilluns no.

+ Restaurem a Dilluns

	Repetir l'acció anterior

	```
    sudo systemctl stop postgresql
    ```
	```
	sudo borg extract $HOME/Documents/m02::Dilluns
    ```
	```
	sudo systemctl start postgresql
	```


### Automatització amb borgmatic

> Borgmatic és un script fet en Python per crear/restaurar backups cridant a
Borg, permet múltiples configuracions i automatitza les tasques que fem a la
consola.


Heu de fer un vídeo _ascii_ que mostri com es fa una configuració de backup de Borg. I de restauració.

Per aconseguir això, fareu:

[Alerta! sempre instal·lem des de repositori, només si no queda més remei mirem
altres alternatives](https://wiki.debian.org/DontBreakDebian)

+ Instal·lareu el paquet asciinema (alerta! sempre instal·lem des de repositori, només sinoó queda més remei mirem altres alternatives )

```
sudo apt install asciinema -y
```

+ Instal·lareu el paquet borgmatic

```
sudo apt install borgmatic -y
```

+ Practicareu una configuració de backup (la que volgueu) configurant els fitxers adients.

+ Gravareu les instruccions tot comentant-les amb asciinema.


#### Inicialitzem el ASCIINEMA i gravarem el nostre CLI.

```
ubuntu@keshi:~/Documents/m02$ asciinema rec
```
```
asciinema: recording asciicast to /tmp/tmpbpe39pka-ascii.cast
asciinema: press <ctrl-d> or type "exit" when you're done

```
```
ubuntu@keshi:~/Documents/m02$ # Inicialitzem el repositori Borg
ubuntu@keshi:~/Documents/m02$ sudo borg init --encryption=repokey Borg/
```

```
[sudo] password for guest:
Enter new passphrase:
Enter same passphrase again:
Do you want your passphrase to be displayed for verification? [yN]: y
Your passphrase (between double-quotes): "keshi"
Make sure the passphrase displayed above is exactly what you wanted.

By default repositories initialized with this version will produce security
errors if written to with an older version (up to and including Borg 1.0.8).

If you want to use these older versions, you can disable the check by running:
borg upgrade --disable-tam Borg

See https://borgbackup.readthedocs.io/en/stable/changes.html#pre-1-0-9-manifest-spoofing-vulnerability for details about the security implications.

IMPORTANT: you will need both KEY AND PASSPHRASE to access this repo!
Use "borg key export" to export the key, optionally in printable format.
Write down the passphrase. Store both at safe place(s).
```

```
ubuntu@keshi:~/Documents/m02$ # Fiquem 'keshi' com a passhprase

ubuntu@keshi:~/Documents/m02$ # Exportarem la Clau a Documents

ubuntu@keshi:~/Documents/m02$ sudo borg key export Borg Documents/m02/key_m02

ubuntu@keshi:~/Documents/m02$ ls Documents/m02
backup.sh  key_m02


ubuntu@keshi:~/Documents/m02$ cat Documents/m02/key_m02
cat: Documents/m02/key_m02: Permission denied


ubuntu@keshi:~/Documents/m02$ sudo cat Documents/m02/key_m02

BORG_KEY 346rtk4it869705i3459ttir865jgnbkflg056f93ie9f0g85iti9c5312fc9
hqlhbGdvcml0aG2mc2hhMjU2pGRhdGHaAN4mH3lketQVRh+vG5nc/TnUqwVEiE2LSkOoA6
mt2ALtw7zvO/tZe9ORI5Brx2Hra2wG93Xaxt9jud3kmo5mbxAv0IqFJuA0ggM52cnJXgzw
BkpLHQ++Z5yncRCgyTcG6g2SgG5i+lZcpaBdeGePzaXIC9Hbn5rLfat/7UctwlPXJ81SQf
q8NZFA7ohx4AjzgcPYMFY7myfSC0k+tycKBvrxGVETzip+3wx98+WGSk4PmlCnnYL/QIkp
Y5kwiJ9ecxU7zaCVKUawdwkalk0590r9ggflgfklsdf39843FdOkaGFzaNoAIEv5ItWWG9
G3GBDpH2/Qw+Pjv8oviHAkbXqcbRk9Z75dqml0ZXJhdGlvbnPOAAGGoKRzYWx02gAgK4U6
CiM9yhoPjT0fZaT6yPPzhVLawdkk4509relje023dmvcbvnklfg=


ubuntu@keshi:~/Documents/m02$ # Parem el servei per fer el backup físic

ubuntu@keshi:~/Documents/m02$ sudo systemctl stop postgresql

ubuntu@keshi:~/Documents/m02$ # Creem el backup físic amb la data d'avui (Divendres)

ubuntu@keshi:~/Documents/m02$ date
Fri 01 Apr 2022 02:54:06 PM CEST


ubuntu@keshi:~/Documents/m02$ sudo borg create Borg::Divendres /var/lib/postgresql/13/main /etc/postgresql/13/main/
Enter passphrase for key /home/guest/m02:

ubuntu@keshi:~/Documents/m02$ sudo borg list Borg/
Enter passphrase for key /home/guest/Borg:
Divendres                            Fri, 2022-04-01 20:18:45 [f14649e2e2c51b63b16c7c74e9ac73bb2986adf02cc2659171b620590965hg04]

ubuntu@keshi:~/Documents/m02$ # Ja tindriem fet el backup físic amb Borgmatic

ubuntu@keshi:~/Documents/m02$ exit
exit

asciinema: recording finished
asciinema: press <enter> to upload to asciinema.org, <ctrl-c> to save locally
asciinema: asciicast saved to /tmp/tmpbpe39pka-ascii.cast

ubuntu@keshi:~/Documents/m02$ asciinema -h
usage: asciinema [-h] [--version] {rec,play,cat,upload,auth} ...

Record and share your terminal sessions, the right way.

positional arguments:
  {rec,play,cat,upload,auth}
    rec                 Record terminal session
    play                Replay terminal session
    cat                 Print full output of terminal session
    upload              Upload locally saved terminal session to asciinema.org
    auth                Manage recordings on asciinema.org account

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

example usage:
  Record terminal and upload it to asciinema.org:
    asciinema rec
  Record terminal to local file:
    asciinema rec demo.cast
  Record terminal and upload it to asciinema.org, specifying title:
    asciinema rec -t "My git tutorial"
  Record terminal to local file, limiting idle time to max 2.5 sec:
    asciinema rec -i 2.5 demo.cast
  Replay terminal recording from local file:
    asciinema play demo.cast
  Replay terminal recording hosted on asciinema.org:
    asciinema play https://asciinema.org/a/difqlgx86ym6emrmd8u62yqu8
  Print full output of recorded session:
    asciinema cat demo.cast

For help on a specific command run:
  asciinema <command> -h
ubuntu@keshi:~/Documents/m02$ cd /tmp/
ubuntu@keshi:/tmp$ asciinema upload tmpbpe39pka-ascii.cast
```

+ Ho pujareu a la web de [asciinema](https://asciinema.org)

[PUTIN]

+ Posareu quin és el vostre link


## LINKS

+ [Manual de Borg](https://borgbackup.readthedocs.io/en/stable/)

# ChangeITLater

[Exemple d'asciinema](https://asciinema.org/a/203761)
 

 

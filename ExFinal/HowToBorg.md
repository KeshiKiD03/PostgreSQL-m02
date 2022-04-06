# Guia d'instal·lació i configuració bàsica de Borg a Debian

## Què és Borg?

+ Borg és un programa de backups (còpias de seguretat) que elimina dades
redundants (duplicades).

+ Aquesta darrera característica fa de Borg una eina molt adient pels backups
diaris ja que només s'emmagatzemen els canvis respecte a la versió anterior.

+ Borg també permet utilitzar compressió i xifratge autenticat.


## Instal·lació del paquet borg a Debian stable

El paquet es troba al nostre repositori de manera que fare, servir l'ordre
habitual, podem fer un `apt-get update` abans si ho considerem necessari: 


```
sudo apt-get install borgbackup  # si volem podem afegir el paquet borgbackup-doc
```


## Creació d'un repositori 

###  Inicialització d'un repositori


Inicialitzem el repositori:

```
borg init -e repoquey /path/to/repo
```

+ la opció `-e repoquey` la veurem també com `--encription=repokey`.

+ el valor d'encriptació repokey és el recomanat si volem compatibilitat amb
  versions antigues. Altrament farem servir_authenticated_ per exemple. [Més
info.](file:///usr/share/doc/borgbackup-doc/html/usage/init.html#borg-init) 

+ La repokey, es desa al fitxer `config` que hi ha dintre del repositori, com
  que no només necessitarem el password sinó també aquesta key, no oblidem de
copiar-la i guardar-la a un lloc segur. Si ens oblidem de copiar-la fora del
repositori, ens podem trobar amb una situació equivalent a quedar-nos fora del
cotxe tancat amb la clau a dins.

	Fem un exemple de còpia de la clau, o sigui exportació,:

	```
	borg key export /DADES/borg_repos/laptop_DB_repo  ~/encrypted-key-backup-training-backup 
	```

	[Més opcions en aquest enllaç](https://borgbackup.readthedocs.io/en/stable/usage/key.html#borg-key-export)

	_No feu servir el format d'exportació de redirecció_ 


+ Si el repositori fos remot anàlogament faríem:

	```
	borg init ... user@hostname:/path/to/repo
	```


### Creació de l'arxiu backup

Si fem un backup totalment físic\*, parem primer el servei, sinó podríem estem
jugant a la loteria per obtenir un backup corrupte. 

```
sudo systemctl stop postgresql
```

+ De què volem fer backup?
	Dades de les bases de dades? Configuració?

+ On es troba aquesta info?

	Hint: com a administrador de la base de dades, puc fer servir l'ordre `show
...` per mostrar tot el que vulgui. Em puc ajudar del tabulador


	```
	training=# show data_directory;
		   data_directory        
	-----------------------------
	 /var/lib/postgresql/13/main
	(1 row)

	training=# show config_file ;
				   config_file               
	-----------------------------------------
	 /etc/postgresql/13/main/postgresql.conf
	(1 row)
	```

	```
	sudo borg create -v --stats /DADES/borg_repos/laptop_DB_repo::Dimecres  /etc/postgresql/13/main/  /var/lib/postgresql/13/main
	```


	És interessant observar que no hi haurà problemes amb aquest dos directoris. Es desa la ruta absoluta.

	D'aquesta manera el sistema ens mostrarà:

	```
	Enter passphrase for key /DADES/borg_repos/laptop_DB_repo: 
	Creating archive at "/DADES/borg_repos/laptop_DB_repo::Dimecres"
	------------------------------------------------------------------------------
	Archive name: Dimecres
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
sudo rm -rf /etc/postgresql/13/main/  /var/lib/postgresql/13/main
```

Comprovem que ja no tenim accés a les bases de dades template1, training ...


Si no diem res el backup es farà al directori on ens trobem:



```
cd /
sudo borg extract /DADES/borg_repos/laptop_DB_repo/::Dimecres
```

Ens demana la contrasenya i voilà

Engeguem el servei de postgresl i ja ens hauria de funcionar tot un altre cop


\* = parlem de backup totalment físic perquè hi ha una altra opció molt interessant que és un híbrid: fer un backup lògic amb pg_dumpall i després un backup físic d'aquest fitxer.


### Restauració a un dels diferents dies de Backup

+ Creem un primer backup, li direm Dilluns


	Parem el servei:

	```
	sudo systemctl stop postgresql
	```

	Inicialitzem el repo:
	```
	sudo borg init -e repokey /DADES/borg_repos/laptop_DB_repo
	```
	
	Exportem la clau per si de cas:

	```
	sudo borg key export /DADES/borg_repos/laptop_DB_repo  ~/encrypted-key-laptop-DB-backup
	```

	Creem el primer backup (Dilluns)
	```
	sudo borg create -v --stats /DADES/borg_repos/laptop_DB_repo::Dilluns  /etc/postgresql/13/main/  /var/lib/postgresql/13/main
	```

+ Eliminem un registre d'una taula d'una base de dades i un altre registre
  d'una taula d'una altra base de dades

	```
	psql training
	...
	psql training2
	...
	```


+ Creem un segon backup, li direm Dimarts

	Parem el servei
	
	
	```
	sudo systemctl stop
	```

	Creem el segon backup (Dimarts)
    ```
    sudo borg create -v --stats /DADES/borg_repos/laptop_DB_repo::Dimarts  /etc/postgresql/13/main/  /var/lib/postgresql/13/main
    ```
	

+ Eliminem un registre més

	```
	...
	```

+ Restaurem a Dimarts

	Parem el servei:
	
	``` 
	sudo systemctl stop postgresql
	``` 
	
	Ens col·loquem a `/` i restaurem:

	```
	sudo borg extract  /DADES/borg_repos/laptop_DB_repo/::Dimarts
	```
	
	Engeguem el servei:

	```
	sudo systemctl start postgresql
	``` 

	Comprovem que el registre que havíem eliminat al pas anterior hi és, però
els que havíem eliminat abans de la còpia de Dilluns no.

+ Restaurem a Dilluns

	Repetir l'acció anterior

### Automatització amb borgmatic

> Borgmatic és un script fet en Python per crear/restaurar backups cridant a
Borg, permet múltiples configuracions i automatitza les tasques que fem a la
consola.


Heu de fer un vídeo _ascii_ que mostri com es fa una configuració de backup de Borg. I de restauració.

[Alerta! sempre instal·lem des de repositori, només si no queda més remei mirem
altres alternatives](https://wiki.debian.org/DontBreakDebian)

+ Instal·lareu el paquet asciinema (alerta! sempre instal·lem des de repositori, només si no queda més remei mirem altres alternatives )

	
	[Exemple d'asciinema](https://asciinema.org/a/203761)

	```
	apt-get install asciinema
	```

	Feu un sign up amb el vostre email i després a la consola feu:

	```
	asciinema auth

	Open the following URL in a web browser to link your install ID with your asciinema.org user account:

	https://asciinema.org/connect/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

	This will associate all recordings uploaded from this machine (past and future ones) to your account, and allow you to manage them (change title/theme, delete) at asciinema.org.
	```

	Si cliquem a l'enllaç ens mostrarà (costa veure-ho):

	```
	Recorder token has been added to your account.
	```

	Més info en aquest [enllaç](https://gitlab.com/pingui/deb-at-inf/-/raw/master/Debian11/HowTo/install_asciinema.md)

+ Instal·lareu el paquet borgmatic

	```
	sudo apt-get install borgmatic
	```

+ Practicareu una configuració de backup (la que volgueu) configurant els
  fitxers adients.

+ Gravareu les instruccions tot comentant-les amb asciinema

+ Ho pujareu a la web de [asciinema](https://asciinema.org)

+ Posareu quin és el vostre link

	Per exemple [aquest](https://asciinema.org/a/acEVrz5it5zg4RL5j1bGWNOw0)

	Falta afegir a l'apartat de `sources` del fitxer de configuració `test.yaml`:
	```
    # List of source directories to backup (required). Globs and
    # tildes are expanded.
    source_directories:
        - /var/lib/postgresql/13/main
        - /etc/postgresql/13/main/
	```

	I a la secció de repositoris:
	```
    repositories:
        - prova_borg
	```
## LINKS

+ [Manual de Borg](https://borgbackup.readthedocs.io/en/stable/)
 

 

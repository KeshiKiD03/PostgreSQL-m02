# Accés local i remot

## Autenticació

### Fitxer d'autenticació de PostgreSQL
 
Per accedir al SGBD PostgreSql ens hem d'autenticar. PostgreSQL permet diversos tipus d'autenticació. A Debian estan definits al fitxer `/etc/postgresql/13/main/pg_hba.conf`.

Això és per la versió 13 de postgresql. En general podem fer servir l'ordre locate per buscar aquest fitxer:

```
locate pg_hba.conf
```
Si no ens surt res potser és perquè no hem inicialitzat la base de dades com a root:

```
updatedb
```

A cada línia d'aquest fitxer s'especifica: 

+ si s'accedeix localment o remotament (aprofundiment al final)
+ a quines bases de dades es pot accedir
+ quins usuaris hi poden accedir
+ quines adreces (IP) poden accedir 
+ el mètode d'autenticació

### Sintaxi

```
TYPE  DATABASE        USER            ADDRESS                 METHOD
```
o

```
TYPE  DATABASE        USER            IP-ADDRESS      IP-MASK             METHOD
```

**Exemples:**
```
# Permet connexió local a qualsevol base de dades als usuaris del sistema
local   all             all                                     peer

# Permet connexió local a qualsevol base de dades a qualsevol usuari sense posar contrasenya
local   all             all                                     trust

# Accés local (però amb connexió TCP/IP) per a usuaris del sistema
host    all             all             127.0.0.1/32            ident

# El mateix que l'anterior però usant màscara de xarxa
host    all             all             127.0.0.1       255.255.255.255     ident

# Permet connexió de qualsevol usuari de Postgres amb contrasenya des de 
# la màquina amb IP 192.168.12.10 connectar-se a la base de dades training 
host    training        all             192.168.12.10/32        md5

# Rebutja tota connexió des de la màquina amb IP 192.168.54.1
host    all             all             192.168.54.1/32         reject
```

Per dir qualsevol adreça de xarxa: 0.0.0.0/0

## Accés remot

Per fer accessos remots, hem de dir a Postgresql que escolti a les adreces de xarxa que volem en el fitxer `/etc/postgresql/13/main/postgresql.conf`:

```
listen_addresses='localhost'					# per defecte
listen_addresses='*'							# per escoltar tot
listen_addresses='192.168.0.24, 192.168.0.26'	# Per escoltar IPs determinades
``` 

Cada cop que toquem fitxers de configuració hem de reiniciar el servei de PostgreSQL:

```
# systemctl restart postgresql
```

Atenció, pot ser que no puguem accedir remotament per tenir més capes de seguretat. Podríem tenir problemes amb Apparmor, les iptables o el firewall. Em aquest cas podem provar de desactivar els corresponents serveis, però centrem-nos primer en els dos fitxers de configuració ja esmentats.

* systemctl disable|stop iptables
* systemctl disable|stop ip6tables
* systemctl disable|stop firewalld

## CREATE ROLE / CREATE USER

*Roles:* un rol és una entitat que posseeix objectes de la base de dades i que té certs privilegis. Depen de com s'usa un rol es pot interpretar com a un usuari o com a un grup. 

```
\du #llista rols existents
```

Per crear rols:
```
CREATE ROLE nom_rol opcions;
```

Per crear un rol que pugui autenticar-se li hem de posar l'opció LOGIN o usar CREATE USER:

```
CREATE ROLE nom_usuari LOGIN;

CREATE USER nom_usuari;
```

OBS: Des de la versió 8.1 de postgreSQL `CREATE USER usuari` és un alias de `CREATE ROLE usuari LOGIN`.


Algunes opcions:

* SUPERUSER|NOSUPERUSER: té permisos per a tot o no
* CREATEDB|NOCREATEDB: pot crear base de dades o no
* CREATEROLE|NOCREATEROLE: pot crear altres rols o no
* INHERIT|NOINHERIT: hereta els privilegis dels rols d'on n'és membre o no
* LOGIN|NOLOGIN: pot fer login o no
* PASSWORD: establim una contrasenya per al rol
* CONNECTION LIMIT num: nombre màxim de connexions simultànies
* VALID UNTIL 'timestamp': després d'aquesta data la contrasenya ja no serà vàlida
* IN ROLE role_name: el rol que creem s'afegix al rol existent (i tindrà els seus privilegis, sempre i quan hi hagi l'opció INHERIT, que està per defecte).


*Exemples:*

```
CREATE ROLE nom_usuari LOGIN PASWORD 'la_password';

CREATE USER nom_usuari PASSWORD 'la_password';
```

Si creem un rol que no pot fer login el podem entendre com un grup. Podem afegir un rol a un altre rol i així els membres tenen els mateixos permisos que el rol pare.

## Accés
```
$ psql -h ip_servidor|nom_servidor -U nom_usuari nom_bd
```

## Recomanació

En general un bon costum és fer servir usuaris i passwords propis del servidor
PostgreSQL que s'emmagatzemen en les seves pròpies taules amb permisos
restringits i seguint el principi de un usuari/password per cada aplicació.

## Tipus de connexió

Al fitxer `/etc/postgresql/13/main/pg_hba.conf` la 1a columna fa referència al tipus de connexió.

És important distingir les dues principals:

+ socket Unix
+ socket TCP/IP.


Quan estic fent servir un tipus o altre? I al fitxer de configuració `pg_hba.conf` quina línia els representa?

+ Connexió amb un socket Unix.

	El fem servir a l'executar:
	```
	psql training
	```
	La secció corresponent al fitxer `pg_hba.conf` és: 
	```
	# "local" is for Unix domain socket connections only
	local		all		all		peer
	```
	`peer` és un mètode d'autenticació exclusiu de les connexions (locals). 
	S'obté del sistema i es comprova que estigui donat d'alta a la base de dades 

+ Connexió amb un socket TCP/IP.

	El fem servir a l'executar l'ordre `psql` amb l'opció `-h`.
	
	Distingirem dos casos

	+ Connexió al nostre propi host mitjançant loopback (127.0.0.1).

		```
		psql -h localhost training  # o l'equivalent psql -h 127.0.0.1 training
		```

		La secció corresponent al fitxer `pg_hba.conf` és:
		```
		# IPv4 local connections:
		host		all		all		127.0.0.1/32	md5
		```
		
	+ Connexió a una adreça IP de la nostra xarxa (mitjançant ethernet, wireless ... no loopback)
		```
		psql -h 192.168.1.23 training
		```
		La secció corresponent al fitxer `pg_hba.conf` és:
		```
		# IPv4 local connections:
		host		all		all		192.168.1.0/24	md5
		```

### Part teòrica

Definició de socket (sòcol)

Es tracta d'un concepte abstracte (depenent d'un context o altre s'implementarà de maneres diferents) pel qual dos programes poden intercanviar informació. Aquests dos programes poden estar en el mateix host o no. Un socket el defineix una adreça de socket que la formen 3 elements: adreça IP, protocol de transport i un número de port.

Podem pensar el socket com un fitxer informàtic existent en el client i el servidor (sigui la mateixa màquina o no) a on el programa servidor i el programa client llegeixen i escriuen la informació.

Quan aquesta comunicació es fa entre programes que es troben al mateix host es pot utilitzar un socket especial anomenat socket Unix que intenta optimitzar els recursos en aquest cas concret.

[Extret de la viquipedia](https://ca.wikipedia.org/wiki/Socket_d%27Internet)




## Troubleshooting

+ [Per si de cas Apparmor, l'equivalent a SELINUX de Fedora, necessita un canvi en la configuració](https://severalnines.com/database-blog/how-configure-apparmor-postgresql-and-timescaledb)

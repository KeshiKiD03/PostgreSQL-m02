# Accés local i remot

VIM

yyp --> Copiar y pegar una linea

```
host    all             all             127.0.0.1/32            md5
host    all             isx6223835      10.200.244.204/32       trust
host    all             guest	        10.200.244.204/32       pam


```

* Conectarse como super usuario mamado postgres - template1 madre
```
sudo -u postgres psql template1
```

```
template1=# CREATE USER isx6223835
template1-# ;
CREATE ROLE
template1=# CREATE USER guest     
;
CREATE ROLE
```
```
template1=# \c training;
You are now connected to database "training" as user "postgres".
training=# GRANT SELECT ON oficines TO guest;
GRANT

training=# 

```

* Dar permisos
```
training=# GRANT SELECT ON comandes TO guest;
GRANT
training=# GRANT SELECT ON productes TO guest;
GRANT
training=# GRANT SELECT ON productes TO isx6223835;
GRANT
training=# GRANT SELECT ON oficines TO isx6223835;
GRANT
training=# GRANT SELECT ON comandes TO isx6223835;
GRANT
training=# GRANT SELECT ON rep_vendes TO isx6223835;
GRANT
training=# GRANT SELECT ON clients TO isx6223835;
GRANT
....
```

* Cambiar contraseña
```
template1=# ALTER USER guest PASSWORD 'guest';
ALTER ROLE
template1=# 

```

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

Modificamos el Postgresql.conf
```
sudo vim /etc/postgresql/13/main/postgresql.conf
```
```
listen_addresses = '*'          # what IP address(es) to listen on;
```

A cada línia d'aquest fitxer s'especifica: 

+ si s'accedeix localment o remotament
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

Atenció, pot ser que no puguem accedir remotament per tenir més capes de seguretat. Podríem tenir problemes amb selinux, les iptables o el firewall. Em aquest cas podem provar de

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

## PERMISOS

```
GRANT SELECT ON rep_vendes TO guest;
```

## Troubleshooting

+ [Per si de cas Apparmor, l'equivalent a SELINUX de Fedora, necessita un canvi en la configuració](https://severalnines.com/database-blog/how-configure-apparmor-postgresql-and-timescaledb)

# Accés i permisos

## Exercici 1

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
d'executar per permetre la connexió des de qualsevol ordinador de l'aula i que un company des del seu ordinador pugui accedir al postgresql del teu ordinador usant
varis usuaris amb les seves contrasenya emmagatzemades al postgresql. Explica com
comprovar el correcte funcionament.


## Exercici 2

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per tal que cap usuari es pugui connectar a cap base de dades des d'un
ordinador concret de l'aula, però s'ha d'acceptar connexions des de tots els altres
ordinadors de l'aula. Explica com comprovar el correcte funcionament.


## Exercici 3

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per tal que un usuari anomenat "conrem" només pugui accedir a la base de
dades amb el mateix nom des d'un ordinador concret de l'aula sense usar contrasenya.
No s'ha de permetre la connexió amb aquest usuari des d'altres ordinadors, però si
amb altres usuaris. Explica com comprovar el correcte funcionament.


## Exercici 4

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per tal que un usuari pugui accedir a totes les bases de dades amb poders
absoluts des d'un ordinador en concret. No s'ha de permetre la connexió amb aquest
usuari des d'altres ordinadors, però si amb altres usuaris. L'usuari s'ha d'anomenar
"remadmin" i la contrasenya emmagatzemada al postgresql ha de ser "ra".
Explica com comprovar el correcte funcionament.


## Exercici 5

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per tal que un usuari pugui accedir a totes les bases de dades des de
qualsevol ordinador de l'aula. L'usuari s'ha d'anomenar "semiadmin" i la contrasenya,
emmagatzemada al postgresql, ha de ser "sa". Aquest usuari ha de tenir permisos per a
poder crear bases de dades i nous usuaris. Explica com comprovar el correcte
funcionament.


## Exercici 6

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per tal que un usuari només pugui accedir a la base de dades "db123" des de
qualsevol ordinador. L'usuari s'ha d'anomenar "us123" i la contrasenya, emmagatzemada
al postgresql, ha de ser "123". L'usuari només pot tenir 2 connexions simultànies i
només s'ha de poder connectar fins el 31-12-2012, inclòs. Explica com comprovar el
correcte funcionament.


## Exercici 7

Explica quines sentències s'han d'executar per tal que un usuari anomenat
"almacen" només pugui modificar les dades de la col·lumna "existencias" de la taula
"productos" de la base de dades "training" propietat del vostre usuari. La
contrasenya de l'usuari s'ha d'emmagatzemar al sistema gestor de base de dades.
Explica com comprovar el correcte funcionament.


## Exercici 8

Explica quines sentències s'han d'executar per tal que un usuari anomenat "rrhh"
només pugui modificar les dades de la taula "repventas" de la base de dades "training"
propietat del vostre usuari. La contrasenya de l'usuari s'ha d'emmagatzemar al
sistema gestor de base de dades. Explica com comprovar el correcte funcionament.


## Exercici 9

Explica quines sentències s'han d'executar per tal que un usuari anomenat
"lectura" no pugui modificar les dades ni l'estructura de la base de dades "training"
propietat del vostre usuari. La contrasenya de l'usuari s'ha d'emmagatzemar al
sistema gestor de base de dades. Explica com comprovar el correcte funcionament.


## Exercici 10

Explica quines sentències s'han d'executar per tal que un usuari anomenat
"gestor" pugui modificar les dades i l'estructura de la base de dades training
propietat del vostre usuari. La contrasenya de l'usuari s'ha d'emmagatzemar al
sistema gestor de base de dades. Aquest usuari no pot tenir permisos de superusuari.
Explica com comprovar el correcte funcionament.


## Exercici 11

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per obtenir el següent escenari:
Els noms assignats han de ser descriptius.
Una base de dades d'una empresa de transport que te una taula per emmagatzemar els
vehicles amb els següents camps:
 * Camp que identifica el vehicle.
 * Camp que indica la data de compra del vehicle.
 * Camp que indica si el vehicle està disponible o bé per algun motiu està al taller,
quan s'afegeix un nou vehicle a la taula aquest camp ha de dir que el vehicle està
disponible.
Els usuaris guarden les seves contrasenyes al postgresql.
L'usuari administrador ha de ser un superusuari del postgresql però només s'ha de
poder connectar des d'un ordinador.
L'usuari del taller:
 * Només ha de poder modificar dades les referents a l'estat del vehicle.
 * Només ha de poder connectar des d'un ordinador en concret.
L'usuari de compres:
 * Ha de poder afegir vehicles a la taula dels vehicles, però no ha de poder
modificar les dades referents a l'estat del vehicle.
 * Només s'ha de poder connectar des de la xarxa local.
Explica com comprovar el correcte funcionament.


## Exercici 12

Explica quina configuració ha de tenir el postgresql i quines sentències s'han
executat per obtenir el següent escenari:
Els noms assignats han de ser descriptius.
Una base de dades d'una pàgina web amb notícies breus i articles.
La base de dades ha de tenir dos taules, una per emmagatzemar les notícies breus i
l'altre per emmagatzemar els articles.
Els usuaris guarden les seves contrasenyes al postgresql.
L'usuari administrador:
 * Només ha de poder tenir una connexió activa.
 * Ha de poder veure i modificar l'estructura i les dades de la base de dades.
 * Ha de poder accedir des de qualsevol lloc.
 * Ha de poder crear nous usuaris i assingar-los els permisos corresponents.
 * No pot tenir permisos de superusuari.
L'usuari de l'aplicació web:
 * Només ha de poder llegir la base de dades.
 * Només s'ha de poder connectar des de l'ordinador que te el servidor web.
L'usuari de gestió de la web:
 * Ha de poder veure i modificar les dades de la base de dades.
 * S'ha de poder connectar des de qualsevol ordinador de la xarxa local.
L'usuari de notícies:
 * Ha de poder veure les taules però només ha de poder modificar la taula de
notícies breus.
 * S'ha de poder connectar des de qualsevol lloc.
L'usuari d'articles:
 * Ha de poder veure les taules però només ha de poder modificar la taula d'articles.
 * Només s'ha de poder connectar des de la xarxa local. 
Explica com comprovar el correcte funcionament.


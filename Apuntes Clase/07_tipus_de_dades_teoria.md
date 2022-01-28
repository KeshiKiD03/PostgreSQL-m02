# Tipus de dades


Podeu trobar els tipus de dades estàndard, els quals seran comun per a la major part de SGBDR [en aquest enllaç](https://en.wikibooks.org/wiki/Structured_Query_Language/Data_Types)

D'altra banda, els tipus de dades per a postgresql 13 els trobareu [en aquest altre enllaç](https://www.postgresql.org/docs/13/datatype.html)


Un possible resum d'aquests últims seria:

## Numèric

+ Enters: smallint, integer, bigint
+ Reals amb precisió exacta: numeric
+ Reals amb precisió inexacta: real, double precision
+ Camp auotincremental: smallserial, serial, bigserial
    
## Monetari: money

+ Per comprovar quin tipus de moneda:

	```
	SHOW lc_monetary;
	```

##  Caràcters

+ Longitud variable amb límit: character varying(n), varchar(n)
+ Longitud fixa (s'omple amb espais en blanc): character(n), char(n)
+ Longitud il·limitada: text

## Data/hora

+ Data i hora sense zona horària: timestamp
+ Data i hora amb zona horària: timestamp with time zone
+ Data: date
+ Hora sense zona horària: time
+ Hora amb zona horària: time with time zone
+ Interval de temps: interval

+ DateStyle: té dos components 
	el primer ens denota com es mostraran les dates: ISO, SQL, Postgres, German
	el segon ens denota l'ordre de dia, mes, any de la data d'entrada si és que hi ha confusió: DMY, MDY, YMD

	- Mostrar el valor de DateStyle
		```
		SHOW DateStyle;
		```
	- Establir el valor de DateStyle
		```
		SET DateStyle TO ISO, DMY;
		```
		```
		SET DateStyle TO German, DMY;
		```
## Booleà: boolean

+ Valors per cert: TRUE, 't', 'true', 'y', 'yes', 'on', '1'
+ Valors per fals: FALSE, 'f', 'false', 'n', 'no', 'off', '0'

## Geomètric:

+ Punt: point, '(x,y)'
+ Recta: line, '((x1,y1),(x2,y2))'
+ Segment: lseg, '((x1,y1),(x2,y2))'
+ Rectangle: box, '((x1,y1),(x2,y2))'
+ Polígon: path, polygon, '((x1,y1),...)'
+ Camí: path '[(x1,y1),...]'
+ Cercle: circle, '<(x,y),r>' (centre i radi)

## Adreces de xarxa:

+ Xarxes IPv4 i IPv6: cidr
+ Xarxes i hosts IPv4 i IPv6: inet
+ Adreça MAC: macaddr

## UUID:

+ uuid

## XML:

+ xml: valida que el text introduït estigui ben format, sinó dóna error.

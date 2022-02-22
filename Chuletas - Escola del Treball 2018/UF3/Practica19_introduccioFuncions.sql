INFO a : https://www.postgresql.org/docs/9.5/static/functions.html


Exemples per cridar funcions passant el tipus de dades corresponent :



Function :	
age(timestamp, timestamp) 
		interval 	
		Subtract arguments, producing a "symbolic" result that uses years and months 	
		age(timestamp '2001-04-10', timestamp '1957-06-13') 	43 years 9 mons 27 days
age(timestamp) 	
		interval
		Subtract from current_date (at midnight) 
		age(timestamp '1957-06-13') 	43 years 8 mons 3 days
clock_timestamp() 
		timestamp with time zone 	
		Current date and time (changes during statement execution); see Section 9.9.4 	  	 
current_date 	---> sense ()
		date 	
		Current date
current_time 	---> sense ()
		time with time zone 	
		Current time of day  
			 
current_timestamp 	t---> sense ()
		imestamp with time zone 	
		Current date and time (start of current transaction); 


1)  select age('1996-05-17');

training=# select age(timestamp '1996-05-17');
           age           
-------------------------
 21 years 9 mons 26 days
(1 row)


	!!!!!!!!!!!!!!!!!!!!! ENS DÓNA ERRRRROOOOOOOOOOOOOOOOORrrrrrrrrrrr !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	HINT:  Could not choose a best candidate function. You might need to add explicit type casts.

2)  select age(timestamp '1996-05-17');


3)  select age(cast ('1966-09-17' as timestamp));


4)  select age('1966-09-17'::timestamp);


Exemples de funcions d''strings/cadenes:

1) CONCATENAR - Operador ||  SELECT 'Hola' || ' avui és divendres';  SELECT 'Hola' || 5000 || ' avui és divendres';


2) LONGITUD D''UNA CADENA : select char_length('aaaa')  o length('jose');


3) TROÇ / PEÇA / PART D''UNA CADENA : 
		substring(string [from int] [for int]) - select substring('Thomas' from 2 for 3)  - hom;
		substr(string, from [, count]) - substr('alphabet', 3, 2) 	ph


4) POSICIÓ D''UN STRING DINS D''UN ALTRE : 
		position(substring in string) - select position('om' in 'Thomas') - 3
		strpos(string, substring) - select strpos('high', 'ig') - 	2

5) REPLACE : replace(string text, from text, to text) - eplace('abcdefabcdef', 'cd', 'XX') 	abXXefabXXef


6)TROÇ DE LA DRETA : right(str text, n int) -  	right('abcde', 2) 	de


7)TROÇ DEL FINAL : left(str text, n int) -  	left('abcde', 2) 	ab


8) TROÇ SEPARAT PER UN DELIMITADOR : split_part(string text, delimiter text, field int) -  	split_part('abc~@~def~@~ghi', '~@~', 2) 	def


9) ELIMINAR CARÀCTERS  :rtrim(string text [, characters text]) -  	rtrim('trimxxxx', 'x') 	trim

5) repeat(string text, number int) -  	repeat('Pg', 4)  - PgPgPgPg







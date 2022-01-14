/* Ejemplos de TODO!
Autor: Aaron Andal
Fecha: 02/02/2015
*/

--  *************************************************
--	*---------------------------------------------- *
--  *--   |	 TEORICO/PRACTICA EXAMEN UF2 BD	  |  -- *
--	*---------------------------------------------- *
--  *************************************************
	----------------------------------
    --   |	Creación de TABLA	  | --
	----------------------------------

CREATE TABLE "table_nam" --> Crear tabla
DROP TABLE "table_name" 	--> Borrar tabla
	CASCADE CONSTRAINTS --> Borra las constrains PRIMERO
DESC "table_name" 	--> Confirma la tabla
CONSTRAINT		--> Crear constraint a nivel de tabla/ columna
	PRIMARY KEY --> PK
	FOREIGN KEY --> FK
	NOT NULL --> NN
	UNIQUE --> UNICO
	
ALTER TABLE "table_name"		--> Modificar la tabla
	ADD			--> Añadir una columna
	MODIFY COLUMN --> Modificar columna
	DROP COLUMN --> Borrar columna
	RENAME COLUMN --> Renombrar Columna
	
	-----------------------------------
    --   |	Inserción de DATOS	  | --
	-----------------------------------
	
INSERT INTO "table_name" () --> Inserta datos en una columna o varias.
	VALUES() --> Inserta valores
	
UPDATE "table_name" --> Actualiza
SET	"columna" = valor [, columna = valor] --> Modifica una o más columnas
[WHERE condicion] --> Condición para filtrar

DELETE FROM tabla --> Borra registros de la tabla
WHERE condición --> Condición para filtrar

SAVEPOINT update_ ; --> Crea un purto de partida o marcador en una transacción actual
 
ROLLBACK TO update_ ; --> Buelve a la savepoint especificada
					--> Rollback puede fallar
					
					--> Con commit se borran los puntos SAVEPOINT
					--> Se hace al final

	----------------------------------
    --    |	De TODO UN POCO	  | 	--
	----------------------------------

FROM DUAL --> Tabla temporal
COMMIT; --> Confirma la transacción de los datos datos DML
SYSDATE --> FECHA del SISTEMA
TO_CHAR(NULL) --> Columna vacía
TO_DATE('FECHA', 'FORMATO') --> Convierte una fecha a un formato especificado

SET VERIFY OFF --> Lo del new value lo oculta

SET "column_name" = NULL --> Actualizar un valor de columna a NULL


ROLLBACK --> Garantiza la consistencia y volver a un estado SAVEPOINT.

select * from dictionary --> Verifica el diccionario de datos

select table_name from dictionary --> Verifica el diccionario de datos

select * from user_tables --> Selecciona todas las tablas del usuario.


SELECT AVG(NVL(commision_pct, 0)) --> Permite a las funciones de grupo incluir valores nulos


	------------------------------------------
    --    |	Operadores de comparación  | 	--
	------------------------------------------
between

	Nos permite obtener datos que se encuentren en un rango.

not between

	Nos permite obtener datos que se encuentren fuera de un rango.

in

	Permite obtener registros cuyos valores estén en una lista de valores.

not in
	Distinto a cualquiera de los miembros entre paréntesis.
any 

	Compara con cualquier registro de la subconsulta. La instrucción es válida 
	si hay un registro en la subconsulta que permite que la comparación sea cierta.

all 

	Compara con todos los registros de la consulta. La instrucción
	resulta cierta si es cierta toda la comparación con los registros
	de la subconsulta.

like % muchos caracteres

like _ un único carácter 
	Permite obtener registros cuyo valor en un campo cumpla una
	condición textual.
	
	-------------------------------------------------------
    --    |	FUNCIONES CADENA DE CARACTERES (LES03)  | 	 --
	-------------------------------------------------------
	
	-- CONVERSIONES --
	
	LOWER('SQL COURSE') --> sql course | minuscula
	
	UPPER('SQL course') --> SQL COUSE | MAYUSCULA

	INITCAP('SQL Course') --> Sql Course | Capital
	
	----------------------------------------------------
	
	SELECT INITCAP('andal')
	FROM DUAL --> Tabla temporal y un select de las funciones
	

	SELECT SUBSTR('PEPE PEREZ', -2,2)
	FROM DUAL --> Devuelve cadena de string que empieza por el final y devuelve 2 empezando por el final. 
	
		SINTAXIS SUBSTR('TEXTO', pos_ini, recorrer_cadena)

	CONCAT('Hello', 'World') --> CONCATENAR 2 STRINGS
	
		SINTAXIS CONCAT('TEXTO', 'TEXTO')
				
				
	SUBSTR('HelloWorld', 1, 5) --> EMPIEZA EN EL CARACTER 1 Y ACABA EN EL 5


	LENGTH('HelloWorld') --> TAMAÑO STRING


	INSTR('HelloWorld', 'W') --> POSICIÓN DEL CARÁCTER *


	LPAD(salary, 10, '*') --> EN LA CADENA SALARY SE LE AÑADE * HASTA 10 INICIO
	
		SINTAXIS LPAD('TEXTO', 10, '*') --> Rellena con * hasta de izq 10 posiciones 

	RPAD(salary, 10, '*') --> EN LA CADENA SALARY SE LE AÑADE * HASTA 10 FINAL
	
		SINTAXIS RPAD('TEXTO', 10, '*') --> Rellena con * hasta 10 posiciones

	REPLACE BLACK and BLUE
	('JACK and JUE','J','BL') --> REEMPLAZA


	TRIM('H' FROM 'HelloWorld') --> ELIMINA EL CARACTER DEL STRING

-- *******************************************************************

	------------------------------------------
    --    |	Funciones de CONVERSION Y CON  | 	--
	------------------------------------------

	SELECT TO_DATE('03/10/96','DD/MM/YY') - SYSDATE
	FROM DUAL; --> CONVIERTE formato de fecha

	SELECT MONTHS_BETWEEN (SYSDATE, TO_DATE('03/10/1996','DD/MM/YY'))
	FROM DUAL; --> VERDADERO CALCULAR MESES DE VIDA


	SELECT MONTHS_BETWEEN (SYSDATE, TO_DATE('03/10/1996','DD/MM/YY'))/12
	FROM DUAL; --> VERDADERO CALCULAR AÑOS DE VIDA

	SELECT SYSDATE - TO_DATE('03/10/1996','DD/MM/YY')
	FROM DUAL; --> VERDADERO CALCULAR DIAS DE VIDA
	
	LAST_DAY('01-FEB-95') --> IMPRIME EL ÚLTIMO DÍA DE LA FECHA INTRODUCIDA
	
	NEXT_DAY(FECHA,DIA) --> SIGUIENTE DIA
	
	ADD_MONTHS('31-JAN-96', 1) --> Añade 1 mes

-- ************************************************************


	ORDER BY -TENURE = ORDER BY "TENURE" DESC
	
	ROUND(45.926, 2) --> Redondea a 2 decimales
	TRUNC(45.926, 2) --> Trunca 
	MOD(1600, 300) --> Devuelve el resto de la división
	
-- ***********************************************************

	------------------------------------------------------
    --    |	Funciones de CONVERSION Y CONDICIONALES  | 	--
	------------------------------------------------------

	TO_CHAR(date, 'formato') --> CNVIERTE una fecha o numero en carácter

	
	fm --> Elimina espacios o 0 iniciales
	
	** El formato debe estar en comillas
	** No en mayusculas
	** Incluir cualquier formato de fecha valido
	** Separado por comas
	
	YYYY --> Años en numeros
	YEAR --> Año en LETRA
	MM --> Valor de 2 digitos el mes
	MONTH --> Valor completo
	MON --> Abreviatura del mes 3 letras
	DY --> Abreviatura de 3 letras del día de la semana
	DAY --> Nombre completo del día de la semana
	DD --> Día numérico del mes
	
	TO_CHAR(number, 'formato') --> CNVIERTE una fecha o numero en carácter
	TO_CHAR(numero, 'formato') 

	9 --> Numero
	0 --> Forzar 0
	$ --> Colocar signo
	L --> Símbolo de divisa local
	. --> Punto decimal
	, --> Coma
	
	TO_NUMBER(char, 'format') --> Convertir una cadena de caracteres a un formato número
	TO_DATE(char, 'format') --> Convierte una cadena de texto en fecha.
	
	NVL --> Convierte de un valor nulo a valor real.
	NVL2 --> Deuelve el valor del sustituto 1, sino el 2.
	
	COALESCE --> Obtiene múltiples valores alternativos. La primera fila de expresiones si no es nula
	
	CASE --> Condicionales lógicos
		
		CASE "expr" WHEN "comparison_expr1" THEN "return_expr1"
					ELSE "else_exp"
					
		END;
		
	DECODE --> Facilita consultas condicionales
	
-- *************************************************************

	----------------------------------
    --    |	Funciones DE GRUPO  | 	--
	----------------------------------

	AVG() --> Media
	COUNT() --> Contar
	MAX() --> Maximo de n numero
	MIN() --> Min de un numero
	
	-- TODAS LAS COLUMNAS DE LA LISTA SELECT QUE NO ESTAN INCLUIDAS EN FUNCIONES DE GRUPO
	-- DEBEN ESTAR EN LA CLÁUSULA "GROUP BY"
	-- NO ES NECESARIO QUE ESTÉ EN LA LISTA DE "SELECT"
	
	-- GROUP BY ES NECESARIO SI SE INTRODUCE FUNCION DE GRUPO.
	-- Having es para FUNCIONES de GRUPOS
	--> Where primero y lueg HAVING
	
-- ***************************************************************

	----------------------------------
    --    |	DEFINICION  | 	--
	----------------------------------
		
	UNION ALL --> Devuelve los resultados de ambas consultas incluidas las duplicaciones.
	--> En union no.
	
	INTERSECT --> Devuelve las filas comunes.
	
	MINUS --> Devuelve todas las filas distintas.
-----------------------------------------------------------------------------------

	--------------------------------------
    --    |	TODOS LOS EJEMPLOS	  | 	--
	--------------------------------------
	
------------------------------------------------------------------------------------



----------------------------------------------------



----------------------------------------------------



----------------------------------------------------



----------------------------------------------------




----------------------------------------------------



----------------------------------------------------



----------------------------------------------------



----------------------------------------------------



----------------------------------------------------



----------------------------------------------------





	
	
	

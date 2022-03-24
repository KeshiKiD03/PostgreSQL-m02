# Backup lògic


## Eines de PostgreSQL

Quan el sistema gestor de Base de Dades Relacional (SGBDR o RDBMS en anglès) és
PostgreSQL, les ordres clàssiques per fer la còpia de base de dades són:

+ `_______` per copiar una base de dades del SGBDR a un fitxer script o de
  tipus arxiu 

+ `_______` per copiar totes les bases de dades del SGBDR a un fitxer script
  SQL


Anàlogament, quan volem restaurar una base de dades si el fitxer destí ha estat un script SQL farem la restauració amb l'ordre `_______`, mentre que si el fitxer destí és de tipus binari l'ordre a utilitzar serà `_______`.


Anem a jugar dintre del nostre SGBDR. Respon i després *executa les
instruccions comprovant empíricament que són correctes*.


## Pregunta 1. 

Quina instrucció ens fa una còpia de seguretat lògica de la base de dades training (de tipus script SQL) ?

## Pregunta 2.

El mateix d'abans però ara el destí és un directori.

## Pregunta 3.

El mateix d'abans però ara el destí és un fitxer tar.

## Pregunta 4. 

El mateix d'abans però ara el destí és un fitxer tar però la base de dades és mooolt gran.

## Pregunta 5

Imagina que vols fer la mateixa ordre d'abans però vols optimitzar el temps
d'execució. No pots esperar tant de temps en fer el backup. Quina ordre
aconseguirà treballar en paral·lel? Fes la mateixa ordre d'abans però atacant
la info de les 5 taules de la base de dades al mateix temps.

## Pregunta 6

Si no indiquem usuari ni tipus de fitxer quin és el valor per defecte?

## Pregunta 7

Fes una còpia de seguretat lògica només de la taula _comandes_ de tipus script SQL.

## Pregunta 8

Fes una còpia de seguretat lògica només de la taula _rep_vendes_ de tipus binari.

## Pregunta 9 

Elimina la taula _comandes_ de la base de dades _training_. 

## Pregunta 10

Elimina la taula *rep_vendes* de la base de dades training. 

Quina ordre restaura la taula *rep_vendes* (recorda que el fitxer és binari)

## Pregunta 11

Després de fer una còpia de tota la base de dades training en format binari, elimina-la. 

Hi ha l'ordre de bash `dropdb` (en realitat és un wrapper de DROP DATABASE). I de manera anàloga també n'hi ha l'ordre de bash `createdb`.
Sense utilitzar aquesta última i amb una única ordre restaura la base de dades training.


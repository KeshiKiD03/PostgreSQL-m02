# DCL Schemes

Dona permisos de lectura sobre totes les taules de l'esquema isxxxxxz al rol_prova i que comprovin que funciona mitjançant un company (Se supose que pertany a prova)

GRANT SELECT ON ALL TABLES IN SCHEMA 

# 

\du --> Ver usuarios

\dt --> Display tables

CREATE ROLE rol_prova;

# Crear Esquema

\dn --> Display N Ver Esquemas

CREATE SCHEMA isx36579183; (Con mi ususario)

scott=# CREATE TABLE emp (
        id    INT
);

SAP QUE HA DE CREAR-LA AL NOU SCHEMA PERQUÈ HI HA UNA DIRECTIVA QUE ÉS DIU:

scott=# SHOW SEARCH_PATH;
   search_path
----------------------
"$user", public


scott=# ALTER TABLE emp ADD COLUMN nom varchar;

scott=# ALTER TABLE emp ADD COLUMN dept smallint;



show search_path; --> Ver el PATH

sudo -u postgres psql scott

scott=> GRANT rol_prova TO isx6223835 ;

SELECT current_user;

SELECT session_user;

GRANT ROLE

# Da SELECT a todas las tablas del esquema de mi usuario a rol_prova

GRANT SELECT ON ALL TABLES IN SCHEMA isx36579183 TO rol_prova;
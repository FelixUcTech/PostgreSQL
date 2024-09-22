--Lo que se puede hacer en las tablas:
    --Crearla
    --Modificarlas
    --Borrarlas
En el entorno grafico, podemos crear una base de datos
Databases->ClicDerecho->Databases->General->Databases->"Nombre de la base de datos"
En la pestaña de SQL
CREATE DATABASE transporte
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
-------------------
--Creación de base de Datos
-- Database: metro
-- DROP DATABASE IF EXISTS metro;
CREATE DATABASE metro
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Mexico.1252'
    LC_CTYPE = 'Spanish_Mexico.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
-------------------
--creación de tablas
--Usuario
--
--Tren
CREATE TABLE public."Tren"
(
    id serial,
    modelo character varying,
    capacidad smallint,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public."Tren"
    OWNER to postgres;

--Crear particiones en bases de datos grandes


--Desde la terminal SQL shell
\h CREATE ROL
CREATE ROLE name [ [ WITH ] option [ ... ] ]

where option can be:

      SUPERUSER | NOSUPERUSER
    | CREATEDB | NOCREATEDB
    | CREATEROLE | NOCREATEROLE
    | INHERIT | NOINHERIT
    | LOGIN | NOLOGIN
    | REPLICATION | NOREPLICATION
    | BYPASSRLS | NOBYPASSRLS
    | CONNECTION LIMIT connlimit
    | [ ENCRYPTED ] PASSWORD 'password' | PASSWORD NULL
    | VALID UNTIL 'timestamp'
    | IN ROLE role_name [, ...]
    | IN GROUP role_name [, ...]
    | ROLE role_name [, ...]
    | ADMIN role_name [, ...]
    | USER role_name [, ...]
    | SYSID uid

URL: https://www.postgresql.org/docs/16/sql-createrole.html
-------------
CREATE ROLE "Nombre de usuario"+
--Un alias de CREATE ROLE es CREATE USER después de la versión 9 de posgres, es un alis el user de role.

ALTER USER "Nombre de usuario" WITH "Cualquiera de las opciones"
--Agregar propiedades

ALTER USER felix_1 LOGIN PASSWORD 'Password01';


'''
Nota:
    Con WITH: Puedes cambiar varios parámetros en una sola sentencia.
    Sin WITH: Solo puedes modificar un parámetro por comando.
'''

--Cambio de usuario
\c postgres felix_1
\c nombre_base_de_datos nombre_usuario
--El mismo usuraio no se puede borrar a sí mismo con el compando DROP ROLE/USER "Usuario"
--Tienes que cambiar a un usurio con los permisos de superuser

--Ejemplo desde una configuración desde pgAmin
CREATE ROLE felix_2 WITH
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1
	VALID UNTIL '2024-09-19T00:00:00-06:00' 
	PASSWORD 'xxxxxx';
COMMENT ON ROLE felix_2 IS 'Este usuario es creado desde la pgAdmin, prueba de PosgreSQL
';

CREATE ROLE felix_1 WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1
	VALID UNTIL '2024-09-20T00:00:00-06:00' 
	PASSWORD 'xxxxxx';

SECURITY LABEL FOR "LoginSeguro" ON ROLE felix_1 IS 'SeguridadNivel1';

COMMENT ON ROLE felix_1 IS 'otro creado desde la terminal'

--Dándole permiso a un usuario restringido
-- Table: public.Tren

-- DROP TABLE IF EXISTS public."Tren";

CREATE TABLE IF NOT EXISTS public."Tren"
(
    id integer NOT NULL DEFAULT nextval('"Tren_id_seq"'::regclass),
    modelo character varying COLLATE pg_catalog."default",
    capacidad smallint,
    CONSTRAINT "Tren_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Tren"
    OWNER to postgres;

REVOKE ALL ON TABLE public."Tren" FROM felix_1;

GRANT UPDATE, INSERT, SELECT ON TABLE public."Tren" TO felix_1;

GRANT ALL ON TABLE public."Tren" TO postgres;

-- Table: public.usuario

-- DROP TABLE IF EXISTS public.usuario;

CREATE TABLE IF NOT EXISTS public.usuario
(
    id integer NOT NULL DEFAULT nextval('usuario_id_seq'::regclass),
    nombre character varying(100) COLLATE pg_catalog."default",
    direccion_residencia character varying[] COLLATE pg_catalog."default",
    fecha_nacimiento date,
    CONSTRAINT usuario_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.usuario
    OWNER to postgres;

REVOKE ALL ON TABLE public.usuario FROM felix_1;

GRANT UPDATE, INSERT, SELECT ON TABLE public.usuario TO felix_1;

GRANT ALL ON TABLE public.usuario TO postgres;

--------------------------------------------
"""LLAVES FORANEAS"""
--------------------------------------------


--------------------------------------------
"""INSERTAR VALORES"""
--------------------------------------------

https://mockaroo.com/ -- Herramienta



--------------------------------------------
"""FUNCIONES PRINCIPALES"""
--------------------------------------------
Funciones principales
ON CONFLICT DO
RETURNING
LIKE / ILIKE
IS / IS NOT
ON CONFLICT DO
Esta instruccion nos permite especificar que debemos hacer en caso de un conflicto.

Ejemplo: Imaginamos que realizamos una consulta donde el id ya ha sido utilizado. Podemos especificar que en ese caso, actualize los datos.


INSERT INTO pasajero (id, nombre, direccion_residencia, fecha_nacimiento)
	values (1, '', '','2010-01-01')
	ON CONFLICT (id) DO 
	UPDATE SET 
	nombre = '', direccion_residencia='', fecha_nacimiento='2010-01-01';
RETURNING
Returning nos devuelve una consulta select de los campos sobre los que ha tenido efecto la instruccion.

Ejemplo: Queremos saber cual es el id que le fue asignado a un dato insertado.


INSERT INTO tren (modelo, capacidad)
	 VALUES('modelo x', 100)
	 RETURNING id;

/*
Opcionalmente tambien puedes solicitar todos los campos o alguno de ellos
*/

INSERT INTO tren (modelo, capacidad)
	 VALUES('modelo x', 100)
	 RETURNING id;

INSERT INTO tren (modelo, capacidad)
	 VALUES('modelo x', 100)
	 RETURNING id, capacidad;
Like / Ilike
Las funciones like y ilike sirven para crear consultas a base de expresiones regulares.

Like considera mayusculas y minusculas, mientras que ilike solo considera las letras.

Ejemplo: Busquemos a los pasajeros con nombre que terminen con la letra o


-- Usando LIKE
SELECT * FROM PASAJERO
WHERE pasajero.nombre LIKE '%O'
-- No devulve nada, porque ningun nombre terminara con una letra mayuscula


-- Usando ILIKE
SELECT * FROM PASAJERO
WHERE pasajero.nombre LIKE '%O'
-- Devolvera los nombres que terminen con o, independiente si es mayuscula o minuscula.

IS / IS NOT
Permite hacer comprobacion de valores especiales como null

Ejemplo: Consultemos a todos los usuarios que tengan como direccion_residencia NULL


-- IS
SELECT * FROM PASAJERO
WHERE pasajero.nombre IS null;
Ahora a los que si tengan la direccion_recidencia con algun valor


-- IS NOT
SELECT * FROM PASAJERO
WHERE pasajero.nombre IS NOT null;

'''Funciones Especiales Avanzadas

COALESCE
NULLIF
GREATEST
LEAST
BLOQUES ANONIMOS'''

-- Si el nombre es null, entonces me mostra 'No Aplica'
SELECT id, COALESCE(nombre, 'No Aplica') AS nombre, direccion_residencia FROM public.pasajero
WHERE id = 1;

-- Si dos campos son iguales ---&gt; 0: False
SELECT NULLIF(0,1);

-- Devuelve el mayor
SELECT GREATEST(0,1,2,5,2,3,6,10,2,1,20);

-- Devuelve en menor
SELECT LEAST(0,1,2,5,2,3,6,10,2,1,20);

-- Devuelve si es Niño o Mayor
SELECT id, nombre, direccion_residencia, fecha_nacimiento,
    (CASE
    WHEN (fecha_nacimiento) &gt; '2015-01-01' THEN
        'Niño'
    ELSE
        'Mayor'
    END)
FROM public.pasajero;

-- Reto
SELECT id, nombre, direccion_residencia, fecha_nacimiento,
    (CASE
    WHEN (CURRENT_DATE - fecha_nacimiento)/365 &gt;= 18 THEN
        '&gt;Mayor'
    ELSE
        '&lt;Menor'
    END)
FROM public.pasajero;
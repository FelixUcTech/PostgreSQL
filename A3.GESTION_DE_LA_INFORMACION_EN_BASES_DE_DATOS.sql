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
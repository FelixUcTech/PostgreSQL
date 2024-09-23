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

'''
-------------------------------------------------
Funciones Especiales Avanzadas

COALESCE
NULLIF
GREATEST
LEAST
-------------------------------------------------
BLOQUES ANONIMOS

Resumen de las acciones dentro de bloques anónimos:
Condicionales: Controlar la lógica de flujo con IF, CASE, etc.
Bucles: Ejecutar bucles con FOR, WHILE, etc.
Operaciones CRUD: Ejecutar sentencias INSERT, UPDATE, DELETE basadas en lógica.
Manejo de excepciones: Capturar y manejar errores con EXCEPTION.
Ejecución de transacciones: Gestionar transacciones manualmente dentro del bloque.

Ventajas de los bloques anónimos:
Flexibilidad: Permiten ejecutar código PL/pgSQL dinámicamente sin crear funciones permanentes.
Pruebas rápidas: Son útiles para probar fragmentos de código PL/pgSQL antes de crear funciones formales.
No almacenados: No ocupan espacio ni permanecen en la base de datos como las funciones, ya que son ejecutados y descartados inmediatamente.
En resumen, los bloques anónimos son una herramienta poderosa para ejecutar lógica programática directamente en PostgreSQL sin necesidad de definir funciones permanentes.
-------------------------------------------------
'''

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

'''
-------------------------------------------------
VISTAS
Hay ciertas consultas que son muy repetitivas, para no repetir una consulta muchas veces existen las vistas.

Hay dos tipos de vistas, volatiles y materializadas, donde una vista guarda toda la consulta, ya sea esta repetitiva o compleja, es senvilla de consultar como una vista

MAterializadas: Persistente

Digamos que hay una vista, pero si es volatil, cada vez que consultes esa vista actualizara la consulta con los valores más acuales de de la base de datos

Pero la materializada, guarda los valores que tenga la base de datos al momento, esta vista es una fotográfica del momento qué se hizo la consulta de la vista materializada.


-------------------------------------------------
'''

'''
INSERTAR VALORES
'''
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Tasqueña', 'Calzada de Tlalpan, Coyoacán, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('General Anaya', 'Calzada de Tlalpan, Benito Juárez, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Ermita', 'Calzada de Tlalpan y Eje 8 Sur, Benito Juárez, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Portero', 'Calzada de Tlalpan y Eje 7 Sur, Benito Juárez, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Nativitas', 'Calzada de Tlalpan y Miguel Laurent, Benito Juárez, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Villa de Cortés', 'Calzada de Tlalpan y José María Vértiz, Benito Juárez, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Xola', 'Calzada de Tlalpan y Xola, Benito Juárez, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Viaducto', 'Calzada de Tlalpan y Viaducto Miguel Alemán, Benito Juárez, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Chabacano', 'Calzada de Tlalpan y Calzada de Chabacano, Cuauhtémoc, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('San Antonio Abad', 'Calzada de Tlalpan, Cuauhtémoc, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Pino Suárez', 'José María Pino Suárez y Fray Servando Teresa de Mier, Cuauhtémoc, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Isabel la Católica', 'Isabel la Católica y José María Izazaga, Cuauhtémoc, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Salto del Agua', 'Eje Central Lázaro Cárdenas y José María Izazaga, Cuauhtémoc, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Bellas Artes', 'Eje Central Lázaro Cárdenas y Avenida Juárez, Cuauhtémoc, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Hidalgo', 'Avenida Hidalgo y Paseo de la Reforma, Cuauhtémoc, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Revolución', 'Avenida de la República y Eje 1 Norte, Cuauhtémoc, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('San Cosme', 'Avenida Ribera de San Cosme, Cuauhtémoc, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Normal', 'Calzada México-Tacuba, Miguel Hidalgo, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Colegio Militar', 'Calzada México-Tacuba, Miguel Hidalgo, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Popotla', 'Calzada México-Tacuba y Av. Mariano Escobedo, Miguel Hidalgo, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Cuitláhuac', 'Calzada México-Tacuba y Circuito Interior, Miguel Hidalgo, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Tacuba', 'Calzada México-Tacuba y Marina Nacional, Miguel Hidalgo, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Panteones', 'Avenida Legaria y Avenida Ferrocarril de Cuernavaca, Miguel Hidalgo, CDMX');
INSERT INTO public.estaciones(nombre, direccion) VALUES ('Cuatro Caminos', 'Boulevard Manuel Ávila Camacho, Naucalpan, Estado de México');
'''
Crear vista materializada
'''
CREATE MATERIALIZED VIEW public.Linea_2_22092024
AS
select * from estaciones
WITH NO DATA;
ALTER TABLE IF EXISTS public.Linea_2_22092024
    OWNER TO postgres;
---------
select * from Linea_2_22092024;
---------

'''
RROR:  no existe la relación «linea_2_22092024»
LINE 1: select * from Linea_2_22092024;
                      ^ 

SQL state: 42P01
Character: 15
'''
---------


update public.estaciones
	set nombre='Tasqueña'
	where idestaciones = 1;

select * from linea2
order by idestaciones;

update public.estaciones
	set nombre = 'Tabasco'
	where idestaciones=1;

select * from estaciones;



'''
Crear vista volatil
'''
CREATE VIEW public."linea2_Actual"
 AS
select * from estaciones;

ALTER TABLE public."linea2_Actual"
    OWNER TO postgres;

'''---------------------------------------------
PL/pgSQL (Lenguaje Procedural de PostgreSQL) 
es una extensión del lenguaje SQL que permite escribir funciones y procedimientos almacenados con lógica más compleja, como bucles y condiciones.

SQL (Lenguaje de Consulta Estructurado) es un lenguaje estándar utilizado para gestionar y manipular bases de datos relacionales mediante consultas, inserciones, actualizaciones y eliminaciones de datos.

SINTAXIS

estructura básica:
------------------------------------------------
[<<label>>]
[DECLARE
    DECLARAIONS]
BEGIN
    statements
END [LABEL];
---------------------------------------------'''

DO $$
DECLARE
	rec record; --Para almacenar lo tipo de datos de una fila es el tipo de datos record
	--Si queremos asignar un valor de inicio se utiliza :=
BEGIN
    RAISE NOTICE 'Algo está MUY GRANDE pasando';
END
$$;
---------------------------------------------
DO $$
DECLARE
	rec record; --Para almacenar lo tipo de datos de una fila es el tipo de datos record
	--Si queremos asignar un valor de inicio se utiliza :=
BEGIN
	for rec in select * from estaciones order by idestaciones loop
    RAISE NOTICE 'Estación número % %', rec.idestaciones, rec.nombre;
	end loop;
END
$$;
---------------------------------------------
--Para encapsular una función que constantemente se este reautilizando es necesario
--delcararla como tal, sin el DO, el el Do es una función que se ejecuta una sola vez
CREATE FUNCTION importantePL()
RETURNS void --Quierer decir que nuestra función por el momento no retorna nada
AS --Le decimos lo que hace la función mediante el AS
$$
DECLARE
	rec record; --Para almacenar lo tipo de datos de una fila es el tipo de datos record
	--Si queremos asignar un valor de inicio se utiliza :=
BEGIN
	for rec in select * from estaciones order by idestaciones loop
    RAISE NOTICE 'Estación número % %', rec.idestaciones, rec.nombre;
	end loop;
END
$$
LANGUAGE PLPGSQL;
'''
llamamos nuestra función guardada de la siguiente manera
'''
select importantePL();
----------------------------------------
'''
Configuracmos para que regrese un valor
si quieres actualizar una pl/psgresql
es probable que no se puedas si redefines variables, pero si borras con drop y la vuelves a crear
'''
--Para encapsular una función que constantemente se este reautilizando es necesario
--delcararla como tal, sin el DO, el el Do es una función que se ejecuta una sola vez
CREATE OR REPLACE FUNCTION importantePL()
RETURNS integer --Quierer decir que nuestra función por el momento no retorna nada
AS --Le decimos lo que hace la función mediante el AS
$$
DECLARE
	rec record; --Para almacenar lo tipo de datos de una fila es el tipo de datos record
    --Si queremos asignar un valor de inicio se utiliza :=
    contador integer := 0;
BEGIN
	for rec in select * from estaciones order by idestaciones loop
    RAISE NOTICE 'Estación número % %', rec.idestaciones, rec.nombre;
	contador := contador + 1;
    end loop;
    RETURN contador;
END
$$
LANGUAGE PLPGSQL;
'''
llamamos nuestra función guardada de la siguiente manera
'''
select importantePL();

'''
CREACION DE PL DESDE PGADMIN
'''
-- FUNCTION: public.Importante2()

-- DROP FUNCTION IF EXISTS public."Importante2"();

CREATE OR REPLACE FUNCTION public."Importante2"(
	)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	rec record; --Para almacenar lo tipo de datos de una fila es el tipo de datos record
    --Si queremos asignar un valor de inicio se utiliza :=
    contador integer := 0;
BEGIN
	for rec in select * from estaciones order by idestaciones loop
    RAISE NOTICE 'Estación número % %', rec.idestaciones, rec.nombre;
	contador := contador + 1;
    end loop;
    RETURN contador;
END
$BODY$;

ALTER FUNCTION public."Importante2"()
    OWNER TO postgres;
--USANDO MAYUSCULAS EN EL NOMBRE SE LLAMA DIFERENTE A LA FUNCIPON EN EL MOTOR DE BASE DE DATOS
SELECT public."Importante2"()

--------------------------------------------
"""TRIGGERS"""
--------------------------------------------
-- FUNCTION: public.importantepl()

-- DROP FUNCTION IF EXISTS public.importantepl();

CREATE OR REPLACE FUNCTION public.importantepl()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
    contador integer := 0;
BEGIN
	select count(*) into contador from estaciones;
	insert into cambios_estaciones(num_estaciones, evento,tiempo)
	values(contador,'INSERT',now());
	return new;
END
$BODY$;

ALTER FUNCTION public.importantepl()
    OWNER TO postgres;


CREATE TRIGGER deletrigger
after INSERT
on estaciones
for each row
execute procedure importantepl2();
--------------------------------------------
-- FUNCTION: public.importantepl()

-- DROP FUNCTION IF EXISTS public.importantepl();

CREATE OR REPLACE FUNCTION public.importantepl()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
    contador integer := 0;
BEGIN
	select count(*) into contador from estaciones;
	insert into cambios_estaciones(num_estaciones, evento,tiempo)
	values(contador,'DELETE',now());
	return new;
END
$BODY$;

ALTER FUNCTION public.importantepl()
    OWNER TO postgres;

CREATE TRIGGER deletrigger
after INSERT
on estaciones
for each row
execute procedure importantepl2();



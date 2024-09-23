--------------------------------------------
"""Simulación de una conexión a bases de datos remotas"""
--------------------------------------------
'''
Hay veces que necesitamos conectarnos a servidores reportos, para ello postgres tiene libreerías que nos permiten acceder a estas bases de datos remotas
EJMPLO: dblink, estás se inicializan en los cabezales similar a python, como pandas, myplotlib, etc.
Esta librería nos permite hace consultas o joins entre bases de datos de diferentes servidores
'''
--Paso 1, podemos crear una base de datos en postgres
CREATE DATABASE remota
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

--Paso 2, creamos una tabla sencilla en esa nueva base de datos
-- Table: public.user_vip
-- DROP TABLE IF EXISTS public.user_vip;
CREATE TABLE IF NOT EXISTS public.user_vip
(
    iduservip integer,
    fecha date
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.user_vip
    OWNER to postgres;

--Paso 3, insertamos valores en esa tabla
INSERT INTO public.user_vip (iduservip, fecha)
VALUES 
(1, '2024-09-23'),
(2, '2024-09-24'),
(3, '2024-09-25'),
(4, '2024-09-26'),
(5, '2024-09-27');

--Paso 4, crear la extesión dblink para poder hacer la consulta entre bases de datos
--Si no creamos extesión no podemos ejecutar el comando, 
CREATE EXTENSION dblink;

--Paso 5, Hacemos una consulta que nos permite conectar ambas bases de datos en una consulta
--Consulta a tabla remota
select * from
dblink (
        'dbname = remota
        port = 5432
        host = 127.0.0.1
        user = postgres
        password = americafelix1998...',
        'SELECT * FROM user_vip');

'''
Al solo ejecutar lo anterior el motor de bd nos regresa lo siguiente
ERROR:  la lista de definición de columnas es obligatoria para funciones que retornan «record»
LINE 2: dblink (
        ^ 

SQL state: 42601
Character: 15
Pasa corregir esto es necesario lo siguiente
'''

--Paso 6, Llamarlo como una tabla local mediante un alias (AS)
--La línea anaterior parte de que estamos recibiendo un arreglo de datos pero el motor de la base de datos en la base local no sabe que tipos de datos vienen de la base remota
select * from
dblink (
        'dbname = remota
        port = 5432
        host = 127.0.0.1
        user = postgres
        password = americafelix1998...',
        'SELECT * FROM user_vip')
AS uservip (iduservip integer,
           fecha date);

--Paso 7 interacción entre tablas
select *
from usuarios
join dblink ('dbname = remota
        port = 5432
        host = 127.0.0.1
        user = postgres
        password = americafelix1998...',
        'SELECT * FROM user_vip')
AS uservip (iduservip integer,
           fecha date)
on usuarios.idusuarios = uservip.iduservip;

--------------------------------------------
"""Tansacciones"""
--------------------------------------------
'''
Transacciones son un conjunto de sentencias que de no realizarse de manera correcta se aplica un rollback, es decir, se devuelven todos los cambios hechos anteriormente
un homologo de esto puede ser un commit en git, pero commit tu lo realizas suponiendo que todo lo que hiciste se ejcutara de manera correcta, pero en este caso se puede configurar 
de tal manera que no se guarde nada, o no se escriba nada en la base de datos hasta que todas las sencias se hayan ejecutado de manera correcta
SINTAXIS'''
BEGIN
--<CONSULTAS>
COMMIT | ROLLBACK   --Una idea de esto, es que si es una ejecución en el sentido de guardar en bases de datos y todo es correecto le escribimos a la base de datos mediante el comiite
                    --Pero si lo que queremos es hacer una secuancia de diagnostico y si todas las sentencias se ejecutan, revertimos lo realizado, dependiendo de la intencion de la programación

--Nota importante; Por default en pgadmin, se tiene habilitado el auto commit esto indica que cada vez que ejecutamos un comando se efectua directamente a la base de datos si este es correcto o aplica
--Cuando se aplica la sentencia anterior solo se guardará si cada consulta se ejecuto correctamente a la base de datos, ejemplo, si se hace una consulta a tabla que no existe todas la sentencias que se hayan hecho no se aplican

--Ejemplo
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE user_id = 1;
SAVEPOINT my_savepoint;
UPDATE accounts SET balance = balance + 100 WHERE user_id = 2;
-- Si esta instrucción falla, podemos volver al SAVEPOINT anterior
ROLLBACK TO SAVEPOINT my_savepoint;
-- Si no hay errores, confirmamos la transacción
COMMIT;

--------------------------------------------
"""Otras Extesiones para postgres"""
--------------------------------------------
'''
Existen muchas extensiones que nos pueden ayudar para relizar actividades más complejasa, como la extesion
CREATE EXTENSION dblink;
'''
---Existen muchas extesiones que pueden ser de gran utilidad en nuestros proyectos
--https://www.postgresql.org/docs/11/contrib.html

"""
F.1. adminpack: Proporciona funciones administrativas adicionales.
F.2. amcheck: Verifica la integridad de los índices en PostgreSQL.
F.3. auth_delay: Introduce un retraso en la autenticación fallida.
F.4. auto_explain: Graba automáticamente los planes de ejecución de consultas.
F.5. bloom: Implementa un índice de filtro Bloom para múltiples columnas.
F.6. btree_gin: Permite usar operadores B-tree con índices GIN.
F.7. btree_gist: Implementa operadores B-tree en índices GiST.
F.8. citext: Proporciona un tipo de datos de texto que no distingue entre mayúsculas y minúsculas.
F.9. cube: Añade soporte para operaciones multidimensionales.
F.10. dblink: Permite ejecutar consultas en bases de datos remotas.
F.11. dict_int: Implementa un diccionario de enteros para búsquedas de texto.
F.12. dict_xsyn: Proporciona un diccionario que gestiona sinónimos para búsquedas de texto.
F.13. earthdistance: Calcula distancias entre puntos en la superficie de la Tierra.
F.14. file_fdw: Accede a archivos planos externos como si fueran tablas.
F.15. fuzzystrmatch: Proporciona funciones de coincidencia de cadenas difusas.
F.16. hstore: Permite almacenar pares clave-valor dentro de una columna.
F.17. intagg: Proporciona funciones de agregación para enteros.
F.18. intarray: Proporciona funciones y operadores para manejar arreglos de enteros.
F.19. isn: Soporta identificadores de estándares internacionales (ISBN, ISSN, etc.).
F.20. lo: Gestiona grandes objetos en PostgreSQL.
F.21. ltree: Permite almacenar y consultar datos jerárquicos.
F.22. pageinspect: Inspecciona el contenido de las páginas de tablas e índices.
F.23. passwordcheck: Valida la calidad de las contraseñas de usuarios.
F.24. pg_buffercache: Muestra el contenido del caché de búferes de PostgreSQL.
F.25. pgcrypto: Proporciona funciones para criptografía y hashing.
F.26. pg_freespacemap: Inspecciona el mapa de espacio libre.
F.27. pg_prewarm: Carga datos en caché al iniciar el servidor.
F.28. pgrowlocks: Muestra las filas bloqueadas en una tabla.
F.29. pg_stat_statements: Monitorea el rendimiento de consultas SQL.
F.30. pgstattuple: Proporciona estadísticas de espacio de tablas e índices.
F.31. pg_trgm: Realiza búsquedas rápidas basadas en trigramas.
F.32. pg_visibility: Inspecciona la visibilidad de las tuplas en las tablas.
F.33. postgres_fdw: Facilita la conexión a bases de datos PostgreSQL remotas.
F.34. seg: Añade un tipo de datos para segmentos numéricos.
F.35. sepgsql: Implementa controles de seguridad SELinux en PostgreSQL.
F.36. spi: Proporciona funciones de la interfaz de programación de procedimientos (SPI).
F.37. sslinfo: Proporciona información sobre conexiones SSL.
F.38. tablefunc: Ofrece funciones para manejar tablas crosstab y pivot.
F.39. tcn: Implementa notificaciones de cambios de tabla.
F.40. test_decoding: Extensión para pruebas de la funcionalidad de replicación lógica.
F.41. tsm_system_rows: Implementa un método de muestreo basado en filas.
F.42. tsm_system_time: Implementa un método de muestreo basado en el tiempo.
F.43. unaccent: Elimina los acentos de los textos.
F.44. uuid-ossp: Proporciona funciones para generar UUIDs.
F.45. xml2: Extensión para trabajar con XML (deprecada).
"""



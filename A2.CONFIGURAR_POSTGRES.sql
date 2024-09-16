3 Conceptops importantes entorno a las bases de datos
    1. Lenguaje
    2. Motor
        Este permite estructurar toda la inforación dentro de de un servidor
    3. Servidor
        Basicamente es el equipo, RAM, procesador, etc, donde se instala el motor de base de datos
------------------------
Postgres utiliza cómo elemento principal en su nucleo, el objeto relacional en las bases de datos
Este concepto pretendia qué las bases de datos tuvieran uan estructura cómo la del desarrollo oriendo a objetos
PostgreSQL es un sistema que maneja datos y lo hace de una forma que se llama relacional. Esto significa que organiza la información en tablas, que son como hojas de cálculo con filas y columnas.

Imagina esto:
Tablas: Piensa en una tabla como una hoja de cálculo en Excel. En una tabla puedes tener filas (cada fila es un registro) y columnas (cada columna es una característica de los registros). Por ejemplo, en una tabla de "Empleados", cada fila puede ser un empleado y las columnas pueden ser el nombre, el salario, y la fecha de ingreso.

Relaciones: Las tablas en PostgreSQL pueden estar relacionadas entre sí. Por ejemplo, puedes tener una tabla de "Empleados" y otra de "Departamentos". Puedes conectar estas dos tablas usando algo llamado llaves. La relación puede decir, por ejemplo, que el empleado "Juan Pérez" trabaja en el departamento "Ventas".

¿Cómo funciona esto?
Almacenamiento: Los datos se guardan en estas tablas.
Consultas: Puedes hacer preguntas a la base de datos, como "¿Qué empleados tienen un salario mayor a $50,000?" y PostgreSQL te dará una respuesta.
Integridad: PostgreSQL asegura que los datos en las tablas estén correctos y no se mezclen de manera errónea, gracias a las relaciones y reglas que puedes definir.
Ejemplo simple:
Imagina que tienes dos tablas:
Empleados: Con columnas para nombre y salario.
Departamentos: Con columnas para el nombre del departamento.
Cuando un empleado trabaja en un departamento, PostgreSQL usa una llave (un identificador único) para conectar la tabla de empleados con la tabla de departamentos.
En resumen, PostgreSQL usa el concepto de tablas y relaciones para organizar y manejar los datos de manera eficiente, permitiéndote hacer preguntas y mantener la información bien organizada y relacionada.
------------------------
Utilización de SQL Shell (psql) esta no es una terminal gráfica
Existe un grupo de comandos qué se presumen son los comandos más importantes, es el grupo de comando backslash, \
postgres=# \?--Con este comando se puede ver todos los comandos, te mostrará todo lo qué se puede hacer en base de datos
--Comando importantes
\l --este comando asocia las bases de datos que están instaladas en el motor
--ejemplo:
  Nombre   |  Due±o   | Codificaci¾n | Proveedor de locale |       Collate       |        Ctype        | configuraci¾n ICU | Reglas ICU: |      Privilegios
-----------+----------+--------------+---------------------+---------------------+---------------------+-------------------+-------------+-----------------------
 postgres  | postgres | UTF8         | libc                | Spanish_Mexico.1252 | Spanish_Mexico.1252 |
   |             |
 template0 | postgres | UTF8         | libc                | Spanish_Mexico.1252 | Spanish_Mexico.1252 |
   |             | =c/postgres          +
           |          |              |                     |                     |                     |
   |             | postgres=CTc/postgres
 template1 | postgres | UTF8         | libc                | Spanish_Mexico.1252 | Spanish_Mexico.1252 |
   |             | =c/postgres          +
           |          |              |                     |                     |                     |
   |             | postgres=CTc/postgres
(3 filas)
--template0 y template1, son bases de datos qué vienen instaladas de frábica 
--las tablas están asociadas a las bases de datos
\dt --te muestras las bases de datos que continen la base de datos de postgres
--si no se encuentra ninguna relacion, esto es porque solo puede acceder el motor de bases de datos, no la terminal
\c "nombre_de_la_base_de_datos"
--Ya en tu base de datos puedes corre comando qué podrías correr en un motor de base de datos como un select
--Ya en la base de datos mediante el comando \c "nombre_de_la_base_de_datos", con el comando
\h --esta funcion muestra todos los comandos de sql qué podemos ejectur, cuando tengamos dudas de como se ejecuta uno de esos comandos podemos consultar...
SELECT version();--Muestra la version de postgres que está ejecuta tu base de datos
\g --Los usuario que están accediendo a la base de datos
\timing--habilita una propiedad, después de cada comando muestra el tiempo qué le tomo ejecutarlo
--Otros ejemplos:
\c Saltar entre bases de datos

\l Listar base de datos disponibles

\dt Listar las tablas de la base de datos

\d <nombre_tabla> Describir una tabla

\dn Listar los esquemas de la base de datos actual

\df Listar las funciones disponibles de la base de datos actual

\dv Listar las vistas de la base de datos actual

\du Listar los usuarios y sus roles de la base de datos actual
-----------------------
--Una base de datos de posgres es base de datos del elefantito
Casts: Los casts permiten convertir un valor de un tipo de datos a otro en PostgreSQL. Por ejemplo, puedes convertir un número entero a texto o una cadena de texto a una fecha. Los casts son útiles cuando quieres asegurar la compatibilidad entre tipos de datos en una consulta.
Ejemplo:
sql
SELECT CAST('2024-01-01' AS DATE);
--
Catalogs: Los catalogs en PostgreSQL son colecciones de tablas que contienen información sobre los objetos de la base de datos, como tablas, vistas, índices, y más. Se utilizan para gestionar metadatos y son esenciales para el funcionamiento del sistema de base de datos. Por ejemplo, el catálogo pg_class almacena información sobre todas las tablas y relaciones en la base de datos.
--
Event Triggers: Un event trigger es un tipo especial de trigger que se activa en respuesta a eventos DDL (como la creación o eliminación de objetos de base de datos). Esto te permite ejecutar código cuando se realizan cambios en la estructura de la base de datos, como cuando se crea una tabla o un índice.
Ejemplo:
sql
CREATE EVENT TRIGGER my_trigger ON ddl_command_start
EXECUTE FUNCTION my_function();
--
Extensions:Las extensions son paquetes adicionales que añaden nuevas funcionalidades a PostgreSQL. Algunas extensiones populares son PostGIS (para datos geoespaciales) y pg_stat_statements (para monitoreo de consultas). Estas permiten ampliar las capacidades estándar de PostgreSQL sin modificar su núcleo.
Ejemplo:
sql
CREATE EXTENSION postgis;
--
Foreign Data Wrappers (FDW): Los Foreign Data Wrappers permiten a PostgreSQL acceder a bases de datos externas como si fueran tablas locales. Esto es útil cuando deseas consultar datos en otras bases de datos sin mover los datos físicamente a PostgreSQL.
Ejemplo:
sql
CREATE EXTENSION postgres_fdw;
--
Languages:Los languages en PostgreSQL son los lenguajes de programación que se pueden usar para crear funciones almacenadas y procedimientos. El lenguaje más común es PL/pgSQL, pero PostgreSQL admite otros lenguajes como Python (PL/Python) o Perl (PL/Perl).
Ejemplo:
sql
CREATE FUNCTION my_function() RETURNS void AS $$
BEGIN
   -- código en PL/pgSQL
END;
$$ LANGUAGE plpgsql;
--
Publications:Las publications se utilizan en la replicación lógica para especificar qué tablas o datos se deben replicar a otros servidores. Las publicaciones definen los objetos que se replicarán y se combinan con suscripciones.
Ejemplo:
sql
CREATE PUBLICATION my_pub FOR TABLE my_table;
--
Schemas:Los schemas en PostgreSQL organizan las tablas y otros objetos dentro de una base de datos, funcionando como carpetas que agrupan objetos relacionados. Cada base de datos puede tener múltiples esquemas, lo que facilita la separación lógica de los datos.
Ejemplo:
sql
CREATE SCHEMA my_schema;
--
Subscriptions:Las subscriptions se usan junto con las publicaciones en la replicación lógica. Una suscripción conecta una base de datos a una publicación en otra base de datos para recibir las actualizaciones de los datos.
Ejemplo:
sql
CREATE SUBSCRIPTION my_sub CONNECTION 'dbname=mydb' PUBLICATION my_pub;
Estos conceptos son esenciales para entender cómo funciona PostgreSQL en términos de organización de datos, replicación y extensibilidad del sistema.
-----------------------
Terminando de explorar las posibilidades dentro de la terminal de comandos y el interfaz gráfico, queda ahora por entender la configuración de:
Para cualquier de los 3 archivos siguientes, es neceserio leer la documentación qué viene implicita en cada archivo para entender el alcance de la configuraciones que se podrían estar llevando acabo
  postgresql.conf
  pg_hba.conf
  pg_ident.conf
--Para acceder a la ubicación de los archivos de configuració, se consulta desde pgAdmin (interfaz grafico)
SHOW config_file;
output
C:/Program Files/PostgreSQL/16/data/postgresql.conf
--Este archivo es muy importante desde aquí se pueden modificar prametros de performas de la misma base de datos}
--Se puede abrir en viasual estudio Code, y si se modiifca ya corriendo el servicio, para poder hacer valdia la configuración se tendría que reiniciar el servicio para que apliquen los cambio
C:/Program Files/PostgreSQL/16/data/pg_hba.conf
--pg_hba.conf es un archivo que nos permite hacer una gestion profesional de los usuarios, permisos y conexión a nivel red
C:/Program Files/PostgreSQL/16/data/pg_ident.conf
-- MAPNAME       SYSTEM-USERNAME         PG-USERNAME
--nos permite mapear usuarios, servidores como linux, usurios roots
--este tipo de archivo nos permite determinar qué tipo de usuario puede tener ciertos servicios o capacidades
-------------
--PRESENTACION DEL PROYECTO
--ELEMENTOS:
    --Pasajero
    --Trayecto
    --Estación
    --Tren
    --Viaje
--De las tablas anteriores se les debe aplicar el estandar ACID, con el fin de qué detectemos que tablas con de relación y qué tablas son independientes
--Tipos de datos en postgres PRINCIPALES
  --Númerico
  --Monetario
  --Texto
  --Binario
  --Fecha/hora
  --Boolean
--Tipos de datos en postgres ESPECIALES, ESTOS SON PROPIOS DE POSGRES
  --Geométricos: Te permiten usar x y y, calcular distancias y áreas
  --Dirección de Red: Almacena ips, y te permite hacer calculos de mascara de red
  --Texto tipo bit: Te permite hacer calculos en otros sistema, hexadecimal o binarios
  --XML, JSON: Ejemplo de comunicación de APIs
  --Arreglos
https://www.todopostgresql.com/postgresql-data-types-los-tipos-de-datos-mas-utilizados/

https://www.postgresql.org/docs/16/datatype.html




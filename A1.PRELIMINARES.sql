¿Qué es PL/SQL?
PL/SQL es un lenguaje de programación procedimental específico de Oracle. Combina la flexibilidad de un lenguaje de programación como Pascal o Ada con las capacidades de manejo de datos de SQL. Aunque PostgreSQL tiene su propia versión de PL/SQL, se llama PL/pgSQL, pero son bastante similares.

PL/SQL significa Procedural Language/SQL y permite:

Escribir código que maneje datos de manera lógica y estructurada.
Usar bloques de código que contienen declaraciones SQL y lógica de control como bucles, condiciones, variables, y más.
Crear procedimientos almacenados y funciones que se ejecutan en el servidor.
Manejar excepciones y errores de forma más robusta que con SQL puro.
Ejemplo de PL/pgSQL en PostgreSQL:

CREATE OR REPLACE FUNCTION aumentar_sueldo(empleado_id INT, aumento DECIMAL)
RETURNS VOID AS $$
BEGIN
    UPDATE empleados SET salario = salario + aumento WHERE id = empleado_id;
END;
$$ LANGUAGE plpgsql;

Esto crea una función que aumenta el sueldo de un empleado usando su ID.
----------------------------------------
¿Qué es un Trigger?
Un trigger (disparador) en bases de datos es una función que se ejecuta automáticamente cuando ocurre un evento en una tabla, como una inserción, actualización o eliminación de datos.

Un trigger se asocia a una tabla y responde a un evento. Los triggers son útiles para mantener la integridad de los datos o ejecutar una acción específica en respuesta a cambios en la base de datos.

Ejemplo de un trigger en PostgreSQL:

CREATE OR REPLACE FUNCTION registrar_cambio()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_cambios(tabla, operacion, fecha) 
    VALUES (TG_TABLE_NAME, TG_OP, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizacion
AFTER UPDATE ON empleados
FOR EACH ROW
EXECUTE FUNCTION registrar_cambio();

En este ejemplo:

Se crea una función de trigger llamada registrar_cambio que registra los cambios en una tabla de log.
El trigger trigger_actualizacion se activa después de cada actualización en la tabla empleados y ejecuta la función.
En resumen:

PL/SQL (en PostgreSQL sería PL/pgSQL) te permite escribir procedimientos y funciones más complejas en la base de datos.
Un trigger es una función que se ejecuta automáticamente cuando ocurre un evento (INSERT, UPDATE, DELETE) en una tabla.
-------------------------------------------------

PostGIS es una extensión para PostgreSQL que permite trabajar con datos geoespaciales, es decir, información que está relacionada con ubicaciones geográficas (como coordenadas, mapas, rutas, etc.). Básicamente, convierte a PostgreSQL en una base de datos espacial.

¿Qué hace PostGIS?
PostGIS agrega nuevas capacidades a PostgreSQL, permitiéndole:

Almacenar datos geoespaciales: Puedes guardar puntos, líneas, polígonos, y más, que representan ubicaciones en el mundo real (como una dirección o la forma de un parque).
Realizar consultas espaciales: Te permite hacer preguntas como "¿Qué tiendas están dentro de un radio de 5 km de mi ubicación?" o "¿Cuál es el camino más corto entre dos puntos?".
Procesar datos geoespaciales: Proporciona muchas funciones especiales para calcular distancias, áreas, intersecciones, y para transformar coordenadas entre distintos sistemas.
Ejemplos prácticos:
Ubicar puntos en un mapa: Si tienes una lista de restaurantes con sus coordenadas (latitud y longitud), puedes almacenarlas en una tabla y luego hacer consultas como "¿Qué restaurantes están cerca de este lugar?".
Geocercas: Puedes definir áreas geográficas específicas, como barrios o zonas de entrega, y preguntar si un punto (una dirección, por ejemplo) está dentro de esa área.
Rutas: Puedes almacenar rutas (como líneas que siguen una calle o carretera) y luego calcular la distancia entre dos puntos en esa ruta.
Ejemplo básico de uso:
Primero, necesitas agregar la extensión de PostGIS a tu base de datos:

sql
CREATE EXTENSION postgis;
Después, puedes crear una tabla con una columna especial para almacenar datos geográficos:
sql
CREATE TABLE lugares (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    ubicacion GEOMETRY(Point, 4326)
);

Y luego insertar datos geoespaciales (por ejemplo, la ubicación de un restaurante):
sql
INSERT INTO lugares (nombre, ubicacion)
VALUES ('Restaurante A', ST_SetSRID(ST_MakePoint(-99.1332, 19.4326), 4326));
Aquí, ST_SetSRID y ST_MakePoint son funciones de PostGIS que permiten crear un punto geográfico usando coordenadas de latitud y longitud.

¿Para qué se usa PostGIS?
Aplicaciones de mapas: Como servicios de entrega, navegación, o cualquier cosa que dependa de ubicaciones.
Análisis espacial: En ciencia ambiental, urbanismo, o incluso en marketing, para analizar patrones geográficos.
Sistemas de información geográfica (SIG): Es una herramienta clave en la creación y manipulación de datos geográficos.
En resumen, PostGIS convierte a PostgreSQL en una base de datos poderosa para trabajar con cualquier tipo de datos espaciales o geográficos.

------------------------

La Consola

La consola en PostgreSQL es una herramienta muy potente para crear, administrar y depurar nuestra base de datos. podemos acceder a ella después de instalar PostgreSQL y haber seleccionado la opción de instalar la consola junto a la base de datos.

PostgreSQL está más estrechamente acoplado al entorno UNIX que algunos otros sistemas de bases de datos, utiliza las cuentas de usuario nativas para determinar quién se conecta a ella (de forma predeterminada). El programa que se ejecuta en la consola y que permite ejecutar consultas y comandos se llama psql, psql es la terminal interactiva para trabajar con PostgreSQL, es la interfaz de línea de comando o consola principal, así como PgAdmin es la interfaz gráfica de usuario principal de PostgreSQL.

Después de emitir un comando PostgreSQL, recibirás comentarios del servidor indicándote el resultado de un comando o mostrándote los resultados de una solicitud de información. Por ejemplo, si deseas saber qué versión de PostgreSQL estás usando actualmente, puedes hacer lo siguiente:

SELECT version();

De manera predeterminada PostgreSQL no crea bases de datos para usar, debemos crear nuestra base de datos para empezar a trabajar, verás que existe ya una base de datos llamada postgres pero no debe ser usada ya que hace parte del CORE de PostgreSQL y sirve para gestionar las demás bases de datos.

Para crear una base de datos debes ejecutar la consulta de creación de base de datos, es importante entender que existe una costumbre no oficial al momento de escribir consultas; consiste en poner en mayúsculas todas las palabras propias del lenguaje SQL cómo CREATE, SELECT, ALTE, etc y el resto de palabras como los nombres de las tablas, columnas, nombres de usuarios, etc en minúscula. No está claro el porqué de esta especie de “estándar” al escribir consultas SQL pero todo apunta a que en el momento que SQL nace, no existían editores de consultas que resaltaran las palabras propias del lenguaje para diferenciar fácilmente de las palabras que no son parte del lenguaje, por eso el uso de mayúsculas y minúsculas.

Las palabras reservadas de consultas SQL usualmente se escriben en mayúscula, ésto para distinguir entre nombres de objetos y lenguaje SQL propio, no es obligatorio, pero podría serte útil en la creación de Scripts SQL largos.

------------------------


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
-----------------------
--Una base de datos de posgres es base de datos del elefantito

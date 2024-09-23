--------------------------------------------
"""Backups y restauraciones"""
--------------------------------------------
"""postgres tiene los servicios de restablecimiento de bases de datos"""

--Paso 1 desde pgadmin, desde la base de datos clic derecho y backup, abre un formulario para relizar el back
--Tipo de formatos para relizar el backup
'''
Custum - Es propio de PostgreSQL, no puedes usar este formato para otros editores.
Tar - Archivo comprimido que contiene la estructura de la base de datos.
Plain - SQL plano, es un script de texto con las instrucciones para recrear la base de datos.
Directory - Es un formato que divide el backup en múltiples archivos dentro de un directorio. Permite paralelizar la restauración y es útil para grandes bases de datos, ya que mejora la eficiencia en la creación de los backups y la restauración de datos.
'''
--Hay muchas opciones dentro del dump, para un respaldo más especializado, esto dependerá las necesidades del backuo

--Paso 2, la restauración dado que puede hacer desde la obción de cualquier base dedatos dentro del serivdor, siempre y cuando no exista lo mencionado en el backup se aplicará el respaldo
--Si ya existe alguna tabla o elemento en la bd que proviende del backup esta parte del codigo se ejecutara fungue como parche pero restableserá al momento que se hizo el backup

--------------------------------------------
"""Mantenimiento"""
--------------------------------------------
--postgres tiene una serie de actividades que se desarrollan en segundo plano mientras nosotros trabajamos con la base de datos, a esto nosotros lo llamamos manteniemiento
--El nombre más común es vaciado, posgres tiene dos niveles de limpieza, el liviano que se ejeecuta continuamente
--Full que es completo qué es completo, que bloquea las tablas para hacer el vaciado, en estos dos procedimeintos no hay que involucrarse mucho a menos que se tengan problemas de indexación
--Ejemplo que se demore al hacer las consultas en tablas
--El mantenimiento se puede hacer en base de datos o en tablas

'''
OPERACIONES DE MANTENIMIENTO TABLA:

1. **VACUUM**: 
   - Limpia las filas muertas generadas por operaciones de actualización o eliminación para liberar espacio en disco.
   - **Opciones**:
     - **FULL**: Realiza una limpieza completa de la tabla, liberando todo el espacio no utilizado y compactando la tabla. Sin embargo, este proceso bloquea la tabla mientras se ejecuta, lo que puede afectar el rendimiento.
     - **FREEZE**: Congela las filas antiguas para evitar que necesiten vaciado en el futuro. Se utiliza cuando se aproxima el límite del "transaction ID wraparound".
     - **ANALYZE**: Junto con la limpieza, recolecta estadísticas de la tabla para optimizar las consultas posteriores.

2. **ANALYZE**:
   - Recolecta estadísticas sobre el contenido de las tablas para ayudar al optimizador a elegir los mejores planes de ejecución. 
   - **NO HACE CAMBIOS** en los datos, solo actualiza la información de las estadísticas.

3. **REINDEX**:
   - Reconstruye uno o más índices de una tabla. Es útil cuando los índices han crecido mucho y se vuelven ineficientes debido a modificaciones en la tabla.
   - **NO TIENE OPCIONES** específicas, pero se puede usar en un índice, una tabla o incluso una base de datos completa.

4. **CLUSTER**:
   - Reorganiza físicamente una tabla en disco según un índice. Mejora el rendimiento de las consultas que acceden a los datos en el orden de dicho índice.
   - Reorganiza los datos en el disco para que coincidan con el orden del índice especificado, mejorando la eficiencia de las consultas que usan ese índice.

'''
--A nivel de base de datos las opciones con más amplias y tiene mayores características que pueden servir para la necesidad del mantenimiento

--------------------------------------------
"""Introduccion a replicas"""
--------------------------------------------
'''
Existen dos tipo de personas, las que están usando replicas y los que las van a usar...

Piensa siempre en modo Réplica
'''

--las replicas son la solución definitiva para los problemas de lectura y escritura
'''
Problemas de Lectura
Carga de Lectura Alta:

Cuando una aplicación tiene muchas consultas de lectura, puede saturar el servidor principal, afectando el rendimiento y la velocidad de respuesta.
Retraso en las Consultas:

A medida que la cantidad de datos y las consultas aumentan, las consultas pueden volverse más lentas, causando tiempo de espera prolongado para los usuarios.
Puntos Únicos de Fallo:

Si el servidor principal se cae, todas las operaciones de lectura se detienen, afectando la disponibilidad de la aplicación.
Problemas de Escritura
Rendimiento de Escritura:

Un alto volumen de operaciones de escritura puede afectar el rendimiento del servidor, especialmente si hay muchas transacciones simultáneas.
Bloqueos:

Las transacciones de escritura pueden provocar bloqueos que afecten las operaciones de lectura y escritura, causando tiempos de espera para los usuarios.
Escalabilidad:

A medida que crece la base de datos y la cantidad de usuarios, la capacidad del servidor principal puede llegar a su límite, dificultando el manejo de nuevas escrituras.
Soluciones a través de Réplicas
Réplicas de Solo Lectura:

Permiten distribuir la carga de lectura a múltiples servidores, lo que mejora el rendimiento y reduce la latencia.
Desacoplamiento de Lecturas y Escrituras:

Al separar las operaciones de lectura y escritura, se puede mejorar el rendimiento general de la aplicación, permitiendo que el servidor principal se enfoque en manejar las escrituras.
Alta Disponibilidad:

En caso de falla del servidor principal, las réplicas pueden ser promovidas a primarias, asegurando que las operaciones de lectura y escritura continúen sin interrupciones.
Escalabilidad Horizontal:

La adición de más réplicas permite manejar un mayor número de operaciones de lectura, lo que facilita el crecimiento de la aplicación sin afectar el rendimiento.
'''

--Cual es la estrategía
--Separar las bases de datos, el espejo sería donde ser hacen todas las consultas y la original sería donde se modifica la base de datos

--------------------------------------------
"""Implementación de replicas en postgres"""
--------------------------------------------
https://www.virtuozzo.com/application-platform/?referer=jelastic

https://app.cloudjiffy.co/

https://platzi.com/tutoriales/1480-postgresql/6559-implementacion-de-replicas-en-postgres-con-docker-2/

--------------------------------------------
"""Otras buenas prácticas"""
--------------------------------------------
--Evitar los bloqueos por insersiones y borrado en la misma tabla

'''
¿Qué es una tabla consolidada?
Una tabla consolidada es un tipo de tabla en bases de datos que combina y resume datos de diferentes fuentes o tablas para proporcionar una visión más clara y simplificada de la información. Estas tablas se utilizan comúnmente en procesos de análisis de datos, informes y en la toma de decisiones. Aquí tienes algunas características y beneficios de las tablas consolidadas:

Características de una Tabla Consolidada
Agregación de Datos:

Combina datos de múltiples registros o tablas, a menudo utilizando funciones de agregación como SUM, AVG, COUNT, etc., para resumir la información.
Estructura Simplificada:

Presenta los datos en un formato más accesible, eliminando la complejidad de las tablas originales y enfocándose en métricas clave.
Fuente Única de Verdad:

Proporciona una única vista de los datos, lo que ayuda a evitar inconsistencias y a asegurar que todos los usuarios estén trabajando con la misma información.
Uso en Informes y Análisis:

Frecuentemente utilizada en informes financieros, de ventas o de rendimiento, donde se requiere una visión global de los datos.
Beneficios de una Tabla Consolidada
Mejora en el Rendimiento:

Al reducir la cantidad de datos que se deben procesar, las tablas consolidadas pueden mejorar el rendimiento de las consultas y análisis.
Facilitación de la Toma de Decisiones:

Al proporcionar un resumen claro y conciso, ayudan a los gerentes y a otros tomadores de decisiones a comprender rápidamente el estado de la organización.
Ahorro de Tiempo:

La consolidación de datos en una sola tabla puede ahorrar tiempo en la búsqueda y análisis de información, permitiendo un acceso más rápido a los datos relevantes.
Facilidad de Mantenimiento:

Al consolidar datos, se puede reducir la cantidad de tablas y relaciones que deben gestionarse, simplificando el mantenimiento de la base de datos.
Ejemplo de Uso
Imagina una base de datos de ventas que incluye tablas para Ventas, Productos, y Clientes. Una tabla consolidada podría resumir la información de ventas por producto y cliente, mostrando total de ventas y cantidad vendida, permitiendo a los gerentes analizar el rendimiento de productos específicos o el comportamiento de compra de diferentes clientes.
'''

--Cuando consolidamos información, se borra la tabla o la infromación que creamos, porque ya se está respaldando en la consolidada
--pero eso borrar y volver a crear tabla no es eficiente
--Un tip de experiencia es renombrar tablas, que el sistema ataque dos tablas
--El apuntador de la tabla consolidada es a la renombrada, y la nueva tabla donde se insertan los datos será más eficiente porque está  vacia 

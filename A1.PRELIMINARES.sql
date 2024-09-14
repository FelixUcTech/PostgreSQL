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

-----------------------------------------

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
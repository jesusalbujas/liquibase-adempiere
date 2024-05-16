# Pasos a Seguir

Al levantar el compose ingresar al contenedor. Previamente está creada la base de da tos `adempiere`, deberá crear la base de datos `seed` para efecto de pruebas.

- `createdb -U adempiere seed`

Insertar información a la base de datos `adempiere`

```sql
-- Creación de tablas
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL,
    location VARCHAR(255)
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    hire_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2),
    category VARCHAR(100)
);
```

Agregar información a las tablas

```sql
-- Inserción de datos de ejemplo
INSERT INTO departments (department_name, location) VALUES
    ('Sales', 'New York'),
    ('Marketing', 'San Francisco'),
    ('Engineering', 'Seattle');
```

Ahora, en el directorio `/liquibase` dentro del contenedor ejecutamos el siguiente comando para verificar las diferencias entre ambas bases de datos:

```sh
 liquibase generateChangelog  --url="jdbc:postgresql://localhost/adempiere"   --username=adempiere   --password=adempiere   --referenceUrl="jdbc:postgresql://localhost/seed"   --referenceUsername=adempiere   --referencePassword=adempiere  --changeLogFile=db_changelog.xml
```

Creara un archivo changelog, con el siguiente nombre `db_changelog.xml`, ahora lo siguiente es aplicar este changelog en la base de datos `seed`

```
liquibase update
```

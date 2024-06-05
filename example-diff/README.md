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

---

## Prueba con ADempiere

Entrar en el servicio de Liquibase para crear la otra base de datos

```bash
createdb -U adempiere seed && pg_restore -U adempiere -v -d adempiere < /tmp/seed.backup && pg_restore -U adempiere -v -d seed < /tmp/seed.backup
```

Hacer una prueba actualizando un socio de negocios en la base de datos `adempiere`

```sql
UPDATE C_BPartner SET Name='Epale', Name2='todo bien' WHERE C_BPartner_ID=50000;
```

Generar Changelog

> [!TIP]
> Al comando `--changeLogFile` se le especifica en qué formato nos traerá los cambios entre las bases de datos. Es decir, al modificar el tipo de archivo este lo traerá en el formato especificado.

Tipos de Archivos

- .yaml
- .json
- .xml
- .sql

```sh
liquibase generateChangelog \
  --url="jdbc:postgresql://localhost/adempiere" \
  --username=adempiere \
  --password=adempiere \
  --referenceUrl="jdbc:postgresql://localhost/seed" \
  --referenceUsername=adempiere \
  --referencePassword=adempiere \
  --excludeObjects="T_*,ad_archive,ad_image,ad_session,ad_changelog,ad_pinstance_para,ad_pinstance,ad_pistance_log,ad_migrationdata,ad_migrationstep,ad_issue,ad_wf_process,ad_wf_activity,ad_wf_eventaudit,ad_scheduler,I_*,ad_table,a_asset_acct,a_asset_addition,a_asset_change,a_asset_change_amt,a_asset_class,a_asset, a_asset_delivery,a_asset_disposed,a_asset_group,a_asset_group_acct,a_asset_info_fin,a_asset_info_ins,a_asset_info_lic,a_asset_info_oth,a_asset_info_tax,a_asset_product,a_asset_retirement,a_asset_reval,a_asset_info_tax,c_elementvalue,a_*"\
  --changeLogFile=db_changelog.xml
```

Aplicar cambios

```bash
liquibase update
```

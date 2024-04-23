
# Gestión de Cambios de BD mediante LiquiBase

- Almacena una lista de los cambios aplicados.

LiquiBase usa ficheros XML para describir los cambios (changesets), lo que permite independencia del sistema de BD utilizado. Un changeset se identifica por su **id** y **author**, así como por el propio nombre del fichero.

Cuando se aplica un changeset, LiquiBase a parte de realizar las modificaciones pertinentes, registra una entrada con el cambio en su tabla de histórico **DatabaseChangeLog**. De hecho, antes de aplicar un changeset, se comprueba con dicha tabla que este no se ha realizado previamente.

## LiquiBase y sus tablas

Usa dos tablas:

- `DatabaseChangeLog`: Para el registro de cambios aplicados

- `DatabaseChangeLock`: Utilizada para controlar la concurrencia.

Ambos bajo el esquema `public`.

## Primero pasos

### Iniciar el proyecto

> [!NOTE]
> Inicializar un nuevo proyecto de Liquibase con la configuración necesaria para conectarte a una base de datos PostgreSQL y generar un archivo de changelog.

```sh
liquibase init project \
--project-dir=/liquibase \
--changelog-file=changelog.xml \
--format=xml \
--url=jdbc:postgresql://localhost/adempiere \
--username=adempiere \
--password=adempiere
```

---

## Primeros pasos con LiquiBase

- changelog.xml

```xml
<databaseChangeLog
    xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:ext="http://www.liquibase.org/xml/ns/dbchangelog-ext"
    xmlns:pro="http://www.liquibase.org/xml/ns/pro"
    xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
        http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-latest.xsd
        http://www.liquibase.org/xml/ns/dbchangelog-ext http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-ext.xsd
        http://www.liquibase.org/xml/ns/pro http://www.liquibase.org/xml/ns/pro/liquibase-pro-latest.xsd">

</databaseChangeLog>
```

En este fichero es donde indicamos todos los cambios o ChangeSets. Para más información al respecto puede entrar al [siguiente enlace](https://docs.liquibase.com/change-types/home.html) donde encontrará mucha más información de la documentación oficial de LiquiBase.

> [!TIP]
> Es importante mencionar que los campos a colocar en el changelog debe ir en minúsculas. LiquiBase es estricto en este aspecto. De lo contrario usted recibirá un error tal como el siguiente:

```sql
Caused by: LiquiBase.exception.MigrationFailedException: Migration failed for changeset changelog.xml::update-example::LiquiBase-docs:
     Reason: LiquiBase.exception.DatabaseException: ERROR: column "Value" of relation "ad_user" does not exist
  Position: 30 [Failed SQL: (0) UPDATE adempiere.ad_user SET "Value" = 'test' WHERE name='epale']
```

---

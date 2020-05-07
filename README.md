# dbt-migrations
A dbt plugin to support database migrations.

## Usage instructions



migrations/1.sql
```
{{ config(materialized='migration') }}
{{ dbt_migrations.enforce_migration_dependancy() }}

create or replace file format my_csv_format
  type = csv
  field_delimiter = '|'
  skip_header = 1
  null_if = ('NULL', 'null')
  empty_field_as_null = true
  compression = gzip;
```

migrations/2.sql
```
{{ config(materialized='migration') }}
{{ dbt_migrations.enforce_migration_dependancy() }}

create or replace stage my_int_stage
  file_format = my_csv_format;

```

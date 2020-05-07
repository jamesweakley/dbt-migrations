# dbt-migrations
A dbt plugin to support database migrations.

*In feedback phase, very unstable!*

This plugin introduces the concept of database migrations, which on the surface is counter to the dbt "everything is a select statement" mantra.

It's important to note that this plugin is specifically *not* for creating tables, views or any other type of relation. Instead, it is to manage the many other types of objects present in modern analytics databases (stages, file formats, pipes, tasks, streams, etc).


Currently, ensuring the migrations run in order is a little tricky, and it's necessary to create model dependancies by convention (just an incrementing number). (In future)[https://github.com/fishtown-analytics/dbt/issues/1212] it maybe be possible to support nicely named migration files with semantic versioning in their names.,



## Usage instructions

1. Add to packages.yml in your dbt project root:
```
packages:    
  - git: "https://github.com/jamesweakley/dbt-migrations.git"
    revision: master
```

2. Run `dbt deps`

3. Add "migrations" to your source-paths array in project.yml

4. Create migration files like so:

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

5. `dbt run`
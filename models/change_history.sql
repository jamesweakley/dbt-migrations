{{ config(schema='migrations',unique_key='revision') }}

select 0 as revision,current_timestamp as installed_datetime
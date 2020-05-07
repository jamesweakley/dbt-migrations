{{ config(schema='migrations',unique_key='revision',materialized='incremental') }}

select 0::number(10,0) as revision,{{ dbt_utils.current_timestamp() }} as installed_datetime
{% macro enforce_migration_dependancy() -%}
{% set help_dbt_infer_dependancies = ref('change_history') %}
{% set this_rev = (this.name | int) %}
{% if this_rev > 1 %}
    {% set prev_rev = (this_rev-1)| string %}
    {% set x = ref(prev_rev) %}
{% endif %}
{%- endmacro %}
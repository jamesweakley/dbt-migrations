{% macro enforce_migration_dependancy() -%}
{% set this_rev = (this.name | int) %}
{% if this_rev > 1 %}
    {% set prev_rev = (this_rev-1)| string %}
    {% set x = ref(prev_rev) %}
{% endif %}
{%- endmacro %}
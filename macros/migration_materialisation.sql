{% materialization migration, default %}
    
    {% set this_rev = (this.name | int) %}
    {% set query_text %}
        select * from {{ ref('change_history') }} where revision={{ this_rev }}
    {% endset %}
    {% set existing_entry = run_query(query_text) %}

    {%- if existing_entry|length == 0 %}
        log('Running migration ' ~ this_rev, info=True)}}
        {% call statement('main') -%}
            {{ sql }}
        {%- endcall %}
        {% call statement('main') -%}
            insert into {{ ref('change_history') }} (revision,installed_datetime) values ({{ this_rev }},{{ dbt_utils.current_timestamp() }}
)
        {%- endcall %}
        {{ adapter.commit() }}
    {% else %}
        log('Not running migration ' ~ this_rev, info=True)}}
    {% endif -%}
    

{%- do store_result('main', status='OK') -%}
{% endmaterialization %}

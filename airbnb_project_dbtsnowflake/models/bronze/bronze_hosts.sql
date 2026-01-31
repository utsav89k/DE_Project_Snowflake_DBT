{{
  config(
    materialized = 'incremental'
    )
}}

select * from {{ source('staging_source', 'hosts') }}

{% if is_incremental() %}
    where CREATED_AT >(select COALESCE(max(CREATED_AT),'1900-01-01') from {{this}})
{% endif %}
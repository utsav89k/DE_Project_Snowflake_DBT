{{
  config(
    materialized = 'incremental',
    unique_key = 'HOST_ID'
    )
}}

select
    HOST_ID,
    REPLACE(HOST_NAME,' ','_') as HOST_NAME,
    HOST_SINCE as HOST_SINCE,
    IS_SUPERHOST,
    RESPONSE_RATE,
    CASE
        when RESPONSE_RATE>95 then 'VERY GOOD'
        when RESPONSE_RATE>80 then 'GOOD'
        when RESPONSE_RATE>60 then 'FAIR'
        ELSE 'POOR'
    END AS RESPONSE_RATE_QUALITY,
    CREATED_AT
FROM {{ ref('bronze_hosts') }}
{% if is_incremental() %}
  where CREATED_AT > (select max(CREATED_AT) from {{ this }})
{% endif %}

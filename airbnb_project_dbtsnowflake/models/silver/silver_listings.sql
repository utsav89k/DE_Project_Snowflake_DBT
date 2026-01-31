{{
  config(
    materialized = 'incremental',
    unique_key = 'LISTING_ID'
    )
}}

select LISTING_ID, HOST_ID, PROPERTY_TYPE, CITY, COUNTRY, ACCOMMODATES, BEDROOMS, BATHROOMS, PRICE_PER_NIGHT,
{{tag('CAST(price_per_night AS INT)')}} as PRICE_PER_NIGHT_TAG, CREATED_AT
FROM {{ ref('bronze_listings') }}
{% if is_incremental() %}
  where CREATED_AT > (select max(CREATED_AT) from {{ this }})
{% endif %}
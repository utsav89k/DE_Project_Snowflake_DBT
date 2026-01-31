{{
  config(
    materialized = 'incremental',
    unique_key='BOOKING_ID',
    incremental_strategy='merge',
    on_schema_change='sync_all_columns'
  )
}}
select BOOKING_ID, LISTING_ID,BOOKING_DATE, 
        {{multiply('NIGHTS_BOOKED','BOOKING_AMOUNT',2)}}  as TOTAL_BOOKING_AMOUNT,
        CLEANING_FEE, CREATED_AT, SERVICE_FEE
FROM {{ ref('bronze_bookings') }}
{% if is_incremental() %}
  where BOOKING_DATE > (select max(BOOKING_DATE) from {{ this }})
{% endif %}
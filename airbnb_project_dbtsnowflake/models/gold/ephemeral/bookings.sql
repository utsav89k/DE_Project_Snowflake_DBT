{{
  config(
    materialized = 'ephemeral'
    )
}}

with bookings as (
    select 
        BOOKING_ID,
        BOOKING_DATE,
        CREATED_AT
    from {{ ref('gold_obt') }}
)


select * from bookings
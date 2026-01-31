{{
  config(
    severity = 'warn'
    )
}}

select 1
from {{ source('staging_source', 'bookings') }}
where BOOKING_AMOUNT <300
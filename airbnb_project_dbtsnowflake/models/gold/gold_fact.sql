{% set config_elements = [
    {
        "table" : "AIRBNB.GOLD.gold_OBT",
        "columns" : "GOLD_obt.BOOKING_ID, GOLD_obt.LISTING_ID, GOLD_obt.HOST_ID,GOLD_obt.TOTAL_BOOKING_AMOUNT, GOLD_obt.SERVICE_FEE, GOLD_obt.CLEANING_FEE, GOLD_obt.ACCOMMODATES, GOLD_obt.BEDROOMS, GOLD_obt.BATHROOMS, GOLD_obt.PRICE_PER_NIGHT, GOLD_obt.RESPONSE_RATE",
        "alias" : "GOLD_obt"
    },
    { 
        "table" : "AIRBNB.GOLD.DIM_LISTINGS",
        "columns" : "",
        "alias" : "DIM_listings",
        "join_condition" : "GOLD_obt.listing_id = DIM_listings.listing_id"
    },
    {
        "table" : "AIRBNB.GOLD.DIM_HOSTS",
        "columns" : "",
        "alias" : "DIM_hosts",
        "join_condition" : "GOLD_obt.host_id = DIM_hosts.host_id"
    }
] %}



SELECT 
        {{ config_elements[0]['columns'] }}

FROM
    {% for config_item in config_elements %}
    {% if loop.first %}
      {{ config_item['table'] }} AS {{ config_item['alias'] }}
    {% else %}
        LEFT JOIN {{ config_item['table'] }} AS {{ config_item['alias'] }}
        ON {{ config_item['join_condition'] }}
        {% endif %}
        {% endfor %}
view: fruit_basket {
 derived_table: {
   sql:
SELECT
    'apple' AS fruit_type,
    'red' AS color,
    'yes' AS is_round,
    1.25 AS price_per_pound,
    0.6 AS weight,
    0.75 AS price,
    TIMESTAMP('2025-01-01') AS added_to_cart_date
UNION ALL
SELECT
    'apple',
    'red',
    'yes',
    1.25,
    0.55,
    0.69,
    TIMESTAMP('2025-01-08')
UNION ALL
SELECT
    'apple',
    'green',
    'yes',
    1.15,
    0.4,
    0.46,
    TIMESTAMP('2025-01-02')
UNION ALL
SELECT
    'banana',
    'yellow',
    'no',
    0.75,
    0.7,
    0.53,
    TIMESTAMP('2025-01-10')
UNION ALL
SELECT
    'banana',
    'yellow',
    'no',
    0.75,
    0.75,
    0.56,
    TIMESTAMP('2025-01-12')
UNION ALL
SELECT
    'orange',
    'orange',
    'yes',
    1.45,
    0.5,
    0.73,
    TIMESTAMP('2025-01-25')
UNION ALL
SELECT
    'orange',
    'orange',
    'yes',
    1.45,
    0.45,
    0.65,
    TIMESTAMP('2025-01-03')
UNION ALL
SELECT
    'lemon',
    'yellow',
    'no',
    2.25,
    0.2,
    0.45,
    TIMESTAMP('2025-02-01')
UNION ALL
SELECT
    'lemon',
    'yellow',
    'no',
    2.25,
    0.22,
    0.50,
    TIMESTAMP('2025-01-01')
UNION ALL
SELECT
    'lemon',
    'yellow',
    'no',
    2.25,
    0.19,
    0.43,
    TIMESTAMP('2025-01-02')
UNION ALL
SELECT
    'lime',
    'green',
    'no',
    2.40,
    0.18,
    0.43,
    TIMESTAMP('2025-02-06')
UNION ALL
SELECT
    'lime',
    'green',
    'no',
    2.40,
    0.17,
    0.41,
    TIMESTAMP('2025-01-20')
;;
 }

dimension: fruit_type {
  type: string
  sql: ${TABLE}.fruit_type ;;
  link: {
    label: "Google Search"
    url: "https://www.google.com/search?q={{ value | encode_url}}"
    icon_url: "https://www.google.com/s2/favicons?domain=www.google.com"
  }
}

  dimension: color {
    type: string
    sql: ${TABLE}.color ;;
  }

  dimension: is_round {
    type: yesno
    sql: ${TABLE}.is_round = 'yes' ;;
  }

  dimension: price_per_pound {
    type: number
    value_format: "$0.00"
    sql: ${TABLE}.price_per_pound ;;
  }

  dimension: weight {
    type: string
    sql: ${TABLE}.weight ;;
  }

  dimension: price {
    type: string
    value_format: "$0.00"
    sql: ${TABLE}.price ;;
  }

  dimension_group: added_to_cart {
    type: time
    sql: ${TABLE}.added_to_cart_date ;;
  }

  measure: count {
    type: count
    drill_fields: [fruit_type, color, weight, is_round, price, price_per_pound]
  }

  measure: total_price {
    type: sum
    value_format: "$0.00"
    sql: ${price};;
    drill_fields: [fruit_type, color, weight, is_round, price, price_per_pound]
  }

  measure: average_price {
    type: average
    value_format: "$0.00"
    sql: ${price};;
    drill_fields: [fruit_type, color, weight, is_round, price, price_per_pound]
  }
}

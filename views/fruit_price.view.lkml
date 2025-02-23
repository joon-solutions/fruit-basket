view: fruit_price {
  derived_table: {
    sql:
      WITH FruitTypes AS (
        SELECT 'apple' AS fruit_type, 'red' AS color UNION ALL
        SELECT 'apple', 'green' UNION ALL
        SELECT 'banana', 'yellow' UNION ALL
        SELECT 'orange', 'orange' UNION ALL
        SELECT 'lemon', 'yellow' UNION ALL
        SELECT 'lime', 'green'
      ),
      DateSeries AS (
        SELECT date
        FROM UNNEST(GENERATE_DATE_ARRAY('2024-12-01', DATE_ADD('2024-12-01', INTERVAL 2 MONTH), INTERVAL 1 DAY)) AS date
      ),
      FruitPrices AS (
          SELECT
              timestamp(d.date) as date,
              f.fruit_type,
              f.color,
              ROUND((RAND() * 1.5 + 0.5),2) AS price -- Random price between 0.5 and 2
          FROM DateSeries d
          CROSS JOIN FruitTypes f
      )
      SELECT *
      FROM FruitPrices
    ;;
  }

  dimension: fruit_type {
    type: string
    sql: ${TABLE}.fruit_type ;;
  }

  dimension: color {
    type: string
    sql: ${TABLE}.color ;;
  }

  dimension: price {
    type: string
    value_format: "$0.00"
    sql: ${TABLE}.price ;;
  }

  dimension_group: date {
    type: time
    sql: ${TABLE}.date ;;
  }

  measure: average_price {
    type: average
    value_format: "$0.00"
    sql: ${price};;
    drill_fields: [fruit_type, color, price]
  }

  measure: market_price {
    type: average
    value_format: "$0.00"
    sql: ${price};;
    drill_fields: [fruit_type, color, price]
  }
}

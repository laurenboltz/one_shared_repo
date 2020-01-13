view: sme_lookml_liquid_exercise_2 {
  derived_table: {
    sql: SELECT
        DATE(orders.created_at ) AS `orders.created_date`,
        products.category  AS `products.category`,
        products.brand  AS `products.brand`,
        COUNT(DISTINCT orders.id ) AS `orders.count`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
      LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id

      WHERE
        (((orders.created_at ) >= ((DATE_ADD(TIMESTAMP(DATE_FORMAT(DATE(NOW()),'%Y-01-01')),INTERVAL -2 year))) AND (orders.created_at ) < ((DATE_ADD(DATE_ADD(TIMESTAMP(DATE_FORMAT(DATE(NOW()),'%Y-01-01')),INTERVAL -2 year),INTERVAL 3 year)))))
      GROUP BY 1,2,3
      ORDER BY DATE(orders.created_at ) DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orders_created_date {
    type: date
    sql: ${TABLE}.`orders.created_date` ;;
  }

  dimension: products_category {
    type: string
    sql: ${TABLE}.`products.category` ;;
  }

  dimension: products_brand {
    type: string
    sql: ${TABLE}.`products.brand` ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

  set: detail {
    fields: [orders_created_date, products_category, products_brand, orders_count]
  }
}

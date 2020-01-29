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
        {% condition date_filter %} orders.created_at {% endcondition %}
      GROUP BY 1,2,3
      ORDER BY DATE(orders.created_at ) DESC
       ;;
  }

filter: date_filter {
  type: date
}

filter: brand_selector {
  type: string
  suggest_dimension: products_brand
  sql: {% condition brand_selector %} ${products_brand} {% endcondition %} ;;
}

parameter: country {
  type: string
  allowed_value: {
    value: "EU"
  }
  allowed_value: {
    value: "US"
  }
}

  dimension: orders_created_date {
    type: date
    sql: ${TABLE}.`orders.created_date` ;;
    html:
    {% if country._parameter_value == "'US'" %}
      {{rendered_value | date: "%m/%d/%Y" }}
    {% elsif country._parameter_value == "'EU'" %}
     {{rendered_value | date: "%d/%m/%Y" }}
    {% else %}
      {{ value }}
    {% endif %};;
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

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  set: detail {
    fields: [orders_created_date, products_category, products_brand, orders_count]
  }
}

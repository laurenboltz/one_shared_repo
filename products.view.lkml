view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    link: {
      label: "Dashboard B"
      url:
      "/dashboards/3538?Brand%20Filter={{ products.brand._filterable_value }}
      &Category%20Filter={{ value | url_encode }}
      &Date%20Filter={{ _filters['orders.created_date'] | url_encode }}"
    }
    link: {
      label: "Explore Pt. 2"
      url:
      "/explore/Lauren_Git/order_items?fields=orders.created_date,products.category,products.brand,orders.count&f[orders.created_date]={{ _filters['orders.created_date'] }}
      &f[products.category]={{ value | url_encode }}
      &sorts=orders.created_date+desc&limit=500"

    }
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: total_spend {
    type: sum
    sql: ${retail_price} ;;
  }

  measure: big_total {
    type: yesno
    sql: ${total_spend} > 10 ;;
  }

  measure: is_active {
    type: string
    sql: CASE WHEN ${big_total} THEN "Active"
    Else "unactive"
    end;;
  }
  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}

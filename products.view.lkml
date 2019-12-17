view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: CASE
    WHEN ${TABLE}.brand = "O'Neill" then "O'Neill"
    WHEN ${TABLE}.brand = "Calvin Klein" then "Calvin Klein"
    WHEN ${TABLE}.brand = "Hanes" then "Hanes"
    WHEN ${TABLE}.brand = "Tommy Hilfiger" then "Tommy Hilfiger"
    ELSE "Other"
    End;;
  }

  dimension: brand_logo {
    type: string
    sql: ${TABLE}.brand ;;
    html:
    {% if brand._value == "O'Neill" %}
    <img src="https://upload.wikimedia.org/wikipedia/en/thumb/1/1b/O%27Neill_%28brand%29_logo.svg/220px-O%27Neill_%28brand%29_logo.svg.png">
    {% elsif brand._value == "Calvin Klein" %}
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Calvin_klein_logo.svg/220px-Calvin_klein_logo.svg.png">
    {% elsif brand._value == "Hanes" %}
    <img src="https://upload.wikimedia.org/wikipedia/en/thumb/f/f0/Hanes-logo.svg/150px-Hanes-logo.svg.png">
    {% elsif brand._value == "Tommy Hilfiger"%}
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Tommy_hilfig_vectorlogo.svg/250px-Tommy_hilfig_vectorlogo.svg.png">
    {% else %}
    <img src="https://images.yourstory.com/cs/2/930f35b0-6b3f-11e9-83be-416c2e530972/Untitled_design_(2)_(1)1559914904431.png?fm=png&auto=format">
    {% endif %} ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
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

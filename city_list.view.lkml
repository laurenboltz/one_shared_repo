view: city_list {
  derived_table: {
    sql: -- raw sql results do not include filled-in values for 'orders.created_date'


      SELECT
        DATE(orders.created_at ) AS `orders.created_date`,
        GROUP_CONCAT(DISTINCT users.city  ORDER BY users.city   SEPARATOR '|RECORD|' ) AS `users.user_cities`
      FROM demo_db.orders  AS orders
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id

      GROUP BY 1
      LIMIT 500
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

  dimension: users_user_cities {
    type: string
    sql: ${TABLE}.`users.user_cities` ;;
#     html:
#   {% assign words = {{ value }} | split: ' ' %}
#   <ul>
#   {% for word in words %}
#   <li> {{ word }} </li>
#   {% endfor %};;
    link: {
      label: "City Google Search"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
      }
  }


  set: detail {
    fields: [orders_created_date, users_user_cities]
  }
}

view: city_list {
  derived_table: {
    sql: SELECT
        users.first_name  AS `users.first_name`,
        GROUP_CONCAT(DISTINCT users.city  ORDER BY users.city   SEPARATOR ', ' ) AS `users.user_cities`
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

  dimension: users_first_name {
    type: string
    sql: ${TABLE}.`users.first_name` ;;
  }

  dimension: city_list {
    type: string
    sql: ${TABLE}.`users.user_cities` ;;
 html:
  {% assign words = {{value}} | split: ', ' %}
  <ul>
  {% for word in words %}
  <li>{{ word }}</li>
  {% endfor %} ;;
    link: {
      label: "City Google Search {{ value }}"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
  }

  set: detail {
    fields: [users_first_name, city_list]
  }
}

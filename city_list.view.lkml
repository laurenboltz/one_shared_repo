view: user_information {
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


dimension: city_list_raw {
  type: string
  sql: ${TABLE}.`users.user_cities` ;;
}



  dimension: city_list_bullet_list {
    type: string
    sql: ${TABLE}.`users.user_cities` ;;
    html:
      {% assign words = {{value}} | split: ', ' %}
      <ul>
      {% for word in words %}
      <li>{{ word }}</li>
      {% endfor %} ;;
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[0] %}City Google Search {{ words[0] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[0] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[1] %}City Google Search {{ words[1] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[1] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[2] %}City Google Search {{ words[2] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[2] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[3] %}City Google Search {{ words[3] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[3] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[4] %}City Google Search {{ words[4] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[4] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[5] %}City Google Search {{ words[5] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[5] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[6] %}City Google Search {{ words[6] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[6] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[7] %}City Google Search {{ words[7] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[7] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[8] %}City Google Search {{ words[8] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[8] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[9] %}City Google Search {{ words[9] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[9] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[10] %}City Google Search {{ words[10] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[10] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[11] %}City Google Search {{ words[11] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[11] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[12] %}City Google Search {{ words[12] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[12] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[13] %}City Google Search {{ words[13] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[13] }}"
    }
    link: {
      label: "{% assign words = {{value}} | split: ', ' %}{%if words[14] %}City Google Search {{ words[14] }}{%endif%}"
      url: "{% assign words = {{value}} | split: ', ' %}http://www.google.com/search?q={{ words[14] }}"
    }

    }


  set: detail {
    fields: [users_first_name, city_list_bullet_list]
  }
}

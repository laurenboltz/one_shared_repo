view: users {
  sql_table_name: demo_db2.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [0, 10, 20, 30, 40, 50, 60, 70, 80]
    style: integer  # the default value, could be excluded
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }


  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: value {
    type: string
    sql: {{ value }} ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    type: string
    sql: CONCAT(${first_name},' ',${last_name});;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    link: {
      label: "Drill Dashboard"
      url: "/dashboards/1114?State={{ value }}&Age={{ _filters['users.age'] | url_encode }}"
    }
    link: {
      label: "Drill Dashboard"
      url: "/dashboards/2484?State={{ value }}&Age={{ _filters['users.age'] | url_encode }}"
    }
}

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
    link: {
      label: "Google"
      url: "www.google.com"
    }
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: average_age {
    type: average
    sql: ${age} ;;
    value_format_name: decimal_2
  }

measure: user_cities {
  type: list
  list_field: city
}

  measure: measure_for_age {
    description: "Use this age field for displaying age on the y-axis"
    type: sum
    sql: ${age} ;;
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}

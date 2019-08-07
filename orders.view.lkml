view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  parameter: test {
    type: date
    default_value: "Null"
    allowed_value: {
      label: "Null"
      value: "Null"
    }
  }

  dimension: parameter {
    sql:  {% parameter test %} ;;
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
      year,
      day_of_week_index
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: period_test {
    type: number
    sql: FLOOR( DATEDIFF(CURRENT_DATE(), ${created_raw}) / 30 );;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  parameter: pizza {
    type: string
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


#   dimension: lala% {
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }

  measure: is_big_count {
    type: yesno
    sql:sql: ${count} > 10   ;;
  }

  measure: is_active {
    type: string
    sql:  CASE WHEN ${is_big_count} THEN "Active"
    ELSE "Inactive"
    END;;
  }

  measure: number {
   type:  number
  sql: ${count}*199 ;;
  }


  measure: count {
    type: count
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
  }

  measure: number_concat {
    type: string
    sql: concat(convert(${count},char),',',convert(${number},char));;
  }


}

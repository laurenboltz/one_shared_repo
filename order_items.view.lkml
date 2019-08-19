view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: period_test {
    type: number
    sql: FLOOR( DATEDIFF(CURRENT_DATE(), ${returned_raw}) / 30 );;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }


  parameter: measure_type {
    suggestions: ["sum","average","count","min","max"]
  }

  parameter: dimension_to_aggregate {
    type: unquoted
    allowed_value: {
      label: "Total Sale Price"
      value: "sale_price"
    }
    allowed_value: {
      label: "Total Gross Margin"
      value: "gross_margin"
    }
  }

  measure: dynamic_agg {
    type: number
    label_from_parameter: dimension_to_aggregate
    sql: case when {% condition measure_type %} 'sum' {% endcondition %} then sum( ${TABLE}.{% parameter dimension_to_aggregate %})
          when {% condition measure_type %} 'average' {% endcondition %} then avg( ${TABLE}.{% parameter dimension_to_aggregate %})
          when {% condition measure_type %} 'count' {% endcondition %} then count( ${TABLE}.{% parameter dimension_to_aggregate %})
          when {% condition measure_type %} 'min' {% endcondition %} then min( ${TABLE}.{% parameter dimension_to_aggregate %})
          when {% condition measure_type %} 'max' {% endcondition %} then max( ${TABLE}.{% parameter dimension_to_aggregate %})
          else null end;;
  }

  measure: total_revenue {
    hidden: yes
    type: sum
    sql: ${TABLE}.sale_price ;;
  }

  measure: total_users {
    hidden: yes
    type: count_distinct
    sql: ${users.id};;
  }

  parameter: main_metric_selector {
    type: unquoted
    allowed_value: {
      label: "Total Revenue"
      value: "total_revenue"
    }
    allowed_value: {
      label: "Total Users"
      value: "total_users"
    }
  }

  measure: dynamic_measure {
    label_from_parameter: main_metric_selector
    sql:
    {% if main_metric_selector._parameter_value == 'total_revenue' %}
      ${total_revenue}
    {% else %}
      ${total_users}
    {% endif %};;
  }

  dimension: gross_margin {
    type: number
    value_format_name: usd
    sql: ${sale_price} - ${inventory_items.cost} ;;
  }

  dimension: gross_margin_tier {
    type: tier
    sql: ${gross_margin} ;;
    tiers: [0, 50, 100, 200, 400]
  }

  measure: percent_of_total_gm {
    type: percent_of_total
    sql: ${total_gross_margin} ;;
  }

  measure: total_gross_margin {
    type: sum
    value_format_name: decimal_2
    sql: ${gross_margin} ;;
    html: {{ rendered_value }} || {{ percent_of_total_gm._rendered_value }} of total>> ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}

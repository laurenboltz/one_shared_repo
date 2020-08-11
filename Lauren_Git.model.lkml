connection: "thelook"

# include all the views
include: "*.view"
#test comment


explore: events {
  view_name: events
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: events_extended {
extends: [events]
from: events_extended
join: orders {
  relationship: many_to_one
  sql_on: ${events.test_id} = ${orders.id} ;;
}
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: sme_lookml_liquid_exercise_2 {
  join: orders {
    type: left_outer
    sql_on: ${orders.created_date} = ${sme_lookml_liquid_exercise_2.orders_created_date} ;;
   relationship: one_to_one
  }
}

explore: sql_runner_query {}

explore: order_items {

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: sql_runner_query {
    type: left_outer
    sql_on: ${sql_runner_query.users_state} = ${users.state} ;;
    relationship: one_to_one
  }
}

explore: orders {
  view_name: orders

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
}


}

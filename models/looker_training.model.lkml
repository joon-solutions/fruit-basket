connection: "analytics_prod"
include: "/views/*.view.lkml"
datagroup: default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}
######## Training comments for Looker setup

######## Adding comments to demo webhooks

persist_with: default_datagroup

explore: fruit_basket {
  group_label: "Fruit Analysis"
}

explore: fruit_price {
  group_label: "Fruit Analysis"
}

explore: our_fruit_basket {
  from:  fruit_basket
  group_label: "Fruit Analysis"
  label: "Fruit Comparison"
  description: "This explore is for training joins concepts"

  join: fruit_price {
    view_label: "Market Fruit Price"
    relationship: one_to_one
    type:  left_outer
    sql_on: ${our_fruit_basket.color} = ${fruit_price.color}
            and  ${our_fruit_basket.fruit_type} = ${fruit_price.fruit_type}
            and ${our_fruit_basket.added_to_cart_date} = ${fruit_price.date_date};;
  }
}

connection: "sample_retail_data"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

explore: order_items {
  label: "eComm Orders"
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
  join: calendar_445_daily {
    type: left_outer
    sql_on: ${order_items.created_date} = ${calendar_445_daily.date_key_date} ;;
    relationship: many_to_one
  }
  join: first_day_of_qtr_dt {
    type: cross
    sql_on: ${calendar_445_daily.date_key_date} = ${first_day_of_qtr_dt.first_date_of_qtr} ;;
    relationship: one_to_one
  }
  join: first_day_of_mo_dt {
    type: cross
    sql_on: ${calendar_445_daily.date_key_date} = ${first_day_of_mo_dt.first_date_of_mo} ;;
    relationship: one_to_one
  }
  join: first_day_of_yr_dt {
    type: cross
    sql_on: ${calendar_445_daily.date_key_date} = ${first_day_of_yr_dt.first_date_of_yr} ;;
    relationship: one_to_one
  }
  join: curr_date_ly_dt {
    type: cross
    sql_on: ${calendar_445_daily.date_key_date} = ${curr_date_ly_dt.curr_date_ly} ;;
    relationship: one_to_one
  }
}

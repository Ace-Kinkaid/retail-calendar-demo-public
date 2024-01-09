view: order_items {
  sql_table_name: `looker-core-4cjg.retail.order_items` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: delivered {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }
  dimension_group: shipped {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.shipped_at ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, inventory_items.product_name]
  }

  measure: total_sales {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
  }

  measure: sales_l4w {
    label: "Sales L4W"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
    filters: [calendar_445_daily.l4w: "Yes"]
  }

  measure: sales_lw {
    label: "Sales LW"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
    filters: [calendar_445_daily.lw: "Yes"]
  }

  measure: sales_qtd {
    label: "Sales QTD"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
    filters: [calendar_445_daily.qtd: "Yes"]
  }

  measure: sales_xtd {
    label: "Sales XTD (dynamic)"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
    filters: [calendar_445_daily.fy_xtd: "Yes"]
  }

  measure: sales_qtd_test {
    label: "Sales QTD"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
    filters: [calendar_445_daily.qtd_test: "Yes"]
  }


}

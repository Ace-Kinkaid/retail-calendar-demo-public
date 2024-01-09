view: curr_date_ly_dt {
  fields_hidden_by_default: yes
  derived_table: {
    sql: select ly_fscl_day_date as curr_date_ly
        from `looker-core-4cjg.retail.wakefern_445_daily`
        where date_key = date('2023-12-18')
        ;;
  }

  # above, we would replace the hardcoded date with
  # current_date() or some expression to dynamically calculate
  # the date of the most recently available data if we had current data

  dimension: curr_date_ly {
    label: "Current Date LY"
    type: date
    sql: ${TABLE}.curr_date_ly ;;
    primary_key: yes
  }
 }

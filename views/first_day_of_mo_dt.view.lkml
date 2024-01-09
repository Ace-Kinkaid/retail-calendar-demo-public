view: first_day_of_mo_dt {
  fields_hidden_by_default: yes
  derived_table: {
    sql: select
          date_key as first_date_of_mo
        , fscl_yr_mo_num as fscl_yr_mo_num
        , fscl_day_of_mo_num as fscl_day_of_mo_num
        , ly_fscl_day_date as first_date_of_mo_ly
        from `looker-core-4cjg.retail.wakefern_445_daily`
        where fscl_day_of_mo_num = 1
        and fscl_yr_mo_num =
        (
          select fscl_yr_mo_num
          from `looker-core-4cjg.retail.wakefern_445_daily`
          where date_key = date('2023-12-18')
        )
        ;;
  }

  # above, we would replace the hardcoded date with
  # current_date() or some expression to dynamically calculate
  # the date of the most recently available data if we had current data

  dimension: first_date_of_mo {
    label: "First Date of Month"
    type: date
    sql: ${TABLE}.first_date_of_mo ;;
    primary_key: yes
  }

  dimension: fscl_yr_mo_num {
    type: number
    sql: ${TABLE}.fscl_yr_mo_num ;;
  }

  dimension: fscl_day_of_mo_num {
    type: number
    sql: ${TABLE}.fscl_day_of_mo_num ;;
  }

  dimension: first_date_of_mo_ly {
    label: "First Date of Month LY"
    type: date
    sql: ${TABLE}.first_date_of_mo_ly ;;
  }
}


view: first_day_of_qtr_dt {
    fields_hidden_by_default: yes
    derived_table: {
        sql: select
          date_key as first_date_of_qtr
        , fscl_yr_qtr_num as fscl_yr_qtr_num
        , fscl_day_ofqtr_num as fscl_day_ofqtr_num
        from `looker-core-4cjg.retail.wakefern_445_daily`
        where fscl_day_ofqtr_num = 1
        and fscl_yr_qtr_num =
          (
           select fscl_yr_qtr_num
           from `looker-core-4cjg.retail.wakefern_445_daily`
           where date_key = date('2023-12-18')
        ) ;;
    }

    # above, we would replace the hardcoded date with
    # current_date() or some expression to dynamically calculate
    # the date of the most recently available data if we had current data

    dimension: first_date_of_qtr {
      label: "First Date of Quarter"
      type: date
      #datatype: date
      sql: ${TABLE}.first_date_of_qtr ;;
      primary_key: yes
    }

    dimension: fscl_day_ofqtr_num {
      type: number
      sql: ${TABLE}.fscl_day_ofqtr_num ;;
    }

    dimension: fscl_yr_qtr_num {
      type: number
      sql: ${TABLE}.fscl_yr_qtr_num ;;
    }
}

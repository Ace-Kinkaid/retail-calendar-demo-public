view: calendar_445_daily {
  sql_table_name: `looker-core-4cjg.retail.wakefern_445_daily` ;;

  dimension_group: current {
    type: time
    convert_tz: no
    datatype: date
    timeframes: [raw, date, week, month, quarter, year, day_of_week_index]
    #sql: date(current_date('America/New_York')) ;;
    sql: date('2023-12-18') ;;
    #this would be a current_date() or the date of the most recently available
    #data if we had current data
  }

  dimension: wtd {
    label: "FY WTD"
    type: yesno
    sql:  ${current_date} BETWEEN ${wk_strt_date} AND ${wk_end_date} ;;
  }

  filter: ydy {
    group_label: "FY XTD Filters"
    label: "YDY"
    type: yesno
    sql:  ${date_key_date} = ${current_date} - 1 ;;
  }

  filter: lw {
    group_label: "FY XTD Filters"
    label: "LW"
    type: yesno
    sql:  DATE_DIFF(${current_date}, ${wk_strt_date}, DAY) BETWEEN 7 AND 13 ;;
  }

  filter: l4w {
    group_label: "FY XTD Filters"
    label: "L4W"
    type: yesno
    sql:  DATE_DIFF(${current_date}, ${wk_strt_date}, DAY) BETWEEN 7 AND 34 ;;
  }

  filter: qtd {
    group_label: "FY XTD Filters"
    label: "QTD"
    type: yesno
    sql:  ${date_key_date} between ${first_day_of_qtr_dt.first_date_of_qtr} and ${current_date} ;;
  }

### This is the more efficient way of writing the QTD filter ###
  filter: qtd_test {
    group_label: "FY XTD Filters"
    label: "QTD_test"
    type: yesno
    sql:  ${fscl_yr_qtr_num} = ${first_day_of_qtr_dt.fscl_yr_qtr_num} ;;
  }
##########################

  filter: mtd {
    group_label: "FY XTD Filters"
    label: "MTD"
    type: yesno
    sql:  ${date_key_date} between ${first_day_of_mo_dt.first_date_of_mo} and ${current_date} ;;
  }

  filter: ytd {
    group_label: "FY XTD Filters"
    label: "YTD"
    type: yesno
    sql:  ${date_key_date} between ${first_day_of_yr_dt.first_date_of_yr} and ${current_date} ;;
  }

  filter: mtd_ly {
    group_label: "FY XTD Filters"
    label: "MTD LY"
    type: yesno
    sql:  ${date_key_date} between ${first_day_of_mo_dt.first_date_of_mo_ly} and ${curr_date_ly_dt.curr_date_ly} ;;
  }

  parameter: fy_xtd_param {
    view_label: "FY XTD (dynamic)"
    type: string
    allowed_value: {
      value: "MTD"
    }
    allowed_value: {
      value: "QTD"
    }
    allowed_value: {
      value: "YTD"
    }
  }

  dimension: fy_xtd_dim {
    hidden: yes
    type: string
    sql:  case
            when {% parameter fy_xtd_param %} = 'MTD' then ${date_key_date} between ${first_day_of_mo_dt.first_date_of_mo} and ${current_date}
            when {% parameter fy_xtd_param %} = 'QTD' then ${date_key_date} between ${first_day_of_qtr_dt.first_date_of_qtr} and ${current_date}
            when {% parameter fy_xtd_param %} = 'YTD' then ${date_key_date} between ${first_day_of_yr_dt.first_date_of_yr} and ${current_date}
          end ;;
  }

  filter: fy_xtd {
    label: "FY XTD (dynamic)"
    hidden: yes
    type: yesno
    sql:  ${fy_xtd_dim} ;;
  }


  dimension: date_key_pk {
    type: date
    primary_key: yes
    sql: ${TABLE}.DATE_KEY ;;
    hidden: yes
  }

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year, day_of_week_index]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DATE_KEY ;;
  }
  # dimension: day_of_wk_num {
  #   type: number
  #   sql: ${TABLE}.DAY_OF_WK_NUM ;;
  # }
  dimension: fscl_day_of_mo_num {
    type: number
    sql: ${TABLE}.FSCL_DAY_OF_MO_NUM ;;
  }
  dimension: fscl_day_of_yr_num {
    type: number
    sql: ${TABLE}.FSCL_DAY_OF_YR_NUM ;;
  }
  dimension: fscl_day_ofqtr_num {
    type: number
    sql: ${TABLE}.FSCL_DAY_OFQTR_NUM ;;
  }
  dimension: fscl_mo_num {
    type: number
    sql: ${TABLE}.FSCL_MO_NUM ;;
  }
  dimension: fscl_qtr_num {
    type: number
    sql: ${TABLE}.FSCL_QTR_NUM ;;
  }
  # dimension: fscl_wk_num {
  #   type: number
  #   sql: ${TABLE}.FSCL_WK_NUM ;;
  # }
  dimension: fscl_yr_mo_num {
    type: number
    sql: ${TABLE}.FSCL_YR_MO_NUM ;;
  }
  dimension: fscl_yr_num {
    type: number
    sql: ${TABLE}.FSCL_YR_NUM ;;
  }
  dimension: fscl_yr_qtr_num {
    type: number
    sql: ${TABLE}.FSCL_YR_QTR_NUM ;;
  }
  # dimension: fscl_yr_qtr_txt {
  #   type: string
  #   sql: ${TABLE}.FSCL_YR_QTR_TXT ;;
  # }
  dimension_group: ly_fscl_day {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.LY_FSCL_DAY_DATE ;;
  }
  # dimension: ly_fscl_mo_num {
  #   type: number
  #   sql: ${TABLE}.LY_FSCL_MO_NUM ;;
  # }
  # dimension: ly_fscl_wk_num {
  #   type: number
  #   sql: ${TABLE}.LY_FSCL_WK_NUM ;;
  # }
  # dimension: ly_fscl_yr_mo_num {
  #   type: number
  #   sql: ${TABLE}.LY_FSCL_YR_MO_NUM ;;
  # }
  # dimension: ly_fscl_yr_num {
  #   type: number
  #   sql: ${TABLE}.LY_FSCL_YR_NUM ;;
  # }
  # dimension: ly_fscl_yr_qtr_num {
  #   type: number
  #   sql: ${TABLE}.LY_FSCL_YR_QTR_NUM ;;
  # }
  # dimension_group: ly_wk_end {
  #   type: time
  #   timeframes: [raw, date, week, month, quarter, year]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}.LY_WK_END_DATE ;;
  # }
  # dimension: ly_yr_qtr_txt {
  #   type: string
  #   sql: ${TABLE}.LY_YR_QTR_TXT ;;
  # }
  # dimension: org_num {
  #   type: number
  #   sql: ${TABLE}.ORG_NUM ;;
  # }
  # dimension_group: prev_day {
  #   type: time
  #   timeframes: [raw, date]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}.PREV_DAY_DATE ;;
  # }
  # dimension: prev_fscl_mo_num {
  #   type: number
  #   sql: ${TABLE}.PREV_FSCL_MO_NUM ;;
  # }
  # dimension: prev_fscl_yrmo_num {
  #   type: number
  #   sql: ${TABLE}.PREV_FSCL_YRMO_NUM ;;
  # }
  # dimension: prev_fsclyrqtr_num {
  #   type: number
  #   sql: ${TABLE}.PREV_FSCLYRQTR_NUM ;;
  # }
  # dimension_group: prev_wk_end {
  #   type: time
  #   timeframes: [raw, date]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}.PREV_WK_END_DATE ;;
  # }
  # dimension_group: wk_end_11_txt {
  #   type: time
  #   timeframes: [raw, date]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}.WK_END_11TXT ;;
  # }
  dimension_group: wk_end {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.WK_END_DATE ;;
  }
  # dimension_group: wk_end_date_txt {
  #   type: time
  #   timeframes: [raw, date]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}.WK_END_DATE_TXT ;;
  # }
  dimension_group: wk_strt {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.WK_STRT_DATE ;;
  }
  # measure: count {
  #   type: count
  # }
}

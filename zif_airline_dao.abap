INTERFACE zif_airline_dao
  PUBLIC .
  TYPES tt_airlines TYPE STANDARD TABLE OF zcp_sairline.
  TYPES : BEGIN OF ty_where_clause,
            line TYPE char72,
          END OF ty_where_clause.
  TYPES: tt_where_clause TYPE STANDARD TABLE OF ty_where_clause.
  METHODS get_airline_by_carrid
    IMPORTING iv_carrid  TYPE zcp_sairline-carrid
    EXPORTING es_airline TYPE zcp_sairline.
  METHODS get_all_airlines
    EXPORTING et_airlines TYPE tt_airlines.
  METHODS get_filtered_airlines IMPORTING where_clause TYPE tt_where_clause EXPORTING et_airlines TYPE tt_airlines .
  METHODS save_airline IMPORTING is_airline TYPE zcp_sairline.
  METHODS update_airline IMPORTING is_airline TYPE zcp_sairline.
  METHODS delete_airline IMPORTING is_airline TYPE zcp_sairline.
ENDINTERFACE.
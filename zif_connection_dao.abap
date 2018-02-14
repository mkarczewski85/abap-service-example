INTERFACE zif_connection_dao
  PUBLIC .
  TYPES tt_connections TYPE STANDARD TABLE OF zcp_sconnection.
  TYPES : BEGIN OF ty_where_clause,
          line TYPE char72,
        END OF ty_where_clause.
  TYPES: tt_where_clause TYPE STANDARD TABLE OF ty_where_clause.
  METHODS: get_connection_by_connid
    IMPORTING iv_connid     TYPE zcp_sconnection-connid
    EXPORTING es_connection TYPE zcp_sconnection.
  METHODS get_connection_by_carrid
    IMPORTING iv_carrid     TYPE zcp_sairline-carrid
    EXPORTING es_connection TYPE zcp_sconnection.
  METHODS get_all_connections
    EXPORTING et_connections TYPE tt_connections .
  METHODS get_filtered_connections IMPORTING where_clause TYPE tt_where_clause EXPORTING et_connections TYPE tt_connections .
  METHODS save_connection IMPORTING is_connection TYPE zcp_sconnection.
  METHODS update_connection IMPORTING is_connection TYPE zcp_sconnection.
  METHODS delete_connection IMPORTING is_connection TYPE zcp_sconnection.
ENDINTERFACE.
CLASS zcl_flight_odata DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES tt_airlines TYPE STANDARD TABLE OF zcp_sairline.
    TYPES tt_connections TYPE STANDARD TABLE OF zcp_sconnection.
    TYPES tt_conditions TYPE STANDARD TABLE OF hrcond.
    METHODS constructor.
    METHODS: get_airline_entity IMPORTING iv_carrid TYPE zcp_sairline-carrid EXPORTING es_entity TYPE zcp_sairline,
      get_airline_entityset EXPORTING et_entityset TYPE tt_airlines,
      get_airlines_set_filtered IMPORTING conditions TYPE tt_conditions EXPORTING et_entityset TYPE tt_airlines.
    METHODS: get_connection_entity IMPORTING iv_connid TYPE zcp_sconnection-connid EXPORTING es_entity TYPE zcp_sconnection,
      get_connection_entityset EXPORTING et_entityset TYPE tt_connections,
      get_connections_set_filtered IMPORTING conditions TYPE tt_conditions EXPORTING et_entityset TYPE tt_connections.
    CLASS-METHODS: get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_flight_odata.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mo_airline_dao TYPE REF TO zif_airline_dao.
    DATA mo_connection_dao TYPE REF TO zif_connection_dao.
    CLASS-DATA go_instance TYPE REF TO zcl_flight_odata.
ENDCLASS.


CLASS zcl_flight_odata IMPLEMENTATION.

  METHOD get_airline_entity.

    mo_airline_dao->get_airline_by_carrid( EXPORTING iv_carrid = iv_carrid IMPORTING es_airline = es_entity ).

  ENDMETHOD.

  METHOD get_airline_entityset.

    mo_airline_dao->get_all_airlines( IMPORTING et_airlines = et_entityset ).

  ENDMETHOD.

  METHOD get_airlines_set_filtered.

     TYPES : BEGIN OF ty_where_clause,
              line TYPE char72,
            END OF ty_where_clause.
    DATA: t_where_clause TYPE STANDARD TABLE OF ty_where_clause.
    DATA(lt_conditions) = conditions.

    CALL FUNCTION 'RH_DYNAMIC_WHERE_BUILD'
      EXPORTING
        dbtable         = 'SCARR'
      TABLES
        condtab         = lt_conditions
        where_clause    = t_where_clause
      EXCEPTIONS
        empty_condtab   = 1
        no_db_field     = 2
        unknown_db      = 3
        wrong_condition = 4
        OTHERS          = 5.

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
      mo_airline_dao->get_filtered_airlines( EXPORTING where_clause = t_where_clause IMPORTING et_airlines = et_entityset ).
    ENDIF.

  ENDMETHOD.

  METHOD get_connection_entity.

    mo_connection_dao->get_connection_by_connid( EXPORTING iv_connid = iv_connid IMPORTING es_connection = es_entity ).

  ENDMETHOD.

  METHOD get_connection_entityset.

    mo_connection_dao->get_all_connections( IMPORTING et_connections = et_entityset ).

  ENDMETHOD.

  METHOD get_connections_set_filtered.
    TYPES : BEGIN OF ty_where_clause,
              line TYPE char72,
            END OF ty_where_clause.
    DATA: t_where_clause TYPE STANDARD TABLE OF ty_where_clause.
    DATA(lt_conditions) = conditions.

    CALL FUNCTION 'RH_DYNAMIC_WHERE_BUILD'
      EXPORTING
        dbtable         = 'SPFLI'
      TABLES
        condtab         = lt_conditions
        where_clause    = t_where_clause
      EXCEPTIONS
        empty_condtab   = 1
        no_db_field     = 2
        unknown_db      = 3
        wrong_condition = 4
        OTHERS          = 5.

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
      mo_connection_dao->get_filtered_connections( EXPORTING where_clause = t_where_clause IMPORTING et_connections = et_entityset ).
    ENDIF.

  ENDMETHOD.

  METHOD constructor.

    mo_airline_dao ?= zcl_airline_dao=>get_instance( ).
    mo_connection_dao ?= zcl_connection_dao=>get_instance( ).

  ENDMETHOD.

  METHOD get_instance.

    IF go_instance IS INITIAL.
      go_instance = NEW zcl_flight_odata( ).
      ro_instance = go_instance.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
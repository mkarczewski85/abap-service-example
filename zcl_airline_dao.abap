CLASS zcl_airline_dao DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_airline_dao.
    METHODS constructor.
    CLASS-METHODS: get_instance RETURNING VALUE(ro_instance) TYPE REF TO zif_airline_dao,
      set_instance IMPORTING io_instance TYPE REF TO zif_airline_dao.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: go_instance TYPE REF TO zif_airline_dao.
ENDCLASS.



CLASS zcl_airline_dao IMPLEMENTATION.


  METHOD constructor.
  ENDMETHOD.


  METHOD get_instance.
    IF go_instance IS INITIAL.
      go_instance = NEW zcl_airline_dao( ).
    ENDIF.
    ro_instance = go_instance.
  ENDMETHOD.


  METHOD set_instance.
    go_instance = io_instance.
  ENDMETHOD.


  METHOD zif_airline_dao~delete_airline.
  ENDMETHOD.


  METHOD zif_airline_dao~get_airline_by_carrid.

    SELECT SINGLE * FROM scarr INTO @DATA(ls_airline) WHERE carrid EQ @iv_carrid.
    IF sy-subrc EQ 0.
      MOVE-CORRESPONDING ls_airline TO es_airline.
    ENDIF.

  ENDMETHOD.

  METHOD zif_airline_dao~get_all_airlines.
    DATA ls_airline TYPE zcp_sairline.

    SELECT * FROM scarr INTO @DATA(ls_entry).
      MOVE-CORRESPONDING ls_entry TO ls_airline.
      APPEND ls_airline TO et_airlines.
    ENDSELECT.

  ENDMETHOD.

  METHOD zif_airline_dao~get_filtered_airlines.
    DATA: ls_airline TYPE zcp_sairline.

    SELECT * FROM scarr INTO CORRESPONDING FIELDS OF @ls_airline WHERE (where_clause).
      APPEND ls_airline TO et_airlines.
    ENDSELECT.

  ENDMETHOD.

  METHOD zif_airline_dao~save_airline.
  ENDMETHOD.


  METHOD zif_airline_dao~update_airline.
  ENDMETHOD.
ENDCLASS.
CLASS zcl_connection_dao DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_connection_dao.
    METHODS constructor.
    CLASS-METHODS: get_instance RETURNING VALUE(ro_instance) TYPE REF TO zif_connection_dao,
      set_instance IMPORTING io_instance TYPE REF TO zif_connection_dao.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: go_instance TYPE REF TO zif_connection_dao.
ENDCLASS.



CLASS zcl_connection_dao IMPLEMENTATION.

  METHOD constructor.
  ENDMETHOD.

  METHOD get_instance.
    IF go_instance IS INITIAL.
      go_instance = NEW zcl_connection_dao( ).
    ENDIF.
    ro_instance = go_instance.
  ENDMETHOD.

  METHOD set_instance.
    go_instance = io_instance.
  ENDMETHOD.

  METHOD zif_connection_dao~get_connection_by_connid.

    SELECT SINGLE * FROM spfli INTO @DATA(ls_connection) WHERE connid EQ @iv_connid.
    IF sy-subrc EQ 0.
      MOVE-CORRESPONDING ls_connection TO es_connection.
    ENDIF.

  ENDMETHOD.

  METHOD zif_connection_dao~get_all_connections.
    DATA: ls_connection TYPE zcp_sconnection.

    SELECT * FROM spfli INTO @DATA(ls_entry).
      MOVE-CORRESPONDING ls_entry TO ls_connection.
      APPEND ls_connection TO et_connections.
    ENDSELECT.

  ENDMETHOD.

  METHOD zif_connection_dao~get_connection_by_carrid.

    SELECT SINGLE * FROM spfli INTO @DATA(ls_connection) WHERE connid EQ @iv_carrid.
    IF sy-subrc EQ 0.
      MOVE-CORRESPONDING ls_connection TO es_connection.
    ENDIF.

  ENDMETHOD.

  METHOD zif_connection_dao~get_filtered_connections.
    DATA: ls_connection TYPE zcp_sconnection.

    SELECT * FROM spfli INTO CORRESPONDING FIELDS OF @ls_connection WHERE (where_clause).
      APPEND ls_connection TO et_connections.
    ENDSELECT.

  ENDMETHOD.

  METHOD zif_connection_dao~save_connection.
  ENDMETHOD.

  METHOD zif_connection_dao~update_connection.
  ENDMETHOD.

  METHOD zif_connection_dao~delete_connection.
  ENDMETHOD.


ENDCLASS.
CLASS zcl_connection_dao_mock DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_connection_dao.
    METHODS constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: lt_test_connections TYPE zif_connection_dao~tt_connections.
ENDCLASS.



CLASS zcl_connection_dao_mock IMPLEMENTATION.

  METHOD constructor.

    DATA ls_mock_connection TYPE zcp_sconnection.

    ls_mock_connection-connid = '17'.
    ls_mock_connection-carrid = 'AA'.
    ls_mock_connection-airpfrom = 'JFK'.
    ls_mock_connection-airpto = 'SFO'.
    ls_mock_connection-arrtime = '6:01'.
    ls_mock_connection-cityfrom = 'NEW YORK'.
    ls_mock_connection-cityto = 'SAN FRANCISCO'.
    ls_mock_connection-countryfr = 'US'.
    ls_mock_connection-countryto = 'US'.
    ls_mock_connection-deptime = '11:00:00'.
    ls_mock_connection-distance = ''.
    ls_mock_connection-distid = ''.
    ls_mock_connection-fltime = ''.
    ls_mock_connection-fltype = ''.
    ls_mock_connection-period = ''.

    INSERT ls_mock_connection INTO TABLE lt_test_connections.
    CLEAR ls_mock_connection.

    ls_mock_connection-connid = '555'.
    ls_mock_connection-carrid = 'AZ'.
    ls_mock_connection-airpfrom = 'FCO'.
    ls_mock_connection-airpto = 'FRA'.
    ls_mock_connection-arrtime = '21:05:00'.
    ls_mock_connection-cityfrom = 'ROME'.
    ls_mock_connection-cityto = 'FRANKFURT'.
    ls_mock_connection-countryfr = 'IT'.
    ls_mock_connection-countryto = 'DE'.
    ls_mock_connection-deptime = '19:00:00'.
    ls_mock_connection-distance = ''.
    ls_mock_connection-distid = ''.
    ls_mock_connection-fltime = ''.
    ls_mock_connection-fltype = ''.
    ls_mock_connection-period = ''.

    INSERT ls_mock_connection INTO TABLE lt_test_connections.
    CLEAR ls_mock_connection.

    ls_mock_connection-connid = '666'.
    ls_mock_connection-carrid = 'AF'.
    ls_mock_connection-airpfrom = 'JFK'.
    ls_mock_connection-airpto = 'FRA'.
    ls_mock_connection-arrtime = '22:03:00'.
    ls_mock_connection-cityfrom = 'NEW YORK'.
    ls_mock_connection-cityto = 'FRANKFURT'.
    ls_mock_connection-countryfr = 'US'.
    ls_mock_connection-countryto = 'DE'.
    ls_mock_connection-deptime = '21:00:00'.
    ls_mock_connection-distance = ''.
    ls_mock_connection-distid = ''.
    ls_mock_connection-fltime = ''.
    ls_mock_connection-fltype = ''.
    ls_mock_connection-period = ''.

    INSERT ls_mock_connection INTO TABLE lt_test_connections.
    CLEAR ls_mock_connection.

  ENDMETHOD.

  METHOD zif_connection_dao~get_connection_by_connid.

    LOOP AT lt_test_connections ASSIGNING FIELD-SYMBOL(<fs_entry>).
      IF <fs_entry>-connid EQ iv_connid.
        es_connection = <fs_entry>.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD zif_connection_dao~get_all_connections.

    et_connections = lt_test_connections.

  ENDMETHOD.

  METHOD zif_connection_dao~get_filtered_connections.

    LOOP AT lt_test_connections ASSIGNING FIELD-SYMBOL(<fs_entry>) WHERE (where_clause).
      APPEND <fs_entry> TO et_connections.
    ENDLOOP.

  ENDMETHOD.

  METHOD zif_connection_dao~get_connection_by_carrid.

    LOOP AT lt_test_connections ASSIGNING FIELD-SYMBOL(<fs_entry>).
      IF <fs_entry>-carrid EQ iv_carrid.
        es_connection = <fs_entry>.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD zif_connection_dao~save_connection.
  ENDMETHOD.

  METHOD zif_connection_dao~update_connection.
  ENDMETHOD.

  METHOD zif_connection_dao~delete_connection.
  ENDMETHOD.

ENDCLASS.
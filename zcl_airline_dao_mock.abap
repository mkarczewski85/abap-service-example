CLASS zcl_airline_dao_mock DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_airline_dao.
    METHODS constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: lt_test_airlines TYPE zif_airline_dao~tt_airlines.
ENDCLASS.



CLASS zcl_airline_dao_mock IMPLEMENTATION.

  METHOD constructor.

    DATA ls_mock_airline TYPE zcp_sairline.

    ls_mock_airline-carrid = 'AA'.
    ls_mock_airline-carrname = 'American Airlines'.
    ls_mock_airline-currcode = 'USD'.
    ls_mock_airline-url = 'http://www.aa.com'.

    INSERT ls_mock_airline INTO TABLE lt_test_airlines.
    CLEAR ls_mock_airline.

    ls_mock_airline-carrid = 'AB'.
    ls_mock_airline-carrname = 'Air Berlin'.
    ls_mock_airline-currcode = 'EUR'.
    ls_mock_airline-url = 'http://www.airberlin.de'.

    INSERT ls_mock_airline INTO TABLE lt_test_airlines.
    CLEAR ls_mock_airline.

    ls_mock_airline-carrid = 'AC'.
    ls_mock_airline-carrname = 'Air Canada'.
    ls_mock_airline-currcode = 'CAD'.
    ls_mock_airline-url = 'http://www.aircanada.ca'.

    INSERT ls_mock_airline INTO TABLE lt_test_airlines.
    CLEAR ls_mock_airline.

    ls_mock_airline-carrid = 'AF'.
    ls_mock_airline-carrname = 'Air France'.
    ls_mock_airline-currcode = 'EUR'.
    ls_mock_airline-url = 'http://www.airfrance.fr'.

    INSERT ls_mock_airline INTO TABLE lt_test_airlines.
    CLEAR ls_mock_airline.

  ENDMETHOD.

  METHOD zif_airline_dao~get_airline_by_carrid.

    LOOP AT lt_test_airlines ASSIGNING FIELD-SYMBOL(<fs_entry>).
      IF <fs_entry>-carrid EQ iv_carrid.
        es_airline = <fs_entry>.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD zif_airline_dao~get_all_airlines.

    et_airlines = lt_test_airlines.

  ENDMETHOD.

  METHOD zif_airline_dao~get_filtered_airlines.

    LOOP AT lt_test_airlines ASSIGNING FIELD-SYMBOL(<fs_entry>) WHERE (where_clause).
      APPEND <fs_entry> TO et_airlines.
    ENDLOOP.

  ENDMETHOD.

  METHOD zif_airline_dao~save_airline.
  ENDMETHOD.

  METHOD zif_airline_dao~update_airline.
  ENDMETHOD.

  METHOD zif_airline_dao~delete_airline.
  ENDMETHOD.

ENDCLASS.
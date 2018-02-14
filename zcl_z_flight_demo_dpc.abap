CLASS zcl_z_flight_demo_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_z_flight_demo_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS airlineset_get_entity REDEFINITION.
    METHODS airlineset_get_entityset REDEFINITION.
    METHODS connectionset_get_entity REDEFINITION.
    METHODS connectionset_get_entityset REDEFINITION.
  PRIVATE SECTION.
    CONSTANTS carrid TYPE string VALUE 'Carrid' ##NO_TEXT.
    CONSTANTS connid TYPE string VALUE 'Connid' ##NO_TEXT.
    METHODS get_parameter_by_name
      IMPORTING it_parameter              TYPE /iwbep/t_mgw_name_value_pair
                iv_name                   TYPE string
      RETURNING VALUE(rv_parameter_value) TYPE string.
    TYPES ty_condition TYPE STANDARD TABLE OF hrcond.
    METHODS get_conditions IMPORTING it_filters TYPE /iwbep/t_mgw_select_option EXPORTING et_conditions TYPE ty_condition.
ENDCLASS.



CLASS zcl_z_flight_demo_dpc_ext IMPLEMENTATION.

  METHOD airlineset_get_entity.

    DATA(lv_carrid) = get_parameter_by_name( it_parameter = it_key_tab iv_name = carrid ).
    zcl_flight_odata=>get_instance( )->get_airline_entity( EXPORTING iv_carrid = CONV #( lv_carrid ) IMPORTING es_entity = er_entity ).

  ENDMETHOD.

  METHOD airlineset_get_entityset.
    DATA(lt_filters) = io_tech_request_context->get_filter( )->get_filter_select_options( ).

    IF lt_filters IS NOT INITIAL.
      DATA lt_conditions TYPE ty_condition.
      get_conditions( EXPORTING it_filters = lt_filters IMPORTING et_conditions = lt_conditions ).
      zcl_flight_odata=>get_instance( )->get_airlines_set_filtered( EXPORTING conditions = lt_conditions IMPORTING et_entityset = et_entityset ).
    ELSE.
      zcl_flight_odata=>get_instance( )->get_airline_entityset( IMPORTING et_entityset = et_entityset ).
    ENDIF.

  ENDMETHOD.

  METHOD connectionset_get_entity.

    DATA(lv_connid) = get_parameter_by_name( it_parameter = it_key_tab iv_name = connid ).
    zcl_flight_odata=>get_instance( )->get_connection_entity( EXPORTING iv_connid = CONV #( lv_connid ) IMPORTING es_entity = er_entity ).

  ENDMETHOD.

  METHOD connectionset_get_entityset.
    DATA(lt_filters) = io_tech_request_context->get_filter( )->get_filter_select_options( ).

    IF lt_filters IS NOT INITIAL.
      DATA lt_conditions TYPE ty_condition.
      get_conditions( EXPORTING it_filters = lt_filters IMPORTING et_conditions = lt_conditions ).
      zcl_flight_odata=>get_instance( )->get_connections_set_filtered( EXPORTING conditions = lt_conditions IMPORTING et_entityset = et_entityset ).
    ELSE.
      zcl_flight_odata=>get_instance( )->get_connection_entityset( IMPORTING et_entityset = et_entityset ).
    ENDIF.

  ENDMETHOD.

  METHOD get_parameter_by_name.
    FIELD-SYMBOLS <fs_parameter> TYPE /iwbep/s_mgw_name_value_pair.

    READ TABLE it_parameter ASSIGNING <fs_parameter> WITH KEY name = iv_name.
    IF <fs_parameter> IS ASSIGNED.
      rv_parameter_value = <fs_parameter>-value.
    ENDIF.

  ENDMETHOD.

  METHOD get_conditions.
    DATA ls_condition TYPE hrcond.

    LOOP AT it_filters ASSIGNING FIELD-SYMBOL(<fs_filter>).
      ls_condition-field = <fs_filter>-property.
      LOOP AT <fs_filter>-select_options ASSIGNING FIELD-SYMBOL(<fs_options>).
        ls_condition-opera = <fs_options>-option.
        ls_condition-low = <fs_options>-low.
        ls_condition-high = <fs_options>-high.
      ENDLOOP.
      APPEND ls_condition TO et_conditions.
      CLEAR ls_condition.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
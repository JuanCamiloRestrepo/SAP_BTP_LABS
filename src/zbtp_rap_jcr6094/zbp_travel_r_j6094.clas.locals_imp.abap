CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF travel_status,
        open     TYPE c LENGTH 1 VALUE 'O', " Open
        accepted TYPE c LENGTH 1 VALUE 'A', " Acepted
        rejected TYPE c LENGTH 1 VALUE 'X', " Rejected
      END OF travel_status.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS acceptTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~acceptTravel RESULT result.

    METHODS deductDiscount FOR MODIFY
      IMPORTING keys FOR ACTION Travel~deductDiscount RESULT result.

    METHODS reCalcTotalPrice FOR MODIFY
      IMPORTING keys FOR ACTION Travel~reCalcTotalPrice.

    METHODS rejectTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~rejectTravel RESULT result.

    METHODS resume FOR MODIFY
      IMPORTING keys FOR ACTION Travel~resume.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~calculateTotalPrice.

    METHODS setStatusToOpen FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~setStatusToOpen.

    METHODS setTravelNumber FOR DETERMINE ON SAVE
      IMPORTING keys FOR Travel~setTravelNumber.

    METHODS validateAgency FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateAgency.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateCustomer.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateDates.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_features.

    " EML
    READ ENTITIES OF ztravel_r_j6094 IN LOCAL MODE
    ENTITY Travel
    FIELDS ( OverallStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    result = VALUE #( FOR travel IN travels ( %tky              = travel-%tky
                                              %field-BookingFee = COND #( WHEN travel-OverallStatus = travel_status-accepted
                                                                          THEN if_abap_behv=>fc-f-read_only
                                                                          ELSE if_abap_behv=>fc-f-unrestricted )
                                              %action-acceptTravel = COND #( WHEN travel-OverallStatus = travel_status-accepted
                                                                             THEN if_abap_behv=>fc-o-disabled
                                                                             ELSE if_abap_behv=>fc-o-enabled )
                                              %action-rejectTravel = COND #( WHEN travel-OverallStatus = travel_status-rejected
                                                                             THEN if_abap_behv=>fc-o-disabled
                                                                             ELSE if_abap_behv=>fc-o-enabled )
                                              %action-deductDiscount = COND #( WHEN travel-OverallStatus = travel_status-accepted
                                                                               THEN if_abap_behv=>fc-o-disabled
                                                                               ELSE if_abap_behv=>fc-o-enabled )
                                              %assoc-_Booking = COND #( WHEN travel-OverallStatus = travel_status-rejected
                                                                        THEN if_abap_behv=>fc-o-disabled
                                                                        ELSE if_abap_behv=>fc-o-enabled ) ) ).



  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD acceptTravel.

    " EML
    MODIFY ENTITIES OF ztravel_r_j6094 IN LOCAL MODE
    ENTITY Travel
    UPDATE
    FIELDS ( OverallStatus )
    WITH VALUE #( FOR key IN keys ( %tky          = key-%tky
                                    OverallStatus = travel_status-accepted ) ).

    READ ENTITIES OF ztravel_r_j6094 IN LOCAL MODE
    ENTITY Travel
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    result = VALUE #( FOR travel IN travels ( %tky   = travel-%tky
                                              %param = travel ) ).

  ENDMETHOD.

  METHOD deductDiscount.
  ENDMETHOD.

  METHOD reCalcTotalPrice.
  ENDMETHOD.

  METHOD rejectTravel.

    " EML
    MODIFY ENTITIES OF ztravel_r_j6094 IN LOCAL MODE
    ENTITY Travel
    UPDATE
    FIELDS ( OverallStatus )
    WITH VALUE #( FOR key IN keys ( %tky          = key-%tky
                                    OverallStatus = travel_status-rejected ) ).

    READ ENTITIES OF ztravel_r_j6094 IN LOCAL MODE
    ENTITY Travel
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    result = VALUE #( FOR travel IN travels ( %tky   = travel-%tky
                                              %param = travel ) ).

  ENDMETHOD.

  METHOD resume.
  ENDMETHOD.

  METHOD calculateTotalPrice.
  ENDMETHOD.

  METHOD setStatusToOpen.

    " EML
    READ ENTITIES OF ztravel_r_j6094 IN LOCAL MODE
    ENTITY Travel
    FIELDS ( OverallStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    DELETE travels WHERE OverallStatus IS NOT INITIAL.

    CHECK travels IS NOT INITIAL.

    "EML
    MODIFY ENTITIES OF ztravel_r_j6094 IN LOCAL MODE
    ENTITY Travel
    UPDATE
    FIELDS ( OverallStatus )
    WITH VALUE #( FOR travel IN travels ( %tky = travel-%tky
                                          OverallStatus = travel_status-open ) ).

  ENDMETHOD.

  METHOD setTravelNumber.
  ENDMETHOD.

  METHOD validateAgency.
  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

  METHOD validateDates.
  ENDMETHOD.

ENDCLASS.

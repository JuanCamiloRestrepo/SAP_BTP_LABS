CLASS zcl_insert_data_table_j6094 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_data_table_j6094 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'Adding Travel data' ).

    DELETE FROM ztb_travel_j6094.


    INSERT ztb_travel_j6094 FROM (
    SELECT FROM /dmo/travel
     FIELDS
        " client
        travel_id,
        agency_id,
        customer_id,
        begin_date,
        end_date,
        booking_fee,
        total_price,
        currency_code,
        description,
        CASE status WHEN 'B' THEN 'A'
                    WHEN 'P' THEN 'O'
                    WHEN 'N' THEN 'O'
                    ELSE 'X' END AS overall_status,
        createdby AS local_created_by,
        createdat AS local_created_at,
        lastchangedby AS last_changed_by,
        lastchangedat AS last_changed_at

    ).

    out->write( 'Adding Booking data' ).

    DELETE FROM ztb_booking_6094.

    INSERT ztb_booking_6094 FROM (

        SELECT
          FROM /dmo/booking
          JOIN ztb_travel_j6094 ON /dmo/booking~travel_id = ztb_travel_j6094~travel_id
          JOIN /dmo/travel ON /dmo/travel~travel_id = /dmo/booking~travel_id
          FIELDS  "client,
                  /dmo/booking~booking_id,
                  ztb_travel_j6094~travel_id AS travel_id,
                  /dmo/booking~booking_date,
                  /dmo/booking~customer_id,
                  /dmo/booking~carrier_id,
                  /dmo/booking~connection_id,
                  /dmo/booking~flight_date,
                  /dmo/booking~flight_price,
                  /dmo/booking~currency_code,
                  CASE /dmo/travel~status WHEN 'P' THEN 'N'
                                                   ELSE /dmo/travel~status END AS booking_status,
                  ztb_travel_j6094~last_changed_at AS local_last_changed_at ).


    DELETE FROM ztb_bksuppl_6094.

    out->write( 'Adding Booking Supplements data' ).

    INSERT ztb_bksuppl_6094 FROM (
       SELECT FROM /dmo/book_suppl  AS supp
              JOIN ztb_travel_j6094 AS trvl ON trvl~travel_id = supp~travel_id
              JOIN ztb_booking_6094 AS book ON book~booking_id = supp~booking_id
              FIELDS
              supp~booking_supplement_id,
              trvl~travel_id        AS travel_id,
              book~booking_id       AS booking_id,
              supp~supplement_id,
              supp~price,
              supp~currency_code,
              trvl~last_changed_at  AS local_last_changed_at ).

  ENDMETHOD.
ENDCLASS.

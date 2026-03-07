CLASS zcl_virt_elem_sadl_j6094 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_virt_elem_sadl_j6094 IMPLEMENTATION.
  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA lt_origianl_data TYPE STANDARD TABLE OF ztravel_c_j6094 WITH DEFAULT KEY.

    lt_origianl_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_origianl_data ASSIGNING FIELD-SYMBOL(<lfs_original_data>).

      <lfs_original_data>-PriceWithVAT = <lfs_original_data>-TotalPrice * '1.21'.

    ENDLOOP.

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    CASE iv_entity.
      WHEN 'ZTRAVEL_C_J6094'.

        LOOP AT it_requested_calc_elements INTO DATA(ls_calc_elem).

          IF ls_calc_elem = 'PRICEWITHVAT'.

            INSERT CONV #( 'TOTALPRICE' ) INTO TABLE et_requested_orig_elements.

          ENDIF.

        ENDLOOP.

    ENDCASE.

  ENDMETHOD.

ENDCLASS.

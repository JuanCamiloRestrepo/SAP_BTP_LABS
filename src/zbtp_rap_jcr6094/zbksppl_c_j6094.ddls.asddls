@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBKSPPL_C_J6094
  as projection on ZBKSPPL_R_J6094
{
  key BooksupplUUID,
      TravelUUID,
      BookingUUID,
      BookingSupplementId,
      SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      LocalLastChangedAt,

      /* Associations */
      _Booking : redirected to parent ZBOOKING_C_J6094,
      _Supplement,
      _SupplementText,
      _Travel : redirected to ZTRAVEL_C_J6094
}

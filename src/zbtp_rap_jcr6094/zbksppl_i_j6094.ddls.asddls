@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBKSPPL_I_J6094
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

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      /* Associations */
      _Booking : redirected to parent ZBOOKING_I_J6094,
      _Supplement,
      _SupplementText,
      _Travel  : redirected to ZTRAVEL_I_J6094
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBKSPPL_R_J6094
  as select from zbksppl_j6094_a

  association        to parent ZBOOKING_R_J6094 as _Booking        on $projection.BookingUUID = _Booking.BookingUUID
  association [1..1] to ZTRAVEL_R_J6094         as _Travel         on $projection.TravelUUID = _Travel.TravelUUID

  association [1..1] to /DMO/I_Supplement       as _Supplement     on $projection.SupplementId = _Supplement.SupplementID
  association [1..*] to /DMO/I_SupplementText   as _SupplementText on $projection.SupplementId = _SupplementText.SupplementID

{
  key booksuppl_uuid        as BooksupplUUID,
      root_uuid             as TravelUUID,
      parent_uuid           as BookingUUID,

      booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,

      // Local ETag Field
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Booking,
      _Travel,
      _Supplement,
      _SupplementText
}

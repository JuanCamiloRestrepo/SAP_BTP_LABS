@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBOOKING_C_J6094
  as projection on ZBOOKING_R_J6094
{
  key BookingUUID,
      TravelUUID,
      BookingID,
      BookingDate,
      CustomerID,
      AirlineID,
      ConnectionID,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      BookingStatus,

      LocalLastChagedAt,

      /* Associations */
      _BookingStatus,
      _BookingSupplement : redirected to composition child ZBKSPPL_C_J6094,
      _Carrier,
      _Connection,
      _Customer,
      _Travel            : redirected to parent ZTRAVEL_C_J6094
}

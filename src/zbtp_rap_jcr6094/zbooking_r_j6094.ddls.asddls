@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBOOKING_R_J6094
  as select from zbooking_j6094_a

  association        to parent ZTRAVEL_R_J6094   as _Travel        on  $projection.TravelUUID = _Travel.TravelUUID

  association [1..1] to /DMO/I_Customer          as _Customer      on  $projection.CustomerID = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier           as _Carrier       on  $projection.AirlineID = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection        as _Connection    on  $projection.AirlineID    = _Connection.AirlineID
                                                                   and $projection.ConnectionID = _Connection.ConnectionID
  association [1..1] to /DMO/I_Booking_Status_VH as _BookingStatus on  $projection.BookingStatus = _BookingStatus.BookingStatus
  
  composition [0..*] of ZBKSPPL_R_J6094 as _BookingSupplement


{
  key booking_uuid         as BookingUUID,
      parent_uuid          as TravelUUID,

      booking_id           as BookingID,
      booking_date         as BookingDate,
      customer_id          as CustomerID,
      carrier_id           as AirlineID,
      connection_id        as ConnectionID,
      flight_date          as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price         as FlightPrice,
      currency_code        as CurrencyCode,
      booking_status       as BookingStatus,

      // Local ETag Field
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_chaged_at as LocalLastChagedAt,

      _Travel,
      _Customer,
      _Carrier,
      _Connection,
      _BookingStatus,
      _BookingSupplement
}

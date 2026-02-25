@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: [ 'BookingID' ]
define view entity ZBOOKING_C_J6094
  as projection on ZBOOKING_R_J6094
{
  key BookingUUID,
      TravelUUID,
      
      @Search.defaultSearchElement: true
      BookingID,
      
      BookingDate,
      
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer_StdVH',
                                                     element: 'CustomerID' },
                                           useForValidation: true }]
      CustomerID,
      _Customer.LastName as CustomerName,
      
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'CarrierName' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Flight_StdVH',
                                                     element: 'AirlineID' },
                                           additionalBinding: [{ localConstant: 'ConnectionID', element: 'ConnectionID', usage: #RESULT },
                                                               { localConstant: 'FlightDate', element: 'FlightDate', usage: #RESULT },
                                                               { localConstant: 'FlightPrice', element: 'FlightPrice', usage: #RESULT },
                                                               { localConstant: 'Currency', element: 'Currency', usage: #RESULT }],
                                           useForValidation: true }]
      AirlineID,
      _Carrier.Name as CarrierName,
      
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Flight_StdVH',
                                                     element: 'ConnectionID' },
                                           additionalBinding: [{ localConstant: 'AirlineID', element: 'AirlineID', usage: #RESULT },
                                                               { localConstant: 'FlightDate', element: 'FlightDate', usage: #RESULT },
                                                               { localConstant: 'FlightPrice', element: 'FlightPrice', usage: #RESULT },
                                                               { localConstant: 'Currency', element: 'Currency', usage: #RESULT }],
                                           useForValidation: true }]
      ConnectionID,

      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Flight_StdVH',
                                                     element: 'FlightDate' },
                                           additionalBinding: [{ localConstant: 'AirlineID', element: 'AirlineID', usage: #RESULT },
                                                               { localConstant: 'ConnectionID', element: 'ConnectionID', usage: #RESULT },
                                                               { localConstant: 'FlightPrice', element: 'FlightPrice', usage: #RESULT },
                                                               { localConstant: 'Currency', element: 'Currency', usage: #RESULT }],
                                           useForValidation: true }]
      FlightDate,
      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Flight_StdVH',
                                                     element: 'FlightPrice' },
                                           additionalBinding: [{ localConstant: 'AirlineID', element: 'AirlineID', usage: #RESULT },
                                                               { localConstant: 'ConnectionID', element: 'ConnectionID', usage: #RESULT },
                                                               { localConstant: 'FlightDate', element: 'FlightDate', usage: #RESULT },
                                                               { localConstant: 'Currency', element: 'Currency', usage: #RESULT }],
                                           useForValidation: true }]
      FlightPrice,
      
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH',
                                                     element: 'Currency' },
                                           useForValidation: true }]
      CurrencyCode,
      
      @ObjectModel.text.element: [ 'BookingStatusText' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Booking_Status_VH',
                                                     element: 'BookingStatus' },
                                           useForValidation: true }]
      BookingStatus,
      _BookingStatus._Text.Text as BookingStatusText : localized,

      LocalLastChangedAt,

      /* Associations */
      _BookingStatus,
      _BookingSupplement : redirected to composition child ZBKSPPL_C_J6094,
      _Carrier,
      _Connection,
      _Customer,
      _Travel            : redirected to parent ZTRAVEL_C_J6094
}

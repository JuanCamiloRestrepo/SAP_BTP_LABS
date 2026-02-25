@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: [ 'BookingSupplementId' ]
define view entity ZBKSPPL_C_J6094
  as projection on ZBKSPPL_R_J6094
{
  key BooksupplUUID,
      TravelUUID,
      BookingUUID,
      
      @Search.defaultSearchElement: true
      BookingSupplementId,
      
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'SupplementDescription' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Supplement_StdVH',
                                                     element: 'SupplementID' },
                                           additionalBinding: [{ localConstant: 'Price', element: 'Price', usage: #RESULT },
                                                               { localConstant: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT }],
                                           useForValidation: true }]
      SupplementId,
      _SupplementText.Description as SupplementDescription : localized,
      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH',
                                                     element: 'Currency' },
                                           useForValidation: true }]
      CurrencyCode,
      
      LocalLastChangedAt,

      /* Associations */
      _Booking : redirected to parent ZBOOKING_C_J6094,
      _Supplement,
      _SupplementText,
      _Travel : redirected to ZTRAVEL_C_J6094
}

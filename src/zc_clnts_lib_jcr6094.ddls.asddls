@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Clients and Books'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
    serviceQuality: #B,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_CLNTS_LIB_JCR6094 as select from ztb_clnts_lib_jr
{
    key id_libro                 as BookID,
    count( distinct id_cliente ) as Sales
}
group by id_libro
    

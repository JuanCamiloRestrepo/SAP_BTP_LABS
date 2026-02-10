@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Clients'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_CLIENTES_JCR
  as select from ztb_clientes_jcr as Clients
  
  inner join ztb_clnts_lib_jr as RelCliLib on RelCliLib.id_cliente = Clients.id_cliente 
  
{
  key RelCliLib.id_libro  as BookID,
  key Clients.id_cliente  as ClientID,
  key Clients.tipo_acceso as AccessType,
      Clients.nombre      as Name,
      Clients.apellidos   as Lastname,
      Clients.email       as Email,
      Clients.url         as Images
}

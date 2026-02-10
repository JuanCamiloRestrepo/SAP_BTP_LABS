@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Books'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_LIBROS_JCR6
  as select from    ztb_libros_jcr6      as Books

    inner join      ztb_catego_jcr6      as Categ on Books.bi_categ = Categ.bi_categ
    left outer join ZC_CLNTS_LIB_JCR6094 as Sales on Books.id_libro = Sales.BookID
  association [0..*] to ZC_CLIENTES_JCR as _Clients on $projection.BookID = _Clients.BookID

{
  key Books.id_libro    as BookID,
  key Books.bi_categ    as Category,
      Books.titulo      as Title,
      Books.autor       as Author,
      Books.editorial   as Editorial,
      Books.idioma      as Language,
      Books.paginas     as PagesNumber,
      @Semantics.amount.currencyCode: 'Currency'
      Books.precio      as Price,
      Books.moneda      as Currency,

      case
        when Sales.Sales < 1 then 0
        when Sales.Sales = 1 then 1
        when Sales.Sales = 2 then 2
        when Sales.Sales > 2 then 3
        else 0
      end               as Sales,

      Categ.descripcion as Description,

      Books.formato     as BookFormat,
      Books.url         as Images,

      _Clients
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS OF F4 SALES ORGANISATION'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.dataCategory: #VALUE_HELP    
define view entity ZSALES_ORGANISATION as select from I_BillingDocumentItemCube( P_ExchangeRateType: 'M', P_DisplayCurrency:'INR' )

{
  key  SalesOrganization
}
group by 
 SalesOrganization

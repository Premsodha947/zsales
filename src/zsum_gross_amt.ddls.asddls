 @AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gross Amount cds sum'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zsum_Gross_Amt as select from Zgross_Amt as a 
{
    key a.BillingDocument,
    key a.BillingDocumentItem,
      a.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(a.ConditionAmount) as ConditionAmount
}
group by
    a.BillingDocument,
    a.BillingDocumentItem,
    a.TransactionCurrency

    
    
 
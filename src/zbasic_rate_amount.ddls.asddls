@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic Rate Amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zbasic_Rate_Amount
  as select from I_BillingDocumentItemPrcgElmnt as a
{
  key a.BillingDocument,
  key a.BillingDocumentItem,
  key a.PricingProcedureStep,
  key a.PricingProcedureCounter,
      a.ConditionType,
      a.TransactionCurrency, 
      a.ConditionRateValue,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
//      sum(a.ConditionAmount) as ConditionAmount
    a.ConditionRateValue as ConditionAmount,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    ConditionAmount as amountcgssgtigst
}
where ( a.ConditionType = 'JOCG' or a.ConditionType = 'JOSG' or a.ConditionType = 'JOIG' or a.ConditionType = 'ZTCS' or a.ConditionType = 'Z004'
or a.ConditionType = 'ZFRT'  or a.ConditionType = 'ZPK1'  or a.ConditionType = 'ZLUM' )
group by
    a.BillingDocument,
    a.BillingDocumentItem,
    a.PricingProcedureStep,
    a.PricingProcedureCounter,
    a.TransactionCurrency, 
    a.ConditionType,
    a.ConditionRateValue,
    ConditionAmount    



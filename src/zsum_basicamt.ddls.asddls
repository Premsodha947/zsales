@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic Amount Sum'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zsum_Basicamt as select from Zbasic_Rate_Amount
{
    key BillingDocument,
    key BillingDocumentItem,
        ConditionType,
       TransactionCurrency,
       ConditionRateValue, 
       @Semantics.amount.currencyCode: 'TransactionCurrency'
//        sum(ConditionAmount) as ConditionAmount
   ConditionRateValue as ConditionAmount,
   @Semantics.amount.currencyCode: 'TransactionCurrency'
   amountcgssgtigst,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    ConditionAmount as ConditionAmounttt
   
}
group by
    BillingDocument,
    BillingDocumentItem,
    ConditionType,
    TransactionCurrency,
    ConditionRateValue,
    amountcgssgtigst,
    ConditionAmount

 

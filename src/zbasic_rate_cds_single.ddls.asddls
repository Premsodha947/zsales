@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for Basic Rate Single Entry per Billing Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zbasic_rate_cds_single as select from Zbasic_rate_cds
{
    BillingDocument,
  BillingDocumentItem,
  max(ConditionRateAmount) as ConditionRateAmount
}
group by 
BillingDocument, 
BillingDocumentItem

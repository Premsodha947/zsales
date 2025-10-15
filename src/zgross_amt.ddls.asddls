@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gross Amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zgross_Amt as select from I_BillingDocumentItemPrcgElmnt as a
{
    key a.BillingDocument,
    key a.BillingDocumentItem,
    key a.PricingProcedureStep,
     key a.PricingProcedureCounter,
      a.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(a.ConditionAmount) as ConditionAmount
}
 
where ( a.ConditionType = 'JOCG' or a.ConditionType = 'JOSG' or a.ConditionType = 'JOIG' or

a.ConditionType = 'Z3RD' or a.ConditionType = 'ZAFT' or a.ConditionType = 'ZAST' or a.ConditionType = 'ZBSM' or a.ConditionType = 'ZBSW'
or a.ConditionType = 'ZCP0'  or a.ConditionType = 'ZDEM'  
  or a.ConditionType = 'ZDOM'  or a.ConditionType = 'ZP00'  or a.ConditionType = 'ZEP0'  or a.ConditionType = 'ZPRS'  or a.ConditionType = 'PPR0'  or a.ConditionType = 'ZJOB' or a.ConditionType = 'ZNPD'
   or a.ConditionType = 'ZRAW' or a.ConditionType = 'ZRET'  or a.ConditionType = 'ZSCH' or a.ConditionType = 'ZSCR' or a.ConditionType = 'ZSPR'   or a.ConditionType = 'ZPRS' 
   or a.ConditionType = 'ZOLD'   or a.ConditionType = 'ZNEW'  or a.ConditionType = 'ZP00'  or a.ConditionType = 'ZSUP'   or a.ConditionType = 'ZDIF'   or a.ConditionType = 'ZDIE' or a.ConditionType = 'ZBOT'  or a.ConditionType = 'ZTRD'
    or a.ConditionType = 'ZTRE'  or a.ConditionType = 'ZY01' or a.ConditionType = 'Z12'  or a.ConditionType = 'Z13'  or a.ConditionType = 'Z14'  or a.ConditionType = 'Z15' 
     or a.ConditionType = 'Z16'  or a.ConditionType = 'ZOT'  or a.ConditionType = 'ZC1'  or a.ConditionType = 'ZC2' or a.ConditionType = 'ZC3'  or a.ConditionType = 'ZC5'  or a.ConditionType = 'ZC6'
      or a.ConditionType = 'ZC7'  or a.ConditionType = 'ZC8'  or a.ConditionType = 'ZC9'  or a.ConditionType = 'Z11'  or a.ConditionType = 'ZFOC'  
      
   )
group by
    a.BillingDocument,
    a.BillingDocumentItem,
    a.PricingProcedureStep,
    a.PricingProcedureCounter,
    a.TransactionCurrency
    
     

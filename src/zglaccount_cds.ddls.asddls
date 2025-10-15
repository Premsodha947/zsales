@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GL Account cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity Zglaccount_Cds as select from I_OperationalAcctgDocItem as a
{
    key a.AccountingDocument,
    key a.CompanyCode,
    key a.FiscalYear,
    key a.GLAccount
     
}
group by
a.AccountingDocument,
a.CompanyCode,       
a.FiscalYear,        
a.GLAccount        
  
   

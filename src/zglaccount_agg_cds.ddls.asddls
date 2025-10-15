@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for gl account'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGLACCOUNT_AGG_CDS as select distinct from I_JournalEntryItem
  
  
  {
key  AccountingDocument,
     FiscalYear,
     GLAccount
  }
where ControllingObjectDebitType = '2' and SourceLedger = '0L'





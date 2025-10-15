@AbapCatalog.sqlViewName: 'ZSALES_REG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GL ACCOUNT & DESCRIPTION'
@Metadata.ignorePropagatedAnnotations: true
define view ZSALES_GLA_CDS as select distinct from  
I_BillingDocumentItemCube( P_ExchangeRateType:'M' , P_DisplayCurrency: 'INR' ) as a  //I_BillingDocument as 
      
      
//             ZGLACCOUNT_AGG_CDS  as gla          
left outer join        I_JournalEntryItem as PP on ( a.AccountingDocument = PP.AccountingDocument 
                                                        and a.Product = PP.Product 
                                                     and a.FiscalYear = PP.FiscalYear and PP.ControllingObjectDebitType = '2'
                                                      and PP.SourceLedger = '0L' )
                                             
 left outer join I_GLAccountTextRawData  as gldesc on   (  gldesc.GLAccount = PP.GLAccount    and gldesc.Language = 'E' 
                                                         )
{
  key PP.AccountingDocument,
      PP.FiscalYear,
      PP.GLAccount,
      gldesc.GLAccountName,
      PP.Product
     
} 


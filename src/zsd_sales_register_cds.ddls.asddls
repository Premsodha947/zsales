@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds of SD SALES REGISTER'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZSD_SALES_REGISTER_CDS
//  with parameters
//    p_plant : werks_d
  as select from I_BillingDocumentItemCube( P_ExchangeRateType:'M' , P_DisplayCurrency: 'INR' ) as a
  association [0..1] to I_SalesDocument     as b        on $projection.SalesDocument = b.SalesDocument
  association [1..1] to I_SalesDocumentItem as _sItem   on (
       $projection.SalesDocument    = _sItem.SalesDocument
       and $projection.SalesDocumentItem = _sItem.SalesDocumentItem
     )
   association[1..1] to I_SalesOrderItem as b1 on ($projection.SalesDocument = b1.SalesOrder and $projection.SalesDocumentItem = b1.SalesOrderItem )  
  association [1..*] to I_JournalEntry      as _journal on (
     $projection.AccountingDocument = _journal.AccountingDocument
     and $projection.CompanyCode    = _journal.CompanyCode 
     and $projection.FiscalYear     = a.FiscalYear
   ) 
association[1..1] to I_Customer as _soldparty on ( $projection.SoldToParty = _soldparty.Customer )
association[1..1] to I_Customer as _shipparty on ($projection.ShipToParty = _shipparty.Customer) 
association[1..1] to I_ProductPlantBasic as _hsn on ($projection.Product = _hsn.Product and $projection.Plant = _hsn.Plant)
association[1..1] to I_ProductDescription_2 as _des on ($projection.Product = _des.Product and _des.Language = 'E')
association[0..1] to Zsum_Basicamt as CGSTAmt on ( $projection.BillingDocument = CGSTAmt.BillingDocument and 
                                                       $projection.BillingDocumentItem = CGSTAmt.BillingDocumentItem   and CGSTAmt.ConditionType = 'JOCG')
association[0..1] to Zsum_Basicamt as Sgsramt on  ( $projection.BillingDocument = Sgsramt.BillingDocument and 
                                                       $projection.BillingDocumentItem = Sgsramt.BillingDocumentItem   and Sgsramt.ConditionType = 'JOSG')
association[0..1] to Zsum_Basicamt as IGSTamt on  ( $projection.BillingDocument = IGSTamt.BillingDocument and 
                                                       $projection.BillingDocumentItem = IGSTamt.BillingDocumentItem   and IGSTamt.ConditionType = 'JOIG')  
association[0..1] to Zsum_Basicamt as tdsamt on  ( $projection.BillingDocument = tdsamt.BillingDocument and 
                                                       $projection.BillingDocumentItem = tdsamt.BillingDocumentItem   and tdsamt.ConditionType = 'ZTCS')  
                                                       
association[0..1] to Zsum_Gross_Amt as Grossamt on ( $projection.BillingDocument = Grossamt.BillingDocument and $projection.BillingDocumentItem = Grossamt.BillingDocumentItem )             
association[1..*] to I_IN_ElectronicDocTransptRegn as Ebill on ( $projection.BillingDocument = Ebill.ElectronicDocSourceKey )
association[1..*] to I_IN_ElectronicDocInvoice as Irn on ( $projection.BillingDocument = Irn.ElectronicDocSourceKey )  
association[1..1] to I_BillingDocumentItem as _item on ( $projection.BillingDocument = _item.BillingDocument and $projection.BillingDocumentItem = _item.BillingDocumentItem ) 
association[0..1] to Zsum_Basicamt as disamt on  ( $projection.BillingDocument = disamt.BillingDocument and 
                                                       $projection.BillingDocumentItem = disamt.BillingDocumentItem   and disamt.ConditionType = 'Z004')

association[0..1] to Zsum_Basicamt as frgt on  ( $projection.BillingDocument = frgt.BillingDocument and 
                                                       $projection.BillingDocumentItem = frgt.BillingDocumentItem   and frgt.ConditionType = 'ZFRT') 
association[0..1] to Zsum_Basicamt as Lum on  ( $projection.BillingDocument = Lum.BillingDocument and 
                                                       $projection.BillingDocumentItem = Lum.BillingDocumentItem   and Lum.ConditionType = 'ZLUM')     
association[1..1] to I_DistributionChannelText as _distribu on ( $projection.DistributionChannel = _distribu.DistributionChannel and _distribu.Language = 'E') 
association[1..1] to  I_DivisionText as _divi on ( $projection.Division = _divi.Division  and _divi.Language = 'E') 
association[0..1] to Zsum_Basicamt as packcharge on  ( $projection.BillingDocument = packcharge.BillingDocument and 
                                                       $projection.BillingDocumentItem = packcharge.BillingDocumentItem   and packcharge.ConditionType = 'ZPK1')
association[0..1] to  ZSALES_GLA_CDS as GLDEC on ( $projection.AccountingDocument = GLDEC.AccountingDocument 
                                                               and $projection.Product = GLDEC.Product
                                                                  and $projection.FiscalYear = GLDEC.FiscalYear )
association[0..1] to  I_JournalEntryItem as PP on ( $projection.AccountingDocument = PP.AccountingDocument 
                                                        and $projection.Product = PP.Product 
                                                     and $projection.FiscalYear = PP.FiscalYear and PP.ControllingObjectDebitType = '2'
                                                      and PP.SourceLedger = '0L' )
                                                                                                           
//association[0..1] to     I_GLAccountTextRawData  as Q on( $projection.G = PP.GLAccount    and Q.Language = 'E' )
                                                                                                       
association[1..1] to I_BillingDocumentItemPrcgElmnt as basicrate on ( $projection.BillingDocument = basicrate.BillingDocument  and 
                                                   $projection.BillingDocumentItem = basicrate.BillingDocumentItem  )  
association[1..1] to ZSALES_ACCEPT_QTY as acceptqty on ( $projection.BillingDocument = acceptqty.BillingDocument  and 
                                                   $projection.BillingDocumentItem = acceptqty.BillingDocumentItem  )  
association[1..1] to I_DeliveryDocument as  packingdetails on ($projection.BillingDocument  = packingdetails.DeliveryDocument)                                                                                                                                                                                                                                                                                                                                                                           

association[0..1] to Zbasic_rate_cds as basicrateinr on  ( $projection.BillingDocument = basicrateinr.BillingDocument and 
                                                       $projection.BillingDocumentItem = basicrateinr.BillingDocumentItem  )
                                                         
association[0..1] to Zbasic_rate_cds_single as basicrateinr11 on  ( $projection.BillingDocument = basicrateinr11.BillingDocument and 
                                                       $projection.BillingDocumentItem = basicrateinr11.BillingDocumentItem  )
                                                         
{
  key a.BillingDocument,
  key a.BillingDocumentItem,
  key a.Plant,
  key a.BillingDocumentType,
      a.AccountingDocument,
      a.PurchaseOrderByCustomer,
      a.SoldToParty,
      a.SoldToPartyName,
      _soldparty.TaxNumber3    as Sold_GstNo,
      _soldparty.Region        as sold_region,
      
      
//      _soldparty.Region as sold_region,

 case _soldparty.Region
     when 'JK' then '01'
     when 'HP' then '02'
     when 'PB' then '03'
     when 'CH' then '04'
     when 'UK' then '05'
     when 'HR' then '06'
     when 'DL' then '07'
     when 'RJ' then '08'
     when 'UP' then '09'
     when 'BR' then '10'
     when 'SK' then '11'
     when 'AR' then '12'
     when 'NL' then '13'
     when 'MN' then '14'
     when 'MZ' then '15'
     when 'TR' then '16'
     when 'ML' then '17'
     when 'AS' then '18'
     when 'WB' then '19'
     when 'JH' then '20'
     when 'OD' then '21'
     when 'CG' then '22'
     when 'MP' then '23'
     when 'GJ' then '24'
     when 'DD' then '25' 
     when 'DN' then '26'
     when 'MH' then '27'
     when 'AP' then '28'  
     when 'KA' then '29'
     when 'GA' then '30'
     when 'LD' then '31'
     when 'KL' then '32'
     when 'TN' then '33'
     when 'PY' then '34'
     when 'AN' then '35'
     when 'TS' then '36'
     when 'LA' then '38'
     when 'OT' then '97'
      when 'CJ' then '99'
     else '00'
end as SoldStateCode,
      
      
      
      
      
      
      
      a.DocumentReferenceID,
      a.CompanyCode,
      a.FiscalYear,
      a.SalesDocument,
      a.SalesDocumentItem,
      a.Product,
      a.BillingQuantityUnit,
@Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'      
      a.BillingQuantity,
      b.CustomerPurchaseOrderDate,
      _sItem.UnderlyingPurchaseOrderItem,
      max(_journal.PostingDate) as Postingdate,
      a.ShipToParty,
      a.ShipToPartyName,
      _shipparty.TaxNumber3 as Ship_Gstno,
      _shipparty.Region as Ship_Region,
      _hsn.ConsumptionTaxCtrlCode as HsnCode,
      _des.ProductDescription,
      _sItem.MaterialByCustomer,
//      b1.TransactionCurrency,


      a.TransactionCurrency ,
//      @Semantics.amount.currencyCode: 'document_curr'
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      b1.NetPriceAmount,
      a.PriceDetnExchangeRate as ExchangeRate,
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
//      b1.NetPriceAmount as BASICRATE ,


//          basicrateinr11.ConditionRateAmount  *  a.PriceDetnExchangeRate  as BASIC_RATE_INR ,
//        max( basicrateinr.ConditionRateAmount ) * a.PriceDetnExchangeRate as BASIC_RATE_INR,
                      
                 

//cast(basicrateinr11.ConditionRateAmount as abap.dec(15,2)) 
//* cast(a.PriceDetnExchangeRate as abap.dec(15,5)) 
//as BASIC_RATE_INR,



//case 
//  when a.BillingDocumentType = 'CBRE' then
//       case 
//            when a.BillingQuantity = 0 then 0
//            else 
//                 ( cast(basicrateinr.ConditionRateAmount as abap.dec(15,2)) /
//                   cast(a.BillingQuantity as abap.dec(15,2)) )
//                   * cast(a.PriceDetnExchangeRate as abap.dec(15,5))
//       end
//  else
//       case 
//            when a.BillingQuantity = 0 then 0
//            else 
//                 cast(basicrateinr.ConditionRateAmount as abap.dec(15,2))
//                 * cast(a.PriceDetnExchangeRate as abap.dec(15,5))
//       end
//end as BASIC_RATE_INR,

//case 
//  when a.BillingDocumentType = 'CBRE' then
//       case 
//            when a.BillingQuantity = 0 then 0
//            else 
//                 cast( 
//                      ( cast(basicrateinr.ConditionRateAmount as abap.dec(15,3)) /
//                        cast(a.BillingQuantity as abap.dec(15,3)) ) 
//                      * cast(a.PriceDetnExchangeRate as abap.dec(15,5))
//                 as abap.dec(15,3))
//       end
//  else
//       case 
//            when a.BillingQuantity = 0 then 0
//            else 
//                 cast( 
//                      cast(basicrateinr.ConditionRateAmount as abap.dec(15,3)) *
//                      cast(a.PriceDetnExchangeRate as abap.dec(15,5))
//                 as abap.dec(15,3))
//       end
//end as BASIC_RATE_INR,



 case
  when a.BillingDocumentType = 'CBRE' and a.BillingQuantity = 0 then 0
  when a.BillingDocumentType = 'CBRE' then
       cast(
           ( cast(basicrateinr.ConditionRateAmount as abap.dec(15,3)) /
             cast(a.BillingQuantity as abap.dec(15,3)) ) *
           cast(a.PriceDetnExchangeRate as abap.dec(15,5))
       as abap.dec(15,3))
  else
       cast(
           cast(basicrateinr.ConditionRateAmount as abap.dec(15,3)) *
           cast(a.PriceDetnExchangeRate as abap.dec(15,5))
       as abap.dec(15,3))
end as BASIC_RATE_INR,

     



//cast( basicrateinr11.ConditionRateAmount as abap.dec(15,2) ) *
//coalesce( cast( a.PriceDetnExchangeRate as abap.dec(15,5) ), 0 )
//- abs( coalesce( cast( disamt.amountcgssgtigst as abap.dec(15,2) ), 0 ) )
//as FinalBasicRate,




//cast(
//    (
//        case 
//            when a.BillingDocumentType = 'CBRE' then
//                ( cast(coalesce(cast(basicrateinr.ConditionRateAmount as abap.dec(15,5)),0) as abap.dec(15,5)) /
//                  cast(a.BillingQuantity as abap.dec(15,5)) )
//                  * cast(a.PriceDetnExchangeRate as abap.dec(15,5))
//            else
//                cast(coalesce(cast(basicrateinr.ConditionRateAmount as abap.dec(15,5)),0) as abap.dec(15,5))
//                * cast(a.PriceDetnExchangeRate as abap.dec(15,5))
//        end
//        - abs( cast(coalesce(cast(disamt.amountcgssgtigst as abap.dec(15,5)),0) as abap.dec(15,5)) /
//            cast(a.BillingQuantity as abap.dec(15,5)) )
//    ) as abap.dec(15,3)
//) as FINALBASICRATE,


case 
  when a.BillingQuantity = 0 then 0
  when a.BillingDocumentType = 'CBRE' then
       cast(
           ( coalesce(cast(basicrateinr.ConditionRateAmount as abap.dec(15,5)),0) /
             cast(a.BillingQuantity as abap.dec(15,5)) ) *
             cast(a.PriceDetnExchangeRate as abap.dec(15,5))
           - abs(
               coalesce(cast(disamt.amountcgssgtigst as abap.dec(15,5)),0) /
               cast(a.BillingQuantity as abap.dec(15,5))
             )
       as abap.dec(15,3))
  else
       cast(
           ( coalesce(cast(basicrateinr.ConditionRateAmount as abap.dec(15,5)),0) *
             cast(a.PriceDetnExchangeRate as abap.dec(15,5)) )
           - abs(
               coalesce(cast(disamt.amountcgssgtigst as abap.dec(15,5)),0) /
               cast(a.BillingQuantity as abap.dec(15,5))
             )
       as abap.dec(15,3))
end as FINALBASICRATE,





     

//(
//    cast(basicrateinr11.ConditionRateAmount as abap.dec(15,2)) 
//    * (coalesce (cast(a.PriceDetnExchangeRate as abap.dec(15,5)), 0)
//) - ( coalesce (cast(disamt.amountcgssgtigst as abap.dec(15,2)), 0) 
//as FinalBasicRate,
                      
                      

cast(
  (
    cast(
      (
        cast(basicrateinr11.ConditionRateAmount as abap.dec(13,2)) *
        cast(a.PriceDetnExchangeRate as abap.dec(13,5))
      ) - cast(disamt.amountcgssgtigst as abap.dec(13,2))
      as abap.dec(16,3)  
    )
    * cast(a.BillingQuantity as abap.dec(13,3))
  )
  as abap.dec(16,2)  
) as AssessableValueINR,
        
        
  
  
//  case BillingDocumentType
//  when 'S1' then -1
//  when 'S2' then -1
//  when 'G2' then -1
//  when 'CBRE' then -1
//  else 1
//end as AmountSign,

//BasicAmount    * AmountSign as BasicAmount,
                      

      CGSTAmt.TransactionCurrency as Tcuky ,
      @Semantics.amount.currencyCode: 'Tcuky'
    case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then
     -CGSTAmt.amountcgssgtigst 
      else CGSTAmt.amountcgssgtigst
end as cgst, 
      cast( ( coalesce( cast(CGSTAmt.ConditionAmount as abap.dec( 25, 2 )) , 0) ) as abap.dec( 25, 2 )) as Cgstper,
      
      Sgsramt.TransactionCurrency as sgstcuky ,
      @Semantics.amount.currencyCode: 'sgstcuky'
       case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then
      -Sgsramt.amountcgssgtigst
      else Sgsramt.amountcgssgtigst
      end as Sgsramt,
      cast( ( coalesce( cast(Sgsramt.ConditionAmount as abap.dec( 25, 2 )) , 0) ) as abap.dec( 25, 2 )) as Sgstper,
      
      IGSTamt.TransactionCurrency as IGSTamtcuky ,
      @Semantics.amount.currencyCode: 'IGSTamtcuky'
      
      
      
      case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
      then
          -IGSTamt.amountcgssgtigst
          else IGSTamt.amountcgssgtigst 
          end as IGSTamt,
      
      
      
      
      
      cast( ( coalesce( cast(IGSTamt.ConditionAmount as abap.dec( 25, 2 )) , 0)  ) as abap.dec( 25, 2 )) as IGSTper,
      tdsamt.TransactionCurrency as tdscuky,
      tdsamt.ConditionRateValue as tcspercentage,
      @Semantics.amount.currencyCode: 'tdscuky'
      tdsamt.amountcgssgtigst as ConditionAmount,
      Grossamt.TransactionCurrency as GrossCuky,
      @Semantics.amount.currencyCode: 'GrossCuky'
     Grossamt.ConditionAmount as GrossAmount,


//GrossAmount * AmountSign as GrossAmount,


      Ebill.IN_ElectronicDocEWbillNmbr as EwayBill,
      Ebill.IN_EDocEWbillCreateDate as Ewaybilldate,
      Irn.IN_ElectronicDocInvcRefNmbr as Irn,
      Irn.IN_ElectronicDocAcknDate as Irndate,
      _item.ReferenceSDDocument as Delivery  ,
      b.YY1_UnloadingPoint_SDH as UnloadingPoint,
      @Semantics.quantity.unitOfMeasure: 'Netqtyunit'
      _item.BillingQuantity  as NetinvoiceQuantity,
      _item.BillingQuantityUnit as Netqtyunit,
//      disamt.TransactionCurrency as discuky,
//      @Semantics.amount.currencyCode: 'discuky'
//cast(disamt.amountcgssgtigst as abap.dec(15,2)) as Discount,

//disamt.TransactionCurrency as TransactionCurrency123,
//  @Semantics.amount.currencyCode: 'TransactionCurrency123'
//cast(disamt.amountcgssgtigst as abap.dec(15,2)) /  cast(a.BillingQuantity as abap.dec(15,2)) as Discount,


case 
  when a.BillingQuantity = 0 then 0
  else 
       cast(
           cast(disamt.amountcgssgtigst as abap.dec(15,2)) /
           cast(a.BillingQuantity as abap.dec(15,2))
       as abap.dec(15,2))
end as Discount,


      
//      disamt.ConditionAmount as Discount,
      disamt.ConditionRateValue as Discount_percentage,
      frgt.TransactionCurrency as Fcuky,
      @Semantics.amount.currencyCode: 'Fcuky'
      frgt.ConditionAmount as FreightAmount ,
      Lum.TransactionCurrency as lumcuky,
      @Semantics.amount.currencyCode: 'lumcuky'
      Lum.ConditionAmount as lum_conditionAmount,
      _soldparty.StreetName,
      _soldparty.CityName,
      _soldparty.PostalCode,
      _soldparty.Country,
      a.SalesOrganization,
      a.DistributionChannel,
      _distribu.DistributionChannelName,
      a.Division,
      _divi.DivisionName,
      a.CreatedByUser,
      a.CreationDate,
      a.CreationTime,
      _item.MatlAccountAssignmentGroup,
      
case
  when coalesce( _item.BillingQuantity, 0 ) = 0 and coalesce( _item.ItemGrossWeight, 0 ) = 0 
   then cast( '0.000' as abap.dec(15,3) ) 
  else cast(
         division(
           cast( _item.ItemGrossWeight as abap.dec(15,3) ),
           cast( _item.BillingQuantity  as abap.dec(13,3) ),
           3
         ) as abap.dec(15,3)
       )
end as GrossWeightPerQty,
      _item.ItemWeightUnit,
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      _item.ItemGrossWeight,
     cast(
  case
    when coalesce( _item.BillingQuantity, 0 ) = 0  and coalesce( _item.ItemNetWeight, 0 ) = 0
    then cast( '0.000' as abap.dec(13,3) )
    else cast(
           division( cast(_item.ItemNetWeight as abap.dec( 15, 3 )) ,
              cast(_item.BillingQuantity as abap.dec( 13, 3 )), 3 )
           as abap.dec(13,3)
         )
  end
  as abap.dec(13,3)
) as NetWeightPerQty,
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      _item.ItemNetWeight,
   acceptqty.ItemWeightUnit as uom  ,
//      _item.BillingQuantityUnit as uom  ,
      packcharge.ConditionRateValue as packingchargepercentage,
      packcharge.TransactionCurrency as Packingchargecurrecncy,
      @Semantics.amount.currencyCode: 'Packingchargecurrecncy'
      packcharge.amountcgssgtigst as Packingchargeamount,  //amountcgssgtigst IS CONDITIONAMOUNT 
      a.ReferenceSDDocument,
      a.BillingDocumentDate,
//      GLDEC.GLAccount,
//      '' as GLAccount,
//      '' as GLAccountName,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
//      basicrateinr.ConditionRateAmount as basicrateinr1,
    
    

      
      
      case 
  when a.BillingDocumentType = 'CBRE' then
       case when a.BillingQuantity = 0 then 0
            else cast(basicrateinr.ConditionRateAmount as abap.dec(15,3)) /
                 cast(a.BillingQuantity as abap.dec(15,3))
       end
  else
       case when a.BillingQuantity = 0 then 0
            else   cast(basicrateinr.ConditionRateAmount as abap.dec(15, 3) )
       end
end as basicrateinr1 ,
      
      
      
      cast(a.BillingQuantity as abap.dec( 13, 3) ) * cast( basicrateinr.ConditionRateAmount as abap.dec( 13, 3 )) as BasicValueInINR,
      @Semantics.amount.currencyCode: 'Tcuky'
      coalesce(  cast( basicrateinr.ConditionRateAmount as abap.dec( 13, 3 )) , 0 ) +
 coalesce( cast(CGSTAmt.amountcgssgtigst as abap.dec( 13, 3 )), 0 ) + coalesce( cast(Sgsramt.amountcgssgtigst as abap.dec( 13, 3 ) ), 0 ) 
      + coalesce( cast(IGSTamt.amountcgssgtigst as abap.dec( 13, 3 )), 0 ) + coalesce( cast(tdsamt.amountcgssgtigst as abap.dec( 13, 3 )), 0 ) as GrossAmountINCTCS,     
     
     
//       coalesce( cast( cast(a.BillingQuantity as abap.dec( 13, 3) ) * 
//       cast( basicrateinr.ConditionRateAmount as abap.dec( 13, 3 )) as abap.dec( 13, 3 )),0 ) +
//        coalesce( cast(CGSTAmt.amountcgssgtigst as abap.dec( 13, 3 )), 0 )
//         + coalesce( cast(Sgsramt.amountcgssgtigst as abap.dec( 13, 3 ) ), 0 ) 
//      + coalesce( cast(IGSTamt.amountcgssgtigst as abap.dec( 13, 3 )), 0 )   as Grosstotal,
//      
      
      


//
//cast(
//    (
//        (
//            case 
//                when a.BillingDocumentType = 'CBRE' then
//                    ( cast(coalesce(cast(basicrateinr.ConditionRateAmount as abap.dec(15,5)),0) as abap.dec(15,5)) /
//                      cast(a.BillingQuantity as abap.dec(15,5)) )
//                      * cast(a.PriceDetnExchangeRate as abap.dec(15,5))
//                else
//                    cast(coalesce(cast(basicrateinr.ConditionRateAmount as abap.dec(15,5)),0) as abap.dec(15,5))
//                    * cast(a.PriceDetnExchangeRate as abap.dec(15,5))
//            end
//            - abs( cast(coalesce(cast(disamt.amountcgssgtigst as abap.dec(15,5)),0) as abap.dec(15,5)) /
//                    cast(a.BillingQuantity as abap.dec(15,5)) )
//        )
//        * cast(a.BillingQuantity as abap.dec(13,5))
//        + coalesce(cast(CGSTAmt.amountcgssgtigst as abap.dec(13,3)), 0)
//        + coalesce(cast(Sgsramt.amountcgssgtigst as abap.dec(13,3)), 0)
//        + coalesce(cast(IGSTamt.amountcgssgtigst as abap.dec(13,3)), 0)
//    )
//    as abap.dec(15,3)
//) as Grosstotal,

      
      
  cast(
    (
        case 
            when a.BillingQuantity = 0 then 0
            when a.BillingDocumentType = 'CBRE' then
                 ( coalesce(cast(basicrateinr.ConditionRateAmount as abap.dec(15,5)),0) /
                   cast(a.BillingQuantity as abap.dec(15,5)) ) *
                   cast(a.PriceDetnExchangeRate as abap.dec(15,5))
                 - abs(
                     coalesce(cast(disamt.amountcgssgtigst as abap.dec(15,5)),0) /
                     cast(a.BillingQuantity as abap.dec(15,5))
                   )
            else
                 ( coalesce(cast(basicrateinr.ConditionRateAmount as abap.dec(15,5)),0) *
                   cast(a.PriceDetnExchangeRate as abap.dec(15,5)) )
                 - abs(
                     coalesce(cast(disamt.amountcgssgtigst as abap.dec(15,5)),0) /
                     cast(a.BillingQuantity as abap.dec(15,5))
                   )
        end
        * cast(a.BillingQuantity as abap.dec(13,5))
        + coalesce(cast(CGSTAmt.amountcgssgtigst as abap.dec(13,3)), 0)
        + coalesce(cast(Sgsramt.amountcgssgtigst as abap.dec(13,3)), 0)
        + coalesce(cast(IGSTamt.amountcgssgtigst as abap.dec(13,3)), 0)
    )
as abap.dec(15,3)) as Grosstotal,
  
      
      
      
      
      
      
//      @EndUserText.label: 'Gross Amount Incl. TCS'
(
    coalesce(
        cast(
            cast(a.BillingQuantity as abap.dec(13,3)) * 
            cast(basicrateinr.ConditionRateAmount as abap.dec(13,3))
            as abap.dec(13,3)
        ), 0
    )
    + coalesce(cast(CGSTAmt.amountcgssgtigst as abap.dec(13,3)), 0)
    + coalesce(cast(Sgsramt.amountcgssgtigst as abap.dec(13,3)), 0)
    + coalesce(cast(IGSTamt.amountcgssgtigst as abap.dec(13,3)), 0)
    + coalesce(cast(tdsamt.amountcgssgtigst as abap.dec(13,3)), 0)
) as GrossAmountInclTCS,
      
      
      
     
     
      acceptqty.DeliveryQuantityUnit,
       @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      acceptqty.ActualDeliveryQuantity,
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
       acceptqty.OriginalDeliveryQuantity,
       
       packingdetails.YY1_packingdetails_DLH,
       GLDEC.GLAccount as PP,
       GLDEC.GLAccountName
     
}
where
  (
       a.BillingDocumentType = 'F2'
    or a.BillingDocumentType = 'JSTO'
    or a.BillingDocumentType = 'G2'
    or a.BillingDocumentType = 'L2'
    or a.BillingDocumentType = 'F8'
    or a.BillingDocumentType = 'S1'
    or a.BillingDocumentType = 'S2'
    or a.BillingDocumentType = 'CBRE'
//    or a.BillingDocumentType = 'JSN'
//    or a.BillingDocumentType = 'JSP'
    
  )
group by
    a.BillingDocument,
    a.BillingDocumentItem,
    a.Plant,
    a.AccountingDocument,
    a.PurchaseOrderByCustomer,
    a.SoldToParty,
    a.SoldToPartyName,
    _soldparty.TaxNumber3,
    _soldparty.Region,
    a.DocumentReferenceID,
    a.CompanyCode,
    a.FiscalYear,
    a.SalesDocument,
    a.SalesDocumentItem,
    a.Product,
    a.BillingQuantityUnit,
    a.BillingQuantity,
    b.CustomerPurchaseOrderDate,
    _sItem.UnderlyingPurchaseOrderItem,
    a.ShipToParty,
    a.ShipToPartyName,
    _shipparty.TaxNumber3,
    _shipparty.Region,
    _hsn.ConsumptionTaxCtrlCode,
    _des.ProductDescription,
    _sItem.MaterialByCustomer,
    b1.TransactionCurrency,
    b1.NetPriceAmount,
    a.PriceDetnExchangeRate,
    CGSTAmt.ConditionAmount,
    CGSTAmt.TransactionCurrency,
    Sgsramt.TransactionCurrency,
    Sgsramt.ConditionAmount,
    IGSTamt.TransactionCurrency,
    IGSTamt.ConditionAmount,
    Grossamt.TransactionCurrency,
    Grossamt.ConditionAmount,
    Ebill.IN_ElectronicDocEWbillNmbr,
    Irn.IN_ElectronicDocInvcRefNmbr,
    _item.ReferenceSDDocument,
    tdsamt.TransactionCurrency,
    tdsamt.amountcgssgtigst,
    Ebill.IN_EDocEWbillCreateDate,
    Irn.IN_ElectronicDocAcknDate,
    b.YY1_UnloadingPoint_SDH,
    _item.BillingQuantity,
    _item.BillingQuantityUnit,
    disamt.TransactionCurrency,
    disamt.ConditionAmount,
    frgt.TransactionCurrency,
    frgt.ConditionAmount,
    Lum.TransactionCurrency,
    Lum.ConditionAmount,
    _soldparty.StreetName,
    _soldparty.CityName,
    _soldparty.PostalCode,
    _soldparty.Country,
    a.SalesOrganization,
    a.DistributionChannel,
    _distribu.DistributionChannelName,
    a.Division,
    _divi.DivisionName,
    a.CreatedByUser,
    a.CreationDate,
    a.CreationTime,
    a.BillingDocumentType,
    tdsamt.ConditionRateValue,
    _item.MatlAccountAssignmentGroup,
    disamt.ConditionRateValue,
    _item.ItemGrossWeight,
    _item.ItemWeightUnit,
    _item.ItemNetWeight,
    packcharge.ConditionRateValue,
    packcharge.TransactionCurrency,
    packcharge.ConditionAmount,
//    GLDEC.GLAccount,
//    GLDEC.GLAccountName,
    a.ReferenceSDDocument,
    a.BillingDocumentDate,
    basicrate.ConditionRateAmount,
    basicrate.ConditionAmount,
    acceptqty.DeliveryQuantityUnit,
    acceptqty.ActualDeliveryQuantity,
    acceptqty.OriginalDeliveryQuantity,
    packingdetails.YY1_packingdetails_DLH,
    CGSTAmt.amountcgssgtigst,
    Sgsramt.amountcgssgtigst,
    IGSTamt.amountcgssgtigst,
    basicrateinr.ConditionAmount,
    tdsamt.ConditionAmounttt,
    basicrateinr.ConditionRateAmount,
    a.TransactionCurrency,
    basicrateinr11.ConditionRateAmount,
    packcharge.amountcgssgtigst,
    disamt.amountcgssgtigst,
    PP.GLAccount,
    GLDEC.GLAccountName,
    GLDEC.GLAccount,
     acceptqty.ItemWeightUnit
 
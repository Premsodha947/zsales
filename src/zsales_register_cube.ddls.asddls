@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FINAL CDS OF sales Register'
@Metadata.ignorePropagatedAnnotations: true
define view entity Zsales_Register_Cube 
as select  from  ZSD_SALES_REGISTER_CDS as a
left outer join I_RegionText as b on ( b.Region = a.sold_region and b.Language = 'E' and b.Country = 'IN' )
left outer join I_RegionText as c on ( c.Region = a.Ship_Region and c.Language = 'E' and c.Country = 'IN')
left outer join I_DeliveryDocument as d on ( d.DeliveryDocument = a.Delivery )
//left outer join I_BillingDocument as b1 on ( b1.BillingDocument = a.BillingDocument )
left outer join I_BillingDocumentBasic as b1 on ( b1.BillingDocument = a.BillingDocument )
//left outer join I_AccountingDocumentJournal( P_Language: 'E' ) as F on (F.AccountingDocument = a.AccountingDocument)
left outer join I_BillingDocumentTypeText as G on (G.BillingDocumentType = a.BillingDocumentType)

{





@UI.selectionField: [{position: 1 }] 
@EndUserText.label: 'Billing Document'
@UI.lineItem: [{ position: 10 , label: 'Billing Document'  }]
key a.BillingDocument,
@EndUserText.label: 'CI Item NO'
@UI.lineItem: [{ position: 20 , label: 'CI Item NO'  }]
key a.BillingDocumentItem,
 @UI.selectionField: [{position: 8 }]
@EndUserText.label: 'Billing Type'
@UI.lineItem: [{ position: 30 , label: 'Billing Document Type'  }]
 key a.BillingDocumentType,
  
@EndUserText.label: 'Accounting Doc Type'
@UI.lineItem: [{ position: 33 , label: 'Accounting Doc Type'  }]
//  F.AccountingDocumentType,
key case a.BillingDocumentType
  when 'CBRE' then 'RV'
  when 'F2'   then 'RV'
  when 'G2'   then 'DG'
  when 'JSTO' then 'RV'
  when 'L2'   then 'SD'
  when 'S1'   then 'RV'
  when 'S2'   then 'RV'
  else 'UNKNOWN'
end as AccountingDocType,

  
  
  @EndUserText.label: 'Billing Document Type Description'
@UI.lineItem: [{ position: 36 , label: 'Billing Document Type Description'  }]
 key G.BillingDocumentTypeName,
  
    
  
  
  
@UI.lineItem: [{ position: 38 , label: 'Government Supply Type'  }]

@EndUserText.label: 'Government Supply Type'
 key case a.BillingDocumentType
  when 'CBRE' then 'CR'
  when 'F2'   then 'INV'
  when 'F8'   then 'CHALAN'
  when 'G2'   then 'CR'
  when 'JSTO' then 'INV'
  when 'L2'   then 'DR'
  when 'S1'   then 'CAN'
  when 'S2'   then 'CAN'
  else 'UNKNOWN'
end as GovernmentSupplyType,

 
  
  
@UI.selectionField: [{position: 10 }]
//@Consumption.filter.mandatory: true
@EndUserText.label: 'Plant'
@UI.lineItem: [{ position: 40 , label: 'Plant'  }]   
@Consumption.valueHelpDefinition: [ { entity:  { name: 'ZPLANT_VALUE_HELP',element: 'Plant' } }] 
 key   a.Plant,
@EndUserText.label: 'ACCOUNTING DOC.NO.'
@UI.lineItem: [{ position: 50 , label: 'ACCOUNTING DOC.NO.'  }]    
 key   a.AccountingDocument,
   @EndUserText.label: 'PO NUMBER'
@UI.lineItem: [{ position: 60 , label: 'PO NUMBER'  }]
key    a.PurchaseOrderByCustomer,
  @EndUserText.label: 'PO DATE'
@UI.lineItem: [{ position: 70 , label: 'PO DATE'  }]  
 key   a.CustomerPurchaseOrderDate,
    @EndUserText.label: 'PO LINE ITEM NO'
@UI.lineItem: [{ position: 80 , label: 'PO LINE ITEM NO'  }]
 key   a.UnderlyingPurchaseOrderItem,
    @EndUserText.label: 'INV NO'
@UI.lineItem: [{ position: 90 , label: 'INV NO'  }]
  key  a.DocumentReferenceID,
  
   
    @EndUserText.label: 'Invoice Date'
    @Consumption.filter.mandatory: true
    @UI.selectionField: [{position: 2 }]
@UI.lineItem: [{ position: 95 , label: 'Invoice Date'  }]
@Consumption.filter.selectionType: #INTERVAL
  key  a.Postingdate,
  
    @EndUserText.label: 'ORIGINAL INVOICE NO'
@UI.lineItem: [{ position: 100 , label: 'ORIGINAL INVOICE NO'  }]
 key a.ReferenceSDDocument,
  
  
  
    @EndUserText.label: 'Billing Date'
//  @Consumption.filter.mandatory: true
    @UI.selectionField: [{position: 22 }]
@UI.lineItem: [{ position: 105 , label: 'ORIGINAL INVOICE DATE'  }]
key  a.BillingDocumentDate,
  
  @UI.selectionField: [{position: 6 }]
    @EndUserText.label: 'Payer'
@UI.lineItem: [{ position: 110 , label: 'CUSTOMER'  }]
  key  a.SoldToParty,
    @EndUserText.label: 'CUSTOMER NAME'
@UI.lineItem: [{ position: 120 , label: 'CUSTOMER NAME'  }]
  key  a.SoldToPartyName,
    @EndUserText.label: 'GST NO'
@UI.lineItem: [{ position: 130 , label: 'GST NO'  }]
  key  a.Sold_GstNo,
    @EndUserText.label: 'STATE CODE'
@UI.lineItem: [{ position: 140 , label: 'STATE CODE'  }]
 key   a.SoldStateCode,
    @EndUserText.label: 'STATE CODE DES.'
@UI.lineItem: [{ position: 150 , label: 'STATE CODE DES.'  }]
  key  b.RegionName as State_Name,
     
    @EndUserText.label: 'Ship to Party Code'
@UI.lineItem: [{ position: 160 , label: 'Ship to Party Code'  }]
 key   a.ShipToParty,
    @EndUserText.label: 'SHIP-TO-PARTY NAME'
@UI.lineItem: [{ position: 170 , label: 'SHIP-TO-PARTY NAME'  }]
 key   a.ShipToPartyName,
  @EndUserText.label: 'SHIP-TO-PARTY GST NO'
@UI.lineItem: [{ position: 180 , label: 'SHIP-TO-PARTY GST NO'  }]  
 key   a.Ship_Gstno,
    @EndUserText.label: 'SHIP-TO-PARTY NAME STATE CODE'
@UI.lineItem: [{ position: 190 , label: 'SHIP-TO-PARTY NAME STATE CODE'  }]
 key   a.Ship_Region,
    @EndUserText.label: 'SHIP-TO-PARTY NAME STATE CODE DES.'
@UI.lineItem: [{ position: 200 , label: 'SHIP-TO-PARTY NAME STATE CODE DES.'  }]
 key   c.RegionName as ShipRegionName,
    
    @EndUserText.label: 'HSN CODE'
@UI.lineItem: [{ position: 210 , label: 'HSN CODE'  }]
 key   a.HsnCode,
      @UI.selectionField: [{position: 5 }]
    @EndUserText.label: 'Material'
@UI.lineItem: [{ position: 220 , label: 'Material'  }]
 key   a.Product,
    @EndUserText.label: 'Material Description'
@UI.lineItem: [{ position: 230 , label: 'Material Description'  }]
 key   a.ProductDescription,
    @EndUserText.label: 'CUSTOMER ITEM CODE'
@UI.lineItem: [{ position: 240 , label: 'CUSTOMER ITEM CODE'  }]
  key  a.MaterialByCustomer,
    
    
      @EndUserText.label: 'GL Code'
      @UI.selectionField: [{position: 12 }]
@UI.lineItem: [{ position: 245 , label: 'G/L Number'  }]
  key   a.PP,          //    a.GLAccount,
    
         @EndUserText.label: 'G/L Description'
@UI.lineItem: [{ position: 250 , label: 'G/L Description'  }] 
 key   a.GLAccountName,
    
    
    @Aggregation.default: #SUM
    @EndUserText.label: 'QUANTITY'
//   @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit' 
@UI.lineItem: [{ position: 255 , label: 'QUANTITY'  }]

 
 key     cast( case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then

   -cast( a.BillingQuantity as abap.dec( 13, 3 ))
   else cast( a.BillingQuantity as abap.dec( 13, 3 )) 
    end  as abap.dec(15,2)) as   BillingQuantityNoUnit,
 

 
    @EndUserText.label: 'UOM'
@UI.lineItem: [{ position: 260 , label: 'UOM'  }]
  key  a.BillingQuantityUnit ,
//    @Semantics.amount.currencyCode: 'TransactionCurrency'
    @EndUserText.label: 'Basic Rate'
@UI.lineItem: [{ position: 270 , label: 'Basic Rate'  }]
 // a.basicrateinr1,                          //  a.BASICRATE, 
// CAST( a.basicrateinr1 AS DECIMAL( 15, 2 ) )  AS BasicRate,  

     
 key    cast
 (case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then  -a.basicrateinr1
     else a.basicrateinr1 end as 
     abap.dec(15,3)
) as BasicRate,
     
     

   
  
    @EndUserText.label: 'DOCUMENT CURR'
@UI.lineItem: [{ position: 275 , label: 'DOCUMENT CURR'  }]
  key  a.TransactionCurrency,
    
    
      @EndUserText.label: 'EXCHANGE RATE'
@UI.lineItem: [{ position: 278 , label: 'EXCHANGE RATE'  }]
  
 key    a.ExchangeRate as ExchangeRate ,
// key   cast( a.ExchangeRate as abap.dec( 15,2 )  ) as ExchangeRate ,
    
    
        
          @EndUserText.label: 'BASIC RATE IN INR'
@UI.lineItem: [{ position: 282 , label: 'BASIC RATE IN INR'  }]
//@Semantics.amount.currencyCode: 'TransactionCurrency'
 
     
 key      cast(
   case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then  -  a.BASIC_RATE_INR 
     else   a.BASIC_RATE_INR  
     end as abap.dec(15,3)
) as  BASIC_RATE_INR,
   
     
     


     
//       @Semantics.amount.currencyCode: 'discuky'
    @EndUserText.label: 'Discount'
@UI.lineItem: [{ position: 286 , label: 'Discount'  }]
 key  cast( a.Discount as abap.dec(15,2) ) as Discount,
//    @UI.hidden: true
// key   a.discuky,
    @EndUserText.label: 'Discount %'
@UI.lineItem: [{ position: 290 , label: 'Discount %'  }]
 key cast(  a.Discount_percentage as abap.dec(15,2) ) as Discount_percentage,
   
    
     @EndUserText.label: 'Final Basic Rate'
@UI.lineItem: [{ position: 294 , label: 'Final Basic Rate'  }]



key    case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then - cast( a.FINALBASICRATE as abap.dec(15,3)  ) 
     else  cast( a.FINALBASICRATE as abap.dec(15,3)  ) 
     end as FinalBasicRate,
     
  

  
    


 
    
          @EndUserText.label: 'BASIC/ASS. VALUE IN INR'
@UI.lineItem: [{ position: 300 , label: 'BASIC/ASS. VALUE IN INR'  }]

//key case
//      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
//     then           -cast(a.FinalBasicRate as abap.dec(15,2)) 
//                * cast(a.BillingQuantity as abap.dec(13,3)) 
// else 
//            cast(a.FinalBasicRate as abap.dec(15,2)) 
//     * cast(a.BillingQuantity as abap.dec(13,3)) 
//             end as BASICASSVALUEININR,
             
           
  key           cast( case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then           -cast(a.FINALBASICRATE as abap.dec(15,5)) 
                * cast(a.BillingQuantity as abap.dec(13,5)) 
 else 
            cast(a.FINALBASICRATE as abap.dec(15,5)) 
     * cast(a.BillingQuantity as abap.dec(13,5)) 
             end as  abap.dec( 15,3 ) ) as  BASICASSVALUEININR,



    
    
    @Semantics.amount.currencyCode: 'Tcuky'
    @EndUserText.label: 'CGST'
@UI.lineItem: [{ position: 310 , label: 'CGST'  }]
  key  a.cgst,
    @UI.hidden: true
 key   a.Tcuky,
    @EndUserText.label: 'CGST %'
@UI.lineItem: [{ position: 315 , label: 'CGST %'  }]
 key   a.Cgstper,
    @Semantics.amount.currencyCode: 'sgstcuky'
    @EndUserText.label: 'SGST'
@UI.lineItem: [{ position: 320, label: 'SGST'  }]
  key  a.Sgsramt,
    @UI.hidden: true
 key   a.sgstcuky,
    @EndUserText.label: 'SGST %'
@UI.lineItem: [{ position: 325 , label: 'SGST %'  }]
key    a.Sgstper,
    @Semantics.amount.currencyCode: 'IGSTamtcuky'
    @EndUserText.label: 'IGST'
@UI.lineItem: [{ position: 330 , label: 'IGST'  }]
 key   a.IGSTamt,
    @UI.hidden: true
key    a.IGSTamtcuky,
    @EndUserText.label: 'IGST %'
@UI.lineItem: [{ position: 340 , label: 'IGST %'  }]
  key  a.IGSTper,
    @Semantics.amount.currencyCode: 'GrossCuky'
    @EndUserText.label: 'GROSS TOTAL'
    @UI.lineItem: [{ position: 350 , label: 'GROSS TOTAL'  }]
//    a.Grosstotal,
 key case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then  -a.Grosstotal
     else a.Grosstotal
     end as Grosstotal,

    
    @UI.hidden: true
  key  a.GrossCuky,
    @Semantics.amount.currencyCode: 'tdscuky'
    @EndUserText.label: 'TCS VALUE'
@UI.lineItem: [{ position: 360 , label: 'TCS VALUE'  }]
 key   a.ConditionAmount as TcsAmt,
    @EndUserText.label: 'TCS %'
@UI.lineItem: [{ position: 363 , label: 'TCS %'  }]
//key    a.tcspercentage,
key cast( a.tcspercentage as abap.dec( 15, 2) ) as tcspercentage ,
    @UI.hidden: true
  key  a.tdscuky,

          @EndUserText.label: 'GROSS AMOUNT INCL TCS'
@UI.lineItem: [{ position: 366 , label: 'GROSS AMOUNT INCL TCS'  }]


key case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then 
            -cast(a.Grosstotal as abap.dec(13,3))+ coalesce(cast(a.ConditionAmount as abap.dec(13,3)), 0) 
      else 
             cast(a.Grosstotal as abap.dec(13,3))+ coalesce(cast(a.ConditionAmount as abap.dec(13,3)), 0) 
     end as GrossAmountInclTCS,
     
     
    
     
      

    @EndUserText.label: 'ACCOUNT ASSIGNMENT G'
@UI.lineItem: [{ position: 367 , label: 'ACCOUNT ASSIGNMENT G'  }]
  key a.MatlAccountAssignmentGroup,
    @EndUserText.label: 'EWAY Bill No'
@UI.lineItem: [{ position: 370 , label: 'EWAY Bill No'  }]
 key   a.EwayBill,
    @EndUserText.label: 'EWAY Bill Date'
@UI.lineItem: [{ position: 380 , label: 'EWAY Bill Date'  }]
key    a.Ewaybilldate,
    @EndUserText.label: 'IRN No'
@UI.lineItem: [{ position: 390 , label: 'IRN No'  }]
key    a.Irn,
    @EndUserText.label: 'IRN date'
@UI.lineItem: [{ position: 400 , label: 'IRN date'  }]
 key   a.Irndate,
    
    
     @EndUserText.label: 'PACKING DETAILS'
@UI.lineItem: [{ position: 405 , label: 'PACKING DETAILS'  }]
 key   d.YY1_packingdetails_DLH,
    
    @EndUserText.label: 'Delivery Document No.'
@UI.lineItem: [{ position: 410 , label: 'Delivery Document No'  }]
 key   a.Delivery,
    @EndUserText.label: 'Delivery date'
@UI.lineItem: [{ position: 420 , label: 'Delivery date'  }]
 key   d.DeliveryDate,
    @EndUserText.label: 'UNLOADING POINT'
@UI.lineItem: [{ position: 430 , label: 'UNLOADING POINT'  }]
 key   a.UnloadingPoint ,
    @EndUserText.label: 'EDI Number'
@UI.lineItem: [{ position: 440 , label: 'EDI Number'  }]
  key  b1.YY1_EDInumber_BDH   ,
    @EndUserText.label: 'ACCEPTED QUANTITY'
@UI.lineItem: [{ position: 445 , label: 'ACCEPTED QUANTITY'  }]
  key  cast( a.ActualDeliveryQuantity as abap.dec( 13, 3 )) as ActualDeliveryQuantity,
     @EndUserText.label: 'Delivery Qty.'
@UI.lineItem: [{ position: 450 , label: 'Delivery Qty.'  }]
 key   cast( a.OriginalDeliveryQuantity as abap.dec( 13, 3 )) as OriginalDeliveryQuantity,
    
    
    @EndUserText.label: 'Sale Order Number'
@UI.lineItem: [{ position: 453 , label: 'Sale Order Number'  }]
 key   a.SalesDocument, 
   
@EndUserText.label: 'GROSS WEIGHT PER QTY UOM'
@UI.lineItem: [{ position: 456 , label: 'GROSS WEIGHT PER QTY UOM'  }]
//    a.GrossWeightPerQty,
key  case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then -a.GrossWeightPerQty
     else a.GrossWeightPerQty
     end as GrossWeightPerQty,

    
    
    
//    @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
//    @EndUserText.label: 'TOTAL GROSS WEIGHT PER QTY UOM'
//@UI.lineItem: [{ position: 458 , label: 'TOTAL GROSS WEIGHT PER QTY UOM'  }]
//    cast(a.ItemGrossWeight as abap.dec( 13, 3 )) as ItemGrossWeight,


@EndUserText.label: 'TOTAL GROSS WEIGHT PER QTY UOM'
@UI.lineItem: [{ position: 458 , label: 'TOTAL GROSS WEIGHT PER QTY UOM'  }]
key  case
 when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
   then 
-cast( a.OriginalDeliveryQuantity as abap.dec(13,3) ) 
   * cast( a.GrossWeightPerQty as abap.dec(13,3) ) 
   else
                 cast( a.OriginalDeliveryQuantity as abap.dec(13,3) ) 
            * cast( a.GrossWeightPerQty as abap.dec(13,3) ) 
             end  as TotalGrossWeight,
//    @UI.hidden: true
//    a.ItemWeightUnit,






//    case
//      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
//     then   -cast(a.ItemGrossWeight as abap.dec( 13, 3 )) 
//     else   cast(a.ItemGrossWeight as abap.dec( 13, 3 ))
//      end as ItemGrossWeight,
   
 


//    @EndUserText.label: 'NET WEIGHT PER QTY UOM'
//@UI.lineItem: [{ position: 459 , label: 'NET WEIGHT PER QTY UOM'  }]
//    cast(a.NETWEIGHTPERQTY as abap.dec( 13, 3 )) as NETWEIGHTPERQTY,

//    @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
    @EndUserText.label: 'TOTAL NET WEIGHT PER QTY UOM'
@UI.lineItem: [{ position: 460 , label: 'TOTAL NET WEIGHT PER QTY UOM'  }]

  key  case
      when ( a.BillingDocumentType = 'S1' or a.BillingDocumentType = 'S2' or a.BillingDocumentType = 'G2'  or a.BillingDocumentType = 'CBRE' )
     then  -cast(a.ItemNetWeight as abap.dec( 13, 3 ))
     else cast(a.ItemNetWeight as abap.dec( 13, 3 ))
     end as ItemNetWeight,
    

    
    
    @EndUserText.label: 'WEIGHT UOM'
@UI.lineItem: [{ position: 461 , label: 'WEIGHT UOM'  }]
key    a.uom,
  
    @Semantics.amount.currencyCode: 'Fcuky'
    @EndUserText.label: 'Freight Amount'
@UI.lineItem: [{ position: 470 , label: 'Freight Amount'  }]
  key  a.FreightAmount,
    @UI.hidden: true
key    a.Fcuky,
    @EndUserText.label: '% Packing charges'
@UI.lineItem: [{ position: 471 , label: '% Packing charges'  }]
key    a.packingchargepercentage,

    @Semantics.amount.currencyCode: 'Packingchargecurrecncy'
    @EndUserText.label: 'Packing Charges Amount'
@UI.lineItem: [{ position: 473 , label: 'Packing Charges Amount'  }]
  key  a.Packingchargeamount,
    @UI.hidden: true
  key  a.Packingchargecurrecncy,
     @Semantics.amount.currencyCode: 'lumcuky'
    @EndUserText.label: 'Lum sum packing'
@UI.lineItem: [{ position: 475 , label: 'Lum sum packing'  }]
 key   a.lum_conditionAmount,
    @UI.hidden: true
 key   a.lumcuky,
    @EndUserText.label: 'STREET'
@UI.lineItem: [{ position: 480 , label: 'STREET'  }]
 key   a.StreetName,
    @EndUserText.label: 'CITY'
@UI.lineItem: [{ position: 490 , label: 'CITY'  }]
 key   a.CityName,
    @EndUserText.label: 'POST CODE'
@UI.lineItem: [{ position: 500 , label: 'POST CODE'  }]
 key   a.PostalCode,
    @EndUserText.label: 'COUNTRY'
@UI.lineItem: [{ position: 510 , label: 'COUNTRY'  }]
 key   a.Country,
    @UI.selectionField: [{position: 9 }]
 @Consumption.filter.mandatory: true
    @EndUserText.label: 'Sales Organization'
@UI.lineItem: [{ position: 520 , label: 'Sales Org'  }]
 @Consumption.valueHelpDefinition: [ { entity:  { name:    'ZSALES_ORGANISATION',element: 'SalesOrganization' } }]
key    a.SalesOrganization,
    @EndUserText.label: 'DistribChannelorder '
    @UI.selectionField: [{position: 3 }]
@UI.lineItem: [{ position: 530 , label: 'Dist Channel'  }]
 key   a.DistributionChannel,
    @EndUserText.label: 'DChannel Desc'
@UI.lineItem: [{ position: 540 , label: 'DChannel Desc'  }]
 key   a.DistributionChannelName,
      @UI.selectionField: [{position: 4 }]
    @EndUserText.label: 'Division'
@UI.lineItem: [{ position: 550 , label: 'Division'  }]
 key   a.Division,
    @EndUserText.label: 'Division Desc'
@UI.lineItem: [{ position: 560 , label: 'Division Desc'  }]
 key   a.DivisionName,
    @EndUserText.label: 'TRANSPOTER NAME'
@UI.lineItem: [{ position: 570 , label: 'TRANSPOTER NAME'  }]
 key   d.YY1_Transportername_DLH,
    @EndUserText.label: 'VEHICLE NO'
@UI.lineItem: [{ position: 580 , label: 'VEHICLE NO'  }]
 key   d.YY1_vehicleno_DLH,
    @EndUserText.label: 'CREATED BY'
@UI.lineItem: [{ position: 590 , label: 'CREATED BY'  }]
 key   a.CreatedByUser,
    @EndUserText.label: 'Created On'
@UI.lineItem: [{ position: 600 , label: 'Created On'  }]
 key   a.CreationDate,
    @EndUserText.label: 'TRANSACTION TIME'
@UI.lineItem: [{ position: 610 , label: 'TRANSACTION TIME'  }]
 key   a.CreationTime,
    @EndUserText.label: 'EPCG LIC NO'
@UI.lineItem: [{ position: 615 , label: 'EPCG LIC NO'  }]
 key   b1.YY1_EPCGLICNo_BDH ,
    
     @EndUserText.label: 'EPCG LIC DATE'
@UI.lineItem: [{ position: 620 , label: 'EPCG LIC DATE'  }]
  key  b1.YY1_Dated_BDH,
    @EndUserText.label: 'Mode Of Trnsprt-Bord'
@UI.lineItem: [{ position: 630 , label: 'Mode Of Trnsprt-Bord'  }]
 key   cast(case b1.YY1_ModeOfTrnsprtBorde_BDH
    when '1'
     then 'Sea'
     when '2'
      then 'Rail'
      when '3'
       then 'Road'
       when '4'
        then 'Air'
        when '5'
         then 'Mail'
         else ''
          end as abap.char(5)) as YY1_ModeOfTrnsprtBorde_BDH ,
    @EndUserText.label: 'Domest Mode Of Trans'
@UI.lineItem: [{ position: 640 , label: 'Domest Mode Of Trans'  }]
 key   cast(case b1.YY1_DomestModeOfTransp_BDH 
        when '1'
        then 'Sea'
        when '2'
        then 'Rail'
        when '3'
        then 'Road'
        when '4'
        then 'Air'
        when '5'
         then 'Mail' end  as abap.char(5)) as YY1_DomestModeOfTransp_BDH ,
    @EndUserText.label: 'Export Customs off'
@UI.lineItem: [{ position: 650 , label: 'Export Customs off'  }]
 key   b1.YY1_ExportCustomsoff_BDH,
    @EndUserText.label: 'Office of Exit'
@UI.lineItem: [{ position: 660 , label: 'Office of Exit'  }]

key    cast(case  b1.YY1_OfficeOfExit_BDH
     when '001'
      then 'NavaSheva'
      when '002'
       then 'Mumbai-india'
       when '003'
       then 'Ahmedabad-India' end as abap.char(20)) as  YY1_OfficeOfExit_BDH ,
    @EndUserText.label: 'Office Of Destinatio'
@UI.lineItem: [{ position: 670 , label: 'Office Of Destinatio'  }]
 key   b1.YY1_OfficeOfDestinatio_BDH ,
    @EndUserText.label: 'Country of Final Des'
@UI.lineItem: [{ position: 680 , label: 'Country of Final Des'  }]
 key   b1.YY1_CountryofFinalDest_BDH
 

 

    
    
    
}  


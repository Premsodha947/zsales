@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ACCEPT QTY'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSALES_ACCEPT_QTY as select from I_BillingDocumentItem as a 
   left outer join I_DeliveryDocumentItem as b on ( b.DeliveryDocument = a.ReferenceSDDocument and b.DeliveryDocumentItem = a.ReferenceSDDocumentItem )
{
  key  a.BillingDocument,
  key  a.BillingDocumentItem,
       b.DeliveryQuantityUnit,
       @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
       b.ActualDeliveryQuantity,
       @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
       b.OriginalDeliveryQuantity,
       b.ItemWeightUnit
} 

 
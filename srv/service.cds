//using { PurchaseOrder } from './external/PurchaseOrder.cds'; 
//using { BusinessPartnerA2X as bupa } from './external/BusinessPartnerA2X.cds'; 
using { demouser01 as my } from '../db/schema.cds';

@path: '/service/demouser01'
@requires: 'authenticated-user'
service demouser01Srv {
  @odata.draft.enabled
  entity Incidents as projection on my.Incidents;
  @odata.draft.enabled
  entity Customers as projection on my.Customers;

  @readonly
  entity Suppliers as projection on my.Suppliers;    

  @readonly
  entity PurchaseOrders as projection on my.PurchaseOrders;    


  annotate my.Incidents {
    customer @changelog: [customer.name];
    title    @changelog;
    status   @changelog; 
  }  

  annotate my.Customers with @PersonalData : {
    DataSubjectRole : 'Customer',
    EntitySemantics : 'DataSubject'
  } {
    ID           @PersonalData.FieldSemantics: 'DataSubjectID';
    firstName    @PersonalData.IsPotentiallyPersonal;
    lastName     @PersonalData.IsPotentiallyPersonal;
    email        @PersonalData.IsPotentiallyPersonal;
    creditCardNumber @PersonalData.IsPotentiallySensitive;
  };

}
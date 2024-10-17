using { PurchaseOrder as po} from '../srv/external/PurchaseOrder.cds'; 
using { BusinessPartnerA2X as bupa } from '../srv/external/BusinessPartnerA2X.cds'; 
namespace demouser01;
using { cuid, managed } from '@sap/cds/common';
using { Attachments } from '@cap-js/attachments';

@assert.unique: { title: [title] }
entity Incidents : cuid, managed {
  title: String(100) @mandatory;
  urgency: String(20);
  status: String(20);
  customerEmail: String(100);
  attachments: Composition of many Attachments;
  conversations: Composition of many Conversations on conversations.incident = $self;
  customer: Association to Customers;

}

entity Conversations : cuid {
  timestamp: DateTime;
  author: String(100);
  message: String(500);
  incident: Association to Incidents;
}

@assert.unique: { email: [email] }
entity Customers : cuid {
  firstName: String(50);
  lastName: String(50);
  name : String(100) = (firstName || ' ' || lastName);
  phoneNumber: String(15);
  email: String(100) @mandatory;
  creditCardNumber: String(16);
  incidents: Association to many Incidents on incidents.customer = $self;
}


entity Suppliers as projection on bupa.A_BusinessPartner {
        key BusinessPartner as ID,
        BusinessPartnerFullName as fullName,
        BusinessPartnerIsBlocked as isBlocked,
}

entity PurchaseOrders as projection on po.PurchaseOrder {
        key PurchaseOrder,
        PurchaseOrderType as Potype,
        Supplier as Supplier,
        CompanyCode as Comcode
}
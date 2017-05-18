# 9 Use of Identifiers 

Identification Schemes constrain the possible Values of UBL Elements. Identifiers have no meaning except to uniquely identify an object. Table 4 categorises some of the possible Identification Schemes for Identifiers that may be used in eInvoice Documents. 

*Table 4: Possible Identification Functions*

| | | | |
| --- |------- | --- |------- |
**Information Element** |**UBL Element**|**Definition**| **Possible Identification Schemes**| 
Invoice Identifier | cbc:ID | The Identifier for the Invoice. | Issued by Supplier |
Document Reference Identifier | cac: DocumentReference/cbc:ID | An Identifiers for the referenced Document. | Issued by Document creator. |
Item Identifier | cac:Item/cac:ItemIdentification/cbc:ID | An Identifier for an Item | May be issued by Supplier, Buyer, manufacturer or issued by a third Party (e.g. a GTIN from GS1). |
Purchase Order Identifier | cac:OrderReference/cbc:ID | An Identifier for a Purchase Order | Issued by the Buyer. | 
Sales Order Identifier | cac:ORderReference/cbc:SalesOrderID | An Identifier for a Purchase Order, assigned by the Seller | Issued by the Supplier. | 
Control Identifier | cac:AccountingCustomerParty/cac:BuyerContact/cbc:ID | An Identifier for this contact | Mutually agreed by trading partners. |
Party Identifier | cac:Party/cac:PartyIdentification/cbc:ID | An Identifier for this Contact. | Mutually agreed by trading partners. | 
Party Company Identifier | cac:Party/cac:PartyLegalEntity/cbc:CompanyID | An identifier for the party as registered within a business registration scheme. | Australian Business Number (ABN) issued by ABR (Australia) |
Electronic Address | cac:Party/cbc:EndpointID | An Identifier for the end point of the routing Service. | Issued by the Service Provider. |
Taxation Branch Identifier | cac:Party/cac:PartyTaxScheme/cbc:CompanyID | An Identifier for the registered Branch of a Party that supplements the ABN as required for Tax reporting purposes (See 9.1, page 51). | A 3-digit value issued by the ATO (Australia. |
Tax Category Identifier | cac:TaxCategory/cbc:ID | An Identifier for a Tax Category | Issued by accounting software providers (Simpler BAS programme may provide these). |
Tax Scheme Identifier | cac:TaxScheme/cbc:ID | An Identifier for this Taxation Scheme. | Issued by the Austrlaian Taxation Office. |
Financial Institution Identifier |cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch | The office holding the Financial Institution Account. | BSB (Australia), BIC (International) | 
Payment Means Identifier | cac:PaymentMeans/cbc:ID | An Identifier for a means of payment. | Mutually agreed by trading partners. |
Payment Means Instruction Identifier | cac:PaymentMeans/cbc:InstructionID | An Identifier for a payment instruction. | Issued by the Financial Institution. |
Financial Institution Account Identifier | cac:FinancialAccount/cbc:ID | The Identifier for this Financial Account for example, the bank account number. | Account Number (Australia), IBAN (International) |
Financial Institution Account. | BSB (Australia), BIC (International) |

## 9.1 Identifying a Tax Branch 

Under section 54-50 of the GST Act, a branch of a Party can be registered with the ATO (Australian Government, 1999). The branch receives a 3-digit representing this registration. All Tax Invoices issued by the branch must include the Taxation Branch Identifier in addition to the Australian Business Number for all of the Branch’s Tax Invoices, even when Invoicing the parent Party. 

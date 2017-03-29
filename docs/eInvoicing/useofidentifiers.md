# 9 Use of Identifiers 

Identification Schemes constrain the possible Values of UBL Elements. Identifiers have no meaning except to uniquely identify an object. Table 4 categorises some of the possible Identification Schemes for Identifiers that may be used in eInvoice Documents. 

*Table 4: Possible Identification Schemes*

| | | | |
| --- |------- | --- |------- |
**Information Element** |**UBL Element**|**Definition**| **Possible Identification Schemes**| 
Invoice Identifier | cbc:ID | The Identifier for the Invoice. | Issued by Supplier |
Financial Institution Identifier |cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch | The office holding the Financial Institution Account. | BSB (Australia), BIC (International) |
Contact Identifier | cac:AccountingCustomerParty/cac:BuyerContact /cbc:ID | An Identifier for this Contact. | Mutually agreed by trading partners. |
Document Reference Identifier | cac:DocumentReference/cbc:ID | An Identifier for the referenced Document. | Issued by Document creator. |
Financial Institution Account Identifier | cac:FinancialAccount/cbc:ID | The Identifier for this Financial Account for example, the bank account number. | Account Number (Australia), IBAN (International). |
Item Identifier | cac:Item/cac:ItemIdentification/cbc:ID | An Identifier for an Item. | May be issued by Supplier, Buyer, manufacturer or issued by a third Party (e.g. a GTIN from GS1). 
Purchase Order Identifier | cac:OrderReference/cbc:ID | An Identifier for a Purchase Order. | Issued by the Buyer. |
Sales Order Identifier | cac:OrderReference/cbc:SalesOrderID | An Identifier for a Purchase Order, assigned by the Seller. | Issued by the Supplier. |
Electronic Address | cac:Party/cbc:EndpointID | An Identifier for the end point of the routing Service. | Issued by the Service provider. |
Party Identifier | cac:Party/cac:PartyIdentification/cbc:ID | An Identifier for the Party. | Mutually agreed by trading partners. |
Party Company Identifier | cac:Party/cac:PartyLegalEntity/cbc:CompanyID | An Identifier for the Party as registered within a business registration scheme. | Australian Business Number (ABN) issued by ABR (Australia). |
Taxation Branch Identifier | cac:Party/cac:PartyTaxScheme/cbc:CompanyID | An Identifier for the registered Branch of a Party that supplements the ABN as required for Tax reporting purposes. (See 9.1) | A 3-digit value issued by the ATO (Australia). |
Payment Means Identifier | cac:PaymentMeans/cbc:ID | An Identifier for a means of payment. | Mutually agreed by trading partners. |
Payment Means Instruction Identifier | cac:PaymentMeans/cbc:InstructionID | An Identifier for a payment instruction. | Issued by the Financial Institution. |
Tax Category Identifier | cac:TaxCategory/cbc:ID | An Identifier for a Tax Category. | Issued by accounting software providers (Simpler BAS programme may provide these) |
Tax Scheme Identifier | cac:TaxScheme/cbc:ID | An Identifier for this Taxation scheme. | Issued by Australian Taxation Office. |



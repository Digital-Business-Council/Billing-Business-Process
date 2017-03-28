# 7 Business Processes 

Business process activity flows are provided to assist in understanding the context of use for eInvoicing Documents. These processes are indicative only and not a Mandatory requirement for using eInvoicing. It is understood that many variants on these processes exist. 

The purpose of providing these process descriptions is to inform Implementers of the context in which these documents are used and not to suggest these are the only processes in which they are used. 

## 7.1 Invoicing 

This section describes a generic Invoicing process, where a Supplier (Accounts Receivable) issues an Invoice to a Buyer of goods or services (Accounts Payable). Figure 2 describes the flow of a common Invoicing process. 

![BPinvoicingprocess_Logo](/images/BPinvoicingprocess.PNG)

### 7.1.1 Tax Invoices 

Tax Invoices are defined by law and need to be retained in order for a business to claim GST credits on purchases and demonstrate the amount of GST that has been collected by the business during the sale of Taxable supplies. 

Tax Invoices in Australia have various requirements set out in the GST Act and GST rulings made by the Australian Taxation Office (Australian Government, 1999) (Australian Government, 2013). These requirements can be found here: 
https://www.ato.gov.au/Business/GST/Issuing-tax-invoices/ 

eInvoices that support the eInvoicing Semantic Model (Digital Business Council, 2016c) and this Implementation Guide provide for these requirements. 

### 7.1.2 Recipient Created Tax Invoicing (RCTI) 

Recipient Created Tax Invoicing is a specialised type of Invoicing process. With RCTIs the Tax Invoice is issued by the Party receiving the goods and services rather than the Supplier. 

## 7.2 Adjustment Invoicing 

After an eInvoice is created, it is sometimes necessary to adjust the information. For example, an adjustment may be needed when: 

There is an error in the relevant Invoice, for example it is to the wrong Buyer, at the wrong time or the wrong amount was charged; 

     • The Amount of the original Invoice no longer reflects the amount the Buyer owes, for example due to Items being returned or a dispute about Items provided; or 
     
     • The supply becomes Taxable or stops being Taxable. 

Two common processes for adjustment Invoicing are described below. 

### 7.2.1 Credit Notes 

The Supplier may create and issue a Credit Note that acts as a ‘negative Invoice’ to offset a previous Invoice. 
Credit Notes may also be known as Adjustment Notes for Tax reporting purposes (Australian Government, 1999) and ATO GST ruling GSTR 2013/2 (Australian Government, 2013). 

### 7.2.2 Copy, Duplicate and Replacement Invoices 

After an Invoice has been received, additional versions of the Invoice may be sent. 

A copy of the original Invoice may be sent. 

A duplicate Invoice may be sent accidentally. 

A replacement Invoice, with different details, may be sent to replace an existing Invoice. 

The eInvoicing Implementation Guide recognises these conditions of Invoicing but does not prescribe how these processes are managed. These are defined by business arrangements between Suppliers and Buyers. 


## 7.3 Acknowledging Invoices 

With an eInvoicing process it is not uncommon for the recipient (e.g. Buyer) to respond to the eInvoice by sending an acknowledgement in the form of a Response document (see Section 8.4). 

Figure 3 describes the flow of a common eInvoicing process with an acknowledgement. 

![BPaccknowledgeinvoiceprocess_logo](/images/BPaccknowledgeinvoiceprocess.PNG)

Note: Responses may also be sent to acknowledge Recipient Created Tax Invoices and Credit Notes. 

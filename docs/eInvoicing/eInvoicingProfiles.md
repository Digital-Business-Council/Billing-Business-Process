# 8 eInvoicing Profiles (Normative) 

This section defines the Profiles of the Data Formats to be used for XML Document exchanges as part of the eInvoicing process. 

Following from the eInvoicing Semantic Model (Digital Business Council, 2016c) the eInvoicing Profiles has been defined to include only the essential UBL Elements (the Core) that an eInvoicing Document needs to satisfy operational, financial and regulatory (e.g. GST) requirements. 

Core UBL Elements are those that business applications or Service Interfaces must be able to recognise if they appear in a Document. Not all Core UBL Elements need appear in all eInvoice Documents, these are noted as Optional in the Profile. Core UBL Elements noted as Mandatory in the Profile and must appear in every eInvoice Document. 

Using these Core UBL Elements for eInvoices means that businesses are able to: 

  a. Interpret and understand the meaning of the common, essential information on an eInvoice; and 

  b. Inform their software or Service providers to process these Core UBL Elements based on the eInvoicing Semantic Model (Digital Business Council, 2016c). 
  
These Profiles are a conformant subset of the OASIS Universal Business Language (UBL) v2.1 (ISO/IEC 19845:2015) (OASIS UBL TC, 2013). XML Documents conforming to these Profiles also conform to the UBL standard. 

## 8.1 Document Constraints 

All XML Documents must conform the UBL rules for Document constraints (OASIS UBL TC, 2013). Specifically: 

*[IND5] UBL conformant instance documents MUST NOT contain an element devoid of content or containing null values, except in the case of extension, where the UBL Extension Content element is used.*

This means that a Mandatory UBL Element must not be empty. If they appear in an XML Document, Optional Elements must also not be empty. 

And: 

*[IND2] All UBL instance documents MUST identify their character encoding within the XML declaration.*

*[IND3] In conformance with ISO IEC ITU UN/CEFACT eBusiness Memorandum of Understanding Management Group (MOUMG) Resolution 01/08 (MOU/MG01n83) as agreed to by OASIS, all UBL SHOULD be expressed using UTF-8.*


## 8.2 Diagram Notation 

The remainder of this section provides a description of the UBL Elements within the eInvoice Schemas. 

The diagramming notation used has the following key: 

- Mandatory Element 

![mandatory_Logo](/images/mandatory.PNG)

- Optional Element 

![optional_Logo](/images/optional.PNG )






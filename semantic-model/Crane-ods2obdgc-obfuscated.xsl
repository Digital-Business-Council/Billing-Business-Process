<?xml version="1.0" encoding="UTF-8"?>
<!--
Crane-ods2obdgc-obfuscated.xsl

This is a stylesheet to convert instances of spreadsheet ODS binary or
ODS XML into a genericode file suitable for processing according to the
OASIS Business Document (OBD) Naming and Design Rules (NDR).

Copyright (C) - Crane Softwrights Ltd. 
              - http://www.CraneSoftwrights.com/links/training-gctk.htm

Portions copyright (C) - OASIS Open 2015. All Rights Reserved.
                       - http://www.oasis-open.org/who/intellectualproperty.php

This documentation and the URI resolution of the XSLT processor both presume
the use of the free Saxon9HE XSLT processor from http://saxon.sf.net ... if
that XSLT 2.0 processor is not being used, then the results may not be as
expected.

Input file (choose one of the following three options):

 (a) -s:{filename} - an XML file listing as the input invocation argument
       that lists the directories and files in which to find the names of
       ODS binary files to be amalgamated into a single output file (see
       below for a copy of the ubl21files.xml example file)
 (b) -it:ods-uri ods-uri={filename} - both arguments needed for an ODS
       binary file name invocation parameter
 (c) -s:{filename} - an ODS XML file as the input invocation argument

Additional invocation arguments:

 - stylesheet file:            -xsl:Crane-ods2obdgc-obfuscated.xsl
 - output genericode file:     -o:{filename}
 
Additional optional invocation parameters:

 - add row as a column value:  row-number-column-name={string}
   - use this argument to add the row number of each row as a genericode
     column simple value, by naming the new column to be added

 - identification metadata:    identification-uri={filename}
   - an XML document to use in place of defaulted metadata; the file is
     of the form of the identification element:

    <Identification>
      <ShortName>OBDNDRSkeleton</ShortName>
      <LongName>OASIS Business Document NDR skeleton genericode file</LongName>
      <Version>1</Version>
      <CanonicalUri>urn:X-CraneSoftwrights.com</CanonicalUri>
      <CanonicalVersionUri>urn:X-CraneSoftwrights.com</CanonicalVersionUri>
    </Identification>

     (note that a relative URI is relative to the stylesheet, not the data;
      use an absolute URI to avoid using a relative URI)

 - indentation of the result:  indent=yes/no (default 'yes')
 
 - indication of raw output:   raw-sheet-long-name={long name of sheet field}
   - the raw output is used when the output is not destined for the OBD NDR
   - the raw output has no key fields and all fields are marked as optional
   - the raw sheet long name, and the derived short name, are used as column
     identifiers for the sheet name value
   - set the raw sheet long name to the empty string to suppress output of the
     sheet name value

 - massaging worksheet names:  lengthen-model-name-uri={filename}
   this points to an XML document with regular expressions used to reverse
   the act of shortening worksheet names; the example in the file (copied
   below) massageModelName-2.1.xml illustrates the shortening and lengthening
   of names to sidestep the bug in Google Docs (see *)

Spreadsheet assumptions:

Each worksheet tab of the spreadsheet is assumed to be a separate model.  The 
first row of the worksheet tab is assumed to be item headings.  The order of 
the columns is not significant.  Empty rows are ignored.  A row whose entire 
text content of the concatenation of all columns is the word "END" signals 
that any subsequent rows are ignored because they are documentary.

Note that if your spreadsheet is in Microsoft Excel format it can be translated
into OpenDocument Format Spreadsheet (ODS) by one of these free approaches:

 (a) - uploading the XLS to Google Drive, opening the spreadsheet on Google,
       then using File/"Download as..." as an "OpenDocument format (.ods)" file
       unless the worksheet names are longer than 31 characters (see *)
 (b) - use the http://www.CraneSoftwrights.com/resources/index.htm#xls2ods2xml
       package after installing it in Open Office

Google Docs:

*  As of April 2016 Google Docs has a bug in that it imports worksheet
   names longer than 31 characters but truncates those names to 31 characters
   when exporting as an ODS file.  Even when this bug is repaired, the maximum
   sheet name appears to be 50 characters.  The special massaging will be
   needed for document type names that are longer than worksheet name limits.


The specification for OASIS genericode is here:

    http://docs.oasis-open.org/codelist/genericode
    
The rows of the spreadsheet are converted into rows of genericode, stopping
at either the end of the spreadsheet worksheet or at the row whose entire
content is the word "END" (whichever comes first).

THE AUTHOR MAKES NO REPRESENTATION ABOUT THE SUITABILITY OF THIS CODE FOR ANY
PURPOSE. THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR 
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN 
NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

TECHNICAL NOTE:

This stylesheet has been purposely obfuscated and all comments have been
removed.  Please respect our copyright and do not attempt to reverse 
engineer the techniques involved.

- - - - - - - - - - - - - - - - - - - -

Example input XML file of document names (included as ubl21files.xml):

<directory name=".">
  <directory name="maindoc">
    <file name="UBL-ApplicationResponse-2.1.ods"/>
    <file name="UBL-AttachedDocument-2.1.ods"/>
    <file name="UBL-AwardedNotification-2.1.ods"/>
    <file name="UBL-BillOfLading-2.1.ods"/>
    <file name="UBL-CallForTenders-2.1.ods"/>
    <file name="UBL-Catalogue-2.1.ods"/>
    <file name="UBL-CatalogueDeletion-2.1.ods"/>
    <file name="UBL-CatalogueItemSpecificationUpdate-2.1.ods"/>
    <file name="UBL-CataloguePricingUpdate-2.1.ods"/>
    <file name="UBL-CatalogueRequest-2.1.ods"/>
    <file name="UBL-CertificateOfOrigin-2.1.ods"/>
    <file name="UBL-ContractAwardNotice-2.1.ods"/>
    <file name="UBL-ContractNotice-2.1.ods"/>
    <file name="UBL-CreditNote-2.1.ods"/>
    <file name="UBL-DebitNote-2.1.ods"/>
    <file name="UBL-DespatchAdvice-2.1.ods"/>
    <file name="UBL-DocumentStatus-2.1.ods"/>
    <file name="UBL-DocumentStatusRequest-2.1.ods"/>
    <file name="UBL-ExceptionCriteria-2.1.ods"/>
    <file name="UBL-ExceptionNotification-2.1.ods"/>
    <file name="UBL-Forecast-2.1.ods"/>
    <file name="UBL-ForecastRevision-2.1.ods"/>
    <file name="UBL-ForwardingInstructions-2.1.ods"/>
    <file name="UBL-FreightInvoice-2.1.ods"/>
    <file name="UBL-FulfilmentCancellation-2.1.ods"/>
    <file name="UBL-GoodsItemItinerary-2.1.ods"/>
    <file name="UBL-GuaranteeCertificate-2.1.ods"/>
    <file name="UBL-InstructionForReturns-2.1.ods"/>
    <file name="UBL-InventoryReport-2.1.ods"/>
    <file name="UBL-Invoice-2.1.ods"/>
    <file name="UBL-ItemInformationRequest-2.1.ods"/>
    <file name="UBL-Order-2.1.ods"/>
    <file name="UBL-OrderCancellation-2.1.ods"/>
    <file name="UBL-OrderChange-2.1.ods"/>
    <file name="UBL-OrderResponse-2.1.ods"/>
    <file name="UBL-OrderResponseSimple-2.1.ods"/>
    <file name="UBL-PackingList-2.1.ods"/>
    <file name="UBL-PriorInformationNotice-2.1.ods"/>
    <file name="UBL-ProductActivity-2.1.ods"/>
    <file name="UBL-Quotation-2.1.ods"/>
    <file name="UBL-ReceiptAdvice-2.1.ods"/>
    <file name="UBL-Reminder-2.1.ods"/>
    <file name="UBL-RemittanceAdvice-2.1.ods"/>
    <file name="UBL-RequestForQuotation-2.1.ods"/>
    <file name="UBL-RetailEvent-2.1.ods"/>
    <file name="UBL-SelfBilledCreditNote-2.1.ods"/>
    <file name="UBL-SelfBilledInvoice-2.1.ods"/>
    <file name="UBL-Statement-2.1.ods"/>
    <file name="UBL-StockAvailabilityReport-2.1.ods"/>
    <file name="UBL-Tender-2.1.ods"/>
    <file name="UBL-TendererQualification-2.1.ods"/>
    <file name="UBL-TendererQualificationResponse-2.1.ods"/>
    <file name="UBL-TenderReceipt-2.1.ods"/>
    <file name="UBL-TradeItemLocationProfile-2.1.ods"/>
    <file name="UBL-TransportationStatus-2.1.ods"/>
    <file name="UBL-TransportationStatusRequest-2.1.ods"/>
    <file name="UBL-TransportExecutionPlan-2.1.ods"/>
    <file name="UBL-TransportExecutionPlanRequest-2.1.ods"/>
    <file name="UBL-TransportProgressStatus-2.1.ods"/>
    <file name="UBL-TransportProgressStatusRequest-2.1.ods"/>
    <file name="UBL-TransportServiceDescription-2.1.ods"/>
    <file name="UBL-TransportServiceDescriptionRequest-2.1.ods"/>
    <file name="UBL-UnawardedNotification-2.1.ods"/>
    <file name="UBL-UtilityStatement-2.1.ods"/>
    <file name="UBL-Waybill-2.1.ods"/>
  </directory>
  <directory name="common">
    <file name="UBL-CommonLibrary-2.1.ods"/>
  </directory>
</directory>

Example input file of regular expressions to shorten or lengthen names:

<!- -
  $Id: massageModelName-2.1.xml,v 1.3 2015/05/06 14:49:29 admin Exp $
  
  Use this file to express the regular expressions that shorten model
  names in document order and lengthen model names in reverse document order.

  Use this expression in the mod/maindoc directory to establish which names
  need shortening to 31 characters or less:

ls *.ods | sed s/UBL-// | sed s/-2.1.ods// | sed -E "s/(.{1,31})(.*)/\1    \2/"

- ->
<!DOCTYPE modelNameMassage
[
<!ELEMENT modelNameMassage ( pass+ )>
<!ELEMENT pass ( shorten, lengthen )>
<!ELEMENT shorten EMPTY>
<!ELEMENT lengthen EMPTY>
<!ATTLIST shorten find CDATA #REQUIRED replace CDATA #REQUIRED>
<!ATTLIST lengthen find CDATA #REQUIRED replace CDATA #REQUIRED>
]>
<modelNameMassage>
  <pass>
    <shorten find="UBL-(.+)-2.1" replace="$1"/>
    <lengthen find="(.+)" replace="UBL-$1-2.1"/>
  </pass>
  <pass>
    <shorten find="Catalogue" replace="Ctlg"/>
    <lengthen find="Ctlg" replace="Catalogue"/>
  </pass>
  <pass>
    <shorten find="Transport([^a])" replace="Txp$1"/>
    <lengthen find="Txp" replace="Transport"/>
  </pass>
  <pass>
    <shorten find="Signature" replace="Sgnt"/>
    <lengthen find="Sgnt" replace="Signature"/>
  </pass>
  <pass>
    <shorten find="Confirmation" replace="Conf"/>
    <lengthen find="Conf" replace="Confirmation"/>
  </pass>
</modelNameMassage>


Crane-ods2odsgc.xsl $Id: Crane-ods2obdgc.xsl,v 1.1 2016/05/04 01:39:53 admin Exp $
gcExportSubset.xsl $Id: gcExportSubset.xsl,v 1.14 2015/06/24 01:00:22 admin Exp $
odsCommon.xsl $Id: odsCommon.xsl,v 1.18 2014/12/27 22:11:50 admin Exp $
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.CraneSoftwrights.com/ns/xslstyle" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" xmlns:c="urn:X-Crane:stylesheets:gc-toolkit" xmlns:o="urn:X-Crane:stylesheets:odf-access" xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" exclude-result-prefixes="xs xsd gc c o office table text" version="2.0"><xsl:param name="row-number-column-name" as="xsd:string?" select="()"/><xsl:param name="identification-uri" as="xsd:string?" select="()"/><xsl:param name="ods-uri" as="xsd:string?" select="()"/><xsl:param name="raw-sheet-long-name" as="xsd:string?" select="()"/><xsl:param name="indent" as="xsd:string" select="'yes'"/><xsl:function name="c:O1874087386" as="xsd:string?"><xsl:param name="c:O1874087386" as="xsd:string?"/><xsl:variable name="c:O1874087386" select="translate($c:O1874087386,'\','/')"/><xsl:sequence select="concat('jar:file:',$c:O1874087386,'!/content.xml')"/></xsl:function><xsl:template name="ods-uri"><xsl:variable name="c:I937043693" select="c:O1874087386($ods-uri)"/><xsl:variable name="c:I624695795" as="document-node()?"><xsl:if test="not(doc-available($c:I937043693))"><xsl:message terminate="yes"><xsl:text>The given URI "</xsl:text><xsl:value-of select="replace($ods-uri,'^jar:file:(/(.:))?(.*)!/content.xml$','$2$3')"/><xsl:text>" does not appear to </xsl:text><xsl:text>point to a ZIP package with a "content.xml" file.</xsl:text></xsl:message></xsl:if><xsl:sequence select="doc($c:I937043693)"/></xsl:variable><xsl:for-each select="$c:I624695795"><xsl:call-template name="c:O468521846"><xsl:with-param name="c:I374817477" select="$c:I624695795"/></xsl:call-template></xsl:for-each></xsl:template><xsl:template match="/" priority="1"><xsl:result-document indent="{if( lower-case($indent)=('y','yes') ) then 'yes' else 'no'}"><xsl:apply-templates/></xsl:result-document></xsl:template><xsl:template match="/directory" priority="3"><xsl:variable name="c:I374817477" as="document-node()*"><xsl:for-each select="//file"><xsl:variable name="c:I312347897" select="replace( resolve-uri(string-join(ancestor-or-self::*/@name,'/'),document-uri(/)), '^file:(/(.:))?','$2')"/><xsl:choose><xsl:when test="doc-available($c:I312347897)"><xsl:choose><xsl:when test="not(doc($c:I312347897)/ (office:document | office:document-content)/ office:body/office:spreadsheet/table:table)"><xsl:message terminate="yes"><xsl:text>The given URI "</xsl:text><xsl:value-of select="$c:I312347897"/><xsl:text>" does not appear to </xsl:text><xsl:text>point to an XML ODS file.</xsl:text></xsl:message></xsl:when><xsl:otherwise><xsl:sequence select="doc($c:I312347897)"/></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise><xsl:variable name="c:I267726769" select="c:O1874087386($c:I312347897)"/><xsl:choose><xsl:when test="not(doc-available($c:I267726769))"><xsl:message terminate="yes"><xsl:text>The given URI "</xsl:text><xsl:value-of select="$c:I312347897"/><xsl:text>" does not appear to </xsl:text><xsl:text>point to a binary ODF file.</xsl:text></xsl:message></xsl:when><xsl:when test="not(doc($c:I267726769)/ (office:document | office:document-content)/ office:body/office:spreadsheet/table:table)"><xsl:message terminate="yes"><xsl:text>The given URI "</xsl:text><xsl:value-of select="$c:I312347897"/><xsl:text>" does not appear to </xsl:text><xsl:text>point to a binary ODS file.</xsl:text></xsl:message></xsl:when><xsl:otherwise><xsl:sequence select="doc($c:I267726769)"/></xsl:otherwise></xsl:choose></xsl:otherwise></xsl:choose></xsl:for-each></xsl:variable><xsl:if test="count(//file) != count($c:I374817477)"><xsl:message terminate="yes"/></xsl:if><xsl:call-template name="c:O468521846"><xsl:with-param name="c:I374817477" select="$c:I374817477"/></xsl:call-template></xsl:template><xsl:template match="/office:document | /office:document-content" priority="2" name="c:O468521846"><xsl:param name="c:I374817477" select=".." as="document-node()+"/><xsl:variable name="c:I234260923" as="element(Column)*"><xsl:for-each-group group-by="." select="($c:I374817477/*/office:body/ office:spreadsheet/table:table//table:table-row)[1]/table:table-cell/text:p"><xsl:variable name="c:I208231931" select="normalize-space(current-grouping-key())"/><xsl:variable name="c:O187408738" select="replace($c:I208231931,'\W+','')"/><Column Id="{$c:O187408738}" Use="{if( $c:O187408738 = 'DictionaryEntryName' and                         empty( $raw-sheet-long-name ) )                      then 'required' else 'optional'}"><ShortName><xsl:value-of select="$c:O187408738"/></ShortName><LongName><xsl:value-of select="$c:I208231931"/></LongName><Data Type="string"/></Column></xsl:for-each-group></xsl:variable><xsl:if test="empty($raw-sheet-long-name)"><xsl:variable name="c:O170371580"><xsl:if test="($c:I234260923/@Id,$row-number-column-name)= 'ModelName'"><xsl:text>Cannot have a column named "ModelName" as this is </xsl:text><xsl:text>reserved to be defined by the worksheet name.
</xsl:text></xsl:if><xsl:if test="not($c:I234260923/@Id='DictionaryEntryName')"><xsl:text>Must have a column named "DictionaryEntryName" as </xsl:text><xsl:text>this is the key column for the genericode file.
</xsl:text></xsl:if><xsl:if test="$c:I234260923/@Id=$row-number-column-name"><xsl:text>Cannot have a column with the same name as the </xsl:text><xsl:text>column designated to store the row number.
</xsl:text></xsl:if></xsl:variable><xsl:if test="normalize-space($c:O170371580)"><xsl:message terminate="yes" select="$c:O170371580"/></xsl:if></xsl:if><gc:CodeList><xsl:call-template name="c:O156173948"/><ColumnSet><xsl:choose><xsl:when test="empty($raw-sheet-long-name)"><Column Id="ModelName" Use="required"><ShortName>ModelName</ShortName><LongName>Model Name</LongName><Data Type="string"/></Column><xsl:for-each select="$row-number-column-name"><Column Id="{translate(normalize-space(.),' ','')}" Use="required"><ShortName><xsl:value-of select="translate(normalize-space(.),' ','')"/></ShortName><LongName><xsl:value-of select="."/></LongName><Data Type="integer"/></Column></xsl:for-each><xsl:copy-of select="$c:I234260923"/><Key Id="key"><ShortName>Key</ShortName><ColumnRef Ref="DictionaryEntryName"/></Key></xsl:when><xsl:when test="string($raw-sheet-long-name)"><Column Id="{$worksheetIdentifier}" Use="optional"><ShortName><xsl:value-of select="$worksheetIdentifier"/></ShortName><LongName><xsl:value-of select="$raw-sheet-long-name"/></LongName><Data Type="string"/></Column><xsl:copy-of select="$c:I234260923"/></xsl:when><xsl:otherwise><xsl:copy-of select="$c:I234260923"/></xsl:otherwise></xsl:choose></ColumnSet><SimpleCodeList><xsl:call-template name="c:O144160568"><xsl:with-param name="c:I374817477" select="$c:I374817477"/></xsl:call-template></SimpleCodeList></gc:CodeList></xsl:template><xsl:template match="/*" priority="1"><xsl:apply-templates mode="c:O133863384" select="."><xsl:with-param name="c:I124939159" tunnel="yes" as="text()*"><xsl:text>This filter does not support an XML instance </xsl:text><xsl:value-of select="concat('starting with {',namespace-uri(*),'}', name(*))"/></xsl:with-param></xsl:apply-templates></xsl:template><xsl:template name="c:O156173948"><xsl:choose><xsl:when test="exists($identification-uri)"><xsl:choose><xsl:when test="not(doc-available($identification-uri))"><xsl:message terminate="yes"><xsl:text>The file at parameter identification-uri= </xsl:text><xsl:text>is not found or is not an XML file.</xsl:text></xsl:message></xsl:when><xsl:when test="not(doc($identification-uri)/Identification)"><xsl:message terminate="yes"><xsl:text>The file at parameter identification-uri= </xsl:text><xsl:text>does not have "{}Identification" as the </xsl:text><xsl:text>document element.</xsl:text></xsl:message></xsl:when><xsl:otherwise><xsl:copy-of select="doc($identification-uri)/Identification"/></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise><xsl:message select="'Using built-in placebo Identification metadata'"/><Identification><ShortName>OBDNDRSkeleton</ShortName><LongName>OASIS Business Document NDR skeleton genericode file</LongName><Version>1</Version><CanonicalUri>urn:X-CraneSoftwrights.com</CanonicalUri><CanonicalVersionUri>urn:X-CraneSoftwrights.com</CanonicalVersionUri></Identification></xsl:otherwise></xsl:choose></xsl:template><xsl:param name="worksheetIdentifier" as="xsd:string?" select="if( exists( $raw-sheet-long-name ) ) then if( string( $raw-sheet-long-name ) ) then replace($raw-sheet-long-name,'\W+','') else () else 'ModelName'"/><xsl:param name="lengthen-model-name-uri" as="xsd:string?"/><xsl:param name="c:I117130461" as="document-node()?" select="if( doc-available( $lengthen-model-name-uri ) ) then for $d in doc( $lengthen-model-name-uri ) return if ( $d/modelNameMassage ) then $d else () else ()"/><xsl:output indent="yes"/><xsl:template match="/"><xsl:choose><xsl:when test="not(office:document or office:document-content)"><xsl:apply-templates mode="c:O133863384" select="node()"><xsl:with-param name="c:I124939159" tunnel="yes" as="text()*"><xsl:text>This filter does not support an instance </xsl:text><xsl:value-of select="concat('starting with {',namespace-uri(*),'}', name(*))"/></xsl:with-param></xsl:apply-templates></xsl:when><xsl:otherwise><xsl:call-template name="c:O144160568"><xsl:with-param name="c:I374817477" select="/"/></xsl:call-template></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="c:O144160568"><xsl:param name="c:I374817477" as="document-node()*"/><xsl:for-each select="$c:I374817477/*/office:body/office:spreadsheet/ table:table"><xsl:variable name="c:O110240434" select="c:I104115965(@table:name)"/><xsl:variable name="c:O98636178" as="element()*"><xsl:for-each select="(.//table:table-row)[1]"><xsl:variable name="c:I93704369" select="."/><xsl:for-each select="1 to xsd:integer( o:O1874087386(table:table-cell[last()])[last()] )"><guess><xsl:value-of select="replace(translate( $c:I93704369/table:table-cell[o:O1874087386(.)=current()]/o:I937043693(.), ':()/''',''),'\s+','')"/></guess></xsl:for-each></xsl:for-each></xsl:variable><xsl:variable name="c:O89242256" select="( (.//table:table-row)[normalize-space( string-join(table:table-cell/o:I937043693(.),''))='END']/ preceding::table:table-row[1], (.//table:table-row)[last()] )[1]"/><xsl:for-each select="(.//table:table-row)[position()&gt;1] [ . is $c:O89242256 or . &lt;&lt; $c:O89242256 ] [string-join(table:table-cell/o:I937043693(.),'')!='']"><Row><xsl:if test="not($row-number-column-name)"><xsl:comment select="position()+1"/></xsl:if><xsl:if test="lower-case($indent)=('y','yes')"><xsl:text>
         </xsl:text></xsl:if><xsl:if test="$worksheetIdentifier"><Value ColumnRef="{$worksheetIdentifier}"><SimpleValue><xsl:value-of select="$c:O110240434"/></SimpleValue></Value></xsl:if><xsl:if test="$row-number-column-name"><Value ColumnRef="{translate(normalize-space($row-number-column-name),' ','')}"><SimpleValue><xsl:value-of select="position()+1"/></SimpleValue></Value></xsl:if><xsl:variable name="c:I93704369" select="."/><xsl:for-each select="1 to xsd:integer( o:O1874087386(table:table-cell[last()])[last()] )"><xsl:variable name="c:O85185790" select="."/><xsl:for-each select="$c:I93704369/table:table-cell [o:O1874087386(.)=$c:O85185790]/ o:I937043693(.)[normalize-space(.)]"><Value ColumnRef="{$c:O98636178[$c:O85185790]}"><SimpleValue><xsl:value-of select="."/></SimpleValue></Value></xsl:for-each></xsl:for-each></Row></xsl:for-each></xsl:for-each></xsl:template><xsl:function name="c:I104115965" as="xsd:string?"><xsl:param name="c:O81482060" as="xsd:string?"/><xsl:sequence select="if( exists($c:O81482060) ) then c:I104115965($c:O81482060,$c:I117130461/*/pass[last()]) else ()"/></xsl:function><xsl:function name="c:I104115965" as="xsd:string?"><xsl:param name="c:O81482060" as="xsd:string?"/><xsl:param name="c:O78086974" as="element(pass)?"/><xsl:sequence select="if( $c:O78086974 ) then c:I104115965( replace( $c:O81482060, $c:O78086974/lengthen/@find, $c:O78086974/lengthen/@replace ), $c:O78086974/preceding-sibling::pass[1] ) else $c:O81482060"/></xsl:function><xsl:variable name="odsTemplate" as="document-node()"><xsl:document><office:document/></xsl:document></xsl:variable><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O468521846" as="element(table:table)*"><xsl:param name="o:I624695795" as="element()"/><xsl:sequence select="$o:I624695795/*/office:body/office:spreadsheet/table:table"/></xsl:function><xsl:key xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I374817477" match="style:style" use="@style:name"/><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I267726769" as="xsd:string"><xsl:param name="o:I312347897" as="attribute()*"/><xsl:sequence select="if( not( $o:I312347897 ) ) then '' else if( starts-with($o:I312347897,'Crane') ) then $o:I312347897 else o:I267726769(key('o:I374817477',$o:I312347897,root($o:I312347897))/ @style:parent-style-name)"/></xsl:function><xsl:key xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I234260923" match="table:table-cell[ o:I267726769(preceding-sibling::table:table-cell[2]/@table:style-name)]" use="substring-after( o:I267726769(preceding-sibling::table:table-cell[2]/@table:style-name), 'CraneLabel')"/><xsl:key xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I208231931" match="table:table-cell[ o:I267726769(preceding-sibling::table:table-cell[2]/@table:style-name)]" use="1"/><xsl:key xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O187408738" match="table:table-cell[o:I267726769(@table:style-name)]" use="o:I267726769(@table:style-name)"/><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O144160568" as="node()?"><xsl:param name="o:O170371580" as="xsd:string"/><xsl:param name="o:O156173948" as="node()"/><xsl:sequence select="key('o:I234260923',$o:O170371580,$o:O156173948)"/></xsl:function><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I937043693" as="xsd:string?"><xsl:param name="o:O133863384" as="element(table:table-cell)?"/><xsl:sequence select="string-join($o:O133863384/text:p/string(.),' ')"/></xsl:function><xsl:template xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I124939159"><xsl:analyze-string select="." regex=".+"><xsl:matching-substring><text:p><xsl:value-of select="."/></text:p></xsl:matching-substring></xsl:analyze-string></xsl:template><xsl:template xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O98636178"><xsl:param name="o:I117130461" as="document-node()" required="yes"/><xsl:param name="o:O110240434" tunnel="yes" as="xsd:boolean" select="false()"/><xsl:param name="o:I104115965" tunnel="yes" as="xsd:boolean" select="false()"/><xsl:copy><xsl:if test="not($o:O110240434)"><xsl:apply-templates select="@*"/></xsl:if><xsl:choose><xsl:when test="$o:I117130461"><xsl:variable name="o:I93704369" as="document-node()"><xsl:document><xsl:apply-templates select="$o:I117130461/node()" mode="o:O98636178"/></xsl:document></xsl:variable><xsl:for-each select="$o:I93704369"><xsl:call-template name="o:I124939159"/></xsl:for-each></xsl:when><xsl:when test="$o:I104115965"/><xsl:otherwise><xsl:apply-templates/></xsl:otherwise></xsl:choose></xsl:copy></xsl:template><xsl:template xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" mode="o:O98636178" match="*"><xsl:param name="o:O89242256" tunnel="yes" as="xsd:string*" select="()"/><xsl:text/>&lt;<xsl:value-of select="name(.)"/><xsl:for-each select="namespace::*[not(.= (../namespace::xml,$o:O89242256))]"><xsl:if test="not(name(.)=../../namespace::*/name(.))"><xsl:value-of select="concat(' xmlns',if(name()) then ':' else '', name(.),'=&#34;',.,'&#34;')"/></xsl:if></xsl:for-each><xsl:for-each select="@*"><xsl:choose><xsl:when test="contains(.,'&#34;')"><xsl:value-of select="concat(&#34; &#34;,name(.),&#34;='&#34;,.,&#34;'&#34;)"/></xsl:when><xsl:otherwise><xsl:value-of select="concat(' ',name(.),'=&#34;',.,'&#34;')"/></xsl:otherwise></xsl:choose></xsl:for-each><xsl:choose><xsl:when test="node()"><xsl:text>&gt;</xsl:text><xsl:apply-templates mode="o:O98636178" select="node()"/><xsl:text/>&lt;/<xsl:value-of select="name(.)"/>&gt;<xsl:text/></xsl:when><xsl:otherwise><xsl:text>/&gt;</xsl:text></xsl:otherwise></xsl:choose></xsl:template><xsl:template xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" mode="o:O98636178" match="text()"><xsl:value-of select="."/></xsl:template><xsl:template xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" mode="o:O98636178" match="comment()"><xsl:value-of select="concat('&lt;!--',.,'--&gt;')"/></xsl:template><xsl:template xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" mode="o:O98636178" match="processing-instruction()"><xsl:value-of select="concat('&lt;?',name(.),' ',.,'?&gt;')"/></xsl:template><xsl:template xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" match="@*|node()" mode="#default o:O85185790"><xsl:copy><xsl:apply-templates select="@*,node()" mode="#default"/></xsl:copy></xsl:template><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O78086974" as="xsd:anyAtomicType*"><xsl:param name="o:O81482060" as="xsd:anyAtomicType*"/><xsl:perform-sort select="$o:O81482060"><xsl:sort/></xsl:perform-sort></xsl:function><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O72080284" as="node()*"><xsl:param name="o:I74963495" as="node()*"/><xsl:perform-sort select="$o:I74963495"><xsl:sort/></xsl:perform-sort></xsl:function><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O1874087386" as="xsd:double+"><xsl:param name="o:O133863384" as="node()"/><xsl:for-each select="$o:O133863384[self::table:table-cell]"><xsl:variable name="o:I69410643" select="count(preceding-sibling::table:table-cell) + 1 + sum(preceding-sibling::table:table-cell/@table:number-columns-spanned) + sum(preceding-sibling::table:table-cell/@table:number-columns-repeated) - count(preceding-sibling::table:table-cell[@table:number-columns-spanned]) - count(preceding-sibling::table:table-cell[@table:number-columns-repeated])"/><xsl:sequence select="xsd:integer($o:I69410643) to xsd:integer( $o:I69410643 - 1 + ( if( @table:number-columns-repeated ) then @table:number-columns-repeated else 1 ) )"/></xsl:for-each><xsl:for-each select="$o:O133863384[self::table:table-column]"><xsl:variable name="start" select="count(preceding-sibling::table:table-column) + 1 + sum(preceding-sibling::table:table-column/@table:number-columns-repeated) - count(preceding-sibling::table:table-column[@table:number-columns-repeated])"/><xsl:sequence select="xsd:integer($start) to xsd:integer( $start - 1 + ( if( @table:number-columns-repeated ) then @table:number-columns-repeated else 1 ) )"/></xsl:for-each></xsl:function><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O66931692" as="xsd:double+"><xsl:param name="o:O66931692" as="element(table:table-row)"/><xsl:for-each select="$o:O66931692"><xsl:variable name="start" select="count(preceding-sibling::table:table-row) + 1 + sum(preceding-sibling::table:table-row/@table:number-rows-repeated) - count(preceding-sibling::table:table-row[@table:number-rows-repeated])"/><xsl:sequence select="xsd:integer($start) to xsd:integer( $start - 1 + ( if( @table:number-rows-repeated ) then @table:number-rows-repeated else 1 ) )"/></xsl:for-each></xsl:function><xsl:template xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O64623702" mode="o:O64623702" match="table:table-cell"><xsl:param name="o:I117130461" as="node()?" required="yes"/><xsl:param name="o:O110240434" tunnel="yes" as="xsd:boolean" select="false()"/><xsl:param name="o:I104115965" tunnel="yes" as="xsd:boolean" select="false()"/><xsl:copy><xsl:if test="not($o:O110240434)"><xsl:apply-templates select="@*"/></xsl:if><xsl:choose><xsl:when test="string($o:I117130461)"><xsl:if test="not($o:I104115965)"><xsl:apply-templates select="* except text:*"/></xsl:if><xsl:for-each select="$o:I117130461"><xsl:call-template name="o:I124939159"/></xsl:for-each></xsl:when><xsl:when test="$o:I104115965"/><xsl:otherwise><xsl:apply-templates/></xsl:otherwise></xsl:choose></xsl:copy></xsl:template><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I60454431" as="xsd:integer"><xsl:param name="o:I62469579" as="xsd:string"/><xsl:analyze-string select="$o:I62469579" regex="\s*(([A-Z])?([A-Z]))?([A-Z])\s*"><xsl:matching-substring><xsl:sequence select="o:O58565230(regex-group(2))*26*26 + o:O58565230(regex-group(3))*26 + o:O58565230(regex-group(4))"/></xsl:matching-substring></xsl:analyze-string></xsl:function><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O58565230" as="xsd:integer"><xsl:param name="o:I62469579" as="xsd:string"/><xsl:sequence select="if($o:I62469579='') then 0 else string-to-codepoints($o:I62469579) - string-to-codepoints('A') + 1"/></xsl:function><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I55120217" as="xsd:string"><xsl:param name="o:O56790526" as="xsd:integer"/><xsl:variable name="o:I53545353" select="( $o:O56790526 - 1 ) idiv (27*26)"/><xsl:variable name="o:O52057982" select="(($o:O56790526 - 1 + $o:I53545353*26) mod (27*26) idiv 26)"/><xsl:variable name="o:O50651010" select="( $o:O56790526 - 1 ) mod 26 + 1"/><xsl:sequence select="concat( o:I49318089( $o:I53545353 ), o:I49318089( $o:O52057982 ), o:I49318089( $o:O50651010 ) )"/></xsl:function><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I49318089" as="xsd:string"><xsl:param name="o:O48053522" as="xsd:integer"/><xsl:sequence select="if($o:O48053522=0) then '' else codepoints-to-string( $o:O48053522 + string-to-codepoints('A') - 1 )"/></xsl:function><xsl:template xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:O46852184"><xsl:for-each select="1 to 1024"><xsl:variable name="o:O45709448" select="."/><xsl:variable name="o:I62469579" select="o:I55120217($o:O45709448)"/><xsl:variable name="o:O44621128" select="o:I60454431($o:I62469579)"/><xsl:message select="concat( $o:O45709448,'=',$o:I62469579,'=',$o:O44621128 )"/><xsl:if test="$o:O45709448 != $o:O44621128"><xsl:message terminate="yes" select="'o:I43583427'"/></xsl:if></xsl:for-each></xsl:template><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I39874199" as="text()*"><xsl:param name="o:I42592895" as="xsd:anyAtomicType?"/><xsl:param name="o:O41646386" as="xsd:integer"/><xsl:param name="o:O40741030" as="xsd:integer"/><xsl:analyze-string select="$o:I42592895" regex="(\$?)([A-Z])+(\$?)(\d+)"><xsl:matching-substring><xsl:value-of select="concat(regex-group(1), o:I55120217(o:I60454431(regex-group(2)) + $o:O41646386), regex-group(3), xsd:integer(regex-group(4)) + $o:O40741030 )"/></xsl:matching-substring><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:function><xsl:function xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" name="o:I39043487" as="xsd:string"><xsl:param name="o:O133863384" as="element(table:table-cell)"/><xsl:for-each select="$o:O133863384"><xsl:sequence select="concat(ancestor::table:table[1]/@table:name,'.', o:I55120217(xsd:integer(o:O1874087386(.))), o:O66931692(..))"/></xsl:for-each></xsl:function></xsl:stylesheet>
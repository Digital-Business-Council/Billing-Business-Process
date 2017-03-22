<?xml version="1.0" encoding="UTF-8"?>
<!--
Crane-gc2obdndr-obfuscated.xsl

This is a stylesheet to generate the validation artefacts (XSD schemas and
CVA assertions) described by a document described by a CCTS model expressed
using genericode. The version of NDR implemented by these stylesheets is
found at:

  http://docs.oasis-open.org/ubl/UBL-NDR/v3.0/UBL-NDR-v3.0.html

For best results the Crane-gcublndrcheck-obfuscated.xsl stylesheet should be
used to analyze the genericode file expressing the CCTS model.  Doing so will
highlight changes to make to prevent certain nonsensical results when
generating the artefacts.

Please see "CreatingExtensionsWithUBLNDR.html" for an illustration of using
these stylesheets

Copyright (C) - Crane Softwrights Ltd. 
              - http://www.CraneSoftwrights.com/links/training-gctk.htm

Portions copyright (C) - OASIS Open 2016. All Rights Reserved.
                       - http://www.oasis-open.org/who/intellectualproperty.php

This documentation and the URI resolution of the XSLT processor both presume
the use of the free Saxon9HE XSLT processor from http://saxon.sf.net ... if
that XSLT 2.0 processor is not being used, then the results may not be as
expected.

Typical invocation:

  java -jar saxon9he.jar {arguments}

Mandatory invocation arguments (URIs are relative to input genericode file):

 - stylesheet file:                         -xsl:Crane-gc2obdndr-obfuscated.xsl
 - input genericode file                    -s:{filename}
 - placebo output in target directory       -o:{dir}/junk.out
 - configuration detail file                config-uri={filename}

Optional invocation arguments:

 - only minimum subset of all models        subset-result={no(default)/yes}
   - this prunes away items that are never used by any model
 - a particular subset of some models       subset-model-regex={string}
 - a particular subset of some constructs   subset-column-name={string-no-sp}
   - the genericode column short name (no white-space), typically compressed
     from the spreadsheet column name
 - lazy pruning of the model                subset-absent-is-zero={no(def)/yes}
   - this only applies to items that have a minimum cardinality of 0; to
     preserve the item the original cardinality must be included in the subset
 - document the exclusion of items          subset-exclusions={yes(default)/no}
 - include elements for all types    subset-include-type-elements={yes(def)/no}
   - this allows one to ignore OBDNDR DCL04
 - include ignored types             subset-include-ignored-types={yes(def)/no}
   - this will suppress declarations that are not needed because not referenced
 - skip creation of QDT fragment            skip-qdt={no(default)/yes}
   - creating a QDT fragment according to the NDRs must be skipped if one has
     already been created with the desired qualifications

Optional invocation arguments (URIs are relative to input genericode file):
(only used when creating extensions or additional documents)

 - config file for base vocabulary          base-config-uri={filename}
 - genericode file for base vocabulary      base-gc-uri={filename}

Necessary invocation argument when the common library has exactly one ABIE:

 - specify the model name          common-library-singleton-model-name={string}

Deprecated invocation argument to mimic archaic declarations:

 - mimic UBL 2.1 declarations              qdt-for-UBL-2.1-only={no(def)/yes}
   - this property should only be used when recreating schemas from before
     the release of the OASIS Business Document Naming and Design Rules
   - this is not to be used in the normal course of creating schemas

Example invocations:

To create the UBL 2.1 base vocabulary artefacts:

    java -jar ../saxon9he/saxon9he.jar -s:mod/UBL-Entities-2.1.gc
         -xsl:../Crane-gc2obdndr-obfuscated.xsl
         -o:junk.out
         config-uri=../config-ubl-2.1.xml 
         qdt-for-UBL-2.1-only=yes

To create the Signature Extension for UBL 2.1:

    java -jar ../saxon9he/saxon9he.jar -s:mod/UBL-Signature-Entities-2.1.gc
         -xsl:../Crane-gc2obdndr-obfuscated.xsl 
         -o:junk.out
         config-uri=../config-ubl-2.1-ext.xml
         base-gc-uri=UBL-Entities-2.1.gc
         base-config-uri=../config-ubl-2.1.xml 
         qdt-for-UBL-2.1-only=yes
         common-library-singleton-model-name=UBL-SignatureLibrary-2.1

To create a user extension for UBL 2.1:

    java -jar ../saxon9he.jar -s:mod/MyTimesheetExtension-Entities.gc
         -xsl:../Crane-gc2obdndr-obfuscated.xsl 
         -o:junk.out
         config-uri=../config-myext.xml
         base-gc-uri=UBL-Entities-2.1.gc
         base-config-uri=../config-ubl-2.1.xml
         qdt-for-UBL-2.1-only=yes

To create an additional document that uses the UBL 2.1 library:

    java -jar ../saxon9he/saxon9he.jar -s:mod/MyRARequestResponse-Entities.gc
         -xsl:../Crane-gc2obdndr-obfuscated.xsl 
         -o:junk.out
         config-uri=../config-rar.xml 
         base-gc-uri=UBL-Entities-2.1.gc 
         base-config-uri=../config-ubl-2.1.xml
         qdt-for-UBL-2.1-only=yes

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

Configuration details file:

The configuration file has two major sections, the <ndr> section and the 
<schema> section.

The <ndr> section describes properties of the use of the naming and design 
rules, such as abbreviations, equivalences, expected BIEs and data types.  This
information is not used in the schema generation.  See the documentation for 
the NDR checking program for details.

The <schema> section describes all of the directories and files that are 
created or files that are needed by the files that are created as part of 
schema generation. The file types are indicated using the type= attribute. The
files that are created are:

    CVA - created context/value association file
        - there are as many of these entries as CVA files need to be created
        - each CVA file points to a skeleton CVA file in which <Context> 
          elements have ignored address= attributes that are each replaced 
          with a valid address= attribute of the union of all BBIE elements, 
          by name using the BBIE namespace prefix, that use the given 
          qualified data type as in these two examples:
          <Context values="checkMax" address="">
             <Annotation>
               <AppInfo>
                 <c:DataType>Max_ Numeric. Type</c:DataType>
               </AppInfo>
             </Annotation>
          </Context>
          <Context values="Chip-2.0" metadata="cctsV2.01-code" address="">
            <Annotation>
              <AppInfo>
                <c:DataType>Chip_ Code. Type</c:DataType>
              </AppInfo>
            </Annotation>
          </Context>
  SABIE - created supplemental library ABIE schema file
  SBBIE - created supplemental library BBIE schema file
  XABIE - created extension point ABIE schema file
  AABIE - created additional document ABIE schema file
  CABIE - created common library ABIE schema file
  CBBIE - created common library BBIE schema file
  DABIE - created document ABIE schema file
        - there are as many of these DABIE entries as document schemas need to 
          be created
        - when supplemental/extension/additional schema files are being 
          created, and only one set of such schema files can be created in any 
          given execution, the common schema files are not created
        - when the element name is <file>, a single file is created with the 
          given file name
        - when the element name is <files>, all document ABIE files are 
          created using the name and namespace as a substitution pattern
    DOC - documentation namespace (no actual file)
    EXT - referenced extension content file (optional)
        - the child of this entry is an XSD reference to the extension point 
          to be included in every document schema as the first child of the 
          document element 

A common comment can be defined for all files for which a specific comment is 
not provided. This comment is placed at the start of the file created. There 
are a number of substitution variables available for this comment:

    %% - a single percent sign
    %f - the output filename (with config path)
    %n - the output ABIE name (no config path)
    %t - the local time of file creation
    %z - the UTC (Zulu) time of file creation

The configuration file is organized by multiple directory parent elements that 
are used to calculate relative URI references for XSD import directives. There 
need not be any directory entries. The directory entry with the attribute 
runtime-name= triggers the recreation of the suite of contained files in the 
given alternative directory, but with XSD documentation constructs removed.

The configuration file used for UBL 2.1 is as follows:

<!DOCTYPE configuration
[
<!ENTITY versionDisplay "2.1 OS">
<!ENTITY versionDirectory   "os-UBL-2.1">
<!ENTITY versionDate        "04 November 2013">
]>
<configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <!- -
    This is the configuration of the base schema fragments for UBL 2.1
  - ->
 <ndr>
  <abbreviations>
    <abbreviation short="CV2">Card Verification Value</abbreviation>
    <abbreviation short="ID">Identifier</abbreviation>
    <abbreviation short="URI">Uniform Resource Identifier</abbreviation>
    <abbreviation short="UNDG">United Nations Development Group</abbreviation>
    <abbreviation short="UBL">Universal Business Language</abbreviation>
    <abbreviation short="UUID">Universally Unique Identifier</abbreviation>
    <abbreviation short="XPath">XML Path Language</abbreviation>
  </abbreviations>
  <equivalences>
    <equivalence>
      <primary-noun>URI</primary-noun>
      <representation-term>Identifier</representation-term>
    </equivalence>
    <equivalence>
      <primary-noun>UUID</primary-noun>
      <representation-term>Identifier</representation-term>
    </equivalence>
  </equivalences>
  <expected-maindoc-BIEs>
    <property-term type="BBIE" cardinality="0..1" order="1"
                                  >UBL Version Identifier</property-term>
    <property-term type="BBIE" cardinality="0..1" order="2"
                                  >Customization Identifier</property-term>
    <property-term type="BBIE" cardinality="0..1" order="3"
                                  >Profile Identifier</property-term>
    <property-term type="BBIE" cardinality="0..1" order="4"
                                  >Profile Execution Identifier</property-term>
    <property-term type="ASBIE" cardinality="0..n"
                                  >Signature</property-term>
  </expected-maindoc-BIEs>
  <types>
    <type>Amount</type>
    <type>Binary Object</type>
    <type>Code</type>
    <type>Date Time</type>
    <type>Date</type>
    <type>Graphic</type>t
    <type>Identifier</type>
    <type>Indicator</type>
    <type>Measure</type>
    <type>Name</type>
    <type>Numeric</type>
    <type>Percent</type>
    <type>Picture</type>
    <type>Quantity</type>
    <type>Rate</type>
    <type>Sound</type>
    <type>Text</type>
    <type>Time</type>
    <type>Value</type>
    <type>Video</type>
  </types>
 </ndr>
 <schema version="2.1">
  <comment>
  Library:           OASIS Universal Business Language (UBL) &versionDisplay;
                     http://docs.oasis-open.org/ubl/&versionDirectory;/
  Release Date:      &versionDate;
  Module:            %f
  Generated on:      %z
  Copyright (c) OASIS Open 2016. All Rights Reserved.
</comment>
    <copyright position="end">
  OASIS takes no position regarding the validity or scope of any 
  intellectual property or other rights that might be claimed to pertain 
  to the implementation or use of the technology described in this 
  document or the extent to which any license under such rights 
  might or might not be available; neither does it represent that it has 
  made any effort to identify any such rights. Information on OASIS's 
  procedures with respect to rights in OASIS specifications can be 
  found at the OASIS website. Copies of claims of rights made 
  available for publication and any assurances of licenses to be made 
  available, or the result of an attempt made to obtain a general 
  license or permission for the use of such proprietary rights by 
  implementors or users of this specification, can be obtained from 
  the OASIS Executive Director.

  OASIS invites any interested party to bring to its attention any 
  copyrights, patents or patent applications, or other proprietary 
  rights which may cover technology that may be required to 
  implement this specification. Please address the information to the 
  OASIS Executive Director.
  
  This document and translations of it may be copied and furnished to 
  others, and derivative works that comment on or otherwise explain 
  it or assist in its implementation may be prepared, copied, 
  published and distributed, in whole or in part, without restriction of 
  any kind, provided that the above copyright notice and this 
  paragraph are included on all such copies and derivative works. 
  However, this document itself may not be modified in any way, 
  such as by removing the copyright notice or references to OASIS, 
  except as needed for the purpose of developing OASIS 
  specifications, in which case the procedures for copyrights defined 
  in the OASIS Intellectual Property Rights document must be 
  followed, or as required to translate it into languages other than 
  English. 

  The limited permissions granted above are perpetual and will not be 
  revoked by OASIS or its successors or assigns. 

  This document and the information contained herein is provided on 
  an "AS IS" basis and OASIS DISCLAIMS ALL WARRANTIES, 
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY 
  WARRANTY THAT THE USE OF THE INFORMATION HEREIN 
  WILL NOT INFRINGE ANY RIGHTS OR ANY IMPLIED 
  WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A 
  PARTICULAR PURPOSE.    
</copyright>
  <type-documentation>
    <ccts:Component xmlns:ccts="urn:un:unece:uncefact:documentation:2">
       <ccts:ComponentType>ComponentType</ccts:ComponentType>
       <ccts:DictionaryEntryName>DictionaryEntryName</ccts:DictionaryEntryName>
       <ccts:Version>Version</ccts:Version>
       <ccts:Definition>Definition</ccts:Definition>
       <ccts:Cardinality>Cardinality</ccts:Cardinality>
       <ccts:ObjectClassQualifier>ObjectClassQualifier</ccts:ObjectClassQualifier>
       <ccts:ObjectClass>ObjectClass</ccts:ObjectClass>
       <ccts:PropertyTermQualifier>PropertyTermQualifier</ccts:PropertyTermQualifier>
       <ccts:PropertyTerm>PropertyTerm</ccts:PropertyTerm>
       <ccts:AssociatedObjectClass>AssociatedObjectClass</ccts:AssociatedObjectClass>
       <ccts:RepresentationTerm>RepresentationTerm</ccts:RepresentationTerm>
       <ccts:DataTypeQualifier>DataTypeQualifier</ccts:DataTypeQualifier>
       <ccts:DataType>DataType</ccts:DataType>
       <ccts:AlternativeBusinessTerms>AlternativeBusinessTerms</ccts:AlternativeBusinessTerms>
       <ccts:Examples>Examples</ccts:Examples>
    </ccts:Component>
  </type-documentation>
  <dir name="cva">
    <file type="CVA" name="UBL-DefaultDTQ-2.1.cva"
          skeleton-uri="UBL-2.1-CVA-Skeleton.cva"/>
  </dir>
  <dir name="xsd" runtime-name="xsdrt">
    <dir name="common">
      <file type="CABIE" name="UBL-CommonAggregateComponents-2.1.xsd"
            prefix="cac"
namespace="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
      <file type="CBBIE" name="UBL-CommonBasicComponents-2.1.xsd"
            prefix="cbc"
namespace="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
      <file type="QDT" name="UBL-QualifiedDataTypes-2.1.xsd"
            prefix="qdt"
namespace="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"/>
      <file type="UDT" name="UBL-UnqualifiedDataTypes-2.1.xsd"
            prefix="udt"
namespace="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
      <file type="EXT" name="UBL-CommonExtensionComponents-2.1.xsd"
            prefix="ext"
namespace="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2">
        <elements>
         <xsd:element ref="ext:UBLExtensions" minOccurs="0" maxOccurs="1">
            <xsd:annotation>
               <xsd:documentation>A container for all extensions present in the document.</xsd:documentation>
            </xsd:annotation>
         </xsd:element>
        </elements>
      </file>
    </dir>
    <dir name="maindoc">
      <files type="DABIE" name="UBL-%n-2.1.xsd"
             namespace="urn:oasis:names:specification:ubl:schema:xsd:%n-2">
        <element-documentation>This element MUST be conveyed as the root element in any instance document based on this Schema expression</element-documentation>
      </files>
    </dir>
  </dir>
 </schema>
</configuration>
 
Crane-gc2obdndr.xsl $Id: Crane-gc2obdndr.xsl,v 1.35 2016/06/25 20:18:45 admin Exp $
Crane-commonndr.xsl $Id: Crane-commonndr.xsl,v 1.34 2016/05/07 16:53:52 admin Exp $
Crane-utilndr.xsl $Id: Crane-utilndr.xsl,v 1.9 2016/05/02 20:32:39 admin Exp $
ndrSubset.xsl $Id: ndrSubset.xsl,v 1.35 2016/05/29 16:47:02 admin Exp $
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.CraneSoftwrights.com/ns/xslstyle" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:gu="urn:X-gc2obdndr" xmlns:dt="urn:X-Crane-gc2obdndr" exclude-result-prefixes="xs gu xsd dt" version="2.0"><xsl:param name="common-library-singleton-model-name" as="xsd:string?" select="()"/><xsl:variable name="gu:O1221238130" as="document-node()" select="/"/><xsl:param name="base-uri" as="xsd:anyURI?" select="()"/><xsl:variable xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" name="gu:I610619065" as="document-node()?" select="if( $base-uri ) then for $u in resolve-uri( $base-uri, document-uri(/) ) return if( doc-available($u) ) then doc($u)[gc:CodeList] else () else ()"/><xsl:variable name="gu:O407079376" as="xsd:string+" select="('UBLName','ComponentName','Name')"/><xsl:variable name="gu:O305309532" as="xsd:string?"><xsl:variable name="gu:O244247626" as="element(model)+"><xsl:for-each-group select="$gu:O1221238130/*/*/Row/gu:O203539688(.,'ModelName')" group-by="."><model name="{.}" count-bies="{count($gu:O1221238130/*/*/Row[gu:O203539688(.,'ModelName')=current()])}" count-abies="{count($gu:O1221238130/*/*/Row[gu:O203539688(.,'ModelName')=current()]                                         [gu:O203539688(.,'ComponentType')='ABIE'])}"/></xsl:for-each-group></xsl:variable><xsl:if test="count($gu:O244247626[@count-abies&gt;1])&gt;1"><xsl:message terminate="yes"><xsl:text>Only one model can have more than one ABIE as the </xsl:text><xsl:text>library model.</xsl:text></xsl:message></xsl:if><xsl:if test="count($gu:O244247626[@count-abies&gt;1])=0 and not($common-library-singleton-model-name)"><xsl:message terminate="yes"><xsl:text>When all models have only one ABIE then the model </xsl:text><xsl:text>to be considered the library model has to be </xsl:text><xsl:text>identified using the </xsl:text><xsl:text>"common-library-singleton-model-name" invocation </xsl:text><xsl:text>argument.</xsl:text></xsl:message></xsl:if><xsl:sequence select="if( $common-library-singleton-model-name ) then $common-library-singleton-model-name else gu:O174462590($gu:O1221238130)"/></xsl:variable><xsl:function name="gu:O174462590" as="xsd:string?"><xsl:param name="gc" as="document-node()?"/><xsl:variable name="gu:O152654766" as="xsd:string*"><xsl:for-each-group group-by="gu:O203539688(.,'ModelName')" select="$gc/*/SimpleCodeList/Row[gu:O203539688(.,'ComponentType')='ABIE']"><xsl:if test="count(current-group())&gt;1"><xsl:value-of select="current-grouping-key()"/></xsl:if></xsl:for-each-group></xsl:variable><xsl:if test="count($gu:O152654766) &gt; 1"><xsl:message terminate="yes"><xsl:text>More than one common library model identified in </xsl:text><xsl:value-of select="document-uri($gc)"/><xsl:text> in that there are </xsl:text><xsl:value-of select="count($gu:O152654766)"/><xsl:text> models with more than one ABIE: </xsl:text><xsl:value-of select="$gu:O152654766" separator=","/></xsl:message></xsl:if><xsl:sequence select="if( empty($gu:O152654766) ) then if( $gc is $gu:I610619065 ) then () else gu:O174462590($gu:I610619065) else $gu:O152654766"/></xsl:function><xsl:function name="gu:O203539688" as="element(SimpleValue)?"><xsl:param name="row" as="element(Row)"/><xsl:param name="col" as="xsd:string*"/><xsl:variable name="gu:I135693125" as="element(SimpleValue)*" select="$row/Value[@ColumnRef=$col]/SimpleValue"/><xsl:if test="count($gu:I135693125) &gt; 1"><xsl:message terminate="yes"><xsl:text>Data error: multiple genericode values in a single </xsl:text><xsl:text>row for column reference</xsl:text><xsl:if test="count($col)&gt;1">s</xsl:if>: <xsl:text/><xsl:value-of select="$col" separator=","/> at <xsl:text/><xsl:for-each select="$row/ancestor-or-self::*"><xsl:text/>/<xsl:value-of select="name(.)"/><xsl:if test="self::Row">[<xsl:number/>]</xsl:if></xsl:for-each></xsl:message></xsl:if><xsl:sequence select="$gu:I135693125"/></xsl:function><xsl:function name="gu:I122123813" as="xsd:string?"><xsl:param name="item" as="item()?"/><xsl:sequence select="translate(normalize-space($item),' ','')"/></xsl:function><xsl:function name="gu:O111021648" as="xsd:string?"><xsl:param name="row" as="element(Row)"/><xsl:param name="col" as="xsd:string+"/><xsl:sequence select="gu:I122123813(gu:O203539688($row,$col))"/></xsl:function><xsl:param name="base-config-uri" select="()" as="xsd:anyURI?"/><xsl:param name="config" as="document-node()?" select="if( not($config-uri) ) then () else doc(resolve-uri($config-uri,base-uri(/)))"/><xsl:param name="config-uri" as="xsd:string?"/><xsl:variable name="gu:O101769844" as="document-node()?" select="$config"/><xsl:variable name="gu:O93941394" as="element()*"><xsl:variable name="gu:I87231295" select="$gu:O101769844/*/schema//(file | files)"/><xsl:if test="$gu:O101769844/*/schema"><xsl:variable name="gu:I81415875"><xsl:if test="count( ( $gu:I87231295[@type='DABIE'][1], $gu:I87231295[@type='XABIE'][1], $gu:I87231295[@type='AABIE'][1] ) ) != 1 or $gu:I87231295[not(@type=('DABIE','CABIE','CBBIE','QDT','UDT','EXT', 'XABIE','AABIE','SABIE','SBBIE','CVA'))]"><xsl:text>Files can be created only for one type of output, </xsl:text><xsl:text>either UBL documents (DABIE), extensions (XABIE) or </xsl:text><xsl:text>additional non-UBL documents (AABIE).
</xsl:text></xsl:if><xsl:if test="$gu:I87231295[@type=('SABIE','SBBIE')] and not($gu:I87231295[@type=('XABIE','AABIE')])"><xsl:text>Supplementary common library schemas can only be </xsl:text><xsl:text>created for extensions or additional documents.
</xsl:text></xsl:if><xsl:if test="$gu:I87231295[@type=('CABIE','CBBIE')] and $gu:I87231295[@type=('XABIE','AABIE')]"><xsl:text>Common library schemas can only be created when not </xsl:text><xsl:text>creating extensions or additional documents. </xsl:text><xsl:text>Reference common library schemas used in a common </xsl:text><xsl:text>library configuration.
</xsl:text></xsl:if><xsl:if test="count($gu:I87231295[@type='CVA'])&gt;1"><xsl:text>Can create only a single CVA file at a time.
</xsl:text></xsl:if><xsl:for-each select="$gu:I87231295[self::files and @prefix]"><xsl:text>A prefix cannot be specified when creating multiple </xsl:text><xsl:text>files.</xsl:text><xsl:value-of select="gu:I76327383(.)"/><xsl:text>
</xsl:text></xsl:for-each><xsl:if test="not($gu:I87231295)"><xsl:text>Some files must be specified for schema generation
</xsl:text></xsl:if></xsl:variable><xsl:if test="normalize-space($gu:I81415875)"><xsl:message terminate="yes" select="$gu:I81415875"/></xsl:if><xsl:sequence select="$gu:I87231295"/></xsl:if></xsl:variable><xsl:variable name="gu:I71837537" as="document-node()?" select="if( $base-config-uri ) then for $u in resolve-uri( $base-config-uri, document-uri(/) ) return if( doc-available($u) ) then doc($u) else () else ()"/><xsl:variable name="gu:O67846562" as="document-node()"><xsl:document><combination><xsl:for-each select="$gu:O101769844,$gu:I71837537"><xsl:for-each select="*"><xsl:copy><xsl:copy-of select="@*"/><xsl:attribute name="xml:base" select="base-uri(.)"/><xsl:copy-of select="node()"/></xsl:copy></xsl:for-each></xsl:for-each></combination></xsl:document></xsl:variable><xsl:key name="gu:I87231295" match="file|files" use="@type"/><xsl:variable name="gu:I64275691" as="xsd:string?" select="gu:O174462590($gu:I610619065)"/><xsl:variable name="gu:O61061906" as="element(Row)*"><xsl:variable name="gu:O58154196" select="(key('gu:I87231295','XABIE',$gu:O67846562), key('gu:I87231295','AABIE',$gu:O67846562))/@abie"/><xsl:choose><xsl:when test="$gu:O58154196"><xsl:sequence select="$gu:O58154196/ key('gu:O55510824',.,$gu:O1221238130) [if( not( $subset-model-regex ) ) then true() else matches(gu:O203539688(.,'ModelName'),$subset-model-regex)]"/></xsl:when><xsl:otherwise><xsl:for-each-group select="/*/SimpleCodeList/ Row[gu:O203539688(.,'ModelName')!=$gu:O305309532] [gu:O203539688(.,'ComponentType')='ABIE'] [ if( not( $subset-model-regex ) ) then true() else matches(gu:O203539688(.,'ModelName'),$subset-model-regex)]" group-by="gu:O203539688(.,$gu:O407079376)"><xsl:sequence select="."/></xsl:for-each-group></xsl:otherwise></xsl:choose></xsl:variable><xsl:variable name="gu:O53097310" as="element(SimpleValue)*" select="$gu:O61061906/gu:O203539688(.,$gu:O407079376)"/><xsl:variable name="gu:O50884922" as="element(Row)*" select="$gu:O61061906 [ if( not( $subset-model-regex ) ) then true() else matches(gu:O203539688(.,'ModelName'),$subset-model-regex) ]"/><xsl:variable name="gu:I48849525" as="element(SimpleValue)*" select="$gu:O50884922/gu:O203539688(.,'ModelName')"/><xsl:variable name="gu:I46970697" as="element(SimpleValue)*" select="$gu:O50884922/gu:O203539688(.,'ObjectClass')"/><xsl:variable name="gu:I45231041" as="xsd:string" select="concat(key('gu:I87231295','CBBIE',$gu:O67846562)/@prefix,':')"/><xsl:variable name="gu:I43615647" as="xsd:string" select="concat(key('gu:I87231295','CABIE',$gu:O67846562)/@prefix,':')"/><xsl:variable name="gu:I42111659" as="xsd:string" select="concat(key('gu:I87231295','SBBIE',$gu:O67846562)/@prefix,':')"/><xsl:variable name="gu:I40707937" as="xsd:string" select="concat(key('gu:I87231295','SABIE',$gu:O67846562)/@prefix,':')"/><xsl:function name="gu:O39394778" as="xsd:string"><xsl:param name="name" as="xsd:string"/><xsl:param name="string" as="xsd:string"/><xsl:value-of><xsl:analyze-string select="$string" regex="%(.)"><xsl:matching-substring><xsl:value-of select="if(regex-group(1)='%') then '%' else if(regex-group(1)='f') then $name else if(regex-group(1)='n') then replace($name,'.*/','') else if(regex-group(1)='t') then format-dateTime( current-dateTime(), '[Y0001]-[M01]-[D01] [H01]:[m01][Z]' ) else if(regex-group(1)='z') then format-dateTime( adjust-dateTime-to-timezone(current-dateTime(),xsd:dayTimeDuration('PT0H')), '[Y0001]-[M01]-[D01] [H01]:[m01]z' ) else ."/></xsl:matching-substring><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:value-of></xsl:function><xsl:function name="gu:I76327383" as="xsd:string"><xsl:param name="this" as="element()"/><xsl:value-of><xsl:for-each select="$this/ancestor-or-self::*"><xsl:text/>/<xsl:value-of select="name(.)"/><xsl:if test="parent::*">[<xsl:number/>]</xsl:if></xsl:for-each><xsl:text>: </xsl:text><xsl:for-each select="$this"><xsl:text/>&lt;<xsl:value-of select="name(.)"/><xsl:for-each select="@*"><xsl:value-of select="concat(' ',name(.),'=&#34;',.,'&#34;')"/></xsl:for-each><xsl:text>&gt;</xsl:text></xsl:for-each></xsl:value-of></xsl:function><xsl:param name="subset-result" as="xsd:string" select="'no'"/><xsl:param name="subset-model-regex" as="xsd:string?"/><xsl:param name="subset-column-name" as="xsd:string?"/><xsl:param name="doc-column-names-regex" as="xsd:string?"/><xsl:param name="subset-absent-is-zero" as="xsd:string" select="'no'"/><xsl:param name="subset-exclusions" as="xsd:string" select="'yes'"/><xsl:param name="subset-include-type-elements" as="xsd:string" select="'yes'"/><xsl:param name="subset-include-ignored-types" as="xsd:string" select="'yes'"/><xsl:variable name="gu:I38163691" as="xsd:boolean" select="not(starts-with('no',lower-case($subset-absent-is-zero)))"/><xsl:variable name="gu:O37007216" as="xsd:boolean" select="starts-with('yes',lower-case($subset-exclusions))"/><xsl:variable name="gu:O35918768" as="xsd:boolean" select="starts-with('yes',lower-case($subset-include-type-elements))"/><xsl:variable name="gu:O34892518" as="xsd:boolean" select="starts-with('yes',lower-case($subset-include-ignored-types))"/><xsl:variable name="gu:I33923281" as="xsd:string?" select="translate(normalize-space($subset-column-name),' ','')"/><xsl:key name="gu:I33006435" match="Column" use="ShortName"/><xsl:variable name="gu:I32137845" as="xsd:string?" select="key('gu:I33006435',$gu:I33923281)/LongName"/><xsl:variable name="gu:O31313798" as="xsd:boolean" select="string($subset-column-name) or string($subset-model-regex) or not(starts-with('no',lower-case($subset-result)))"/><xsl:variable name="gu:I30530953" as="element(Column)*"><xsl:if test="exists($doc-column-names-regex)"><xsl:sequence select="$gu:O1221238130/*/ColumnSet/Column [matches(ShortName,$doc-column-names-regex)]"/></xsl:if></xsl:variable><xsl:function name="gu:O29077098" as="xsd:boolean"><xsl:param name="gu:I29786295" as="element(Row)"/><xsl:sequence select="if( not( $gu:O31313798 ) ) then true() else ( some $gu:O28400886 in ($gu:O27755412,$gu:O50884922) satisfies $gu:O28400886 is $gu:I29786295 )"/></xsl:function><xsl:function name="gu:I26548655" as="xsd:boolean"><xsl:param name="gu:I27138625" as="element(Row)"/><xsl:sequence select="if( not( $gu:O31313798 ) ) then true() else if( gu:O203539688($gu:I27138625,'ComponentType')='ABIE' ) then gu:O29077098( $gu:I27138625 ) else if( not( gu:O29077098( $gu:I27138625/ preceding-sibling::Row[gu:O203539688(.,'ComponentType')='ABIE'][1] ) ) ) then false() else not( gu:O25983790($gu:I27138625) )"/></xsl:function><xsl:variable name="gu:I25442461" as="element(Row)*" select="$gu:O1221238130/*/SimpleCodeList/Row"/><xsl:variable name="gu:I24923227" as="element(Row)*" select="($gu:O50884922,$gu:O27755412)/ key('gu:O24424762',gu:O203539688(.,'ObjectClass')) [not( gu:O25983790(.) )]"/><xsl:variable name="gu:I23945845" as="element(Row)*" select="$gu:I24923227[gu:O203539688(.,'ComponentType')='ASBIE']"/><xsl:variable name="gu:O23485348" as="element(Row)*" select="$gu:I24923227[gu:O203539688(.,'ComponentType')='BBIE']"/><xsl:variable name="gu:O23042228" as="element(Row)*" select="$gu:I23945845 [ for $gu:O22615520 in gu:O203539688(.,'AssociatedObjectClass') return ( not( key('gu:I22204329',$gu:O22615520) ) or ( every $gu:I21807823 in key('gu:O24424762',$gu:O22615520) satisfies gu:O25983790( $gu:I21807823 ) ) ) ]"/><xsl:variable name="gu:O21425230" as="element(Row)*"><xsl:sequence select="$gu:I25442461[gu:O203539688(.,'ComponentType')='ABIE'] [gu:O203539688(.,'ModelName')=$gu:O305309532]"/></xsl:variable><xsl:variable name="gu:O27755412" as="element(Row)*"><xsl:sequence select="if( $gu:O31313798 ) then gu:I21055829( $gu:O50884922 ) else $gu:I25442461[gu:O203539688(.,'ComponentType')='ABIE'] [gu:O203539688(.,'ModelName')=$gu:O305309532]"/></xsl:variable><xsl:function name="gu:I21055829" as="element(Row)*"><xsl:param name="gu:I20698951" as="element(Row)*"/><xsl:variable name="gu:O20353968" select="$gu:I20698951/ key('gu:I20020297',gu:O203539688(.,'ObjectClass'),$gu:O1221238130) [not(gu:O25983790(.))]/gu:O203539688(.,'AssociatedObjectClass')"/><xsl:variable name="gu:I19697389" select="for $each in $gu:O20353968 return $gu:O1221238130/key('gu:I22204329',$each,.)"/><xsl:sequence select="gu:O19384732( ($gu:I20698951,$gu:I19697389), ( for $gu:I19081845 in $gu:O1221238130 return $gu:I19697389/key('gu:I20020297', gu:O203539688(.,'ObjectClass')) [not( gu:O25983790(.) )]/ key('gu:I22204329', gu:O203539688(.,'AssociatedObjectClass'),$gu:I19081845)))"/></xsl:function><xsl:function name="gu:O19384732" as="element(Row)*"><xsl:param name="gu:O18788278" as="element(Row)*"/><xsl:param name="gu:O18227434" as="element(Row)*"/><xsl:variable name="gu:O17959384" select="$gu:O18227434[1]"/><xsl:choose><xsl:when test="not($gu:O17959384)"><xsl:sequence select="$gu:O18788278"/></xsl:when><xsl:when test="some $gu:I17699103 in $gu:O18788278 satisfies $gu:I17699103 is $gu:O17959384"><xsl:sequence select="gu:O19384732($gu:O18788278, $gu:O18227434 except $gu:O17959384)"/></xsl:when><xsl:otherwise><xsl:sequence select="gu:O19384732( (:add this to the set found so far:) ( $gu:O18788278, $gu:O17959384 ), (:add its references to the ones being looked for:) ( $gu:O18227434, ($gu:O1221238130,$gu:I610619065)/ key('gu:I20020297', gu:O203539688($gu:O17959384,'ObjectClass')) [not( gu:O25983790(.) )]/ key('gu:I22204329', gu:O203539688(.,'AssociatedObjectClass')) ) except ( $gu:O18788278, $gu:O17959384 ) )"/></xsl:otherwise></xsl:choose></xsl:function><xsl:template name="gu:I17446259"><xsl:choose><xsl:when test="not($gu:O31313798)"/><xsl:when test="string($subset-column-name) and ( every $gu:I17200537 in ($gu:O1221238130,$gu:I610619065)/*/SimpleCodeList/Row/gu:O203539688(.,$subset-column-name) satisfies normalize-space($gu:I17200537)='' )"><xsl:text>No subset information found for named column: </xsl:text><xsl:value-of select="$subset-column-name"/><xsl:text>
</xsl:text></xsl:when><xsl:when test="string($subset-model-regex) and ( every $gu:O16961640 in distinct-values( ($gu:O1221238130,$gu:I610619065)/*/SimpleCodeList/Row/gu:O203539688(.,'ModelName') ) satisfies not( matches($gu:O16961640,$subset-model-regex) ) )"><xsl:text>No subset information found for model regex: </xsl:text><xsl:value-of select="$subset-model-regex"/><xsl:text>
</xsl:text></xsl:when><xsl:otherwise><xsl:for-each select="$gu:O27755412"><xsl:variable name="gu:I16729289" select="key('gu:O24424762',gu:O203539688(.,'ObjectClass'))"/><xsl:choose><xsl:when test="count($gu:I16729289)=0"><xsl:text>The ABIE appears corrupted in that it has no </xsl:text><xsl:text>BIEs: </xsl:text><xsl:value-of select="gu:O203539688(.,'DictionaryEntryName')"/><xsl:text>
</xsl:text></xsl:when><xsl:when test="not( gu:I16503217(.) )"/><xsl:when test="not( some $gu:I21807823 in $gu:I16729289 satisfies not( gu:O25983790($gu:I21807823) ) )"><xsl:text>An ABIE cannot have all of its members excluded </xsl:text><xsl:text>in a subset: </xsl:text><xsl:value-of select="gu:O203539688(.,'DictionaryEntryName')"/><xsl:text>
</xsl:text></xsl:when></xsl:choose><xsl:for-each select="$gu:I16729289"><xsl:variable name="gu:I16283175" select="normalize-space(gu:O203539688(.,'Cardinality'))"/><xsl:variable name="gu:O16068922" select="normalize-space(gu:O203539688(.,$gu:I33923281))"/><xsl:choose><xsl:when test="not($gu:O16068922 = ('','0','0..1','1','0..n','1..n'))"><xsl:text>Invalid value "</xsl:text><xsl:value-of select="$gu:O16068922"/><xsl:text>" for subset cardinality: </xsl:text><xsl:value-of select="gu:O203539688(.,'DictionaryEntryName')"/><xsl:text>
</xsl:text></xsl:when><xsl:when test="not($gu:I16283175 = ('','0..1','1','0..n','1..n'))"><xsl:text>Invalid value "</xsl:text><xsl:value-of select="$gu:O16068922"/><xsl:text>" for original cardinality: </xsl:text><xsl:value-of select="gu:O203539688(.,'DictionaryEntryName')"/><xsl:text>
</xsl:text></xsl:when><xsl:when test="$gu:O16068922=''"/><xsl:when test="substring($gu:I16283175,1,1)='1' and not( substring($gu:O16068922,1,1)='1')"><xsl:text>The minimum cardinality cannot be lowered </xsl:text><xsl:text>from "</xsl:text><xsl:value-of select="$gu:I16283175"/><xsl:text>" to "</xsl:text><xsl:value-of select="$gu:O16068922"/><xsl:text>": </xsl:text><xsl:value-of select="gu:O203539688(.,'DictionaryEntryName')"/><xsl:text>
</xsl:text></xsl:when><xsl:when test="substring($gu:I16283175,string-length($gu:I16283175),1)='1' and substring($gu:O16068922,string-length($gu:O16068922),1)='n'"><xsl:text>The maximum cardinality cannot be raised </xsl:text><xsl:text>from "</xsl:text><xsl:value-of select="$gu:I16283175"/><xsl:text>" to "</xsl:text><xsl:value-of select="$gu:O16068922"/><xsl:text>": </xsl:text><xsl:value-of select="gu:O203539688(.,'DictionaryEntryName')"/><xsl:text>
</xsl:text></xsl:when></xsl:choose></xsl:for-each></xsl:for-each></xsl:otherwise></xsl:choose></xsl:template><xsl:function name="gu:I16503217" as="xsd:boolean"><xsl:param name="gu:I15860235" as="element(Row)"/><xsl:sequence select="exists( ($gu:O1221238130/key('gu:I15656899',gu:O203539688($gu:I15860235,'ObjectClass')), $gu:I610619065/key('gu:I15656899',gu:O203539688($gu:I15860235,'ObjectClass'))) [gu:I26548655(.)] )"/></xsl:function><xsl:function name="gu:O15458710" as="xsd:boolean"><xsl:param name="gu:I15860235" as="element(Row)"/><xsl:sequence select="gu:O203539688($gu:I15860235,'ModelName')=$gu:I48849525"/></xsl:function><xsl:function name="gu:O15265476" as="xsd:string"><xsl:param name="row" as="element(Row)"/><xsl:param name="minimumFlag" as="xsd:boolean"/><xsl:for-each select="(normalize-space(gu:O203539688($row,$gu:I33923281)) [$gu:O31313798][string(.)], gu:O203539688($row,'Cardinality')[$gu:I38163691] [starts-with(normalize-space(.),'0')] [$gu:O31313798]/'0', normalize-space(gu:O203539688($row,'Cardinality')))[1]"><xsl:choose><xsl:when test="$minimumFlag"><xsl:value-of select="substring(.,1,1)"/></xsl:when><xsl:when test="ends-with(.,'n')">unbounded</xsl:when><xsl:otherwise><xsl:value-of select="substring(.,string-length(.),1)"/></xsl:otherwise></xsl:choose></xsl:for-each></xsl:function><xsl:function name="gu:I15077013" as="xsd:string"><xsl:param name="row" as="element(Row)"/><xsl:sequence select="gu:O15265476($row,true())"/></xsl:function><xsl:function name="gu:I14893147" as="xsd:string"><xsl:param name="row" as="element(Row)"/><xsl:sequence select="gu:O15265476($row,false())"/></xsl:function><xsl:function name="gu:O25983790" as="xsd:boolean"><xsl:param name="row" as="element(Row)"/><xsl:sequence select="gu:I15077013($row)='0' and gu:I14893147($row)='0'"/></xsl:function><xsl:key name="gu:O14713712" match="Row[gu:O203539688(.,'ComponentType')='ABIE']" use="if( gu:O203539688(.,'ModelName')=$gu:O305309532 ) then $gu:O305309532 else gu:O203539688(.,$gu:O407079376)"/><xsl:key name="gu:I14538549" match="Row" use="gu:O203539688(.,'DictionaryEntryName')"/><xsl:key name="gu:I14367507" match="Row[gu:O203539688(.,'ComponentType')='BBIE']" use="gu:O203539688(.,$gu:O407079376)"/><xsl:key name="gu:O55510824" match="Row[gu:O203539688(.,'ComponentType')='ABIE']" use="gu:O203539688(.,$gu:O407079376)"/><xsl:key name="gu:I22204329" match="Row[gu:O203539688(.,'ComponentType')='ABIE']" use="gu:O203539688(.,'ObjectClass')"/><xsl:key name="gu:I14200443" match="Row" use="gu:O203539688(.,'ComponentType')"/><xsl:key name="gu:I14037219" match="Row[gu:O203539688(.,'DataType')]" use="gu:O203539688(.,'DataType')"/><xsl:key name="gu:O13877706" match="Row[gu:O203539688(.,'ComponentType')!='ABIE']" use="preceding-sibling::Row[gu:O203539688(.,'ComponentType')='ABIE'][1]/ gu:O203539688(.,'ObjectClass')"/><xsl:key name="gu:O24424762" match="Row[gu:O203539688(.,'ComponentType')!='ABIE']" use="gu:O203539688(.,'ObjectClass')"/><xsl:key name="gu:O13721776" match="Row" use="concat( gu:O203539688(.,'ObjectClass'),' ', gu:O203539688(.,$gu:O407079376),' ', gu:O203539688(.,'ComponentType'))"/><xsl:key name="gu:O13569312" match="Row[gu:O203539688(.,'ComponentType')='ASBIE']" use="preceding-sibling::Row[gu:O203539688(.,'ComponentType')='ABIE'][1]/ gu:O203539688(.,$gu:O407079376)"/><xsl:key name="gu:I20020297" match="Row[gu:O203539688(.,'ComponentType')='ASBIE']" use="preceding-sibling::Row[gu:O203539688(.,'ComponentType')='ABIE'][1]/ gu:O203539688(.,'ObjectClass')"/><xsl:key name="gu:I15656899" match="Row[gu:O203539688(.,'ComponentType')='ASBIE']" use="gu:O203539688(.,'AssociatedObjectClass')"/><xsl:key name="gu:I13420199" match="Row[gu:O203539688(.,'ComponentType')='BBIE']" use="gu:O203539688(.,'DataType')"/><xsl:variable name="gu:I13274327" as="element(SimpleValue)*"><xsl:for-each-group select="/*/SimpleCodeList/Row/gu:O203539688(.,'ModelName')" group-by="."><xsl:sequence select="."/></xsl:for-each-group></xsl:variable><xsl:variable name="gu:O13131592" as="element(SimpleValue)*" select="$gu:O21425230/gu:O203539688(.,$gu:O407079376)"/><xsl:variable name="gu:I12991895" as="element(SimpleValue)*" select="$gu:O27755412/gu:O203539688(.,$gu:O407079376)"/><xsl:param name="qdt-for-UBL-2.1-only" as="xsd:string" select="'no'"/><xsl:variable name="gu:O12855138" as="xsd:boolean" select="starts-with('yes',lower-case($qdt-for-UBL-2.1-only))"/><xsl:param name="skip-qdt" as="xsd:string" select="'no'"/><xsl:variable name="gu:O12721230" as="xsd:boolean" select="starts-with('yes',lower-case($skip-qdt))"/><xsl:output indent="yes"/><xsl:template match="/"><xsl:variable name="gu:I12590083"><xsl:choose><xsl:when test="not($gu:O101769844)"><xsl:text>Cannot open specified configuration file "</xsl:text><xsl:value-of select="$config-uri"/><xsl:text>" resolved relative to the input genericode file: </xsl:text><xsl:value-of select="document-uri(/)"/></xsl:when><xsl:when test="$base-config-uri and not($gu:I71837537)"><xsl:text>Cannot open specified common configuration file "</xsl:text><xsl:value-of select="$base-config-uri"/><xsl:text>" resolved relative to the input genericode file: </xsl:text><xsl:value-of select="document-uri(/)"/></xsl:when><xsl:when test="($gu:O93941394[@type=('XABIE','AABIE')]) and not($gu:I610619065)"><xsl:text>Cannot open specified common genericode file "</xsl:text><xsl:value-of select="$base-uri"/><xsl:text>" resolved relative to the input genericode file: </xsl:text><xsl:value-of select="document-uri(/)"/></xsl:when><xsl:otherwise><xsl:call-template name="gu:I12461613"/></xsl:otherwise></xsl:choose></xsl:variable><xsl:if test="normalize-space($gu:I12590083)"><xsl:message terminate="yes" select="$gu:I12590083"/></xsl:if><xsl:variable name="gu:O12335738" select="$gu:O67846562/*/configuration[1]"/><xsl:apply-templates select="key('gu:I87231295','CVA',$gu:O12335738)"/><xsl:for-each select="false(), if( $gu:O12335738//dir[@runtime-name] ) then true() else ()"><xsl:choose><xsl:when test="$gu:O93941394[@type='XABIE']"><xsl:apply-templates select="key('gu:I87231295','XABIE',$gu:O12335738)"><xsl:with-param name="gu:I12212381" tunnel="yes" select="."/><xsl:with-param name="gu:O12091466" tunnel="yes" select="'XABIE'"/></xsl:apply-templates><xsl:apply-templates select="key('gu:I87231295','SABIE',$gu:O12335738)"><xsl:with-param name="gu:I12212381" tunnel="yes" select="."/><xsl:with-param name="gu:O12091466" tunnel="yes" select="'SABIE'"/></xsl:apply-templates><xsl:apply-templates select="key('gu:I87231295','SBBIE',$gu:O12335738)"><xsl:with-param name="gu:I12212381" tunnel="yes" select="."/><xsl:with-param name="gu:O12091466" tunnel="yes" select="'SBBIE'"/></xsl:apply-templates></xsl:when><xsl:when test="$gu:O93941394[@type='AABIE']"><xsl:apply-templates select="key('gu:I87231295','AABIE',$gu:O12335738)"><xsl:with-param name="gu:I12212381" tunnel="yes" select="."/><xsl:with-param name="gu:O12091466" tunnel="yes" select="'AABIE'"/></xsl:apply-templates><xsl:apply-templates select="key('gu:I87231295','SABIE',$gu:O12335738)"><xsl:with-param name="gu:I12212381" tunnel="yes" select="."/><xsl:with-param name="gu:O12091466" tunnel="yes" select="'SABIE'"/></xsl:apply-templates><xsl:apply-templates select="key('gu:I87231295','SBBIE',$gu:O12335738)"><xsl:with-param name="gu:I12212381" tunnel="yes" select="."/><xsl:with-param name="gu:O12091466" tunnel="yes" select="'SBBIE'"/></xsl:apply-templates></xsl:when><xsl:otherwise><xsl:apply-templates select="key('gu:I87231295','DABIE',$gu:O12335738)"><xsl:with-param name="gu:I12212381" tunnel="yes" select="."/><xsl:with-param name="gu:O12091466" tunnel="yes" select="'DABIE'"/></xsl:apply-templates><xsl:apply-templates select="key('gu:I87231295','CABIE',$gu:O12335738)"><xsl:with-param name="gu:I12212381" tunnel="yes" select="."/><xsl:with-param name="gu:O12091466" tunnel="yes" select="'CABIE'"/></xsl:apply-templates><xsl:apply-templates select="key('gu:I87231295','CBBIE',$gu:O12335738)"><xsl:with-param name="gu:I12212381" tunnel="yes" select="."/><xsl:with-param name="gu:O12091466" tunnel="yes" select="'CBBIE'"/></xsl:apply-templates><xsl:if test="not($gu:O12721230) and not($gu:O12855138)"><xsl:apply-templates select="key('gu:I87231295','QDT',$gu:O12335738)"><xsl:with-param name="gu:I12212381" tunnel="yes" select="."/><xsl:with-param name="gu:O12091466" tunnel="yes" select="'QDT'"/></xsl:apply-templates></xsl:if></xsl:otherwise></xsl:choose></xsl:for-each></xsl:template><xsl:template match="configuration//file"><xsl:param name="gu:I12212381" tunnel="yes" as="xsd:boolean"/><xsl:variable name="gu:O11972922" select="gu:O11856680( ., ancestor::schema, $gu:I12212381 )"/><xsl:message select="'Creating',$gu:O11972922,'...'"/><xsl:variable name="gu:O11742674" select="if( @type=('DABIE','XABIE','AABIE') ) then if( @abie ) then $gu:O50884922[gu:O203539688(.,$gu:O407079376)=current()/@abie] else $gu:O50884922[1] else (:'CABIE','SABIE','CBBIE','SBBIE':) ( $gu:O50884922/ key('gu:I20020297',gu:O203539688(.,'ObjectClass'),$gu:O1221238130) [gu:I26548655(.)]/(., key('gu:I22204329',gu:O203539688(.,'AssociatedObjectClass'),$gu:O1221238130)), $gu:O27755412 )"/><xsl:variable name="gu:I11630839" select="($gu:O50884922,$gu:O11742674)/ key('gu:O24424762',gu:O203539688(.,'ObjectClass'),$gu:O1221238130) [gu:O203539688(.,'ComponentType')='BBIE'] [gu:I26548655(.)]"/><xsl:variable name="gu:O11742674" select="if( @type='QDT' ) then () else $gu:O11742674"/><xsl:variable name="gu:I11630839" select="if( @type='QDT' ) then $gu:I11630839[gu:O203539688(.,'DataTypeQualifier')] else $gu:I11630839"/><xsl:if test="@abie and not( $gu:O11742674 )"><xsl:message terminate="yes"><xsl:text>Cannot find requested ABIE in the set of document </xsl:text><xsl:text>ABIES: </xsl:text><xsl:value-of select="@abie"/></xsl:message></xsl:if><xsl:result-document href="{$gu:O11972922}"><xsl:call-template name="gu:O11521114"><xsl:with-param name="gu:O11972922" select="$gu:O11972922"/><xsl:with-param name="gu:O11742674" tunnel="yes" select="$gu:O11742674"/><xsl:with-param name="gu:I11630839" tunnel="yes" select="$gu:I11630839"/><xsl:with-param name="gu:O11413440" select="@namespace"/></xsl:call-template></xsl:result-document></xsl:template><xsl:template match="configuration//files"><xsl:param name="gu:I12212381" tunnel="yes" as="xsd:boolean"/><xsl:variable name="gu:O11307760" select="."/><xsl:variable name="gu:I11204019" as="xsd:string*" select="key('gu:I87231295',@type,$gu:O67846562)/@abie"/><xsl:for-each select="$gu:O61061906[not(gu:O203539688(.,$gu:O407079376)=$gu:I11204019)]"><xsl:variable name="gu:O11102164" select="."/><xsl:for-each select="$gu:O11307760"><xsl:variable name="gu:O11972922" select="gu:O39394778($gu:O11102164/gu:O203539688(.,$gu:O407079376), ( gu:O11856680( ., ancestor::schema, $gu:I12212381) ))"/><xsl:if test="gu:O29077098( $gu:O11102164 )"><xsl:message select="'Creating',$gu:O11972922,'...'"/><xsl:result-document href="{$gu:O11972922}"><xsl:call-template name="gu:O11521114"><xsl:with-param name="gu:O11972922" select="$gu:O11972922"/><xsl:with-param name="gu:O11742674" tunnel="yes" select="$gu:O11102164"/><xsl:with-param name="gu:I11630839" tunnel="yes" select="$gu:O11102164/ key('gu:O24424762',gu:O203539688(.,'ObjectClass'),$gu:O1221238130) [gu:O203539688(.,'ComponentType')='BBIE'] [gu:I26548655(.)]"/><xsl:with-param name="gu:O11413440" select="gu:O39394778($gu:O11102164/gu:O203539688(.,$gu:O407079376),@namespace)"/><xsl:with-param name="gu:O12091466" tunnel="yes" select="@type"/></xsl:call-template></xsl:result-document></xsl:if></xsl:for-each></xsl:for-each></xsl:template><xsl:template match="configuration//file[@type='CVA']" priority="1"><xsl:variable name="gu:I11002145" select="document(@skeleton-uri)"/><xsl:variable name="gu:I10903911" select="gu:O11856680( ., ancestor::schema, false() )"/><xsl:message select="'Creating',$gu:I10903911,'...'"/><xsl:result-document href="{$gu:I10903911}"><xsl:apply-templates mode="gu:I10807417" select="$gu:I11002145"/></xsl:result-document></xsl:template><xsl:template name="gu:O11521114"><xsl:param name="gu:O11972922" as="xsd:string"/><xsl:param name="gu:O11413440" as="xsd:string"/><xsl:param name="gu:O12091466" tunnel="yes" as="xsd:string"/><xsl:param name="gu:I12212381" tunnel="yes" as="xsd:boolean"/><xsl:param name="gu:O11742674" tunnel="yes" as="element(Row)*"/><xsl:param name="gu:I11630839" tunnel="yes" as="element(Row)*"/><xsl:variable name="gu:I10712615" select="."/><xsl:text>
</xsl:text><xsl:for-each select="(comment,ancestor::schema/comment)[1]"><xsl:comment><xsl:value-of select="gu:O39394778($gu:O11972922,.)"/></xsl:comment><xsl:text>
</xsl:text></xsl:for-each><xsl:for-each select="(copyright,ancestor::schema/copyright)[1][@position='start']"><xsl:comment> ===== Copyright Notice ===== </xsl:comment><xsl:text>
</xsl:text><xsl:comment select="."/></xsl:for-each><xsd:schema targetNamespace="{$gu:O11413440}" elementFormDefault="qualified" attributeFormDefault="unqualified" version="{ancestor::schema/@version}"><xsl:variable name="gu:O10619462" as="element(file)*"><xsl:if test="$gu:O12091466=('XABIE','AABIE') and $gu:O11742674[not(gu:O10527914(.))]"><xsl:sequence select="key('gu:I87231295','SABIE',$gu:O67846562)"/></xsl:if><xsl:if test="$gu:O12091466=('XABIE','AABIE','SABIE') and $gu:I11630839[not(gu:O10527914(.))]"><xsl:sequence select="key('gu:I87231295','SBBIE',$gu:O67846562)"/></xsl:if><xsl:if test="( (:a document ABIE needs access to the library:) ( $gu:O12091466='DABIE' and $gu:O11742674[not(gu:O10527914(.))] ) or (:an extension construct needs access to the library:) ( $gu:O12091466=('XABIE','AABIE','SABIE') and $gu:O11742674[gu:O203539688(.,'ComponentType')='ABIE']/ key('gu:I20020297',gu:O203539688(.,'ObjectClass'))/ ( for $gu:O22615520 in gu:O203539688(.,'AssociatedObjectClass') return $gu:I610619065/key('gu:I22204329',$gu:O22615520))))"><xsl:sequence select="key('gu:I87231295','CABIE',$gu:O67846562)"/></xsl:if><xsl:if test="( $gu:O12091466='DABIE' and $gu:I11630839[not(gu:O10527914(.))] ) or ( $gu:O12091466='CABIE' and $gu:I11630839 ) or ( $gu:O12091466=('XABIE','AABIE','SABIE') and $gu:O11742674[gu:O203539688(.,'ComponentType')='ABIE']/ key('gu:O24424762',gu:O203539688(.,'ObjectClass')) [gu:O203539688(.,'ComponentType')='BBIE']/ ( for $gu:O10437932 in gu:O203539688(.,$gu:O407079376) return $gu:I610619065/key('gu:I14367507',$gu:O10437932)))"><xsl:sequence select="key('gu:I87231295','CBBIE',$gu:O67846562)"/></xsl:if><xsl:if test="$gu:O12091466=('CBBIE','SBBIE')"><xsl:sequence select="key('gu:I87231295','QDT',$gu:O67846562), key('gu:I87231295','UDT',$gu:O67846562)"/></xsl:if><xsl:if test="$gu:O12091466='QDT'"><xsl:sequence select="key('gu:I87231295','UDT',$gu:O67846562)"/></xsl:if><xsl:if test="$gu:O12091466=('DABIE','AABIE')"><xsl:sequence select="key('gu:I87231295','EXT',$gu:O67846562)"/></xsl:if></xsl:variable><xsl:namespace name="" select="$gu:O11413440"/><xsl:for-each select="(:first check self-referencing common aggregates:) .[$gu:O12091466=('CABIE','SABIE')], (:then add in all of the participating files:) $gu:O10619462"><xsl:namespace name="{@prefix}" select="@namespace"/></xsl:for-each><xsl:copy-of select=".//namespace::*"/><xsl:if test="not($gu:I12212381) and not($gu:O12091466=('CBBIE','SBBIE'))"><xsl:copy-of select="(type-documentation, $gu:O67846562/combination/configuration/schema/type-documentation)[1]// namespace::*"/><xsl:copy-of select="(element-documentation, $gu:O67846562/combination/configuration/schema/element-documentation)[1]// namespace::*"/></xsl:if><xsl:if test="$gu:O10619462 or imports/node()"><xsl:call-template name="gu:I10349475"><xsl:with-param name="section">Imports</xsl:with-param></xsl:call-template><xsl:for-each select="$gu:O10619462"><xsl:element name="xsd:import"><xsl:attribute name="namespace" select="@namespace"/><xsl:attribute name="schemaLocation" select="gu:O11856680(.,$gu:I10712615,$gu:I12212381)"/></xsl:element></xsl:for-each><xsl:copy-of select="imports/node()"/></xsl:if><xsl:if test="not($gu:O12091466='QDT')"><xsl:call-template name="gu:I10262505"/></xsl:if><xsl:call-template name="gu:O10176984"/></xsd:schema><xsl:for-each select="(copyright,ancestor::schema/copyright)[1][@position='end']"><xsl:comment> ===== Copyright Notice ===== </xsl:comment><xsl:comment select="."/></xsl:for-each></xsl:template><xsl:template name="gu:I10262505"><xsl:param name="gu:O11742674" tunnel="yes" as="element(Row)*"/><xsl:param name="gu:I11630839" tunnel="yes" as="element(Row)*"/><xsl:param name="gu:O12091466" tunnel="yes" as="xsd:string"/><xsl:param name="gu:I12212381" tunnel="yes" as="xsd:boolean"/><xsl:variable name="gu:I10712615" select="."/><xsl:call-template name="gu:I10349475"><xsl:with-param name="section">Element Declarations</xsl:with-param></xsl:call-template><xsl:choose><xsl:when test="$gu:O12091466=('DABIE','XABIE','AABIE')"><xsl:element name="xsd:element"><xsl:attribute name="name" select="$gu:O11742674/gu:O203539688(.,$gu:O407079376)"/><xsl:attribute name="type" select="concat($gu:O11742674/ gu:O203539688(.,$gu:O407079376),'Type')"/><xsl:for-each select="(element-documentation, $gu:O67846562/combination/configuration/schema/element-documentation) [1][not($gu:I12212381)]"><xsl:element name="xsd:annotation"><xsl:element name="xsd:documentation"><xsl:copy-of select="node()" copy-namespaces="no"/></xsl:element></xsl:element></xsl:for-each></xsl:element></xsl:when><xsl:when test="$gu:O12091466=('CABIE','SABIE')"><xsl:variable name="gu:I10092877" as="element(pair)*"><xsl:if test="$gu:O35918768"><xsl:for-each select="$gu:O11742674 [$gu:O12091466='CABIE' or not(gu:O10527914(.))] [gu:I26548655(.)][not(gu:O10527914(.))] [not( some $gu:O10010148 in $gu:O50884922 satisfies $gu:O10010148 is . )] [gu:O203539688(.,'ComponentType')='ABIE' or not( for $gu:O22615520 in gu:O203539688(.,'AssociatedObjectClass') return $gu:I610619065/key('gu:I22204329',$gu:O22615520))]"><xsl:variable name="type" select="(gu:O111021648(.,'AssociatedObjectClass')[normalize-space(.)], gu:O111021648(.,'ObjectClass'))[1]"/><pair den="{gu:O203539688(.,'DictionaryEntryName')}" typedElement=""><name><xsl:value-of select="$type"/></name><xsl:text>&#xD;</xsl:text><type><xsl:value-of select="$type"/></type></pair></xsl:for-each></xsl:if><xsl:for-each select="$gu:O11742674/ key('gu:I20020297',gu:O203539688(.,'ObjectClass'),$gu:O1221238130) [$gu:O12091466=('CABIE','SABIE') or not(gu:O10527914(.)) ] [gu:I26548655(.)]"><pair den="{gu:O203539688(.,'DictionaryEntryName')}"><xsl:attribute name="gu:O29077098" select="gu:O29077098(preceding-sibling::Row [gu:O203539688(.,'ComponentType')='ABIE'][1])"/><xsl:attribute name="gu:I26548655" select="gu:I26548655(.)"/><name><xsl:value-of select="gu:O203539688(.,$gu:O407079376)"/></name><xsl:text>&#xD;</xsl:text><type><xsl:for-each select="gu:O203539688(.,'AssociatedObjectClass')"><xsl:if test="$gu:I610619065/key('gu:I22204329',current())"><xsl:value-of select="$gu:I43615647"/></xsl:if><xsl:value-of select="translate(.,' ','')"/></xsl:for-each></type></pair></xsl:for-each></xsl:variable><xsl:for-each-group select="$gu:I10092877" group-by="name"><xsl:sort select="."/><xsl:element name="xsd:element"><xsl:attribute name="name" select="name"/><xsl:attribute name="type" select="concat(type,'Type')"/></xsl:element></xsl:for-each-group></xsl:when><xsl:when test="$gu:O12091466=('CBBIE','SBBIE')"><xsl:for-each-group select="$gu:I11630839[ gu:O29077098(preceding-sibling::Row [gu:O203539688(.,'ComponentType')='ABIE'][1])]" group-by="gu:O203539688(.,$gu:O407079376)"><xsl:sort select="current-grouping-key()"/><xsl:if test="$gu:O12091466='CBBIE' or not(gu:O10527914(.))"><xsl:element name="xsd:element"><xsl:attribute name="name" select="current-grouping-key()"/><xsl:attribute name="type" select="concat(current-grouping-key(),'Type')"/></xsl:element></xsl:if></xsl:for-each-group></xsl:when></xsl:choose></xsl:template><xsl:template name="gu:O10176984"><xsl:param name="gu:O12091466" tunnel="yes" as="xsd:string"/><xsl:param name="gu:I12212381" tunnel="yes" as="xsd:boolean"/><xsl:param name="gu:O11742674" tunnel="yes" as="element(Row)*"/><xsl:param name="gu:I11630839" tunnel="yes" as="element(Row)*"/><xsl:variable name="gu:I10712615" select="."/><xsl:variable name="gu:I9928765" select="(type-documentation, $gu:O67846562/combination/configuration/schema/type-documentation) [1][not($gu:I12212381)]"/><xsl:choose><xsl:when test="$gu:O12091466=('DABIE','CABIE','XABIE','AABIE','SABIE')"><xsl:variable name="gu:O9848694" select="if( $gu:O12091466 = ('DABIE','CABIE') ) then $gu:I45231041 else $gu:I42111659"/><xsl:variable name="gu:I9769905" select="if( $gu:O12091466 = 'DABIE' ) then $gu:I43615647 else if( $gu:O12091466=('XABIE','AABIE','SABIE') ) then $gu:I40707937 else ''"/><xsl:call-template name="gu:I10349475"><xsl:with-param name="section" select="'Type Definitions', 'Aggregate Business Information Entity Type Definitions'"/></xsl:call-template><xsl:for-each-group select="( $gu:O11742674[gu:O203539688(.,'ComponentType')='ABIE'], $gu:O11742674[gu:O203539688(.,'ComponentType')='ASBIE']/ key('gu:I22204329',gu:O203539688(.,'AssociatedObjectClass')) ) [not(gu:O10527914(.))]" group-by="gu:O203539688(.,'ObjectClass')"><xsl:sort select="current-grouping-key()"/><xsl:variable name="gu:O9692366" select="."/><xsl:choose><xsl:when test="not($gu:O34892518) and not($gu:O35918768) and not(gu:O15458710(.)) and not(gu:I16503217(.))"><xsl:if test="not($gu:I12212381) and $gu:O37007216"><xsl:comment><xsl:text>Subset has no use of: den="</xsl:text><xsl:value-of select="gu:O203539688(.,'DictionaryEntryName')"/><xsl:text>"</xsl:text></xsl:comment><xsl:text>
   </xsl:text></xsl:if></xsl:when><xsl:when test="not( gu:O29077098(.) )"><xsl:if test="not($gu:I12212381) and $gu:O37007216"><xsl:comment><xsl:text>Subset excludes: den="</xsl:text><xsl:value-of select="gu:O203539688(.,'DictionaryEntryName')"/><xsl:text>"</xsl:text></xsl:comment><xsl:text>
   </xsl:text></xsl:if></xsl:when><xsl:otherwise><xsl:element name="xsd:complexType"><xsl:attribute name="name" select="concat(gu:O111021648(.,'ObjectClass'),'Type')"/><xsl:for-each select="$gu:I9928765"><xsl:element name="xsd:annotation"><xsl:element name="xsd:documentation"><xsl:apply-templates select="*" mode="gu:O9616048"><xsl:with-param name="bie" tunnel="yes" select="$gu:O9692366"/></xsl:apply-templates></xsl:element></xsl:element></xsl:for-each><xsl:element name="xsd:sequence"><xsl:if test="$gu:O12091466=('DABIE','AABIE')"><xsl:apply-templates mode="gu:O9540922" select="key('gu:I87231295','EXT',$gu:O67846562)/elements/node()"/></xsl:if><xsl:for-each select="key('gu:O13877706', gu:O203539688($gu:O9692366,'ObjectClass'), $gu:O1221238130)"><xsl:variable name="gu:O9466962" select="."/><xsl:variable name="gu:I9394139" select="gu:O203539688(.,'ComponentType')"/><xsl:variable name="gu:O9322428" select="gu:O203539688(.,'AssociatedObjectClass')"/><xsl:variable name="gu:O9251804" select="$gu:O12091466='CABIE' or gu:O10527914($gu:O9466962)"/><xsl:variable name="gu:I9182241" select="gu:I15077013(.)"/><xsl:variable name="gu:I9113717" select="gu:I14893147(.)"/><xsl:variable name="gu:O9046208" select="normalize-space(gu:O203539688(.,'Cardinality'))"/><xsl:variable name="gu:O8979692" select="normalize-space(gu:O203539688(.,$gu:I33923281))"/><xsl:variable name="gu:O8914146" select="concat( if( $gu:I9394139='BBIE' ) then if( $gu:O9251804 ) then $gu:I45231041 else $gu:O9848694 else if( $gu:O9251804 ) then $gu:I43615647 else $gu:I9769905 ,gu:O203539688(.,$gu:O407079376))"/><xsl:choose><xsl:when test="not(gu:I26548655(.))"><xsl:if test="not($gu:I12212381) and $gu:O37007216"><xsl:if test="position()=1 and not($gu:O12091466=('DABIE','AABIE'))"><xsl:text>
         </xsl:text></xsl:if><xsl:comment><xsl:text>Subset excludes: ref="</xsl:text><xsl:value-of select="$gu:O8914146"/><xsl:text>" cardinality="</xsl:text><xsl:value-of select="$gu:O9046208"/><xsl:text>" den="</xsl:text><xsl:value-of select="gu:O203539688(.,'DictionaryEntryName')"/><xsl:text>"</xsl:text></xsl:comment><xsl:text>
         </xsl:text></xsl:if></xsl:when><xsl:otherwise><xsl:element name="xsd:element"><xsl:attribute name="ref" select="$gu:O8914146"/><xsl:attribute name="minOccurs" select="$gu:I9182241"/><xsl:attribute name="maxOccurs" select="$gu:I9113717"/><xsl:if test="not($gu:I12212381) and $gu:O8979692!='' and not( $gu:O8979692=$gu:O9046208 ) and $gu:O31313798 and $gu:O37007216"><xsl:text>
            </xsl:text><xsl:comment><xsl:text>Subset changes: ref="</xsl:text><xsl:value-of select="$gu:O8914146"/><xsl:text>"; original cardinality="</xsl:text><xsl:value-of select="$gu:O9046208"/><xsl:text>" den="</xsl:text><xsl:value-of select="gu:O203539688(.,'DictionaryEntryName')"/><xsl:text>"</xsl:text></xsl:comment><xsl:text>
            </xsl:text></xsl:if><xsl:for-each select="$gu:I9928765"><xsl:element name="xsd:annotation"><xsl:element name="xsd:documentation"><xsl:apply-templates select="*" mode="gu:O9616048"><xsl:with-param name="bie" tunnel="yes" select="$gu:O9466962"/></xsl:apply-templates></xsl:element></xsl:element></xsl:for-each></xsl:element></xsl:otherwise></xsl:choose></xsl:for-each><xsl:copy-of select="$gu:I10712615/elements[ @abie=gu:O203539688($gu:O9692366,$gu:O407079376)]/node()"/></xsl:element></xsl:element></xsl:otherwise></xsl:choose></xsl:for-each-group></xsl:when><xsl:when test="$gu:O12091466=('CBBIE','SBBIE')"><xsl:call-template name="gu:I10349475"><xsl:with-param name="section" select="'Type Definitions', 'Basic Business Information Entity Type Definitions'"/></xsl:call-template><xsl:for-each-group select="$gu:I11630839" group-by="gu:O203539688(.,$gu:O407079376)"><xsl:sort select="concat(current-grouping-key(),'Type')"/><xsl:if test="$gu:O12091466 = 'CBBIE' or not( gu:O10527914(.) )"><xsl:element name="xsd:complexType"><xsl:attribute name="name" select="concat(current-grouping-key(),'Type')"/><xsl:variable name="gu:I8849551" select="gu:O203539688(.,'DataType')"/><xsl:variable name="gu:I8785885" select="if( contains( $gu:I8849551, '_' ) ) then substring-after($gu:I8849551,'_') else $gu:I8849551"/><xsl:variable name="gu:I8723129" select="contains($gu:I8849551, '_') and not($gu:O12855138)"/><xsl:element name="xsd:simpleContent"><xsl:element name="{if( $gu:O12855138 ) then 'xsd:extension' else 'xsd:restriction'}"><xsl:attribute name="base"><xsl:choose><xsl:when test="$gu:I8723129"><xsl:value-of select="concat(key('gu:I87231295','QDT',$gu:O67846562) /@prefix,':', translate($gu:I8849551,'_ .',''))"/></xsl:when><xsl:otherwise><xsl:value-of select="concat(key('gu:I87231295','UDT',$gu:O67846562) /@prefix,':', translate($gu:I8785885,' .',''))"/></xsl:otherwise></xsl:choose></xsl:attribute></xsl:element></xsl:element></xsl:element></xsl:if></xsl:for-each-group></xsl:when><xsl:when test="$gu:O12091466=('QDT')"><xsl:call-template name="gu:I10349475"><xsl:with-param name="section" select="'Qualified Data Type Definitions'"/></xsl:call-template><xsl:for-each-group select="$gu:I11630839" group-by="gu:O203539688(.,'DataType')"><xsl:sort select="current-grouping-key()"/><xsl:element name="xsd:complexType"><xsl:attribute name="name" select="translate(current-grouping-key(),'_ .','')"/><xsl:element name="xsd:simpleContent"><xsl:element name="{if( $gu:O12855138 ) then 'xsd:extension' else 'xsd:restriction'}"><xsl:attribute name="base"><xsl:variable name="gu:I8849551" select="gu:O203539688(.,'DataType')"/><xsl:value-of select="concat(key('gu:I87231295','UDT',$gu:O67846562) /@prefix,':', translate(substring-after($gu:I8849551,'_'),' .',''))"/></xsl:attribute></xsl:element></xsl:element></xsl:element></xsl:for-each-group></xsl:when></xsl:choose></xsl:template><xsl:template match="*" mode="gu:O9616048"><xsl:param name="bie" tunnel="yes" as="element(Row)"/><xsl:choose><xsl:when test="*"><xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates select="*" mode="gu:O9616048"/></xsl:copy></xsl:when><xsl:otherwise><xsl:if test="gu:O203539688($bie,.)[normalize-space(.)]"><xsl:copy><xsl:copy-of select="@*"/><xsl:value-of select="gu:O203539688($bie,.)"/></xsl:copy></xsl:if></xsl:otherwise></xsl:choose></xsl:template><xsl:template match="xsd:annotation | text()" mode="gu:O9540922"><xsl:param name="gu:I12212381" tunnel="yes" as="xsd:boolean"/><xsl:if test="not($gu:I12212381)"><xsl:next-match/></xsl:if></xsl:template><xsl:template match="*" mode="gu:O9540922"><xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates mode="gu:O9540922"/></xsl:copy></xsl:template><xsl:template match="/*" mode="gu:I10807417"><xsl:copy><xsl:apply-templates mode="gu:I10807417" select="@*,node()"><xsl:with-param name="contexts" as="element(Context)*" tunnel="yes"><xsl:apply-templates select="Contexts/Context" mode="gu:I10807417"/></xsl:with-param></xsl:apply-templates></xsl:copy></xsl:template><xsl:template match="@*|node()" mode="gu:I10807417"><xsl:copy><xsl:apply-templates mode="gu:I10807417" select="@*,node()"/></xsl:copy></xsl:template><xsl:template match="InstanceMetadataSets/text() | ValueLists/text()" mode="gu:I10807417"/><xsl:template match="ValueList" mode="gu:I10807417"><xsl:param name="contexts" as="element(Context)*" tunnel="yes"/><xsl:if test="exists($contexts[tokenize(@values,'\s+')=current()/@xml:id])"><xsl:copy><xsl:apply-templates mode="gu:I10807417" select="@*,node()"/></xsl:copy></xsl:if></xsl:template><xsl:template match="InstanceMetadataSet" mode="gu:I10807417"><xsl:param name="contexts" as="element(Context)*" tunnel="yes"/><xsl:if test="exists($contexts[@metadata=current()/@xml:id])"><xsl:copy><xsl:apply-templates mode="gu:I10807417" select="@*,node()"/></xsl:copy></xsl:if></xsl:template><xsl:template match="Contexts" mode="gu:I10807417"><xsl:param name="contexts" as="element(Context)*" tunnel="yes"/><xsl:copy><xsl:copy-of select="@*,Annotation,$contexts"/></xsl:copy></xsl:template><xsl:template match="Context[Annotation/AppInfo/dt:DataType]" mode="gu:I10807417"><xsl:variable name="gu:I8661263" select="gu:I8661263(Annotation/AppInfo/dt:DataType, @address)"/><xsl:copy><xsl:copy-of select="@*"/><xsl:attribute name="address" select="(normalize-space($gu:I8661263)[string(.)],'/*[parent::*]')[1]"/><xsl:copy-of select="*"/></xsl:copy></xsl:template><xsl:function name="gu:I8661263" as="xsd:string"><xsl:param name="gu:I8785885" as="xsd:string+"/><xsl:param name="gu:O8600268" as="xsd:string?"/><xsl:value-of><xsl:for-each-group select="for $each in $gu:I8785885 return key('gu:I13420199',$each,$gu:O1221238130) [gu:I26548655(.)]" group-by="gu:O203539688(.,$gu:O407079376)"><xsl:sort select="current-grouping-key()"/><xsl:if test="position()&gt;1"> | </xsl:if><xsl:choose><xsl:when test="count(distinct-values( key('gu:I14367507',current-grouping-key())/ gu:O203539688(.,'DataTypeQualifier')/string(.)))&gt;1"><xsl:variable name="gu:O8540126" select="current-group()/ preceding-sibling::Row[gu:O203539688(.,'ComponentType')='ABIE'][1]"/><xsl:variable name="gu:O8480820" select="$gu:O8540126/gu:O203539688(.,'ObjectClass')/ key('gu:I15656899',.) [gu:I26548655(.)]"/><xsl:for-each select="$gu:O8480820"><xsl:sort select="gu:O203539688(.,$gu:O407079376)"/><xsl:if test="position()&gt;1"> | </xsl:if><xsl:value-of select="concat($gu:I43615647, gu:O203539688(.,$gu:O407079376), '/', $gu:I45231041, current-grouping-key(), $gu:O8600268)"/></xsl:for-each></xsl:when><xsl:otherwise><xsl:value-of select="concat($gu:I45231041, current-grouping-key(), $gu:O8600268)"/></xsl:otherwise></xsl:choose></xsl:for-each-group></xsl:value-of></xsl:function><xsl:function name="gu:O11856680" as="xsd:string"><xsl:param name="gu:I8422331" as="element()"/><xsl:param name="gu:O8364644" as="element()"/><xsl:param name="gu:I12212381" as="xsd:boolean"/><xsl:variable name="gu:O8307742" select="($gu:I8422331/ancestor::dir[@name=$gu:O8364644/ancestor::dir/@name][1], $gu:I8422331/ancestor::schema)[1]"/><xsl:variable name="gu:O8251608" select="($gu:O8364644/ancestor::dir[@name=$gu:I8422331/ancestor::dir/@name][1], $gu:O8364644/ancestor::schema)[1]"/><xsl:value-of><xsl:for-each select="$gu:O8364644/ancestor::*[ancestor::*[. is $gu:O8251608]]"><xsl:text>../</xsl:text></xsl:for-each><xsl:for-each select="$gu:I8422331/ancestor::*[ancestor::*[. is $gu:O8307742]]"><xsl:value-of select="if( @runtime-name and $gu:I12212381 ) then @runtime-name else @name"/><xsl:text>/</xsl:text></xsl:for-each><xsl:value-of select="$gu:I8422331/@name"/></xsl:value-of></xsl:function><xsl:template name="gu:I12461613"><xsl:choose><xsl:when test="boolean($base-uri) != exists($gu:O93941394[@type=('XABIE','AABIE')])"><xsl:text>Creating extension/addition constructs requires and </xsl:text><xsl:text>satisfies base-uri being specified.  One cannot </xsl:text><xsl:text>have one without having the other.
</xsl:text></xsl:when></xsl:choose><xsl:for-each select="$gu:O1221238130,$gu:I610619065"><xsl:choose><xsl:when test="namespace-uri(/*) != 'http://docs.oasis-open.org/codelist/ns/genericode/1.0/' or local-name(/*) != 'CodeList'"><xsl:text>Expected {http://docs.oasis-open.org/codelist/ns/</xsl:text><xsl:text>genericode/1.0/}CodeList as the document element of "</xsl:text><xsl:value-of select="document-uri(/)"/><xsl:text>", but found the document element: </xsl:text><xsl:value-of select="concat('{',namespace-uri(/*),'}',local-name(/*))"/><xsl:text>
</xsl:text></xsl:when><xsl:otherwise><xsl:variable name="gu:I8196229" as="element()*"><xsl:for-each-group group-by="gu:O203539688(.,'ModelName')" select="/*/SimpleCodeList/Row[gu:O203539688(.,'ComponentType')='ABIE']"><model name="{current-grouping-key()}" abie-count="{count(current-group())}"/></xsl:for-each-group></xsl:variable><xsl:if test="count($gu:I8196229[@abie-count&gt;1])&gt;1"><xsl:text>Found in the genericode input too many common </xsl:text><xsl:text>library models with multiple ABIE constructs: </xsl:text><xsl:value-of select="$gu:I8196229[@abie-count&gt;1]" separator=","/><xsl:text>
</xsl:text></xsl:if></xsl:otherwise></xsl:choose></xsl:for-each><xsl:call-template name="gu:I17446259"/><xsl:for-each select="$gu:O101769844, $gu:I71837537"><xsl:choose><xsl:when test="not(/configuration)"><xsl:text>Expected {}configuration as the document element of </xsl:text><xsl:text>the configuration file, but in "</xsl:text><xsl:value-of select="document-uri(/)"/><xsl:text>" found the document element: </xsl:text><xsl:value-of select="concat('{',namespace-uri(/*),'}',local-name(/*))"/><xsl:text>
</xsl:text></xsl:when><xsl:otherwise><xsl:if test="not(/*/ndr) and not(/*/schema)"><xsl:text>The configuration file must have an ndr section </xsl:text><xsl:text>and/or a schema section and neither has been </xsl:text><xsl:text>detected.
</xsl:text></xsl:if><xsl:if test="exists(/*/ndr/abbreviations)"><xsl:text>The use of &lt;abbreviations&gt; is archaic and </xsl:text><xsl:text>the configuration file needs to be modified.
</xsl:text></xsl:if><xsl:if test="not(normalize-space(/*/schema/@version))"><xsl:text>A version of the suite of schemas must be specified </xsl:text><xsl:text>using version= on the configuration file document </xsl:text><xsl:text>element.
</xsl:text></xsl:if><xsl:for-each select="/*/schema/copyright"><xsl:if test="not(@position=('start','end'))"><xsl:text>Every copyright statement must have </xsl:text><xsl:text>position="start" or position="end": </xsl:text><xsl:value-of select="gu:I76327383(.)"/><xsl:text>
</xsl:text></xsl:if></xsl:for-each><xsl:for-each select="/*/schema//(file|files)"><xsl:choose><xsl:when test="@type='CVA' and not(normalize-space(@name)) and not(normalize-space(@skeleton))"><xsl:text>Each of type= and name= and skeleton= must be </xsl:text><xsl:text>specified: </xsl:text><xsl:value-of select="gu:I76327383(.)"/><xsl:text>
</xsl:text></xsl:when><xsl:when test="not(normalize-space(@type)) or not(normalize-space(@name)) or (@type != 'CVA' and not(normalize-space(@namespace)))"><xsl:text>Each of type=, name= and namespace= must be </xsl:text><xsl:text>specified: </xsl:text><xsl:value-of select="gu:I76327383(.)"/><xsl:text>
</xsl:text></xsl:when><xsl:when test="not(@type=('CABIE','CBBIE','QDT','UDT','EXT','DABIE', 'CVA','XABIE','AABIE','SABIE','SBBIE'))"><xsl:text>Invalid type attribute: </xsl:text><xsl:value-of select="gu:I76327383(.)"/><xsl:text>
</xsl:text></xsl:when><xsl:when test="@abie and (not(self::file) or not(@type=('DABIE','AABIE','XABIE')))"><xsl:text>abie= can only be specified for a single </xsl:text><xsl:text>file with type 'DABIE', 'XABIE' or 'AABIE': </xsl:text><xsl:value-of select="gu:I76327383(.)"/><xsl:text>
    </xsl:text></xsl:when><xsl:when test="@type=('DABIE','AABIE','XABIE') and count($gu:O53097310)=0"><xsl:text>No document-level ABIEs supplied to satisfy type='</xsl:text><xsl:value-of select="@type"/><xsl:text>': </xsl:text><xsl:value-of select="gu:I76327383(.)"/><xsl:text>
</xsl:text></xsl:when><xsl:when test="self::files and not(@type=( 'DABIE','XABIE','AABIE'))"><xsl:text>&lt;files&gt; must have a type of DABIE, XABIE or AABIE': </xsl:text><xsl:value-of select="gu:I76327383(.)"/><xsl:text>
</xsl:text></xsl:when></xsl:choose><xsl:if test="@type='CVA'"><xsl:variable name="gu:I11002145" select="document(@skeleton-uri)"/><xsl:if test="not($gu:I11002145)"><xsl:text>Unable to open specified input CVA skeleton file "</xsl:text><xsl:value-of select="@skeleton-uri"/><xsl:text>" relative to configuration file: </xsl:text><xsl:value-of select="base-uri(@skeleton-uri)"/><xsl:text>
</xsl:text></xsl:if><xsl:for-each select="$gu:I11002145"><xsl:if test="local-name(/*) != 'ContextValueAssociation' or namespace-uri(/*) != 'http://docs.oasis-open.org/codelist/ns/ContextValueAssociation/1.0/'"><xsl:text>Expected {http://docs.oasis-open.org/codelist/ns/</xsl:text><xsl:text>ContextValueAssociation/1.0/}ContextValueAssociation</xsl:text><xsl:text> as the document element of </xsl:text><xsl:text>the input file "</xsl:text><xsl:value-of select="document-uri(/)"/><xsl:text>", but found the document element: </xsl:text><xsl:value-of select="concat('{',namespace-uri(/*),'}',local-name(/*))"/><xsl:text>
</xsl:text></xsl:if></xsl:for-each></xsl:if></xsl:for-each></xsl:otherwise></xsl:choose></xsl:for-each></xsl:template><xsl:template name="gu:I10349475"><xsl:param name="section" as="xsd:string+"/><xsl:param name="gu:I12212381" tunnel="yes" as="xsd:boolean"/><xsl:if test="not($gu:I12212381)"><xsl:text>
   </xsl:text><xsl:for-each select="$section"><xsl:comment> ===== <xsl:value-of select="."/> ===== </xsl:comment><xsl:text>
   </xsl:text></xsl:for-each></xsl:if></xsl:template><xsl:function name="gu:O10527914" as="xsd:boolean"><xsl:param name="gu:O9466962" as="element(Row)"/><xsl:variable name="gu:I8141587" select="gu:O203539688($gu:O9466962,$gu:O407079376)"/><xsl:choose><xsl:when test="gu:O203539688($gu:O9466962,'ComponentType')='BBIE'"><xsl:sequence select="boolean($gu:I610619065/key('gu:I14200443','BBIE',.) [gu:O203539688(.,$gu:O407079376)=$gu:I8141587])"/></xsl:when><xsl:when test="gu:O203539688($gu:O9466962,'ComponentType')='ASBIE'"><xsl:sequence select="boolean($gu:I610619065/key('gu:I14200443','ASBIE',.) [gu:O203539688(.,$gu:O407079376)=$gu:I8141587])"/></xsl:when><xsl:otherwise><xsl:sequence select="boolean($gu:I610619065/key('gu:I14200443','ABIE',.) [gu:O203539688(.,'ModelName')=$gu:I64275691] [gu:O203539688(.,$gu:O407079376)=$gu:I8141587])"/></xsl:otherwise></xsl:choose></xsl:function></xsl:stylesheet>
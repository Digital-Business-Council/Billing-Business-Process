Crane-checkgc4obdndr-obfuscated.xsl

This is a stylesheet to analyze the genericode representation of a OASIS
Business Document NDR 3.0 CCTS model, reporting on inconsistencies or 
invalidly-expressed values. The version of NDR implemented by these 
stylesheets is found at:

  http://docs.oasis-open.org/ubl/UBL-NDR/v3.0/UBL-NDR-v3.0.html
  
Note that only the COMxx and MODxx rules that are programmatically tested are
tested by this stylesheet, as those rules are for the CCTS model.  This
stylesheet does not test any generated schemas for conformance to the NDR,
a genericode-expressed CCTS model.

When two models are supplied as arguments the stylesheet creates reports of
the differences between the two, including an analysis of non-backward-
compatible changes.  The difference reports can be exported as DocBook tables.

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

Typical invocation (HTML output to standard output):

  java -jar saxon9he.jar {arguments}

Mandatory Invocation arguments (URI's are relative to the input):

 - stylesheet file:            -xsl:Crane-checkgc4obdndr-obfuscated.xsl
 - input new genericode file   -s:{filename}
 - output HTML file            -o:filename
 - document title suffix       "title-suffix={string}"
   - this is added to the title of the generated report
 - configuration details       +config={filename} or config-uri={filename}
   - this is the same configuration file that is input to the Crane-gc2obdndr
     stylesheet that creates the schemas from the CCTS model

Necessary invocation argument when the common library has exactly one ABIE:

 - specify the model name      common-library-singleton-model-name={string}

Optional invocation arguments (where URI's are relative to the input):

 - old genericode file                 +old={filename} or old-uri={filename}
   - to specify an older version of the model to analyze a comparison
 - base genericode file                +base={filename} or base-uri={filename}
   - to specify a base library for use by extension components
 - pre-created xsd base directory      xsd-dir-uri={filename}
   - specifying this engages the NDR tests of the XSD files
 - pre-created xsdrt base directory    xsdrt-dir-uri={filename}
   - specifying this engages the NDR tests of the XSD files

Optional invocation arguments (where URI's are relative to the output):

 - output DocBook file URI common      docbook-common-uri=file://{filename}
 - output DocBook file URI maindoc     docbook-maindoc-uri=file://{filename}

Optional invocation arguments:

 - change column title suffix               "change-suffix={string}"
   - this is added in the title row of the table summarizing changes from
     the old genericode file to the new genericode file
 - a particular subset of some models       subset-model-regex={string}
 - a particular subset of some constructs   subset-column-name={string-no-sp}
   - the string value of the column name must have all of the spaces removed
     from the column name in the spreadsheet used to create the genericode file
 - useful during development                ignore-sort-rule={no(default)/yes}
 
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

IMPLEMENTATION NOTE:

This stylesheet logic does not accommodate qualified object classes.

TECHNICAL NOTE:

This stylesheet has been purposely obfuscated and all comments have been
removed.  Please respect our copyright and do not attempt to reverse 
engineer the techniques involved.

(For those readers who are curious, the latest NDR document is dated after the
UBL 2.1 schemas were published and so there are a number of errors reported for
UBL 2.1 that will be repaired in future versions)

Configuration details file:

The configuration file has two major sections, the <ndr> section and the 
<schema> section.

The <ndr> section describes properties of the use of the naming and design
rules, such as abbreviations, equivalences, expected BIEs and data types.  This
information is not used in the schema generation.

All allowed abbreviations must be itemized as these are the portions of 
element names that do not satisfy the UpperCamelCase convention.  What is not
shown in the example below is that the <abbreviation> element can have an
optional valuesOnly="" or namesOnly="" attribute to indicate that the
abbreviation is not applicable to both values and names.

All equivalences between primary nouns and representation terms must be
itemized.

All fields allowing excess space characters must be named by their genericode
column names.

All mandatory BIEs for each maindoc must be itemized with their cardinality
and, optionally, their order.

All allowed unqualified data types must be itemized to ensure nothing 
unsupported is asked for.

The <schema> section describes all of the directories and files that are 
created or files that are needed by the files that are created as part of 
schema generation.  See the documentation for the schema generation program for
details.

This checking program only checks the model-related NDRs of MODxx and COMxx.  
The schema-related rules are not checked.

The configuration file used for UBL 2.1 is found in the ubl/ directory, and for
BDE 1.1 in the bde/ directory.


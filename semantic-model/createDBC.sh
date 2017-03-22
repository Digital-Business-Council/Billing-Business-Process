args=( ) # "subset-model-regex=-Invoice-" subset-column-name=SubsetTest subset-absent-is-zero=yes subset-include-type-elements=no subset-include-ignored-types=no

gc2obdndr=Crane-gc2obdndr-20160626-0140z
cvagcxsl=Crane-cva-gc-xsl-20130416-0040z
cva2sch=Crane-cva2sch-20130207-1940z
saxon9he=saxon9he


echo Creating genericode from spreadsheet model ...
java -jar ./saxon9he/saxon9he.jar  -it:ods-uri ods-uri=./DBC-AU/models/DBC-CoreInvoice-1.0.ods -xsl:./Crane-ods2obdgc-obfuscated.xsl -o:./DBC-AU/models/DBC-CoreInvoice-1.0.gc  "title-suffix=Invoice core" "change-suffix=Core"
if [ "$?" != "0" ]; then exit ; fi


echo DBC Core Invoice document...
echo ...checking...
java -jar $saxon9he/saxon9he.jar -o:DBC-AU/models/checkDBCCoreInvoice.html -s:DBC-AU/models/DBC-CoreInvoice-1.0.gc -xsl:$gc2obdndr/Crane-checkgc4obdndr-obfuscated.xsl config-uri=config-DBC-1.0.xml "title-suffix=DBC Core Invoice 1.0"
if [ "$?" != "0" ]; then exit ; fi

echo ...building schemas...
java -jar $saxon9he/saxon9he.jar -s:DBC-AU/models/DBC-CoreInvoice-1.0.gc -xsl:$gc2obdndr/Crane-gc2obdndr-obfuscated.xsl -o:junk.out config-uri=config-DBC-1.0.xml 
if [ "$?" != "0" ]; then exit ; fi

echo ...summarizing reports...
java -jar $saxon9he/saxon9he.jar -o:DBC-AU/models/junk.out -s:DBC-AU/models/DBC-CoreInvoice-1.0.gc -xsl:$gc2obdndr/Crane-gc2obdsummary-obfuscated.xsl "title-prefix=Digital Business Council" subset-exclusions=no "doc-column-names-regex=InformationElement"
if [ "$?" != "0" ]; then exit ; fi

echo ...documenting CVA...
java -jar $saxon9he/saxon9he.jar -o:DBC-AU/cva/CoreInvoice-1.0.html -s:DBC-AU/cva/CoreInvoice-1.0.cva -xsl:$cvagcxsl/Crane-cva2html.xsl -versionmsg:off

echo ...creating Schematron and XSLT from CVA...
java -jar $saxon9he/saxon9he.jar -o:DBC-AU/cva/temp.cva.xsl -s:DBC-AU/cva/CoreInvoice-1.0.cva -xsl:$cva2sch/utility/Crane-cva2schXSLT.xsl -versionmsg:off
if [ "$?" != "0" ]; then exit ; fi
java -jar $saxon9he/saxon9he.jar -o:DBC-AU/cva/CoreInvoice-1.0.pattern.sch -s:DBC-AU/cva/temp.cva.xsl -xsl:DBC-AU/cva/temp.cva.xsl -versionmsg:off
if [ "$?" != "0" ]; then exit ; fi
java -jar $saxon9he/saxon9he.jar -o:DBC-AU/cva/temp.xsl.sch -s:DBC-AU/schematron/XSLT/CoreInvoice-1.0.sch -xsl:$cva2sch/utility/iso_schematron_assembly.xsl -versionmsg:off
if [ "$?" != "0" ]; then exit ; fi
java -jar $saxon9he/saxon9he.jar -o:DBC-AU/cva/CoreInvoice-1.0.xsl -s:DBC-AU/cva/temp.xsl.sch -xsl:$cva2sch/utility/Message-Schematron-terminator.xsl -versionmsg:off
if [ "$?" != "0" ]; then exit ; fi
rm DBC-AU/cva/temp.xsl.sch DBC-AU/cva/temp.cva.xsl

#echo ...testing conformant instance against Schematron...
#java -jar $saxon9he/saxon9he.jar -s:DBC-AU/testsets/SampleInvoice-ConformantInvoice.xml -xsl:DBC-AU/cva/CoreInvoice-1.0.xsl -versionmsg:off -warnings:silent
#if [ "$?" != "0" ]; then echo "Result: error reported" ; else echo "Result: no error reported" ; fi

#echo ...reports ordered by information element...
#java -jar $saxon9he/saxon9he.jar -o:summaryInformationElements/junk.out -s:DBC-AU/models/DBC-CoreInvoice-1.0.gc -xsl:$gc2obdndr/Crane-gc2obdsummary-obfuscated.xsl "title-prefix=Digital Business Council" "doc-column-names-regex=InformationElement" subset-exclusions=no ABIE-sort-column-name=InformationElement
#if [ "$?" != "0" ]; then exit ; fi

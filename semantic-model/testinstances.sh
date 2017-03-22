gc2obdndr=./Crane-gc2obdndr-20160626-0140z
cvagcxsl=./Crane-cva-gc-xsl-20130416-0040z
cva2sch=./Crane-cva2sch-20130207-1940z
saxon9he=./saxon9he

echo ...testing conformant instance against Schematron...
java -jar $saxon9he/saxon9he.jar -s:DBC-AU/testsets/SampleInvoice-ConformantInvoice.xml -xsl:DBC-AU/cva/CoreInvoice-1.0.xsl -versionmsg:off -warnings:silent
if [ "$?" != "0" ]; then echo "Result: error reported" ; else echo "Result: no error reported" ; fi

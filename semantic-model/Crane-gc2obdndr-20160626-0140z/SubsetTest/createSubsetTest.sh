args=( "subset-model-regex=-Invoice-" subset-column-name=SubsetTest subset-absent-is-zero=yes ) # "subset-model-regex=-Invoice-" subset-column-name=SubsetTest subset-absent-is-zero=yes subset-include-type-elements=no subset-include-ignored-types=no

echo SubsetTest document...
echo ...checking...
java -jar ../saxon9he/saxon9he.jar -o:checkSubsetTest-noschemas.html -s:mod/SubsetTest-Entities.gc -xsl:../Crane-checkgc4obdndr-obfuscated.xsl config-uri=../config-ubl-2.1-test-no-schema.xml "title-suffix=Demo Subset Test" "change-suffix=Demo" ${args[@]}
if [ "$?" != "0" ]; then exit ; fi

echo ...building minimal...
java -jar ../saxon9he/saxon9he.jar -s:mod/SubsetTest-Entities.gc -xsl:../Crane-gc2obdndr-obfuscated.xsl -o:minimal/junk.out config-uri=../config-ubl-2.1-test-no-ndr.xml qdt-for-UBL-2.1-only=yes ${args[@]} subset-exclusions=no
if [ "$?" != "0" ]; then exit ; fi

echo ...building annotated...
java -jar ../saxon9he/saxon9he.jar -s:mod/SubsetTest-Entities.gc -xsl:../Crane-gc2obdndr-obfuscated.xsl -o:annotated/junk.out config-uri=../config-ubl-2.1-test-no-ndr.xml qdt-for-UBL-2.1-only=yes ${args[@]} subset-exclusions=yes
if [ "$?" != "0" ]; then exit ; fi

echo ...summarizing minimal...
java -jar ../saxon9he/saxon9he.jar -o:minimal/summary/junk.out -s:mod/SubsetTest-Entities.gc -xsl:../Crane-gc2obdsummary-obfuscated.xsl "title-prefix=Demo Subset Test" ${args[@]} subset-exclusions=no
if [ "$?" != "0" ]; then exit ; fi

echo ...summarizing annotated...
java -jar ../saxon9he/saxon9he.jar -o:annotated/summary/junk.out -s:mod/SubsetTest-Entities.gc -xsl:../Crane-gc2obdsummary-obfuscated.xsl "title-prefix=Demo Subset Test" ${args[@]} subset-exclusions=yes
if [ "$?" != "0" ]; then exit ; fi



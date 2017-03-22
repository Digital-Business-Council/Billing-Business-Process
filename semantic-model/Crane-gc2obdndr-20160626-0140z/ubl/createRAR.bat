@echo off

echo RAR document...
echo ...checking...
java -jar ../saxon9he/saxon9he.jar -o:checkRAR.html -s:mod/MyRARequestResponse-Entities.gc -xsl:../Crane-checkgc4obdndr-obfuscated.xsl config-uri=../config-rar.xml base-uri=UBL-Entities-2.1.gc extension=yes base-config-uri=../config-ubl-2.1.xml "title-suffix=Demo RAR" "change-suffix=Demo"
if %errorlevel% neq 0 goto :done

echo ...building RARequest... 
java -jar ../saxon9he/saxon9he.jar -s:mod/MyRARequestResponse-Entities.gc -xsl:../Crane-gc2obdndr-obfuscated.xsl -o:junk.out config-uri=../config-rar.xml base-uri=UBL-Entities-2.1.gc base-config-uri=../config-ubl-2.1.xml qdt-for-UBL-2.1-only=yes
if %errorlevel% neq 0 goto :done

echo ...summarizing...
java -jar ../saxon9he/saxon9he.jar -o:summary/junk.out all-documents-base-name=RARDocuments -s:mod/MyRARequestResponse-Entities.gc -xsl:../Crane-gc2obdsummary-obfuscated.xsl config-uri=../config-rar.xml base-summary-uri=AllDocuments.html base-uri=UBL-Entities-2.1.gc "title-prefix=Demo RAR"
if %errorlevel% neq 0 goto :done

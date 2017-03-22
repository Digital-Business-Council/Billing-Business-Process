Crane-gc2obdsummary-obfuscated.xsl

This is a stylesheet to generate the summary HTML reports of CCTS models.

Copyright (C) - Crane Softwrights Ltd. 
              - http://www.CraneSoftwrights.com/links/res-dev.htm

Portions copyright (C) - OASIS Open 2016. All Rights Reserved.
                       - http://www.oasis-open.org/who/intellectualproperty.php

Typical invocation:

  java -jar saxon9he.jar {arguments}

Mandatory invocation arguments (URIs are relative to input genericode file):

 - stylesheet file:                     -xsl:Crane-gc2obdsummary-obfuscated.xsl
 - input genericode file                -s:{filename}
 - placebo output in target directory   -o:{dir}/junk.out
 - title prefix at report top           title-prefix={string}

Optional invocation arguments (column names have no spaces):

 - time stamp for the package              date-time={string}
 - amalgam report base name                all-documents-base-name={string}
   - when there is more than one document, this is the filename to use for
     the report that combines the members of all documents
 - which profile to report on              subset-column-name={string-no-sp}
 - only minimum subset of all models       subset-result={no(default)/yes}
   - this prunes away items that are never used by any model
 - a particular subset of some models      subset-model-regex={string}
 - a particular subset of some constructs  subset-column-name={string-no-sp}
   - the string value of the column name must have all of the spaces removed
     from the column name in the spreadsheet used to create the genericode file
 - lazy pruning of the model               subset-absent-is-zero=(no(def)/yes)
   - this only applies to items that have a minimum cardinality of 0; to
     preserve the item the original cardinality must be included in the subset
 - document the exclusion of items         subset-exclusions=(yes(default)/no)
 - document only the entire "all" model    do-all-only=(no(default)/yes)
 - reorganize the report                   ABIE-sort-column-name={string-no-sp}

Optional invocation arguments for summaries of extensions (both of which
must exist):

 - genericode file for base vocabulary      base-uri={filename}
 - the summary report of the base model     base-summary-uri={string}
   - use this to link out of an extension summary into the base model summary
 
Necessary invocation argument when the common library has exactly one ABIE:

 - specify the model name          common-library-singleton-model-name={string}

Optional invocation argument to support parallel processing invocation:

 - specify the group number        parallel-group-of-4={1,2,3,4} (default:all)
   - create only one quarter of the results (the "all" document is in group 4)

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

<cfscript>

  string function selectIfSingle(required array arr) {
    return 1 == ArrayLen(arr) ? ' selected ' : ' ';
  }

</cfscript>

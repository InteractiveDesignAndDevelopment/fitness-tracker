<cfscript>

  string function selectIfTrue(required boolean b) {
    return b ? ' selected ' : ' ';
  }

  string function selectIfSingle(required array arr) {
    return selectIfTrue(1 == ArrayLen(arr));
  }

</cfscript>

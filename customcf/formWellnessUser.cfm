<script>
  function validateForm() {
    var x = document.forms["userRegistration"]["Firstname"].value;
    if (x == null || x == "") {
      alert("Enter valid first name");
      return false;
    }
    x = document.forms["userRegistration"]["Lastname"].value;
    if (x == null || x == "") {
      alert("Enter valid last name");
      return false;
    }
    x = document.forms["userRegistration"]["Email"].value;
    if (x == '' || x.indexOf('@') == -1 || x.indexOf('.') == -1 || x.length < 6) {
      alert("Enter valid email address");
      return false;
    }
  }
</script>

<cfquery name="getWellnessUserTypes" datasource="dsnWellness">
SELECT
  ID
  , Name
FROM WellnessUserType
</cfquery>

<form name="userRegistration" action = "user-registered.cfm" onsubmit="return validateForm()" method="post">
  First name: <br />
  <input
    type = "Text" name = "Firstname"><br />
  Last name: <br />
  <input
    type = "Text" name = "Lastname"><br />
  Email address: <br />
  <input
    type = "Text" name = "Email"><br />
  <input type="hidden" name = "GroupID" value="">
  Employee or Student: <br />
  <select name="WellnessUserTypeID">
    <cfoutput query="getWellnessUserTypes">
      <option value="#ID#">#Name#</option>
    </cfoutput>
  </select>
  <br />
  <br />
  <input
    type = "Submit" name = "Submit"
    value = "Register">
</form>

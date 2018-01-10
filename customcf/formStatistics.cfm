<cfscript>
  Users = createObject('components.Users');
  allUsers = Users.all();

  Challenges = createObject('components.Challenges');
  allChallenges = Challenges.all();
</cfscript>

<!--- <script>
  function validateForm() {
    var x = document.forms["Statistics"]["WellnessUserID"].value;
    if (x == null || x == "") {
      alert("Select any registered email address");
      return false;
    }
  }
</script> --->

<!---
<cfquery name="getWellnessUsers" datasource="dsnWellness">
  SELECT
    ID,
    Email
    FROM WellnessUser
    ORDER BY Email
</cfquery>
--->

<!---
<cfquery name="getChallenges" datasource="dsnWellness">
  SELECT
    ID,
    Name
    FROM Challenge
    ORDER BY Name
</cfquery>
--->

<cfquery name="getActivityTypes" datasource="dsnWellness">
  SELECT
    ID,
    Name
    FROM ActivityType
    ORDER BY Name
</cfquery>

<CFQUERY NAME="getSumOfActivities" DATASOURCE="dsnWellness">
  SELECT
    SUM(Measure) AS SumOfMeasuresAll
  FROM Activity
  WHERE ChallengeID = 1
</CFQUERY>

<form action = "view-statistics-by-user.cfm" onsubmit="return validateForm()" name="Statistics" method="post">
  Email address<br />
  <select name="WellnessUserID">
    <option value="">Please select any registered email address</option>
    <cfoutput query="allUsers">
      <option value="#ID#">#Email#</option>
    </cfoutput>
  </select>
  <br />
  <br />
  Challenge<br />
  <select name="ChallengeID">
    <cfoutput query="allChallenges">
      <option value="#ID#">#Name#</option>
    </cfoutput>
  </select>
  <br />
  <br />
  Activity type<br />
  <select name="ActivityTypeID">
    <cfoutput query="getActivityTypes">
      <option value="#ID#">#Name#</option>
    </cfoutput>
  </select>
  <br />
  <br />
  <input
    type = "Submit" name = "Submit"
    value = "View Single User Statistics">
  </input>
</form>
<br />
<br />

<p>
Statistics for all of Mercer, Move More for Heart Health 2016<br />
<cfoutput query="getSumOfActivities">
  Total minutes of exercise: #NumberFormat(SumOfMeasuresAll, ",")#
  <div>#NumberFormat(SumOfMeasuresAll, ",")#</div>
</cfoutput>
</p>


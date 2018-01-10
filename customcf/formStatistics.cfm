<cfscript>
  Users = createObject('components.Users');
  Challenges = createObject('components.Challenges');
  ActivityTypes = createObject('components.ActivityTypes');
</cfscript>

<cfoutput>

  <form action="./view-statistics-by-user.cfm" method="post">
    Email address
    <select name="WellnessUserID">
      <option value="">Select an email address</option>
      <cfloop array="#Users.all()#" index="user">
        <option value="#user.getID()#">#user.getEmail()#</option>
      </cfloop>
    </select>

    <!--- Challenge<br />
    <select name="ChallengeID">
      <cfoutput query="allChallenges">
        <option value="#ID#">#Name#</option>
      </cfoutput>
    </select>
    --->

    <!---
    Activity type<br />
    <select name="ActivityTypeID">
      <cfoutput query="allActivityTypes">
        <option value="#ID#">#Name#</option>
      </cfoutput>
    </select>
    <br />
    <br />
    <input
      type = "Submit" name = "Submit"
      value = "View Single User Statistics">
    </input> --->
  </form>
  <br />
  <br />

  <!---
  <p>
  Statistics for all of Mercer, Move More for Heart Health 2016<br />
  <cfoutput query="getSumOfActivities">
    Total minutes of exercise: #NumberFormat(SumOfMeasuresAll, ",")#
    <div>#NumberFormat(SumOfMeasuresAll, ",")#</div>
  </cfoutput>
  </p>
  --->

</cfoutput>

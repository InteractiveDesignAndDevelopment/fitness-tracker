
<cfquery name="getusers" datasource="dsnWellness" result="queryResult">
    SELECT id,
           last_name,
           first_name,
           email
      FROM users
  ORDER BY last_name, first_name, email
</cfquery>

<!---
<cfquery name="getChallenges" datasource="dsnWellness">
  SELECT id,
         Name
    FROM Challenge
</cfquery>
--->

<!---
<cfquery name="getActivitiesByUserid" datasource="dsnWellness">
  SELECT id,
         user_id,
         challenge_id,
         Typeid,
         Measure,
         FORMAT(ActivityDate, 'M/d/yyyy', 'en-US') AS ActivityMonthDay
    FROM Activity
   WHERE challenge_id = #Form.challenge_id#
     AND user_id = #Form.user_id#
</cfquery>
--->

<cfquery name="getActivityTypes" datasource="dsnWellness">
  SELECT
    id
    , Name
  FROM ActivityType
</cfquery>

<!---
<cfquery name="getSumOfActivitiesByUserid" datasource="dsnWellness">
  SELECT
    SUM(Measure) AS SumOfMeasures
  FROM Activity
  WHERE challenge_id = #Form.challenge_id# AND user_id = #Form.user_id#
</cfquery>
--->

<cfquery name="getSumOfActivities" datasource="dsnWellness">
  SELECT
    SUM(Measure) AS SumOfMeasuresAll
  FROM Activity
  WHERE challenge_id = 1
</cfquery>
<cfoutput query="getSumOfActivities">
<p style="font-weight:bold">Statistics for all of Mercer:</p>
Total: #NumberFormat(SumOfMeasuresAll, ",")# minutes of exercise
</cfoutput>
</p>



<cfoutput query="getusers">
  <cfset NumRegusers = queryResult.RecordCount>
</cfoutput>


<br />
<cfoutput>
<p style="font-weight:bold">Registered users (#NumRegusers#):</p>
</cfoutput>

<cfoutput query="getusers">
#last_name#, #first_name#; #email#<br />
</cfoutput>



<!---
<p>
<cfoutput query="getUser">
User: #first_name# #last_name#<br />
</cfoutput>

<cfoutput query="getChallenge">
Challenge: #Name#<br />
</cfoutput>

<cfoutput query="getActivityType">
Date, #Name#:
</cfoutput>
</p>

<ul>
<cfoutput query="getActivitiesByUserid">
<li>#ActivityMonthDay#, #Measure#</li>
</cfoutput>
</ul>
<br />
--->

<!---
<cfoutput query="getUser">
<p>Statistics for #first_name# #last_name#:<br />
</cfoutput>
<cfoutput query="getSumOfActivitiesByUserid">
Total: #NumberFormat(SumOfMeasures, ",")#
</cfoutput>
</p>

<cfchart
     format="png"
     xaxistitle="Date of activity"
     yaxistitle="Measure of activity">
  <cfchartseries
         type="bar"
         query="getActivitiesByUserid"
         itemcolumn="ActivityMonthDay"
         valuecolumn="Measure">
  </cfchartseries>
</cfchart>
<br />
<br />
--->

<!---
<cfquery name="getTotalsByfirst_name" datasource="dsnWellness">
  SELECT
    --a.user_id
    --, a.Measure
    --, a.ActivityDate
    [users].first_name
    , SUM(a.Measure) AS Total
  FROM Activity a
  INNER JOIN [users]
  ON a.user_id=[users].id
  WHERE a.challenge_id = 1
  GROUP BY [users].first_name
</cfquery>
--->

<!---
<cfchart
     format="png"
     xaxistitle="User"
     yaxistitle="Measure of activity">
  <cfchartseries
         type="bar"
         query="getTotalsByfirst_name"
         itemcolumn="first_name"
         valuecolumn="Total">
  </cfchartseries>
</cfchart>
--->

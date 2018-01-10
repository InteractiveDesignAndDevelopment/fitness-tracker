
<CFQUERY NAME="getUsers" DATASOURCE="dsnWellness" result="queryResult">
	SELECT
		ID
		, Lastname
		, Firstname
		, Email	
	FROM WellnessUser
	ORDER BY Lastname, Firstname, Email
</CFQUERY>

<!---
<CFQUERY NAME="getChallenges" DATASOURCE="dsnWellness">
	SELECT
		ID
		, Name	
	FROM Challenge
</CFQUERY>
--->

<!---
<CFQUERY NAME="getActivitiesByUserID" DATASOURCE="dsnWellness">
	SELECT
		ID
		, WellnessUserID
		, ChallengeID
		, TypeID
		, Measure
		, FORMAT(ActivityDate, 'M/d/yyyy', 'en-US') AS ActivityMonthDay
	FROM Activity
	WHERE ChallengeID = #Form.ChallengeID# AND WellnessUserID = #Form.WellnessUserID#
</CFQUERY>
--->

<CFQUERY NAME="getActivityTypes" DATASOURCE="dsnWellness">
	SELECT
		ID
		, Name
	FROM ActivityType
</CFQUERY>

<!---
<CFQUERY NAME="getSumOfActivitiesByUserID" DATASOURCE="dsnWellness">
	SELECT
		SUM(Measure) AS SumOfMeasures
	FROM Activity
	WHERE ChallengeID = #Form.ChallengeID# AND WellnessUserID = #Form.WellnessUserID#
</CFQUERY>
--->

<CFQUERY NAME="getSumOfActivities" DATASOURCE="dsnWellness">
	SELECT
		SUM(Measure) AS SumOfMeasuresAll
	FROM Activity
	WHERE ChallengeID = 1
</CFQUERY>
<cfoutput query="getSumOfActivities">
<p style="font-weight:bold">Statistics for all of Mercer:</p>
Total: #NumberFormat(SumOfMeasuresAll, ",")# minutes of exercise
</cfoutput>
</p>



<cfoutput query="getUsers">
	<cfset NumRegUsers = queryResult.RecordCount>
</cfoutput>


<br />
<cfoutput>
<p style="font-weight:bold">Registered users (#NumRegUsers#):</p>
</cfoutput>

<cfoutput query="getUsers">
#Lastname#, #Firstname#; #Email#<br />
</cfoutput>



<!---
<p>
<cfoutput query="getUser">
User: #Firstname# #Lastname#<br />
</cfoutput>

<cfoutput query="getChallenge">
Challenge: #Name#<br />
</cfoutput>

<cfoutput query="getActivityType">
Date, #Name#:
</cfoutput>
</p>

<ul>
<cfoutput query="getActivitiesByUserID">
<li>#ActivityMonthDay#, #Measure#</li>
</cfoutput>
</ul>
<br />
--->

<!---
<cfoutput query="getUser">
<p>Statistics for #Firstname# #Lastname#:<br />
</cfoutput>
<cfoutput query="getSumOfActivitiesByUserID">
Total: #NumberFormat(SumOfMeasures, ",")#
</cfoutput>
</p>

<cfchart
		 format="png"
		 xaxistitle="Date of activity"
		 yaxistitle="Measure of activity">
	<cfchartseries
				 type="bar"
				 query="getActivitiesByUserID"
				 itemcolumn="ActivityMonthDay"
				 valuecolumn="Measure">
	</cfchartseries>
</cfchart>
<br />
<br />
--->

<!---
<CFQUERY NAME="getTotalsByFirstname" DATASOURCE="dsnWellness">
	SELECT
		--a.WellnessUserID
		--, a.Measure
		--, a.ActivityDate
		WellnessUser.FirstName
		, SUM(a.Measure) AS Total
	FROM Activity a
	INNER JOIN WellnessUser
	ON a.WellnessUserID=WellnessUser.ID
	WHERE a.ChallengeID = 1
	GROUP BY WellnessUser.FirstName
</CFQUERY>
--->

<!---
<cfchart
		 format="png"
		 xaxistitle="User"
		 yaxistitle="Measure of activity">
	<cfchartseries
				 type="bar"
				 query="getTotalsByFirstname"
				 itemcolumn="Firstname"
				 valuecolumn="Total">
	</cfchartseries>
</cfchart>
--->
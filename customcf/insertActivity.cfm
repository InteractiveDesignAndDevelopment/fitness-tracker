<!---
<cfoutput>
<p>Form.WellnessUserID=#Form.WellnessUserID#</p>
<p>Form.ChallengeID=#Form.ChallengeID#</p>
<p>Form.ActivityTypeID=#Form.ActivityTypeID#</p>
<p>Form.ActivityTypeID=#Form.ActivityTypeID#</p>
<p>Form.Measure=#Form.Measure#</p>
<p>Form.strActivityDateYear=#Form.strActivityDateYear#</p>
<p>Form.strActivityDateMonth=#Form.strActivityDateMonth#</p>
<p>Form.strActivityDateDay=#Form.strActivityDateDay#</p>
</cfoutput>
--->

<!--- Create a yyyy-mm-dd date string for activity --->
<cfset strActivityDate = "#Form.strActivityDateYear#" & "-" & "#Form.strActivityDateMonth#" & "-" & "#Form.strActivityDateDay#">

<!--- Invoke stored procedure to insert Activity values into Activity table --->

<CFSTOREDPROC procedure="sproc_Insert_Activity" datasource="dsnWellness">
	<CFPROCPARAM type="In" cfsqltype="CF_SQL_VARCHAR" null="no" value="#Form.WellnessUserID#">
	<CFPROCPARAM type="In" cfsqltype="CF_SQL_VARCHAR" null="no" value="#Form.ChallengeID#">
	<CFPROCPARAM type="In" cfsqltype="CF_SQL_VARCHAR" null="no" value="#Form.ActivityTypeID#">
	<CFPROCPARAM type="In" cfsqltype="CF_SQL_VARCHAR" null="no" value="#Form.Measure#">
	<CFPROCPARAM type="In" cfsqltype="CF_SQL_VARCHAR" null="no" value="#strActivityDate#">
</CFSTOREDPROC>

<CFQUERY NAME="getUser" DATASOURCE="dsnWellness">
	SELECT
		ID
		, Lastname
		, Firstname
		, Email		
	FROM WellnessUser
	WHERE ID = #Form.WellnessUserID#
</CFQUERY>

<CFQUERY NAME="getChallenge" DATASOURCE="dsnWellness">
	SELECT
		ID
		, Name	
	FROM Challenge
	WHERE ID = #Form.ChallengeID#
</CFQUERY>

<CFQUERY NAME="getActivityType" DATASOURCE="dsnWellness">
	SELECT
		ID
		, Name
	FROM ActivityType
	WHERE ID = #Form.ActivityTypeID#
</CFQUERY>
<p>Successfully entered activity:<br />
<cfoutput query="getUser">#Firstname# #Lastname# completed #Form.Measure# </cfoutput><cfoutput query="getActivityType">#Name# </cfoutput><cfoutput query="getChallenge">for the challenge #Name#</cfoutput>.
</p>

<CFQUERY NAME="getSumOfActivitiesByUserID" DATASOURCE="dsnWellness">
	SELECT
		SUM(Measure) AS SumOfMeasures
	FROM Activity
	WHERE ChallengeID = #Form.ChallengeID# AND WellnessUserID = #Form.WellnessUserID#
</CFQUERY>


<cfoutput query="getSumOfActivitiesByUserID"><h1>#NumberFormat(SumOfMeasures, ",")#</h1></cfoutput>

<cfoutput query="getUser"><p>Congratulations, #Firstname#. You have completed </cfoutput><cfoutput query="getSumOfActivitiesByUserID">#NumberFormat(SumOfMeasures, ",")# total </cfoutput><cfoutput query="getActivityType">#Name#</cfoutput>.</p>
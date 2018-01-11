<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/chartist/0.11.0/chartist.min.css"
  integrity="sha256-Te9+aTaL9j0U5PzLhtAHt+SXlgIT8KT9VkyOZn68hak="
  crossorigin="anonymous" />

<script
  src="https://cdnjs.cloudflare.com/ajax/libs/chartist/0.11.0/chartist.min.js"
  integrity="sha256-UzffRueYhyZDw8Cj39UCnnggvBfa1fPcDQ0auvCbvCc="
  crossorigin="anonymous"></script>

<style>
.ct-series-a .ct-bar {
  /* Colour of your bars */
  stroke: orange;
  /* The width of your bars */
  stroke-width: 5px;
}
.ct-chart .ct-label.ct-horizontal {
  /*text-align: center;*/
  /*font-weight: bold;*/
  font-size: small;
}
.ct-chart .ct-label.ct-vertical {
  /*text-align: center;*/
  /*font-weight: bold;*/
  font-size: x-small;
}
</style>

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

<CFQUERY NAME="getActivitiesByUserID" DATASOURCE="dsnWellness">
  SELECT
    ID
    , WellnessUserID
    , ChallengeID
    , TypeID
    , Measure
    , FORMAT(ActivityDate, 'yyyy/MM/dd', 'en-US') AS ActivityMonthDay
  FROM Activity
  WHERE ChallengeID = #Form.ChallengeID# AND WellnessUserID = #Form.WellnessUserID#
  ORDER BY ActivityMonthDay
</CFQUERY>

<CFQUERY NAME="getActivityType" DATASOURCE="dsnWellness">
  SELECT
    ID
    , Name
  FROM ActivityType
  WHERE ID = #Form.ActivityTypeID#
</CFQUERY>

<CFQUERY NAME="getSumOfActivitiesByUserID" DATASOURCE="dsnWellness">
  SELECT
    SUM(Measure) AS SumOfMeasures
  FROM Activity
  WHERE ChallengeID = #Form.ChallengeID# AND WellnessUserID = #Form.WellnessUserID#
</CFQUERY>

<p>
<cfoutput query="getUser">
User: #Firstname# #Lastname#<br />
</cfoutput>

<cfoutput query="getChallenge">
Challenge: #Name#<br />
</cfoutput>

<cfoutput query="getUser">
Statistics for #Firstname# #Lastname#:<br />
</cfoutput>
<cfoutput query="getSumOfActivitiesByUserID">
Total: #NumberFormat(SumOfMeasures, ",")#
</cfoutput>
</p>

<div class="ct-chart ct-minor-seventh" id="chart1"></div>

<CFQUERY NAME="getTotalsByFirstname" DATASOURCE="dsnWellness">
  SELECT
    --a.WellnessUserID
    --, a.Measure
    --, a.ActivityDate
    WellnessUser.FirstName
    , WellnessUser.LastName
    , SUM(a.Measure) AS Total
  FROM Activity a
  INNER JOIN WellnessUser
  ON a.WellnessUserID=WellnessUser.ID
  WHERE a.ChallengeID = 2
  GROUP BY WellnessUser.FirstName, WellnessUser.LastName
  ORDER BY Total DESC
</CFQUERY>

<CFQUERY NAME="getSumOfActivities" DATASOURCE="dsnWellness">
  SELECT
    SUM(Measure) AS SumOfMeasuresAll
  FROM Activity
  WHERE ChallengeID = #Form.ChallengeID#
</CFQUERY>

<br />
<p>
Statistics for all of Mercer:<br />
<cfoutput query="getSumOfActivities">
Total: #NumberFormat(SumOfMeasuresAll, ",")#
</cfoutput>
</p>

<div class="ct-chart ct-minor-seventh" id="chart2"></div>

<script>
new Chartist.Bar('#chart1', {
  labels: [
  <cfoutput query="getActivitiesByUserID">
  '#ActivityMonthDay#',
  </cfoutput>
  ],
  series: [
    [
  <cfoutput query="getActivitiesByUserID">
  #Measure#,
  </cfoutput>
  ]
  ]
}, {
  seriesBarDistance: 10,
  reverseData: true,
  horizontalBars: true,
  axisY: {
    offset: 70
  }
});

new Chartist.Bar('#chart2', {
  labels: [
  <cfoutput query="getTotalsByFirstname">
  '#Firstname# #LastName#',
  </cfoutput>
  ],
  series: [
    [
  <cfoutput query="getTotalsByFirstname">
  #Total#,
  </cfoutput>
  ]
  ]
}, {
  seriesBarDistance: 10,
  reverseData: true,
  horizontalBars: true,
  axisY: {
    offset: 120
  }
});
</script>

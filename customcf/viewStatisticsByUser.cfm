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

<cfquery name="getUser" datasource="dsnWellness">
  SELECT [users].id,
         [users].last_name,
         [users].first_name,
         [users].email
    FROM [users]
   WHERE [users].id = #Form.user_id#
</cfquery>

<cfquery name="getChallenge" datasource="dsnWellness">
  SELECT challenges.id,
         challenges.name
    FROM challenges
   WHERE challenges.id = #Form.challenge_id#
</cfquery>

<cfquery name="getActivitiesByUserID" datasource="dsnWellness">
    SELECT activities.id,
           activities.[user_id],
           activities.challenge_id,
           activities.activity_type_id,
           activities.measure,
           FORMAT(activities.activity_date, 'yyyy/MM/dd', 'en-US') AS activity_month_day
      FROM activities
     WHERE activities.challenge_id = #Form.challenge_id#
       AND activities.[user_id] = #Form.user_id#
  ORDER BY activity_month_day
</cfquery>

<cfquery name="getActivityType" datasource="dsnWellness">
  SELECT activity_types.id,
         activity_types.name
    FROM activity_types
   WHERE activity_types.id = #Form.activity_type_id#
</cfquery>

<cfquery name="getSumOfActivitiesByUserID" datasource="dsnWellness">
  SELECT SUM(activities.measure) AS sum_of_measures
    FROM activities
   WHERE activities.challenge_id = #Form.challenge_id#
     AND activities.[user_id] = #Form.user_id#
</cfquery>

<p>
  <cfoutput query="getUser">
    User: #first_name# #last_name#<br />
  </cfoutput>

  <cfoutput query="getChallenge">
    Challenge: #name#<br />
  </cfoutput>

  <cfoutput query="getUser">
    Statistics for #first_name# #last_name#:<br />
  </cfoutput>
  <cfoutput query="getSumOfActivitiesByUserID">
    Total: #NumberFormat(sum_of_measures, ',')#
  </cfoutput>
</p>

<div class="ct-chart ct-minor-seventh" id="chart1"></div>

<cfquery name="getTotalsByFirstname" datasource="dsnWellness">
     SELECT [users].first_name,
            [users].last_name,
            SUM(activities.measure) AS total
       FROM activities
 INNER JOIN [users]
         ON activities.[user_id] = [users].id
      WHERE activities.challenge_id = #Form.challenge_id#
   GROUP BY [users].first_name, [users].last_name
   ORDER BY total DESC
</cfquery>

<cfquery name="getSumOfActivities" datasource="dsnWellness">
  SELECT SUM(activities.measure) AS sum_of_measures_all
    FROM activities
   WHERE activities.challenge_id = #Form.challenge_id#
</cfquery>

<br />

<p>
  Statistics for all of Mercer:<br />
  <cfoutput query="getSumOfActivities">
    Total: #NumberFormat(sum_of_measures_all, ',')#
  </cfoutput>
</p>

<div class="ct-chart ct-minor-seventh" id="chart2"></div>

<script>
  new Chartist.Bar('#chart1', {
    labels: [
    <cfoutput query="getActivitiesByUserID">
    '#activity_month_day#',
    </cfoutput>
    ],
    series: [
      [
    <cfoutput query="getActivitiesByUserID">
    #measure#,
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
    '#first_name# #last_name#',
    </cfoutput>
    ],
    series: [
      [
    <cfoutput query="getTotalsByFirstname">
    #total#,
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

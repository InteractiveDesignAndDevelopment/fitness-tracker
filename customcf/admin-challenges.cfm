<cfscript>
  Challenges = createObject('component', 'components.Challenges');
</cfscript>

<cfoutput>

  <h2>Challenges</h2>

  <ul>
    <cfloop array="#Challenges.find().toArray()#" index="challenge">
      <li>
        #challenge.getName()#
        <ul>
          <li><a href="./admin-report-activities-by-user-by-week.cfm?challenge_id=#challenge.getID()#">Activities By User By Week</a></li>
        </ul>
      </li>
    </cfloop>
  </ul>

</cfoutput>

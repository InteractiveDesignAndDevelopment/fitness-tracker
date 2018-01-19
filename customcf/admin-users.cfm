<cfscript>
  Users = createObject('component', 'components.Users');
</cfscript>

<cfoutput>

  <h2>Users</h2>

  <ul>
    <cfloop array="#Users.find().toArray()#" index="user">
      <li>#user.fullName()#</li>
    </cfloop>
  </ul>
</cfoutput>

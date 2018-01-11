<cfscript>
  User = createObject('component', 'components.User').init(Form);
  isSaved = User.save();
</cfscript>

<cfoutput>
  <cfif isSaved>
    <p><strong>Successfully registered user!</strong></p>
    <p>
      Firstname = #User.getFirstname()#<br>
      Lastname = #User.getLastname()#<br>
      Email = #User.getEmail()#<br>
      Type = #User.userType().getName()#
    </p>
  <cfelseif ! User.isUnique()>
    <p style="color: red;">
      #User.getEmail()# has already been registered.
    </p>
  <cfelse>
    <p>
      Unspecified error.
    </p>
  </cfif>
</cfoutput>

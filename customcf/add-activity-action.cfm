<cfscript>
  // WriteDump(form);
  // exit;

  Users = createObject('component', 'components.Users');
  User = Users.find(where = { id = Form.user_id }).toArray()[1];
  // WriteDump(User);
  Challenges = createObject('component', 'components.Challenges');
  Challenge = Challenges.find(where = { id = Form.challenge_id }).toArray()[1];
  // WriteDump(Challenge);
  ActivityTypes = createObject('component', 'components.ActivityTypes');
  ActivityType = ActivityTypes.find(where = { id = Form.activity_type_id }).toArray()[1];
  // writeDump(form);
  // WriteDump(ActivityType);

  Activity = createObject('component', 'components.Activity').init(form);
  // WriteDump(Activity.save());
  isSaved = Activity.save();

  // exit;
</cfscript>

<cfoutput>
  <cfif isSaved>
    <h2>Successfully Entered Activity</h2>

    <p>
      #User.getFirstName()# #User.getLastName()# completed <strong>#Form.Measure#</strong> #ActivityType.getName()# for the challenge <em>#Challenge.getName()#</em>
    </p>

    <p>
      <!--- FIXME: This can't work with multiple activity types --->
      Congratulations, #User.getFirstName()#. You have completed #NumberFormat(User.sumActivity(where = { challenge_id = form.challenge_id }), ',')# minutes of exercise.
    </p>
  <cfelse>
    <h2>An error occurred and your activty was not saved.</h2>
  </cfif>
</cfoutput>

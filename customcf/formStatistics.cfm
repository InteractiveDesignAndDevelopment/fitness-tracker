<cfscript>
  include '_functions.cfm';

  Users = createObject('component', 'components.Users');
  allUsers = Users.find().toArray();
  Challenges = createObject('component', 'components.Challenges');
  allChallenges = Challenges.find().toArray();
  ActivityTypes = createObject('component', 'components.ActivityTypes');
  allActivityTypes = ActivityTypes.find().toArray();
  Activities = createObject('component', 'components.Activities');
  currentChallenge = Challenges.current();
</cfscript>

<cfoutput>

  <h2>Collective Statistics</h2>

  <h3>#currentChallenge.getName()#</h3>
  <cfloop array="#currentChallenge.activityTypes()#" index="activityType">
    <cfscript>
      associatedActivities = Activities.find(where = {
        challengeID    = currentChallenge.getID(),
        activityTypeID = activityType.getID()
      });
      sumMeasure = arrayReduce(associatedActivities, function(total, activity) {
        return total + activity.getMeasure();
      }, 0);
    </cfscript>
    <div>
      #sumMeasure#
      #activityType.getName()#
    </div>
  </cfloop>

  <h2>Individual Statistics</h2>

  <form action="./view-statistics-by-user.cfm" method="post">

    <div class="form-group">
      <label for="WellnessUserID">Email address</label>
      <select class="form-control select2-control" id="WellnessUserID" name="WellnessUserID" required>
        <option></option>
        <cfloop array="#allUsers#" index="user">
          <option value="#user.getID()#" #selectIfSingle(allUsers)#>#user.getEmail()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="ChallengeID">Challenge</label>
      <select class="form-control" id="ChallengeID" name="ChallengeID">
        <option></option>
        <cfloop array="#allChallenges#" index="challenge">
          <option value="#challenge.getID()#" #selectIfSingle(allChallenges)#>#challenge.getName()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="ActivityTypeID">Activity type</label>
      <select class="form-control" id="ActivityTypeID" name="ActivityTypeID">
        <option></option>
        <cfloop array="#allActivityTypes#" index="activityType">
          <option value="#activityType.getID()#" #selectIfSingle(allActivityTypes)#>#activityType.getName()#</option>
        </cfloop>
      </select>
    </div>

    <input type="Submit" name="Submit" value="View Single User Statistics">

  </form>

  <script>
    // Set the "bootstrap" theme as the default theme for all Select2
    // widgets.
    //
    // @see https://github.com/select2/select2/issues/2927
    $.fn.select2.defaults.set('theme', 'bootstrap');

    $('##WellnessUserID').select2({
      placeholder: 'Select an email address',
      width: null
    });

    $('##ChallengeID').select2({
      placeholder: 'Select a challenge',
      width: null
    });

    $('##ActivityTypeID').select2({
      placeholder: 'Select an activity type',
      width: null
    });

    // copy Bootstrap validation states to Select2 dropdown
    //
    // add .has-waring, .has-error, .has-succes to the Select2 dropdown
    // (was ##select2-drop in Select2 v3.x, in Select2 v4 can be selected via
    // body > .select2-container) if _any_ of the opened Select2's parents
    // has one of these forementioned classes (YUCK! ;-))
    $( ".select2-control" ).on( "select2:open", function() {
      if ( $( this ).parents( "[class*='has-']" ).length ) {
        var classNames = $( this ).parents( "[class*='has-']" )[ 0 ].className.split( /\s+/ );

        for ( var i = 0; i < classNames.length; ++i ) {
          if ( classNames[ i ].match( "has-" ) ) {
            $( "body > .select2-container" ).addClass( classNames[ i ] );
          }
        }
      }
    });
  </script>

</cfoutput>

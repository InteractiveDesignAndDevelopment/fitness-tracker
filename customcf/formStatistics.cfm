<cfscript>
  include '_functions.cfm';

  Users = createObject('component', 'components.Users');
  allUsers = Users.find().toArray();

  Challenges = createObject('component', 'components.Challenges');
  allChallenges = Challenges.find().toArray();
  currentChallenge = Challenges.current();

  ActivityTypes = createObject('component', 'components.ActivityTypes');
  allActivityTypes = ActivityTypes.find().toArray();

  Activities = createObject('component', 'components.Activities');
</cfscript>

<cfoutput>

  <h2>Collective Statistics</h2>

  <h3>#currentChallenge.getName()#</h3>

  <cfloop array="#currentChallenge.activityTypes()#" index="activityType">

    <cfscript>
      associatedActivities = Activities.find(where = {
        challenge_id    = currentChallenge.getID(),
        activity_type_id = activityType.getID()
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
      <label for="user_id">Email address</label>
      <select class="form-control select2-control" id="user_id" name="user_id" required>
        <option></option>
        <cfloop array="#allUsers#" index="user">
          <option value="#user.getID()#" #selectIfSingle(allUsers)#>#user.getEmail()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="challenge_id">Challenge</label>
      <select class="form-control" id="challenge_id" name="challenge_id">
        <option></option>
        <cfloop array="#allChallenges#" index="challenge">
          <option value="#challenge.getID()#" #selectIfSingle(allChallenges)#>#challenge.getName()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="activity_type_id">Activity type</label>
      <select class="form-control" id="activity_type_id" name="activity_type_id">
        <option></option>
        <cfloop array="#allActivityTypes#" index="activityType">
          <option value="#activityType.getID()#" #selectIfSingle(allActivityTypes)#>#activityType.getName()#</option>
        </cfloop>
      </select>
    </div>

    <div>
      <input class="btn btn-primary" type="Submit" name="Submit" value="View Single User Statistics">
    </div>

  </form>

  <script>
    // Set the "bootstrap" theme as the default theme for all Select2
    // widgets.
    //
    // @see https://github.com/select2/select2/issues/2927
    $.fn.select2.defaults.set('theme', 'bootstrap');

    $('##user_id').select2({
      placeholder: 'Select an email address',
      width: null
    });

    $('##challenge_id').select2({
      placeholder: 'Select a challenge',
      width: null
    });

    $('##activity_type_id').select2({
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

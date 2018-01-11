<cfscript>
  Users = createObject('components.Users');
  Challenges = createObject('components.Challenges');
  ActivityTypes = createObject('components.ActivityTypes');
  Activities = createObject('components.Activities');
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

  <!---
  <p>
  Statistics for all of Mercer, Move More for Heart Health 2016<br />
  <cfoutput query="getSumOfActivities">
    Total minutes of exercise: #NumberFormat(SumOfMeasuresAll, ",")#
    <div>#NumberFormat(SumOfMeasuresAll, ",")#</div>
  </cfoutput>
  </p>
  --->

  <h2>Individual Statistics</h2>

  <form action="./view-statistics-by-user.cfm" method="post">

    <div class="form-group">
      <label for="WellnessUserID">Email address</label>
      <select class="form-control select2-control" id="WellnessUserID" name="WellnessUserID" required>
        <option></option>
        <cfloop array="#Users.all()#" index="user">
          <option value="#user.getID()#">#user.getEmail()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="ChallengeID">Challenge</label>
      <select class="form-control" id="ChallengeID" name="ChallengeID">
        <option></option>
        <cfloop array="#challenges.all()#" index="challenge">
          <option value="#challenge.getID()#">#challenge.getName()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="ActivityTypeID">Activity type</label>
      <select class="form-control" id="ActivityTypeID" name="ActivityTypeID">
        <option></option>
        <cfloop array="#activityTypes.all()#" index="activityType">
          <option value="#activityType.getID()#">#activityType.getName()#</option>
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

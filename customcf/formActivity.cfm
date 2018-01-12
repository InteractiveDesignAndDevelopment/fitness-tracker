<cfscript>
  include '_functions.cfm';

  Users = createObject('component', 'components.Users');
  allUsers = Users.find().toArray();
  Challenges = createObject('component', 'components.Challenges');
  allChallenges = Challenges.find().toArray();
  ActivityTypes = createObject('component', 'components.ActivityTypes');
  allActivityTypes = ActivityTypes.find().toArray();
</cfscript>

<cfoutput>

  <form action="./activity-recorded.cfm" method="post">

    <div class="form-group">
      <label for="WellnessUserID">Email address</label>
      <select class="form-control" id="WellnessUserID" name="WellnessUserID" required>
        <option></option>
        <cfloop array="#allUsers#" index="user">
          <option value="#user.getID()#" #selectIfSingle(allUsers)#>#user.getEmail()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="ChallengeID">Challenge</label>
      <select class="form-control" id="ChallengeID" name="ChallengeID" required>
        <option></option>
        <cfloop array="#allChallenges#" index="challenge">
          <option value="#challenge.getID()#" #selectIfSingle(allChallenges)#>#challenge.getName()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="ActivityTypeID">Activity Type</label>
      <select class="form-control" id="ActivityTypeID" name="ActivityTypeID" required>
        <option></option>
        <cfloop array="#allActivityTypes#" index="activityType">
          <option value="#activityType.getID()#" #selectIfSingle(allActivityTypes)#>#activityType.getName()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="Measure">How many</label>
      <input class="form-control" type="text" id="Measure" name="Measure" required>
    </div>

    <div class="form-group">
      <label>Date of activity</label>
      <input type="hidden" id="ActivityDate" name="ActivityDate" required>
      <div style="overflow:hidden;">
        <div class="form-group">
          <div class="row">
            <div class="col-xs-offset-1 col-xs-9">
              <div id="ActivityDate-datepicker"></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div>
      <input type="submit" name="Submit" value="Record activity">
    </div>

  </form>

  <script>
    // Set the "bootstrap" theme as the default theme for all Select2
    // widgets.
    //
    // @see https://github.com/select2/select2/issues/2927
    $.fn.select2.defaults.set('theme', 'bootstrap');

    (function() {
      var $activityDate = $('##ActivityDate');
      var $activityDateTimePicker = $('##ActivityDate-datepicker');
      var $wellnessUserId = $('##WellnessUserID');
      var $challengeId = $('##ChallengeID');
      var $activityTypeId = $('##ActivityTypeID');

      var onChangeActivityDateTimePicker = function() {
        var v = $activityDateTimePicker.data('DateTimePicker').date();
        var m = moment(v);
        var f = m.format('YYYY-MM-DD');
        $activityDate.val(f);
      }

      $wellnessUserId.select2({
        placeholder: 'Select your email address',
        width: null
      });

      $challengeId.select2({
        placeholder: 'Select a challenge',
        width: null
      });

      $activityTypeId.select2({
        placeholder: 'Select an activity type',
        width: null
      });

      $activityDateTimePicker.datetimepicker({
        format: 'YYYY-MM-DD',
        inline: true
      });

      $activityDateTimePicker.on('dp.change', onChangeActivityDateTimePicker);

      $(function () {
        onChangeActivityDateTimePicker();
      });
    })();
  </script>
</cfoutput>

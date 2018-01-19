<cfscript>
  // If in CommonSpot...
  if (StructKeyExists(request, 'cp')) {
    // Assuming Bootstrap and jQuery are loaded by the template
    Server.CommonSpot.udf.resources.loadResources('moment');
    Server.CommonSpot.udf.resources.loadResources('select2');
    Server.CommonSpot.udf.resources.loadResources('select2-bootstrap-theme');
    Server.CommonSpot.udf.resources.loadResources('bootstrap-datetimepicker');
  }

  include '_functions.cfm';

  Users = createObject('component', 'components.Users');
  selectableUsers = Users.find().toArray();
  Challenges = createObject('component', 'components.Challenges');
  selectableChallenges = Challenges.find().toArray();
  ActivityTypes = createObject('component', 'components.ActivityTypes');
  selectableActivityTypes = ActivityTypes.find( where = { is_enabled = true } ).toArray();
</cfscript>

<cfoutput>

  <form action="./add-activity-action.cfm" method="post">

    <div class="form-group">
      <label for="user_id">Email address</label>
      <select class="form-control" id="user_id" name="user_id" required>
        <option></option>
        <cfloop array="#selectableUsers#" index="user">
          <option value="#user.getID()#" #selectIfSingle(selectableUsers)#>#user.getEmail()#</option>
        </cfloop>
      </select>
      <p class="help-block">
        Start typing to filter the list.
      </p>
    </div>

    <div class="form-group">
      <label for="challenge_id">Challenge</label>
      <select class="form-control" id="challenge_id" name="challenge_id" required>
        <option></option>
        <cfloop array="#selectableChallenges#" index="challenge">
          <option value="#challenge.getID()#" #selectIfTrue(challenge.isDefault())# #selectIfSingle(selectableChallenges)#>#challenge.getName()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="activity_type_id">Activity Type</label>
      <select class="form-control" id="activity_type_id" name="activity_type_id" required>
        <option></option>
        <cfloop array="#selectableActivityTypes#" index="activityType">
          <option value="#activityType.getID()#" #selectIfSingle(selectableActivityTypes)#>#activityType.getName()#</option>
        </cfloop>
      </select>
    </div>

    <div class="form-group">
      <label for="Measure">Minutes you did of this activity</label>
      <input class="form-control" type="number" id="measure" name="measure" required>
    </div>

    <div class="form-group">
      <label>Date of activity</label>
      <input type="hidden" id="activity_date" name="activity_date" required>
      <div style="overflow:hidden;">
        <div class="form-group">
          <div class="row">
            <div class="col-xs-offset-1 col-xs-9">
              <div id="activity_date-datepicker"></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div>
      <input class="btn btn-primary" type="submit" name="Submit" value="Record Activity">
    </div>

  </form>

  <script>
    (function() {
      var $activity_date = $('##activity_date');
      var $activity_date_dateTimePicker = $('##activity_date-datepicker');
      var $user_id = $('##user_id');
      var $challenge_id = $('##challenge_id');
      var $activity_type_id = $('##activity_type_id');

      $(function () {
        // Set the "bootstrap" theme as the default theme for all Select2
        // widgets.
        //
        // @see https://github.com/select2/select2/issues/2927
        $.fn.select2.defaults.set('theme', 'bootstrap');

        $user_id.select2({
          placeholder: 'Select your email address',
          width: null
        });

        $challenge_id.select2({
          placeholder: 'Select a challenge',
          width: null
        });

        $activity_type_id.select2({
          placeholder: 'Select an activity type',
          width: null
        });

        $activity_date_dateTimePicker.datetimepicker({
          format: 'YYYY-MM-DD',
          inline: true
        });

        var onChangeActivityDateDateTimePicker = function() {
          var v = $activity_date_dateTimePicker.data('DateTimePicker').date();
          var m = moment(v);
          var f = m.format('YYYY-MM-DD');
          $activity_date.val(f);
        }

        $activity_date_dateTimePicker.on('dp.change', onChangeActivityDateDateTimePicker);

        onChangeActivityDateDateTimePicker();
      });
    })();
  </script>
</cfoutput>

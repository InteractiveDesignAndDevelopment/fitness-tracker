/**
 * Activity.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/

component accessors=true output=false persistent=false {

  property id;
  property activityDate;
  property activityTypeID;
  property challengeID;
  property measure;
  property userID;

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

 public component function init() {

   if (1 == ArrayLen(arguments) && IsStruct(arguments[1])) {
     var s = arguments[1];

     if (StructKeyExists(s, 'id')) {
       setID(s.id);
     }

     if (StructKeyExists(s, 'activity_date')) {
       setActivityDate(s.activity_date);
     }

     if (StructKeyExists(s, 'activity_type_id')) {
       setActivityTypeID(s.activity_type_id);
     }

     if (StructKeyExists(s, 'challenge_id')) {
       setChallengeID(s.challenge_id);
     }

     if (StructKeyExists(s, 'measure')) {
       setMeasure(s.measure);
     }

     if (StructKeyExists(s, 'user_id')) {
       setUserID(s.user_id);
     }
   }

   return this;
 }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public boolean function save() {
    if (0 == Len(this.getID())) {
      return variables.insert(argumentsCollection = arguments);
    } else {
      return variables.update(argumentsCollection = arguments);
    }
  }

  public component function user() {
    return new User(this.getUserID());
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  // TODO: Add update functionality
  // private boolean function update() {
  // }

  private boolean function insert() {
    var sql = '';

    savecontent variable='sql' {
      WriteOutput(' INSERT INTO activities (');
      WriteOutput('   user_id,');
      WriteOutput('   challenge_id,');
      WriteOutput('   activity_type_id,');
      WriteOutput('   measure,');
      WriteOutput('   activity_date');
      WriteOutput(' )');
      WriteOutput(' OUTPUT INSERTED.*');
      WriteOutput(' VALUES (');
      WriteOutput('   :user_id,');
      WriteOutput('   :challenge_id,');
      WriteOutput('   :activity_type_id,');
      WriteOutput('   :measure,');
      WriteOutput('   :activity_date');
      WriteOutput(' )');
    };

    var params = {
      user_id          = this.getUserID(),
      challenge_id     = this.getChallengeID(),
      activity_type_id = this.getActivityTypeID(),
      measure          = this.getMeasure(),
      activity_date    = this.getActivityDate()
    };

    try {
      var results = queryExecute(sql, params, { datasource = 'dsnWellness' });
      // WriteDump(results);
      setID(queryGetRow(results, 1).id);
      return true;
    } catch (any e) {
      return false;
    }
  }

  private boolean function update() {
    WriteOutput('TODO: Create this if ever needed.');
  }

}

/**
 * ActivityTypes.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/
component accessors=true output=false persistent=false {

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function init() {
    return this;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public function all() {
    var results = queryNew('');
    var sql = '';
    sql &= '   SELECT *';
    sql &= '     FROM ActivityType';
    sql &= ' ORDER BY Name';
    results = queryExecute(sql, {}, { datasource = 'dsnWellness' });
    return activityTypesQuerytoActivityTypeArray(results);
  }

  public function find () {
    var results = queryNew('');
    var params = {};
    savecontent variable='sql' {
      WriteOutput(' SELECT ActivityType.*');
      WriteOutput('   FROM ActivityType');
      if (StructKeyExists(arguments, 'where')) {
        WriteOutput(' WHERE 1=1');
        if (StructKeyExists(arguments.where, 'challengeID')) {
          WriteOutput('    AND ActivityType.ID IN (');
          WriteOutput(' SELECT DISTINCT Activity.TypeID');
          WriteOutput('   FROM Activity');
          WriteOutput('  WHERE Activity.ChallengeID = :challengeID');
          WriteOutput('    AND Activity.TypeID = ActivityType.ID');
          WriteOutput(' )');
          params.challengeID = arguments.where.challengeID;
        }
      }
    }
    results = queryExecute(sql, params, { datasource = 'dsnWellness' });
    return activityTypesQuerytoActivityTypeArray(results);
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private array function activityTypesQuerytoActivityTypeArray(required query activityTypesQuery) {
    var activityTypeArray = [];
    for (row in activityTypesQuery) {
      ArrayAppend(activityTypeArray, new ActivityType(row));
    }
    return activityTypeArray;
  }
}

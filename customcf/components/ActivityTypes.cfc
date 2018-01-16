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
    sql &= '   SELECT activity_types.*';
    sql &= '     FROM activity_types';
    sql &= ' ORDER BY activity_types.name';
    results = queryExecute(sql, {}, { datasource = 'dsnWellness' });
    return activityTypesQuerytoActivityTypeArray(results);
  }

  public function find () {
    var params = {};
    var results = queryNew('');
    var sql = '';

    savecontent variable='sql' {
      WriteOutput(' SELECT activity_types.*');
      WriteOutput('   FROM activity_types');
      if (StructKeyExists(arguments, 'where')) {
        WriteOutput(' WHERE 1=1');
        if (StructKeyExists(arguments.where, 'challenge_id')) {
          WriteOutput('    AND activity_types.id IN (');
          WriteOutput(' SELECT DISTINCT activities.activity_type_id');
          WriteOutput('   FROM activities');
          WriteOutput('  WHERE activities.challenge_id = :challenge_id');
          WriteOutput('    AND activities.activity_type_id = activity_types.id');
          WriteOutput(' )');
          params.challenge_id = arguments.where.challenge_id;
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

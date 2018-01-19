/**
 * Activities.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/
component accessors=true output=false persistent=false {

  property activities;

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

  public array function find() {
    var params = {};
    var results = queryNew('');
    var sql = '';

    // Compatibility layer for Kelly's old field name in the database
    if (StructKeyExists(arguments, 'where') && StructKeyExists(arguments.where, 'TypeID')) {
      arguments.where.activityTypeID = arguments.where.typeID;
      StructDelete(arguments.where, 'typeID');
    }

    savecontent variable='sql' {
      WriteOutput(' SELECT activities.*');
      WriteOutput('   FROM activities');
      if (StructKeyExists(arguments, 'where')) {
        WriteOutput(' WHERE 1=1');
        if (StructKeyExists(arguments.where, 'challenge_id')) {
          WriteOutput(' AND challenge_id = :challenge_id');
          params.challenge_id = arguments.where.challenge_id;
        }
        if (StructKeyExists(arguments.where, 'activity_type_id')) {
          WriteOutput(' AND activity_type_id = :activity_type_id');
          params.activity_type_id = arguments.where.activity_type_id;
        }
      }
      WriteOutput(' ORDER BY activity_date');
    }
    // WriteDump(sql);

    results = queryExecute(sql, params, { datasource = 'dsnWellness' });

    return activitiesQuerytoActivityArray(results);
  }

  public numeric function sum() {
    var sql = '';
    var params = {};
    var where = {};

    if (StructKeyExists(arguments, 'where')) {
      where = arguments.where;
    }

    // WriteDump(arguments);

    savecontent variable='sql' {
      WriteOutput(' SELECT SUM(measure) AS sum_measure');
      WriteOutput('   FROM activities');

      if (!StructIsEmpty(where)) {
        WriteOutput(' WHERE 1=1');

        if (StructKeyExists(where, 'challenge_id')) {
          WriteOutput(' AND activities.challenge_id = :challenge_id');
          params.challenge_id = arguments.where.challenge_id;
        }

        if (StructKeyExists(where, 'user_id')) {
          WriteOutput(' AND activities.user_id = :user_id');
          params.user_id = arguments.where.user_id;
        }
      }
    };

    // WriteDump(sql);

    results = queryExecute(sql, params, { datasource = 'dsnWellness' });

    if (1 == results.RecordCount) {
      return queryGetRow(results, 1).sum_measure;
    } else {
      return;
    }
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private array function activitiesQuerytoActivityArray(required query activitiesQuery) {
    var activityArray = [];
    for (row in activitiesQuery) {
      ArrayAppend(activityArray, new Activity(row));
    }
    return activityArray;
  }

}

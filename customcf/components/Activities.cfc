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
      WriteOutput(' SELECT Activity.*');
      WriteOutput('   FROM Activity');
      if (StructKeyExists(arguments, 'where')) {
        WriteOutput(' WHERE 1=1');
        if (StructKeyExists(arguments.where, 'challengeID')) {
          WriteOutput(' AND ChallengeID = :challengeID');
          params.challengeID = arguments.where.challengeID;
        }
        if (StructKeyExists(arguments.where, 'activityTypeID')) {
          WriteOutput(' AND TypeID = :activityTypeID');
          params.activityTypeID = arguments.where.activityTypeID;
        }
      }
      WriteOutput(' ORDER BY ActivityDate');
    }
    // WriteDump(sql);

    results = queryExecute(sql, params, { datasource = 'dsnWellness' });

    return activitiesQuerytoActivityArray(results);
  }

  // public function sum(options = {}) {
  //   var results = queryNew('');
  //   var sql = '';
  //   var challengeID = '';
  //   var params = {};
  //
  //   if (structKeyExists(options, 'challengeID')) {
  //     challengeID = options.challengeID;
  //   }
  //
  //   sql &= ' SELECT SUM(Measure) AS SumOfMeasuresAll';
  //   sql &= '   FROM Activity';
  //   if (0 < len(challengeID)) {
  //     sql &= '  WHERE ChallengeID = :challengeID';
  //   }
  //
  //   if (0 < len(challengeID)) {
  //     params.challengeID = challengeID;
  //   }
  //
  //   results = queryExecute(sql, params, { datasource = 'dsnWellness' });
  //
  //   return results;
  // }

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

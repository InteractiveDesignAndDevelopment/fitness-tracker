/**
 * Challenges.cfc
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

  public array function find() {
    var params = {};
    var results = queryNew('');
    var sql = '';

    savecontent variable='sql' {
      WriteOutput(' SELECT Challenge.*');
      WriteOutput('   FROM Challenge');

      // if (StructKeyExists(arguments, 'where')) {
      //   WriteOutput(' WHERE 1=1');
      //
      //   if (StructKeyExists(arguments.where, 'isCurrent')) {
      //     WriteOutput(' AND Challenge.isCurrent = :isCurrent');
      //     params.isCurrent = IsNumeric(arguments.where.isCurrent) ?
      //       arguments.where.isCurrent :
      //       booleanToInt(arguments.where.isCurrent);
      //     }
      //   }
      //
      // }

      WriteOutput(' ORDER BY Challenge.Name');
    }

    results = queryExecute(sql, params, { datasource = 'dsnWellness' });

    return challengesQuerytoChallengeArray(results);
  }

  public component function current() {
    currentChallenge = this.find(where = { isCurrent = true })
    if (1 == ArrayLen(currentChallenge)) {
      return currentChallenge[1];
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

  // private boolean function booleanToInt(required boolean b) {
  //   return b ? 1 : 0;
  // }
  //
  // private numeric function intToBoolean(required numeric i) {
  //   return 1 == i;
  // }

  private array function challengesQuerytoChallengeArray(required query challengesQuery) {
    var challengeArray = [];
    for (row in challengesQuery) {
      ArrayAppend(challengeArray, new Challenge(row));
    }
    return challengeArray;
  }
}

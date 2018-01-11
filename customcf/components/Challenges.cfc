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

  public array function all() {
    var results = queryNew('');
    var sql = '';
    sql &= '   SELECT *';
    sql &= '     FROM Challenge';
    sql &= ' ORDER BY Name';
    results = queryExecute(sql, {}, { datasource = 'dsnWellness' });
    return challengesQuerytoChallengeArray(results);
  }

  public component function current() {
    var results = queryNew('');
    var sql = '';
    sql &= ' SELECT *';
    sql &= '   FROM Challenge';
    sql &= '  WHERE isCurrent = ''1''';
    results = queryExecute(sql, {}, { datasource = 'dsnWellness' });
    arr = challengesQuerytoChallengeArray(results);
    if (1 <= ArrayLen(arr)) {
      return arr[1];
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

  private array function challengesQuerytoChallengeArray(required query challengesQuery) {
    var challengeArray = [];
    for (row in challengesQuery) {
      ArrayAppend(challengeArray, new Challenge(row));
    }
    return challengeArray;
  }
}

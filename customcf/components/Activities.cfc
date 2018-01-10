/**
 * Activities.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/
component Challenges {
  public function sum(options = {}) {
    var results = queryNew('');
    var sql = '';
    var challengeID = '';
    var params = {};

    if (structKeyExists(options, 'challengeID')) {
      challengeID = options.challengeID;
    }

    sql &= ' SELECT SUM(Measure) AS SumOfMeasuresAll';
    sql &= '   FROM Activity';
    if (0 < len(challengeID)) {
      sql &= '  WHERE ChallengeID = :challengeID';
    }

    if (0 < len(challengeID)) {
      params.challengeID = challengeID;
    }

    results = queryExecute(sql, params, { datasource = 'dsnWellness' });

    return results;
  }
}

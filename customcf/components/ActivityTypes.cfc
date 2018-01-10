/**
 * ActivityTypes.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/
component ActivityTypes {
  public function all() {
    var results = queryNew('');
    var sql = '';
    sql &= '   SELECT ID,';
    sql &= '          Name';
    sql &= '     FROM ActivityType';
    sql &= ' ORDER BY Name';
    results = queryExecute(sql, {}, { datasource = 'dsnWellness' });
    return results;
  }
}

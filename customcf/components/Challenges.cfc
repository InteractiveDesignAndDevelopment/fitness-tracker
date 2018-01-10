component Challenges {
  public function all() {
    var results = queryNew('');
    var sql = '';
    sql &= '   SELECT ID,';
    sql &= '          Name';
    sql &= '     FROM Challenge';
    sql &= ' ORDER BY Name';
    results = queryExecute(sql, {}, { datasource = 'dsnWellness' });
    return results;
  }
}
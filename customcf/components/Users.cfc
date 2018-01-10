component Users {
  public function all() {
    var results = queryNew('');
    var sql = '';
    sql &= '   SELECT ID,';
    sql &= '          Email';
    sql &= '     FROM WellnessUser';
    sql &= ' ORDER BY Email';
    results = queryExecute(sql, {}, { datasource = 'dsnWellness' });
    return results;
  }
}

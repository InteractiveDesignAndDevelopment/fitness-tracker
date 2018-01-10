/**
 * Users.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/
component Users {
  public component function init() {
    return this;
  }

  public function all() {
    var results = queryNew('');
    var sql = '';
    sql &= '   SELECT ID,';
    sql &= '          Email';
    sql &= '     FROM WellnessUser';
    sql &= ' ORDER BY Email';
    results = queryExecute(sql, {}, { datasource = 'dsnWellness' });

    return usersQuerytoUserArray(results);
  }

  private array function usersQuerytoUserArray(required query query) {
    var userArray = [];
    for (row in query) {
      ArrayAppend(userArray, new User(row));
    }
    return userArray;
  }
}

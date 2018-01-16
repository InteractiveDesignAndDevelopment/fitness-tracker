/**
 * Users.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/
component Users accessors=true output=false persistent=false {

  this.usersArray = [];

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

  public function find() {
    var params = {};
    var results = queryNew('');
    var sql = '';

    savecontent variable='sql' {
      WriteOutput(' SELECT users.*');
      WriteOutput('   FROM users');

      if (StructKeyExists(arguments, 'where')) {
        WriteOutput(' WHERE 1=1');

        if (StructKeyExists(arguments.where, 'email')) {
          WriteOutput(' AND users.email = :email');
          params.email = arguments.where.email;
        }

        if (StructKeyExists(arguments.where, 'id')) {
          WriteOutput(' AND users.id = :id');
          params.id = arguments.where.id;
        }

      }

      WriteOutput(' ORDER BY email');
    }

    results = queryExecute(sql, params, { datasource = 'dsnWellness' });

    this.usersArray = usersQuerytoUserArray(results);
    return this;
  }

  public function toArray() {
    return this.usersArray;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private array function usersQuerytoUserArray(required query usersQuery) {
    var userArray = [];
    for (row in usersQuery) {
      ArrayAppend(userArray, new User(row));
    }
    return userArray;
  }
}

/**
 * Users.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-11
 **/
component Users accessors=true output=false persistent=false {

  this.userTypesArray = [];

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

  public component function find() {

    var params = {};
    var results = queryNew('');
    var sql = '';

    savecontent variable='sql' {
      WriteOutput('   SELECT user_types.*');
      WriteOutput('     FROM user_types');
      if (StructKeyExists(arguments, 'where')) {
        WriteOutput(' WHERE 1=1');
        if (StructKeyExists(arguments.where, 'id')) {
          WriteOutput(' AND user_types.id = :id');
          params.id = arguments.where.id;
        }
      }
      WriteOutput(' ORDER BY user_types.name');
    }
    // WriteDump(sql);

    results = queryExecute(sql, params, { datasource = 'dsnWellness' });

    this.userTypesArray = userTypesQueryToUserTypeArray(results);
    return this;
  }

  public component function first() {
    return this.toArray()[1];
  }

  public array function toArray() {
    return this.userTypesArray;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private array function userTypesQueryToUserTypeArray(required query userTypesQuery) {
    var userTypeArray = [];
    for (row in userTypesQuery) {
      ArrayAppend(userTypeArray, new UserType(row));
    }
    return userTypeArray;
  }
}

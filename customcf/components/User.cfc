/**
 * User.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/
component accessors=true output=false persistent=false {

  property email;
  property firstName;
  property id;
  property lastName;
  property userTypeID;

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function init () {
    var s = {};

    if (1 == arrayLen(arguments)) {
      if (IsNumeric(arguments[1])) {
        return new Users().find(where = { id = arguments[1] }).first();
      }
      if (IsStruct(arguments[1])) {
        s = arguments[1];
      }
    }

    if (StructKeyExists(s, 'email')) {
      setEmail(s.email);
    }

    if (StructKeyExists(s, 'first_name')) {
      setFirstName(s.first_name);
    }

    if (StructKeyExists(s, 'id')) {
      setID(s.id);
    }

    if (StructKeyExists(s, 'last_name')) {
      setLastName(s.last_name);
    }

    if (StructKeyExists(s, 'user_type_id')) {
      setUserTypeID(s.user_type_id);
    }

    return this;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public string function fullName() {
    return '#this.getFirstName()# #this.getLastName()#';
  }

  public boolean function isUnique() {
    var Users = createObject('component', 'Users');
    return 0 == ArrayLen(Users.find(where = { email = this.getEmail() }).toArray());
  }

  public boolean function save() {
    if (0 == Len(this.getID())) {
      return variables.insert(argumentsCollection = arguments);
    } else {
      return variables.update(argumentsCollection = arguments);
    }
  }

  public string function sortName() {
    return '#this.getLastName()#, #this.getFirstName()# (#this.getID()#)';
  }

  public numeric function sumActivity() {
    var Activities = createObject('component', 'Activities');
    var where = {
      user_id = this.getID()
    };

    if (StructKeyExists(arguments, 'where')) {
      StructAppend(where, arguments.where, false);
    }

    return Activities.sum(where = where);
  }

  public component function type() {
    return this.userType(argumentsCollection = arguments);
  }

  public component function userType() {
    if (0 == Len(this.getUserTypeID())) {
      return;
    }

    var UserTypes = createObject('component', 'UserTypes');
    var results = UserTypes.find(where = { id = getUserTypeID() });

    if (1 != ArrayLen(results.toArray())) {
      return;
    }

    return results.first();
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  // TODO: Add update functionality
  private boolean function update() {
  }

  private boolean function insert() {
    if (!this.isUnique()) {
      return false;
    }

    var sql = '';

    savecontent variable='sql' {
      WriteOutput(' INSERT INTO Users (');
      WriteOutput('   email,');
      WriteOutput('   first_name,');
      WriteOutput('   last_name,');
      WriteOutput('   user_type_id');
      WriteOutput(' )');
      WriteOutput(' OUTPUT INSERTED.*');
      WriteOutput(' VALUES (');
      WriteOutput('   :email,');
      WriteOutput('   :first_name,');
      WriteOutput('   :last_name,');
      WriteOutput('   :user_type_id');
      WriteOutput(' )');
    };

    var params = {
      email        = this.getEmail(),
      first_name   = this.getFirstName(),
      last_name    = this.getLastName(),
      user_type_id = this.getUserTypeID()
    };

    try {
      var results = queryExecute(sql, params, { datasource = 'dsnWellness' });
      // WriteDump(results);
      setID(queryGetRow(results, 1).id);
      return true;
    } catch (any e) {
      return false;
    }
  }

}

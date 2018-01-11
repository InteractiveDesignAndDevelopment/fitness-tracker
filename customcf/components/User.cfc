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
  property wellnessUserTypeID;

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function init () {
    if (1 == arrayLen(arguments) && IsStruct(arguments[1])) {
      var row = arguments[1];
      if (StructKeyExists(row, 'email')) {
        setEmail(row.email);
      }
      if (StructKeyExists(row, 'firstName')) {
        setFirstName(row.firstName);
      }
      if (StructKeyExists(row, 'id')) {
        setID(row.id);
      }
      if (StructKeyExists(row, 'lastName')) {
        setLastName(row.lastName);
      }
      if (StructKeyExists(row, 'wellnessUserTypeID')) {
        setWellnessUserTypeID(row.wellnessUserTypeID);
      }
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

  public boolean function isUnique() {
    var Users = createObject('component', 'Users');
    return 0 == ArrayLen(Users.find(where = { email = this.getEmail() }).toArray());
  }

  public boolean function save() {
    if (0 == Len(this.getID())) {
      return this.insert(argumentsCollection = arguments);
    } else {
      return this.update(argumentsCollection = arguments);
    }
  }

  public component function type() {
    return this.userType(argumentsCollection = arguments);
  }

  public component function userType() {
    if (0 == Len(this.getWellnessUserTypeID())) {
      return;
    }

    var UserTypes = createObject('component', 'UserTypes');
    var results = UserTypes.find(where = { id = getWellnessUserTypeID() });

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
  // private struct function update() {
  // }

  private boolean function insert() {
    if (!this.isUnique()) {
      return false;
    }

    var sql = '';

    savecontent variable='sql' {
      WriteOutput(' INSERT INTO WellnessUser (');
      WriteOutput('   Email,');
      WriteOutput('   Firstname,');
      WriteOutput('   Lastname,');
      WriteOutput('   WellnessUserTypeID');
      WriteOutput(' )');
      WriteOutput(' OUTPUT INSERTED.*');
      WriteOutput(' VALUES (');
      WriteOutput('   :email,');
      WriteOutput('   :firstName,');
      WriteOutput('   :lastName,');
      WriteOutput('   :wellnessUserTypeID');
      WriteOutput(' )');
    }

    var params = {
      email = this.getEmail(),
      firstName = this.getFirstName(),
      lastName = this.getLastName(),
      wellnessUserTypeID = this.getWellnessUserTypeID()
    }

    try {
      var results = queryExecute(sql, params, { datasource = 'dsnWellness' });
      WriteDump(results);
      setID(queryGetRow(results, 1).id);
      return true;
    } catch (err) {
      return false;
    }
  }

}

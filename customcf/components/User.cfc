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

}

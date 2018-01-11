/**
 * Challenge.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/
component accessors=true output=false persistent=false {
  property id;
  property name;

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function init() {
    if (1 == ArrayLen(arguments) && IsStruct(arguments[1])) {
      var row = arguments[1];
      if (StructKeyExists(row, 'id')) {
        setID(row.id);
      }
      if (StructKeyExists(row, 'name')) {
        setName(row.name);
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

  public array function activities () {
    return new Activities().find(where = { challengeID = getID() });
  }

  public array function activityTypes () {
    return new ActivityTypes().find(where = { challengeID = getID() })
  }
}

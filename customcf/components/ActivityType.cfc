/**
 * ActivityType.cfc
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
      var s = arguments[1];

      if (StructKeyExists(s, 'id')) {
        setID(s.id);
      }

      if (StructKeyExists(s, 'name')) {
        setName(s.name);
      }
    }

    return this;
  }

}

/**
 * ActivityType.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/

component accessors=true output=false persistent=false {

  property id;
  property isEnabled;
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

      if (StructKeyExists(s, 'isEnabled')) {
        if (IsBoolean(s.isEnabled)) {
          s.isEnabled = s.isEnabled ? 1 : 0;
        }
        setIsEnabled(s.isEnabled);
      }

      if (StructKeyExists(s, 'name')) {
        setName(s.name);
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

  public boolean function isEnabled() {
    return 1 == this.getIsEnabled();
  }

}

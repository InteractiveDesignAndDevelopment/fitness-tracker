/**
 * Challenge.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/
component accessors=true output=false persistent=false {
  property id;
  property isDefault;
  property isOpen;
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

      if (StructKeyExists(s, 'is_default')) {
        if (IsBoolean(s.is_default)) {
          s.is_default = boolToInt(s.is_default);
        }
        setIsDefault(s.is_default);
      }

      if (StructKeyExists(s, 'is_open')) {
        if (IsBoolean(s.is_open)) {
          s.is_open = boolToInt(s.is_open);
        }
        setIsOpen(s.is_open);
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

  public array function activities () {
    return new Activities().find(where = { challenge_id = getID() });
  }

  public array function activityTypes () {
    return new ActivityTypes().find(where = { challenge_id = getID() });
  }

  public boolean function isDefault () {
    return 1 == this.getIsDefault();
  }

  public boolen function isOpen () {
    return 1 == this.getIsOpen();
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private numeric function boolToInt(required boolean b) {
    return b ? 1 : 0;
  }

  private boolean function intToBool(required numeric i) {
    return 1 == i;
  }

}

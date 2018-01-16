<cfscript>
  UserTypes = createObject('component', 'components.UserTypes');
</cfscript>

<cfoutput>

  <form action="./user-registered.cfm" method="post">
    <div class="form-group">
      <label for="first_name">First name</label>
      <input class="form-control" type="text" id="first_name" name="first_name" required>
    </div>

    <div class="form-group">
      <label for="last_name">Last name</label>
      <input class="form-control" type="text" id="last_name" name="last_name" required>
    </div>

    <div class="form-group">
      <label for="email">Email address</label>
      <input class="form-control" type="email" id="email" name="email" required>
    </div>

    <div class="form-group">
      <label for="user_type_id">Employee or Student</label>
      <select class="form-control select2-control" id="user_type_id" name="user_type_id" required>
        <option></option>
        <cfloop array="#UserTypes.find().toArray()#" index="type">
          <option value="#type.getID()#">#type.getName()#</option>
        </cfloop>
      </select>
    </div>

    <div>
      <input class="btn btn-primary" type="submit" name="Submit" value="Register">
    </div>
  </form>

  <script>
    // Set the "bootstrap" theme as the default theme for all Select2
    // widgets.
    //
    // @see https://github.com/select2/select2/issues/2927
    $.fn.select2.defaults.set('theme', 'bootstrap');

    $('##WellnessUserTypeID').select2({
      placeholder: 'Select a user type',
      width: null
    });

    // copy Bootstrap validation states to Select2 dropdown
    //
    // add .has-waring, .has-error, .has-succes to the Select2 dropdown
    // (was ##select2-drop in Select2 v3.x, in Select2 v4 can be selected via
    // body > .select2-container) if _any_ of the opened Select2's parents
    // has one of these forementioned classes (YUCK! ;-))
    $( ".select2-control" ).on( "select2:open", function() {
      if ( $( this ).parents( "[class*='has-']" ).length ) {
        var classNames = $( this ).parents( "[class*='has-']" )[ 0 ].className.split( /\s+/ );

        for ( var i = 0; i < classNames.length; ++i ) {
          if ( classNames[ i ].match( "has-" ) ) {
            $( "body > .select2-container" ).addClass( classNames[ i ] );
          }
        }
      }
    });
  </script>

</cfoutput>

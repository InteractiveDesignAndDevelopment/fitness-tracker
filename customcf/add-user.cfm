<cfoutput>

  <form action="./add-user-action.cfm" method="post">
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

    <div>
      <!-- For 2018 All Users are Employees (id = 1) -->
      <input type="hidden" name="user_type_id" value="1">
      <input class="btn btn-primary" type="submit" name="Submit" value="Register User">
    </div>
  </form>

</cfoutput>

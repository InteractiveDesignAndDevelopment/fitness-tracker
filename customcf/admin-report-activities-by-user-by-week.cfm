<cfscript>
  Activities = createObject('component', 'components.Activities');
  foundActivities = Activities.find(url).toArray();
  report = {};
  report.users = {};
  report.sortedUserIDs = [];

  arrayEach(foundActivities, function(activity) {
    var user = activity.user();
    var userID = user.getID();
    var date = activity.getActivityDate();
    var yearWeek = '#Year(date)#-#Week(date)#';

    if (!StructKeyExists(report.users, userID)) {
      report.users[userID] = {};
      report.users[userID].user = user;
      report.users[userID].yearWeeks = {};
      report.users[userID].sortedYearWeekNames = [];
    }

    if (!StructKeyExists(report.users[userID].yearWeeks, yearWeek)) {
      report.users[userID].yearWeeks[yearWeek] = 0;
    }

    report.users[userID].yearWeeks[yearWeek] += activity.getMeasure();

    // WriteOutput('#userID#: #yearWeek# = #activity.getMeasure()#<br>');
  });

  // WriteDump(report);

  // Sort users
  StructEach(report.users, function(userID) {
    var user = report.users[userID].user;
    // WriteDump(user);
    ArrayAppend(report.sortedUserIDs, user.getID());
  });
  ArraySort(report.sortedUserIDs, function(uID1, uID2) {
    var sn1 = report.users[uID1].user.sortName();
    var sn2 = report.users[uID2].user.sortName();
    return compare(sn1, sn2);
  });

  // Sort year week names
  StructEach(report.users, function(userID) {
    var sortedYearWeekNames = StructKeyArray(report.users[userID].yearWeeks);
    ArraySort(sortedYearWeekNames, function(ywn1, ywn2) {
      // WriteDump('#ywn1# vs #ywn2#');
      var i1 = Int(reReplace(ywn1, '\D', '', 'all'));
      var i2 = Int(REReplace(ywn2, '\D', '', 'all'));
      // WriteDump('#i1# vs #i2#');
      return i1 < i2 ? -1 : i2 == i1 ? 0 : 1;
    });
    report.users[userID].sortedYearWeekNames = sortedYearWeekNames;
  });
</cfscript>

<cfoutput>

  <ul>
    <cfloop array="#report.sortedUserIDs#" index="sortedUserID">
      <li>
        #report.users[sortedUserID].user.fullName()#
        <ul>
          <cfloop array="#report.users[sortedUserID].sortedYearWeekNames#" index="sortedYearWeekName">
            <li>#sortedYearWeekName#: #report.users[sortedUserID].yearWeeks[sortedYearWeekName]#</li>
          </cfloop>
        </ul>
      </li>
    </cfloop>
  </ul>

</cfoutput>

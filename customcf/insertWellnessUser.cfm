

<!--- Check for email address already registered --->
<cfquery name="getWellnessUsers" datasource="dsnWellness" result="queryResult">
	SELECT TOP 1
		Email
	  FROM WellnessUser
	  WHERE Email = '#Form.Email#'
</cfquery>

<!--- Get name of Wellness User Type of this user --->
<cfquery name="getWellnessUserType" datasource="dsnWellness">
SELECT
	ID
	, Name
FROM WellnessUserType
WHERE ID = #Form.WellnessUserTypeID#
</cfquery>

<cfoutput query="getWellnessUserType">
	<cfset WellnessUserTypeName = #Name#>
</cfoutput>

<cfoutput>
	<cfif queryResult.RecordCount EQ 0>
	
		<CFSTOREDPROC procedure="sproc_Insert_User" datasource="dsnWellness">
			<CFPROCPARAM type="In" cfsqltype="CF_SQL_VARCHAR" null="no" value="#Form.Firstname#">
			<CFPROCPARAM type="In" cfsqltype="CF_SQL_VARCHAR" null="no" value="#Form.Lastname#">
			<CFPROCPARAM type="In" cfsqltype="CF_SQL_VARCHAR" null="no" value="#Form.Email#">
			<CFPROCPARAM type="In" cfsqltype="CF_SQL_INTEGER" null="no" value="#Form.WellnessUserTypeID#">
		</CFSTOREDPROC>
		
		<p><strong>Successfully registered user:</strong><br />
		Firstname = #Form.Firstname#<br />
		Lastname = #Form.Lastname#<br />
		Email = #Form.Email#<br />
		Type = #WellnessUserTypeName#
		</p>
	<cfelse>
		<p style="color:red">#Form.Email# has already been registered.</p>

	</cfif>
</cfoutput>
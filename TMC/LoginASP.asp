<!-- # include file="RED.asp" -->

<%
'REDConnString="DRIVER={SQL Server};SERVER=192.168.1.31;UID=mainuser;PWD=76.Admin;DATABASE=MCBase"
REDConnString="DSN=mcbase;UID=mainuser;PWD=562.Admin;Database=MCBase"
REDConnString="DRIVER={SQL Server};SERVER=127.0.0.1;UID=mainuser;PWD=562.Admin;DATABASE=MCBase"

Application("tmcVer")="1.0.0.3047"
Application("tmcVersion")="1.0.0.3047beta"
Application("tmcMajorReleaseDate")="2015.10.14"
Application("tmcMinorReleaseDate")="2015.10.14"
Application("tmcReleaseDate")="2015.10.14"
Application("tmcBuildDate")="2015.10.14"

Dim GlobalCustID
Dim sAction 

sAction = CStr(Request.QueryString("action"))

Select Case sAction
	Case "Login"
		Login
		
	Case "Validate"
		Validate
		
	Case Else 
		 oops 
				
End Select		

'---------------------------------------------------------------------------------------------------------------------
Sub Login

	Dim Pass, User
	Dim XML	
	Dim XMLtext

	response.ContentType = "text/xml"
	If Request.QueryString("HTML")=1 Then Response.ContentType="text/html"
	
	%><root><%

	Pass = cstr(Request.QueryString("Pass"))
	User = CStr(Request.QueryString("User"))
	Mobile= CStr(Request.QueryString("M"))

	Session.Timeout=1440'Minutes
	Session("Pass")=Pass
	Session("User")=User
	Session("Mobile")=Mobile

	SQL1 ="SELECT UserName, EmpID, Email, Password, URL, mURL FROM Access WHERE (UserName='"&User&"' OR Email='"&User&"@tricomlv.com') AND Password='"&Pass&"'"
	%><SQL1><%=SQL1%></SQL1><%
	%><serverCreateObject><% set rs1=Server.CreateObject("ADODB.Recordset") %></serverCreateObject><%
	%><cs><%=REDConnString%></cs><%
	%><rsOpen><% rs1.Open SQL1, REDConnString %></rsOpen><%
	
	If rs1.EOF Then
		%><EmpID>0</EmpID><%
	Else
		If rs1("Password")<>Pass Then'Forces case sensitivity.
			%><EmpID>0</EmpID><%
		Else
			%><EmpID><%=rs1("EmpID")%></EmpID><% 
			
			if Mobile="Mobile" Then
				url=Replace(rs1("mURL"),"--TIMESTAMP--",timer)
			Else
				url=Replace(rs1("URL"),"--TIMESTAMP--",timer)
			End If	
			loginDest=Session("LoginDestination")
			Session("LoginDestination")=""
			%><url>--<%=url%></url><%
			%><mDest>--<%=loginDest%></mDest><%
			%><loginDest>--<%=loginDest%></loginDest><%
			
			SQL2 ="SELECT EmpID, FName, LName, UserName, Email FROM Employees WHERE EmpID="&rs1("EmpID")
			set rs2=Server.CreateObject("ADODB.Recordset")
			rs2.Open SQL2, REDconnstring
			
			%><EmpFName>--<%=rs2("Fname")%></EmpFName><%
			%><EmpLName>--<%=rs2("Lname")%></EmpLName><%
			%><user>--<%=rs1("UserName")%></user><%
			
			Session("user")=rs1("UserName")
			Session("userName")=rs2("Fname")&" "&rs2("Lname")
			Session("EmpId")=rs2("EmpID")
			Session("userEmail")=rs2("Email")
			
			Application.Lock
				Application("visitors")=Application("visitors")+1 'Currently logged In
				Application("logins")=Application("logins")+1	'Total logins since application start
				Application("SessionID"&Application("logins"))=Session.SessionID
				Application("loginNum"&Session.SessionID)=Application("logins")
				
				Application("SessionGone"&Session.SessionID)=0
				'''''These Just reset the biz. --Don't forget to re-remark them out!
				'Application("visitors")=1
				'Application("logins")=1
				'Application("SessionID"&Application("logins"))=Session.SessionID
			Application.UnLock
		End If
	End if	

	%>		
		<User>--<%=User%></User>
		<%
		'It's a dumb Idea to return the password information, so use the following code only in emergency debugging situations. AND BE SURE TO FIX IT WHEN DONE!
		'<Pass>--<%=Pass% ></Pass>
		'<dumbIdea>--<%=rs1("Password")% ></dumbIdea>
		%>
	</root>
	<%
	set rs1 = nothing
	set rs2 = nothing

End Sub'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


'---------------------------------------------------------------------------------------------------
Sub Validate
	
	Dim Validated
	Dim Pass
	Dim User
	Dim XML
	Dim URL
	
	If Session.Contents.Count<=1Then
		Validated=0
	Else
		Pass=Session("Pass")
		User=Session("User")
		if (IsNull(Pass)) or (IsNull(User)) or Pass = "" or User = "" Then
			Validated=0
		Else

			SQL1 ="SELECT * FROM Access WHERE Password='"&Pass&"' AND UserName='"&User&"'"
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			XMLtext = ""
			If rs1.EOF Then
				Validated=0 'This shouldn't happen.
			Else
				URL = rs1("URL")
				mDest="0"
				If Session("LoginDestination")<>"" Then 
					mDest=Session("LoginDestination")
					Session("LoginDestination")=""
				End If
					
				Validated=1
				Application.Contents("UserList")=Application.Contents("UserList")&User&","
				
				Session("accessID")=rs1("LoginID")
				Session("accessDataEntry")=rs1("DataEntry")
				Session("accessEstimates")=rs1("Estimates")
				Session("accessProjects")=rs1("Projects")
				Session("accessService")=rs1("Service")
				Session("accessTest")=rs1("Test")
				Session("accessEngineering")=rs1("Engineering")
				Session("accessPurchasing")=rs1("Purchasing")
				Session("accessTime")=rs1("Time")
				Session("accessOffice")=rs1("Office")
				Session("accessInventory")=rs1("Inventory")
				Session("accessTraining")=rs1("Training")
				Session("accessWebsite")=rs1("Website")
				Session("accessAdmin")=rs1("Admin")
				Session("accessMobile")=rs1("Mobile")
				Session.Timeout=rs1("SessionTimeout")
				
			End if
		End If
	End If

		
	response.ContentType = "text/xml"
	%>
	<root>
		<Validated>Validated</Validated>
		<URL><%=URL%></URL>
		<mDest><%=mDest%></mDest>
	</root>
	<%
	set rs1 = nothing

End Sub'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub oops  () '--------------------------------------------------------------------------------------------------------

response.write Application("tmcVersion")

End Sub '------------------------------------------------------------------------------------------------------------------------

%>

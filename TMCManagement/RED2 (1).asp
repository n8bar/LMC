<root>
<% 

Select Case lCase(Request.QueryString("action"))

	Case "relogin"
		Session("user")=Request.QueryString("user")
		Session("userName")=Request.QueryString("userName")
		Session("userEmail")=Request.QueryString("userEmail")
		Session("EmpId")=Request.QueryString("EmpId")
	
	Case Else
	
End Select
%> 
</root>
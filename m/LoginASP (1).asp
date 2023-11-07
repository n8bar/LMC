<!--#include file="RED.asp" -->

<%
Response.Buffer= True

Dim sAction 

sAction = CStr(Request.QueryString("action"))

Select Case sAction
		
	Case "Login"
		Login
		

	Case Else
		Elsify
		
End Select		





Sub Login
	Dim User
	Dim Pass
	Dim XML
	
	Pass = CStr(Request.QueryString("Pass"))
	User = CStr(Request.QueryString("User"))
	
	SQL1 ="SELECT * FROM Access WHERE Password='"&Pass&"' AND UserName='"&User&"'"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	If rs1.EOF Then
		XML = XML&"<EmpID>0</EmpID>"
	Else
		
		if rs1("Mobile")="True" then
	
			XML = XML&"<EmpID>"&rs1("EmpID")&"</EmpID>" 
			XML = XML&"<url>--"&rs1("URL")&"</url>"
			
			SQL2 ="SELECT * FROM Employees WHERE EmpID="&rs1("EmpID")
			set rs2=Server.CreateObject("ADODB.Recordset")
			rs2.Open SQL2, REDconnstring
			
			XML = XML&"<EmpFName>--"&rs2("Fname")&"</EmpFName>"
			XML = XML&"<EmpLName>--"&rs2("Lname")&"</EmpLName>"
		Else
			XML = XML&"<EmpID>0</EmpID>"
		End If
	
		
	End if	
	
	XML = "<root>"&XML&"<User>--"&User&"</User></root>"
	
	set rs1 = nothing
	set rs2 = nothing
	
	response.ContentType = "text/xml"
	response.Write(XML)
End Sub



Sub Elsify

End Sub
%>
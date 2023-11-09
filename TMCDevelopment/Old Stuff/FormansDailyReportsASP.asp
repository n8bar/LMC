<!--#include file="../../LMC/RED.asp" -->

<%
Response.ContentType = "text/xml"

%>
<root>
	<action><%=Request.QueryString("action")%></action>
<%

Select Case CStr(Request.QueryString("action"))

	Case "NewReport"
		NewReport
		
	Case Else 
		 oops 
				
End Select		


%>
</root>
<%


Sub NewReport  () '------------------------------------------------------------------------

	ProjID=Request.QueryString("ProjID")
	d8=Request.QueryString("Date")
	
	%><Date><%=d8%></Date><%
	
	SQL="SELECT * FROM FormansReport WHERE Date='"&d8&"' AND ProjID="&ProjID
	%><SQL><%=SQL%></SQL><%
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.open SQL, REDConnString
	
	If rs.EOF Then
		%><Exists>0</Exists><% 
		
		SQL2="INSERT INTO FormansReport (Date, ProjID) VALUES ('"&d8&"',"&ProjID&")"
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.open SQL2, REDConnString
	Else
		%><Exists>1</Exists><%
		%><ReportID><%=rs("ReportID")%></ReportID><% 
	End If
	
		%><ProjID><%=ProjID%></ProjID><%
	
	Set rs=Nothing
	Set rs2=Nothing
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub oops ()'------------------------------------------------------------------------
	%>
	<Error>Missing "action" subroutine assignment for:<%=Request.QueryString("action")%></Error>
	<%
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%>
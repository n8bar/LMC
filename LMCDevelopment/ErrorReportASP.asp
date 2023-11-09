<!--#include file="../LMC/RED.asp" -->
<%
'Dim sAction 
'sAction = 
	
	Dim URL : URL = CStr(Request.QueryString("URL"))
	Dim MSG : MSG = CStr(Request.QueryString("MSG"))
	Dim Line: Line= CStr(Request.QueryString("Line"))
	Dim UN  : UN  = CStr(Request.QueryString("UN"))
	
	Dim DateTime: DateTime=Date&" "&Time
	
	SQL="INSERT INTO ErrorReport (Time, URL, MSG, Line, UserName) VALUES ('"&DateTime&"', '"&URL&"', '"&MSG&"', "&Line&", '"&UN&"')"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	response.ContentType = "text/xml"
%>
<root>
	<DateTime><%=DateTime%></DateTime>
	<url><%=URL%></url>
	<msg><%=MSG%></msg>
	<line><%=Line%></line>
	<UN><%=UN%></UN>
</root>
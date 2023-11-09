<%

response.ContentType="text/xml"

VarValue=Session(Request.QueryString("variable"))

if VarValue="" Then VarValue="0"

%>

<root>

	<value><%=VarValue%></value>

</root>
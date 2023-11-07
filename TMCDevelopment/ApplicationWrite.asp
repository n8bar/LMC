
<root>
	<variable><%=Request.QueryString("Variable")%></variable>
	<value><%=Request.QueryString("Value")%></value>
<%Application(Request.QueryString("Variable"))=Request.QueryString("Value")%>
</root>
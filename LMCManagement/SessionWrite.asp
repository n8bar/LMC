<root>
	<variable><%=Request.QueryString("Variable")%></variable>
	<value><%=Request.QueryString("Value")%></value>
<%Session(Request.QueryString("Variable"))=Request.QueryString("Value")%>
</root>
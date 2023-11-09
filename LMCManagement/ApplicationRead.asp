<% response.ContentType="text/xml" %>
<root>
	<variable>--<%=Request.QueryString("Variable")%></variable>
	<value>--<%=Application(Request.QueryString("Variable"))%></value>
</root>
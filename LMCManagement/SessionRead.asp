<% response.ContentType="text/xml" %>
<root>
	<variable>--<%=Request.QueryString("Variable")%></variable>
	<value>--<%=Session(Request.QueryString("Variable"))%></value>
</root>
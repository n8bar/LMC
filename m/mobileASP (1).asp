<%
SELECT CASE lCase(request.QueryString("action"))
	Case "logout"
		Session.Abandon()
End Select
%>
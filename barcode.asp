<html>
<head>
<style>
button { width:50%; font-size:72px; padding:16px 0; }
</style>
<%
PartIDOption=False
Code=Request.QueryString("q") : If Code="" Or IsNull(Code) Then Code=Request.QueryString("CODE")
If IsNumeric(Code) Then 
	If len(Code)=12 or len(Code)=14 Then
		%>
		<script>
			window.onload=function() { window.location='m/upc.asp?q=<%=Code%>'; }
		</script>
		<%
		Response.End()
	End If
	
	%>
	</head>
	<body style="text-align:center;">
	
		Code: <%=Code%>
		<h1><button onClick="window.location='m/Part.asp?pID=<%=Code%>'">Tricom Part ID</button></h1>
		<h1><button onClick="window.location='m/Part.asp?pn=<%=Code%>'">Part Number</button></h1>
	</body>
	</html>	
	<%	Response.End() 
Else
	%>
	<script>
		//window.onload=function() { window.location='m/part.asp?pn=<%=Code%>'; } 
		window.onload=function() { window.location='m/Inventory.asp?search=<%=Code%>'; } 
	</script>
	<%
End If

%>
<body>
</body>
</html>
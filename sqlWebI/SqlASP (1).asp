<!-- #include file="../LMC/RED.asp" -->
<%
If request.QueryString("html")=1 then Response.ContentType="text/html" else Response.ContentType = "text/xml"

'Dim XML
%><root><%

SQL=CStr(Request.QueryString("SQL"))
%><SQL><%=SQL%></SQL><%
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring
	
Dim Action: Action = CStr(Request.QueryString("action"))
	
	Select Case Action
	
		Case "Read"
			
			Data = rs.getRows
			
			%>
				<RecordCount><%=uBound(Data)%></RecordCount>
			<%
			
			For i=0to uBound(Data)
			%>
				<field<%=i%>><%=Data(i)%></field><%=i%>>
			<%
			Next



		Case "Write"
		
		
	End Select
	
	
	
set rs = nothing
%>

<Action><%=Action%></Action>

</root>
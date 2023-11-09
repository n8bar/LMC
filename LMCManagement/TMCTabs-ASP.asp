<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%

content="text/xml"
if Request.QueryString("HTML")=1 Then content="text/html"
Response.ContentType=content

%>
<!-- #include file="../LMC/RED.asp" -->
<root>
	<action><%=Request.QueryString("action")%></action>

<%

Select Case Request.QueryString("action") 
	
	Case "subTabs"
		
		parentTabId=Request.QueryString("parentTabId")
		%><parentTabId><%=parentTabId%></parentTabId><%
		
		WhereElse=""
		If session("User") <> "n8" Then WhereElse="AND comingSoon!='True'"
		SQL="SELECT subTabId, tabName, frameSrc, comingSoon, txtColor,Color FROM subTabs WHERE parentTabId="&parentTabId&" "&WhereElse&" ORDER BY orderIndex"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		rCount=0
		Do Until rs.EOF
			rCount=rCount+1
			
			%>
			<subTabId<%=rCount%>><%=rs("subTabId")&"</subTabId"&rCount&">"%>
			<tabName<%=rCount%>><%=rs("tabName")&"</tabName"&rCount&">"%>
			<frameSrc<%=rCount%>><%=EncodeChars(rs("frameSrc"))&"</frameSrc"&rCount&">"%>
			<comingSoon<%=rCount%>><%=rs("comingSoon")&"</comingSoon"&rCount&">"%>
			<txtColor<%=rCount%>><%=rs("txtColor")&"</txtColor"&rCount&">"%>
			<tColor<%=rCount%>><%=rs("Color")&"</tColor"&rCount&">"%>
			<%
			
			rs.MoveNext
		Loop
	
		%><rCount>0<%=rCount%></rCount><%


	Case "keepAlive"
		
		
		
		
	Case Else
		%>
		
		<%
End Select
%>

</root>

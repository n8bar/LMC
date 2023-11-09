<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../LMC/RED.asp"-->
<%
response.ContentType="text/xml"
if request.QueryString("html")=1 Then response.ContentType="text/html"
qry=request.QueryString("qry")

if qry="" Then
	%><error>Empty qry</error><%
	response.End()
End If

SQL="SELECT Name, Phone1, Phone2, Cphone1 FROM Contacts WHERE Name LIKE '%"&qry&"%' OR Phone1 LIKE '%"&qry&"%' OR Phone2 LIKE '%"&qry&"%' OR Cphone1 LIKE '%"&qry&"%' OR Cphone2 LIKE '%"&qry&"%'"
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString

%>
<contactData>
  <group>
		<%
		c=0
		Do Until rs.EOF
			%><contact sDisplayName="<%=rs("Name")%>" sOfficeNumber="<%=rs("Phone1")%>" sMobilNumber="<%=rs("CPhone1")%>" sOtherNumber="<%=rs("Phone2")%>" sLine="Auto" sRing="Auto"/><%
			c=c+1
			rs.MoveNext
		Loop
		%>
  </group>
  <blacklist></blacklist>
	<count><%=c%></count>
</contactData>

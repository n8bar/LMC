<!--#include file="../../LMC/RED.asp" -->
<%
Format=lcase(Request.QueryString("Format"))
If Format <> "html" Then Format="xml"
Response.ContentType="text/"&Format
If Request.QueryString("Html")=1 Then Response.ContentType="text/html"

PartID = CStr(Request.QueryString("ID"))
POID = CStr(Request.QueryString("POID"))
%>
<root>
	<%If Format="html" Then %><br/>Format:<% End If%>
	<format><%=Format%></format>
	<%If Format="html" Then %><br/>Action:<% End If%> 
	<action><%=sAction%></action> 
<%	
	SQL="SELECT * FROM Parts WHERE PartsID="&PartID
	%><SQL><%=SQL%></SQL><%
	Set rs= Server.CreateObject("AdoDB.RecordSet")
	rs.Open SQL, REDConnString
	
	If Not rs.EOF Then
		GMToffset = -7
		GMToffsetseconds = (0-GMToffset) * 3600
		GMTTime = DateAdd("s",GMToffsetseconds,Now())
		TimeStamp = DateDiff("s","1/1/1970",GMTTime)*3600
		CreationKey=Session.SessionID&TimeStamp
		Columns="(PartID,POID,Qty,PartNumber,Cost,Description,CreationKey)"
		SQL1="INSERT INTO POItems "&Columns&" VALUES ("&PartID&","&POID&",1,'"&rs("PartNumber")&"', '"&rs("Cost")&"', '"&rs("Description")&"', '"&CreationKey&"')"
		%><SQL1><%=SQL1%></SQL1><%
		Set rs1= Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		Set rs1=Nothing
		
		SQL2="Select * FROM POItems WHERE CreationKey='"&CreationKey&"'"
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2= Server.CreateObject("AdoDB.RecordSet")
		rs2.Open SQL2, REDConnString
		POItemsID=rs2("POItemsID")
		Set rs2=Nothing
		
		%>
		<PartFound>1</PartFound>
		<pID><%=PartID%></pID>
		<PN><%=rs("PartNumber")%></PN>
		<Desc><%=rs("Description")%></Desc>
		<Cost><%=rs("Cost")%></Cost>
		<POItemsID><%=POItemsID%></POItemsID>
		<%
	Else
		%>
		<PartFound>0</PartFound>
		<%
	End If
	
	Set rs=Nothing
%>
</root>
<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%

content="text/xml"
if Request.QueryString("HTML")=1 Then content="text/html"
Response.ContentType=content

%>
<!-- #include file="../TMC/RED.asp" -->
<root>
	<action><%=Request.QueryString("action")%></action>

<%

Select Case Request.QueryString("action") 
	
	Case "LoadEvents"
		
		wDate=Request.QueryString("week")
		
		wkDay=weekDay(wDate)
		Monday=DateAdd("d",2-wkDay,wDate)
		Tuesday=DateAdd("d",1,Monday)
		Wednesday=DateAdd("d",2,Monday)
		Thursday=DateAdd("d",3,Monday)
		Friday=DateAdd("d",4,Monday)
		Saturday=DateAdd("d",5,Monday)
		Sunday=DateAdd("d",-1,Monday)
		Sunday2=DateAdd("d",6,Monday)
		
		%>
		<Sunday><%=Sunday%></Sunday>
		<Sunday2><%=Sunday2%></Sunday2>
		<userEmpID>--<%=Session("EmpId")%></userEmpID>
		<%
		
		
		W1="(DateFrom <='"&Sunday&"' AND DateTo >='"&Sunday&"')"  	'Events that Include this Sunday
		W2="(DateFrom <='"&Sunday2&"' AND DateTo >='"&Sunday2&"')"	'Events that Include next Sunday
		W3="(DateFrom >='"&Sunday&"' AND DateTo <='"&Sunday2&"')" 	'Events that land within the week
		
		EvCount=0
		
		SQL="SELECT * FROM Calendar WHERE "&W1&" OR "&W2&" OR "&W3&" ORDER BY AttentionID, DateFrom, TaskID, Done"
		Set rs= server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		Do Until rs.EOF
			EvCount=EvCount+1
			%>
			<ID<%=EvCount%>><%=rs("CalID")%></ID><%=EvCount%>>
			<AttnID<%=EvCount%>><%=rs("AttentionID")%></AttnID><%=EvCount%>>
			<From<%=EvCount%>><%=rs("DateFrom")%></From><%=EvCount%>>
			<TaskID<%=EvCount%>><%=rs("TaskID")%></TaskID><%=EvCount%>>
			<To<%=EvCount%>><%=rs("DateTo")%></To><%=EvCount%>>
			<Event<%=EvCount%>><%=rs("Title")%></Event><%=EvCount%>>
			<Note<%=EvCount%>><%=rs("Note")%></Note><%=EvCount%>>
			<JobID<%=EvCount%>><%=rs("JobID")%></JobID><%=EvCount%>>
			<Crew<%=EvCount%>><%=rs("CrewNames")%></Crew><%=EvCount%>>
			<Done<%=EvCount%>><%=rs("Done")%></Done><%=EvCount%>>
			<%
			
			SQL1="SELECT * FROM GantRows WHERE AttnID="&rs("AttentionID")&" AND Monday='"&Monday&"'"
			Set rs1=Server.CreateObject("AdoDB.RecordSet")
			rs1.Open SQL1, REDConnString
			
			If rs1.EOF Then
				SQL2="INSERT INTO GantRows (AttnID,Monday) VALUES ("&rs("AttentionID")&",'"&Monday&"')"
				Set rs2=Server.CreateObject("AdoDB.RecordSet")
				rs2.Open SQL2, REDConnString
				Set rs2=Nothing
				Set rs1=Nothing
				SQL1="SELECT * FROM GantRows WHERE AttnID="&rs("AttentionID")&" AND Monday='"&Monday&"'"
				Set rs1=Server.CreateObject("AdoDB.RecordSet")
				rs1.Open SQL1, REDConnString
			End If
			if rs.EOF then %><Bezerk>No Way Man!!!</Bezerk><% End If
			'rs.MoveNext
			'if rs.EOF then % ><Bezerk>WHAT THE HECK?!?!?</Bezerk><% End If
			
			%>
			<SQL2-<%=EvCount%>><%=SQL2%></SQL2-><%=EvCount%>> 
			<SQL1-<%=EvCount%>><%=SQL1%></SQL1-><%=EvCount%>>
			<Vehicle<%=EvCount%>>--<%=rs1("Vehicle")%></Vehicle><%=EvCount%>>
			<weekCrew<%=EvCount%>>--<%=rs1("Crew")%></weekCrew><%=EvCount%>>
			<GantRowID<%=EvCount%>><%=rs1("GantRowID")%></GantRowID><%=EvCount%>>
			<%
			Set rs1=Nothing

			SQL3 = "SELECT * FROM Employees WHERE EmpID="&rs("AttentionID")
			Set rs3=Server.CreateObject("AdoDB.RecordSet")
			rs3.Open SQL3, REDConnString
			%>
			<empName<%=EvCount%>><%=rs3("FName")&" "&rs3("LName")%></empName><%=EvCount%>>
			<%
			Set rs3=Nothing
			
			SQL4 = "SELECT * FROM Tasks WHERE TaskID="&rs("TaskID")
			Set rs4=Server.CreateObject("AdoDB.RecordSet")
			rs4.Open SQL4, REDConnString
			%>
			<BgColor<%=EvCount%>><%=rs4("BgColor")%></BgColor><%=EvCount%>>
			<TextColor<%=EvCount%>><%=rs4("TextColor")%></TextColor><%=EvCount%>>
			<AltBgColor<%=EvCount%>><%=rs4("AltBgColor")%></AltBgColor><%=EvCount%>>
			<%
			Set rs4=Nothing
			
			rs.MoveNext
		Loop
		%>
		<evCount><%=evCount%></evCount>
		
		<%
		
	Case Else
		%>
		
		<%
End Select
%>

</root>

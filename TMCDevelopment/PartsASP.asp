<!--#include file="../LMC/RED.asp" -->
<%
Format=lcase(Request.QueryString("Format"))
If Format <> "html" Then Format="xml"
Response.ContentType="text/"&Format
If Request.QueryString("Html")=1 Then Response.ContentType="text/html"

sAction = CStr(Request.QueryString("action"))
%>
<root>
	<%If Format="html" Then %><br/>Format:<% End If%>
	<format><%=Format%></format>
	<%If Format="html" Then %><br/>Action:<% End If%> 
	<action><%=sAction%></action> 
<%	

Select Case sAction
	
	Case "SearchParts"
		
		SearchTxt = CStr(Request.QueryString("SearchTxt"))
		SearchName = CStr(Request.QueryString("SearchName"))
		
		MfrColor = "000"  
		PartColor = "000"  
		DescColor = "000"  
		Select Case SearchName
			Case "Manufacturer"
				MfrColor = "DD00DD" 
		
			Case "PartNumber" 
				PartColor = "DD00DD" 
			
			Case "Description" 
				DescColor = "DD00DD" 
		End Select
		%>
		<MfrColor><%=MfrColor%></MfrColor>
		<PartColor><%=PartColor%></PartColor>
		<DescColor><%=DescColor%></DescColor>
		<%
	
		SQL = "SELECT * FROM Parts WHERE "&SearchName&" LIKE '%"&SearchTxt&"%'"
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring	
		
		MaxResults=256
		Maxed=False
		rNum=0
		Do While Not rs.EOF
			rNum=rNum+1
			
			pID=rs("PartsID")
			
			%>
			<pID<%=rNum%>><%=pID%></pID><%=rNum%>>
			<Mfr<%=rNum%>><%=rs("Manufacturer")%></Mfr><%=rNum%>>
			<PN<%=rNum%>><%=rs("PartNumber")%></PN><%=rNum%>>
			<Cost<%=rNum%>><%=rs("Cost")%></Cost><%=rNum%>>
			<Desc<%=rNum%>><%=rs("Description")%></Desc><%=rNum%>>
			<%
			
			If rNum>=MaxResults Then 
				Maxed=True
				Exit Do
			End If
						
			rs.MoveNext 
		Loop
		Set rs = nothing				 
		
		
		If Maxed Then
			%><maxed><%=1%></maxed><%
		Else
			%><maxed><%=0%></maxed><%
		End If
		
		%>
		<matches><%=rNum%></matches>
		<max><%=MaxResults%></max>
		<%
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''	
		
		
		
		
	Case Else
	
		If Format="html" Then %><br/>Error:<% End If%>
		<error>Cannot find routine for <%=sAction%></error>
	<%	
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''	
	
End Select
%>
</root>
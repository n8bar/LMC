<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Custom SQL Scripting</title>
<!--#include file="../LMC/RED.asp" -->
</head>

<body>
<%
If Request.QueryString("Careful")=1 Then 
	%>Careful...<%
	Response.End()
End If

Server.ScriptTimeout=1000

Select Case Request.QueryString("Script")

	Case "PhoneNumFix"
	
			BadChars=Array(" "," ","-",".","(",")")
			
			Columns=Array("Phone1","Phone2","Fax","CPhone1","CPhone2")
			
			For F=0 to uBound(Columns)
				%><h2><%=Columns(F)%>:</h3><%
				For Char= 0 To uBound(BadChars)
					%><h3> &nbsp; &nbsp; <%=BadChars(Char)%></h3><%
					SQL="SELECT * FROM CustomersBackup20101102 WHERE "&Columns(F)&" LIKE '%"&BadChars(Char)&"%' "
					Set rs=Server.CreateObject("AdoDB.RecordSet")
					rs.Open SQL, REDConnString
					
					Do Until rs.EOF
						%><span><%=rs("CustID")%>: &nbsp; &nbsp; &nbsp; &nbsp;<%=rs(Columns(F))%> -></span><%
						NewValue=rs(Columns(F))
						OldValue=""
						Do Until OldValue=NewValue
							For Char2=0 To uBound(BadChars)
								OldValue=NewValue
								NewValue=Replace(OldValue,BadChars(Char2),"")
							Next
						Loop
						
						If NewValue="" Then NewValue="NULL"
							
						%> <%=NewValue%> &nbsp; : &nbsp; <%
					
						SQL1="UPDATE Customers SET "&Columns(F)&"="&NewValue&" WHERE CustID="&rs("CustID")
						%> <%=SQL1%> <br/><%
						Set rs1=Server.CreateObject("AdoDB.RecordSet")
						rs1.Open SQL1, REDConnString
						Set rs1=Nothing
							
						Response.Flush()
						rs.MoveNext
					Loop
					Set rs=Nothing
				Next
			Next
		
	
	Case "AposFixer"
		
			'SQL="SELECT BidItemsID, ItemDescription FROM BidItems WHERE ItemDescription like '%''%'"
			'Set rs=Server.CreateObject("AdoDB.RecordSet")
			'rs.Open SQL, REDConnString
			
			SQL="SELECT PartsID, PartNumber, Description FROM Parts WHERE Description like '%''%'"
			Set rs=Server.CreateObject("AdoDB.RecordSet")
			rs.Open SQL, REDConnString
			
			Do Until rs.EOF
				
				'ItemDescription=EncodeChars(rs("ItemDescription"))
				'
				'
				'SQL2="UPDATE BidItems SET ItemDescription='"&ItemDescription&"' WHERE BidItemsID="&rs("BidItemsID") 
				'% ><b>SQL2:</b><%=SQL2%><br/><%
				'Set rs2=Server.CreateObject("AdoDB.RecordSet")
				''rs2.Open SQL2, REDConnString
				
				
				Desc=EncodeChars(rs("PartNumber"))
				'Desc=EncodeChars(rs("Description"))
				
				SQL2="UPDATE Parts SET PartNumber='"&Desc&"' WHERE PartsID="&rs("PartsID") 
				'SQL2="UPDATE Parts SET Description='"&Desc&"' WHERE PartsID="&rs("PartsID") 
				%><b>SQL2:</b><%=SQL2%><br/><%
				Set rs2=Server.CreateObject("AdoDB.RecordSet")
				rs2.Open SQL2, REDConnString
				
				
				
				rs.MoveNext
			Loop










'''''''''''''''''''''''''''''''''''''''''''''''
	Case "PartsMesh"                            '
'''''''''''''''''''''''''''''''''''''''''''''''			
			SQL="SELECT BidItemsID, ItemName, ItemDescription FROM BidItems WHERE PartID is NULL"
			Set rs=Server.CreateObject("AdoDB.RecordSet")
			rs.Open SQL, REDConnString
			
			Max=3000
			Loops=0
			On Error Resume Next
			Do Until rs.EOF
				Loops=Loops+1
				'If Loops>=Max Then Exit Do
				%><h2><%=Loops%></h2><%
				
				
				PN=rs("ItemDescription")
					
					
				'SQL1="SELECT PartsID FROM Parts WHERE Description='"&PN&"' OR PartNumber='"&PN&"'"
				'SQL1="SELECT PartsID FROM Parts WHERE Description='"&PN&"'"' OR PartNumber='"&PN&"'"
				SQL1="SELECT PartsID FROM Parts WHERE PartNumber='"&PN&"'"
				%><b>SQL1:</b><%=SQL1%><br/><%
				Response.Flush()
				Set rs1=Server.CreateObject("AdoDB.RecordSet")
				rs1.Open SQL1, REDConnString
				If Err.number <> 0 then
					%>
					<h4 style="color:red;">Error:<span style="font-family:Consolas; font-weight:normal; font-size:12px;"><%=Err.description%></span></h4>
					<%
					Err.number=0
				End If
				
				If Not rs1.EOF Then
					SQL2="UPDATE BidItems SET PartID="&rs1("PartsID")&" WHERE BidItemsID="&rs("BidItemsID")
					%><b>SQL2:</b><%=SQL2%><br/><%
					Response.Flush()
					Set rs2=Server.CreateObject("AdoDB.RecordSet")
					rs2.Open SQL2, REDConnString
					If Err.number <> 0 then
						%>
						<h4 style="color:red;">Error:<span style="font-family:Consolas; font-weight:normal; font-size:12px;"><%=Err.description%></span></h4>
						<%
						Err.number=0
					End If
				End If
				
				
				PN=rs("ItemName")
				
				'SQL1="SELECT PartsID FROM Parts WHERE Description='"&PN&"' OR PartNumber='"&PN&"'"
				'SQL1="SELECT PartsID FROM Parts WHERE Description='"&PN&"'"' OR PartNumber='"&PN&"'"
				SQL1="SELECT PartsID FROM Parts WHERE PartNumber='"&PN&"'"
				%><b>SQL1:</b><%=SQL1%><br/><%
				Response.Flush()
				Set rs1=Server.CreateObject("AdoDB.RecordSet")
				rs1.Open SQL1, REDConnString
				If Err.number <> 0 then
					%><h4 style="color:red;">Error:<pre><%=Err.description%></pre></h4><%
					Err.number=0
				End If
				
				If Not rs1.EOF Then
					SQL2="UPDATE BidItems SET PartID="&rs1("PartsID")&" WHERE BidItemsID="&rs("BidItemsID")
					%><b>SQL2:</b><%=SQL2%><br/><%
					Response.Flush()
					Set rs2=Server.CreateObject("AdoDB.RecordSet")
					rs2.Open SQL2, REDConnString
					If Err.number <> 0 then
						%><h4 style="color:red;">Error:<pre><%=Err.description%></pre></h4><%
						Err.number=0
					End If
				End If
				
				Response.Flush()
				rs.MoveNext
			Loop
	
	
	
	Case Else
		%>
		Script=[Nothing]
		<%
	End Select		
%>
<div>Script:<%=Request.QueryString("Script")%> Executed!</div>
</body>
</html>
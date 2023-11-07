<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../TMC/RED.asp" -->
<html>
<head>
<title>Price list Updater</title>
</head>

<body>
Price List Updater<br/>
<br/>
Here goes...<br/>
<%
'SQL="SELECT PN, Price, Description FROM Vigilant2011"
'% > <br/>SQL:<%=SQL% ><br/> <%
'Set rs=Server.CreateObject("AdoDB.RecordSet")
'rs.Open SQL, REDConnString
'
'Do Until rs.EOF
'	
'	SQL2="SELECT PartsID, PartNumber FROM Parts WHERE PartNumber='"&rs("PN")&"'"
'	% > <br/>SQL2:<%=SQL2% ><br/> <%
'	Set rs2=Server.CreateObject("AdoDB.RecordSet")
'	rs2.Open SQL2, REDConnString
'	
'	If Not rs2.EOF Then
'		'If CLng()<CLng() Then
'			SQL3="UPDATE Parts SET Cost="&rs("Price")&", WHERE PartNumber='"&rs("PN")&"' AND PartsID="&rs2("PartsID")
'			% ><big><big><i>SQL3:<%=SQL3% ></i></big></big><br/> <%
'			Set rs3=Server.CreateObject("AdoDB.RecordSet")
'			'rs3.Open SQL3, REDConnString
'		'End If
'	Else
'		SQL4="INSERT INTO Parts (PartNumber, Cost, Description) VALUES ('"&rs("PN")&"', "&(CLng(rs("Price"))+3)&", ''"&EncodeChars(rs("Description"))&"') "
'		% > <br/><b>SQL4:<%=SQL4% ></b><br/> <%
'		Set rs4=Server.CreateObject("AdoDB.RecordSet")
'		rs4.Open SQL4, REDConnString
'	End If
'	
'	Set rs2=Nothing
'	
'	rs.MoveNext
'Loop
'Set rs=Nothing

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'SQL="SELECT Model, Description, Price FROM Jeron2011"
'% > <br/>SQL:<%=SQL% ><br/> <%
'Set rs=Server.CreateObject("AdoDB.RecordSet")
'rs.Open SQL, REDConnString
'
'Do Until rs.EOF
'
'	SQL4="INSERT INTO Parts (Manufacturer, System, Category1, Model, PartNumber, Cost, Description) VALUES ('Jeron', 'Nurse Call', 'Nurse 'Call', '"&rs("Model")&"', '"&rs("Model")&"', 0"&rs("Price")&", '"&EncodeChars(rs("Description"))&"') "
'	% > <br/><b style=font-family:consolas; >SQL4:<%=SQL4% ></b><br/> <%
'	Set rs4=Server.CreateObject("AdoDB.RecordSet")
'	rs4.Open SQL4, REDConnString
'
'	rs.MoveNext
'Loop
'Set rs=Nothing
%>
</body>
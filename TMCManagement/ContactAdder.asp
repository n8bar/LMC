<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ContactsAdder</title>
<!-- #include file="Common.asp" -->
</head>

<body>

<%

SQL="SELECT Contact2,CPhone2,Email2,ID FROM Contacts WHERE ISNULL(Contact2,'') <> ''"
Set rs=Server.CreateObject("AdoDB.RecordSet")
%><br/>Main SQL:<pre><%=SQL%></pre><br/><%
rs.Open SQL, REDConnString


iteration=-1
Do until rs.EOF
	
	iteration=iteration+2
	isoDate=cstr(Year(date))+right("0"&Month(date),2)+right("0"&Day(date),2)
	seconds=right("00000"&Fix(timer),5)
	cKey=isoDate+seconds+right("0000"&iteration,4)
	
	cPhone2=rs("CPhone2")
	If CPhone2="" OR IsNull(CPhone2) Then CPhone2=0
		
	Values="'"&rs("Contact2")&"',"&Cphone2&",1,'"&rs("Email2")&"','"&cKey&"'"
	addSQL="INSERT INTO Contacts (Name, Phone1, human, email, cKey) VALUES ("&values&")"
	%><br/>Adding: <%=addSQL%><%
	Set addRS=Server.CreateObject("AdoDB.RecordSet")
	addRS.Open addSQL,REDConnString
	
	
	idSQL="SELECT id FROM Contacts WHERE cKey='"&cKey&"'"
	Set idRS=Server.CreateObject("AdoDB.RecordSet")
	idRS.Open idSQL,REDConnString
	addedID=idRS("id")
	set idRS=Nothing
	
	%> &nbsp; added id:<%=addedID%><%
	
	typeSQL="INSERT INTO ContactsType (ContactID,TypeID) VALUES ("&addedID&",1006)"
	%><br/>typing: <%=typeSQL%><%
	Set typeRS=Server.CreateObject("AdoDB.RecordSet")
	typeRS.Open typeSQL,REDConnString
	
	linkSQL="INSERT INTO ContactContacts (MasterID,DetailID,RelationshipId) VALUES ("&addedID&","&rs("ID")&",6)"
	%><br/>linking: <%=linkSQL%><%
	Set linkRS=Server.CreateObject("AdoDB.RecordSet")
	linkRS.Open linkSQL,REDConnString
	
	
	rs.MoveNext
	%><br/><%
Loop


%>


</body>
</html>
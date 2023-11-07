<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Materials</title>
<!--#include file="common.asp" -->
<!-- 
<script type="text/javascript" src="matReq.js?nocache=<%=LoadStamp%>"></script>
<script type="text/javascript" src="matReqAJAX.js?nocache=<%=LoadStamp%>"></script>
-->

<link type="text/css" rel=stylesheet href="Library/CSS_DEFAULTS.css?noCache=<%=LoadStamp%>" media="screen"/>
<link type="text/css" rel=stylesheet href="Library/ListsCommon.css?noCache=<%=LoadStamp%>" media="all"/>
<link type="text/css" rel=stylesheet href="Materials/matReq.css?nocache=<%=LoadStamp%>" media="all"/>
<style>
	h1 { font-family:condensed;}
	
	#statusKey { width:85%; margin-left:7%; text-align:center; border:1px #ddd solid; border-radius:4px; white-space:normal; }
	#statusKey span { white-space:nowrap; }
	
	#left { width:33%; height:100%; overflow-x:hidden; overflow-y:auto; white-space:nowrap;  text-overflow:ellipsis; }
	
	div { overflow:hidden; text-overflow:ellipsis; white-space:nowrap;  }
	
	.debugger { width:100%; float:left; height:12px; color:#777; font-family:Verdana, Geneva, sans-serif; font-size:10px; }
	
	.mrRow { width:100.1%; cursor:pointer; font-family:Consolas; }
	.mrRow:hover {
		background:-moz-linear-gradient(bottom, rgba(224,255,255,.25), /*rgba(0,192,192,.5) 50%,*/ rgba(128,144,144,.25));
		background:-webkit-gradient(linear,0 0,0 100%, from(rgba(224,255,255,.25)) /*,color-stop(.5, rgba(0,192,192,.5))*/, to(rgba(128,144,144,.25)));
	}
	.mrRow span {font-family:Condensed; font-weight:bold; height:20px;}
	
	#vBarC { width:1%; height:100%; float:left; }
	#vBar { width:50%; height:100%; margin:0 auto 0 auto; 
		background:-moz-linear-gradient(right, rgba(128,144,144,1), rgba(224,255,255,1) 25%, rgba(128,144,144,1));
		background:-webkit-gradient(linear,0 0,100% 0, from(rgba(128,144,144,1)) ,color-stop(.25, rgba(224,255,255,1)), to(rgba(128,144,144,1)));
	}
</style>

<%
tab="<small><small><span style=""white-space:pre;"">&#9;</span></small></small>"

mrsJP="<span style=""font-weight:bold; font-family:Consolas; color:#D00;""><big><big><i><b>!</b></i></big></big></span>"
mrsPO="<span style=""font-weight:bold; font-family:Consolas; color:#0A0;"">$</span>"
mrsDone="<span style=""font-weight:bold; font-family:Consolas; color:#0C0;""><big>&radic;</big></span>"
%>
</head>
<body>

<div id=Reload class=tButton32 onClick="sW('JPFrameURL',''); noCacheReload();" title="Reload" style="position:absolute; top:8px; left:28%;" /><img src="../Images/reloadblue24.png" width=100% height=100% /></div>

<div id=left >
<h1> Material Requests</h1>

<div id=statusKey>
	<span><%=mrsJP%>=needs Job Pack</span>
	<span><%=mrsPO%>=needs PO</span>
	<span><%=mrsDone%>=Ready to go</span>
</div>
<%

SQL="SELECT id, Due, Done, ByEmpID, ProjID FROM MaterialRequests WHERE Done=1 AND RequestFilled=0 ORDER BY ProjID"', Due"
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString


Do Until rs.EOF
	
	'If Due<>rs("Due") Then
	'	Due=rs("Due")
	'	% ><h4 > &nbsp; &nbsp; Due: <%=Due% > &nbsp; &nbsp; </h4><%
	'End If
	
	If ProjID<>rs("ProjID") Then		
		
		ProjID=rs("ProjID")
		SQL1="SELECT ProjName+' - '+ProjCity+', '+ProjState AS Proj FROM Projects WHERE ProjID="&ProjID
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		
		If rs1.EOF Then
			Project="Serious Error: Project # "&ProjID&" Is missing from the database"
		Else
			Project=DecodeChars(rs1("Proj"))
		End If
		%><div class="w100p fL tdU mT12"><span style="margin-bottom:0; text-decoration:underline;"><%=Project%></span></div><%
	End If	

	EmpID=rs("ByEmpID")
	SQL2="SELECT FName+' '+LName AS Employee FROM Employees WHERE EmpID="&rs("ByEmpID")
	Set rs2=Server.CreateObject("AdoDB.RecordSet")
	rs2.Open SQL2, REDConnString
	
	If rs2.EOF Then
		ByEmp="Serious Error: Employee # "&EmpID&" Is missing from the database"
	Else
		ByEmp=rs2("Employee")
	End If
	
	
	mrStatus=mrsJP
	
	mriSQL="SELECT JobPackID, PartsID FROM matReqItems WHERE mRID="&rs("ID")&" AND Needed=1 ORDER BY PartsID"
	Set mrItems=server.CreateObject("AdoDB.RecordSet")
	mrItems.Open mriSQL, REDConnString	
	IsDone=True
	needsPO=False
	neededQty=-1 : totalNQ=0
	If not mrItems.EOF Then oldPartsID=mrItems("PartsID")
	rIndex=1
	Do Until mrItems.EOF
		hasJP= NOT (mrItems("JobPackID")=0)
		IsDone=IsDone AND hasJP
		
		if NOT hasJP Then neededQty=neededQty+1
		
		%><%'="<span class=debugger style=""width:auto; color:#ccc;""><b>hasJP:</b>"&(hasJP)&"</span>"&tab%><%
		If oldPartsID <> mrItems("PartsID") Then
			rIndex=rIndex+1
			
			invSQL="SELECT Inventory, PartNumber FROM Parts WHERE PartsID="&oldPartsID
			Set iRS=Server.CreateObject("AdoDB.RecordSet")
			iRS.Open invSQL, REDConnString
			If iRS.EOF Then Inventory=0 Else Inventory=iRS("Inventory")
			If neededQty<0 Then neededQty=0
			PO=Inventory<neededQty
			needsPO=needsPO OR PO
			oldPartsID=mrItems("PartsID")
			
			%><%'="<span class=debugger><b>√:</b>"&(IsDone)&tab&tab&"  <b>i:</b>"&(Inventory&"  <b>nQ:</b>"&neededQty)&tab&"  <b>PO:</b>"&(PO)&"<b>PN:</b>"&iRS("PartNumber")&tab&"</span>"%><%
			
			totalNQ=totalNQ+neededQty
			neededQty=-1'rIndex
		End If
		
		mrItems.MoveNext
	Loop
	
	opacity=1
	If IsDone Then 
		mrStatus=mrsDone
		opacity=.5
	End If
	If needsPO Then mrStatus=mrsPO
	
	%>
	<div class="mrRow" onClick="Gebi('right').src='JobPack.asp?noCache=<%=SessionID&Timer%>&id=<%=rs("id")%>';">
		<%=mrStatus)'&tab&totalNQ&tab&(needsPO)&tab%>&nbsp;
		<span style="opacity:0<%=opacity%>;">
			<span>MR#</span><%=rs("id")&tab%>
			<span>By:</span><%=ByEmp&tab%>
		</span>
	</div>
	<%
	
	
	rs.MoveNext
Loop

%>
<br/>
<h1><hr style="visibility:hidden;"/>Job Packs</h1>
<%

SQL3="SELECT id, Shelf, ShipToAttn, ShipToAddress, ShipToCity, ShipToState, ProjID FROM JobPacks WHERE Shipped<>1 ORDER BY Shelf"
Set rs3=Server.CreateObject("AdoDB.RecordSet")
rs3.Open SQL3, REDConnString

If Not rs3.EOF Then
	ProjID=rs3("ProjID")
	SQL4="SELECT ProjName+' - '+ProjCity+', '+ProjState AS Proj FROM Projects WHERE ProjID="&ProjID
	Set rs4=Server.CreateObject("AdoDB.RecordSet")
	rs4.Open SQL4, REDConnString
	
	If rs4.EOF Then
		Project="Serious Error: Project # "&ProjID&" Is missing from the database.  This could be a result of someone deleting an activated project."
	Else
		Project=DecodeChars(rs4("Proj"))
	End If
End If

Do Until rs3.EOF

	ProjID=rs3("ProjID") %><script>var projId=0<%=ProjID%>;</script><%
	SQL4="SELECT ProjName+' - '+ProjCity+', '+ProjState AS Proj FROM Projects WHERE ProjID="&ProjID
	Set rs4=Server.CreateObject("AdoDB.RecordSet")
	rs4.Open SQL4, REDConnString
	If rs4.EOF Then
		Project="Serious Error: Project # "&ProjID&" Is missing from the database"
	Else
		Project=dcF(rs4,"Proj")
	End If
	%>
	<div class="mrRow" style="margin-bottom:20px;" onClick="Gebi('right').src='JobPack.asp?noCache=<%=SessionID&Timer%>&jp=<%=rs3("id")%>';">
		<span style="font-weight:normal;"><big><%=Project%></big></span>
		<br/>
		<span>JobPack#</span><%=rs3("id")&tab%>
		<span>Shelf: </span><%=dcF(rs3,"Shelf")&tab%>
		<!-- <span>Send To: </span><%=dcF(rs3,"ShipToAttn")&" "&dcF(rs3,"ShipToAddress")&", "&dcF(rs3,"ShipToCity")&", "&dcF(rs3,"ShipToState")&", "&dcF(rs3,"ShipToAttn")&tab%> -->
	</div>
	<%
	rs3.MoveNext
Loop

If session("JPFrameURL")="" Then session("JPFrameURL")="JobPack.asp?noCache="&LoadStamp

%>
</div>
<div id=vBarC><div id=vBar ></div></div>
<iframe id=right class="w65p h100p fL" frameborder="0" src="<%=DecodeChars(session("JPFrameURL"))%>"></iframe>
	

</body>
</html>
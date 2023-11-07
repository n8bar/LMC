<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="common.asp" -->

<script type="text/javascript" src="../tmcManagement/CommonAJAX.js"></script>
<script type="text/javascript" src="../tmcManagement/rcstri.js"></script>
<style>
	html{ margin:0 0 0 0; width:100%; height:100%; overflow:hidden; background:#B4DAF5; text-align:center; font-size:24px; }
	body{ margin:0 0 0 0; width:100%; height:100%; overflow:auto; /*background:#E6F3FB; */
		background:-moz-linear-gradient(top, rgba(0,120,192,.375), /*rgba(0,120,192,.25) 50%*/, rgba(0,108,172,.25));
		background:-webkit-gradient(linear,0 100%,0 0, from(rgba(0,120,192,.375)) /*,color-stop(.5,  rgba(0,120,192,.25))*/, to(rgba(0,108,172,.25)));
	}
	a { width:100%; height:48px; display:block; float:left; border-radius:2px; margin:0; font-size:36px; line-height:48px; text-decoration:none; color:white; opacity:.75;  
		font-family: "Arial Narrow", "Agency FB", "Swis721 LtCn BT"; font-weight:bold;
	}
	.projRow { background:none; width:100%; float:left; margin-top:12px; overflow:hidden; }
	.mrRow { float:left; width:100%;
		background:-moz-linear-gradient(top, rgba(0,120,192,.5), /*rgba(0,120,192,.75) 50%*/, rgba(0,108,172,1));
		background:-webkit-gradient(linear,0 100%,0 0, from(rgba(0,120,192,.5)) /*,color-stop(.5,  rgba(0,120,192,.75))*/, to(rgba(0,108,172,1)));
	}
</style>
</head>
<html>
<body>
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
		%><div class="projRow"><span style="margin-bottom:0; text-decoration:underline;"><%=Project%></span></div><%
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
			
			%><%'="<span class=debugger><b>v:</b>"&(IsDone)&tab&tab&"  <b>i:</b>"&(Inventory&"  <b>nQ:</b>"&neededQty)&tab&"  <b>PO:</b>"&(PO)&"<b>PN:</b>"&iRS("PartNumber")&tab&"</span>"%><%
			
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
	<div class="mrRow" onClick="window.location='../tmcManagement/JobPack.asp?noCache=<%=SessionID&Timer%>&id=<%=rs("id")%>';">
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
</body>
</html>
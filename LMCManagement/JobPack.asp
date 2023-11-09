<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Materials</title>
<!--#include file="Common.asp" -->
<!-- 
<script type="text/javascript" src="matReq.js?nocache=<%=LoadStamp%>"></script>
<script type="text/javascript" src="matReqAJAX.js?nocache=<%=LoadStamp%>"></script>
-->

<link type="text/css" rel=stylesheet href="Library/CSS_DEFAULTS.css?noCache=<%=LoadStamp%>" media="screen"/>
<link type="text/css" rel=stylesheet href="Library/ListsCommon.css?noCache=<%=LoadStamp%>" media="all"/>
<link type="text/css" rel=stylesheet href="Materials/matReq.css?nocache=<%=LoadStamp%>" media="all"/>

<style>
body {overflow-x:hidden; overflow-y:auto; min-height:0px; }

.ItemsHead div:first-child{ border-left:none; }
.ItemsHead div:last-child{ border-right:none; }

.row { margin-bottom:3px; margin-top:0; float:left; height:29px; border:1px #ccc solid; border-bottom-color:#aaa; overflow:hidden; }
.row div { line-height:12px;  }
.row div small { line-height:27px; }
.row input {float:left; background:rgba(255,255,255,.5); border:1px #888 solid; border-radius:3px; }
.row input[readonly] { border-color:rgba(255,255,255,0); }
/*#row0 {opacity:.1;}*/

#top{ position:absolute; top:0px; height:112px; width:100%; float:left; z-index:10;
 background:-moz-linear-gradient(top, rgba(255,255,255,1), rgba(255,255,255,1) 50%,*/ rgba(255,255,255,.25));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(255,255,255,1)) ,color-stop(.5, rgba(255,255,255,1)), to(rgba(255,255,255,.25)));
}
.MRTitle { background:none; border:none; z-index:100; font-size:14px; height:20px; }
.MRTitle span {font-family:Condensed; font-weight:bold;}
#nothingRow { background:none; border:none; opacity:0; height:112px; }

.editBtn { width:5%; background: url(../images/Pencil-gray16.png) center no-repeat; border-radius:8px; }
	.editBtn:hover { border-width:1px; border-style:outset; background: url(../images/Pencil-icon16.png) center no-repeat; }
	.editBtn:active { border-width:1px; border-style:inset; background: url(../images/Pencil-icon16-bold.png) center no-repeat; }
.saveBtn { width:5%; background: url(../images/save_16.png) center no-repeat; border-radius:8px; }
	.saveBtn:hover { border-width:1px; border-style:outset; }
	.saveBtn:active { border-width:1px; border-style:inset; }

#choose	{ position:absolute; top:85%; font-size:36px; color:#0ff; font-family:Condensed; text-shadow:#000 0 0 3px,#000 0 0 3px,#000 0 0 3px,#000 0 0 3px,#000 0 0 3px,#000 0 0 3px; }

.jpiStatus { width:5%; text-align:center; padding:0; }
</style>

<script type="text/ecmascript" src="Materials/JobPack.js?nocache=<%=LoadStamp%>"></script>
<script type="text/ecmascript">
	var noCache=<%=SessionID&Date&Timer%>;

</script>

<%
mrid=Request.QueryString("ID")
jpid=Request.QueryString("jp")

Project="<i><small>Choose a Material Request on Left</small></i>"'"<big style=""color:#0FF; text-shadow:#000 0 0 5px,#000 0 0 5px,#000 0 0 5px,#000 0 0 5px;"">Please choose a Material Request on the left.</big>"

If mrid<>"" Then
	SQL="SELECT ByEmpID,ProjID,Date,Due,ShipToAttn,ShipToName,ShipToAddress,ShipToCity,ShipToState,ShipToZip,notes FROM MaterialRequests WHERE id="&mrid
	SET rs=Nothing
	SQL="SELECT ByEmpID,ProjID,Date,Due,ShipToAttn,ShipToName,ShipToAddress,ShipToCity,ShipToState,ShipToZip,notes FROM MaterialRequests WHERE id="&mrid
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.Open SQL, REDConnString
	
	d8=rs("Date")
	Due=rs("Due")
	
	ProjID=rs("ProjID") %><script>var projId=0<%=ProjID%>;</script><%
	SQL1="SELECT ProjName+' - '+ProjCity+', '+ProjState AS Proj FROM Projects WHERE ProjID="&ProjID
	Set rs1=Server.CreateObject("AdoDB.RecordSet")
	rs1.Open SQL1, REDConnString
	If rs1.EOF Then
		Project="Serious Error: Project # "&ProjID&" Is missing from the database"
	Else
		Project=DecodeChars(rs1("Proj"))
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

Else
	If jpid<>"" Then
		SQL="SELECT Shelf, ShipToAttn, ShipToAddress, ShipToCity, ShipToState, ProjID, Shipped FROM JobPacks WHERE id="&jpid
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString

		ProjID=rs("ProjID") %><script>var projId=0<%=ProjID%>;</script><%
		SQL1="SELECT ProjName+' - '+ProjCity+', '+ProjState AS Proj FROM Projects WHERE ProjID="&ProjID
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		If rs1.EOF Then
			Project="Serious Error: Project # "&ProjID&" Is missing from the database"
		Else
			Project=dcF(rs1,"Proj")
		End If
		
		If rs.EOF Then
			%>There are no parts in this job pack yet.  Add some by using a Material Request.<%
			response.end()
		End If
		
		jpStatus="not Sent"
		If rs("Shipped") = "True" Then jpStatus="<i><big>Sent</big></i>"

		%>
		<script>var jpId=0<%=jpid%>;</script>
		</head>
		<body >
		<div id=Reload class=tButton24 onClick="noCacheReload();" title="Reload" style="position:absolute; top:8px; right:24px; z-index:20;" /><img src="../Images/reloadblue24.png" width=100% height=100% /></div>
		<div class="row h48" id=nothingRow ></div>
		<div id=top class="w97p h48">
			<div class="row MRTitle" >
				<span>For: </span><big><%=Project%></big><%'=dcF(rs,"Shelf")&%><%=tab&tab%>
			</div>
			<div class="row MRTitle w93p h24" style="" >
				<span>Job Pack#</span><%=jpid%>&nbsp; &nbsp; &nbsp; &nbsp;
				<span>Status:</span><%=jpStatus&tab&tab%><%=indent%>
				<span class="fR" style="position:relative; top:-3px;">
					<span><%=indent%>Shelf:</span><%=dcF(rs,"Shelf")&tab&tab%>
				<!-- 
					<span class="tButton0x24" style="line-height:24px; overflow:hidden; margin-right:16px; width:auto;" onClick="sendJP();">&nbsp;Send&nbsp;<img class="fR h40" style="position:relative; top:-10px;" src="../images/ServiceVan48.png"/></span>< %=indent%>
				-->
				</span>
			</div>
		</div>
		<div id=jpItemsHead class="ItemsHead">
			<div class="w25p" >Manufacturer</div>
			<div class="w28p">Part Number</div>
			<div class="w23p lH12"><small>Inventory Quantity</small></div>
			<div class="w23p lH12"><small>Job Pack Quantity</small></div>
		</div>
		
		<div class="row taC" id=row-1 style="background:transparent; font-size:22px; line-height:22px; border:none; color:#abb;"><big><big><b>←</b></big></big>Add parts and adjust quantities using a Material Request.</div>
		<%
		
		SQL2="SELECT ID,Mfr,PartNo,Description,unitSize,Cost,PartsID,MRID FROM MatReqItems WHERE JobPackID="&jpid&" ORDER BY PartsID, MRID"
		%><%'=SQL2%><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.Open SQL2, REDConnString
		r=0 :	PartsID=-1
		
		Dim PartsID, Mfr, PN, iQty, iLevel, inventoryStatus, pLevel, pColor
		Sub loadJPIRecord()
			PartsID=rs2("PartsID")
			Mfr=dcF(rs2,"Mfr")
			PN=dcF(rs2,"PartNo")
			
			partsSQL="SELECT Inventory,InventoryLevel FROM Parts WHERE PartsID="&rs2("PartsID")
			Set partsRS=Server.CreateObject("AdoDB.RecordSet")
			partsRS.Open partsSQL, REDConnString
			iQty=cSng("0"&partsRS("Inventory"))
			iLevel=cint("0"&partsRS("InventoryLevel"))
			if iLevel>0 Then 
				pLevel=(cInt(iQty/iLevel)*10000)/100
				inventoryStatus=pLevel&"% of Maintenance Level:"&iLevel 
			Else 
				inventoryStatus=iQty
				pLevel=0
			End If
			If pLevel>100 Then pColor="#0C0" Else pColor="#0FF"
		End Sub
		
		If Not rs2.EOF Then
			loadJPIRecord()
		End If
		Do Until rs2.EOF
			
			If PartsID=rs2("PartsID") Then
				jpQty=jpQty+1
			Else
				r=r+1
				%>
				<div class=row id=row<%=r%> >
					<input id=PartsID<%=r%> type="hidden" value="<%=PartsID%>" />
					<div class="w25p"><%=Mfr%></div>
					<div class="w28p"><%=PN%></div>
					<div class="w23p lH12 taR ffConsolas" style="<%=iSty%>" title="<%=inventoryStatus%>">
						<small id=iQty<%=r%>><%=iQty%></small>
						<div class="w100p h3" style="border:1px #888 solid; border-radius:2px; position:relative; top:-5px; background:#000;" ><div style="background:<%=pColor%>; width:<%=pLevel%>%; height:100%;">&nbsp;</div></div>
					</div>
					<!--
					<div class="w10p p0 taC" >
						< %if jpQty > 0 Then %> <button class=tButton0x24 style="float:none;" onClick="movePartInventory(< %=r%>);"><img height=20 src="../images/GreenLeftTriangle.png"/></button> < %End IF%>
						< %if iQty > 0 Then %> <button class=tButton0x24 style="float:none;" onClick="movePartJobPack(< %=r%>);"><img height=20 src="../images/GreenRightTriangle.png"/></button> < %End IF%>
					</div>
					-->
					<div class="w23p h100p ffConsolas">
						<input id=jpQty<%=r%> class="w100p h100p taR " value="<%=jpQty%>" onkeypress="onlyAccept(event,'0123456789.',this); " readonly />
					</div>
					<!-- div id=edit<%=r%> class="editBtn" style="height:24px; text-align:center; float:right;" onclick="mrId=0<%=rs2("MRID")%>;eRow(<%=r%>);" >&nbsp;</div -->
				</div>
				<%
				jpQty=0
				loadJPIRecord()
			End If
			response.Flush()
			rs2.MoveNext
		Loop
		%>
		</body>
		</html>
		<%
		Response.End()
	End If
End If

tab="<small><small><span style=""white-space:pre;"">&#9;</span></small></small>"
indent="<small><small><span style=""white-space:pre;""> &nbsp; &nbsp; &nbsp; </span></small></small>"
%>
</head>
<body onLoad="resize(); //alert(window.location)" onResize="resize();" onclick="try{clearTimeout(timer);} catch(e){}">

<div id=Reload class=tButton24 onClick="noCacheReload();" title="Reload" style="position:absolute; top:8px; right:24px; z-index:20;" /><img src="../Images/reloadblue24.png" width=100% height=100% /></div>

<div class="row" id=nothingRow ></div>
<div id=top>
		
	<div class="row MRTitle" style="" >
		<div><span>MR#</span><%=mrid&tab&tab%></div>
		<div><span>Submitted on:</span><%=d8&tab&tab%></div>
		<div><span>Due by:</span><%=Due%></div>
	</div>
	<div class="row MRTitle" style="z-index:0;" >
		<div style="text-shadow:#0CC 0 0 5px"><span>For:</span><%=Project&tab%></div>
		<div><span>Requested by:</span><%=ByEmp%></div>
	</div>
<%
If mrid="" AND jpid="" Then 
	%>
	</div>
	<div id=choose><big><big>←</big></big>Choose a Material Request or Job Pack.<span id=distanceMeter style="display:none;"</span></div>
	<script>
	var interval=25;
	var timer=setTimeout("animateChoose();",interval);
	var dir=-2; var oT;//=Gebi('choose').offsetTop;
	function animateChoose() {
		var H=document.body.offsetHeight;
		oT=Gebi('choose').offsetTop;
		var distance=oT/100; if (distance<1) distance=1; distanceMeter.innerHTML=distance+':'+interval;
		Gebi('choose').style.top=oT+dir/*(dir*distance)*/+('px');
		interval=(H-oT)/25;
		timer=setTimeout("animateChoose();",interval);
		if (dir>0) { if (oT>=H-48) dir=-dir; }
		else { if(oT<=96) dir=-dir; }
	}
	</script>
	</body>
	</html>
	<%
	Response.End()
End If

%>
<!--#include file="Materials/jobPackMR.asp" -->

</body>
</html>
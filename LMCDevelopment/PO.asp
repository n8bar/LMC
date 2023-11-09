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
IsBlank=False
If mrid<>"" Then
	SQL="SELECT ByEmpID,ProjID,Date,Due,ShipToAttn,ShipToName,ShipToAddress,ShipToCity,ShipToState,ShipToZip,notes FROM MaterialRequests WHERE id="&mrid
	SET rs=Nothing
	SQL="SELECT ByEmpID,ProjID,Date,Due,ShipToAttn,ShipToName,ShipToAddress,ShipToCity,ShipToState,ShipToZip,notes FROM MaterialRequests WHERE id="&mrid
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.Open SQL, REDConnString
	
	d8=rs("Date")
	Due=rs("Due")
	
	ProjID=rs("ProjID") %><script>var projId=0<%=ProjID%>;</script><%
	SQL1="SELECT ProjName+' - '+ProjCity+', '+ProjState AS Proj, ProjState, ProjName FROM Projects WHERE ProjID="&ProjID
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
		<%
	Else
		IsBlank=True
		%><span>Please Choose a Material Request or PO on left.</span><%
		Response.End()
	End If
End If

Set rs3=Nothing
SQL3="SELECT ID,ShipToName,ShipToAttn,ShipToAddress,ShipToCity,ShipToState,ShipToZip,notes FROM JobPacks WHERE ProjID="&ProjID&" AND Shipped=0"' ORDER BY Shipped, DateShipped DESC"
%><%'=SQL3&"<br/>"%><%
Set rs3=Server.CreateObject("AdoDB.RecordSet")
rs3.open SQL3, REDConnString

If rs3.EOF Then
	%>
	</div>
	<center>
		<i>No Job Pack is associated with this Material Request.</i><br>
		<button disabled>Skip</button>
	</center>
	</body>
	</html>
	<%
	Response.End()
End If

JPID=rs3("ID")
ShipToName=dcF(rs3,"ShipToName")
ShipToAttn=dcF(rs3,"ShipToAttn")
ShipToAddress=dcF(rs3,"ShipToAddress")
ShipToCity=dcF(rs3,"ShipToCity")
ShipToState=dcF(rs3,"ShipToState")
ShipToZip=dcF(rs3,"ShipToZip")
jpNotes=dcF(rs3,"notes")
%>
	<div id=jpInfo style="display:none;">
		<div id=shipToName ><%=shipToName%></div>
		<div id=shipToAttn ><%=ShipToAttn%></div>
		<div id=shipToAddress ><%=ShipToAddress%></div>
		<div id=shipToCity ><%=ShipToCity%></div>
		<div id=shipToState ><%=ShipToState%></div>
		<div id=shipToZip ><%=ShipToZip%></div>
		<div id=jpNotes ><%=jpNotes%></div>
	</div>
	
	<div class="row MRTitle h24" style="top:48px;" >
		<div><span>Job Pack#</span><%=JPID&tab&tab%></div>
		<div><span>Ship To:</span><%=ShipToName&", "&ShipToAttn&", "&ShipToAddress&", "&ShipToCity&", "&ShipToState&" "&ShipToZip%></div>
		<!-- span class="fR" style="position:relative; top:-3px;">
			<span class="tButton0x24" style="line-height:24px; overflow:hidden; margin-right:16px; width:auto;" onClick="sendJP();">&nbsp;Send&nbsp;<img class="fR h40" style="position:relative; top:-10px;" src="../images/ServiceVan48.png"/></span>< %=indent%>
		</span -->
	</div>
	
	<!--
	<div id=jpItemsHead class="ItemsHead">
		<div class="w20p" >Manufacturer</div>
		<div class="w21p">Part Number</div>
		<div class="w11p lH12"><small>Inventory Quantity</small></div>
		<div class="w5p p0" ><button class=tButton0x24 style="float:none;" onClick="movePart(0)"><img height=20 src="../images/CyanDblRight24.png"/></button></div>
		<div class="w16p lH12"><small>Job Pack Quantity</small></div>
		<div class="w11p lH12"><small>Still Needed Quantity</small></div>
		<div class="w11p lH12"><small>Sent Qty <br/> (this M.R.)</small></div>
		<div class="w4p ffConsolas lH24 fS18 fwB" style="color:#0f0; text-shadow:#040 0 2px 1px,#400 1px 0 1px,#400 0 -1px 1px,#400 -1px 0 1px;" ><i>√</i></div>
	</div>
	-->
	
</div>
<br/>
<script>
	var jpId=<%=JPID%>;
	var mrId=<%=mrid%>;
</script>
	
<%	


nQty=0
sQty=0
jpQty=0

check="<img height=""24"" src=""../images/check_64.png"">"
canDo="<span style=""color:#f00; font-family:consolas; font-size:32px; position:relative; top:6px;""><b>←</b></span>"
cheese="<img height=""24"" src=""../images/check_64-bold.png"">"
'need2order="<img height=24 src=""../images/po.png""/>"
need2order="<div class=""w100p ffConsolas lH24 fS18"" style=""color:#0d0; text-shadow:#040 0 2px 1px,#400 1px 0 1px,#400 0 -1px 1px,#400 -1px 0 1px;"" >$</div>"
%>
<script>
	var jpiStatus=new Object;
	jpiStatus.check='<%=check%>';
	jpiStatus.canDo='<%=cando%>';
	jpiStatus.cheese='<%=cheese%>';
	jpiStatus.need2order='<%=need2order%>';
</script>
<div id=check style="display:none;" ><%=check%></div>
<div id=canDo style="display:none;" ><%=canDo%></div>
<div id=cheese style="display:none;" ><%=cheese%></div>
<div id=need2order style="display:none;" ><%=need2order%></div>
<%

SQL4="SELECT ID,Mfr,PartNo,Description,unitSize,Cost,JobPackID,PartsID,needed FROM MatReqItems WHERE mrId="&mrid&" ORDER BY PartsID, jobPackID"
Set rs4=Server.CreateObject("AdoDB.RecordSet")
rs4.Open SQL4,REDConnString
Dim rMfr(1024)
Dim rPN(1024)
Dim rDesc(1024)
Dim rUnitSize(1024)
Dim rCost(1024)
Dim rPartsID(1024)
Dim rIDList(1024)
Dim rJpList(1024)
Dim rNeededList(1024)
Dim Qty(1024)
Dim invQty(1024)
Dim invLevel(1024)
Dim JPackQty(1024)
Dim needQty(1024)
Dim sentQty(1024)
rI=-1
TotalCost=0
Do Until rs4.EOF
	If previousPartsID=rs4("PartsID") Then
		rIdList(rI)=rIdList(rI)&","&rs4("ID")
		rJpList(rI)=rJpList(rI)&","&rs4("JobPackID")
		rNeededList(rI)=rNeededList(rI)&","&rs4("needed")
		Qty(rI)=Qty(rI)+1
	Else
		rI=rI+1
		rMfr(rI)=dcF(rs4,"Mfr")
		rPN(rI)=dcF(rs4,"PartNo")
		rDesc(rI)=dcF(rs4,"Description")
		rUnitSize(rI)=dcF(rs4,"unitSize")
		rCost(rI)=rs4("Cost")
		rPartsID(rI)=rs4("PartsID")
		Qty(rI)=1
		JPackQty(rI)=0
		sentQty(rI)=0
		needQty(rI)=0
		SQL5="SELECT Inventory,InventoryLevel FROM Parts WHERE PartsID="&rs4("PartsID")
		Set rs5=Server.CreateObject("AdoDB.RecordSet")
		rs5.Open SQL5, REDConnString
		invQty(rI)=cSng("0"&rs5("Inventory"))
		invLevel(rI)=cSng("0"&rs5("InventoryLevel"))
		rIdList(rI)=rs4("ID")
		rJpList(rI)=rs4("JobPackID")
		rNeededList(rI)=rs4("needed")
	End If
	TotalCost=TotalCost+rs4("Cost")
	If rs4("needed")="True" Then
		needQty(rI)=needQty(rI)+1
	End If
	
	If rs4("JobPackID")=jpid Then
		JPackQty(rI)=JPackQty(rI)+1
	Else
		If rs4("JobPackID") > 0 Then sentQty(rI)=sentQty(rI)+1
	End If
	
	previousPartsID=rs4("PartsID")	
	
	rs4.MoveNext
Loop

rCount=rI+1
PO=rs1("ProjState")&(ProjID-80000)&"-"&mrID
path="C:\Inetpub\wwwroot\csv\"
fileName=PO&".csv"
%>
<h3>For now all we have is a <a href="../csv/<%=fileName%>">csv file</a> that can be uploaded to the Edwards ordering site. <br/> So just hang tight.  'till we get the real PO's going!<br/><br/>This order is about <%=formatCurrency(TotalCost)%></h3>
<%
'% >Qty,Cat No<br/><%
Set shell=CreateObject("WScript.Shell")
shell.run "C:\Inetpub\wwwroot\cmd.exe /c ""del "&path&fileName&""""
shell.run "C:\Inetpub\wwwroot\cmd.exe /c ""echo Qty,Cat No  >> "&path&fileName&""""

For r=0 To rI

	if invLevel(r)>0 Then 
		pLevel=cInt((invQty(r)/invLevel(r))*100)
		inventoryStatus=pLevel&"% of Maintenance Level:"&invLevel(r)
	Else 
		inventoryStatus=invQty(r)
		pLevel=0
	End If
	If pLevel>100 Then pColor="#0C0" Else pColor="#0FF"

	itemStatus=canDo
	If needQty(r)=jPackQty(r) Then	itemStatus=check
	If needQty(r)<jPackQty(r) Then	itemStatus=cheese
	If needQty(r)>jPackQty(r) AND invQty(r)<(needQty(r)-jPackQty(r)) Then	itemStatus=need2order
	%>
	<%'=needQty(r)% >,<%=rPN(r)% ><br/%>
	
	<% 	
	shell.run "C:\Inetpub\wwwroot\cmd.exe /c ""echo "&needQty(r)&","""&rPN(r)&"""  >> "&path&fileName&"""" 
	%>
	<!-- 
	<div class=row id=row<%=r%> >
		<input id=PartsID<%=r%> type="hidden" value="<%=rPartsID(r)%>" />
		<input id=mriIdList<%=r%> type="hidden" value="<%=rIdList(r)%>" />
		<div class="w20p"><%=rMfr(r)%></div>
		<div id=PN<%=r%> class="w21p"><%=rPN(r)%></div>
		<div class="w11p lH12 taR ffConsolas" style="<%=iSty%>" title="<%=inventoryStatus%>">
			<small id=iQty<%=r%>><%=invQty(r)%></small>
			<div class="w100p h3" style="border:1px #888 solid; border-radius:2px; position:relative; top:-5px; background:#000; z-index:0;" >
				<div style="background:<%=pColor%>; width:<%=pLevel%>%; height:100%;">&nbsp;</div>
			</div>
		</div>
		<div class="w5p p0 taC" ><%if invQty(r) > 0 Then %> <button class=tButton0x24 style="float:none;" onClick="movePart(<%=r%>);"><img height=20 src="../images/CyanDblRight24.png"/></button> <%End IF%></div>
		<div class="w11p h100p ffConsolas">
			<input id=jpQty<%=r%> class="w100p h100p taR " value="<%=jPackQty(r)%>" onkeypress="onlyAccept(event,'0123456789.',this); " readonly />
		</div>
		<div id=edit<%=r%> class="editBtn" style="height:24px; text-align:center;" onclick="eRow(<%=r%>);" >&nbsp;</div>
		<% stillNeededQty=needQty(r)-jPackQty(r) %>
		<div class="w11p lH12 taR ffConsolas"><small id=nQty<%=r%> ><%=stillNeededQty%></small></div>
		<div class="w11p lH12 taR ffConsolas"><small id=sQty<%=r%> ><%=sentQty(r)%></small></div>
		<div class=jpiStatus id=status<%=r%> ><%=itemStatus%></div>
	</div>
	-->
	<%
Next

Subject=Server.URLEncode("Fire Alarm Order "&PO)
attachment=Server.URLEncode("\\tmc.tricom.sc\wwwroot\"&filename)
emailBody=Server.URLEncode("Cory,")
emailBody=emailBody&"%0D"&Server.URLEncode("I need a Fire Alarm order entered at https://myeddie.edwardsutcfs.com/.")
emailBody=emailBody&"%0D"&Server.URLEncode("Username: 187944")
emailBody=emailBody&"%0D"&Server.URLEncode("Password: 7@Zionian")&"%0D"
emailBody=emailBody&"%0D"&Server.URLEncode("Job Name: "&Project)
emailBody=emailBody&"%0D"&Server.URLEncode("PO#: "&PO)
emailBody=emailBody&"%0D"&Server.URLEncode("Shipping: Best Way")
emailBody=emailBody&"%0D"&Server.URLEncode("Ship To: "&ShipToName&", ATTN: "&ShipToAttn&", "&ShipToAddress&", "&ShipToCity&" "&ShipToState&" "&ShipToZip)
emailBody=emailBody&"%0D"&Server.URLEncode("Ship Complete: NO")
emailBody=emailBody&"%0D"&Server.URLEncode("Discount Code: ")
emailBody=emailBody&"%0D"&Server.URLEncode("Parts List: Upload attached csv file.")
emailBody=emailBody&"%0D"&"%0D"&Server.URLEncode("Thanks!")
link="mailto:cory@dpbsllc.com?subject="&Subject&"&body="&emailBody'&"&attach="&attachment
link=Replace(link,"+","%20")
%>

<a href="<%=link%>">eMail Cory</a>. Don't forget to attach the CSV file.

</body>
</html>
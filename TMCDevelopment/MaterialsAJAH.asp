
<!--#include file="../LMC/RED.asp" -->
<%
Response.ContentType = "text/xml"
Response.Buffer="false"
sAction = CStr(Request.QueryString("action"))

%>
<html>
<head>
	<title><%=sAction%></title>
	<link type="text/css" rel=stylesheet href="Library/CSS_DEFAULTS.css" media="screen"/>
	<!-- link type="text/css" rel=stylesheet href="ListsCommon.css" media="all"/>
	<link type="text/css" rel=stylesheet href="Materials.css" media="all"/ -->
	<link type="text/css" rel=stylesheet href="Library/dhtmlgoodies_calendar.css?random=20051112" media=all />
	<style media="all">
		html{ height:100%; width:100%; margin:0 0 20px 0; overflow:hidden;}
		body{ height:100%; width:100%; margin:0 0 20px 0; overflow:hidden; padding:0 2.5% 0 2.5%;}
	
		#left,#right {float:left; width:47%; height:100%; overflow:auto; }
		.ItemsHead { width:95%; height:32px; float:left; overflow:hidden; white-space:nowrap; border:1px solid #066; margin:0 2.5% 0 0; min-width:0;
		border-radius:3px; border-top-left-radius:8px; border-top-right-radius:8px;
		background:-moz-linear-gradient(top, rgba(192, 255, 255, .75), /*rgba(0, 192, 192, .5) 50%,*/ rgba(96, 128, 128, .75));
		background:-webkit-gradient(linear,0 0,0 100%, from(rgba(192, 255, 255, .75)) /*,color-stop(.5, rgba(0, 192, 192, .5))*/, to(rgba(96, 128, 128, .75)));
		}
		.ItemsHead div { float:left; display:block; text-align:center; padding:2px 0; overflow:hidden; white-space:nowrap; text-overflow:ellipsis; }
		.row {width:95%; height:48px; float:left; overflow:hidden; white-space:nowrap; border:1px solid #099; margin:8px 0 0 0; min-width:0; border-radius:3px;
		background:-moz-linear-gradient(top, rgba(224, 255, 255, .25), /*rgba(0, 192, 192, .5) 50%,*/ rgba(128, 144, 144, .25));
		background:-webkit-gradient(linear,0 0,0 100%, from(rgba(224, 255, 255, .25)) /*,color-stop(.5, rgba(0, 192, 192, .5))*/, to(rgba(128, 144, 144, .25)));
		}
		.row div {float:left; height:28px; line-height:28px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis; margin:0; padding:0; }
		.rowBottom {width:100%; height:20px !important; line-height:20px !important; font-size:14px; font-family:"Swis721 LtCn BT", "Arial Narrow", Narrow;
		background:-moz-linear-gradient(top, rgba(224, 224, 224, .25), /*rgba(0, 192, 192, .5) 50%,*/ rgba(128, 128, 128, .25));
		background:-webkit-gradient(linear,0 0,0 100%, from(rgba(224, 224, 224, .25)) /*,color-stop(.5, rgba(0, 192, 192, .5))*/, to(rgba(128, 128, 128, .25)));
		}
		#newMR label{color:#088; }
		.wsnw {white-space:nowrap;}
		#cal {cursor:pointer; width:24px; height:24px; float:left; background-image:url(../Images/Cal24x24.gif);}
		#cal:hover{ background-image:url(../images/Cal24x24Rollover.gif);}
	</style>
</head>
<body>
<%
Select Case lCase(sAction)
	

	Case "loadmrs"'------------------------------------------------------------------------------------------------------------------
	
		ProjID=Request.QueryString("projID")
		%>
		<!-- div class=row style="opacity:0;">&nbsp;</div -->
		<h3>Materials Requested:</h3>
		<%
	
	

	Case "dangit"'------------------------------------------------------------------------------------------------------------------
		
		SQL="SELECT * FROM MaterialRequests WHERE ProjID="&ProjID&" ORDER BY Done DESC, Id"
		Set rs=Server.CreateObject("AdoDb.RecordSet")
		rs.Open SQL, REDConnString
		
		
		If rs.EOF Then 
			%><br/> There aren't any Material Requests for this project yet! <%
			Done=1
		Else 
			Done=rs("Done")
		End If
		
		If Done=1 Then
			%>
			<form id=newMR action="javascript:newMatReq(Gebi('newMR'));" style="height:auto; width:90%; margin:0 0 0 5%;">
				<h3>New Material Request:</h3>
				<h5 style="margin-bottom:0;">Ship To:</h5>
				<label class="taR w100p fL wsnw">Recipient's Name:<input class="w70p fR" name=shipToAttn maxlength=100 /></label><big><big><br></big></big>
				<label class="taR w100p fL wsnw">Company <b>/</b> Facility:<input class="w70p fR" name=shipToName  maxlength=100 /></label><big><big><br></big></big>
				<label class="taR w100p fL wsnw">Street Address:<input class="w70p fR" name=shipToAddress maxlength=100 /></label><big><big><br></big></big>
				<label class="taR w50p fL wsnw">City:<input class="w80p fR" name=shipToCity maxlength=50 /></label>
				<label class="taR w20p fL wsnw">State:<input class="w40p fR" name=shipToState  maxlength=2 /></label>
				<label class="taR w30p fL wsnw">Zip:<input class="w70p fR" name=shipToZip maxlength=10 /></label><br>
				<h5 style="margin-bottom:0;"> Details </h5>
				<label class="taR w100p fL wsnw">Requested By:<select name=empID id=empID class="w70p fR"><%EmployeeOptionList("active")%></select></label><big><big><br></big></big>
				<label class="taR w90p fL wsnw">Need it delivered by:<input class="w50p fR" id=Due name=Due maxlength=50 onClick="displayCalendar('Due','mm/dd/yyyy',Gebi('cal'));" /></label><div id=cal onClick="displayCalendar('Due','mm/dd/yyyy',this); posCal();" onMouseOver="calPosUpdate(event,this);" src="../images/cal.gif" width="16" height="16">&nbsp;</div>
				<h5 style="margin-bottom:0;">Notes:</h5>
				<textarea id=notes class="w100p h64" style="font-family:Consolas,'Courier New', Courier, monospace"></textarea>
				<center><button class="w50p" type="submit" >Activate<b><big><i>!</i></big></b></button></center>
			</form>
			<%
		Else
			%>
			<script>mrId=0<%=rs("Id")%>;</script>

			<div id=bidHead class="ItemsHead" >
				<div style="width:5%;"><label><input type=checkbox onClick="checkAll('partCheckbox',this.checked);"/></label></div>
				<div style="width:5%;"><small>Edit</small></div>
				<div style="width:14%;"><small>Quantity</small></div>
				<div style="width:14%;">Manufacturer</div>
				<div style="width:14%;">Part Number</div>
				<div style="width:23%;">Cost</div>
				<div style="width:24%;">Total</div>
			</div>	
			
			<div id=newRow style="display:none;">
				<div id=rowINDEX >
					<div></div>
				</div>
			</div>
			<%	
		End If
		
		mrItems=-1
		Dim MatReqItemsIDList(4096,4096)
		Dim mriPartsID(4096)
		Dim mriProjID(4096)
		Dim mriMfr(4096)
		Dim mriPN(4096)
		Dim mriDesc(4096)
		Dim mriUnitSize(4096)
		Dim mriCost(4096)
		Dim mriJpID(4096)
		Dim mriPO(4096)
		Dim mriQty(4096)

		r=0
		Do Until rs.EOF
			opacity=""
			If rs("Done")=1 Then opacity=" opacity:.5; "
			
			SQL0="SELECT * FROM MatReqItems WHERE mRID="&rs("Id")&" ORDER BY PartsID"
			Set rs0=Server.CreateObject("AdoDb.RecordSet")
			rs0.Open SQL0, REDConnString
			
			If Not rs0.EOF Then noParts=" style=""display:none"" " 
			%><span id=noParts <%=noParts%> ><br/>There aren't any parts in this Material Request yet.</span><%
			
			mrItems=0 : mrItemsI=-1
			Do Until rs0.EOF
				mrItemsI=mrItemsI+1
				MatReqItemsIDList(mrItems,mrItemsI)=rs0("ID")
				If rs0("PartsID")<>mriPartsID(mrItems) Then
					mrItems=mrItems+1
					mriPartsID(mrItems)=rs0("PartsID")
					mriProjID(mrItems)=rs0("ProjID")
					mriMfr(mrItems)=rs0("Mfr")
					mriPN(mrItems)=rs0("PartNo")
					mriDesc(mrItems)=rs0("Description")
					mriUnitSize(mrItems)=rs0("unitSize")
					mriCost(mrItems)=rs0("Cost")
					mriJpID(mrItems)=rs0("JobPackID")
					mriPO(mrItems)=rs0("PO")
					mriQty(mrItems)=1
				Else
					mriQty(mrItems)=mriQty(mrItems)+1
				End If
				rs0.MoveNext
			Loop
			
			For r=0 to mrItems
				%>
				<div id=row<%=r%> class=row value="<%=mriPartsID(r)%>" style=" <%=opacity%> " >
					<div class=w5p ></div>
					<div class=w5p ></div>
					<div class=w14p ><%=(mriQty(r)*mriUnitSize(r))%></div>
					<div class=w14p ><%=mriMfr(r)%></div>
					<div class=w14p ><%=mriPN(r)%></div>
					<div class=w23p ><%=formatCurrency(mriCost(r))%></div>
					<div class=w24p ><%=formatCurrency((mriQty(r)*mriUnitSize(r))*mriCost(r))%></div>
					<div class=rowBottom ><%=mriDesc(r)%></div>
				</div>
				<%
			Next
			
			rs.MoveNext
		Loop
		
	Case Else '═════════════════════════════════════════════════════════════════════
		%>
		<error>No subroutine found for:<%=sAction%> </error>
		<%
End Select		

%>
</body>
</html>
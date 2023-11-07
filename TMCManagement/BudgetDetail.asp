<!--#include file="../TMC/RED.asp" -->
<!DOCTYPE html>
<html style="height:100%; overflow:hidden;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>Budget Detail</title>
<!--#include file="common.asp" -->

<script type="text/javascript" src="Project/Project.js?nocache=<%=timer%>"></script>
<script type="text/javascript" src="Project/ProjectAJAX.js?nocache=<%=timer%>"></script>

<link rel=stylesheet href="Project/Project.css?nocache=<%=timer%>" media=all >

<%
If Session("user")="" Then
	QS=request.QueryString
	If QS <> "" Then QS= "?"&QS
	Session("LoginDestination")="../TMCManagement/BudgetDetail.asp"&QS
	Response.Redirect("blank.html")
End If

Sql0="SELECT Projects FROM Access WHERE UserName='"&Session("user")&"'"
Set rs0=Server.CreateObject("AdoDB.RecordSet")
rs0.Open Sql0, REDConnString

If rs0.EOF Then Response.Redirect("blank.html")
If rs0("Projects") <> "True" Then  Response.Redirect("blank.html")

SysID=Request.QueryString("SysID")
ProjID=Request.QueryString("ProjID")

If SysID>0 AND ProjID<1 Then
	cols="System,SystemID,ProjectID,RCSNotes,Notes,EnteredBy,DateEntered,Includes,Excludes"
	cols=cols&",MU,FixedPrice,Overhead,TaxRate,ExcludeSys,TotalFixed,Round"
	SQL="SELECT "&cols&" FROM Systems WHERE SystemID="&SysID
	Set rs=Server.createObject("AdoDB.RecordSet")
	%><%'=SQL%><%
	rs.Open SQL, REDConnString
	 
	projId=rs("ProjectID")
	'sysId=rs("SystemId")
	'Notes=DecodeChars(rs("Notes"))
	'System=DecodeChars(rs("System"))
	'RCSNotes=DecodeChars(rs("RCSNotes"))
	'Includes=DecodeChars(rs("Includes"))
	'Excludes=DecodeChars(rs("Excludes"))
	'MU=rs("MU") : If MU="" Or IsNull(MU) Then MU=0
	'Overhead=rs("Overhead")
	Set rs=Nothing
Else
	ProjID=Request.QueryString("projId")
End If

projSQL="SELECT ProjName, Use2010Bidder, SqFoot, Floors, DateStarted, DateDue, RCSNotes, CustName, RCSPM, ProjAddress, ProjCity, ProjState, ProjZip FROM Projects WHERE ProjID="&projId
%><%=projSQL%><%
Set projRS = Server.CreateObject("AdoDB.RecordSet")
projRS.Open projSQL, REDConnString
If projRS("Use2010Bidder")="True" Then useNewBidder=True  Else useNewBidder=False
unb=projRS("Use2010Bidder")

Set rs=Nothing

pName=DecodeChars(projRS("ProjName"))
Address=DecodeChars(projRS("ProjAddress"))
City=DecodeChars(projRS("ProjCity"))
RCSNotes=DecodeChars(CR2Br(projRS("RCSNotes")&" "))
Customer=DecodeChars(projRS("CustName"))

editLink="<a class=""editLink"" onclick=""eSysField(this.parentNode);"" >Edit</a>"
currencyLink="<a class=""editLink"" onclick=""eSysCurrency(this.parentNode);"" >Edit</a>"
dateLink="<a class=""editLink"" onclick=""dateSysField(this.parentNode)"" >Edit</a>"
notesLink="<a class=editLink onClick=eSysNotes(this.parentNode);>Edit</a>"

sysListSQL="SELECT SystemID FROM Systems WHERE ProjectID="&projID&" AND ExcludeSys<1"
Set sysListRS=Server.CreateObject("AdoDB.RecordSet")
sysListRS.Open sysListSQL, REDConnString
sysCount=0
Do Until sysListRS.EOF
	sysCount=sysCount+1
	sysListRS.MoveNext
Loop

%>

</head>

<body onLoad="setTimeout('systemBudget(<%=sysId%>);',500); sysResize();" style="height:100%; overflow:hidden; " onResize="sysResize();">

<div id=copyModal>
	<div id=copyWindow class="WindowBox">
		<div id=cwTitle class="WindowTitle"><span class="redXCircle" onClick="hide('copyModal')">X</span>Copy System</div>
		<br/>
		&nbsp;&nbsp;&nbsp;
		<label class="fL nowrap">&nbsp;&nbsp;Preset Name&nbsp;<input id=cwPresetName type="text" style="width:256px;" /></label>
		<br/>
		&nbsp;&nbsp;&nbsp;
		<label class="fL nowrap">
			&nbsp;&nbsp;Preset System&nbsp;
			<select id=cwSysType style="width:240px;">
				<option id=cwSysType0 selected></option>
				<%SysTypesOptionList("cwSysType")%>
			</select>
		</label>
		<div id=cwBottom style="width:100%; height:32px; line-height:32px; float:left; margin:12px 0 0 0;">
			<label class="nowrap">&nbsp;&nbsp;&nbsp;<input id=cwQtyChk type="checkbox" checked />Blank Quantities&nbsp;</label>
			<button id=cwCopyBidBtn style="height:95%; float:right; margin:0 1% 0 0;" onClick="copyBid();">&nbsp;<b>Copy Bid</b>&nbsp;</button>
		</div>
	</div>
</div>
<script type="text/javascript">
var projId=<%=projId%>;
var accessUser='n8';
</script>


<div id=Scrollbox >
	<br/>
	
	<div id=ProjInfoTitle class=ProjInfoTitle style="margin-top:1%;" >
		<div style=float:left;>Project Information</div>
		<div id=BudgetTotal class=total style="font-size:24px; float:right; line-height:20px; margin-right:8px;"></div>
		<div id=ProjectTotal class=total style="font-size:24px; float:right; line-height:20px; margin-right:32px;"></div>
	</div>
	<% 
	If useNewBidder Then 
		notNewBidder=0
		bidType="Lump Sum"
		notBidType="Itemized Materials"
	Else
		notNewBidder=1
		bidType="Itemized Materials" 
		notBidType="Lump Sum"
	End If
	
	rowCount=5
	iRowH=((100/rowCount)*3)/3 
	iRowMH=((144/rowCount)*3)/3 
	iColH=100'iRowH*(rowCount-1)
	iColMH=144'iRowMH*(rowCount-1)
	InfoCellStyle="height:"&iRowH&"%; max-height:"&iRowH&"%; min-height:"&iRowMH&"px; -moz-min-height:0px;"
	InfoBottomStyle="height:-moz-calc(100%-("&iRowH&"% * "&CStr(rowCount-1)&"); min-height:"&iRowMH&"px; -moz-min-height:0px;"
	%>
	<div id=ProjInfo class=ProjInfo height="178px" style="height:15%; min-height:<%=iColMH%>px;" >
		<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
			<label style="<%=InfoCellStyle%>"><big>Project Name</big></label>
			<label style="<%=InfoCellStyle%>"># of Floors</label>
			<label style="<%=InfoCellStyle%>">Square Footage</label>
			<label style="<%=InfoCellStyle%>">Date Started</label>
			<label style="<%=InfoCellStyle%>">Closing Date</label>
			<!-- <label style="< %=InfoCellStyle%>">Bid Type</label> -->
		</div>
		<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
			<div class=fieldDiv style="<%=InfoCellStyle%> z-index:0;" id=ProjName ><%=editLink%><div><%=pName%></div></div>
			<div class=fieldDiv style="<%=InfoCellStyle%>" id="Floors"><%=editLink&ProjRs("Floors")%></div>
			<div class=fieldDiv style="<%=InfoCellStyle%>" id=SqFoot><%=editLink&ProjRs("SqFoot")%></div>
			<div class=fieldDiv style="<%=InfoCellStyle%>"><%=ProjRs("DateStarted")%></div>
			<div class=fieldDiv id=BiddingDueDate style="<%=InfoCellStyle%>"><%=dateLink&ProjRs("DateDue")%></div>
			<%onClick="WSQLUBit('Projects','Use2010Bidder',"&notNewBidder&",'ProjID',"&projId&"); window.location=window.location;"%>
			<!-- <div class=fieldDiv id=Use2010Bidder style="height:100%;"><span style="float:left; font-size:14px; line-height:20px;"><%=bidType%></span></div> -->
		</div>
		<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
			<label style="<%=InfoCellStyle%>">Customer</label>
			<label style="<%=InfoCellStyle%>">Project Manager</label>
			<label style="<%=InfoCellStyle%>">Address</label>
			<label style="<%=InfoCellStyle%>">City</label>
			<label style="<%=InfoCellStyle%>">State</label>
			<label style="<%=InfoCellStyle%>">Zip</label>
		</div>
		<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
			<div class=fieldDiv id=CustName style="<%=InfoCellStyle%>"><%=Customer%></div>
			<div class=fieldDiv id=RCSPM style="<%=InfoCellStyle%>"><%=editLink&ProjRs("RCSPM")%></div>
			<div class=fieldDiv id=ProjAddress style="<%=InfoCellStyle%>"><%=editLink&Address%></div>
			<div class=fieldDiv id=ProjCity style="<%=InfoCellStyle%>"><%=editLink&City%></div>
			<div class=fieldDiv id=ProjState style="<%=InfoCellStyle%>"><%=editLink&ProjRs("ProjState")%></div>
			<div class=fieldDiv id=ProjZip style="<%=InfoCellStyle%>"><%=editLink&ProjRs("ProjZip")%></div>
		</div>
		<div class="labelColumn w50p" style="height:<%=iRowMH%>px; min-height:<%=iRowMH%>px;"></div>
	</div>
	
	
	<div id="SysInfoTitle" class="ProjInfoTitle">
		<span class=rollUp onClick="RollupC(this,'RollUpSysInfo',Gebi('RollUpSysInfo'));">▼</span>
		Systems Information
	</div>
	<div id=RollUpSysInfo style="height:40%; min-height:128px;">
		<div class="ProjInfoListHead" style="border-bottom:none; line-height:32px;" >
			<div style="width:33.34%; width:calc(33.34%-16px); width:-moz-calc(33.34%-16px); width:-webkit-calc(33.34%-16px); border:none; text-align:left;"><big>&nbsp; System Name</big> / Estimator / Notes</div>
			<div style="width:33.33%; width:calc(33.33%-16px); width:-moz-calc(33.33%-16px); width:-webkit-calc(33.33%-16px); border:none; text-align:left;">Scope of Work</div>
			<div style="width:16.67%; width:calc(16.67%-16px); width:-moz-calc(16.67%-16px); width:-webkit-calc(33.33%-16px); border:none; text-align:left;">Includes</div>
			<div style="width:16.66%; width:calc(16.66%-16px); width:-moz-calc(16.66%-16px); width:-webkit-calc(33.33%-16px); border:none; text-align:left;">Excludes</div>
		</div>
		<div id=SysInfo class=ProjInfo height="384px" style="height:100%; height:calc(100%-64px); min-height:64px; overflow-y:scroll;">
		
			<%
			sysListSQL="SELECT SystemID FROM Systems WHERE ProjectID="&projID&" AND ExcludeSys<1"
			Set sysListRS=Server.CreateObject("AdoDB.RecordSet")
			sysListRS.Open sysListSQL, REDConnString
			sysCount=0
			Do Until sysListRS.EOF
				sysCount=sysCount+1
				sysListRS.MoveNext
			Loop
			
			rowHeightPercent=100/sysCount

			sysListRS.MoveFirst
			
			row=0
			Do Until sysListRS.EOF
				row = row+1
				
				SysID=sysListRS("SystemID")
				
				cols="System,SystemID,ProjectID,RCSNotes,Notes,EnteredBy,DateEntered,Includes,Excludes"
				cols=cols&",MU,FixedPrice,Overhead,TaxRate,ExcludeSys,TotalFixed,Round"
				SQL="SELECT "&cols&" FROM Systems WHERE SystemID="&SysID
				%><%'=SQL%><%
				Set rs=Server.createObject("AdoDB.RecordSet")
				rs.Open SQL, REDConnString
				
				sysName=DecodeChars(rs("System"))
				sysEntBy=rs("EnteredBy")
				sysNotes=DecodeChars(CR2BR(rs("RCSNotes")))
				sysScope=DecodeChars(CR2BR(rs("Notes")))
				sysDate=rs("DateEntered")
				sysIncludes=DecodeChars(CR2BR(rs("Includes")))
				sysExcludes=DecodeChars(CR2BR(rs("Excludes")))
				
				%>				
				<div id=sysInfoRow<%=row%> style="min-height:96px; height:0<%=rowHeightPercent%>%; width:100%; border-bottom:#000 1px solid;">
					<div id=sysNameEntByNotes<%=row%> style="width:33.34%; height:100%; float:Left;" >
						<div style="width:100%; height:15%; float:left; font-weight:bold;"><%=sysName%></div>
						<div style="width:100%; height:15%; float:left;" ><%=sysEntBy%></div>
						<div style="width:100%; height:70%; float:left; overflow-y:scroll;" ><small><%=sysNotes%></small></div>
					</div>
					<div id=sysScope<%=row%> style="width:33.33%; height:100%; float:Left; overflow-y:scroll;" ><small><%=sysScope%></small></div>
					<div id=sysIncludes<%=row%> style="width:16.67%; height:100%; float:Left; overflow-y:scroll;" ><small><%=sysIncludes%></small></div>
					<div id=sysExcludes<%=row%> style="width:16.66%; height:100%; float:Left; overflow-y:scroll;" ><small><%=sysExcludes%></small></div>
				</div>
				
				<!--
				<div class="w100p fL h32"></div>
				<button style="font-size:18px; min-height:64px; height:24px; width:90%; margin-left:5%; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; float:left;" onclick="PrintSystemBudget(< %=SysID%>);">Print < %=System%> Budget Summary</button>
				<br/>
				-->
		
				<%
				sysListRS.MoveNext
			Loop
	
			%>
		</div>
	</div>
	
	<!-- 
	<div class="ProjInfoTitle">
		<span class=rollUp onClick="RollupC(this,'RollUpCost',Gebi('RollUpCost'));">▼</span>
		<div style="float:left">System Costing</div>
	</div>
	<div id=SysCosting class=ProjInfo style="height:auto;">
		<div id=RollUpCost height="auto">
			<div class="ProjInfoListHead" style="border-bottom:none; line-height:16px; width:100%; margin:0;" >
				<% 
				w=(100/5)
				s=" style=""height:16px; width:"&w&"%;"""
				%>
				<div <%=s%>>Parts<sup><small><b>(w/TAX)</b></small></sup></div>
				<div <%=s%>>Labor</div>
				<div <%=s%>>Travel</div>
				<div <%=s%>>Equipment</div>
				<div <%=s%>>Other Expenses</div>

				<% 	s=" style=""font-size:12px; height:16px; width:"&w&"%;""" %>
				<div <%=s%>>
					<div class="fL w50p" >Budget</div>
					<div class="fR w50p" >Spent</div>
				</div>
				<div <%=s%>>
					<div class="fL w50p" >Budget</div>
					<div class="fR w50p" >Spent</div>
				</div>
				<div <%=s%>>
					<div class="fL w50p" >Budget</div>
					<div class="fR w50p" >Spent</div>
				</div>
				<div <%=s%>>
					<div class="fL w50p" >Budget</div>
					<div class="fR w50p" >Spent</div>
				</div>
				<div <%=s%>>
					<div class="fL w50p" >Budget</div>
					<div class="fR w50p" >Spent</div>
				</div>
			</div>

			<%	s=" style=""font-size:12px; height:24px; width:"&w&"%;"""  	%>
			<div class="ProjInfoListHead" style="border:none; height:20px; font-size:14px; line-height:20px; width:100%; margin:0; background:transparent;" >
				<div <%=s%>>
					<div id=bPartsCost class="fieldDiv w50p"></div>
					<div id=aPartsCost class="fieldDiv w50p"></div>
				</div>
				<div <%=s%>>
					<div id=bLaborCost class="fieldDiv w50p"></div>
					<div id=aLaborCost class="fieldDiv w50p"></div>
				</div>
				<div <%=s%>>
					<div id=bTravelCost class="fieldDiv w50p"></div>
					<div id=aTravelCost class="fieldDiv w50p"></div>
				</div>
				<div <%=s%>>
					<div id=bEquipCost class="fieldDiv w50p"></div>
					<div id=aEquipCost class="fieldDiv w50p"></div>
				</div>
				<div <%=s%>>
					<div id=bOtherCost class="fieldDiv w50p"></div>
					<div id=aOtherCost class="fieldDiv w50p"></div>
				</div>
			</div>
			<div class="ProjInfoListHead h20 w100p m0 fS14 lH16" style="border:none; background:transparent;" >
				<div <%=s%>>
					<div id=bPartsPerc class="fieldDiv w50p"></div>
					<div id=aPartsPerc class="fieldDiv w50p"></div>
				</div>
				<div <%=s%>>
					<div id=bLaborPerc class="fieldDiv w50p"></div>
					<div id=aLaborPerc class="fieldDiv w50p"></div>
				</div>
				<div <%=s%>>
					<div id=bTravelPerc class="fieldDiv w50p"></div>
					<div id=aTravelPerc class="fieldDiv w50p"></div>
				</div>
				<div <%=s%>>
					<div id=bEquipPerc class="fieldDiv w50p"></div>
					<div id=aEquipPerc class="fieldDiv w50p"></div>
				</div>
				<div <%=s%>>
					<div id=bOtherPerc class="fieldDiv w50p"></div>
					<div id=aOtherPerc class="fieldDiv w50p"></div>
				</div>
				<div <%=s%>>
					<div id=bTaxPerc class="fieldDiv w50p"></div>
					<div id=aTaxPerc class="fieldDiv w50p"></div>
				</div>
			</div>
			<div class="labelColumn w50p" align=center><iframe id=bGraph src="" style="border:none; height:418px; width:100%;"></iframe></div>
			<div class="labelColumn w50p" align=center><iframe id=aGraph src="" style="border:none; height:418px; width:100%;"></iframe></div>
		</div>
			
		</div>

		<br/><br/><br/>
	-->
	
		<div class="ProjInfoTitle">
			<button title="Remove Selected" style="width:auto;" onClick="deleteBidItems('partCheckbox');"><img src="../images/delete16.PNG">delete</button>
			<!-- button title="Add Blank" style="width:auto;" onClick="parent.AddBlankPart();"><img src="../images/plus_16.png">add blank</button -->
			<button title="Add Part" style="width:auto;" onClick="parent.ShowAddPart();"><img src="../images/plus_16.png">add part</button>
			<span class=rollUp onClick="Rollup(this,'RollUpParts');">►</span>Materials
		</div>
		<div id=Parts class=ProjInfo height="32px" style="height:32px; display:none;">
		</div>
	
		<div id=RollUpParts class="ProjInfoList" style="display:none;">
			<div class="ProjInfoListHead">
				<div style="width:3%;"><input type=checkbox onClick="checkAll('partCheckbox',this.checked);"/></div>
				<div style="width:3%;"><small>Edit</small></div>
				<div style="width:10%; font-size:10px;">
					<div style="width:100%; height:50%; font-weight:bold;">Quantity</div>
					<div style="width:50%; height:50%; font-weight:normal;">Budget</div>
					<div style="width:50%; height:50%; font-weight:normal;">Actual</div>
				</div>
				<div style="width:9%;">Manufacturer</div>
				<div style="width:12%;">Part Number</div>
				<div style="width:28%;">Description</div>
				<div style="width:8%;">Cost</div>
				<div style="width:27%; font-size:12px;">
					<div style="width:100%; height:50%; font-weight:bold;">Totals</div>
					<div style="width:33.3333%; height:50%; font-weight:normal;">Allowance</div>
					<div style="width:33.3333%; height:50%; font-weight:normal;">Actual</div>
					<div style="width:33.3334%; height:50%; font-weight:normal;">Budget Left</div>
				</div>
			</div>
			
			<div id=BidSystemsParts>
				<%
				sysListSQL="SELECT SystemID FROM Systems WHERE ProjectID="&projID&" AND ExcludeSys<1"
				Set sysListRS=Server.CreateObject("AdoDB.RecordSet")
				sysListRS.Open sysListSQL, REDConnString
				
				pRow=0
				partsTotal=0
				Do Until sysListRS.EOF
					
					SysID=sysListRS("SystemID")
					
					SQL="SELECT System, MU FROM Systems WHERE SystemID="&SysID
					%><%'=SQL%><%
					Set rs=Server.createObject("AdoDB.RecordSet")
					rs.Open SQL, REDConnString
					
					%>
					<div id=pRow-1 class="ProjInfoListRow" style="background:none !important;" ><div style="width:100%;"></div></div>
					<div id=pRow0 class="ProjInfoListRow" style="background:none !important;" ><div style="width:100%;"><%=DecodeChars(rs("System"))%></div></div>
					<%
					
					pSQL="SELECT BidItemsID, Manufacturer, ItemName, ItemDescription, IsNull(Qty,0) AS Qty, IsNull(Cost,0) AS Cost, ActualQty, editable FROM BidItems WHERE SysID="&sysId&" AND Type='Part'"
					%><%'=pSQL%><%
					Set pRS=Server.CreateObject("AdoDB.RecordSet")
					pRS.Open pSQL, REDConnString
					
					Do Until pRS.EOF
						Cost=pRS("Cost")	
						
						pRow=pRow+1
						
						Qty=pRS("Qty")
						ActualQty=pRS("ActualQty")
						if Qty="" Then Qty=0
						if ActualQty="" Then ActualQty=0
						
						color=""
						If ActualQty<=0 And Qty<>0 Then color = "color:#C00;"
						
						Mfg=DecodeChars(pRS("Manufacturer"))
						PN=DecodeChars(pRS("ItemName"))
						Desc=DecodeChars(pRS("ItemDescription"))
						
						bc=" background:rgba(255,224,192,.75); "
						
						checkbox="<img align=absmiddle src=""../Images/padlock-gray.png"" height=16 width=16 style=""margin:auto;"" />"
						If pRS("editable")="True" Then checkbox="<input id=pSel"&pRow&" class=partCheckbox name=partCheckbox type=checkbox style=""width:100%;""/>"
						
						%>
						<div id=pRow<%=pRow%> class="ProjInfoListRow" style="<%=color%> ">
							<div id=Part-BidItemsID<%=pRow%> style="display:none"><%=pRS("BidItemsID")%></div>
							<div style="width:3%; " align="center"><%=checkbox%></div>
							<div style="width:3%; "><div id=Part-Edit<%=pRow%> class=rowEdit onClick="editPart(<%=pRow%>);"></div></div>
							<div style="width:5%; " class=taRPi id=Part-Qty<%=pRow%> ><%=Qty%></div>
							<div style="width:5%; " class=taRPi id=Part-ActualQty<%=pRow%> onKeyUp=updatePartRow(<%=pRow%>);><%=ActualQty%></div>
							<div style="width:9%; " class=taLPi id=Part-Manufacturer<%=pRow%>><%=Mfg%></div>
							<div style="width:12%; " class=taLPi id=Part-PartNumber<%=pRow%>><%=PN%></div>
							<div style="width:28%;  text-align:left;" class=taLPi id=Part-ItemDescription<%=pRow%>><%=Desc%></div>
							<div style="width:8%; " class=taRPi id=Part-Cost<%=pRow%> onKeyUp=updatePartRow(<%=pRow%>);><%=formatCurrency(Cost)%></div>
							<div style="width:9%; " class=taRPi id=Part-Total<%=pRow%>><%=formatCurrency(Cost*Qty)%></div>
							<div style="width:9%;" class=taRPi id=Part-Actual<%=pRow%>><%=formatCurrency(Cost*ActualQty)%></div>
							<% 
							Diff=Cost*(Qty-ActualQty)
							dColor=" color:#0c0; "
							if Diff<0 then dColor=" color:#f00; " 
							if Diff=0 then dColor="" 
							%>
							<div style="width:9%; font-weight:bold; <%=dColor%>" class=taRPi id=Part-Diff<%=pRow%>><%=formatCurrency(Diff)%></div>
						</div>
						<%
						partsTotal=partsTotal+(Cost*Qty)
						aPartsTotal=aPartsTotal+(Cost*ActualQty)
						pRS.MoveNext
					Loop
					sysListRS.MoveNext
				Loop
				bPartsTotal=bPartsTotal+(partsTotal-aPartsTotal)
				
				%>
				<script type="text/javascript">var pRow=<%=pRow%>;</script>
			</div>
		</div>
	<div id=tRowTotal class="ProjInfoListRow">
		<div style="width:73%; text-align:right; padding:0 2px 0 0;" >Total Parts:</div>
		<div style="width:9%; text-align:right; padding:0 2px 0 0;" class=total id=TotalParts><%=formatCurrency(partsTotal)%></div>
		<div style="width:9%; text-align:right; padding:0 2px 0 0;" class=total id=aTotalParts><%=formatCurrency(aPartsTotal)%></div>
		<div style="width:9%; text-align:right; padding:0 2px 0 0;" class=total id=bTotalParts><%=formatCurrency(bPartsTotal)%></div>
	</div>
	
	<div id=Junk style="width:100%; display:none;"></div>
	
	<div class="ProjInfoTitle">
		<button title="Remove Selected" style="width:auto;" onClick="deleteBidItems('laborCheckbox');"><img src="../images/delete16.PNG">delete</button>
		<!-- button title="Add Blank Labor" style="width:auto;" onClick="parent.AddBlankLabor();"><img src="../images/plus_16.png">add blank</button -->
		<button title="Add Labor" style="width:auto;" onClick="parent.ShowAddLabor();"><img src="../images/plus_16.png">add labor</button>
		<span class=rollUp onClick="Rollup(this,'RollUpLabor');">►</span>Labor
	</div>
	
	<div id=Labor class=ProjInfo height=32px style="height:32px; display:none; "></div>
	
	<div id=RollUpLabor class="ProjInfoList" style="display:none;">
	<div class="ProjInfoListHead">
		<div style="width:3%;"><input type="checkbox" onClick="checkAll('laborCheckbox',this.checked);"/></div>
		<div style="width:10%; font-size:10px;">
			<div style="width:100%; height:50%; font-weight:bold;">Hours</div>
			<div style="width:50%; height:50%; font-weight:normal;">Budget</div>
			<div style="width:50%; height:50%; font-weight:normal;">Actual</div>
		</div>
		<div style="width:17%;">Labor</div>
		<div style="width:42%;">Description</div>
		<div style="width:7%;">Cost</div>
		<div style="width:21%; font-size:12px;">
			<div style="width:100%; height:50%; font-weight:bold;">Totals</div>
			<div style="width:33.333%; height:50%; font-weight:normal;">Allowance</div>
			<div style="width:33.333%; height:50%; font-weight:normal;">Actual</div>
			<div style="width:33.333%; height:50%; font-weight:normal;">Budget Left</div>
		</div>
		%>
	</div>
	
	<div id=BidSystemsLabor>
		<%
		sysListSQL="SELECT SystemID FROM Systems WHERE ProjectID="&projID&" AND ExcludeSys<1"
		Set sysListRS=Server.CreateObject("AdoDB.RecordSet")
		sysListRS.Open sysListSQL, REDConnString
		
		lRow=0
		laborTotal=0
		laborI=-1
		Dim laborName(1024)
		Dim laborDesc(1024)
		Dim laborBudgetHours(1024) 
		Dim laborBudgetDollars(1024) 
		Dim laborActualHours(1024)
		Dim laborActualDollars(1024)
		Do Until sysListRS.EOF
			
			SysID=sysListRS("SystemID")
			
			SQL="SELECT System, MU FROM Systems WHERE SystemID="&SysID
			%><%'=SQL%><%
			Set rs=Server.createObject("AdoDB.RecordSet")
			rs.Open SQL, REDConnString
			
			lSQL="SELECT BidItemsID, ItemName, ItemDescription, Qty, ActualQty, Cost, editable FROM BidItems WHERE SysID="&sysId&" AND Type='Labor'"
			%><%'=lSQL%><%
			Set lRS=Server.CreateObject("AdoDB.RecordSet")
			lRS.Open lSQL, REDConnString
			
			
			Do Until lRS.EOF
				Cost=lRS("Cost")	
				lName=DecodeChars(lRS("ItemName"))
				lDesc=DecodeChars(lRS("ItemDescription"))
				
				lRow=lRow+1
				color=""
				If lRS("Qty")<=0 Then color = "color:#C00;"
				checkbox="<img align=absmiddle src=""../Images/padlock-gray.png"" height=16 width=16 style=""margin:auto;"" />"
				If lRS("editable")="True" Then checkbox="<input id=lSel"&lRow&" class=laborCheckbox type=checkbox style=""width:100%;""/>"
				%>
				<!--
				<div id=lRow<%=lRow%> class="ProjInfoListRow" style="<%=color%> ">
					<div id=Labor-BidItemsID<%=lRow%> style="display:none;"><%=lRS("BidItemsID")%></div>
					<div style="width:3%;" align="center"><%=checkbox%></div>
					<!-- div style="width:3%;"><div id=Labor-Edit<%=lRow%> class=rowEdit onClick="editLabor(<%=lRow%>);"></div></div - - >
					<div style="width:5%;" class=taRPi id=Labor-Qty<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=lRS("Qty")%></div>
					<div style="width:5%;" class=taRPi id=Labor-ActualQty<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=lRS("ActualQty")%></div>
					<%="<div style=width:17%; class=taLPi id=Labor-ItemName"&lRow&">"&lName&"</div>"%>
					<%="<div style=""width:42%; text-align:left; text-overflow:ellipsis;"" class=taLPi id=Labor-ItemDescription"&lRow&">"&lDesc&"</div>"%>
					<div style="width:7%;" class=taRPi id=Labor-Cost<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=formatCurrency(Cost)%></div>
					<div style="width:7%;" class=taRPi id=Labor-Total<%=lRow%>><%=formatCurrency(Cost*lRS("Qty"))%></div>
					<div style="width:7%;" class=taRPi id=Labor-Actual<%=lRow%>><%=formatCurrency(Cost*lRS("ActualQty"))%></div>
					<div style="width:7%;" class=taRPi id=Labor-Diff<%=lRow%>><%=formatCurrency(Cost*(lRS("Qty")-lRS("ActualQty")))%></div>
				</div>
				-->
				<%
				laborTotal=laborTotal+(lRS("Cost")*lRS("Qty"))
				alaborTotal=alaborTotal+(Cost*lRS("ActualQty"))
				blaborTotal=blaborTotal+(Cost*(lRS("Qty")-lRS("ActualQty")))
				
				if laborI>=0 Then
					matched=False
					For l=0 to laborI
						If uCase(lName)=laborName(l) Then
							laborActualHours(l)=0
							laborBudgetHours(l)=laborBudgetHours(l)+lRS("Qty")
							laborActualDollars(l)=0
							laborBudgetDollars(l)=laborBudgetDollars(l)+(lRS("Qty")*Cost)
							laborDesc(l)=laborDesc(l)&" / "&lDesc
							matched=True
							Exit For
						End If
					Next
					if not matched Then
						laborI=laborI+1
						laborName(laborI)=uCase(lName)
						laborDesc(laborI)=lDesc
						laborActualHours(laborI)=0
						laborBudgetHours(laborI)=lRS("Qty")
						laborActualDollars(laborI)=0
						laborBudgetDollars(laborI)=lRS("Qty")*Cost
					End If
				Else
					laborI=0
					laborName(0)=uCase(lName)
					laborDesc(0)=lDesc
					laborActualHours(0)=0
					laborBudgetHours(0)=lRS("Qty")
					laborActualDollars(0)=0
					laborBudgetDollars(0)=lRS("Qty")*Cost
				End If
				
				lRS.MoveNext
			Loop
			
			sysListRS.MoveNext
		Loop
		
		timeSQL="SELECT EmpID, TimeOutHr,TimeOutMin,TimeInHr,TimeInMin, wage, JobPhase FROM Time WHERE JobID=0"&ProjID
		Set timeRS=Server.CreateObject("AdoDB.RecordSet")
		timeRS.Open timeSQL, REDConnString
		
		Do Until timeRS.EOF
			H=(timeRS("TimeOutHr")+(timeRS("TimeOutMin")/60))-(timeRS("TimeInHr")+(timeRS("TimeInMin")/60))
			lName=timeRS("JobPhase")
			
			wage=timeRS("wage")
			if wage=0 or wage="" or wage=" " or IsNull(wage) Then
				empTimeSQL="SELECT Wage FROM Employees WHERE EmpID="&timeRS("EmpID")
				Set empTimeRS=Server.CreateObject("AdoDB.RecordSet")
				empTimeRS.Open empTimeSQL, REDConnString
				wage=0
				If Not EmpTimeRS.EOF Then wage=empTimeRS("Wage")
				Set empTimeRS=Nothing
			End If
			'% ><div id=lRowWabbit class="ProjInfoListRow" ><%=wage% ></div><%
			
			if laborI>=0 Then
				matched=False
				For l=0 to laborI
					If uCase(lName)=laborName(l) Then
						laborActualHours(l)=laborActualHours(l)+H
						laborActualDollars(l)=laborActualDollars(l)+(H*wage)
						'laborDesc(l)=laborDesc(l)&" / "&lDesc
						matched=True
						Exit For
					End If
				Next
				if not matched Then
					laborI=laborI+1
					laborName(laborI)=uCase(lName)
					laborDesc(laborI)=lDesc
					laborBudgetHours(laborI)=0
					laborActualHours(laborI)=H
					laborActualDollars(laborI)=H*wage
				End If
			Else
				laborI=0
				laborName(0)=uCase(lName)
				laborDesc(0)=lDesc
				laborActualHours(0)=H
				laborBudgetHours(0)=0
				laborActualDollars(0)=H*wage
			End If
			
			timeRS.MoveNext
		Loop
		
		if laborI>=0 Then
			aLaborTotal=0
			For lRow=0 to laborI
				%><%'="<div class=""ProjInfoListRow"">"&lRow&":"&laborBudgetDollars(lRow)&":"&laborBudgetHours(lRow)&"</div>"%><%				
				dividend=laborBudgetHours(lRow) : if dividend=0 Then dividend=1
				divisor=laborBudgetDollars(lRow) : if divisor="" Then divisor=0
				Cost=divisor/dividend
				%>
				<div id=lRow<%=l%> class="ProjInfoListRow" style="<%=color%> ">
					<!-- div id=Labor-BidItemsID< %=lRow%> style="display:none;">< %=lRS("BidItemsID")%></div -->
					<div style="width:3%;" align="center"><%=checkbox%></div>
					<!-- div style="width:3%;"><div id=Labor-Edit<%=lRow%> class=rowEdit onClick="editLabor(<%=lRow%>);"></div></div -->
					<div style="width:5%;" class=taRPi id=Labor-Qty<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=laborBudgetHours(lRow)%></div>
					<div style="width:5%;" class=taRPi id=Labor-ActualQty<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=laborActualHours(lRow)%></div>
					<%="<div style=width:17%; class=taLPi id=Labor-ItemName"&lRow&">"&laborName(lRow)&"</div>"%>
					<%="<div style=""width:42%; text-align:left; text-overflow:ellipsis;"" class=taLPi id=Labor-ItemDescription"&lRow&">"&laborDesc(lRow)&"</div>"%>
					<div style="width:7%;" class=taRPi id=Labor-Cost<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=formatCurrency(Cost)%></div>
					<div style="width:7%;" class=taRPi id=Labor-Total<%=lRow%>><%=formatCurrency(laborBudgetDollars(lRow))%></div>
					<div style="width:7%;" class=taRPi id=Labor-Actual<%=lRow%>><%=formatCurrency(laborActualDollars(lRow))%></div>
					<div style="width:7%;" class=taRPi id=Labor-Diff<%=lRow%>><%=formatCurrency(laborBudgetDollars(lRow)-laborActualDollars(lRow))%></div>
				</div>
				<%
				aLaborTotal=aLaborTotal+laborActualDollars(lRow)
			Next
		End If
		%>
		<script type="text/javascript">var lRow=<%=lRow%>;</script>
	</div>
	</div>
	<%'="<div class=""ProjInfoListRow"">"&laborI&"</div>"%>
	<div id=tRowTotal class="ProjInfoListRow">
		<div style="width:79%; text-align:right; padding:0 2px 0 0;" >Total Labor:</div>
		<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalLabor><%=formatCurrency(laborTotal)%></div>
		<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalLabor><%=formatCurrency(aLaborTotal)%></div>
		<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalLabor><%=formatCurrency(bLaborTotal)%></div>
	</div>
	
	<br/>
	<br/>
	<br/>
	<div style="float:left; width:100%; height:48px;"></div>
	<div class="ProjInfoSingle">
		<span>&nbsp; &nbsp;<big class=rollUp style="margin:6px 0 0 1%;" onClick="Rollup(this,'RollUpExpenses');">▼</big></span>
		<div class="ProjInfoSingleTitle">Expenses</div>
		<div style="margin:0 0 0 10%; text-align:left; width:10%;"> Total:&nbsp;<big id=ExpTotal class=total>0</big></div>
	</div>
	<div class="fadeToWhite"></div>
	<div id=RollUpExpenses style="display:block;">
		<div class="ProjInfoTitle">
			<button title="Remove Selected" style="width:auto;" onClick="deleteExpenses('travelCheckbox');"><img src="../images/delete16.PNG">delete</button>
			<button title="Add Travel" style="width:auto;" onClick="parent.ShowAddTravel();"><img src="../images/plus_16.png">add travel</button>
			<span class=rollUp onClick="Rollup(this,'RollUpTravel');">▼</span>Travel
		</div>
		<div id=Travel class=ProjInfo height=32px style="height:32px; display:none; "></div>
		
		<div id="RollUpTravel" class="ProjInfoList">
			<div class="ProjInfoListHead">
				<div style="width:3%;"><input type="checkbox" onClick="checkAll('travelCheckbox',this.checked);"/></div>
				<div style="width:3%;"><small>Edit</small></div>
				<div style="width:6%;">Type</div>
				<div style="width:20%;">From</div>
				<div style="width:20%;">To</div>
				<div style="width:9%;">Cost/Unit</div>
				<div style="width:10%; font-size:10px;">
					<div style="width:100%; height:50%; font-weight:bold;">Quantity</div>
					<div style="width:50%; height:50%; font-weight:normal;">Budget</div>
					<div style="width:50%; height:50%; font-weight:normal;">Actual</div>
				</div>
				<div style="width:8%;">Unit</div>
				<div style="width:21%; font-size:12px;">
					<div style="width:100%; height:50%; font-weight:bold;">Totals</div>
					<div style="width:33.333%; height:50%; font-weight:normal;">Allowance</div>
					<div style="width:33.333%; height:50%; font-weight:normal;">Actual</div>
					<div style="width:33.333%; height:50%; font-weight:normal;">Off-Budget</div>
				</div>
			</div>
			
			<div id=BidSystemsTravel>
				<%
				tSQL="SELECT ExpenseID, SubType, Origin, Destination, Units, ActualUnits, UnitCost, editable FROM Expenses WHERE SysID="&sysId&" AND Type='Travel'"
				%><%'=tSQL%><%
				Set tRS=Server.CreateObject("AdoDB.RecordSet")
				tRS.Open tSQL, REDConnString
				
				tRow=0
				travelTotal=0
				Do Until tRS.EOF
					
					tRow=tRow+1
					
					Cost=DecodeChars(tRS("UnitCost")): If Cost="" Or IsNull(Cost) Then Cost=0
					Qty=tRS("Units"): If Qty="" Or IsNull(Qty) Then Qty=0
					ActualQty=tRS("ActualUnits"): If ActualQty="" Or IsNull(ActualQty) Then ActualQty=0
					Origin=DecodeChars(trs("Origin"))
					Destination=DecodeChars(trs("Destination"))
					SubType=tRS("SubType")
					
					ttSQL="SELECT Unit FROM TravelType WHERE Type='"&SubType&"'"
					Set ttRS=Server.CreateObject("AdoDB.Recordset")
					ttRS.Open ttSQL, REDConnString
					If ttRS.EOF Then Unit="Unit"  Else  Unit=ttRS("Unit")
					Set ttRS=Nothing
					
					If tRS("editable")<>"True" Then 
						checkbox="<img align=absmiddle src=""../Images/padlock-gray.png"" height=16 width=16 style=""margin:auto;"" />"
					Else
						checkbox="<input id=tSel"&tRow&" class=travelCheckbox type=checkbox style=""width:100%;""/>"
						Qty=0
					End If
							
					If Qty<>1 Then Unit=Unit+"s"
					%>
					<div id=tRow<%=tRow%> class="ProjInfoListRow">
						<div id=Travel-ExpenseID<%=tRow%> style="display:none;"><%=tRS("ExpenseID")%></div>
						<div style="width:3%;" align="center"><%=checkbox%></div>
						<div style="width:3%;"><div id=Travel-Edit<%=tRow%> class=rowEdit onClick="editTravel(<%=tRow%>);"></div></div>
						<div style="width:6%;" id=Travel-SubType<%=tRow%>><%=tRS("SubType")%></div>
						<%="<div style=""width:20%; text-align:left; text-overflow:ellipsis; padding:0 0 0 2px;"" id=Travel-Origin"&tRow&">"&Origin&"</div>"%>
						<%="<div style=""width:20%; text-align:left; text-overflow:ellipsis; padding:0 0 0 2px;"" id=Travel-Destination"&tRow&">"&Destination&"</div>"%>
						<div style="width:9%; text-align:right; padding:0 2px 0 0;" id=Travel-Cost<%=tRow%> onKeyUp=updateTravelRow(<%=tRow%>);><%=formatCurrency(Cost)%></div>
						<div style="width:5%; text-align:right; padding:0 2px 0 0;" id=Travel-Qty<%=tRow%> onKeyUp=updateTravelRow(<%=tRow%>); ><%=Qty%></div>
						<div style="width:5%; text-align:right; padding:0 2px 0 0;" id=Travel-ActualQty<%=tRow%> onKeyUp=updateTravelRow(<%=tRow%>); ><%=ActualQty%></div>
						<div style="width:8%; text-align:left; padding:0 0 0 2px;" id=Travel-Unit<%=tRow%> ><%=Unit%></div>
						<div style="width:7%; text-align:right; padding:0 2px 0 0;" id=Travel-Total<%=tRow%>><%=formatCurrency(Cost*Qty)%></div>
						<div style="width:7%; text-align:right; padding:0 2px 0 0;" id=Travel-Actual<%=tRow%>><%=formatCurrency(Cost*ActualQty)%></div>
						<div style="width:7%; text-align:right; padding:0 2px 0 0;" id=Travel-Diff<%=tRow%>><%=formatCurrency(Cost*(Qty-ActualQty))%></div>
					</div>
					<%
					travelTotal=travelTotal+(Cost*Qty)
					tRS.MoveNext
				Loop
				%>
				<script type="text/javascript">
					var tRow=<%=tRow%>;
				</script>
			</div>
		</div>
		<div id=tRowTotal class="ProjInfoListRow">
			<div style="width:79%; text-align:right; padding:0 2px 0 0;" >Total Travel Expenses:</div>
			<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalTravel><%=formatCurrency(travelTotal)%></div>
			<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalTravel><%=formatCurrency(aTravelTotal)%></div>
			<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalTravel><%=formatCurrency(bTravelTotal)%></div>
		</div>
			
		<br/>
		<br/>
		<!--
		<table style="float:left; margin:32px 0 0 5%; width:90%;" cellpadding=0 cellspacing=0 cols=2 >
			<tr>
				<td width="100%" >
		-->
		<div class="ProjInfoTitle" >
			<button title="Remove Selected" style="width:auto;" onClick="deleteExpenses('equipCheckbox');"><img src="../images/delete16.PNG">delete</button>
			<button title="Add Equipment" style="width:auto;" onClick="parent.AddBlankEquip();"><img src="../images/plus_16.png">add equipment</button>
			<span class=rollUp onClick="Rollup(this,'RollUpEquip');">▼</span>Equipment
		</div>
			
		<div id="RollUpEquip" class="ProjInfoList" style="margin:0 0 0 2%;" >
			<div class="ProjInfoListHead" style="margin:0;" >
				<div style="width:3%;"><input type="checkbox" onClick="checkAll('equipCheckbox',this.checked);"/></div>
				<div style="width:3%;"><small>Edit</small></div>
				<div style="width:16%; font-size:10px;">
					<div style="width:100%; height:50%; font-weight:bold;">Quantity</div>
					<div style="width:50%; height:50%; font-weight:normal;">Budget</div>
					<div style="width:50%; height:50%; font-weight:normal;">Actual</div>
				</div>
				<div style="width:47%;">Description</div>
				<div style="width:10%;">Cost/Unit</div>
				<div style="width:21%; font-size:12px;">
					<div style="width:100%; height:50%; font-weight:bold;">Totals</div>
					<div style="width:33.333%; height:50%; font-weight:normal;">Allowance</div>
					<div style="width:33.333%; height:50%; font-weight:normal;">Actual</div>
					<div style="width:33.333%; height:50%; font-weight:normal;">Off-Budget</div>
				</div>
			</div>
			
			<div id=BidSystemsEquipment >
				<%
				eSQL="SELECT ExpenseID, SubType, Units, ActualUnits, UnitCost, editable FROM Expenses WHERE SysID="&sysId&" AND Type='Equip'"
				%><%'=eSQL%><%
				Set eRS=Server.CreateObject("AdoDB.RecordSet")
				eRS.Open eSQL, REDConnString
				
				eRow=0
				equipTotal=0
				Do Until eRS.EOF
					
					eRow=eRow+1
					
					Cost=DecodeChars(eRS("UnitCost")): If Cost="" Or IsNull(Cost) Then Cost=0
					Qty=eRS("Units"): If Qty="" Or IsNull(Qty) Then Qty=0
					ActualQty=eRS("ActualUnits"): If ActualQty="" Or IsNull(ActualQty) Then ActualQty=0
					SubType=eRS("SubType")
					
					If eRS("editable")<>"True" Then 
						checkbox="<img align=absmiddle src=""../Images/padlock-gray.png"" height=16 width=16 style=""margin:auto;"" />"
					Else 
						checkbox="<input id=eSel"&eRow&" class=equipCheckbox type=checkbox style=""width:100%;""/>"
						Qty=0
					End If
					
					If Qty<>1 Then Unit=Unit+"s"
					%>
					<div id=eRow<%=eRow%> class="ProjInfoListRow" style="margin:0;" >
						<div id=Equip-ExpenseID<%=eRow%> style="display:none;"><%=eRS("ExpenseID")%></div>
						<div style="width:3%;" align=center ><%=checkbox%></div>
						<div style="width:3%;" ><div id=Equip-Edit<%=eRow%> class=rowEdit onClick="editEquip(<%=eRow%>);"></div></div>
						<div style="width:8%;" class=taRPi id=Equip-Qty<%=eRow%> onKeyUp=updateEquipRow(<%=eRow%>); ><%=Qty%></div>
						<div style="width:8%;" class=taRPi id=Equip-ActualQty<%=eRow%> onKeyUp=updateEquipRow(<%=eRow%>); ><%=ActualQty%></div>
						<div style="width:47%;" class=taLPi id=Equip-Desc<%=eRow%>><%=eRS("SubType")%></div>
						<div style="width:10%;" class=taRPi id=Equip-Cost<%=eRow%> onKeyUp=updateEquipRow(<%=eRow%>);><%=formatCurrency(Cost)%></div>
						<div style="width:7%;" class=taRPi id=Equip-Total<%=eRow%>><%=formatCurrency(Cost*Qty)%></div>
						<div style="width:7%;" class=taRPi id=Equip-Actual<%=eRow%>><%=formatCurrency(Cost*ActualQty)%></div>
						<div style="width:7%;" class=taRPi id=Equip-Diff<%=eRow%>><%=formatCurrency(Cost*(Qty-ActualQty))%></div>
					</div>
					<%
					equipTotal=equipTotal+(Cost*Qty)
					eRS.MoveNext
				Loop
				%>
				<script type="text/javascript">var eRow=<%=eRow%>;</script>
			</div>
		</div>
		<div id=eRowTotal class="ProjInfoListRow" style=" margin:0 0 0 2%;">
			<div style="width:79%; text-align:right; padding:0 2px 0 0;" >Total Equipment Expenses:</div>
			<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalEquip><%=formatCurrency(equipTotal)%></div>
			<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalEquip><%=formatCurrency(aEquipTotal)%></div>
			<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalEquip><%=formatCurrency(bEquipTotal)%></div>
		</div>
		<!-- /td>
		<td width="50%" valign=top -->
		<div class="ProjInfoTitle" >
			<button title="Remove Selected" style="width:auto;" onClick="deleteExpenses('otherCheckbox');"><img src="../images/delete16.PNG">delete</button>
			<button title="Add Equipment" style="width:auto;" onClick="parent.AddBlankOther();"><img src="../images/plus_16.png">add expense</button>
			<div style="max-width:48%; float:left; overflow:hidden;"><span class=rollUp onClick="Rollup(this,'RollUpOther');">▼</span>Licensing, Permits, and Miscellaneous Expenses</div>
		</div>
		
		<div id=RollUpOther class="ProjInfoList" style="margin:0 0 0 2%;">
			<div class="ProjInfoListHead" style="margin:0;">
				<div style="width:3%;"><input type="checkbox" onClick="checkAll('otherCheckbox',this.checked);"/></div>
				<div style="width:3%;"><small>Edit</small></div>
				<div style="width:16%; font-size:10px;">
					<div style="width:100%; height:50%; font-weight:bold;">Quantity</div>
					<div style="width:50%; height:50%; font-weight:normal;">Budget</div>
					<div style="width:50%; height:50%; font-weight:normal;">Actual</div>
				</div>
				<div style="width:47%;">Description</div>
				<div style="width:10%;">Cost/Unit</div>
				<div style="width:21%; font-size:12px;">
					<div style="width:100%; height:50%; font-weight:bold;">Totals</div>
					<div style="width:33.333%; height:50%; font-weight:normal;">Allowance</div>
					<div style="width:33.333%; height:50%; font-weight:normal;">Actual</div>
					<div style="width:33.333%; height:50%; font-weight:normal;">Off-Budget</div>
				</div>
			</div>
			
			<div id=BidSystemsOther>
				<%
				oSQL="SELECT ExpenseID, SubType, Units, ActualUnits, UnitCost, editable FROM Expenses WHERE SysID="&sysId&" AND Type='OH'"
				%><%'=oSQL%><%
				Set oRS=Server.CreateObject("AdoDB.RecordSet")
				oRS.Open oSQL, REDConnString
				
				oRow=0
				otherTotal=0
				Do Until oRS.EOF
					
					oRow=oRow+1
					
					Cost=DecodeChars(oRS("UnitCost")): If Cost="" Or IsNull(Cost) Then Cost=0
					Qty=oRS("Units"): If Qty="" Or IsNull(Qty) Then Qty=0
					ActualQty=oRS("ActualUnits"): If ActualQty="" Or IsNull(ActualQty) Then ActualQty=0
					SubType=oRS("SubType")
					
					If oRS("editable")<>"True" Then 
						checkbox="<img align=absmiddle src=""../Images/padlock-gray.png"" height=16 width=16 style=""margin:auto;"" />"
					Else
						checkbox="<input id=oSel"&oRow&" class=otherCheckbox type=checkbox style=""width:100%;""/>"
						Qty=0
					End If
					
					If Qty<>1 Then Unit=Unit+"s"
					
					%>
					<div id=oRow<%=oRow%> class="ProjInfoListRow" style="margin:0;">
						<div id=Other-ExpenseID<%=oRow%> style="display:none;"><%=oRS("ExpenseID")%></div>
						<div style="width:3%;" align="center"><%=checkBox%></div>
						<div style="width:3%;"><div id=Other-Edit<%=oRow%> class=rowEdit onClick="editOther(<%=oRow%>);"></div></div>
						<div style="width:8%;" class=taRPi id=Other-Qty<%=oRow%> onKeyUp=updateOtherRow(<%=oRow%>); ><%=Qty%></div>
						<div style="width:8%;" class=taRPi id=Other-ActualQty<%=oRow%> onKeyUp=updateOtherRow(<%=oRow%>); ><%=ActualQty%></div>
						<div style="width:47%;" class=taLPi id=Other-Desc<%=oRow%>><%=oRS("SubType")%></div>
						<div style="width:10%;" class=taRPi id=Other-Cost<%=oRow%> onKeyUp=updateOtherRow(<%=oRow%>);><%=formatCurrency(Cost)%></div>
						<div style="width:7%;" class=taRPi id=Other-Total<%=oRow%>><%=formatCurrency(Cost*Qty)%></div>
						<div style="width:7%;" class=taRPi id=Other-Actual<%=oRow%>><%=formatCurrency(Cost*ActualQty)%></div>
						<div style="width:7%;" class=taRPi id=Other-Diff<%=oRow%>><%=formatCurrency(Cost*(Qty-ActualQty))%></div>
					</div>
					<%
					otherTotal=otherTotal+(Cost*Qty)
					oRS.MoveNext
				Loop
				%>
				<script type="text/javascript">var oRow=<%=oRow%>;</script>
			</div>
		</div>
		<div id=oRowTotal class="ProjInfoListRow" style="margin:0 0 0 2%;">
			<div style="width:79%; text-align:right; padding:0 2px 0 0;" >Total Other Expenses:</div>
			<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalOther><%=formatCurrency(otherTotal)%></div>
			<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalOther><%=formatCurrency(aOtherTotal)%></div>
			<div style="width:7%; text-align:right; padding:0 2px 0 0;" class=total id=TotalOther><%=formatCurrency(bOtherTotal)%></div>
		</div>
	</div>
	<div style=" float:left; height:32px; width:100%;"></div>

	<script type="text/javascript">
		Gebi('ExpTotal').innerHTML=formatCurrency(<%=travelTotal+equipTotal+otherTotal%>);
	</script>
</div>

<div id=SystemsBar class="Toolbar">
	<button id=ReloadFrame class=tButton0x24 onClick="window.location=window.location;" style="float:right; margin:3px 1% 0 0; position:relative; "/>
		<img src="../Images/reloadblue24.png" style="float:left; height:20px; margin:0; width:20px;"/>
		<div style="float:left; font-size:16px;">&nbsp;Reload: <%=System%></div>
	</button>
	
	<div id=budgetStatus class="fR taR w20p" style="line-height:32px; margin-right:16px;" >
		<span id=budgetCondition ></span>
		<span id=plusMinus class=total></span>
		<span id=diff class=total></span>
	</div>
	<div id=ActualTotal class="total taR" title="Actual for <%=System%>" align=right style=" width:20%;"></div>
	<div id=SystemTotal class="total taR" title="Budget for <%=System%>" align=right style=" width:20%;"></div>
	<!--small style="float:left; padding:5px 0 0 0; width:7%;"><b>Systems:</b></small>
	<div id=systemLinkList >
		<select id=systemList onChange="parent.loadSystem(SelI(this.id).value);" style="width:100%; font-size:18px; opacity:.6;"> 
		<%
		'SQL1="SELECT System, SystemID FROM Systems WHERE ProjectID="&projId
		'Set rs1=Server.createObject("Adodb.Recordset")
		'rs1.open SQL1, REDConnstring
		'
		'Do Until rs1.eof
		'	If rs1("SystemID")=sysId Then 
		'		s="font-size:16px; font-weight:bold; font-size:15px;"
		'		selected="selected"
		'	else 
		'		selected=""
		'		s=""
		'	End If
		'	'% ><a class="sysLink" onClick="parent.loadSystem(<%=rs1("SystemID")% >);" style="<%=s% >"><%=DecodeChars(rs1("System"))% ></a><%
		'	% ><option class="sysLink" value="<%=rs1("SystemID")% >" style="<%=s% >" <%=selected% >><%=DecodeChars(rs1("System"))% ></option><%
		'	rs1.moveNext
		'Loop
		'Set rs1=Nothing
		%>
		</select>
	</div -->
</div>
</body>
</html>
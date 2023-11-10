<!--#include file="../LMC/RED.asp" -->
<!DOCTYPE html>
<html style="height:100%; overflow:hidden;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<!--#include file="Common.asp" -->

<script type="text/javascript" src="Service/ServiceJob.js?noCache=0<%=loadStamp%>"></script>

<link rel="stylesheet" href="Service/ServiceJob.css?noCache=0<%=loadStamp%>" media="all">

<%
If Session("user")="" Then
	QS=request.QueryString
	If QS <> "" Then QS= "?"&QS
	Session("LoginDestination")="../LMCManagement/ServiceJob.asp"&QS
	Response.Redirect("blank.html")
End If

Sql0="SELECT Estimates FROM Access WHERE UserName='"&Session("user")&"'"
Set rs0=Server.CreateObject("AdoDB.RecordSet")
rs0.Open Sql0, REDConnString

If rs0.EOF Then Response.Redirect("blank.html")
If rs0("Estimates") <> "True" Then  Response.Redirect("blank.html")
 
Id = Request.QueryString("id")
%>
<script>
var serviceId=('0<%=cStr(Request.QueryString("id"))%>')*1;
var Id=serviceId;
</script>
<title>LMC Service Call #<%=Id%></title>
<%
	'cols="JobName,ProjectID,PrivateNotes,Scope,TricomRepID,DateEnt,Includes,Excludes"
	'cols=cols&",MU,FixedPrice,Overhead,TaxRate,isFixedPrice,Round,CustAgreed"
	cols="*"
	SQL="SELECT "&cols&" FROM Services WHERE ID="&ID
	%><%'=SQL%><%
	Set rs=Server.createObject("AdoDB.RecordSet")
	rs.Open SQL, REDConnString
	
	if rs.EOF Then
		%>Service Call #<%=ID%> does not exist.<%
		response.End()
	End If
	 
	projId=rs("ProjectID")
	Id=rs("Id")
	Scope=DecodeChars(rs("Scope"))
	JobName=DecodeChars(rs("JobName"))
	PrivateNotes=DecodeChars(rs("PrivateNotes"))
	Includes=DecodeChars(rs("Includes"))
	Excludes=DecodeChars(rs("Excludes"))
	If rs("CustAgreed")="True" Then custAgreed=True Else custAgreed=False
	MU=rs("MU") : If MU="" Or IsNull(MU) Then MU=0
	
	TricomRep="_____________________________"
	If CInt("0"&rs("TricomRepID"))>0 Then
		trSQL="SELECT FName, LName, EmpID FROM Employees WHERE EmpID="&rs("TricomRepID")
		%><%'=trSQL%><%
		Set trRS=Server.createObject("AdoDB.RecordSet")
		trRS.Open trSQL, REDConnString
		If Not trRS.EOF Then
			TricomRep=trRS("FName")&" "&trRS("LName")
		End If
	End If
	
	editLink="<a class=""editLink"" onclick=""eSysField(this.parentNode);"" >Edit</a>"
	currencyLink="<a class=""editLink"" onclick=""eSysCurrency(this.parentNode);"" >Edit</a>"
	dateLink="<a class=""editLink"" onclick=""dateSysField(this.parentNode)"" >Edit</a>"
	notesLink="<a class=editLink onClick=eSysNotes(this.parentNode);>Edit</a>"
%>

<script type="text/javascript">
//var projId=<%=projId%>;
//var sysId=<%=sysId%>;
var jobName=CharsDecode('<%=EncodeChars(JobName)%>');
var MU=<%=MU%>;
<% 

%>
var obtained=<%=lCase(CStr(custAgreed))%>;

var editLink='<%=editLink%>';
var currencyLink='<%=currencyLink%>';
var dateLink='<%=dateLink%>';
var notesLink='<%=notesLink%>';

</script>
</head>

<body onLoad="setTimeout('serviceCost(<%=Id%>);',500); Resize(); " style="height:100%; overflow:hidden; " onResize="Resize();">

<div id=Modal onMouseMove="ModalMouseMove(event,'AddPartContainer');" align="center">
	<div style="width:100%; height:30%;"></div>
	<img src=../Images/roller.gif /><br/>
	<div id=modalStatus></div>
</div>


<div id=copyModal>
	<div id=copyWindow class="WindowBox">
		<div id=cwTitle class="WindowTitle"><span class="redXCircle" onClick="hide('copyModal')">X</span>Copy Service to Preset</div>
		<br/>
		&nbsp;&nbsp;&nbsp;
		<label class="fL nowrap">&nbsp;&nbsp;Preset Name&nbsp;<input id=cwPresetName type="text" style="width:256px;" /></label>
		<br/>
		&nbsp;&nbsp;&nbsp;
		<label class="fL nowrap">
			&nbsp;&nbsp;Preset Service&nbsp;
			<select id=cwSysType style="width:240px;">
				<option id=cwSysType0 selected></option>
				<%SysTypesOptionList("cwSysType")%>
			</select>
		</label>
		<div id=cwBottom style="width:100%; height:32px; line-height:32px; float:left; margin:12px 0 0 0;">
			<label class="nowrap">&nbsp;&nbsp;&nbsp;<input id=cwQtyChk type="checkbox" checked />Blank Quantities&nbsp;</label>
			<button id=cwCopyServiceBtn style="height:95%; float:right; margin:0 1% 0 0;" onClick="copyService();">&nbsp;<b>Copy Service</b>&nbsp;</button>
		</div>
	</div>
</div>

<div id=dupModal>
	<div id=dupWindow class="WindowBox">
		<div id=dwTitle class="WindowTitle"><span class="redXCircle" onClick="hide('dupModal');">X</span>Move or Copy</div>
		<br/>
		&nbsp;&nbsp;&nbsp;
		<label class="fL nowrap">&nbsp;&nbsp;To Service #&nbsp;<input id=dwProjID type="text" style="width:256px;" value="<%=ProjID%>" /></label>
		<br/>
		&nbsp;&nbsp;&nbsp;
		<label class="fL nowrap">
			&nbsp;&nbsp;Name&nbsp;
			<input id=dwSysName type="text" style="width:256px;" value="<%=JobName%> 2" />
		</label>
		<div id=dwBottom style="width:100%; height:32px; line-height:32px; float:left; margin:12px 0 0 0;">
			<label class="nowrap">&nbsp;&nbsp;&nbsp;<input id=dwMoveChk type="checkbox" />Delete when done (Move)&nbsp;</label>
			<button id=cwDupServiceBtn style="height:95%; float:right; margin:0 1% 0 0;" onClick="dupService();">&nbsp;<b>Go</b>&nbsp;</button>
		</div>
	</div>
</div>

<div id="Employees" style="display:none;"><%EmployeeOptionList("active")%></div>

<div id="AddContactContainer"> 
	<div id="AddContactTitle" onmousedown="PartsMouseDown(event)" onmouseup="PartsMouseUp(event)" onMouseMove="ModalMouseMove(event,'AddPartContainer')" onselectstart="return false;" >PARTS LIST SEARCH</div>
	<iframe id="AddContactBox" class="AddContactBox" src="ContactsInterface.asp?Customer=1&Vendor=0&BoxID=AddContactContainer&ModalID=Modal&MM=parent.PartsMouseMove(event,'AddContactContainer')&MD=parent.PartsMouseDown(event)&MU=parent.PartsMouseUp(event)"></iframe>
</div>
	
<div id="AddPartContainer"> 
	<div id="AddPartTitle" onmousedown="PartsMouseDown(event)" onmouseup="PartsMouseUp(event)" onMouseMove="ModalMouseMove(event,'AddPartContainer')" onselectstart="return false;" >PARTS LIST SEARCH</div>
	<iframe id="AddPartBox" class="AddPartBox" src="PartsInterface.asp?BoxID=AddPartContainer&ModalID=Modal&MM=parent.PartsMouseMove(event,'AddPartContainer')&MD=parent.PartsMouseDown(event)&MU=parent.PartsMouseUp(event)"></iframe>
</div>
	
<div id="AddLaborContainer"> 
	<div id="AddLaborTitle" onmousedown="PartsMouseDown(event)" onmouseup="PartsMouseUp(event)" onMouseMove="ModalMouseMove(event,'AddLaborContainer')" onselectstart="return false;" >LABOR LIST SEARCH</div>
	<iframe id="AddLaborBox" class="AddLaborBox" src="LaborInterface.asp?BoxID=AddLaborContainer&ModalID=Modal&MM=parent.PartsMouseMove(event,'AddLaborContainer')&MD=parent.PartsMouseDown(event)&MU=parent.PartsMouseUp(event)"></iframe>
</div>

<div id="AddTravelContainer" class="WindowBox"> 
	<div id=AddTravelTitle class="WindowTitle">Add Travel Expense<div class="redXCircle" onClick="HideAddTravel();">X</div></div>
	
		<div class="BoxRow">
			<div class="BoxLabel">Method:</div>
			<select id="tSelType" class="BoxInput" onChange="Gebi('addBoxUnits').innerHTML=SelI(this.id).value+'s';Gebi('addBoxCostUnit').innerHTML=SelI(this.id).value;">
			
			<%
			SQL1="SELECT TravelTypeID, Type, Unit FROM TravelType"
			Set rs1= Server.CreateObject("ADODB.RecordSet")
			rs1.Open SQL1, REDConnString
			
			Dim TravelType(255,2)
			Dim t: t=0
			
			Do Until rs1.EOF
				If t+1>255 then Exit Do
				t=t+1
				
				TravelType(t,0)=rs1("TravelTypeID")
				TravelType(t,1)=rs1("Type")
				TravelType(t,2)=rs1("Unit")
				
				Rs1.MoveNext
			Loop
			
			Set rs1=Nothing
			
			For t = 1 to UBound(TravelType)
				If TravelType(t,0)<>"" Then
					%>
						<option id="TravelType<%=TravelType(t,0)%>" value="<%=TravelType(t,2)%>" ><%=TravelType(t,1)%></option>
					<%
				End If
			Next
			%>
			</select>
		</div>
		
		<div class="BoxRow">
			<div class="BoxLabel">From:</div>
			<input id="tOrigin" class="BoxInput"/>
		</div>
		<div class="BoxRow">
			<div class="BoxLabel">To:</div>
			<input id="tDest" class="BoxInput"/>
		</div>
		<div class="BoxRow">
			<div id="addBoxUnits" class="BoxLabel">Tickets</div>
			<input id="tAmount" class="BoxInput Numbers"/>
		</div>
		<div class="BoxRow">
			<div class="BoxLabel">Cost per&nbsp;<span id="addBoxCostUnit" style="">Ticket</span></div>
			<input id="tCost" class="BoxInput Numbers"/>
		</div>
		<div class="BoxRow">
			<button style=float:left; onClick=HideAddTravel(); >Cancel</button>
			<button id=tAdd style=float:right; onClick="AddExpense('Travel',SelI('tSelType').innerHTML, Gebi('tOrigin').value, Gebi('tDest').value, Gebi('tAmount').value, Gebi('tCost').value); HideAddTravel();">Save</button>
		</div>
</div>


<div id=mainToolbar class="Toolbar">
	<button onClick="window.history.go(-1);" style="float:left;">◄Back</button>
	<button id="ReloadFrame" class="tButton24" onClick="window.location=window.location;" style="float:right;"/><img src="../Images/reloadblue24.png" /></button><div class=tSpacer style="float:right;"></div>
	<button id="PrintProposal" class="tButton0x24" onClick="Print();" style="float:right; width:auto; line-height:24px; font-family:Verdana, Geneva, sans-serif; font-weight:bold;"/> <img src="../Images/printer-icon.png" style="float:left; height:23px; width:23px;" /><big>&nbsp;Print&nbsp;</big></button>
</div>
<div id=pathToolbar class="Toolbar">
	<div id=path>&nbsp; Service > <a href="Service.asp">Service Jobs</a> > <%=pName%></div>
	<div id=JobTotal class="total"></div>
</div>


<div id=TabsBar>
	<span id=JobInfoTab class="activeTab" onClick=" showTab(this); ">Job Information</span>
	<span id=PrintingTab class="tab" onClick="showTab(this);">Proposal Printing</span>
</div>
<div id="OuterBox">
<div id=JobInfoPage class="activeTabPage">
	<div id=ProjInfoTitle class=ProjInfoTitle >
		<div style=float:left;>Customer / Facility Information</div>
		<div id=BudgetTotal class=total style="font-size:24px; float:right; line-height:20px; margin-right:8px;"></div>
		<div id=ProjectTotal class=total style="font-size:24px; float:right; line-height:20px; margin-right:32px;"></div>
	</div>
	<% 
	rowCount=5
	iRowH=((100/rowCount)*3)/3 
	iRowMH=((144/rowCount)*3)/3 
	iColH=100'iRowH*(rowCount-1)
	iColMH=144'iRowMH*(rowCount-1)
	InfoCellStyle="height:"&iRowH&"%; max-height:"&iRowH&"%; min-height:"&iRowMH&"px; -moz-min-height:0px;"
	InfoBottomStyle="height:-moz-calc(100%-("&iRowH&"% * "&CStr(rowCount-1)&"); min-height:"&iRowMH&"px; -moz-min-height:0px;"
	%>
	<div id=ProjInfo class=ProjInfo height="178px" style="height:25%; min-height:<%=iColMH%>px;" >
		<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
			<label style="<%=InfoCellStyle%>"><big>Service Name</big></label>
			<label style="<%=InfoCellStyle%>">Sales Representative</label>
			<label style="<%=InfoCellStyle%>">Date Created</label>
			<label style="<%=InfoCellStyle%>">Start Date</label>
			<label style="<%=InfoCellStyle%>">Completion Date</label>
			<!-- <label style="< %=InfoCellStyle%>">Bid Type</label> -->
		</div>
		<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
			<div class="fieldDiv" id="JobName" style="<%=InfoCellStyle%> font-size-adjust:.6;"><%=editLink%><%=JobName%></div>
			<div class="fieldDiv" style="<%=InfoCellStyle%>"><%=TricomRep%></div>
			<div class="fieldDiv" style="<%=InfoCellStyle%>"><%=rs("DateEnt")%></div>
			<div class=fieldDiv style="<%=InfoCellStyle%>"><%=rs("DateStart")%></div>
			<div class=fieldDiv id=BiddingDueDate style="<%=InfoCellStyle%>"><%=dateLink&rs("DateDue")%></div>
			<%onClick="WSQLUBit('Projects','Use2010Bidder',"&notNewBidder&",'ProjID',"&projId&"); window.location=window.location;"%>
			<!-- <div class=fieldDiv id=Use2010Bidder style="height:100%;"><span style="float:left; font-size:14px; line-height:20px;"><%=bidType%></span></div> -->
		</div>
		<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
			<label style="<%=InfoCellStyle%>">Customer</label>
			<label style="<%=InfoCellStyle%>">Lead Tech</label>
			<label style="<%=InfoCellStyle%>">Address</label>
			<label style="<%=InfoCellStyle%>">City</label>
			<label style="<%=InfoCellStyle%>">State</label>
			<label style="<%=InfoCellStyle%>">Zip</label>
		</div>
		<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
			<div class=fieldDiv id=RCSPM style="<%=InfoCellStyle%>"><%=Customer%></div>
			<div class=fieldDiv id=RCSPM style="<%=InfoCellStyle%>"><%=editLink&rs("TricomLeadTechID")%></div>
			<div class=fieldDiv id=Address style="<%=InfoCellStyle%>"><%=editLink&rs("Address")%></div>
			<div class=fieldDiv id=City style="<%=InfoCellStyle%>"><%=editLink&rs("City")%></div>
			<div class=fieldDiv id=State style="<%=InfoCellStyle%>"><%=editLink&rs("State")%></div>
			<div class=fieldDiv id=Zip style="<%=InfoCellStyle%>"><%=editLink&rs("Zip")%></div>
		</div>
		<div class="labelColumn w50p" style="height:<%=iRowMH%>px; min-height:<%=iRowMH%>px;"></div>
	</div>

	<div id="SysInfoTitle" class="ProjInfoTitle">
		<span class=rollUp onClick="RollupC(this,'RollUpSysInfo',this.parentNode.parentNode);">▼</span>
		Service Information
	</div>
	<div id=SysInfo class=ProjInfo height="250px" style="height:250px;">
		
		<div id=RollUpSysInfo>
			
			<div class="labelColumn w25p">
				<label style="height:56px; padding-top:12px;" onDblClick="eSysNotes(Gebi('RCSNotes'));">Notes<br/><small><small>(Not Seen by Customer)</small></small></label>
			</div>
			<div class="fieldColumn w75p">
				<div class="fieldDiv pre" id=RCSNotes style="height:56px; white-space:pre-wrap;"><%=notesLink%><%=RCSNotes%></div>
				<div id=oldNotes style="display:none;"></div>
			</div>
			
			<div class="labelColumn w25p">
				<label style="height:88px; line-height:88px;" onDblClick="eSysNotes(Gebi('Notes'));">Scope of Work</label>
			</div>
			<div class="fieldColumn w75p">
				<div class="fieldDiv pre" id=Notes style="height:88px; white-space:pre-wrap;"><%=notesLink%><%=Notes%></div>
				<div id=oldNotes style="display:none;"></div>
			</div>
			
			<div class="labelColumn w25p">
				<label style="height:104px; line-height:104px;" onDblClick="eSysNotes(Gebi('Includes'));">Includes</label>
			</div>
			<div class="fieldColumn w25p">
				<div class="fieldDiv pre" id=Includes style="height:104px; white-space:pre-wrap; text-overflow:ellipsis;"><%=notesLink%><%=Includes%></div>
				<div id=oldNotes style="display:none;"></div>
			</div>
			
			<div class="labelColumn w25p">
				<label style="height:104px; line-height:104px;" onDblClick="eSysNotes(Gebi('Excludes'));">Excludes</label>
			</div>
			<div class="fieldColumn w25p">
				<div class="fieldDiv pre" id=Excludes style="height:104px; white-space:pre-wrap;"><%=notesLink%><%=Excludes%></div>
				<div id=oldNotes style="display:none;"></div>
			</div>
		</div>
	</div>
	
	<br/>
	
	<div class="ProjInfoTitle">
		<span class=rollUp onClick="RollupC(this,'RollUpCost',this.parentNode.parentNode);">▼</span>
		<div style="float:left">Service Costing</div>
	</div>
	<div id=SysCosting class=ProjInfo height="362px" style="height:362px;">
		
		
		<div id=RollUpCost>
			<div class="labelColumn w25p">
				<label>Margin</label>
				<label for=TotalFixed>Use Fixed Price</label>
				<label>Fixed Price</label>
				<label>Overhead</label>
				<label>Tax Rate</label>
				<!-- label class="h72"></label - ->
				<label style="border:none; padding:0;">
					<label style="float:left; font-size:12px; width:40%;">Parts Cost</label>
					<div id=PartsCost class=fieldDiv style="float:left; font-size:12px; background:#fff; width:60%;"></div>
				</label>
				<label style="border:none; padding:0;">
					<label style="float:left; font-size:12px; width:40%;">Labor Cost</label>
					<div id=LaborCost class=fieldDiv style="float:left; font-size:12px; background:#fff; width:60%;"></div>
				</label>
				<!-- -->
				<label>Parts Cost</label><label>Parts Sell</label>
				<label>Labor Cost</label><label>Parts Sell</label>
				<label>Travel</label><label>Equipment</label>
				<label>Other Expenses</label><label>Overhead</label><label>Profit</label><label>Tax</label>
			</div>
			<div class="fieldColumn w25p" style="border-right:#000 1px solid;">
				<div class="fieldDiv" id="MU" ><%=currencyLink%><%=rs("MU")%></div>
				<%If rs("isFixedPrice")="True" Then chk="checked" else chk=""%>
				<label class="fieldDiv">&nbsp; &nbsp; &nbsp; <input id=TotalFixed type=checkbox <%=chk%> onChange="eSysCheck(this.id,this.checked);" /></label>
				<div class="fieldDiv" id="FixedPrice" ><%=currencyLink%><%=rs("FixedPrice")%></div>
				<div class="fieldDiv" id="Overhead" ><%=currencyLink%><%'=rs("Overhead")%></div>
				<div class="fieldDiv" id=TaxRate><%=editLink%><%=rs("TaxRate")%></div>
				<!-- div class="fieldDiv h72"></div -->
				<div id=PartsCost class=fieldDiv></div>
				<div id=PartsSell class=fieldDiv></div>
				<div id=LaborCost class=fieldDiv></div>
				<div id=LaborSell class=fieldDiv></div>
<!-- div class="fieldDiv" style="border:none; padding:0;"><label align=right class=fieldDiv style="float:left; font-size:12px; background:#F3F3F3; width:40%;">Parts Sell&nbsp;</label><div id=PartsSell class=fieldDiv style="float:left; font-size:12px; width:60%;"></div>
				</div>
				<div class="fieldDiv" style="border:none; padding:0;"><label align=right class=fieldDiv style="float:left; font-size:12px; background:#F3F3F3; width:40%;">Labor Sell&nbsp;</label><div id=LaborSell class=fieldDiv style="float:left; font-size:12px; width:60%;"></div>
				</div -->
				<div id=TravelCost class=fieldDiv></div>
				<div id=EquipCost class=fieldDiv></div>
				<div id=OtherCost class=fieldDiv></div>
				<div id=OverheadCost class=fieldDiv></div>
				<div id=ProfitCost class=fieldDiv></div>
				<div id=TaxCost class=fieldDiv></div>
			</div>
			
			<div class="labelColumn w50p" align=center><iframe id=Graph src="" style="border:none; height:362px; width:100%;"></iframe></div>
		</div>
		<br/><br/><br/>
	</div>
	
	
	<div class="ProjInfoTitle">
		<button title="Remove Selected" style="width:auto;" onClick="deleteBidItems('partCheckbox');"><img src="../images/delete16.PNG">delete</button>
		<!-- button title="Add Blank" style="width:auto;" onClick="AddBlankPart();"><img src="../images/plus_16.png">add blank</button -->
		<button title="Add Part" style="width:auto;" onClick="ShowAddPart();"><img src="../images/plus_16.png">add part</button>
		<span class=rollUp onClick="Rollup(this,'RollUpParts');">►</span>Materials
	</div>
	<div id=Parts class=ProjInfo height="32px" style="height:32px; display:none;">
	</div>
	
	<div id=RollUpParts class="ProjInfoList" style="display:none;">
		<div class="ProjInfoListHead">
			<div style="width:3%;"><input type=checkbox onclick="checkAll('partCheckbox',this.checked);"/></div>
			<div style="width:3%;"><small>Edit</small></div>
			<div style="width:7%;">Qty</div>
			<div style="width:12%;">Manufacturer</div>
			<div style="width:15%;">Part Number</div>
			<%
			If useNewServicer Then
				%>
				<div style="width:38%;">Description</div>
				<div style="width:10%;">Cost</div>
				<div style="width:12%;">Totals</div>
				<%
			Else
				%>
				<div style="width:28%;">Description</div>
				<div style="width:10%;">Cost</div>
				<div style="width:10%;">Sell</div>
				<div style="width:12%;">Totals</div>
				<%
			End If
			%>
		</div>
		
		<div id=ServiceParts>
			<%
			pSQL="SELECT BidItemsID, Manufacturer, ItemName, ItemDescription, IsNull(Qty,0) AS Qty, IsNull(Cost,0) AS Cost FROM BidItems WHERE SysID="&Id&" AND Type='Part' AND editable<>1"
			%><%'=pSQL%><%
			Set pRS=Server.CreateObject("AdoDB.RecordSet")
			pRS.Open pSQL, REDConnString
			
			pRow=0
			partsTotal=0
			Do Until pRS.EOF
				Cost=pRS("Cost")	
				
				pRow=pRow+1
				
				Qty=pRS("Qty")
				if Qty="" Then Qty=0
				
				color=""
				If Qty<=0 Then color = "color:#C00;"
				
				Mfg=DecodeChars(pRS("Manufacturer"))
				PN=DecodeChars(pRS("ItemName"))
				Desc=DecodeChars(pRS("ItemDescription"))
				
				%>
				<div id=pRow<%=pRow%> class="ProjInfoListRow" style="<%=color%> ">
					<div id=Part-BidItemsID<%=pRow%> style="display:none"><%=pRS("BidItemsID")%></div>
					<div style="width:3%;" align="center"><input id=pSel<%=pRow%> class=partCheckbox name=partCheckbox type=checkbox style="width:100%;"/></div>
					<div style="width:3%;"><div id=Part-Edit<%=pRow%> class=rowEdit onClick="editPart(<%=pRow%>);"></div></div>
					<div style="width:7%;" class=taRPi id=Part-Qty<%=pRow%> onKeyUp=updatePartRow(<%=pRow%>);><%=Qty%></div>
					<div style="width:12%;" class=taLPi id=Part-Manufacturer<%=pRow%>><%=Mfg%></div>
					<div style="width:15%;" class=taLPi id=Part-PartNumber<%=pRow%>><%=PN%></div>
					<%
					If useNewServicer Then
						%>
						<div style="width:38%; text-align:left;" class=taLPi id=Part-ItemDescription<%=pRow%>><%=Desc%></div>
						<div style="width:10%;" class=taRPi id=Part-Cost<%=pRow%> onKeyUp=updatePartRow(<%=pRow%>);><%=formatCurrency(Cost)%></div>
						<div style="width:12%;" class=taRPi id=Part-Total<%=pRow%>><%=formatCurrency(Cost*Qty)%></div>
						<%
						partsTotal=partsTotal+(Cost*Qty)
					Else
						Sell=((Cost*(MU+100))/100)
						%>
						<div style="width:28%; text-align:left;" class=taLPi id=Part-ItemDescription<%=pRow%>><%=Desc%></div>
						<div style="width:10%;" class=taRPi id=Part-Cost<%=pRow%> onKeyUp=updatePartRow(<%=pRow%>);><%=formatCurrency(Cost)%></div>
						<div style="width:10%;" class=taRPi id=Part-Sell<%=pRow%>><%=formatCurrency(Sell)%></div>
						<div style="width:12%;" class=taRPi id=Part-Total<%=pRow%>><%=formatCurrency(Sell*Qty)%></div>
						<%
						partsTotal=partsTotal+(Sell*Qty)
					End If
					%>
				</div>
				<%
				pRS.MoveNext
			Loop
			%>
			<script type="text/javascript">var pRow=<%=pRow%>;</script>
		</div>
	</div>
	<div id=tRowTotal class="ProjInfoListRow">
		<div style="width:90%; text-align:right; padding:0 2px 0 0;" >Total Parts:</div>
		<div style="width:10%; text-align:right; padding:0 2px 0 0;" class=total id=TotalParts><%=formatCurrency(partsTotal)%></div>
	</div>
	
	
	<div id=Junk style="width:100%;"></div>
	
	<div class="ProjInfoTitle">
		<button title="Remove Selected" style="width:auto;" onClick="deleteBidItems('laborCheckbox');"><img src="../images/delete16.PNG">delete</button>
		<!-- button title="Add Blank Labor" style="width:auto;" onClick="AddBlankLabor();"><img src="../images/plus_16.png">add blank</button -->
		<button title="Add Labor" style="width:auto;" onClick="ShowAddLabor();"><img src="../images/plus_16.png">add labor</button>
		<span class=rollUp onClick="Rollup(this,'RollUpLabor');">►</span>Labor
	</div>
	
	<div id=Labor class=ProjInfo height=32px style="height:32px; display:none; "></div>
	
	<div id=RollUpLabor class="ProjInfoList" style="display:none;">
	<div class="ProjInfoListHead">
		<div style="width:3%;"><input type="checkbox" onclick="checkAll('laborCheckbox',this.checked);"/></div>
		<div style="width:3%;"><small>Edit</small></div>
		<div style="width:4%;">Hrs</div>
		<div style="width:20%;">Labor</div>
		<%
		If useNewServicer Then
			%>
			<div style="width:50%;">Description</div>
			<div style="width:10%;">Cost</div>
			<div style="width:10%;">Totals</div>
			<%
		Else
			%>
			<div style="width:40%;">Description</div>
			<div style="width:10%;">Cost</div>
			<div style="width:10%;">Sell</div>
			<div style="width:10%;">Totals</div>
			<%
		End If
		%>
	</div>
	
	<div id=ServiceLabor>
		<%
		lSQL="SELECT BidItemsID, ItemName, ItemDescription, Qty, Cost FROM BidItems WHERE SysID="&Id&" AND Type='Labor' AND editable<>1"
		%><%'=lSQL%><%
		Set lRS=Server.CreateObject("AdoDB.RecordSet")
		lRS.Open lSQL, REDConnString
		
		lRow=0
		laborTotal=0
		Do Until lRS.EOF
			Cost=lRS("Cost")	: if Cost="" Or IsNull(Cost) Then Cost=0
			
			lRow=lRow+1
			color=""
			If lRS("Qty")<=0 Then color = "color:#C00;"
			%>
			<div id=lRow<%=lRow%> class="ProjInfoListRow" style="<%=color%> ">
				<div id=Labor-BidItemsID<%=lRow%> style="display:none;"><%=lRS("BidItemsID")%></div>
				<div style="width:3%;" align="center"><input id=lSel<%=lRow%> class="laborCheckbox" type="checkbox" style="width:100%;"/></div>
				<div style="width:3%;"><div id=Labor-Edit<%=lRow%> class=rowEdit onClick="editLabor(<%=lRow%>);"></div></div>
				<div style="width:4%;" class=taRPi id=Labor-Qty<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=lRS("Qty")%></div>
				<%="<div style=width:20%; class=taLPi id=Labor-ItemName"&lRow&">"&DecodeChars(lRS("ItemName"))&"</div>"%>
				<%
				If useNewServicer Then
					%>
					<%="<div style=""width:50%; text-align:left; text-overflow:ellipsis;"" class=taLPi id=Labor-ItemDescription"&lRow&">"&DecodeChars(lRS("ItemDescription"))&"</div>"%>
					<div style="width:10%;" class=taRPi id=Labor-Cost<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=formatCurrency(Cost)%></div>
					<div style="width:10%;" class=taRPi id=Labor-Total<%=lRow%>><%=formatCurrency(Cost*lRS("Qty"))%></div>
					<%
				Else
					Sell=((Cost*(MU+100))/100)
					%>
					<%="<div style=""width:40%; text-align:left; text-overflow:ellipsis;"" class=taLPi id=Labor-ItemDescription"&lRow&">"&DecodeChars(lRS("ItemDescription"))&"</div>"%>
					<div style="width:10%;" class=taRPi id=Labor-Cost<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=formatCurrency(Cost)%></div>
					<div style="width:10%;" class=taRPi id=Labor-Sell<%=lRow%>><%=formatCurrency(Sell)%></div>
					<div style="width:10%;" class=taRPi id=Labor-Total<%=lRow%>><%=formatCurrency(Sell*lRS("Qty"))%></div>
					<%
				End If
				%>
			</div>
			<%
			If useNewServicer Then
				laborTotal=laborTotal+(lRS("Cost")*lRS("Qty"))
			Else
				laborTotal=laborTotal+(Sell*lRS("Qty"))
			End If
			lRS.MoveNext
		Loop
		%>
		<script type="text/javascript">var lRow=<%=lRow%>;</script>
	</div>
	</div>
	<div id=tRowTotal class="ProjInfoListRow">
		<div style="width:90%; text-align:right; padding:0 2px 0 0;" >Total Labor:</div>
		<div style="width:10%; text-align:right; padding:0 2px 0 0;" class=total id=TotalLabor><%=formatCurrency(laborTotal)%></div>
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
			<button title="Add Travel" style="width:auto;" onClick="ShowAddTravel();"><img src="../images/plus_16.png">add travel</button>
			<span class=rollUp onClick="Rollup(this,'RollUpTravel');">▼</span>Travel
		</div>
		<div id=Travel class=ProjInfo height=32px style="height:32px; display:none; "></div>
		
		<div id="RollUpTravel" class="ProjInfoList">
			<div class="ProjInfoListHead">
				<div style="width:3%;"><input type="checkbox" onclick="checkAll('travelCheckbox',this.checked);"/></div>
				<div style="width:3%;"><small>Edit</small></div>
				<div style="width:7%;">Type</div>
				<div style="width:27%;">From</div>
				<div style="width:27%;">To</div>
				<div style="width:10%;">Cost/Unit</div>
				<div style="width:4%;">Qty</div>
				<div style="width:9%;">Unit</div>
				<div style="width:10%;">Totals</div>
			</div>
			
			<div id=ServiceTravel>
				<%
				tSQL="SELECT ExpenseID, SubType, Origin, Destination, Units, UnitCost FROM Expenses WHERE SysID="&Id&" AND Type LIKE 'travel' AND editable<>1 "
				%><%'=tSQL%><%
				Set tRS=Server.CreateObject("AdoDB.RecordSet")
				tRS.Open tSQL, REDConnString
				
				tRow=0
				travelTotal=0
				Do Until tRS.EOF
					
					tRow=tRow+1
					
					Cost=DecodeChars(tRS("UnitCost")): If Cost="" Or IsNull(Cost) Then Cost=0
					Qty=tRS("Units"): If Qty="" Or IsNull(Qty) Then Qty=0
					Origin=DecodeChars(trs("Origin"))
					Destination=DecodeChars(trs("Destination"))
					SubType=tRS("SubType")
					
					ttSQL="SELECT Unit FROM TravelType WHERE Type='"&SubType&"'"
					Set ttRS=Server.CreateObject("AdoDB.Recordset")
					ttRS.Open ttSQL, REDConnString
					%><%'=ttSQL%><%
					If ttRS.EOF Then Unit="Unit"  Else  Unit=ttRS("Unit")
					Set ttRS=Nothing
							
					If Qty<>1 Then Unit=Unit+"s"
					%>
					<div id=tRow<%=tRow%> class="ProjInfoListRow">
						<div id=Travel-ExpenseID<%=tRow%> style="display:none;"><%=tRS("ExpenseID")%></div>
						<div style="width:3%;" align="center"><input id=tSel<%=tRow%> class=travelCheckbox type=checkbox style=width:100%; /></div>
						<div style="width:3%;"><div id=Travel-Edit<%=tRow%> class=rowEdit onClick="editTravel(<%=tRow%>);"></div></div>
						<div style="width:7%;" id=Travel-SubType<%=tRow%>><%=tRS("SubType")%></div>
						<%="<div style=""width:27%; text-align:left; text-overflow:ellipsis; padding:0 0 0 2px;"" id=Travel-Origin"&tRow&">"&Origin&"</div>"%>
						<%="<div style=""width:27%; text-align:left; text-overflow:ellipsis; padding:0 0 0 2px;"" id=Travel-Destination"&tRow&">"&Destination&"</div>"%>
						<div style="width:10%; text-align:right; padding:0 2px 0 0;" id=Travel-Cost<%=tRow%> onKeyUp=updateTravelRow(<%=tRow%>);><%=formatCurrency(Cost)%></div>
						<div style="width:4%; text-align:right; padding:0 2px 0 0;" id=Travel-Qty<%=tRow%> onKeyUp=updateTravelRow(<%=tRow%>); ><%=Qty%></div>
						<div style="width:9%; text-align:left; padding:0 0 0 2px;" id=Travel-Unit<%=tRow%> ><%=Unit%></div>
						<div style="width:10%; text-align:right; padding:0 2px 0 0;" id=Travel-Total<%=tRow%>><%=formatCurrency(Cost*Qty)%></div>
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
			<div style="width:90%; text-align:right; padding:0 2px 0 0;" > Total Travel Expenses:</div>
			<div style="width:10%; text-align:right; padding:0 2px 0 0;" class=total id=TotalTravel><%=formatCurrency(travelTotal)%></div>
		</div>
			
		<br/>
		<br/>
		
		<!--
		<table style="float:left; margin:32px 0 0 5%; width:90%;" cellpadding=0 cellspacing=0 cols=2 >
			<tr>
				<td width="50%" style="min-width:50%;">
		-->
		<div style="float:left; width:50%; ">
					<div class="ProjInfoTitle" style="width:95%;">
						<button title="Remove Selected" style="width:auto;" onClick="deleteExpenses('equipCheckbox');"><img src="../images/delete16.PNG">delete</button>
						<button title="Add Equipment" style="width:auto;" onClick="AddBlankEquip();"><img src="../images/plus_16.png">add equipment</button>
						<span class=rollUp onClick="Rollup(this,'RollUpEquip');">▼</span>Equipment
					</div>
					
					<div id="RollUpEquip" class="ProjInfoList" style="margin:0 0 0 2%;">
						<div class="ProjInfoListHead" style="margin:0; width:95%;">
							<div style="width:6%;"><input type="checkbox" onclick="checkAll('equipCheckbox',this.checked);"/></div>
							<div style="width:6%;"><small>Edit</small></div>
							<div style="width:8%;">Qty</div>
							<div style="width:40%;">Description</div>
							<div style="width:20%;">Cost/Unit</div>
							<div style="width:20%;">Totals</div>
						</div>
						
						<div id=ServiceEquipment>
							<%
							eSQL="SELECT ExpenseID, SubType, Units, UnitCost FROM Expenses WHERE SysID="&Id&" AND Type LIKE 'Equip' AND editable<>1"
							%><%'=eSQL%><%
							Set eRS=Server.CreateObject("AdoDB.RecordSet")
							eRS.Open eSQL, REDConnString
							
							eRow=0
							equipTotal=0
							Do Until eRS.EOF
								
								eRow=eRow+1
								
								Cost=DecodeChars(eRS("UnitCost")): If Cost="" Or IsNull(Cost) Then Cost=0
								Qty=eRS("Units"): If Qty="" Or IsNull(Qty) Then Qty=0
								SubType=eRS("SubType")
								
								If Qty<>1 Then Unit=Unit+"s"
								%>
								<div id=eRow<%=eRow%> class="ProjInfoListRow" style="margin:0; width:95%;">
									<div id=Equip-ExpenseID<%=eRow%> style="display:none;"><%=eRS("ExpenseID")%></div>
									<div style="width:6%;" align="center"><input id=eSel<%=eRow%> class=equipCheckbox type=checkbox style=width:100%; /></div>
									<div style="width:6%;"><div id=Equip-Edit<%=eRow%> class=rowEdit onClick="editEquip(<%=eRow%>);"></div></div>
									<div style="width:8%;" class=taRPi id=Equip-Qty<%=eRow%> onKeyUp=updateEquipRow(<%=eRow%>); ><%=Qty%></div>
									<div style="width:40%;" class=taLPi id=Equip-Desc<%=eRow%>><%=eRS("SubType")%></div>
									<div style="width:20%;" class=taRPi id=Equip-Cost<%=eRow%> onKeyUp=updateEquipRow(<%=eRow%>);><%=formatCurrency(Cost)%></div>
									<div style="width:20%;" class=taRPi id=Equip-Total<%=eRow%>><%=formatCurrency(Cost*Qty)%></div>
								</div>
								<%
								equipTotal=equipTotal+(Cost*Qty)
								eRS.MoveNext
							Loop
							%>
							<script type="text/javascript">var eRow=<%=eRow%>;</script>
						</div>
					</div>
					<div id=tRowTotal class="ProjInfoListRow" style="width:95%; margin:0 0 0 2%;">
						<div style="width:80%; text-align:right; padding:0 2px 0 0;" >Total Equipment Expenses:</div>
						<div style="width:20%; text-align:right; padding:0 2px 0 0;" class=total id=TotalEquip><%=formatCurrency(equipTotal)%></div>
					</div>
		</div>
		<!-- 
				</td>
				<td width="50%" valign=top >			
		-->
		<div style="float:left; width:50%; ">

					<div class="ProjInfoTitle" style="width:95%;">
						<button title="Remove Selected" style="width:auto;" onClick="deleteExpenses('otherCheckbox');"><img src="../images/delete16.PNG">delete</button>
						<button title="Add Equipment" style="width:auto;" onClick="AddBlankOther();"><img src="../images/plus_16.png">add expense</button>
						<div style="max-width:48%; float:left; overflow:hidden;"><span class=rollUp onClick="Rollup(this,'RollUpOther');">▼</span>Licensing, Permits, and Miscellaneous Expenses</div>
					</div>
					
					<div id=RollUpOther class="ProjInfoList" style="margin:0 0 0 2%;">
						<div class="ProjInfoListHead" style="margin:0; width:95%;">
							<div style="width:6%;"><input type="checkbox" onclick="checkAll('otherCheckbox',this.checked);"/></div>
							<div style="width:6%;"><small>Edit</small></div>
							<div style="width:8%;">Qty</div>
							<div style="width:40%;">Description</div>
							<div style="width:20%;">Cost/Unit</div>
							<div style="width:20%;">Totals</div>
						</div>
						
						<div id=ServiceOther>
							<%
							oSQL="SELECT ExpenseID, SubType, Units, UnitCost FROM Expenses WHERE SysID="&Id&" AND Type LIKE 'OH' AND editable<>1"
							%><%'=oSQL%><%
							Set oRS=Server.CreateObject("AdoDB.RecordSet")
							oRS.Open oSQL, REDConnString
							
							oRow=0
							otherTotal=0
							Do Until oRS.EOF
								
								oRow=oRow+1
								
								Cost=DecodeChars(oRS("UnitCost")): If Cost="" Or IsNull(Cost) Then Cost=0
								Qty=oRS("Units"): If Qty="" Or IsNull(Qty) Then Qty=0
								SubType=oRS("SubType")
								
								If Qty<>1 Then Unit=Unit+"s"
								%>
								<div id=oRow<%=oRow%> class="ProjInfoListRow" style="margin:0; width:95%;">
									<div id=Other-ExpenseID<%=oRow%> style="display:none;"><%=oRS("ExpenseID")%></div>
									<div style="width:6%;" align="center"><input id=oSel<%=oRow%> class=otherCheckbox type=checkbox style=width:100%; /></div>
									<div style="width:6%;"><div id=Other-Edit<%=oRow%> class=rowEdit onClick="editOther(<%=oRow%>);"></div></div>
									<div style="width:8%;" class=taRPi id=Other-Qty<%=oRow%> onKeyUp=updateOtherRow(<%=oRow%>); ><%=Qty%></div>
									<div style="width:40%;" class=taLPi id=Other-Desc<%=oRow%>><%=oRS("SubType")%></div>
									<div style="width:20%;" class=taRPi id=Other-Cost<%=oRow%> onKeyUp=updateOtherRow(<%=oRow%>);><%=formatCurrency(Cost)%></div>
									<div style="width:20%;" class=taRPi id=Other-Total<%=oRow%>><%=formatCurrency(Cost*Qty)%></div>
								</div>
								<%
								otherTotal=otherTotal+(Cost*Qty)
								oRS.MoveNext
							Loop
							%>
							<script type="text/javascript">var oRow=<%=oRow%>;</script>
						</div>
					</div>
					<div id=tRowTotal class="ProjInfoListRow" style="width:95%; margin:0 0 0 2%;">
						<div style="width:80%; text-align:right; padding:0 2px 0 0;" >Total Other Expenses:</div>
						<div style="width:20%; text-align:right; padding:0 2px 0 0;" class=total id=TotalOther><%=formatCurrency(otherTotal)%></div>
					</div>
		<!--
				</td>
			</tr>
		</table>
		-->
		</div>
	</div>
	<div style=" float:left; height:32px; width:100%;"></div>
</div>	
<div id=PrintingPage class="tabPage">
	<!--#include file="Service/PrintingTab.asp" -->
</div>
</div>	
	<script type="text/javascript">
		Gebi('ExpTotal').innerHTML=formatCurrency(<%=travelTotal+equipTotal+otherTotal%>);
	</script>
</div>


<!--
<%

'SQL3="SELECT SystemName, SystemID FROM SystemList"
'Set rs3=Server.CreateObject("AdoDB.RecordSet")
'rs3.open SQL3, REDConnString

'Do Until rs3.EOF
'	SysName=Replace(rs3("SystemName")," ","")
	%>
	<div class="MenuBox presetList" id=<%=SysName%>Presets style="position:absolute; width:192px; z-index:100010;">
		<%
'		SQL4="SELECT ServicePresetID, ServicePresetName FROM ServicePresets WHERE ServicePresetSystemID="&rs3("SystemID")&" AND NOT(ServicePresetName LIKE '%-Empty-%')"
'		Set rs4=Server.CreateObject("AdoDB.RecordSet")
'		rs4.open SQL4, REDConnString
'		If rs4.EOF Then
			%>NONE<%
'		End If
'		Do Until rs4.EOF
			%><div class="MenuItem presetItem" onClick="LoadPreset(< %=rs4("ServicePresetID")%>,<%=sysId%>); hideMenus();">< %=rs4("ServicePresetName")%></div><%
'			rs4.MoveNext
'		Loop
		%>
	</div>
	<%
'	rs3.MoveNext
'Loop
'Set rs3=Nothing
%>
<div id=PresetMenu class=MenuBox style="position:absolute; width:144px; z-index:100100;">
	<div id=PresetMenuTitle align=center style="background:rgb(224,240,192); border-bottom:1px #aaa solid; height:14px; font-size:12px; width:100%;">
		Choose a Preset:
		<div class="smallRedXCircle" onClick="hideMenus();" style="font-size:16px; line-height:10px; height:13px; width:16px;">&times;</div>
	</div>
	<%
'	SQL3="SELECT SystemName FROM SystemList"
'	Set rs3=Server.CreateObject("AdoDB.RecordSet")
'	rs3.open SQL3, REDConnString
	
'	arrow="<span class=fL >◄</span>"
'	sI=0
'	Do Until rs3.EOF
'		sI=sI+1
'		SysName=Replace(rs3("SystemName")," ","")
		%>
			<div id=PItem<%=sI%> class="MenuItem presetItem" onClick="hidePresetLists(); showPresetList('<%=SysName%>Presets',this);">
				< %=rs3("SystemName")&arrow%>
			</div>
			<script type="text/javascript">
				if(Gebi('<%=SysName%>Presets').innerHTML.replace('NONE','')==Gebi('<%=SysName%>Presets').innerHTML) {}
				else { Gebi('PItem<%=sI%>').style.display='none'; }
			</script>
		<%
'		rs3.MoveNext
'	Loop
'	Set rs3=Nothing
	%>
	<hr style="margin:0;"/>
	<div id=PItem<%=sI+1%> class="MenuItem presetItem" onClick="parent.location='ServicePresets.asp';">Preset Editor<img class=fL src="../Images/pencil_16.png"></span></div>
	<div id=PItem<%=sI+2%> class="MenuItem presetItem" onClick="showServiceCopy();">Copy To Preset<img class=fL src="../Images/plus_16.png"></span></div>
	<hr style="margin:0;" />
	<div id=PItem<%=sI+3%> class="MenuItem presetItem" align="center"><button onClick="hideMenus();" style="width:75%;">Cancel</button></div>
</div>
-->

<div id=Menu class=MenuBox style="position:absolute; width:144px; z-index:100100;">
	<div id=MenuTitle align=center style="background:rgb(224,240,192); border-bottom:1px #aaa solid; height:14px; font-size:12px; width:100%;">System Functions</div>

	<div id=MItem class="MenuItem presetItem" onClick="showCopyService();"></div>

	<hr style="margin:0;"/>
	<div id=PItem class="MenuItem presetItem" onClick="showServiceDuplicate();">Copy System<img class=fL src="../Images/plus_16.png"></span></div>
	<div id=PItem class="MenuItem presetItem" onClick="showServiceMove();">Move System<img class=fL src="../Images/move_16.png"></span></div>
	<div id=PItem class="MenuItem presetItem" onClick="delSys();">Delete System<img class=fL src="../Images/delete16.PNG"></span></div>
	<hr style="margin:0;" />
	<div id=PItem class="MenuItem presetItem" align="center"><button onClick="hideMenus();" style="width:75%;">Cancel</button></div>
</div>
	
</body>
</html>
<!--#include file="../LMC/RED.asp" -->
<!DOCTYPE html>
<html style="height:100%; overflow:hidden;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>TMC Estimates</title>
<!--#include file="common.asp" -->

<script type="text/javascript" src="Bid/BidProject.js"></script>
<script type="text/javascript" src="Bid/BidSystemsAJAX.js"></script>

<link rel="stylesheet" href="Bid/BidProject.css" media="all">

<%
If Session("user")="" Then
	QS=request.QueryString
	If QS <> "" Then QS= "?"&QS
	Session("LoginDestination")="../TMCManagement/BidSystems.asp"&QS
	Response.Redirect("blank.html")
End If

Sql0="SELECT Estimates FROM Access WHERE UserName='"&Session("user")&"'"
Set rs0=Server.CreateObject("AdoDB.RecordSet")
rs0.Open Sql0, REDConnString

If rs0.EOF Then Response.Redirect("blank.html")
If rs0("Estimates") <> "True" Then  Response.Redirect("blank.html")
 
SysId = Request.QueryString("SysId")
If SysId="" Then
	projId=Request.QueryString("projId")
	%>
	</head>
	<%="<body>"%>
	<div id=SystemsBar class="Toolbar" style="background:none; height:24px; overflow:auto; padding:0; width:95%;">
		<button id="ReloadFrame" class="tButton24" onClick="window.location=window.location;" style="float:right; margin:0 3% 0 0;"/>
			<img src="../Images/reloadblue24.png" style="float:left; height:100%; width:100%;"/>
		</button>
		<%
		sysSQL="SELECT System, SystemID FROM Systems WHERE ProjectID="&projID
		Set sysRS=Server.createObject("Adodb.Recordset")
		sysRS.open sysSQL, REDConnstring

		Do Until sysRS.eof
			If sysRS("SystemID")=sysId Then s="font-size:16px; font-weight:bold; font-size:15px;" Else s=""
			%><a class="sysLink" onClick="parent.loadSystem(<%=sysRS("SystemID")%>);" style="<%=s%>"><%=DecodeChars(sysRS("System"))%></a><%
			sysRS.moveNext
		Loop
		%>
	</div>
	<%="</body>"%>
	</html>
	<%
	Response.end()
End If
%>


<%
	cols="System,SystemID,ProjectID,RCSNotes,Notes,EnteredBy,DateEntered,Includes,Excludes"
	cols=cols&",MU,FixedPrice,Overhead,TaxRate,ExcludeSys,TotalFixed,Round"
	SQL="SELECT "&cols&" FROM Systems WHERE SystemID="&SysID
	Set rs=Server.createObject("AdoDB.RecordSet")
	rs.Open SQL, REDConnString
	
	If rs.EOF Then 
		projId=Request.QueryString("projId")
		%>
		</head>
		This System cannot be found and was probably deleted earlier or by another user. <button onClick="history.go(-1);">Go Back</button>
		</body>
		</html>
		<%
		Response.end()
	End If
	
	projId=rs("ProjectID")
	%><span style="display:none;" id=projNo><%=projId%></span><%
	sysId=rs("SystemId")
	Notes=DecodeChars(rs("Notes"))
	System=DecodeChars(rs("System"))
	RCSNotes=DecodeChars(rs("RCSNotes"))
	Includes=DecodeChars(rs("Includes"))
	Excludes=DecodeChars(rs("Excludes"))
	IncludeSys=(rs("ExcludeSys")="False")
	MU=rs("MU") : If MU="" Or IsNull(MU) Then MU=0
	Overhead=rs("Overhead")
	
	projSQL="SELECT Use2010Bidder, Obtained FROM Projects WHERE ProjID="&projId
	Set projRS = Server.CreateObject("AdoDB.RecordSet")
	projRS.Open projSQL, REDConnString
	If projRS.EOF Then
		%>Project #<%=projId%> No longer exists. <%
	End If
	
	useNewBidder= ( projRS("Use2010Bidder")="True" )
	unb=projRS("Use2010Bidder")
	obtained=projRS("obtained") : If obtained="" OR isNull(obtained) Then obtained= "False"
	Set projRS=Nothing
	
	editLink="<a class=""editLink"" onclick=""eSysField(this.parentNode);"" >Edit</a>"
	currencyLink="<a class=""editLink"" onclick=""eSysCurrency(this.parentNode);"" >Edit</a>"
	dateLink="<a class=""editLink"" onclick=""dateSysField(this.parentNode)"" >Edit</a>"
	notesLink="<a class=editLink onClick=eSysNotes(this.parentNode);>Edit</a>"

If IsNull(System) Then System="[Untitled System]"
%>

<script type="text/javascript">
var projId=<%=projId%>;
var sysId=<%=sysId%>;
var sysName='<%=Replace(System,"'","\'")%>';
var MU=<%=MU%>;
<% 
If useNewBidder Then 
	%>var useNewBidder=true;<%
Else 
	%>var useNewBidder=false;<%
End If

obtained=lcase(obtained) : if obtained="" Then obtained="false"
IncludeSys=lcase(IncludeSys) : if IncludeSys="" Or IsNull(IncludeSys) Then IncludeSys="false"
%>
var obtained=<%=obtained%>;
var includeSys=<%=IncludeSys%>;

var editLink='<%=editLink%>';
var currencyLink='<%=currencyLink%>';
var dateLink='<%=dateLink%>';
var notesLink='<%=notesLink%>';

function sysLoad() { 
<%If session("MaterialListSortBy")<>"" Then 
	Response.Write("Rollup(Gebi('partsRollerUpper'),'RollUpParts')")
End If %>
}
</script>
</head>

<body onLoad="setTimeout('systemCost(<%=sysId%>);',500); sysLoad();" style="height:100%; overflow:hidden; " >

<div id=copyModal>
	<div id=copyWindow class="WindowBox">
		<div id=cwTitle class="WindowTitle"><span class="redXCircle" onClick="hide('copyModal')">X</span>Copy System to Preset</div>
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

<div id=dupModal>
	<div id=dupWindow class="WindowBox">
		<div id=dwTitle class="WindowTitle"><span class="redXCircle" onClick="hide('dupModal');">X</span>Move or Copy</div>
		<br/>
		&nbsp;&nbsp;&nbsp;
		<label class="fL nowrap">&nbsp;&nbsp;To Bid #&nbsp;<input id=dwProjID type="text" style="width:256px;" value="<%=ProjID%>" /></label>
		<br/>
		&nbsp;&nbsp;&nbsp;
		<label class="fL nowrap">
			&nbsp;&nbsp;Name&nbsp;
			<input id=dwSysName type="text" style="width:256px;" value="<%=System%> 2" />
		</label>
		<div id=dwBottom style="width:100%; height:32px; line-height:32px; float:left; margin:12px 0 0 0;">
			<label class="nowrap">&nbsp;&nbsp;&nbsp;<input id=dwMoveChk type="checkbox" />Delete when done (Move)&nbsp;</label>
			<button id=cwDupBidBtn style="height:95%; float:right; margin:0 1% 0 0;" onClick="dupBid();">&nbsp;<b>Go</b>&nbsp;</button>
		</div>
	</div>
</div>

<div id=Scrollbox style="height:100%; width:100%; overflow-x:hidden; overflow-y:auto; position:relative; z-index:0;">
	<br/>
	
	<div id="SysInfoTitle" class="ProjInfoTitle">
		<span class=rollUp onClick="RollupC(this,'RollUpSysInfo',this.parentNode.parentNode);">▼</span>
		System Information
	</div>
	<div id=SysInfo class=ProjInfo height="400px" style="height:400px;">
		
		<div id=RollUpSysInfo>
			<div class="labelColumn w25p">
				<label><big>System Name</big></label>
				<label>Entered By</label>
				<label>Date Created</label>
			</div>
			<div class="fieldColumn w25p">
				<div class="fieldDiv" id="System" style="font-size-adjust:.6;"><%=editLink%><%=System%></div>
				<div class="fieldDiv"><%=rs("EnteredBy")%></div>
				<div class="fieldDiv"><%=rs("DateEntered")%></div>
			</div>
			
			<div class="labelColumn w25p">
				<label style="height:72px; line-height:18px;" onDblClick="eSysNotes(Gebi('RCSNotes'));"><br/>Notes<small><br/>(Not seen by customer)<br/></small></label>
			</div>
			<div class="fieldColumn w25p">
				<div class="fieldDiv pre" id=RCSNotes style="height:72px; white-space:pre-wrap;"><%=notesLink%><%=RCSNotes%></div>
				<div id=oldNotes style="display:none;"></div>
			</div>
			
			<div class="labelColumn w25p">
				<label style="height:188px; line-height:188px;" onDblClick="eSysNotes(Gebi('Notes'));">Scope of Work</label>
			</div>
			<div class="fieldColumn w75p">
				<div class="fieldDiv pre" id=Notes style="height:188px; white-space:pre-wrap;"><%=notesLink%><%=Notes%></div>
				<div id=oldNotes style="display:none;"></div>
			</div>
			
			<div class="labelColumn w25p">
				<label style="height:138px; line-height:138px;" onDblClick="eSysNotes(Gebi('Includes'));">Includes</label>
			</div>
			<div class="fieldColumn w25p">
				<div class="fieldDiv pre" id=Includes style="height:138px; white-space:pre-wrap; text-overflow:ellipsis;"><%=notesLink%><%=Includes%></div>
				<div id=oldNotes style="display:none;"></div>
			</div>
			
			<div class="labelColumn w25p">
				<label style="height:138px; line-height:138px;" onDblClick="eSysNotes(Gebi('Excludes'));">Excludes</label>
			</div>
			<div class="fieldColumn w25p">
				<div class="fieldDiv pre" id=Excludes style="height:138px; white-space:pre-wrap;"><%=notesLink%><%=Excludes%></div>
				<div id=oldNotes style="display:none;"></div>
			</div>
		</div>
	</div>
	
	<br/>
	
	<div class="ProjInfoTitle">
		<span class=rollUp onClick="RollupC(this,'RollUpCost',this.parentNode.parentNode);">▼</span>
		<div style="float:left">System Costing</div>
	</div>
	<div id=SysCosting class=ProjInfo height="386px" style="height:386px;">
		
		
		<div id=RollUpCost>
			<div class="labelColumn w25p">
				<label>Margin</label><label for=TotalFixed>Use Fixed Price</label><label>Fixed Price</label>
				<label>Overhead</label><label>Tax Rate</label><label></label><label for=ExcludeSys>Include system in project</label>
				<label for=Round style="border-bottom:#000 1px solid;">Round up total to next $10</label>
				<%
				If useNewBidder Then
					%><label>Parts</label><label>Labor</label><%
				Else
					%>
					<label style="border:none; padding:0;">
						<label style="float:left; font-size:12px; width:40%;">Parts Cost</label>
						<div id=PartsCost class=fieldDiv style="float:left; font-size:12px; background:#fff; width:60%;"></div>
					</label>
					<label style="border:none; padding:0;">
						<label style="float:left; font-size:12px; width:40%;">Labor Cost</label>
						<div id=LaborCost class=fieldDiv style="float:left; font-size:12px; background:#fff; width:60%;"></div>
					</label>
					<%
				End If
				%>
				<label>Travel</label><label>Equipment</label>
				<label>Other Expenses</label><label>Overhead</label><label>Profit</label><label>Tax</label>
			</div>
			<div class="fieldColumn w25p" style="border-right:#000 1px solid;">
				<div class="fieldDiv" id="MU" ><%=currencyLink%><%=rs("MU")%></div>
				<%If rs("TotalFixed")="True" Then chk="checked" else chk=""%>
				<label class="fieldDiv">&nbsp; &nbsp; &nbsp; <input id=TotalFixed type=checkbox <%=chk%> onChange="eSysCheck(this.id,this.checked);" /></label>
				<div class="fieldDiv" id="FixedPrice" ><%=currencyLink%><%=rs("FixedPrice")%></div>
				<div class="fieldDiv" id="Overhead" ><%=currencyLink%><%=rs("Overhead")%></div>
				<div class="fieldDiv" id=TaxRate><%=editLink%><%=rs("TaxRate")%></div>
				<%If rs("ExcludeSys")="True" Then chk="" else chk="checked"%>
				<div class="fieldDiv" ></div>
				<label class="fieldDiv">&nbsp; &nbsp; &nbsp; <input id=ExcludeSys type=checkbox <%=chk%> onChange="eSysCheck(this.id,!this.checked);"/></label>
				<%If rs("Round")="True" AND useNewBidder Then chk="checked" else chk=""%>
				<%If useNewBidder Then dis="" else dis="disabled"%>
				<label class="fieldDiv" style="border-bottom:#000 1px solid;">&nbsp; &nbsp; &nbsp; <input id=Round type=checkbox <%=chk%> <%=dis%> onChange="eSysCheck(this.id,this.checked);" /></label>
				<%
				If useNewBidder Then
					%>
					<div id=PartsCost class=fieldDiv></div>
					<div id=LaborCost class=fieldDiv></div>
					<%
				Else
					%>
					<div class="fieldDiv" style="border:none; padding:0;"><label align=right class=fieldDiv style="float:left; font-size:12px; background:#F3F3F3; width:40%;">Parts Sell&nbsp;</label><div id=PartsSell class=fieldDiv style="float:left; font-size:12px; width:60%;"></div>
					</div>
					<div class="fieldDiv" style="border:none; padding:0;"><label align=right class=fieldDiv style="float:left; font-size:12px; background:#F3F3F3; width:40%;">Labor Sell&nbsp;</label><div id=LaborSell class=fieldDiv style="float:left; font-size:12px; width:60%;"></div>
					</div>
					<%
				End If
				%>
				<div id=TravelCost class=fieldDiv></div>
				<div id=EquipCost class=fieldDiv></div>
				<div id=OtherCost class=fieldDiv></div>
				<div id=OverheadCost class=fieldDiv></div>
				<div id=ProfitCost class=fieldDiv></div>
				<div id=TaxCost class=fieldDiv></div>
			</div>
			
			<div class="labelColumn w50p" align=center><iframe id=Graph src="" style="border:none; height:418px; width:100%;"></iframe></div>
		</div>
		<br/><br/><br/>
	</div>
	
	
	<div class="ProjInfoTitle">
		<button title="Remove Selected" style="width:auto;" onClick="deleteBidItems('partCheckbox');"><img src="../images/delete16.PNG">delete</button>
		<!-- button title="Add Blank" style="width:auto;" onClick="parent.AddBlankPart();"><img src="../images/plus_16.png">add blank</button -->
		<button title="Add Part" style="width:auto;" onClick="parent.ShowAddPart();"><img src="../images/plus_16.png">add part</button>
		<span id=partsRollerUpper class=rollUp onClick="Rollup(this,'RollUpParts');">►</span>Materials
	</div>
	<div id=Parts class=ProjInfo height="32px" style="height:32px; display:none;">
	</div>
	
	<div id=RollUpParts class="ProjInfoList" style="display:none;">
		<div class="ProjInfoListHead">
			<%
			Function ifPSort(fieldName)
				If lCase(session("MaterialListSortBy"))=lCase(fieldName) Then ifPSort="font-weight:bold;" Else ifPSort=""
			End Function
			
			Sub PSorter(fieldName)
				Response.Write("sessionWrite('MaterialListSortBy','"&fieldName&"'); location+='';")
			End Sub
			%>
			<div style="width:3%;"><input type=checkbox onclick="checkAll('partCheckbox',this.checked);"/></div>
			<div style="width:3%;"><small>Edit</small></div>
			<div style="width:7%; <%ifPSort("Qty")%>" onClick="<%PSorter("Qty")%>">Qty</div>
			<div style="width:12%; <%ifPSort("Manufacturer")%>" onClick="<%PSorter("Manufacturer")%>">Manufacturer</div>
			<div style="width:15%; <%ifPSort("ItemName")%>" onClick="<%PSorter("ItemName")%>">Part Number</div>
			<%
			If useNewBidder Then
				%>
				<div style="width:38%; <%ifPSort("ItemDescription")%>" onClick="<%PSorter("ItemDescription")%>">Description</div>
				<div style="width:10%; <%ifPSort("Cost")%>" onClick="<%PSorter("Cost")%>">Cost</div>
				<div style="width:12%; <%ifPSort("CTotal")%>" onClick="<%PSorter("CTotal")%>">Totals</div>
				<%
			Else
				%>
				<div style="width:28%; <%ifPSort("ItemDescription")%>" onClick="<%PSorter("ItemDescription")%>">Description</div>
				<div style="width:10%; <%ifPSort("Cost")%>" onClick="<%PSorter("Cost")%>">Cost</div>
				<div style="width:10%; <%ifPSort("Sell")%>" onClick="<%PSorter("Sell")%>">Sell</div>
				<div style="width:12%; <%ifPSort("STotal")%>" onClick="<%PSorter("STotal")%>">Totals</div>
				<%
			End If
			%>
		</div>
		
		<div id=BidSystemsParts>
			<%
			
			matOrder=""
			If session("MaterialListSortBy")<>"" Then matOrder=" ORDER BY "&session("MaterialListSortBy")
			pSQL="SELECT BidItemsID, Manufacturer, ItemName, ItemDescription, IsNull(Qty,0) AS Qty, IsNull(Cost,0) AS Cost, (Cost*Qty) AS CTotal, (Cost+(Cost*"&MU&")) AS Sell, (Cost+(Cost*"&MU&"))*Qty AS STotal FROM BidItems WHERE SysID="&sysId&" AND Type='Part' AND editable<>1 "&matOrder
			%><%'=pSQL%><%
			Set pRS=Server.CreateObject("AdoDB.RecordSet")
			pRS.Open pSQL, REDConnString
			
			pRow=0
			partsTotal=0
			Do Until pRS.EOF
				Cost=pRS("Cost")	
				CTotal=pRS("CTotal")
				Sell=pRS("Sell")
				STotal=pRS("Stotal")
				
				pRow=pRow+1
				
				Qty=pRS("Qty")
				if Qty="" Then Qty=0
				
				color=""
				If Qty<=0 Then color = "color:#C00 !important;"
				
				Mfg=DecodeChars(pRS("Manufacturer"))
				PN=DecodeChars(pRS("ItemName"))
				Desc=DecodeChars(pRS("ItemDescription"))
				
				%>
				<div id=pRow<%=pRow%> class="ProjInfoListRow" style="<%=color%> ">
					<div id=Part-BidItemsID<%=pRow%> style="display:none"><%=pRS("BidItemsID")%></div>
					<div style="width:3%;" align="center"><input id=pSel<%=pRow%> class=partCheckbox name=partCheckbox type=checkbox style="width:100%;"/></div>
					<div style="width:3%;"><div id=Part-Edit<%=pRow%> class=rowEdit onClick="editPart(<%=pRow%>);"></div></div>
					<div style="width:7%;" class=taRPi id=Part-Qty<%=pRow%> onKeyUp=updatePartRow(<%=pRow%>); onblur=evalBox(this); ><%=Qty%></div>
					<div style="width:12%;" class=taLPi id=Part-Manufacturer<%=pRow%>><%=Mfg%></div>
					<div style="width:15%;" class=taLPi id=Part-PartNumber<%=pRow%>><%=PN%></div>
					<%
					If useNewBidder Then
						%>
						<div style="width:38%; text-align:left;" class=taLPi id=Part-ItemDescription<%=pRow%>><%=Desc%></div>
						<div style="width:10%;" class=taRPi id=Part-Cost<%=pRow%> onKeyUp=updatePartRow(<%=pRow%>);><%=formatCurrency(Cost)%></div>
						<div style="width:12%;" class=taRPi id=Part-Total<%=pRow%>><%=formatCurrency(CTotal)%></div>
						<%
						partsTotal=partsTotal+CTotal
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
		<div style="width:88%; text-align:right; padding:0 2px 0 0;" >Total Parts:</div>
		<div style="width:12%; text-align:right; padding:0 2px 0 0;" class=total id=TotalParts><%=formatCurrency(partsTotal)%></div>
	</div>

	<div class="ProjInfoTitle ProjInfoTBottom">
		<button title="Remove Selected" style="width:auto;" onClick="deleteBidItems('partCheckbox');"><img src="../images/delete16.PNG">delete</button>
		<button title="Add Part" style="width:auto;" onClick="parent.ShowAddPart();"><img src="../images/plus_16.png">add part</button>
	</div>
	
	<div id=Junk style="width:100%;"></div>
	
	<div class="ProjInfoTitle">
		<button title="Remove Selected" style="width:auto;" onClick="deleteBidItems('laborCheckbox');"><img src="../images/delete16.PNG">delete</button>
		<!-- button title="Add Blank Labor" style="width:auto;" onClick="parent.AddBlankLabor();"><img src="../images/plus_16.png">add blank</button -->
		<button title="Add Labor" style="width:auto;" onClick="parent.ShowAddLabor();"><img src="../images/plus_16.png">add labor</button>
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
		If useNewBidder Then
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
	
	<div id=BidSystemsLabor>
		<%
		lSQL="SELECT BidItemsID, ItemName, ItemDescription, Qty, Cost FROM BidItems WHERE SysID="&sysId&" AND Type='Labor' AND editable<>1"
		%><%'=lSQL%><%
		Set lRS=Server.CreateObject("AdoDB.RecordSet")
		lRS.Open lSQL, REDConnString
		
		lRow=0
		laborTotal=0
		Do Until lRS.EOF
			Cost=lRS("Cost")	: if Cost="" Or IsNull(Cost) Then Cost=0
			
			lRow=lRow+1
			color=""
			If lRS("Qty")<=0 Then color = "color:#C00 !important;"
			%>
			<div id=lRow<%=lRow%> class="ProjInfoListRow" style="<%=color%> ">
				<div id=Labor-BidItemsID<%=lRow%> style="display:none;"><%=lRS("BidItemsID")%></div>
				<div style="width:3%;" align="center"><input id=lSel<%=lRow%> class="laborCheckbox" type="checkbox" style="width:100%;"/></div>
				<div style="width:3%;"><div id=Labor-Edit<%=lRow%> class=rowEdit onClick="editLabor(<%=lRow%>);"></div></div>
				<div style="width:4%;" class=taRPi id=Labor-Qty<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>); onblur="this.innerHTML=eval(this.innerHTML);" ><%=lRS("Qty")%></div>
				<%="<div style=width:20%; class=taLPi id=Labor-ItemName"&lRow&">"&DecodeChars(lRS("ItemName"))&"</div>"%>
				<%
				If useNewBidder Then
					%>
					<%="<div style=""width:50%; text-align:left; text-overflow:ellipsis;"" class=taLPi id=Labor-ItemDescription"&lRow&">"&DecodeChars(lRS("ItemDescription"))&"</div>"%>
					<div style="width:10%;" class=taRPi id=Labor-Cost<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>); onblur="this.innerHTML=eval(this.innerHTML);" ><%=formatCurrency(Cost)%></div>
					<div style="width:10%;" class=taRPi id=Labor-Total<%=lRow%>><%=formatCurrency(Cost*lRS("Qty"))%></div>
					<%
				Else
					Sell=((Cost*(MU+100))/100)
					%>
					<%="<div style=""width:40%; text-align:left; text-overflow:ellipsis;"" class=taLPi id=Labor-ItemDescription"&lRow&">"&DecodeChars(lRS("ItemDescription"))&"</div>"%>
					<div style="width:10%;" class=taRPi id=Labor-Cost<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>); onblur="this.innerHTML=eval(this.innerHTML);" ><%=formatCurrency(Cost)%></div>
					<div style="width:10%;" class=taRPi id=Labor-Sell<%=lRow%>><%=formatCurrency(Sell)%></div>
					<div style="width:10%;" class=taRPi id=Labor-Total<%=lRow%>><%=formatCurrency(Sell*lRS("Qty"))%></div>
					<%
				End If
				%>
			</div>
			<%
			If useNewBidder Then
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
			<button title="Add Travel" style="width:auto;" onClick="parent.ShowAddTravel();"><img src="../images/plus_16.png">add travel</button>
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
			
			<div id=BidSystemsTravel>
				<%
				tSQL="SELECT ExpenseID, SubType, Origin, Destination, Units, UnitCost FROM Expenses WHERE SysID="&sysId&" AND Type LIKE 'travel' AND editable<>1 "
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
						<div style="width:10%; text-align:right; padding:0 2px 0 0;" id=Travel-Cost<%=tRow%> onKeyUp=updateTravelRow(<%=tRow%>); onblur="this.innerHTML=eval(this.innerHTML);" ><%=formatCurrency(Cost)%></div>
						<div style="width:4%; text-align:right; padding:0 2px 0 0;" id=Travel-Qty<%=tRow%> onKeyUp=updateTravelRow(<%=tRow%>); onblur="this.innerHTML=eval(this.innerHTML);" ><%=Qty%></div>
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
						<button title="Add Equipment" style="width:auto;" onClick="parent.AddBlankEquip();"><img src="../images/plus_16.png">add equipment</button>
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
						
						<div id=BidSystemsEquipment>
							<%
							eSQL="SELECT ExpenseID, SubType, Units, UnitCost FROM Expenses WHERE SysID="&sysId&" AND Type LIKE 'Equip' AND editable<>1"
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
									<div style="width:8%;" class=taRPi id=Equip-Qty<%=eRow%> onKeyUp=updateEquipRow(<%=eRow%>); onblur="this.innerHTML=eval(this.innerHTML);" ><%=Qty%></div>
									<div style="width:40%;" class=taLPi id=Equip-Desc<%=eRow%>><%=eRS("SubType")%></div>
									<div style="width:20%;" class=taRPi id=Equip-Cost<%=eRow%> onKeyUp=updateEquipRow(<%=eRow%>); onblur="this.innerHTML=eval(this.innerHTML);" ><%=formatCurrency(Cost)%></div>
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
						<button title="Add Equipment" style="width:auto;" onClick="parent.AddBlankOther();"><img src="../images/plus_16.png">add expense</button>
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
						
						<div id=BidSystemsOther>
							<%
							oSQL="SELECT ExpenseID, SubType, Units, UnitCost FROM Expenses WHERE SysID="&sysId&" AND Type LIKE 'OH' AND editable<>1"
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
									<div style="width:8%;" class=taRPi id=Other-Qty<%=oRow%> onKeyUp=updateOtherRow(<%=oRow%>); onblur="this.innerHTML=eval(this.innerHTML);" ><%=Qty%></div>
									<div style="width:40%;" class=taLPi id=Other-Desc<%=oRow%>><%=oRS("SubType")%></div>
									<div style="width:20%;" class=taRPi id=Other-Cost<%=oRow%> onKeyUp=updateOtherRow(<%=oRow%>); onblur="this.innerHTML=eval(this.innerHTML);" ><%=formatCurrency(Cost)%></div>
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
	<script type="text/javascript">
		Gebi('ExpTotal').innerHTML=formatCurrency(<%=travelTotal+equipTotal+otherTotal%>);
	</script>
</div>

<div id=SystemsBar class="Toolbar">
	<div id=sysBarRight style="float:right; width:13%; z-index:100;">
		<button id=ReloadFrame class=tButton24 onClick="window.location=window.location;" style="float:right; margin:3px 1% 0 0; position:relative; "/>
			<img src="../Images/reloadblue24.png" style="float:left; height:20px; margin:0; width:20px;"/>
			<div style="float:left; font-size:16px;">&nbsp;Reload: <%=System%></div>
		</button>
		<button id=PresetsButton class=tButton0x24 onClick="showPresetMenu(this);" style="float:left; margin:3px 1% 0 0; width:80px;"/>
			<big style="float:left; height:20px; position:relative; top:-2px; width:20px;"><big>&nbsp;▼&nbsp;</big></big>
			<div style="float:left; font-size:16px;">&nbsp;Presets</div>
		</button>
	</div>
	<div id=SystemTotal class=total title="Total for <%=System%>" align=right style=" width:25%;"></div>
	<button id=MenuButton class=tButton0x24 onClick="showMenu(this);" style="float:left; margin:3px 1% 0 0; width:24px;"/>
		<big style="float:left; height:20px; position:relative; top:-2px; width:20px;"><big>&nbsp;▼&nbsp;</big></big>
	</button>
	<small style="float:left; padding:5px 0 0 0; width:7%;"><b>Systems:</b></small>
	<div id=systemLinkList >
		<select id=systemList onChange="parent.loadSystem(SelI(this.id).value);" style="width:100%; font-size:18px; opacity:.6;"> 
		<%
		SQL1="SELECT System, SystemID FROM Systems WHERE ProjectID="&projId
		Set rs1=Server.createObject("Adodb.Recordset")
		rs1.open SQL1, REDConnstring
		
		Do Until rs1.eof
			If rs1("SystemID")=sysId Then 
				s="font-size:16px; font-weight:bold; font-size:15px;"
				selected="selected"
			else 
				selected=""
				s=""
			End If
			'% ><a class="sysLink" onClick="parent.loadSystem(<%=rs1("SystemID")% >);" style="<%=s% >"><%=DecodeChars(rs1("System"))% ></a><%
			%><option class="sysLink" value="<%=rs1("SystemID")%>" style="<%=s%>" <%=selected%>><%=DecodeChars(rs1("System"))%></option><%
			rs1.moveNext
		Loop
		Set rs1=Nothing
		%>
		</select>
	</div>
	<!-- Finish this up sometime soon.
	<span class="fL">&nbsp;</span>
	<div class="ToolbarButton fL" title="Delete this system" onclick="delSys();"><img src="../Images/delete.PNG" height="100%" /></div>
	-->
</div>

<%

SQL3="SELECT SystemName, SystemID FROM SystemList"
Set rs3=Server.CreateObject("AdoDB.RecordSet")
rs3.open SQL3, REDConnString

Do Until rs3.EOF
	SysName=Replace(rs3("SystemName")," ","")
	%>
	<div class="MenuBox presetList" id=<%=SysName%>Presets style="position:absolute; width:192px; z-index:100010;">
		<%
		SQL4="SELECT BidPresetID, BidPresetName FROM BidPresets WHERE BidPresetSystemID="&rs3("SystemID")&" AND NOT(BidPresetName LIKE '%-Empty-%')"
		Set rs4=Server.CreateObject("AdoDB.RecordSet")
		rs4.open SQL4, REDConnString
		If rs4.EOF Then
			%>NONE<%
		End If
		Do Until rs4.EOF
			%><div class="MenuItem presetItem" onClick="LoadPreset(<%=rs4("BidPresetID")%>,<%=sysId%>); hideMenus();"><%=rs4("BidPresetName")%></div><%
			rs4.MoveNext
		Loop
		%>
	</div>
	<%
	rs3.MoveNext
Loop
Set rs3=Nothing
%>
<div id=PresetMenu class=MenuBox style="position:absolute; width:144px; z-index:100100;">
	<div id=PresetMenuTitle align=center style="background:rgb(224,240,192); border-bottom:1px #aaa solid; height:14px; font-size:12px; width:100%;">
		Choose a Preset:
		<div class="smallRedXCircle" onClick="hideMenus();" style="font-size:16px; line-height:10px; height:13px; width:16px;">&times;</div>
	</div>
	<%
	SQL3="SELECT SystemName FROM SystemList"
	Set rs3=Server.CreateObject("AdoDB.RecordSet")
	rs3.open SQL3, REDConnString
	
	arrow="<span class=fL >◄</span>"
	sI=0
	Do Until rs3.EOF
		sI=sI+1
		SysName=Replace(rs3("SystemName")," ","")
		%>
			<div id=PItem<%=sI%> class="MenuItem presetItem" onClick="hidePresetLists(); showPresetList('<%=SysName%>Presets',this);">
				<%=rs3("SystemName")&arrow%>
			</div>
			<script type="text/javascript">
				if(Gebi('<%=SysName%>Presets').innerHTML.replace('NONE','')==Gebi('<%=SysName%>Presets').innerHTML) {}
				else { Gebi('PItem<%=sI%>').style.display='none'; }
			</script>
		<%
		rs3.MoveNext
	Loop
	Set rs3=Nothing
	%>
	<hr style="margin:0;"/>
	<div id=PItem<%=sI+1%> class="MenuItem presetItem" onClick="parent.location='BidPresets.asp';">Preset Editor<img class=fL src="../Images/pencil_16.png"></span></div>
	<div id=PItem<%=sI+2%> class="MenuItem presetItem" onClick="showBidCopy();">Copy To Preset<img class=fL src="../Images/plus_16.png"></span></div>
	<hr style="margin:0;" />
	<div id=PItem<%=sI+3%> class="MenuItem presetItem" align="center"><button onClick="hideMenus();" style="width:75%;">Cancel</button></div>
</div>

<div id=Menu class=MenuBox style="position:absolute; width:144px; z-index:100100;">
	<div id=MenuTitle align=center style="background:rgb(224,240,192); border-bottom:1px #aaa solid; height:14px; font-size:12px; width:100%;">System Functions</div>

	<div id=MItem class="MenuItem presetItem" onClick="showCopyBid();"></div>

	<hr style="margin:0;"/>
	<div id=PItem class="MenuItem presetItem" onClick="showBidDuplicate();">Copy System<img class=fL src="../Images/plus_16.png"></span></div>
	<div id=PItem class="MenuItem presetItem" onClick="showBidMove();">Move System<img class=fL src="../Images/move_16.png"></span></div>
	<div id=PItem class="MenuItem presetItem" onClick="delSys(<%=sysId%>);">Delete System<img class=fL src="../Images/delete16.PNG"></span></div>
	<hr style="margin:0;" />
	<div id=PItem class="MenuItem presetItem" align="center"><button onClick="hideMenus();" style="width:75%;">Cancel</button></div>
</div>
	
</body>
</html>
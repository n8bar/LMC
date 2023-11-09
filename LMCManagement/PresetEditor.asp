<!--#include file="../LMC/RED.asp" -->
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Bid Preset Editor</title>
	<!--#include file="Common.asp" -->
	
	<link rel=stylesheet href=Bid/BidPresets.css media=all>
	<link rel=stylesheet href=Bid/BidProject.css media=all>
	
	<script type="text/javascript" src=Bid/PresetEditor.js ></script>
</head>

<body style="overflow-x:hidden; overflow-y:auto; ">

<div id=Modal onMouseMove="ModalMouseMove(event,'AddPartContainer');" align="center">
	<div style="width:100%; height:30%;"></div>
	<img src=../Images/roller.gif /><br/>
	<div id=modalStatus></div>
</div>

<div id="AddPartContainer" style="border-radius:8px; left:.5%; overflow:hidden; position:absolute; top:3%;"> 
	<div id="AddPartTitle" onselectstart="return false;" >PARTS LIST SEARCH</div>
	<iframe id="AddPartBox" class="AddPartBox" src="PartsInterface.asp?BoxID=AddPartContainer&ModalID=Modal"></iframe>
</div>

<div id="AddLaborContainer" style="border-radius:8px; left:.5%; overflow:hidden; position:absolute; top:3%;"> 
	<div id="AddPartTitle" onselectstart="return false;" >LABOR SEARCH</div>
	<iframe id="AddPartBox" class="AddPartBox" src="LaborInterface.asp?BoxID=AddLaborContainer&ModalID=Modal"></iframe>
</div>

<%
pId=Request.QueryString("id")
If pId="" Then Response.End 
Key="BidPresetID"
If len(pId)>8 Then Key="creationKey" 'if its longer than 8 chars, it must be a creationKey.

editLink="<a class=""editLink"" style=""z-index:10000;"" onclick=""editField(this.parentNode);"" >Edit</a>"
notesLink="<a class=editLink onClick=editNotes(this.parentNode);>Edit</a>"

SQL="SELECT BidPresetID, BidPresetSectionID, BidPresetSection, BidPresetName, Scope, Includes, Excludes FROM BidPresets WHERE "&Key&"='"&pId&"'"
'% ><%=SQL% ><%
Set rs=Server.CreateObject("AdoDB.Recordset")
rs.Open SQL, REDConnString
If rs.EOF Then 
	%>
	<br>Preset has been deleted.<br><br>
	creationKey:<%=cK%><br>
	BidPresetID:<%=pId%>
	<%
	Response.End()
End If
pId=rs("BidPresetID")
pName=DecodeChars(rs("BidPresetName"))
secId=rs("BidPresetSectionID")
%>
<script>var pId=<%=pId%>;</script>
	<button class="tButton24" style="float:right; margin:8px 12px 0 0; width:auto;" onClick="window.location=window.location;" title="Reload <%=pName%>"/><img src="../Images/reloadblue24.png" style="height:12px; width:12px;" /><small>&nbsp; Reload <%=pName%></small></button>

<div id="ProjInfoTitle" class="ProjInfoTitle" style="margin-top:4px;">
	<div style=float:left;>Preset Information</div>
	<div id=ProjectTotal class=total style="font-size:32px; float:right; line-height:20px; margin-right:8px;"></div>
</div>
<div id=ProjInfo class=ProjInfo height=146px style="height:146px;" >
	<div class="labelColumn w20p">
		<label><big>Preset Name</big> </label>
	</div>
	<div class="fieldColumn w30p">
		<div class=fieldDiv id="BidPresetName" style="z-index:0;"><%=editLink%><div><%=pName%></div></div>
	</div>
	<div class="labelColumn w20p">
		<label>Section Type</label>
	</div>
	<div class="fieldColumn w30p">
		<select class=fieldDiv id=BidPresetSection onFocus="b4secChange();" onChange="sectionChange(); //if(SelI(this.id).value==0){parent.showNewSec();}">
			<%
			SQL1="SELECT SectionID, SectionName FROM SectionList ORDER BY SectionName"
			Set rs1=Server.CreateObject("AdoDB.Recordset")
			rs1.Open SQL1, REDConnString
			Do Until rs1.EOF
				selected=""
				If secId=rs1("SectionID") Then selected="selected"
				%><option value=<%=rs1("SectionID")&" "&selected%> ><%=rs1("SectionName")%></option><%
				rs1.MoveNext
			Loop
			%>
			<!-- option id=0 value="0" style="font-size:18px; text-align:center;"> &nbsp; Add a new section type &nbsp; </option -->
		</select>
	</div>
	<div class="labelColumn w20p" >
		<label style="height:48px; line-height:48px;">Scope</label>
	</div>
	<div id="oldNotes" style="display:none;"></div>
	<div class="fieldColumn w80p" >
		<div class=fieldDiv style="height:48px;" id=Scope ><%=notesLink%><%=DecodeChars(rs("Scope"))%></div>
	</div>
	
	<div class="labelColumn w20p" >
		<label style="height:72px; line-height:72px;">Includes</label>
	</div>
	<div class="fieldColumn w30p" >
		<div class=fieldDiv style="height:72px;" id=Includes ><%=notesLink%><%=DecodeChars(rs("Includes"))%></div>
	</div>
	
	<div class="labelColumn w20p" >
		<label style="height:72px; line-height:72px;">Excludes</label>
	</div>
	<div class="fieldColumn w30p" >
		<div class=fieldDiv style="height:72px;" id=Excludes ><%=notesLink%><%=DecodeChars(rs("Excludes"))%></div>
	</div>
	
</div>


<div class="ProjInfoTitle">
	<button title="Remove Selected" style="width:auto;" onClick="deleteBidItems('partCheckbox');"><img src="../images/delete16.PNG">delete</button>
	<button title="Add Part" style="width:auto;" onClick="ShowAddPart();"><img src="../images/plus_16.png">add part</button>
	<span class=rollUp onClick="Rollup(this,'RollUpParts');">▼</span>Materials
</div>
	
<div id=RollUpParts class="ProjInfoList" style="display:block;">

	<div class="ProjInfoListHead">
		<div style="width:4%;" ><input type=checkbox onclick="checkAll('partCheckbox',this.checked);"/></div>
		<div style="width:4%;" ><small>Edit</small></div>
		<div style="width:7%;" >Qty</div>
		<div style="width:15%;" >Manufacturer</div>
		<div style="width:17%;" >Part Number</div>
		<div style="width:40%;" >Description</div>
		<div style="width:13%;" >Unit Cost</div>
	</div>

	<div id=BidSectionsParts>
		<%
		pSQL="SELECT BidPresetItemsID, ItemID, Qty FROM BidPresetItems WHERE BidPresetID="&pId&" AND Type='Part'"
		%><%'=pSQL%><%
		Set pRS=Server.CreateObject("AdoDB.RecordSet")
		pRS.Open pSQL, REDConnString
		
		pRow=0
		partsTotal=0
		Do Until pRS.EOF
			
			pRow=pRow+1
			
			color=""
			Qty=pRS("Qty") : If Qty="" Then Qty=0
			If Qty<=1 Then 
				color = "color:#400;"
			End If
			If Qty<=0 Then 
				color = "color:#C00;"
				Qty=0
			End If
			
			itemID=pRS("ItemID")
			
			if isNull(itemID) or ItemID="" Then 
				Cost="999999.99"'pRS2("Cost")	
				'Mfg=DecodeChars(pRS2("Manufacturer"))
				PN="Deleted Part Error"'DecodeChars(pRS2("PartNumber"))
				Desc="If this was copied, please refer to the original bid.  Sorry for the inconvenience."'DecodeChars(pRS2("Description"))
				'presetItemsID=pRS("BidPresetItemsID")
			Else	
				pSQL2="SELECT Manufacturer, PartNumber, Description, Cost FROM Parts WHERE PartsID="&pRS("ItemID")
				%><%'=pSQL2%><%
				Set pRS2=Server.CreateObject("AdoDB.RecordSet")
				pRS2.Open pSQL2, REDConnString
				
				Cost=pRS2("Cost")	
				Mfg=DecodeChars(pRS2("Manufacturer"))
				PN=DecodeChars(pRS2("PartNumber"))
				Desc=DecodeChars(pRS2("Description"))
				presetItemsID=pRS("BidPresetItemsID")
			End If
			%>
			<div id=pRow<%=pRow%> class="ProjInfoListRow" style="<%=color%> ">
				<div id=Part-BidPresetItemsID<%=pRow%> style="display:none;"><%=presetItemsID%></div>
				<div style="width:4%;" align="center"><input id=pSel<%=pRow%> class=partCheckbox name=partCheckbox type=checkbox style="width:100%;"/></div>
				<div style="width:4%;"><div id=Part-Edit<%=pRow%> class=rowEdit onClick="editPart(<%=pRow%>);"></div></div>
				<div style="width:7%;" class=taRPi id=Part-Qty<%=pRow%> onKeyUp=updatePartRow(<%=pRow%>);><%=Qty%></div>
				<div style="width:15%;" class=taLPi id=Part-Manufacturer<%=pRow%>><%=Mfg%></div>
				<div style="width:17%;" class=taLPi id=Part-PartNumber<%=pRow%>><%=PN%></div>

				<div style="width:40%; text-align:left;" class=taLPi id=Part-Description<%=pRow%>><%=Desc%></div>
				<div style="width:13%;" class=taRPi id=Part-Cost<%=pRow%> onKeyUp=updatePartRow(<%=pRow%>);><%=formatCurrency(Cost)%></div>
			</div>
			<%
			'partsTotal=partsTotal+(pRS2("Cost")*Qty)
			partsTotal=partsTotal+(Qty)
			pRS.MoveNext
		Loop
		%>
		<script type="text/javascript">var pRow=<%=pRow%>;</script>
	</div>
</div>
<div id=tRowTotal class="ProjInfoListRow" style="display:none;">
	<div style="width:13%; text-align:right; padding:0 2px 0 0;" ><span id=partsTotal><%=partsTotal%></span> Items</div>
	<div style="width:87%; text-align:right; padding:0 2px 0 0;" ></div>
	<!-- <div style="width:10%; text-align:right; padding:0 2px 0 0;" class=total id=TotalParts>< %=formatCurrency(partsTotal)%></div> -->
</div>


<div id=Junk style="width:100%;"></div>

<div class="ProjInfoTitle">
	<button title="Remove Selected" style="width:auto;" onClick="deleteBidItems('laborCheckbox');"><img src="../images/delete16.PNG">delete</button>
	<button title="Add Labor" style="width:auto;" onClick="ShowAddLabor();"><img src="../images/plus_16.png">add labor</button>
	<span class=rollUp onClick="Rollup(this,'RollUpLabor');">▼</span>Labor
</div>

<div id=RollUpLabor class="ProjInfoList" style="display:block;">
<div class="ProjInfoListHead">
	<div style="width:4%;"><input type="checkbox" onclick="checkAll('laborCheckbox',this.checked);"/></div>
	<div style="width:4%;"><small>Edit</small></div>
	<div style="width:5%;">Hrs</div>
	<div style="width:27%;">Labor</div>
	<div style="width:50%;">Description</div>
	<div style="width:10%;">Cost</div>
</div>

<div id=BidSectionsLabor>
	<%
	lSQL="SELECT BidPresetItemsID, ItemID, Qty FROM BidPresetItems WHERE BidPresetID="&pId&" AND Type='Labor'"
	%><%'=lSQL%><%
	Set lRS=Server.CreateObject("AdoDB.RecordSet")
	lRS.Open lSQL, REDConnString
	
	lRow=0
	laborTotal=0
	Do Until lRS.EOF
		lSQL2="SELECT Name, Description, RateCost FROM Labor WHERE LaborID="&lRS("ItemID")
		%><%'=lSQL2%><%
		Set lRS2=Server.CreateObject("AdoDB.RecordSet")
		lRS2.Open lSQL2, REDConnString
		
		if Not lRS2.EOF Then

			Cost=lRS2("RateCost")	
	
			lRow=lRow+1
			color=""
			Qty=lRS("Qty") : If Qty="" Then Qty=0
			If Qty<=1 Then 
				color = "color:#400;"
			End If
			If Qty<=0 Then 
				color = "color:#C00;"
				Qty=0
			End If
			%>
			<div id=lRow<%=lRow%> class="ProjInfoListRow" style="<%=color%> ">
				<div id=Labor-BidPresetItemsID<%=lRow%> style="display:none;"><%=lRS("BidPresetItemsID")%></div>
				<div style="width:4%;" align="center"><input id=lSel<%=lRow%> class="laborCheckbox" type="checkbox" style="width:100%;"/></div>
				<div style="width:4%;"><div id=Labor-Edit<%=lRow%> class=rowEdit onClick="editLabor(<%=lRow%>);"></div></div>
				<div style="width:5%;" class=taRPi id=Labor-Qty<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=Qty%></div>
				<%="<div style=width:27%; class=taLPi id=Labor-Name"&lRow&">"&DecodeChars(lRS2("Name"))&"</div>"%>
				<%="<div style=""width:50%; text-align:left; text-overflow:ellipsis;"" class=taLPi id=Labor-Description"&lRow&">"&DecodeChars(lRS2("Description"))&"</div>"%>
				<div style="width:10%;" class=taRPi id=Labor-RateCost<%=lRow%> onKeyUp=updateLaborRow(<%=lRow%>);><%=formatCurrency(Cost)%></div>
			</div>
			<%
			laborTotal=laborTotal+Qty
		End If
		lRS.MoveNext
	Loop
	%>
	<script type="text/javascript">var lRow=<%=lRow%>;</script>
</div>
</div>
<div id=tRowTotal class="ProjInfoListRow" style="display:none;">
	<div style="width:18%; text-align:right; padding:0 2px 0 0;" ><span id=laborTotal ><%=laborTotal%></span> total hours</div>
	<div style="width:82%; text-align:right; padding:0 2px 0 0;" ></div>
</div>

<br />
<br />
<br />
<div style="float:left; width:100%; height:48px;"></div>

<% Response.End() %>
<!--
<div class="ProjInfoSingle">
	<span>&nbsp; &nbsp;<big class=rollUp style="margin:6px 0 0 1%;" onClick="Rollup(this,'RollUpExpenses');">►</big></span>
	<div class="ProjInfoSingleTitle">Expenses</div>
	<div style="margin:0 0 0 10%; text-align:left; width:10%;"> Total:&nbsp;<big id=ExpTotal class=total>0</big></div>
</div>
<div class="fadeToWhite"></div>
<div id=RollUpExpenses style="display:none;">
	<div id=Travel class=ProjInfo height=32px style="height:32px; ">
		<div class="ProjInfoTitle">
			<button title="Remove Selected" style="width:auto;" onClick="deleteExpenses('travelCheckbox');"><img src="../images/delete16.PNG">delete</button>
			<button title="Add Travel" style="width:auto;" onClick="parent.ShowAddTravel();"><img src="../images/plus_16.png">add travel</button>
			<span class=rollUp onClick="Rollup(this,'RollUpTravel');">▼</span>Travel
		</div>
	</div>
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
		
		<div id=BidSectionsTravel>
			< %
			tSQL="SELECT ExpenseID, SubType, Origin, Destination, Units, UnitCost FROM Expenses WHERE SecID="&secId&" AND Type='Travel'"
			%>< %'=tSQL%>< %
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
				If ttRS.EOF Then Unit="Unit"  Else  Unit=ttRS("Unit")
				Set ttRS=Nothing
						
				If Qty<>1 Then Unit=Unit+"s"
				%>
				<div id=tRow< %=tRow%> class="ProjInfoListRow">
					<div id=Travel-ExpenseID< %=tRow%> style="display:none;">< %=tRS("ExpenseID")%></div>
					<div style="width:3%;" align="center"><input id=tSel< %=tRow%> class=travelCheckbox type=checkbox style=width:100%; /></div>
					<div style="width:3%;"><div id=Travel-Edit< %=tRow%> class=rowEdit onClick="editTravel(< %=tRow%>);"></div></div>
					<div style="width:7%;" id=Travel-SubType< %=tRow%>>< %=tRS("SubType")%></div>
					< %="<div style=""width:27%; text-align:left; text-overflow:ellipsis; padding:0 0 0 2px;"" id=Travel-Origin"&tRow&">"&Origin&"</div>"%>
					< %="<div style=""width:27%; text-align:left; text-overflow:ellipsis; padding:0 0 0 2px;"" id=Travel-Destination"&tRow&">"&Destination&"</div>"%>
					<div style="width:10%; text-align:right; padding:0 2px 0 0;" id=Travel-Cost< %=tRow%> onKeyUp=updateTravelRow(< %=tRow%>);>< %=formatCurrency(Cost)%></div>
					<div style="width:4%; text-align:right; padding:0 2px 0 0;" id=Travel-Qty< %=tRow%> onKeyUp=updateTravelRow(< %=tRow%>); >< %=Qty%></div>
					<div style="width:9%; text-align:left; padding:0 0 0 2px;" id=Travel-Unit< %=tRow%> >< %=Unit%></div>
					<div style="width:10%; text-align:right; padding:0 2px 0 0;" id=Travel-Total< %=tRow%>>< %=formatCurrency(Cost*Qty)%></div>
				</div>
				< %
				travelTotal=travelTotal+(Cost*Qty)
				tRS.MoveNext
			Loop
			%>
			<script type="text/javascript">
				var tRow=< %=tRow%>;
			</script>
		</div>
	</div>
	<div id=tRowTotal class="ProjInfoListRow">
		<div style="width:90%; text-align:right; padding:0 2px 0 0;" >Total Travel Expenses:</div>
		<div style="width:10%; text-align:right; padding:0 2px 0 0;" class=total id=TotalTravel>< %=formatCurrency(travelTotal)%></div>
	</div>
		
	<br/>
	<br/>
	
	<table style="float:left; margin:32px 0 0 5%; width:90%;" cellpadding=0 cellspacing=0 cols=2 >
		<tr>
			<td width="50%" style="min-width:50%;">
				<div id=Equip class=ProjInfo height=32px style="height:32px; margin:0; width:95%;">
					<div class="ProjInfoTitle">
						<button title="Remove Selected" style="width:auto;" onClick="deleteExpenses('equipCheckbox');"><img src="../images/delete16.PNG">delete</button>
						<button title="Add Equipment" style="width:auto;" onClick="parent.AddBlankEquip();"><img src="../images/plus_16.png">add equipment</button>
						<span class=rollUp onClick="Rollup(this,'RollUpEquip');">▼</span>Equipment
					</div>
				</div>
				<div id="RollUpEquip" class="ProjInfoList">
					<div class="ProjInfoListHead" style="margin:0; width:95%;">
						<div style="width:6%;"><input type="checkbox" onclick="checkAll('equipCheckbox',this.checked);"/></div>
						<div style="width:6%;"><small>Edit</small></div>
						<div style="width:8%;">Qty</div>
						<div style="width:40%;">Description</div>
						<div style="width:20%;">Cost/Unit</div>
						<div style="width:20%;">Totals</div>
					</div>
					
					<div id=BidSectionsEquipment>
						< %
						eSQL="SELECT ExpenseID, SubType, Units, UnitCost FROM Expenses WHERE SecID="&secId&" AND Type='Equip'"
						%>< %'=eSQL%>< %
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
							< %
							equipTotal=equipTotal+(Cost*Qty)
							eRS.MoveNext
						Loop
						%>
						<script type="text/javascript">var eRow=<%=eRow%>;</script>
					</div>
				</div>
				<div id=tRowTotal class="ProjInfoListRow" style="margin:0; width:95%;">
					<div style="width:80%; text-align:right; padding:0 2px 0 0;" >Total Equipment Expenses:</div>
					<div style="width:20%; text-align:right; padding:0 2px 0 0;" class=total id=TotalEquip><%=formatCurrency(equipTotal)%></div>
				</div>
			</td>
			<td width="50%" valign="top">			
				<div id=Other class=ProjInfo height=32px style="height:32px; margin:0; width:95%; ">
					<div class="ProjInfoTitle">
						<button title="Remove Selected" style="width:auto;" onClick="deleteExpenses('otherCheckbox');"><img src="../images/delete16.PNG">delete</button>
						<button title="Add Equipment" style="width:auto;" onClick="parent.AddBlankOther();"><img src="../images/plus_16.png">add expense</button>
						<div style="max-width:48%; float:left; overflow:hidden;"><span class=rollUp onClick="Rollup(this,'RollUpOther');">▼</span>Licensing, Permits, and Miscellaneous Expenses</div>
					</div>
				</div>
				<div id=RollUpOther class="ProjInfoList">
					<div class="ProjInfoListHead" style="margin:0; width:95%;">
						<div style="width:6%;"><input type="checkbox" onclick="checkAll('otherCheckbox',this.checked);"/></div>
						<div style="width:6%;"><small>Edit</small></div>
						<div style="width:8%;">Qty</div>
						<div style="width:40%;">Description</div>
						<div style="width:20%;">Cost/Unit</div>
						<div style="width:20%;">Totals</div>
					</div>
					
					<div id=BidSectionsOther>
						< %
						oSQL="SELECT ExpenseID, SubType, Units, UnitCost FROM Expenses WHERE SecID="&secId&" AND Type='OH'"
						%>< %'=oSQL%>< %
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
								<div style="width:40%;" class=taLPi id=Other-Desc< %=oRow%>><%=oRS("SubType")%></div>
								<div style="width:20%;" class=taRPi id=Other-Cost< %=oRow%> onKeyUp=updateOtherRow(<%=oRow%>);><%=formatCurrency(Cost)%></div>
								<div style="width:20%;" class=taRPi id=Other-Total< %=oRow%>><%=formatCurrency(Cost*Qty)%></div>
							</div>
							< %
							otherTotal=otherTotal+(Cost*Qty)
							oRS.MoveNext
						Loop
						%>
						<script type="text/javascript">var oRow=< %=oRow%>;</script>
					</div>
				</div>
				<div id=tRowTotal class="ProjInfoListRow" style="margin:0; width:95%;">
					<div style="width:80%; text-align:right; padding:0 2px 0 0;" >Total Other Expenses:</div>
					<div style="width:20%; text-align:right; padding:0 2px 0 0;" class=total id=TotalOther>< %=formatCurrency(otherTotal)%></div>
				</div>
			</td>
		</tr>
	</table>
</div>
<div style=" float:left; height:32px; width:100%;"></div>
<script type="text/javascript">
	Gebi('ExpTotal').innerHTML=formatCurrency(< %=travelTotal+equipTotal+otherTotal%>);
</script>
-->

</body>
</html>
<!DOCTYPE html>
<html style="overflow-x:auto;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Admin</title>

<!--#include file="Common.asp" -->

<SCRIPT type="text/javascript" src="Library/dhtmlgoodies_calendar.js?random=20060118"></script>
<script>
function resize() {
	var titleH=(Gebi('listToolbar').offsetHeight);
	Gebi('listToolbar').style.fontSize=(titleH-(titleH/2.5))+'px';	
	with (Gebi('listToolbar').style) { lineHeight=fontSize };	
	with (Gebi('ListHead')) { style.lineHeight=offsetHeight+'px'; }
}
</script>

<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">
<link type="text/css" rel=stylesheet href="Library/ListsCommon.css" media="all"/>
<link type="text/css" rel=stylesheet href="Materials/Inventory.css" media="all"/>
<style>
	
</style>
</head>
<body style="background:#fff; min-width:1024px;" onResize="resize();" onLoad="Gebi('totalBox').innerHTML=Gebi('bottomTotal').innerHTML; resize();">

<div id="ListBody" align="center" >
	<div id="listToolbar" class="Toolbar" ondblclick="Gebi('hiddenSQLRabbit').style.display='block';">
		<big><big><big>Inventory</big></big></big>
		<big id=totalBox style="float:right; font-family:Consolas, 'Courier New', Courier, monospace"></big>
		<!--
		<button id="delBids" class="tButton0x24" onclick="delBids();" title="Delete Selected Projects">
			<span><img src="../Images/delete.png" style="float:left; height:22px; width:22px;"></span>
			<span style="float:left; font-size:15px; height:100%;">Delete&nbsp;</span>
		</button>
		<!--
		<div class="tSpacer1">&nbsp;</div>
		<button id="editBids" class="tButton0x24" onClick="editBids();" title="Edit multiple bids simultaneously." />
			<span><img src="../Images/pencil_16.png" style="float:left; height:22px; width:22px;"/></span>
			<span style="float:left; font-size:15px; height:100%;">&nbsp;Mass Edit&nbsp;</span>
		</button>
		-->	
		<!--
		
		<select id="selShowBids" onchange="selShowBids_Change(this);" style="">
			<option value="All">All Bids</option>
			<option value="Recent" selected="">Recent Bids</option>
			<option value="Open">Open Bids</option>
			<option value="Closed">Closed Bids</option>
			<option value="Won">Won Bids</option>
			<option value="Lost">Lost Bids</option>
		</select>
		<label for="selShowBids" style="float:right; margin:5px 0 0 0;">Show&nbsp;</label>	
		-->
	</div>
		
	<div id=ListHead>
		<div class="pIdW taC" ><span class=hColSort id=PartsID onClick="sortBy(this);" >Part ID#</span></div>
		<div class="mfrW taC" ><span class=hColumn id=Manufacturer onClick="sortBy(this);" >Manufacturer</span></div>
		<div class="modelW taC" ><span class=hColumn id=Model onClick="sortBy(this);" >Name/Model</span></div>
		<div class="PNW taC" ><span class=hColumn id=PartNumber onClick="sortBy(this);" >Part Number</span></div>
		<div class="qtyW taC" ><span class=hColumn id=LaborValue onClick="sortBy(this);" >In Stock</span></div>
		<div class="costW taC" ><span class=hColumn id=Cost onClick="sortBy(this);" >Cost</span></div>
		<div class="totalW taC" ><span class=hColumn id=Cost onClick="sortBy(this);" >Total</span></div>
		<div class=endW>&nbsp;</div>
		<!-- div class="descriptionW taC" ><span class=hColumn id=Vendor1 onClick="sortBy(this);" >Description</span></div -->
	</div>

	<div id="LItemsContainer">
		<div class=row id=emptyRow style="border:none; height:6px;"></div>
		<%
		Fieldz=" PartsID, PartNumber AS PN, Model, Manufacturer AS Mfr, Inventory AS Qty, InventoryLevel AS iLevel, Cost, Cost*Inventory AS Total, Category1, System "
		SQL="SELECT "&Fieldz&" FROM Parts WHERE Inventory > 0 ORDER BY Category1, Manufacturer"
		Set rs=server.createObject("adoDb.recordSet")
		rs.Open SQL, RedConnString
		
		rI=0 : cI=0 : Total=0
		Dim cName(1024)
		Dim cTotal(1024)
		If not rs.EOF Then cName(cI)=rs("Category1")
		If cName(cI) = "" or IsNull(cName(cI)) Then Cat=(rs("System"))
		'If cName(cI) = "" or IsNull(cName(cI)) Then 
		'Else
		' csa=Split(cName(cI)," - ")
		' cName(cI)=lCase(csa(0))
		'End If
		If cName(cI) = "" or IsNull(cName(cI)) Then cName(cI)="Miscellaneous and Uncategorized"
		cName(cI)=CStr(cName(cI))
		%><div class=row id=row<%=rI%>.5 style=" font-family:Verdana, Geneva, sans-serif; font-size:18px;" ><%=cName(cI)%></div><%
		Do Until rs.EOF
			rI=rI+1
			if fix((rI+1)/2)/2 = fix(fix((rI+1)/2)/2) Then stripe1=" background:rgba(0,255,255,.1);" Else stripe1=""
			if (rI+1)/2 = fix((rI+1)/2) Then stripe2= " margin-bottom:0;" Else stripe2=""
			stripe=stripe1&stripe2
			
			Cat=rs("Category1")
			If Cat = "" or IsNull(Cat) Then Cat=(rs("System"))
			'If Cat = "" or IsNull(Cat) Then 
			'Else
			' csa=Split(Cat," - ")
			' Cat=lCase(csa(0))
			'End If
			If IsNull(Cat) or Cat="" Then Cat="Miscellaneous and Uncategorized"
			Cat=CStr(Cat)
			
			If (Cat<>cName(cI)) Then
				%>
				<div class=row id=row<%=rI%>.5 style=" font-family:Consolas, 'Courier New', monospace; font-size:16px; font-weight:bold; " >
					<div style="float:left; text-align:left; border:none;"><%=cName(cI)%> Total:</div>
					<div style="float:right; text-align:right; border:none;"><%=formatCurrency("0"&cTotal(cI))%></div>
				</div>
				<div class=row style="opacity:0" >&nbsp;</div>
				<%
				cI=cI+1
				cTotal(cI)=0
				cName(cI)=Cat
				%><div class=row id=row<%=rI%>.5 style=" font-family:Verdana, Geneva, sans-serif; font-size:18px;" ><%=cName(cI)%></div><%
			End If
			
			Total=Total+rs("Total")
			cTotal(cI)=cTotal(cI)+rs("Total")
			
			
			%>
			<div class=row id=row<%=rI%> style="<%=stripe%>">
				<div class=pIdW><%=rs("PartsID")%>&nbsp;</div>
				<div class=mfrW><%=rs("Mfr")%>&nbsp;</div>
				<div class=modelW><%=rs("Model")%>&nbsp;</div>
				<div class=PNW><%=rs("PN")%>&nbsp;</div>
				<div class=qtyW><%=rs("Qty")%>&nbsp;</div>
				<div class=costW><%=formatCurrency("0"&rs("Cost"))%>&nbsp;</div>
				<!-- div class=totalW><%=formatCurrency("0"&rs("Total"))%>&nbsp;</div -->
				<div class=totalW><%=formatCurrency(Total)%>&nbsp;</div>				
				<div class=endW>&nbsp;</div>
			</div>
			<!-- div class=row style="background:#eff;">< %=rs("Category1")%> - < %=rs("System")%> - < %=Cat%> - < %=cName(cI)%>&nbsp;</div -->
			<%
			rs.MoveNext
		Loop
		%>
		<div class=row id=row<%=rI%>.5 style=" font-family:Consolas, 'Courier New', monospace; font-size:16px; font-weight:bold;" >
			<div style="float:left; text-align:left; border:none;"><%=cName(cI)%> Total:</div>
			<div style="float:right; text-align:right; border:none;"><%=formatCurrency("0"&cTotal(cI))%></div>
		</div>
		<div class=row style="opacity:0" >&nbsp;</div>
	
		<div class=row id=row<%=rI%>.5 style=" height:32px; font-family:Consolas, 'Courier New', monospace; font-size:24px;" >
			<div style="float:left; text-align:left; border:none;">Inventory Total:</div>
			<div id=bottomTotal style="float:right; text-align:right; border:none;"><%=formatCurrency("0"&Total)%></div>
		</div>
	
	</div> 

</div>

</body>
</html>
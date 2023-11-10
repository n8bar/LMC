<%
Set rs3=Nothing
SQL3="SELECT ID,ShipToName,ShipToAttn,ShipToAddress,ShipToCity,ShipToState,ShipToZip,notes FROM JobPacks WHERE ProjID="&ProjID&" AND Shipped=0"' ORDER BY Shipped, DateShipped DESC"
Set rs3=Server.CreateObject("AdoDB.RecordSet")
rs3.open SQL3, REDConnString

If rs3.EOF Then
	%>
	</div>
	<form id=newJP action="javascript:newJobPack();" style="height:auto; width:90%; margin:0 0 0 5%;">
		<h3>New Job Pack:</h3>
		<h5><label class="w100p fL wsnw">Shelf: <input class="w70p" id=jpShelf name=jpShelf maxlength=100 value="" /></label></h5><br/>
		<h5 style="margin-bottom:0;">Ship To:</h5>
		<label class="taR w100p fL wsnw">Recipient's Name:<input class="w70p fR" name=shipToAttn maxlength=100 value="<%=rs("shipToAttn")%>" /></label><big><big><br></big></big>
		<label class="taR w100p fL wsnw" >Company / Facility:<input class="w70p fR" name=shipToName maxlength=100 value="<%=rs("shipToName")%>" /></label><big><big><br></big></big>
		<label class="taR w100p fL wsnw">Street Address:<input class="w70p fR" name=shipToAddress maxlength=100 value="<%=rs("shipToAddress")%>" /></label><big><big><br></big></big>
		<label class="taR w50p fL wsnw">City:<input class="w80p fR" name=shipToCity maxlength=50 value="<%=rs("shipToCity")%>" /></label>
		<label class="taR w20p fL wsnw">State:<input class="w40p fR" name=shipToState maxlength=2 value="<%=rs("shipToState")%>" /></label>
		<label class="taR w30p fL wsnw">Zip:<input class="w70p fR" name=shipToZip maxlength=10 value="<%=rs("shipToZip")%>" /></label><br>
		<h5 style="margin-bottom:0;">Notes:</h5>
		<textarea id=notes class="w100p h64" style="font-family:Consolas,\'Courier New\', Courier, monospace"><%=rs("notes")%></textarea>
		<center><button class="w40p" type="submit" >Save<b><big><i>!</i></big></b></button></center>
	</form>
	<script>Gebi('jpShelf').focus();</script>
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
		<span class="fR" style="position:relative; top:-3px;">
			<span class="tButton0x24" style="line-height:24px; overflow:hidden; margin-right:16px; width:auto;" onClick="sendJP();">&nbsp;Send&nbsp;<img class="fR h40" style="position:relative; top:-10px;" src="../../LMCManagement/images/ServiceVan48.png"/></span><%=indent%>
		</span>
	</div>
	
	
	<div id=jpItemsHead class="ItemsHead">
		<div class="w20p" >Manufacturer</div>
		<div class="w21p">Part Number</div>
		<div class="w11p lH12"><small>Inventory Quantity</small></div>
		<div class="w5p p0" ><button class=tButton0x24 style="float:none;" onClick="movePart(0)"><img height=20 src="../../LMCManagement/images/CyanDblRight24.png"/></button></div>
		<div class="w16p lH12"><small>Job Pack Quantity</small></div>
		<div class="w11p lH12"><small>Still Needed Quantity</small></div>
		<div class="w11p lH12"><small>Sent Qty <br/> (this M.R.)</small></div>
		<div class="w4p ffConsolas lH24 fS18 fwB" style="color:#0f0; text-shadow:#040 0 2px 1px,#400 1px 0 1px,#400 0 -1px 1px,#400 -1px 0 1px;" ><i>√</i></div>
	</div>

</div>
<script>
	var jpId=<%=JPID%>;
	var mrId=<%=mrid%>;
</script>
	
<%	


nQty=0
sQty=0
jpQty=0

check="<img height=""24"" src=""../images/check_64.png"">"
canDo="<span style=""color:#f00; font-family:consolas; font-size:32px; position:relative; top:6px;""><b>&larr;</b></span>"
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
		<div class="w5p p0 taC" ><%if invQty(r) > 0 Then %> <button class=tButton0x24 style="float:none;" onClick="movePart(<%=r%>);"><img height=20 src="../../LMCManagement/images/CyanDblRight24.png"/></button> <%End IF%></div>
		<div class="w11p h100p ffConsolas">
			<input id=jpQty<%=r%> class="w100p h100p taR " value="<%=jPackQty(r)%>" onkeypress="onlyAccept(event,'0123456789.',this); " readonly />
		</div>
		<div id=edit<%=r%> class="editBtn" style="height:24px; text-align:center;" onclick="eRow(<%=r%>);" >&nbsp;</div>
		<% stillNeededQty=needQty(r)-jPackQty(r) %>
		<div class="w11p lH12 taR ffConsolas"><small id=nQty<%=r%> ><%=stillNeededQty%></small></div>
		<div class="w11p lH12 taR ffConsolas"><small id=sQty<%=r%> ><%=sentQty(r)%></small></div>
		<div class=jpiStatus id=status<%=r%> ><%=itemStatus%></div>
	</div>
	<%


Next

Response.End() 

'███████████████████████████████████████████████
'██████████████████████████████████████████████████
'████████████████████████████████████████████████████
'█████████████████████████████████████████████████████
'█████████████████████████████████████████████████████
'████████████████████████████████████████████████████
'██████████████████████████████████████████████████
'███████████████████████████████████████████████
	
	mriIdList=""
	jpQty=0
	sQty=0
	
	Do while previousPartsID=rs4("PartsID")
		mriid=rs4("ID")
		If mriIdList<>"" Then mriIDList=mriIdList&","
		mriIDList=mriIdList&mriid
		PartJPID=rs4("JobPackID")
		Mfr=dcF(rs4,"Mfr")
		PN=dcF(rs4,"PartNo")
		PartsID=rs4("PartsID")
		needed=(rs4("needed")="True")
		SQL5="SELECT Inventory,InventoryLevel FROM Parts WHERE PartsID="&rs4("PartsID")
		Set rs5=Server.CreateObject("AdoDB.RecordSet")
		rs5.Open SQL5, REDConnString
		invQty=cSng("0"&rs5("Inventory"))
		iLevel=cint("0"&rs5("InventoryLevel"))
		if iLevel>0 Then 
			pLevel=cInt((invQty/iLevel)*100)
			inventoryStatus=pLevel&"% of Maintenance Level:"&iLevel 
		Else 
			inventoryStatus=invQty
			pLevel=0
		End If
		If pLevel>100 Then pColor="#0C0" Else pColor="#0FF"
	
		If needed Then nQty=1 Else nQty=0
		if PartJPID= JPID Then 
			jpQty=1
		Else
			If PartJPID>0 Then sQty=1' Else nQty=1
		End If
		previousPartsID=rs4("PartsID")
		rs4.MoveNext
	Loop
	
	%>
	<div class=row id=row<%=r%> >
		<input id=PartsID<%=r%> type="hidden" value="<%=PartsID%>" />
		<input id=mriIDLIST<%=r%> type="hidden" value="<%=mriIDLIST%>" />
		<div class="w20p"><%=Mfr%></div>
		<div id=PN<%=r%> class="w21p"><%=PN%></div>
		<div class="w11p lH12 taR ffConsolas" style="<%=iSty%>" title="<%=inventoryStatus%>">
			<small id=invQty<%=r%>><%=invQty%></small>
			<div class="w100p h3" style="border:1px #888 solid; border-radius:2px; position:relative; top:-5px; background:#000; z-index:0;" ><div style="background:<%=pColor%>; width:<%=pLevel%>%; height:100%;">&nbsp;</div></div>
		</div>
		<div class="w5p p0 taC" ><%if invQty > 0 Then %> <button class=tButton0x24 style="float:none;" onClick="movePart(<%=r%>);"><img height=20 src="../../LMCManagement/images/CyanDblRight24.png"/></button> <%End IF%></div>
		<div class="w11p h100p ffConsolas">
			<input id=jpQty<%=r%> class="w100p h100p taR " value="<%=jpQty%>" onkeypress="onlyAccept(event,'0123456789.',this); " readonly />
		</div>
		<div id=edit<%=r%> class="editBtn" style="height:24px; text-align:center;" onclick="eRow(<%=r%>);" >&nbsp;</div>
		<div class="w11p lH12 taR ffConsolas"><small id=nQty<%=r%> ><%=nQty-jpQty%></small></div>
		<div class="w11p lH12 taR ffConsolas"><small id=sQty<%=r%> ><%=sQty%></small></div>
		<div class=jpiStatus id=status<%=r%> ><%=itemStatus%></div>
	</div>
	<%
	
	rs4.MoveNext
'Loop	
	itemStatus=canDo
	If nQty=jpQty Then	itemStatus=check
	If nQty<jpQty Then	itemStatus=cheese
	If nQty>jpQty AND invQty<(nQty-jpQty) Then	itemStatus=need2order
	'If nQty>0 And invQty>0 Then iSty="font-weight:bold; font-size:19px; color:#C00; background-color:rgba(192,0,0,.0625);" Else iSty=""
	%>
	<%


r=0
Do Until rs4.Eof
	If PartsID<>rs4("PartsID") Then
		
		'If nQty>0 And invQty>0 Then iSty="font-weight:bold; font-size:19px; color:#C00; background-color:rgba(192,0,0,.0625);" Else iSty=""
		%>
		<div class=row id=row<%=r%> >
			<input id=PartsID<%=r%> type="hidden" value="<%=PartsID%>" />
			<input id=mriIDLIST<%=r%> type="hidden" value="<%=mriIDLIST%>" />
			<div class="w20p"><%=Mfr%></div>
			<div id=PN<%=r%> class="w21p"><%=PN%></div>
			<div class="w11p lH12 taR ffConsolas" style="<%=iSty%>" title="<%=inventoryStatus%>">
				<small id=invQty<%=r%>><%=invQty%></small>
				<div class="w100p h3" style="border:1px #888 solid; border-radius:2px; position:relative; top:-5px; background:#000; z-index:0;" ><div style="background:<%=pColor%>; width:<%=pLevel%>%; height:100%;">&nbsp;</div></div>
			</div>
			<div class="w5p p0 taC" ><%if invQty > 0 Then %> <button class=tButton0x24 style="float:none;" onClick="movePart(<%=r%>);"><img height=20 src="../../LMCManagement/images/CyanDblRight24.png"/></button> <%End IF%></div>
			<div class="w11p h100p ffConsolas">
				<input id=jpQty<%=r%> class="w100p h100p taR " value="<%=jpQty%>" onkeypress="onlyAccept(event,'0123456789.',this); " readonly />
			</div>
			<div id=edit<%=r%> class="editBtn" style="height:24px; text-align:center;" onclick="eRow(<%=r%>);" >&nbsp;</div>
			<div class="w11p lH12 taR ffConsolas"><small id=nQty<%=r%> ><%=nQty-jpQty%></small></div>
			<div class="w11p lH12 taR ffConsolas"><small id=sQty<%=r%> ><%=sQty%></small></div>
			<div class=jpiStatus id=status<%=r%> ><%=itemStatus%></div>
		</div>
		<%
		
		mriIdList=""
		
		If needed Then nQty=1 else nQty=0
		'if PartJPID= JPID Then 
		if rs4("JobPackID")=JPID Then
			jpQty=1
		Else
			'If PartJPID>0 Then sQty=1 Else nQty=1
			If rs4("JobPackID")>0 Then sQty=1 'Else nQty=1
			jpQty=0
		End If
		r=r+1
	Else
		If needed Then nQty=nQty+1
		'if PartJPID=JPID Then
		if rs4("JobPackID")=JPID Then
			jpQty=jpQty+1
		Else 
			'If PartJPID>0 Then sQty=sQty+1 Else nQty=nQty+1
			If rs4("JobPackID")>0 Then sQty=sQty+1' Else nQty=nQty+1
		End If
	End if

	mriid=rs4("ID")
	If mriIdList<>"" Then mriIDList=mriIdList&","
	mriIDList=mriIdList&mriid
	partJPID=rs4("JobPackID")
	Mfr=dcF(rs4,"Mfr")
	PN=dcF(rs4,"PartNo")
	PartsID=rs4("PartsID")
	needed=(rs4("needed")="True")
	SQL5="SELECT Inventory,InventoryLevel FROM Parts WHERE PartsID="&rs4("PartsID") : Set rs5=Server.CreateObject("AdoDB.RecordSet") : rs5.Open SQL5, REDConnString
	invQty=cint("0"&rs5("Inventory"))
	iLevel=cint("0"&rs5("InventoryLevel"))
	if iLevel>0 Then 
		pLevel=cint((invQty/iLevel)*100)
		inventoryStatus=pLevel&"% of Maintenance Level:"&iLevel'& "Debuggr: iL="&iLevel&" invQty="&invQty
	Else 
		inventoryStatus=invQty
		pLevel=0
	End If
	If pLevel>100 Then pColor="#0C0" Else pColor="#0FF"
	'SQL6="SELECT Inventory,InventoryLevel FROM MatReqItems WHERE PartsID="&rs4("PartsID")&" AND JobPackID=" : Set rs6=Server.CreateObject("AdoDB.RecordSet") : rs6.Open SQL6, REDConnString
	
	
	
	%>
	<debug style="display:none; font-size:10px;">
		mriid:<%=mriid%> &nbsp; &nbsp; &nbsp; 
		PartsID:<%=PartsID%> &nbsp; &nbsp; &nbsp; 
		PartJpid:<%=partJpid%> &nbsp; &nbsp; &nbsp; 
		PN:<%=PN%> &nbsp; &nbsp; &nbsp; 
		needed:<%=needed%> &nbsp; &nbsp; &nbsp; 
		jpTally:<%=jpQty%> &nbsp; &nbsp; &nbsp; 
		nTally:<%=nQty%> &nbsp; &nbsp; &nbsp; 
		sTally:<%=sQty%><br/>
	</debug>
	<%
	
	rs4.MoveNext
Loop
'nQty=nQty+1

%>
<div class=row id=row<%=r%> >
	<input id=PartsID<%=r%> type="hidden" value="<%=PartsID%>" />
	<input id=mriIDLIST<%=r%> type="hidden" value="<%=mriIDLIST%>" />
	<div class="w20p"><%=Mfr%></div>
	<div id=PN<%=r%> class="w21p"><%=PN%></div>
	<div class="w11p lH12 taR ffConsolas" style="<%=iSty%>" title="<%=inventoryStatus%>">
		<small id=invQty<%=r%>><%=invQty%></small>
		<div class="w100p h3" style="border:1px #888 solid; border-radius:2px; position:relative; top:-5px; background:#000;" ><div style="background:<%=pColor%>; width:<%=pLevel%>%; height:100%;">&nbsp;</div></div>
	</div>
	<div class="w5p p0 taC" ><%if invQty > 0 Then %> <button class=tButton0x24 style="float:none;" onClick="movePart(<%=r%>);"><img height=20 src="../../LMCManagement/images/CyanDblRight24.png"/></button> <%End IF%></div>
	<div class="w11p h100p ffConsolas">
				<input id=jpQty<%=r%> class="w100p h100p taR " value="<%=jpQty%>" onkeypress="onlyAccept(event,'0123456789.',this); " readonly />
	</div>
	<div id=edit<%=r%> class="editBtn" style="height:24px; text-align:center;" onclick="eRow(<%=r%>);" >&nbsp;</div>
	<div class="w11p lH12 taR ffConsolas"><small id=nQty<%=r%> ><%=nQty-jpQty%></small></div>
	<div class="w11p lH12 taR ffConsolas"><small id=sQty<%=r%> ><%=sQty%></small></div>
	<div class=jpiStatus id=status<%=r%> ><%=itemStatus%> </div>
</div>

<% mriIdList="" %>
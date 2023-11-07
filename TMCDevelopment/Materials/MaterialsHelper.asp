<div id=Modal align=center>
	<div style="width:100%; height:30%;"></div>
	<img id=mSwirl src=../../Images/roller.gif style="display:none; margin:auto;" /><br/>
	<div id=mStatus style="display:none;"></div>
</div>
<div id=Modal2></div>

<form id=NewPartBox class="WindowBox" align="center" action="javascript:SavePart();" >
	<div id=npTitle class="WindowTitle" style="background:#009191; color:#fff; text-align:center;"><span id=npTitleName></span><div class="redXCircle" onClick="hideNewPart();" >X</div></div>
	<div id=editPId style="float:left;"></div>

	<div class="newPartBoxRow" style="height:26px;">
		<label class="newPartLabel" for="npPartName"><big>Part Name:</big></label>
		<input id="npPartName" type="text" class="newPartTxt" style="font-size:22px;" required /><big>&nbsp;</big>
	</div>

	<div class="newPartBoxRow" style="height:23px;">
		<label class="newPartLabel" for="npPN" style="font-size-adjust:1px;">Part Number:</label>
		<input id="npPN" type="text" class="newPartTxt" style="font-size:19px;" required />
	</div>

	<div class=newPartBoxRow style="height:64px;; line-height:24px;">
		<div class=newPartLabel >
			<label for=npMfg style="float:right;" >Manufacturer:</label>
			<button class="tButton24 ToolbarButton" onClick="showNM();" style="float:right; margin:0 2px 0 0;"><img src="../../Images/plus_16.png" /></button>
		</div>
		<select id=npMfg class=newPartTxt style="font-size:16px; height:100%; overflow-y:auto" onChange="npMfgChange();" required multiple size="1" onFocus="//this.multiple=true; this.style.height='100%';" onBlur="//this.multiple=false; this.style.height='20px';" >
			<option id=mChoose >Please Choose a Manufacturer</option>
			<%
			mfgSQL="SELECT ManufID, Name FROM Manufacturers ORDER BY Name"
			Set mfgRS=Server.CreateObject("AdoDB.RecordSet")
			mfgRS.Open mfgSQL, REDConnString
			Do Until mfgRS.EOF
				%><option value="<%=mfgRS("ManufID")%>"><%=DecodeChars(mfgRS("Name"))%></option><%
				mfgRS.moveNext
			Loop
			Set mfgRS=Nothing
			%>
			<option value="new"><b style="color:#0a0;">+</b>New Manufacturer</option>
		</select>
	</div>

	<div class="newPartBoxRow">
		<label class="newPartLabel" for="npCost" >Cost: $</label>
		<input id="npCost" type="text" class="newPartTxt" required onKeyPress="onlyAccept(event,'0123456789.',this);" />
	</div>

	<div class="newPartBoxRow">
		<label class="newPartLabel" for="npDesc" >Description:</label>
		<input id="npDesc" type="text" class="newPartTxt" required />
	</div>
	
	<div class=newPartBoxRow style="height:64px;; line-height:24px;">
		<div class=newPartLabel >
			<label for=npCat style="float:right;" >Category:</label>
			<button class="tButton24 ToolbarButton" onClick="showNC();" style="float:right; margin:0 2px 0 0;"><img src="../../Images/plus_16.png" /></button>
		</div>
		<select id=npCat class=newPartTxt style="font-size:16px; height:100%; overflow-y:auto" onChange="npCatChange();" required multiple size="1" onFocus="//this.multiple=true; this.style.height='100%';" onBlur="//this.multiple=false; this.style.height='20px';" >
			<option id=cChoose >Please Choose a Category</option>
			<%
			catSQL="SELECT CategoryID, Category FROM Categories ORDER BY Category"
			Set catRS=Server.CreateObject("AdoDB.RecordSet")
			catRS.Open catSQL, REDConnString
			Do Until catRS.EOF
				%><option value="<%=catRS("CategoryID")%>"><%=DecodeChars(catRS("Category"))%></option><%
				catRS.moveNext
			Loop
			Set catRS=Nothing
			%>
			<option value="new"><b style="color:#0a0;">+</b>New Category</option>
		</select>
	</div>

	<div class=newPartBoxRow style="height:64px;; line-height:24px;">
		<div class=newPartLabel >
			<label for=npSys style="float:right;" >System Type:</label>
			<button class="tButton24 ToolbarButton" onClick="showNS();" style="float:right; margin:0 2px 0 0;"><img src="../../Images/plus_16.png" /></button>
		</div>
		<select id=npSys class=newPartTxt style="font-size:16px; height:100%; overflow-y:auto" onChange="npCatChange();" required multiple size="1" onFocus="//this.multiple=true; this.style.height='100%';" onBlur="//this.multiple=false; this.style.height='20px';" >
			<option id=sChoose >Please Choose a System Type</option>
			<%
			sysSQL="SELECT SystemID, SystemName FROM SystemList WHERE Enabled>0 ORDER BY SystemName"
			Set sysRS=Server.CreateObject("AdoDB.RecordSet")
			sysRS.Open sysSQL, REDConnString
			Do Until sysRS.EOF
				%><option value="<%=sysRS("SystemID")%>"><%=DecodeChars(sysRS("SystemName"))%></option><%
				sysRS.moveNext
			Loop
			Set sysRS=Nothing
			%>
			<option value="new"><b style="color:#0a0;">+</b>New System Type</option>
		</select>
	</div>

	<div class="newPartBoxRow" style="width:95%;"><input type="submit" onClick="//savePart();" style="float:right;" value=Save /></div>
</form>


<div id=NewMfgBox class=WindowBox>
	<div class=WindowTitle style="background:#009191; color:#fff; text-align:center;">New Manufacturer<div class="redXCircle" onClick="hideNM();" >X</div></div>
	<div class="newPartBoxRow" align="center">
		<br/>
		<label>Name:</label>
		<input id=nmName type="Text" />
		<button onClick="saveNM(Gebi('nmName').value);">Save</button>
	</div>
</div>

<div id=NewCatBox class=WindowBox>
	<div class=WindowTitle style="background:#009191; color:#fff; text-align:center;">New Category<div class="redXCircle" onClick="hideNC();" >X</div></div>
	<div class="newPartBoxRow" align="center">
		<br/>
		<label>Category:</label>
		<input id=ncName type="Text" />
		<button onClick="saveNC(Gebi('ncName').value);">Save</button>
	</div>
</div>

<div id=NewSysBox class=WindowBox>
	<div class=WindowTitle style="background:#009191; color:#fff; text-align:center;">New System<div class="redXCircle" onClick="hideNC();" >X</div></div>
	<div class="newPartBoxRow" align="center">
		<br/>
		<label>System:</label>
		<input id=nsName type="Text" />
		<button onClick="saveNS(Gebi('nsName').value);">Save</button>
	</div>
</div>
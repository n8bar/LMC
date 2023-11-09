<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../LMC/RED.asp" -->
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Bid Preset Editor</title>
	<!--#include file="Common.asp" -->
	
	<link rel=stylesheet href=Library/CSS_DEFAULTS.css media=all>
	<link rel=stylesheet href=Bid/BidProject.css media=all>
	<link rel=stylesheet href=Bid/BidPresets.css media=all>
	<script type="text/javascript">var sessionID='<%=Session.SessionID%>';</script>
	<script type="text/javascript" src="Bid/BidPresets.js"></script>

</head>

<body>

<div id=npModal>
	<div id=npWindow class="WindowBox taC" style="display:block; top:10%; left:20%;">
		<div id=npWTitle class="WindowTitle">New Preset<span class="redXCircle" onClick="Gebi('npModal').style.display='none';">X</span></div>
		<br>
		<label style="width:90%; text-align:left;">Name:<br>
			<input id=npName type="text" style="width:80%;" onKeyPress="npEnableSave();" onChange="npEnableSave();" />
		</label>
		<br>
		<br>
		<label class="w100p taL" >Section Type:<br></label>

			<select id=npSecList class="w70p h24 fL" style="margin:0 0 0 10%;" onChange="npEnableSave();">
				<option><br/></option>
				<option id=optNewSecType>New Section Type</option>
				<option><br/></option>
				<%
				SecTypesOptionList("secType")
				%>
			</select>
			<button id=stDel class="ToolbarButton w20 h20 fL taC" title="Delete this section type" onClick="delSecType();" disabled><img src="../Images/delete16.PNG"/></button>
		<br/>
		<br/>
		<button id=npSave onClick="newPreset(Gebi('npName').value, SelI('npSecList').innerHTML, SelI('npSecList').value);">Save</button>
	</div>
</div>

<div id=nsModal >
	<div id=newSecTypeBox class=WindowBox>
		<div class=WindowTitle >New Section Type <div class=redXCircle onClick=hideNS(); >X</div></div>
		<div class=newPartBoxRow align=center>
			<br/>
			<label>Section Type:</label>
			<input id=nsName type=Text />
			<button onClick="saveNS(Gebi('nsName').value);">Save</button>
		</div>
	</div>
</div>

<div id=Top class=Toolbar>
	<button onClick="window.history.go(-1);" style="float:left;">◄Back</button>
</div>
<div id="mainToolbar" class="Toolbar" >
	<div id=path >&nbsp; Jobs > <a href="javascript:window.location='Bid.asp';">Estimating/Sales</a> > Preset Editor</div>
	<button id="ReloadFrame" class="tButton32" style="position:relative; top:-8px;" onClick="window.location=window.location;" title="Reload Tab"/><img src="../Images/reloadblue24.png" /></button>
</div>

<div id=Presets>
	<div id=sectionList style=" border-top-right-radius:8px; border-top-left-radius:8px;" >
		<div class=Toolbar style="height:32px; border-top-right-radius:10px; border-top-left-radius:10px;">
			<button id=btnNewPreset onclick="showNewPreset();" >&nbsp;<img src="../Images/plus_16.png" />New&nbsp;</button>
		</div>
		<%
		SQL="SELECT SectionID, SectionName FROM SectionList ORDER BY SectionName"
		Set rs=Server.CreateObject("AdoDB.Recordset")
		rs.Open SQL, REDConnString
		
		If Not rs.EOF Then
			%><div class=topShade>&nbsp;</div><%
			Do Until rs.EOF
				secID=rs("SectionID")
				%>
				<div class=sectionType id=sec<%=secID%> onclick="secType(<%=secID%>);">
					&nbsp; &nbsp;<%=rs("SectionName")%>
				</div>
	
				<div id=sec<%=rs("SectionID")%>list class=presetList >
					<%
					SQL1="SELECT BidPresetID, BidPresetName FROM BidPresets WHERE BidPresetSectionID="&rs("SectionID")
					Set rs1=Server.CreateObject("AdoDB.Recordset")
					rs1.Open SQL1, REDConnString
					
					Do Until rs1.EOF
						bpID=rs1("BidPresetID")
						%>
						<div class=Preset >
							<span class="PresetX" onClick="delPreset(<%=bpID%>,this);">&nbsp;</span>
							<span onclick="loadPreset(<%=bpID%>);" style="width:100%; display:inline-block;">&nbsp;<%=rs1("BidPresetName")%></span>
						</div>
						<%
						rs1.MoveNext
					Loop
					%>
				</div>
				<%
				rs.MoveNext
			Loop
		End If
		%>
	</div>
	<% 
	pId=Request.QueryString("id")
	if pID<>""then src="PresetEditor.asp?id="&pID
	%>
	<iframe id=presetEdit src="<%=src%>"></iframe>
</div>

</body>
</html>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Materials</title>
<!--#include file="common.asp" -->
<script type="text/javascript" src="Materials/Materials.js"></script>
<script type="text/javascript" src="Materials/MaterialsAJAX.js"></script>
<script>var noCache='<%=Request.QueryString("nocache")%>';</script>

<link type="text/css" rel=stylesheet href="Library/CSS_DEFAULTS.css" media="screen"/>
<link type="text/css" rel=stylesheet href="Library/ListsCommon.css" media="all"/>
<link type="text/css" rel=stylesheet href="Materials/Materials.css" media="all"/>
<link type="text/css" rel=stylesheet href="Library/dhtmlgoodies_calendar.css?random=20051112" media=all />

</head>
<body onResize="Resize();" onLoad="Resize();" >
<iframe id=PartFrame style="display:none; width:100%; height:100%; top:0; left:0; border:none; position:absolute; z-index:100;"></iframe>
<iframe id=DataFrame style="display:none; width:100%; height:100%; top:0; left:0; border:none; position:absolute; z-index:100;"></iframe>
<div id=frameX class="redXCircle32" style="display:none; right:16px; z-index:200; font-family:'Comic Sans MS',wide;font-weight:normal;" onClick="closeFrames();">X</div>


<!--#include file="Materials/MaterialsHelper.asp" -->

<div id=Top></div>
<div id=mainToolbar class=Toolbar style="background:none; height:48px; text-align:center; width:98%;">
	
	<div class=tSpacer5 >&nbsp;</div>
	<button id=newPart class=tButton32 onClick=showNewPart(); title="New Part" /><img src="../Images/plus_16.png" /></button>
	<div class=tSpacer1 >&nbsp;</div>
	<button id=searchParts class=tButton32 onClick="toggleSearchSort();" title="Search Parts" /><img src="../Images/search.png" /></button>
	<div class=tSpacer5 >&nbsp;</div>
	<div class=tSpacer10 >&nbsp;</div>
	<!-- I wish I had time 4 this!
	<button id=importData class=tButton32x onClick="Gebi('DataFrame').style.display='block'; Gebi('frameX').style.display='block';" title="Data Import" />
		<div style="height:100%; width:32px; display:inline-block; float:left; margin:0 0 0 4px;"><img src="../Images/move.png" /></div>
		<div style="height:auto; width:auto; display:inline-block; float:right; padding:0 4px 0 4px;">Data Import</div> 
	</button>
	-->
	<div class=tSpacer10 >&nbsp;</div>
	<% 
	if session("partsListMax")<=0 Then session("partsListMax")=128 
	plm = session("partsListMax")
	%>
	<label id=lLMax >
		&nbsp; &nbsp; &nbsp; &nbsp; Show
		<input id=lMax type=text width=3 onkeyup="return false;" value=<%=plm%> onChange="sW('partsListMax',this.value);" >
		results &nbsp; &nbsp;
	</label>
	<div class=tSpacer10 >&nbsp;</div>
	<button id=ReloadFrame class=tButton32 onClick="noCacheReload();" title="Reload Tab"/>
		<img src="../Images/reloadblue24.png" />
	</button>
</div>

<div id=SearchSort>
	<form id=SearchBar class=Toolbar action="javascript:Search();">
		<input id=btnSearch style="position:relative; float:right; font-size:20px; height:32px; margin:12px 12px 0 0;" type=submit value=Search />
		&nbsp;<label style="white-space:nowrap;">Part Name or Number<input id=sName onkeypress="ifEnter(event,'Search();');" autocomplete=on /></label>
		&nbsp;
		<label style="white-space:nowrap;">
			Manufacturer:
			<select id=sMfg onkeypress="ifEnter(event,'Search();');">
				<option value=0>[Any]</option>
				<%
				SQL="SELECT ManufID, Name FROM Manufacturers ORDER BY Name"
				Set rS=Server.CreateObject("AdoDB.RecordSet")
				rS.Open SQL, REDConnString
				
				Do Until rS.EOF
					%> <option value="<%=rS("ManufID")%>"><%=DecodeChars(rS("Name"))%></option> <%
					rS.MoveNext
				Loop
				Set rS = Nothing
				%>
			</select>
		</label>
		&nbsp;<label style="white-space:nowrap;">Description<input id=sDesc onkeypress="ifEnter(event,'Search();');" autocomplete=on /></label>
		&nbsp;
		<label style="white-space:nowrap;">Max Price<input id=sMax class=w96 type=text onkeypress="ifEnter(event,'Search();');" autocomplete=on /></label>
		&nbsp;
		<label style="white-space:nowrap;">Min Price<input id=sMin class=w96 type=text onkeypress="ifEnter(event,'Search();');" autocomplete=on /></label>
		&nbsp;
		<label style="white-space:nowrap;">
			System Type:
			<select id=sSystem onkeypress="ifEnter(event,'Search();');">
				<option value=0>[Any]</option>
				<% SysTypesOptionList("") %>
			</select>
		</label>
		&nbsp;
		<label style="white-space:nowrap;">
			Category:
			<select id=sCategory onkeypress="ifEnter(event,'Search();');">
				<option value=0>[Any]</option>
				<%
				SQL="SELECT CategoryID, Category FROM Categories ORDER BY Category"
				Set rS=Server.CreateObject("AdoDB.RecordSet")
				rS.Open SQL, REDConnString
				
				Do Until rS.EOF
					%> <option value="<%=rS("CategoryID")%>"><%=DecodeChars(rS("Category"))%></option> <%
					rS.MoveNext
				Loop
				Set rS=Nothing
				%>
			</select>
		</label>
		&nbsp;
		<label style="white-space:nowrap;">
			Vendor:
			<select id=sVendor onkeypress="ifEnter(event,'Search();');">
				<option value=0>[Any]</option>
				<% ContactsOptionList("vendors") %>
			</select>
		</label>
		&nbsp;
		<label style="white-space:nowrap;"><input id=sAny type="checkbox" onChange="Gebi('sAll').checked=!this.checked" checked >Match Anything</label>
		<label style="white-space:nowrap;"><input id=sAll type="checkbox" onChange="Gebi('sAny').checked=!this.checked" >Match Everything</label>
		<br/>
		&nbsp;
	</form>
</div>


<div id="ListBody" align="center">
	<div id="listToolbar" class="Toolbar" ondblclick="Gebi('hiddenSQLRabbit').style.display='block';">
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
	
	<div id="LItemsContainer" style="background:url(../images/forklift-256-faded.png) no-repeat bottom right; ">
		<div class=row id=emptyRow style="border:none; height:6px;"></div>
	</div> 
</div>                
<div id=ListHead style="box-shadow: 0 -5px 20px white, 0 -5px 20px white, 0 -5px 20px white, 0 -5px 20px white, 0 -5px 20px white, 0 -5px 20px white, 0 -5px 20px white, 0 -5px 20px white, 0 -5px 20px white, 0 -5px 20px white, 0 -5px 20px white;">
	<div class="edW taC" ><span id=edit>edit</span></div>
	<div class="pIdW taC" ><span class=hColSort id=PartsID onClick="sortBy(this);" >Part ID#</span></div>
	<div class="modelW taC" ><span class=hColumn id=Model onClick="sortBy(this);" >Name</span></div>
	<div class="PNW taC" ><span class=hColumn id=PartNumber onClick="sortBy(this);" >Part Number</span></div>
	<div class="qtyW taC" ><span class=hColumn id=LaborValue onClick="sortBy(this);" >In Stock</span></div>
	<div class="costW taC" ><span class=hColumn id=Cost onClick="sortBy(this);" >Cost</span></div>
	<div class="mfrW taC" ><span class=hColumn id=Manufacturer onClick="sortBy(this);" >Manufacturer</span></div>
	<div class="systemW taC" ><span class=hColumn id=System onClick="sortBy(this);" >System</span></div>
	<div class="categoryW taC" ><span class=hColumn id=Category1 onClick="sortBy(this);" >Category</span></div>
	<!-- div class="descriptionW taC" ><span class=hColumn id=Vendor1 onClick="sortBy(this);" >Description</span></div -->
</div>

</body>
</html>
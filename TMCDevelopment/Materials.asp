<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Materials</title>
<!--#include file="common.asp" -->
<script type="text/javascript" src="Materials/Materials.js"></script>
<script type="text/javascript" src="Materials/MaterialsAJAX.js"></script>
<script>
	var noCache='<%=Request.QueryString("nocache")%>';
	window.onresize = function() {
		function H(id) { return Gebi(id).offsetHeight; }
		Gebi('ListBody').style.height=document.body.offsetHeight-H('Top')-H('mainToolbar')-H('TabsBar')+3+('px');
	}
	window.onload=window.onresize;

	function getLastTab() {
		var tabId='<%=application("MaterialsTab"&session("EmpId"))%>';
		if (tabId!='') showTab(Gebi(tabId));
	}
</script>

<link type="text/css" rel=stylesheet href="Library/CSS_DEFAULTS.css?noCache=<%=LoadStamp%>" media="screen"/>
<link type="text/css" rel=stylesheet href="Library/ListsCommon.css?noCache=<%=LoadStamp%>" media="all"/>
<link type="text/css" rel=stylesheet href="Materials/Materials.css?noCache=<%=LoadStamp%>" media="all"/>
<link type="text/css" rel=stylesheet href="Library/dhtmlgoodies_calendar.css?random=20051112&noCache=<%=LoadStamp%>" media=all />
</head>
<body onLoad="getLastTab();">
<iframe id=PartFrame style="display:none; width:100%; height:100%; top:0; left:0; border:none; position:absolute; z-index:100;"></iframe>
<iframe id=DataFrame style="display:none; width:100%; height:100%; top:0; left:0; border:none; position:absolute; z-index:100;"></iframe>
<div id=frameX class="redXCircle32" style="display:none; right:16px; z-index:200; font-family:'Comic Sans MS',wide;font-weight:normal;" onClick="closeFrames();">X</div>


<!--#include file="Materials/MaterialsHelper.asp" -->

<div id=Top></div>
<div id=mainToolbar class=Toolbar style="background:none; height:48px; text-align:center; width:98%;">
	
	<div id=path></div>
	<script type="text/javascript">
		var path='';
		var topLevel=window.top.document;
		try { //(!!topLevel.getElementsByClassName('selectedMainTab')) {
			path+=topLevel.getElementsByClassName('selectedMainTab')[0].innerHTML+'>';
		} catch(e) { /*path='My TMC >'*/ }
		path+=' <big><b>Materials</b></big>';
		Gebi('path').innerHTML=path;
	</script>
	
	<div class=tSpacer5 >&nbsp;</div>
	<div class=tSpacer1 >&nbsp;</div>

	<div class=tSpacer5 >&nbsp;</div>
	<div class=tSpacer10 >&nbsp;</div>
	<!-- I wish I had time 4 this!
	<button id=importData class=tButton32x onClick="Gebi('DataFrame').style.display='block'; Gebi('frameX').style.display='block';" title="Data Import" />
		<div style="height:100%; width:32px; display:inline-block; float:left; margin:0 0 0 4px;"><img src="../Images/move.png" /></div>
		<div style="height:auto; width:auto; display:inline-block; float:right; padding:0 4px 0 4px;">Data Import</div> 
	</button>
	-->
	<div class=tSpacer10 >&nbsp;</div>
	<div class=tSpacer10 >&nbsp;</div>
	<div class=tSpacer10 >&nbsp;</div>
	<div class=tSpacer10 >&nbsp;</div>
	<button id=ReloadFrame class=tButton32 onClick="noCacheReload();" title="Reload Tab"/>
		<img src="../Images/reloadblue24.png" />
	</button>
</div>

<div id=TabsBar>
	<span id=ipeTab class=tab onClick=" showTab(this); " style="background:url(../images/forklift-z-32.png) no-repeat center left #fff;">&nbsp; &nbsp; &nbsp;Parts &amp; Inventory</span>
	<span id=mrTab class=tab onClick=" showTab(this); " style="background:url(../images/Doc►Cyan.png) no-repeat center left #fff; ">&nbsp; &nbsp;Request Materials</span>
	<span id=jpTab class=tab onClick="showTab(this);" style="background:url(../images/JobPack-z-32.png) no-repeat center left #fff;">&nbsp; &nbsp; &nbsp;Job Packs</span>
	<span id=orTab class=tab onClick="showTab(this);" style="background:url(../images/PO.png) no-repeat center left #fff;">&nbsp; &nbsp; Purchase Orders</span>
</div>



<div id="ListBody" align="center">
	<div id="listToolbar" class="Toolbar" ondblclick="Gebi('hiddenSQLRabbit').style.display='block';" style="display:none;">
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

	<iframe id=ipePage class=tabPage src="materialsDB.asp?nocache=<%=LoadStamp%>" ></iframe>
	<iframe id=mrPage class=tabPage src="matReq.asp?nocache=<%=LoadStamp%>" ></iframe>
	<iframe id=jpPage class=tabPage src="JobPacks.asp?nocache=<%=LoadStamp%>" ></iframe>
	<iframe id=orPage class=tabPage src="PurchaseOrders.asp?nocache=<%=LoadStamp%>" ></iframe>
	
</div>                

</body>
</html>
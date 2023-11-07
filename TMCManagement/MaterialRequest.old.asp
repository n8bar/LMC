<!--#include file="../TMC/RED.asp" -->
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
		Gebi('ListBody').style.height=document.body.offsetHeight-H('Top')+0+('px');
	}
	window.onload=window.onresize;
</script>

<link type="text/css" rel=stylesheet href="Library/CSS_DEFAULTS.css" media="screen"/>
<link type="text/css" rel=stylesheet href="Library/ListsCommon.css" media="all"/>
<link type="text/css" rel=stylesheet href="Materials/Materials.css" media="all"/>
<link type="text/css" rel=stylesheet href="Library/dhtmlgoodies_calendar.css?random=20051112" media=all />
<style media="all">
	body { min-height:480px; }
	#Top { height:5%; max-height:64px; background:none; }
	#selProj {float:left;}
	#ListBody { height:95%; margin-top:0; z-index:0; } 
	#list {border:none; width:100%; height:100%;}
</style>
</head>
<body>

<div id=Modal onMouseMove="ModalMouseMove(event,'AddPartContainer');" align="center">
	<div id="AddPartContainer"> 
		<div id="AddPartTitle" onmousedown="PartsMouseDown(event)" onmouseup="PartsMouseUp(event)" onMouseMove="ModalMouseMove(event,'AddPartContainer')" onselectstart="return false;" >PARTS LIST SEARCH</div>
		<iframe id="AddPartBox" class="AddPartBox" src="PartsInterface.asp?BoxID=AddPartContainer&ModalID=Modal&MM=parent.PartsMouseMove(event,'AddPartContainer')&MD=parent.PartsMouseDown(event)&MU=parent.PartsMouseUp(event)"></iframe>
	</div>
	<div style="width:100%; height:30%;"></div>
	<img src=../Images/roller.gif /><br/>
	<div id=modalStatus></div>
</div>
<%
ProjOpt=""
If Session("mrListProj") = "" Then ProjOpt="<option value=0 >Project:</option>"
%>
<table id=Top class=Toolbar >
<tr >
	<td width=80%> 
		<select id=selProj class=tButton onChange="Gebi('list').src='materialRList.asp?ProjID='+SelI(this.id).value"><%=ProjOpt%><%ProjectOptionList("active")%></select>
	</td>
	<td width=20%>
		<button id=ReloadFrame class=tButton32 onClick="noCacheReload();" title="Reload Tab"/><img src="../Images/reloadblue24.png" /></button>
	</td>
</tr>
</table>
<div id="ListBody" align="center">
	
	<iframe id=list src="materialRList.asp?nocache=<%=LoadStamp%>" ></iframe>
</div>                

</body>
</html>
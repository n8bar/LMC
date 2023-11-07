<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Labor Interface</title>
<!--#include file="../../TMC/RED.asp" -->
<%
	boxID=request.QueryString("BoxID")
	modalID=request.QueryString("ModalID")
	MouseMoveEvent=request.QueryString("MM")
	MouseDownEvent=request.QueryString("MD")
	MouseUpEvent=request.QueryString("MU")
%>
<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="oldLaborInterfaceAJAX.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>
<script type="text/javascript">
	var boxID='<%=boxID%>';
	function AddLabor(LaborID)	{	parent.AddLabor(LaborID);}
	
	function ShowEditor() { Gebi('Modal').style.display='block'; Gebi('EditBox').style.display='block'; }
	function HideEditor() { Gebi('Modal').style.display='none'; Gebi('EditBox').style.display='none'; }
	
	function EditLabor(LaborID) { 
		ShowEditor();
		
	}
</script>
<link rel="stylesheet" href="../Library/CSS_DEFAULTS.css" media="screen">
<style>
html,body{overflow:hidden; background:#CCC; padding:0; margin:0; height:100%; width:100%;}

#HeadingDiv{width:100%; height:20%; overflow:hidden;}
.Search{height:25px; padding:3px 0px 0px 0px; margin:0; z-index:202100; }
.Label{float:right; padding:5px 4px 0px 0px; margin:0; font-family:Arial,Helvetica,sans-serif; font-size:11px; font-weight:bold; text-align:right; color:#FFF; z-index:202100; }
.SearchTxt{float:right; padding:0; margin:0px 5px 0px 0px; font-family:Arial,Helvetica,sans-serif; font-size:13px; font-weight:bold; text-align:left; color:#000; z-index:202200; }
.SearchBtn{float:right; padding:0; margin:1px 6px 0px 0px; font-family:Arial,Helvetica,sans-serif; font-size:11px; font-weight:bold; text-align:center; color:#000; z-index:202200; }
.HeadItems{width:98%; background:#F3F4CC; float:left; height:16px; overflow:hidden; white-space:nowrap; margin:5px 5px 0px 1%; padding:0; font-family:Arial,Helvetica,sans-serif; font-size:10px; font-weight:bold; text-align:left; color:#000; border:1px solid #000; }
	.HeadItem{ float:left; height:16px; overflow:hidden; white-space:nowrap; margin:0; padding:0; display:inline; }
#Results{overflow-x:hidden; height:80%; width:98%; background:#DDD; float:left; padding:0px 0px 0px 0px; margin:0px 0px 0px 1%; font-family: Arial,Helvetica,sans-serif; font-size: 13px; font-weight:normal; text-align:left; color:#000; border:1px solid #000; z-index:202000; }
.Close{	position:relative; float:Left; height:25px; width:40px; background:#FF; padding:0px 0px 0px 0px; margin:1px 0px 0px 12px; font-family: Arial,Helvetica,sans-serif; font-size: 13px; font-weight:normal; text-align:center; color:#000; z-index:202000; }

#Modal { background:#B15670; display:none; left:0; height:100%; opacity:.5; position:absolute; top:0; width:100%; z-index:300000; }
#EditBox {background:#fff; border-radius:6px; display:none; height:90%; left:10%; overflow:hidden; position:absolute; top:5%; width:80%; z-index:300100; }
#EditBoxTitle{color:white; background:#B15670; font-weight:bold; width:100%; }
</style>
</head>
 
<body onmousemove="<%=MouseMoveEvent%>;" onselectstart="return false;">
	
	<div id=Modal></div>
	
	<div id=EditBox >
		<div id=EditBoxTitle>
			Labor Editor
			<button style="float:right; height:20px; font-weight:bold; line-height:16px;" onClick=HideEditor(); >X</button>
		</div>
		&nbsp;&nbsp;&nbsp;Coming soon...<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <small style="color:#aaa;"><small> I hope </small></small>
		
	</div>

	<div id="HeadingDiv" onselectstart="return false;">
		<div id="Search" class="Search">
			<button id="Close" class="Close" onClick="PGebi('<%=boxID%>').style.display='none'; PGebi('<%=modalID%>').style.display='none';">Close</button>
			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
			<button id="New" onClick="EditLabor(0);">New Labor</button>
			<input onClick="SearchLabor();" id="SearchLaborDescBtn" class="SearchBtn" type="button" value="Search" />
			<div class="SearchTxt"><input name="SearchLaborTxt" id="SearchLaborTxt"type="text" size="48" maxlength="48"/></div>
		</div>
        
		<div class="HeadItems borderSizing">
			<div class="HeadItem borderSizing" style="width:5%; border-left:none; ">&nbsp;Add</div>
			<div class="HeadItem borderSizing" style="width:2.5%; border-left:none; ">&nbsp;E</div>
			<div class="HeadItem borderSizing" style="width:15%; ">&nbsp;Category</div>
			<div class="HeadItem borderSizing" style="width:15%; ">&nbsp;Labor Name</div>
			<div class="HeadItem borderSizing" style="width:55%; ">&nbsp;Description</div>
			<div class="HeadItem borderSizing" style="width:7.5%; ">Hourly Rate&nbsp;</div>
		</div>
  </div>
	
	<iframe id="Results" class="borderSizing" src="oldLaborSearch.asp">Labor</iframe>
	
</body>
</html>
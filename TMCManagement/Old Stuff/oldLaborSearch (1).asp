<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Labor Interface</title>
<!--#include file="../../TMC/RED.asp" -->
<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="oldLaborInterfaceAJAX.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>

<link rel="stylesheet" href="../Library/CSS_DEFAULTS.css" media="screen">
<style>
html,body{width:100%; height:100%; padding:0; margin:0;}

/*Labor Search Box Items ////////////////////////////////////////////////////*/
.ItemRow {	height:22px; width:100%; overflow:hidden; white-space:nowrap; background:#FFF; margin:0; padding:0; border-bottom: 1px solid #000; }
.Item {float:left; height:22px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis; margin:0; padding:0; font-family:Arial,Helvetica,sans-serif; font-size:12px; font-weight:normal; text-align:left; color:#000; }
.ItemAdd {height:20px; margin:auto; padding:0; position:static; font-family: Arial,Helvetica,sans-serif; font-size:10px; font-weight:normal; text-align:center; color:#000; }

.editButton { background-image:url(../../images/Pencil-gray16.png); border-radius:4px; height:16px; margin:1px auto 0 auto; width:16px; }
.editButton:hover{background-color:rgba(255,255,255,.25); background-image:url(../../images/Pencil-icon16.png); border:1px outset; height:18px; width:18px;}
.editButton:active{ border:1px inset; height:18px; width:18px;}

.saveButton { background-image:url(../../images/Pencil-gray16.png); border-radius:4px; height:16px; margin:1px auto 0 auto; width:16px; }
.saveButton:hover{background-color:rgba(255,255,255,.25); background-image:url(../../images/Pencil-icon16.png); border:1px outset; height:18px; width:18px;}
.saveButton:active{ border:1px inset; height:18px; width:18px;}
</style>
</head>

<body>
<%
Where=" WHERE Name LIKE '%"&SearchTxt&"%' OR Description LIKE '%"&SearchTxt&"%' "
If SearchTxt="" Or IsNull(SearchTxt) Then Where =""
SQL = "SELECT LaborID, Category, Name, Description, RateCost FROM Labor"&Where&" ORDER  BY Category, Name"
'% ><%=SQL%><%
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring	

rNum=0
Do While Not rs.EOF
	rNum=rNum+1
	
	lID=rs("LaborID")
	%>
	<div id="Labor<%=lID%>" class="ItemRow borderSizing" >
		<span class="Item borderSizing" style="background-color:#ddd; text-align:center; width:5%; ">
			<button class="ItemAdd borderSizing" onClick="parent.AddLabor(<%=lID%>);">Add</button>
		</span>
		<span class="Item borderSizing" style="background-color:#ddd; border-left: 1px solid #000; text-align:center; width:2.5%;">
			<div class=editButton onClick="parent.EditLabor(<%=lID%>);"></div>
		</span>
		<span class="Item borderSizing" style="width:15%; border-left: 1px solid #000; display:inline;"><%=rs("Category")%></span>
		<span class="Item borderSizing" style="width:15%; border-left: 1px solid #000; display:inline;"><%=DecodeChars(rs("Name"))%></span>
		<span class="Item borderSizing" style="width:55%; border-left: 1px solid #000; display:inline;"><%=rs("Description")%></span>
		<span class="Item borderSizing" style="width:7.5%; border-left: 1px solid #000; display:inline; text-align:right;"><%=formatCurrency(rs("RateCost"))%>&nbsp;</span>
	</div>
	<%
	Response.Flush()
	rs.MoveNext 
Loop
Set rs = nothing				 
%>
	
</body>
</html>
<!DOCTYPE html> <!--  PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd" > -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="common.asp" -->

<script type="text/javascript" src="../tmcManagement/modules/CommonAJAX.js"></script>
<script type="text/javascript" src="../tmcManagement/modules/rcstri.js"></script>


<script type="text/javascript">

function inventoryAdjust(rowI,Amt) {
	var qtyBox=Gebi('Inventory'+rowI);
	var qty=qtyBox.innerHTML*1;
	var newQty=qty+(Amt*1);
	var pID=Gebi('row'+rowI).getAttribute('value');
	if (newQty<0) {
		if( confirm('Quantities cannot be negative. \n click OK to zero this out.')) {newQty=0;} else {return false;}
	}
	WSQLU('Parts','Inventory',newQty,'PartsID',pID);
	qtyBox.innerHTML=newQty;
}

function saveInventory(rowI,Box) {
	if (Box.getAttribute('contentEditable')=='true') {
		var pID=Gebi('row'+rowI).getAttribute('value');
		WSQLU('Parts','Inventory',Box.innerHTML,'PartsID',pID);
		Box.setAttribute('contentEditable','false');
		Box.style.background='none';		
	}
}

function manualInventory(rowI,Box) {
	if (Box.getAttribute('contentEditable')=='true') {
	}
	else {
		//var miID='manualInventory'+rowI;
		//var keypress=' onkeypress="onlyAccept(event,\'0123456789.\',this);" '
		//var dblClick=' onDblClick="saveInventory('+rowI+',this);" ';
		//Box.innerHTML='<input id='+miID+' '+dblClick+' '+keypress+' style="width:100%; height:100%;" value="'+Box.innerHTML+'" />';
		Box.style.background='#FFF';
		Box.setAttribute('contentEditable','true');
		Box.focus;
	}
}

</script>

<link rel="stylesheet" href="mobile.css" media="screen">

<style type="text/css" media="all">
html{ margin:0 0 0 0; width:100%; height:100%; overflow:hidden; /*background:rgba(0,128,128,.025);*/ text-align:center; font-family:Arial;
 border-radius:3px; border-top:none; border-bottom-left-radius:11px; border-bottom-right-radius:11px;
}
body{ margin:0 0 0 0; width:100%; min-width:240px; height:100%; min-height:240px; overflow-x:hidden; overflow-y:scroll; }


a { width:100%; height:48px; display:block; float:left; border-radius:2px; margin:0; font-size:36px; line-height:48px; text-decoration:none; color:white; opacity:.75;  
 font-family: "Arial Narrow", "Agency FB", "Swis721 LtCn BT"; font-weight:bold;
 background:-moz-linear-gradient(top, rgba(0,120,192,.75), /*rgba(0,120,192,.5) 50%,*/ rgba(0,108,172,.5));
 background:-webkit-gradient(linear,0 100%,0 0, from(rgba(0,120,192,.75)) /*,color-stop(.5,  rgba(0,120,192,.5))*/, to(rgba(0,108,172,.5)));
}
a:focus { background-color:white; outline:invert thin solid; opacity:1; }
a:active { background-color:black; }
a:hover { }
.space { width:100%; height:48px;}

#Search { width:80%; height:10%; max-height:64px; min-height:40px; margin:2px 0 0 10%; padding:0; background:rgba(0,192,192,.5); border-radius:24px;
 background:-moz-linear-gradient(bottom, rgba(0,192,192,.75), rgba(0,144,144,.5) 50%, rgba(0,96,96,.5));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(0,192,192,.75)) ,color-stop(.5,  rgba(0,144,144,.5)), to(rgba(0,96,96,.5)));
}
#innerSearch {position:relative; width:100%; top:15%; }
#SearchBox { width:50%; border-radius:4px; max-height:24px; line-height:24px; white-space:nowrap; }

#itemsHead { width:90%; margin:2px 0 0 5%; overflow:hidden; max-height:32px; min-height:20px; height:5%; line-height:24px;
 border:rgba(0,0,0,.333) solid 1px; border-left-width:2px; border-radius:10px; border-bottom-left-radius:4px; border-bottom-right-radius:4px;
 background:-moz-linear-gradient(bottom, rgba(0,192,192,.125), rgba(0,144,144,.25) 50%, rgba(0,96,96,.25));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(0,192,192,.125)) ,color-stop(.5,  rgba(0,144,144,.25)), to(rgba(0,96,96,.25)));
}
#itemsHead div{ float:left; border-left:rgba(255,255,255,.75) solid 1px; border-right:rgba(0,0,0,.25) solid 1px; height:100%; }
#itemsHead:first-child{border-top-left-radius:9px;}
#itemsHead:last-child{border-top-right-radius:9px;}


.row {width:100%; height:52px; overflow:hidden; margin:8px 0 2px 0; border-radius:5px; font-size:14px; 
 background:-moz-linear-gradient(bottom, rgba(224,255,255,.25), /*rgba(0,192,192,.5) 50%,*/ rgba(128,144,144,.25));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(224,255,255,.25)) /*,color-stop(.5, rgba(0,192,192,.5))*/, to(rgba(128,144,144,.25)));
}
.row:first-child{border-top-left-radius:12px; border-top-right-radius:12px; }
.row:last-child{border-bottom-right-radius:12px; border-bottom-left-radius:12px; }

.row div { float:left; border-left:rgba(255,255,255,.75) solid 1px; border-right:rgba(0,0,0,.25) solid 1px; height:32px;}
.row div:nth-child(2) { border-top-left-radius:4px; border-bottom-left-radius:4px; }
.row div:last-child { border-top-right-radius:4px; border-bottom-right-radius:4px; }

.rowTop { height:20px !important; width:100%; float:left; font-size:10px; line-height:10px; text-align:left; border:none !important; color:#888; overflow:hidden;
 background:-moz-linear-gradient(top, rgba(224,255,255,.25), /*rgba(0,192,192,.5) 50%,*/ rgba(128,144,144,.25));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(224,255,255,.25)) /*,color-stop(.5, rgba(0,192,192,.5))*/, to(rgba(128,144,144,.25)));
}
.rowTop div { height:100% !important; }
.rowTop div:last-child { border-right:none; }

.rowTop div button { height:18px; line-height:18px; border-radius:6px; font-size:10px; }

.match { line-height:30px; height:30px; width:75%; color:white; margin:0 0 0 12.5%; padding:0; float:left; border:1px solid #999; border-radius:8px;
 background:-moz-linear-gradient(top, rgba(112,255,112,.6667), /*rgba(0,192,192,.5) 50%,*/ rgba(64,144,64,.6667));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(112,255,112,.6667)) /*,color-stop(.5, rgba(0,192,192,.5))*/, to(rgba(64,144,64,.6667)));
}
.match:active {opacity:1;}

</style>

<%

ss=Request.QueryString("SearchString")
upc=Request.QueryString("upc")

If ss="" Then
	%><i>No Results</i><%
	Response.End()
End If

%>
</head>

<body >
	<!-- div class=row id=MTrow value="0" style="opacity:0; height:24px;" >&nbsp;</div -->

<%

Where=""
Where=Where&" PartNumber LIKE '%"&ss&"%'"
Where=Where&" OR Category1 LIKE '%"&ss&"%'"
Where=Where&" OR Category2 LIKE '%"&ss&"%'"
Where=Where&" OR Manufacturer LIKE '%"&ss&"%'"
Where=Where&" OR Model LIKE '%"&ss&"%'"
Where=Where&" OR System LIKE '%"&ss&"%'"

SortBy=session("InventoryOrder")
If SortBy="" Then SortBy="PartsID"

SQL ="SELECT PartsID, PartNumber, Inventory, InventoryLevel, Manufacturer, Model, Description, Cost+(Cost*Margin/100) AS Retail, Category1, System, UPC FROM Parts WHERE "&where&" ORDER BY "&SortBy
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring
if rs.eof then 
	%><i>No Results</i><%
	Response.End()
end if
lI=0
Do until rs.Eof Or lI > 4096
	lI=lI+1
	%>
	<div class=row id=row<%=lI%> value="<%=rs("PartsID")%>" >
		<div class=rowTop id=rb<%=lI%>>
			<div style="width:30%;"><b>Name:</b> <%=rs("Model")%></div>
			<div style="width:20%;"><b>Mfr:</b> <%=rs("Manufacturer")%></div>
			<div style="width:20%;"><%=rs("Description")%></div>
			<div id=System<%=lI%> style="width:15%;"><%=rs("System")%></div>
			<div style="width:15%;"><%=rs("UPC")%></div>
		</div>
		<div id=PN<%=lI%> style="width:30%; <%=bS%> " ><%=rs("PartNumber")%></div>
		<div id=Retail<%=lI%> style="width:20%; line-height:32px;"><%=formatCurrency(rs("Retail"))%></div>
		<div id=Inventory<%=lI%> style="width:20%; <%=bS%> line-height:32px;" onClick="manualInventory(<%=lI%>,this); this.focus;" onblur="saveInventory(<%=lI%>,this);" onkeypress="onlyAccept(event,'0123456789.',this);" ><%=rs("Inventory")%></div>
		<div id=Category<%=lI%> style="width:15%; line-height:32px;"><%=rs("Category1")%></div>
		<div style="width:15%;"><button id=match<%=lI%> class=match onclick="parent.matchPart(<%=rs("PartsID")%>);" >Match</button></div>
	</div>
	<%
	Response.Flush()
	rs.MoveNext
Loop
%>
</body>
</html>

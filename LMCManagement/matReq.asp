<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Materials</title>
<!--#include file="Common.asp" -->
<script type="text/javascript" src="Materials/matReq.js?nocache=<%=LoadStamp%>"></script>
<script type="text/javascript" src="Materials/matReqAJAX.js?nocache=<%=LoadStamp%>"></script>
	<%
	 
	ProjID=Request.QueryString("ProjID")
	If ProjID="" or ProjID="0" Then
		'ProjID=Session("mrListProj")
		If ProjID="" or ProjID="0" Then
			%>
			<select id=Projects onChange="<%="window.location='matReq.asp?nocache="%><%=LoadStamp%>&ProjID='+SelI(this.id).value;"><option value="" >Choose a project:</option><%ProjectOptionList("active")%></select>
			</body>
			</html>
			<%
			response.End()
		End If
		%>
		<script>
		if(!!PGebi('selProj')) {
			var opts=PGebi('selProj').childNodes;
			for(o=0;o<opts.length;o++) {
				if(opts[o].value==ProjID) {
					PGebi('selProj').selectedIndex=o;
					break;
				}
			}
		}
		</script>
		<%
	Else
		Session("mrListProj")=ProjID
	End If
	
	Function dcF(recordSetObj,fieldName)
		dcF=dcField(recordSetObj,fieldName)
	End Function
	%>
<script>
	var noCache='<%=Request.QueryString("nocache")%>';
	var empID=<%=session("EmpID")%>;
	var mrId=0;

	var ProjID=0<%=ProjID%>;
	
	//var ProjectSelect='<select id=Projects onChange="window.location=\'MaterialRequest.asp?nocache=<%=LoadStamp%>&ProjID=\'+SelI(this.id).value;"><option>Choose a project:</option><%=ProjectListChoose(ProjID,"active")%></select>';
	
	var sysNames=new Array;
	var sysIDs=new Array;
</script>

<link type="text/css" rel=stylesheet href="Library/CSS_DEFAULTS.css?nocache=<%=LoadStamp%>" media="screen"/>
<link type="text/css" rel=stylesheet href="Materials/matReq.css?nocache=<%=LoadStamp%>" media="all"/>
<!-- link type="text/css" rel=stylesheet href="ListsCommon.css?nocache=<%=LoadStamp%>" media="all"/ -->
<link type="text/css" rel=stylesheet href="Library/dhtmlgoodies_calendar.css?random=20051112&nocache=<%=LoadStamp%>" media=all />
<%
%>
</head>
<body onLoad="loadMRs(); ">
<div id=EmpOptionList style="display:none;" ><%EmployeeOptionList("active")%></div>
<div id=Modal onMouseMove="ModalMouseMove(event,'AddPartContainer');" align="center">
	<div id="AddPartContainer" draggable="auto"> 
		<div id="AddPartTitle" onmousedown="PartsMouseDown(event)" onmouseup="PartsMouseUp(event)" onMouseMove="ModalMouseMove(event,'AddPartContainer')" onselectstart="return false;" >PARTS LIST SEARCH</div>
		<iframe id="AddPartBox" class="AddPartBox" src="PartsInterface.asp?BoxID=AddPartContainer&ModalID=Modal&MM=parent.PartsMouseMove(event,'AddPartContainer')&MD=parent.PartsMouseDown(event)&MU=parent.PartsMouseUp(event)"></iframe>
	</div>
	<div style="width:100%; height:30%;"></div>
	<img src=../Images/roller.gif /><br/>
	<div id=modalStatus class="w100p h32 taC"></div>
</div>
<div id=calDivDot class="w1 h1">&nbsp;</div>
<div id=top>
	<div id=topLeft>
		<h3 style="margin-bottom:0;">
			<span>Bill Of Materials:<small>(from bid)</small></span>
			<select id=Projects onChange="window.location='matReq.asp?nocache=<%=LoadStamp%>&ProjID='+SelI(this.id).value;">
				<option>Choose a project:</option>
				<%=ProjectListChoose(ProjID,"active")%>
			</select>
		</h3>
	</div>
	<div id=topRight>
		<h3 style="margin-bottom:0;">&nbsp;Materials Requested:<div id=Reload class=tButton24 onClick="noCacheReload();" title="Reload"/><img src="../Images/reloadblue24.png" width=100% height=100% /></div></h3>
	</div>
</div>
<div id=left style="background:url(../images/Products272-faded.png) no-repeat bottom left; " onscroll="leftScroll();"> 
	<div id=bidItemsHead class="ItemsHead" style="position:relative;" >
		<div style="width:13%;"><small>Quantity</small></div>
		<div style="width:14%;">Manufacturer</div>
		<div style="width:20%;">Part Number</div>
		<div style="width:20%;">Cost</div>
		<div style="width:21%;">Total</div>
		<div class="w6p p0" ><button class=tButton0x24 style="float:none;" onClick="copyPart(0,0)"><img height=20 src="../images/CyanDblRight24.png"/></button></div>
		<div class="w6p p0" ><button class=tButton0x24 style="float:none;" onClick="showAddPart();"><img height=16 src="../images/plus_16.png"/></button></div>
	</div>	
	<%
	SQL0="SELECT SectionID, Section FROM Sections WHERE ProjectID="&ProjID&" AND ExcludeSec=0"
	Set rs0=Server.CreateObject("AdoDb.RecordSet")
	rs0.Open SQL0, REDConnString
	
	r=0
	sysI=-1
	Do until rs0.EOF
		sysI=sysI+1
		%><script>
			sysNames[<%=sysI%>]='<%=DecodeChars(rs0("Section"))%>';
			sysIDs[<%=sysI%>]='<%=rs0("SectionID")%>';
		</script><%
		
		SQL1="SELECT * FROM BidItems WHERE SecID="&rs0("SectionID")&" AND Type='Part' ORDER BY PartID"
		Set rs1=Server.CreateObject("AdoDb.RecordSet")
		rs1.Open SQL1, REDConnString
		
		Do Until rs1.EOF
			r=r+1
			%>
			<div id=biRow<%=r%> class=row value="<%=rs1("BidItemsID")%>" title="PartsID:<%=rs1("PartID")%>" >
				<div style="display:none;" id=PartsID<%=r%> ><%=rs1("PartID")%></div>
				<div class=w14p id=biQty<%=r%> ><%=rs1("Qty")%></div>
				<div class=w14p id=biMfr<%=r%> ><%=dcF(rs1,"Manufacturer")%></div>
				<div class=w20p id=biPN<%=r%> ><%=dcF(rs1,"ItemName")%></div>
				<div class=w20p id=biCost<%=r%> ><%=formatCurrency(rs1("Cost"))%></div>
				<div class=w21p id=biTotal<%=r%> ><%=formatCurrency(("0"&rs1("Qty"))*rs1("Cost"))%></div>
				<div class="w10p taC">
					<button class="tButton0x24 copyButton" style="float:none;" onClick="copyPart(<%=r%>,<%=rs1("BidItemsID")%>)"><img height=20 src="../images/CyanDblRight24.png"/></button>
				</div>
				<div class=rowBottom id=biDesc<%=r%> ><%=dcF(rs1,"ItemDescription")%></div>
			</div>
			<%
			rs1.MoveNext
		Loop
		
		rs0.MoveNext
	Loop
	%>
	<script>var biRows=0<%=r+1%>;</script>
	<div id=EmptyRow style="display:none;">
		<div id=biRow_INDEX_ class=row value="" title="PartsID:_PID_" >
			<div style="display:none;" id=PartsID_INDEX_ ></div>
			<div class=w14p id=biQty_INDEX_ ></div>
			<div class=w14p id=biMfr_INDEX_ ></div>
			<div class=w20p id=biPN_INDEX_ ></div>
			<div class=w20p id=biCost_INDEX_ ></div>
			<div class=w21p id=biTotal_INDEX_ ></div>
			<div class="w10p taC">
				<button class="tButton0x24 copyButton" style="float:none;" onClick="copyPart(_INDEX_,_BIID_);"><img height=20 src="../images/CyanDblRight24.png"/></button>
			</div>
			<div class=rowBottom id=biDesc_INDEX_ ></div>
		</div>
	</div>
</div>	
<div id=right>&nbsp;
	<div id=lBottom></div>
</div>
</body>
</html>
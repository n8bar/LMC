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
	var empID=<%=session("EmpID")%>;
	var mrId=0;

	<% 
	ProjID=Request.QueryString("ProjID")
	If ProjID="" or ProjID="0" Then
		ProjID=Session("mrListProj")
		If ProjID="" or ProjID="0" Then
			%><%="Choose a project↑</body></html>"%><%
			response.End()
		End If
		%>
		if(!!PGebi('selProj')) {
			var opts=PGebi('selProj').childNodes;
			for(o=0;o<opts.length;o++) {
				if(opts[o].value==ProjID) {
					PGebi('selProj').selectedIndex=o;
					break;
				}
			}
		}
		<%
	Else
		Session("mrListProj")=ProjID
	End If
	%>
	var ProjID=0<%=ProjID%>;
</script>

<link type="text/css" rel=stylesheet href="Library/CSS_DEFAULTS.css" media="screen"/>
<!-- link type="text/css" rel=stylesheet href="ListsCommon.css" media="all"/>
<link type="text/css" rel=stylesheet href="Materials.css" media="all"/ -->
<link type="text/css" rel=stylesheet href="Library/dhtmlgoodies_calendar.css?random=20051112" media=all />
<style media="all">
	html{ height:100%; width:100%; margin:0 0 20px 0; overflow:hidden;}
	body{ height:100%; width:100%; margin:0 0 20px 0; overflow:hidden; padding:0 2.5% 0 2.5%;}

	#left,#right {float:left; width:47%; height:100%; overflow:auto; }
	.ItemsHead { width:95%; height:32px; float:left; overflow:hidden; white-space:nowrap; border:1px solid #066; margin:0 2.5% 0 0; min-width:0;
	border-radius:3px; border-top-left-radius:8px; border-top-right-radius:8px;
	background:-moz-linear-gradient(top, rgba(192, 255, 255, .75), /*rgba(0, 192, 192, .5) 50%,*/ rgba(96, 128, 128, .75));
	background:-webkit-gradient(linear,0 0,0 100%, from(rgba(192, 255, 255, .75)) /*,color-stop(.5, rgba(0, 192, 192, .5))*/, to(rgba(96, 128, 128, .75)));
	}
	.ItemsHead div { float:left; display:block; text-align:center; padding:2px 0; overflow:hidden; white-space:nowrap; text-overflow:ellipsis; }
	.row {width:95%; height:48px; float:left; overflow:hidden; white-space:nowrap; border:1px solid #099; margin:8px 0 0 0; min-width:0; border-radius:3px;
	background:-moz-linear-gradient(top, rgba(224, 255, 255, .25), /*rgba(0, 192, 192, .5) 50%,*/ rgba(128, 144, 144, .25));
	background:-webkit-gradient(linear,0 0,0 100%, from(rgba(224, 255, 255, .25)) /*,color-stop(.5, rgba(0, 192, 192, .5))*/, to(rgba(128, 144, 144, .25)));
	}
	.row div {float:left; height:28px; line-height:28px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis; margin:0; padding:0; }
	.rowBottom {width:100%; height:20px !important; line-height:20px !important; font-size:14px; font-family:"Swis721 LtCn BT", "Arial Narrow", Narrow;
	background:-moz-linear-gradient(top, rgba(224, 224, 224, .25), /*rgba(0, 192, 192, .5) 50%,*/ rgba(128, 128, 128, .25));
	background:-webkit-gradient(linear,0 0,0 100%, from(rgba(224, 224, 224, .25)) /*,color-stop(.5, rgba(0, 192, 192, .5))*/, to(rgba(128, 128, 128, .25)));
	}
	#newMR label{color:#088; }
	.wsnw {white-space:nowrap;}
	#cal {cursor:pointer; width:24px; height:24px; float:left; background-image:url(../Images/Cal24x24.gif);}
	#cal:hover{ background-image:url(../images/Cal24x24Rollover.gif);}
</style>
<%
%>
</head>
<body onLoad="loadMRs();">
	<div id=calDivDot class="w1 h1">&nbsp;</div>
	<div id=left>
	</div>
	<div id=right>
		<h3>Bill Of Materials:</h3>
		<div id=requestHead class="ItemsHead" >
			<div class="w10p p0" ><button class=tButton0x24 style="float:none;" onClick="copyPart(0,0)"><img height=20 src="../images/CyanDblLeft24.png"/></button></div>
			<div style="width:14%;"><small>Quantity</small></div>
			<div style="width:14%;">Manufacturer</div>
			<div style="width:20%;">Part Number</div>
			<div style="width:20%;">Cost</div>
			<div style="width:21%;">Total</div>
		</div>	
		<%
		SQL0="SELECT SystemID FROM Systems WHERE ProjectID="&ProjID&" AND ExcludeSys=0"
		Set rs0=Server.CreateObject("AdoDb.RecordSet")
		rs0.Open SQL0, REDConnString
		
		r=0
		Do until rs0.EOF
		
			SQL1="SELECT * FROM BidItems WHERE SysID="&rs0("SystemID")
			Set rs1=Server.CreateObject("AdoDb.RecordSet")
			rs1.Open SQL1, REDConnString
			
			Do Until rs1.EOF
				r=r+1
				%>
				<div id=biRow<%=r%> class=row value="<%=rs1("BidItemsID")%>" title="PartsID:<%=rs1("PartID")%>" >
					<div class="w10p taC">
						<button class=tButton0x24 style="float:none;" onClick="copyPart(<%=r%>,<%=rs1("BidItemsID")%>)"><img height=20 src="../images/CyanDblLeft24.png"/></button>
					</div>
					<div style="display:none;" id=PartsID<%=r%> ><%=rs1("PartID")%></div>
					<div class=w14p id=Qty<%=r%> ><%=rs1("Qty")%></div>
					<div class=w14p id=Mfr<%=r%> ><%=rs1("Manufacturer")%></div>
					<div class=w20p id=PN<%=r%> ><%=rs1("ItemName")%></div>
					<div class=w20p id=Qty<%=r%> ><%=formatCurrency(rs1("Cost"))%></div>
					<div class=w21p id=Qty<%=r%> ><%=formatCurrency(rs1("Qty")*rs1("Cost"))%></div>
					<div class=rowBottom ><%=rs1("ItemDescription")%></div>
				</div>
				<%
				rs1.MoveNext
			Loop
			
			rs0.MoveNext
		Loop
		%>
	</div>	
</body>
</html>
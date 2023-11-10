<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title>Project List</title>

<!-- <script type="text/javascript" src="jQuery.js"></script> -->
<!-- <script type="text/javascript" src="gears_init.js"></script> -->
<script type="text/javascript" src="ProjectsJS.js"></script>
<script type="text/javascript" src="ProjectsAJAX.js"></script>
<script type="text/javascript" src="../../LMCManagement/Old Stuff/rcstri.js"></script>
<script type="text/javascript" src="../../LMCManagement/Old Stuff/SqlAjax.js"></script>
<!-- script type="text/javascript" src="https://wave-api.appspot.com/public/embed.js"></script> 
<script type="text/javascript" src="Library/WaveEmbed.js"></script>  -->
<!-- #include file="RED.asp" -->

<link rel="stylesheet" href="../../LMCManagement/Old Stuff/CSS_DEFAULTS.css" media="screen"/>
<link rel="stylesheet" href="ProjectsCSS.css" media="screen"/>

</head>

<body style="overflow-x:hidden; overflow-y:scroll;" onLoad="setTimeout('alignColumns();',300);">
<%
Dim ProgArr(6)

SQL0= "SELECT * FROM Progress"
Set rs0=Server.CreateObject("ADODB.Recordset")
rs0.Open SQL0, REDconnstring	

Dim P: P=0
Do Until rs0.EOF
	P=P+1
	ProgArr(P)=rs0("BGColor")
	rs0.MoveNext
Loop

Set rs0=Nothing

Dim Active: Active=Request.QueryString("Active")


SQL="SELECT * FROM Projects WHERE Active='"&Active&"' AND Obtained='True'"
Set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring	


Dim LoopNum

LoopNum=0
Green="E0EFE8"
Purple="E8E0EF"
AltBG=Purple

Do Until rs.EOF
	LoopNum=LoopNum+1
	
	'Gebi('ProjectOverlayTxt').innerHTM.
	If AltBG =Green Then AltBG=Purple Else AltBG=Green
	%>
	<div id="RowContainer<%=LoopNum%>" class="RowContainer" style="background:#<%=AltBG%>;">
<script type="text/javascript">parent.document.getElementById('ProjectOverlay').style.display='none';</script>
	<div id="ItemJobContainer" style="white-space:nowrap; float:left; clear:both; width:100%;">

		<div class="ItemJob" id="ItemJob<%=LoopNum%>">
			&nbsp;<%=DecodeChars(rs("ProjName"))%> &nbsp;
	</div><div class="ProjID"><%=rs("ProjID")%></div></div>
	
	<div id="itemRow<%=LoopNum%>" class="ItemRow" >

		<div class="ItemInfo" title="Manage this project." onClick="parent.parent.Gebi('ProjectsIframe').src='Projman.asp?Projid=<%=rs("ProjID")%>'">
			<div id="InfoBackground<%=LoopNum%>" class="ItemInfoBackground" >&nbsp;</div>
		</div>
	
		<div class="ItemArchive" title="Archive this project." onMouseOver="" onMouseOut="" >
			<div id="ArchiveButton<%=LoopNum%>" class="ItemArchiveButton"> </div>
		</div>
		<div class="ItemTime" title="Clock time on this project."><div class="ItemTimeBackground"></div></div>
		<div class="ItemSch" title="Schedule this project."><div class="ItemSchBackground"></div></div>
<%
		If rs("CustomerID")="" Or IsNull(rs("CustomerID")) Then
			CustName="<em>Customer Not Entered</em>"
		Else
			SQL1 = "SELECT * FROM Customers WHERE CustID="&rs("CustomerID")
			Set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring	
			
			If rs1.EOF Then CustName="<em>Customer #"&rs("CustomerID")&"</em>" Else CustName=rs1("Name")
			
			Set rs1=Nothing
		End If
%>
		<div id="ItemCust<%=LoopNum%>" class="ItemCust"><%=CustName%></div>

		<div id="AttentionButton<%=LoopNum%>" class="ItemAttnButton" onClick="ShowEmployeeList('ProjectManagerName<%=LoopNum%>,<%=rs("ProjID")%>,<%=LoopNum%>)"></div>
		<% PM = rs("RCSPM"):If PM ="" Then PM="<i>Jeff</i>" %>
		<div id="ProjectManagerName<%=LoopNum%>" title="Project Manager" class="ItemAttn"><%=PM%></div>


		<div id="itemsProgress" style="white-space:nowrap; border:0px solid #000; float:right; display:inline; width:198px; min-width:234px;">
	
			<div title="" class="ItemDone" align="center">
				<div id="iPlans<%=LoopNum%>" class="ItemProg" style="background:#<%=ProgArr(rs("Plans"))%>;">&nbsp;</div>
			</div>
			<div title="" class="ItemDone" align="center">
				<div id="iPermits<%=LoopNum%>" class="ItemProg" style="background:#<%=ProgArr(rs("Permits"))%>;">&nbsp;</div>
			</div>
			<div title="" class="ItemDone" align="center">
				<div id="iUnderGround<%=LoopNum%>" class="ItemProg" style="background:#<%=ProgArr(rs("UnderGround"))%>;">&nbsp;</div>
			</div>
			<div title="" class="ItemDone" align="center">
				<div id="iRoughIn<%=LoopNum%>" class="ItemProg" style="background:#<%=ProgArr(rs("RoughIn"))%>;">&nbsp;</div>
			</div>
			<div title="" class="ItemDone" align="center">
				<div id="iRoughInspect<%=LoopNum%>" class="ItemProg" style="background:#<%=ProgArr(rs("RoughInspect"))%>;">&nbsp;</div>
			</div>
			<div title="" class="ItemDone" align="center">
				<div id="iOrderMat<%=LoopNum%>" class="ItemProg" style="background:#<%=ProgArr(rs("OrderMaterials"))%>;">&nbsp;</div>
			</div>
			<div title="" class="ItemDone" align="center">
				<div id="iTrim<%=LoopNum%>" class="ItemProg" style="background:#<%=ProgArr(rs("Trim"))%>;">&nbsp;</div>
			</div>
			<div title="" class="ItemDone" align="center">
				<div id="iFinishInsp<%=LoopNum%>" class="ItemProg" style="background:#<%=ProgArr(rs("FinishInspect"))%>;">&nbsp;</div>
			</div>
			<div title="" class="ItemDone" align="center">
			<div id="iJobFinish<%=LoopNum%>" class="ItemProg" style="background:#<%=ProgArr(rs("JobCompleted"))%>;">&nbsp;</div>
	</div>

	</div>	<!--
 --></div> </div>

<%
	response.Flush()
	rs.MoveNext
Loop
%>
<div id="PlansColumn" class="ProgColumn" style=""></div>
<div id="UndergroundColumn" class="ProgColumn" style=""></div>
<div id="RoughInspColumn" class="ProgColumn" style=""></div>
<div id="TrimColumn" class="ProgColumn" style=""></div>
<div id="DoneColumn" class="ProgColumn" style=""></div>

</body>
</html>

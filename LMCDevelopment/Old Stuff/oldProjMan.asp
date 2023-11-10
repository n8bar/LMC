<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title>Project Management</title>

<!-- <script type="text/javascript" src="jQuery.js"></script> -->
<!-- <script type="text/javascript" src="gears_init.js"></script> -->
<script type="text/javascript" src="ProjMan.js"></script>
<script type="text/javascript" src="ProjManAJAX.js"></script>
<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>
<SCRIPT type="text/javascript" src="../Library/dhtmlgoodies_calendar.js?random=20060118"></script>
<!-- script type="text/javascript" src="https://wave-api.appspot.com/public/embed.js"></script> 
<script type="text/javascript" src="Library/WaveEmbed.js"></script>  -->

<!-- #include file="../../LMC/RED.asp" -->


<%
Dim ProjID:
ProjID= Request.QueryString("ProjID")

If ProjID = "" or (isNull(ProjID)) then ProjID=8702

%>
<script type="text/javascript">
var accessUser='n8';
var ProjID=<%=ProjID%>; //Copy the ASP ProjID to a JS ProjID
</script>

<link rel="stylesheet" href="../Library/CSS_DEFAULTS.css" media="screen"/>
<link rel="stylesheet" href="ProjMan.css" media="screen"/>
<link type="text/css" rel="stylesheet" href="../Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">

</head>

<body onLoad="" onResize="Resize();">

<%
	SQL = "SELECT * FROM Projects WHERE ProjID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	If not rs.EOF then
%>

<div id="Modal" class="Modal"></div>

<div id="OverAllContainer" class="OverAllContainer">

<div id="Left" class="Left">
	<div id="LeftModal" class="Modal"></div>

	<button id="BackButton" class="BackButton" title="◄Back to projects" onClick="Back2List();">◄Back to projects</button>
	
<br/>
<br/>
<%
	Dim ProjName: ProjName=DecodeChars(rs("ProjName"))
	Dim Address: DecodeChars(Address=rs("ProjAddress"))
	'Dim  : =DecodeChars(rs(""))
	'Dim  : =DecodeChars(rs(""))
	'Dim  : =DecodeChars(rs(""))
	'Dim  : =DecodeChars(rs(""))
	
	Dim OwnName : OwnName=DecodeChars(rs("OwnName"))
	Dim OwnContact : OwnContact=DecodeChars(rs("OwnContact"))
	Dim OwnPhone1 : OwnPhone1=DecodeChars(rs("OwnPhone1"))
	Dim OwnPhone2 : OwnPhone2=DecodeChars(rs("OwnPhone2"))
	'Dim  : =DecodeChars(rs(""))
	'Dim  : =DecodeChars(rs(""))
	'Dim  : =DecodeChars(rs(""))
	'Dim  : =DecodeChars(rs(""))
	
	Dim GenName : GenName=DecodeChars(rs("GenName"))
	Dim GenContact : GenContact=DecodeChars(rs("GenContact"))
	Dim GenPhone1 : GenPhone1=DecodeChars(rs("GenPhone1"))
	Dim GenPhone2 : GenPhone2=DecodeChars(rs("GenPhone2"))
	'Dim  : =DecodeChars(rs(""))
	'Dim  : =DecodeChars(rs(""))
	'Dim  : =DecodeChars(rs(""))
	'Dim  : =DecodeChars(rs(""))
	
	
	SQL1 = "SELECT * FROM Progress"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
		
	Dim ProgID
	Dim BGColor
	Dim AltBGColor
	Dim BGText
	Dim Text
	Dim MOTextColor
	Dim MOutTextColor
	
	Dim PrCount
	
	Dim ProgArr(16)
		
	PrCount = 0
	
		Do While Not rs1.EOF
			PrCount=PrCount+1
			
			ProgID= rs1("ProgID")
			BGColor = rs1("BGColor")
			AltBGColor= rs1("AltBGColor")
			BGText= rs1("BGText")
			Text= rs1("Text")
			MOTextColor= rs1("MOTextColor")
			MOutTextColor= rs1("MOutTextColor")
			
			ProgArr(PrCount) = array(ProgID,BGColor,AltBGColor,BGText,Text,MOutTextColor)
	
		rs1.MoveNext
		Loop		
	set rs1=nothing

%>
	<!-- img src="Images/GreyGradient2-18TopLeft.gif" class="iTitleDefaultLeft" -->
	<div id="iTitleProj" class="iTitleDefault" style="margin:32px 0 0 0;">
		<div class="iTitleTextDefault">Project Info</div>
		<div id="UpButtonProj" href="javascript:Void();" onClick="RollUp('Proj');" class="DefaultIUp">▲</div>
		<div id="DnButtonProj" href="javascript:Void();" onClick="RollDn('Proj');" class="DefaultIDn">▼</div>
	</div>
	<!-- img src="Images/GreyGradient2-18TopRight.gif" class="iTitleDefaultRight" -->
	<div id="iRollUpProj" class="iRollup">
		<div id="iBoxProj" class="iBoxDefault">
			<div id="ProjNameDiv" class="InfoDiv" onClick="ProjName.focus();">
				<label for="ProjName" class="InfoLabel">Project:<br/></label>
				<input id="ProjName" type="text" class="InfoText" style="font-weight:bold;" value="<%=ProjName%>"
				 onKeyUp="UpdateText('Projects','ProjName',this.value,'ProjID',ProjID); Gebi('ProjectName').innerHTML=this.value;"/>
			</div>
			<div id="ProjAddrDiv" class="InfoDiv" onClick="ProjAddr.focus();">
				<label for="ProjAddr" class="InfoLabel">Address:</label>
				<input id="ProjAddr" type="text" class="InfoText" value="<%=Address%>" 
				 onKeyUp="UpdateText('Projects','ProjAddress',this.value,'ProjID',ProjID)"/>
			</div>
		</div>
	</div>


	<div id="iTitleOwn" class="iTitleDefault">
		<div class="iTitleTextDefault">Owner's Info</div>
		<div id="UpButtonOwn" href="javascript:Void();" onClick="RollUp('Own');" class="DefaultIUp">▲</div>
		<div id="DnButtonOwn" href="javascript:Void();" onClick="RollDn('Own');" class="DefaultIDn">▼</div>
	</div>
	<div id="iRollUpOwn" class="iRollup">
		<div id="iBoxOwn" class="iBoxDefault">
			<div id="OwnNameDiv" class="InfoDiv" onClick="Gebi('OwnName').focus();">
				<label for="OwnName" class="InfoLabel">Owner:<br/></label>
				<input id="OwnName"  type="text" class="InfoText" style="font-weight:bold;" value="<%=OwnName%>"  
				 onKeyUp="UpdateText('Projects', 'OwnName', this.value, 'ProjID', ProjID);"/>
			</div>

			<div id="OwnContactDiv" class="InfoDiv" onClick="Gebi('OwnContact').focus();">
				<label for="OwnContact" class="InfoLabel">Owner Contact:<br/></label>
				<input id="OwnContact"  type="text" class="InfoText" value="<%=OwnContact%>"  
				 onKeyUp="UpdateText('Projects','OwnContact',this.value,'ProjID',ProjID);"/>
			</div>
			
			<div id="OwnPhone1Div" class="InfoDiv" onClick="Gebi('OwnPhone1').focus();">
				<label for="OwnPhone1" class="InfoLabel">Phone:<br/></label>
				<input id="OwnPhone1"  type="text" class="InfoText" value="<%=OwnPhone1%>"  
				 onKeyUp="UpdateText('Projects','OwnPhone1',this.value,'ProjID',ProjID);"/>
			</div>
			
			<div id="OwnPhone2Div" class="InfoDiv" onClick="Gebi('OwnPhone2').focus();">
				<label for="OwnPhone2" class="InfoLabel">2nd Phone:<br/></label>
				<input id="OwnPhone2" type="text" class="InfoText" value="<%=OwnPhone2%>"  
				 onKeyUp="UpdateText('Projects','OwnPhone2',this.value,'ProjID',ProjID);"/>
			</div>
		</div>
		<!--	
			<div id="" class="InfoDiv" onClick="Gebi('').focus();">
				<label for="" class="InfoLabel"> <br/></label>
				<input id="" type="text" class="InfoText" value="<%'=%>"  
				 onKeyUp="UpdateText('Projects','',this.value,'ProjID',ProjID);"/>
			</div>
		!-->	
	</div>

	<div id="iTitleGen" class="iTitleDefault">
		<div class="iTitleTextDefault">General's Info</div>
		<div id="UpButtonGen"  href="javascript:Void();" onClick="RollUp('Gen');" class="DefaultIUp">▲</div>
		<div id="DnButtonGen" href="javascript:Void();" onClick="RollDn('Gen');" class="DefaultIDn">▼</div>
	</div>
	<!-- img src="Images/GreyGradient2-18TopRight.gif" class="iTitleDefaultRight" -->
	<div id="iRollUpGen" class="iRollup">
		<div id="iBoxGen" class="iBoxDefault">
			
			<div id="GenNameDiv" class="InfoDiv" onClick="GenName.focus();">
				<label for="GenName" class="InfoLabel">General:<br/></label>
				<input id="GenName" type="text" class="InfoText" style="font-weight:bold;" value="<%=GenName%>"
				 onKeyUp="UpdateText('Projects','GenName',this.value,'ProjID',ProjID)"/>
			</div>

			<div id="GenContactDiv" class="InfoDiv" onClick="Gebi('GenContact').focus();">
				<label for="GenContact" class="InfoLabel">General Contact:<br/></label>
				<input id="GenContact"  type="text" class="InfoText" value="<%=GenContact%>"  
				 onKeyUp="UpdateText('Projects','GenContact',this.value,'ProjID',ProjID);"/>
			</div>
			
			<div id="GenPhone1Div"  class="InfoDiv" onClick="Gebi('GenPhone1').focus();">
				<label for="GenPhone1" class="InfoLabel">Phone:<br/></label>
				<input id="GenPhone1"  type="text" class="InfoText" value="<%=GenPhone1%>"  
				 onKeyUp="UpdateText('Projects','GenPhone1',this.value,'ProjID',ProjID);"/>
			</div>
			
			<div id="GenPhone2Div"  class="InfoDiv" onClick="Gebi('GenPhone2').focus();">
				<label for="GenPhone2" class="InfoLabel">2nd Phone:<br/></label>
				<input id="GenPhone2" type="text" class="InfoText" value="<%=GenPhone2%>"  
				 onKeyUp="UpdateText('Projects','GenPhone2',this.value,'ProjID',ProjID);"/>
			</div>
		</div>
	</div>

	<div id="CustomInfoBoxOverallDiv" style="height:auto;">
		<%
		SQL2 = "SELECT * FROM InfoBoxes WHERE ProjID="&ProjID
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		Dim iBNum : iBNum=0	
		Do Until rs2.eof
			iBNum=iBNum+1
		%>

		<div id="CustomInfoBox<%=iBNum%>">
			<div id="iTitle<%=iBNum%>" class="iTitleCustom">
				<img class="CustomIX" src="../../LMCDevelopment/images/closesmall.gif" onClick="DelInfoBox(<%=rs2("InfoBoxID")%>,this.parentNode.parentNode)"/>
				<div class="iTitleTextCustom"><%=rs2("Title")%></div>
				<div id="UpButton<%=iBNum%>" href="javascript:Void();" onClick="RollUp('<%=iBNum%>');" class="CustomIUp">▲</div>
				<div id="DnButton<%=iBNum%>" href="javascript:Void();" onClick="RollDn('<%=iBNum%>');" class="CustomIDn">▼</div>
			</div>
			<!-- img src="Images/GreyGradient2-18TopRight.gif" class="iTitleDefaultRight" -->
			<div id="iRollUp<%=iBNum%>" class="iRollup">
				<div id="iBox<%=iBNum%>" class="iBoxCustom">
					<div id="infoBox<%=iBNum%>customData">
						<%
						SQL3 = "SELECT * FROM InfoBoxData WHERE InfoBoxID="&rs2("InfoBoxID")
						set rs3=Server.CreateObject("ADODB.Recordset")
						rs3.Open SQL3, REDconnstring
						
						Dim IBDNum : IBDNum=0
						Dim TN
						Do Until rs3.eof
							IBDNum=IBDNum+1
							TN="CustomData"&CStr(iBNum)&"-"&CStr(iBDNum)
							
							%>
							
							<div id="<%=TN%>Div" class="InfoDiv" onClick="try{Gebi('<%=TN%>').focus();} catch(e){}">
								<img src="../../LMCDevelopment/images/closesmall.gif" style="cursor:pointer;" onClick="DelInfoBoxData(<%=rs3("InfoBoxDataID")%>,this.parentNode);"/>
								<label for="<%=TN%>" class="InfoLabel"><%=rs3("Name")%><br/></label>
								<input id="<%=TN%>" type="text" class="InfoText" value="<%=rs3("Data")%>"  
								 onKeyUp="UpdateText('InfoBoxData','Data',this.value,'InfoBoxDataID',<%=rs3("InfoBoxDataID")%>);"/>
							</div>
							
							<%
							rs3.MoveNext
						Loop
						set rs3 = nothing
						%>
					</div>
					<button class="iBoxButton" style="color:#080;" title="New Info. Field" onClick="ShowInfoBoxDataBox(<%=rs2("InfoBoxID")%>,<%=IBNum%>);">+</button>
					<br/>
				</div>
			</div>
		</div>
		<%
			rs2.MoveNext
		Loop
		
		If IsNull(iBDNum) Or iBDNum="" Then iBDNum=0
		%>
	</div>
	<script type="text/javascript">var iBNum=<%=IBNum%>; var iBDNum=<%=IBDNum%>; </script>
<!--
	<div id="iTitleBottom" class="iTitleDefault" style="background:none; margin:8px 0 0 0;">
		<div class="iTitleTextDefault"></div>
-->
			<button class="NewInfoBoxButton" title="New Info. Box" onClick="ShowInfoBoxBox();">+</button>
<!--
		<div id="UpButtonBottom"  href="javascript:Void();" onClick="RollUp('Own');" class="DefaultIUp"></div>
		<div id="DnButtonBottom"  href="javascript:Void();" onClick="RollDn('Own');" class="DefaultIDn"></div>
	</div>
	<div id="iRollUpBottom"  class="iRollup">
		<div id="iBoxBottom"  classs="gradient ffffff FCF8F4 iBoxDefault">
			<div style="width:100%;">			</div>
		</div>
	</div>
-->
<br/>
<br/>
&nbsp;






<div id="InfoBoxBox"  class="InfoBoxBox">
	<div align="center" style="width:100%; border-bottom:#888 1px solid; background:#888; color:#000;"><big>New Info Box</big></div>

	<br />
	&nbsp;<label for="iBTitle">Info Box Title:</label><br />
	&nbsp;<input id="iBTitle" type="text" style="width:128px; background:#FFF8AA; border:none; font-weight:bold;" />
	&nbsp;

	<div id="InfoBoxBoxBottomButtons" style="width:100%; height:32px;">
		<button id="InfoBoxBoxCancel" onClick="CloseInfoBoxBox();" style="float:left;">Cancel</button>

		<button id="InfoBoxBoxSave" onClick="MakeInfoBox(document.getElementById('iBTitle').value);" style="float:right;">Save</button>
	</div>
</div>


<div id="InfoBoxDataBox"  class="InfoBoxBox">
	<div align="center" style="width:100%; border-bottom:#888 1px solid; background:#888; color:#000;"><big>New Info Data</big></div>

	<br />
	&nbsp;<label for="iBDTitle">Name:</label><br />
	&nbsp;<input id="iBDTitle" type="text" style="width:128px; background:#FFF8AA; border:none; font-weight:bold;" />
	&nbsp;

	<div id="InfoBoxDataBoxBottomButtons" style="width:100%; height:32px;">
		<button id="InfoBoxDataBoxCancel" onClick="CloseInfoBoxBox();" style="float:left;">Cancel</button>
		<button id="InfoBoxDataBoxSave" style="float:right;"
		 onClick="MakeInfoBoxData();">
			Save		</button>
	</div>
</div>


















<script type="text/javascript">
var OldBkg=Gebi('iTitleProj').parentNode.style.background;
Gebi('iTitleProj').parentNode.style.background='#e2e2e2';
Gebi('iTitleProj').parentNode.style.background=OldBkg;

//RollDn('Bottom');
</script>
</div>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End Left Div ~~~~~~~~~~~~~~~~~~~~~ -->


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End Left Div ~~~~~~~~~~~~~~~~~~~~~ -->


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End Left Div ~~~~~~~~~~~~~~~~~~~~~ -->


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End Left Div ~~~~~~~~~~~~~~~~~~~~~ -->


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End Left Div ~~~~~~~~~~~~~~~~~~~~~ -->








<div id="RightTitle" class="RightTitle">Project Management</div><!--[if IE]><font size="6"><br/></font><![endif]-->

<div id="Right" class="Right">

	<div id="DataTabsBox" class="DataTabsBox"><!--Creates dynamic tabs-->
	
		<div id="ManageTabBox" classs="gradient f0e4dc c0c0c0 TabBox2" class="TabBox2"
		 onmouseover="MouseOverMarTop('ManageTabBox')" onMouseOut="MouseOutMarTop('ManageTabBox')">
			
			<div id="ManageTabBkg" class="TabBox2Bkg">
				<!--	
				<div style="float:left; z-index:1; position:relative; left:1px; width:25px;">
					<img width="24px" height="24px" src="images/LightGrayGradient2TLCorner24x24.gif"/>
					<img width="24px" height="48px" src="images/LightGrayGradient2BLCorner24x24.gif" style="position:relative; top:-3px;"/>				</div>
				<div style="float:left; z-index:0; width:1px; position:absolute; left:24px; overflow:visible;">
					<img width="256px" height="24px" src="images/LightGrayGradient2-24x24.gif"/>
					<img width="256px"  height="48px" src="images/LightGrayGradient2B-24x24.gif" style="position:relative; top:-3px; margin:0 0 0 0;"/>				</div>
				<div style="float:right; z-index:1; position:relative; left:-1px; width:25px;">
					<img width="24px" height="24px" src="images/LightGrayGradient2TRCorner24x24.gif"/>
					<img width="24px" height="48px" src="images/LightGrayGradient2BRCorner24x24.gif" style="position:relative; top:-3px;"/>				</div>
				 -->
			</div>
			
			<div id=ManageTab  class=TabInner2 style="background:#DFD6F5;" onClick="DataTabs('Manage','Manage')">Manage</div>
		</div>
			
		<div id="ScheduTabBox" classs="gradient f0e4dc c0c0c0 TabBox2" class="TabBox2" onMouseOver="MouseOverMarTop('ScheduTabBox')" onMouseOut="MouseOutMarTop('ScheduTabBox')">
			<div id="ScheduTabBkg" class="TabBox2Bkg"></div>
			<script type="text/javascript"> Gebi('ScheduTabBkg').innerHTML=Gebi('ManageTabBkg').innerHTML;</script>
<div id="ScheduTab" class="TabInner2" onClick="DataTabs('Schedu','Schedule');" style="background:#C9E4F8 ;">Schedule</div>
		</div>
			
		<div id="BOfMatTabBox" classs="gradient f0e4dc c0c0c0 TabBox2" class="TabBox2" onMouseOver="MouseOverMarTop('BOfMatTabBox')" onMouseOut="MouseOutMarTop('BOfMatTabBox')">
			<div id="BOfMatTabBkg" class="TabBox2Bkg"></div>
			<script type="text/javascript"> Gebi('BOfMatTabBkg').innerHTML=Gebi('ManageTabBkg').innerHTML;</script>
			<div id="BOfMatTab"  class="TabInner2" onClick="DataTabs('BOfMat','Bill of Materials')" style="background:#C6FFFF ;">B.O.M.<br/></div>
		</div>
			
		<div id="DocsTabBox" classs="gradient f0e4dc c0c0c0 TabBox2" class="TabBox2" onMouseOver="MouseOverMarTop('DocsTabBox')" onMouseOut="MouseOutMarTop('DocsTabBox')">
			<div id="DocsTabBkg" class="TabBox2Bkg"></div>
			<script type="text/javascript"> Gebi('DocsTabBkg').innerHTML=Gebi('ManageTabBkg').innerHTML;</script>
			<div id="DocsTab"  class="TabInner2" onClick="DataTabs('Docs','Documents');" style="background:#FFD1A8 ;">Docs<br/></div>
		</div>
			
		<!--div id="PrDocsTabBox" classs="gradient f0e4dc c0c0c0 TabBox2" class="TabBox2" onmouseover="MouseOverMarTop('PrDocsTabBox')" onmouseout="MouseOutMarTop('PrDocsTabBox')">
			<div id="PrDocsTabBkg" class="TabBox2Bkg"></div>
			<script type="text/javascript"> Gebi('PrDocsTabBkg').innerHTML=Gebi('ManageTabBkg').innerHTML;</script>
			<div id="PrDocsTab"  class="TabInner2" onClick="DataTabs('PrDocs','Private Docs')">Private</div>
		</div-->

		<div id="PlansTabBox" classs="gradient f0e4dc c0c0c0 TabBox2" class="TabBox2" onMouseOver="MouseOverMarTop('PlansTabBox')" onMouseOut="MouseOutMarTop('PlansTabBox')">
			<div id="PlansTabBkg" class="TabBox2Bkg"></div>
			<script type="text/javascript"> Gebi('PlansTabBkg').innerHTML=Gebi('ManageTabBkg').innerHTML;</script>
			<div id="PlansTab"  class="TabInner2" onClick="DataTabs('Plans','Drawings')" style="background:#E2E2E9;">Plans<br/></div>
		</div>

		<div id="PicTabBox" classs="gradient f0e4dc c0c0c0 TabBox2" class="TabBox2" onMouseOver="MouseOverMarTop('PicTabBox')" onMouseOut="MouseOutMarTop('PicTabBox')">
			<div id="PicTabBkg" class="TabBox2Bkg"></div>
			<script type="text/javascript"> Gebi('PicTabBkg').innerHTML=Gebi('ManageTabBkg').innerHTML;</script>
			<div id="PicTab" class="TabInner2" onClick="DataTabs('Pic','Pictures')" style="background:#FFD1A8;">
				Pictures<br/> 
			</div>
		</div>

		<div id="MapTabBox" classs="gradient f0e4dc c0c0c0 TabBox2" class="TabBox2" onMouseOver="MouseOverMarTop('MapTabBox')" onMouseOut="MouseOutMarTop('MapTabBox')">
			<div id="MapTabBkg" class="TabBox2Bkg"></div>
			<script type="text/javascript"> Gebi('MapTabBkg').innerHTML=Gebi('ManageTabBkg').innerHTML;</script>
			<div id="MapTab" class="TabInner2" onClick="DataTabs('Map','Project Location')" style="background:#FFD1A8;">
				Map<br/> 
			</div>
		</div>

		<!-- div id="ClDocsTabBox" classs="gradient f0e4dc c0c0c0 TabBox2" class="TabBox2" onmouseover="MouseOverMarTop('ClDocsTabBox');" onmouseout="MouseOutMarTop('ClDocsTabBox');">
			<div id="ClDocsTabBkg" class="TabBox2Bkg"></div>
			<script type="text/javascript"> Gebi('ClDocsTabBkg').innerHTML=Gebi('ManageTabBkg').innerHTML;</script>
			<div id="ClDocsTab"  class="TabInner2" onClick="DataTabs('ClDocs','Closeout Docs');">Closeout<br/>Docs
			</div>
		</div -->

		<div id="JobLogTabBox" class="TabBox2" onMouseOver="MouseOverMarTop('JobLogTabBox')" onMouseOut="MouseOutMarTop('JobLogTabBox')">
			<div id="JobLogTabBkg" class="TabBox2Bkg"></div>
			<script type="text/javascript"> Gebi('JobLogTabBkg').innerHTML=Gebi('ManageTabBkg').innerHTML;</script>
			<div id="JobLogTab"  class="TabInner2" onClick="DataTabs('JobLog','Log / Job Notes')" style="background:#FCFCC0;">Notes</div>
		</div>
	</div>  
	
			<div id="TabTitleSpacer"  style="width:33%; float:left; position:relative; height:1px;">&nbsp;</div>
			<div id="TabTitle" class="TabTitle">
				<div class="TabTitleCorner"><img src="../../LMCDevelopment/images/LightGrayGradient2BLCorner24x24.gif" style="float:left; z-index:0;"/></div>
				<div id="TabTitleText" class="TabTitleText">Manage</div>
				<div class="TabTitleCorner" style="width:1px;"><img src="../../LMCDevelopment/images/LightGrayGradient2BRCorner24x24.gif" style="float:left; z-index:0;"/></div>
			</div>
			

<div id="ManageBox" class="Box">
	
	<div id="ProjProg"  class="ProjProg">

		<div id="ProgHead"  class="ProgHead">
			<div class="HeadText" style="">Progress</div>
			<button id="ProgPrint" class="ProgPrint" onClick="PrintProgressReport();">Print Progress Report</button>
		</div>
		<hr/>
	</div>

	<div id="ManageContent"  class="ManageContent">
	
		<div id="ProgDetail"  class="ProgDetail">


			<div class="ProgressLabel" style="padding:0 0 0 1%;">&nbsp;<big><big>Project: <b id="ProjectName"><%=ProjName%></b></big></big></div>
			<%Dim Active : if rs("Active")="True" Then Active="checked" Else Active=""%>
			<div style="float:right;">
				<input style="position:relative; top:2px;" id="cbActive" type="checkbox" onChange="" <%=Active%>/>
				<small><label for="cbActive">This is an active project.</label></small>			</div>
			<div id="ProgProject" class="ProgItem" style="padding:0 0 12px 0;">

				
				<div title='Overall Project Progress' class='BigItemDone' align='center'>
					<div id="ProjProg" class="BigItemProg" onClick="showProgressMenu('ProjProgS',<%=rs("ProjID")%>,'JobCompleted','Projects','1');"
					 onmouseover="this.style.color='#<%=ProgArr(rs("Plans"))(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
						<div id="ProjProgS" class="ProgBkg" style="background:#<%=ProgArr(rs("JobCompleted"))(1)%>; border-radius:13px;">&nbsp;</div>
					</div>
				</div>
				

				<div id="ProjItemsProgress" class="ItemsProgress">
					
					<div id="ProgProjBoxes" class="ProgBoxes" style="">

						<%
							Dim PrItem
							PrItem=rs("Plans")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:11%; padding:0 1% 0 1.5%; ">
							<div title="Overall Engineering Progress" class="ItemDone"  align="center">
								<div id="PrPlan" class="ItemProg" onClick="showProgressMenu('PrPlanS',ProjID,'Plans','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<%'=Replace(Replace(ProgArr(PrItem)(3),"-AMPERSAND-","&"),"ProgState","PrPlanS")%>		
									<div id="PrPlanS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Plans</div>
						</div>


						<%
							PrItem=rs("Permits")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:11%; padding:0 1% 0 0;">
							<div title="Obtaining Permits" class="ItemDone"  align="center">
								<div id="PrPerm" class="ItemProg" onClick="showProgressMenu('PrPermS',ProjID,'Permits','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrPermS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Permits</div>
						</div>


						<%
							PrItem=rs("UnderGround")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:11%; padding:0 1% 0 0;">
							<div title="Underground Progress" class="ItemDone"  align="center">
								<div id="PrUG" class="ItemProg" onClick="showProgressMenu('PrUGS',ProjID,'UnderGround','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrUGS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Under-<br/>Ground</div>
						</div>


						<%
							PrItem=rs("RoughIn")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:11%; padding:0 1% 0 0;">
							<div title="Rough In Progress" class="ItemDone"  align="center">
								<div id="PrRuf" class="ItemProg" onClick="showProgressMenu('PrRufS',ProjID,'RoughIn','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrRufS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Rough-In</div>
						</div>


						<%
							PrItem=rs("RoughInspect")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:11%; padding:0 1% 0 0;">
							<div title="Rough Inspection" class="ItemDone"  align="center">
								<div id="PrRufI" class="ItemProg" onClick="showProgressMenu('PrRufIS',ProjID,'RoughInspect','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrRufIS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Rough<br/>Inspection</div>
						</div>


						<%
							PrItem=rs("OrderMaterials")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:11%; padding:0 1% 0 0;">
							<div title="Overall Purchasing Progress" class="ItemDone"  align="center">
								<div id="PrOMat" class="ItemProg" onClick="showProgressMenu('PrOMatS',ProjID,'OrderMaterials','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrOMatS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Order<br/>Materials</div>
						</div>


						<%
							PrItem=rs("Trim")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:11%; padding:0 1% 0 0; ">
							<div title="Trim Out" class="ItemDone" align="center">
								<div id="PrTrim" class="ItemProg" onClick="showProgressMenu('PrTrimS',ProjID,'Trim','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrTrimS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Trim</div>
						</div>


						<%
							PrItem=rs("FinishInspect")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; padding:0 1% 0 0; ">
							<div title="Final Inspection" class="ItemDone" align="center">
								<div id="PrFinI" class="ItemProg" onClick="showProgressMenu('PrFinIS',ProjID,'FinishInspect','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrFinIS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Final<br/>Inspection</div>
						</div>
					</div>
				</div>
				<!-- End Eng ItemsProgress -->
			</div>
			<br />

			
			<div class="ProgressLabel">&nbsp;Engineering</div>
			<div id="ProgPlan" class="ProgItem">

				<div title='click to set the progress of the task' class='BigItemDone' align='center'>
					<div id="PlanProg"  class="BigItemProg" onClick="showProgressMenu('PlanProgS',<%=rs("ProjID")%>,'Plans','Projects','1');"
					 onmouseover="this.style.color='#<%=ProgArr(rs("Plans"))(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
						<div id="PlanProgS" class="ProgBkg" style="background:#<%=ProgArr(rs("Plans"))(1)%>; border-radius:13px;">&nbsp;</div>
					</div>Draw
				</div>
				

				<div id="PlanItemsProgress" class="ItemsProgress">
					
					<div id="ProgPlanBoxes" class="ProgBoxes">

						<%
							'Dim PrItem
							Dim Sp: Sp="13.1%"							
							PrItem=rs("PlansOrig")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 8px 0 8px;">
							<div title="Obtain-Original-Drawings Progress" class="ItemDone"  align="center">
								<div id="PrOrig" class="ItemProg" onClick="showProgressMenu('PrOrigS',ProjID,'PlansOrig','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrOrigS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Originals</div>
						</div>

							
						
						<%
							PrItem=rs("PlansDraw")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>%; padding:0 0 0 8px;">
							<div title="Draw-Plans Progress" class="ItemDone" align="center">
								<div id="PrDraw" class="ItemProg" onClick="showProgressMenu('PrDrawS',ProjID,'PlansDraw','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrDrawS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Draw</div>
						</div>

					
						<%
							PrItem=rs("PlansPlot")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 0 0 8px;">
							<div title="Send-To-Plotter Progress" class="ItemDone"  align="center">
								<div id="PrPlot" class="ItemProg" onClick="showProgressMenu('PrPlotS',ProjID,'PlansPlot','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrPlotS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Plot</div>
						</div>
							
						
						<%
							PrItem=rs("PlansReview")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 0 0 8px;">
							<div title="Plan-Review Progress" class="ItemDone"  align="center">
								<div id="PrReview" class="ItemProg" onClick="showProgressMenu('PrReviewS',ProjID,'PlansReview','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrReviewS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Review</div>
						</div>
					
						<%
							PrItem=rs("PlansSubmit")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 0 0 8px;">
							<div title="Submit-to-AHJ Progress" class="ItemDone"  align="center">
								<div id="PrSubmit" class="ItemProg" onClick="showProgressMenu('PrSubmitS',ProjID,'PlansSubmit','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrSubmitS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Submit</div>
						</div>
						
					
						<%
							PrItem=rs("PlansApproved")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 0 0 8px;">
							<div title="AHJ-Approval Progress" class="ItemDone"  align="center">
								<div id="PrApproved" class="ItemProg" onClick="showProgressMenu('PrApprovedS',ProjID,'PlansApproved','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrApprovedS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Approved</div>
						</div>

			
						<%
							PrItem=rs("PlansAsBuilts")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; padding:0 0 0 8px;">
							<div title="As-Builts Progress" class="ItemDone"  align="center">
								<div id="PrAsBuilts" class="ItemProg" onClick="showProgressMenu('PrAsBuiltsS',ProjID,'PlansAsBuilts','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrAsBuiltsS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">As-Builts</div>
						</div>
					</div>
				</div>
				<!-- End Eng ItemsProgress -->
			</div>

			<br />
			<div class="ProgressLabel">&nbsp;Purchasing</div>
			<div id="ProgPurchase"  class="ProgItem">
	
				<div title='click to set the progress of the task' class='BigItemDone' align='center'>
					<div id="PurchaseProg"  class="BigItemProg" onClick="showProgressMenu('PurchaseProgS',<%=rs("ProjID")%>,'OrderMaterials','Projects','1');"
					 onmouseover="this.style.color='#<%=ProgArr(rs("OrderMaterials"))(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
						<div id="PurchaseProgS" class="ProgBkg" style="background:#<%=ProgArr(rs("OrderMaterials"))(1)%>; border-radius:13px;">&nbsp;</div>
					</div>
				</div>

				<div id="PurchaseItemsProgress" class="ItemsProgress">
					
					<div id="ProgPlanBoxes" class="ProgBoxes">

						<%
							'Dim PrItem
							PrItem=rs("OrderUG")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 8px 0 8px;">
							<div title="Order Underground Materials Progress" class="ItemDone"  align="center">
								<div id="PrOrUG" class="ItemProg" onClick="showProgressMenu('PrOrUGS',ProjID,'OrderUG','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrOrUGS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Underground<br/>Ordered</div>
						</div>
						
						
						<%
							'Dim PrItem
							PrItem=rs("ReceiveUG")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 8px 0 8px;">
							<div title="Order Underground Materials Progress" class="ItemDone"  align="center">
								<div id="PrRecUG" class="ItemProg" onClick="showProgressMenu('PrRecUGS',ProjID,'ReceiveUG','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrRecUGS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Underground<br/>Received</div>
						</div>
						
						
						<%
							'Dim PrItem
							PrItem=rs("OrderRoughIn")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 8px 0 8px;">
							<div title="Order Underground Materials Progress" class="ItemDone"  align="center">
								<div id="PrOrRuf" class="ItemProg" onClick="showProgressMenu('PrOrRufS',ProjID,'OrderRoughIn','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrOrRufS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Rough-In<br/>Ordered</div>
						</div>
						

						<%
							'Dim PrItem
							PrItem=rs("ReceiveRoughIn")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 8px 0 8px;">
							<div title="Order Underground Materials Progress" class="ItemDone"  align="center">
								<div id="PrRecRuf" class="ItemProg" onClick="showProgressMenu('PrRecRufS',ProjID,'ReceiveRoughIn','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrRecRufS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Rough-In<br/>Received</div>
						</div>
						
						
						<%
							'Dim PrItem
							PrItem=rs("OrderFinish")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 8px 0 8px;">
							<div title="Order Underground Materials Progress" class="ItemDone"  align="center">
								<div id="PrOrTr" class="ItemProg" onClick="showProgressMenu('PrOrTrS',ProjID,'OrderFinish','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrOrTrS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Trim<br/>Ordered</div>
						</div>
						

						<%
							'Dim PrItem
							PrItem=rs("ReceiveFinish")
							if (IsNull(PrItem)) or PrItem<1 or PrItem>6 then PrItem=1
						%>
						<div style="float:left; width:<%=Sp%>; padding:0 8px 0 8px;">
							<div title="Order Underground Materials Progress" class="ItemDone"  align="center">
								<div id="PrRecTr" class="ItemProg" onClick="showProgressMenu('PrRecTrS',ProjID,'ReceiveFinish','Projects','1');" 
								 onmouseover="this.style.color='#<%=ProgArr(PrItem)(1)%>';" onMouseOut="this.style.color=this.parentNode.style.color;">
									<div id="PrRecTrS" class="ProgBkg" style="background:#<%=ProgArr(PrItem)(1)%>;">&nbsp;</div>
								</div>
							</div><br />
							<div class="ProgBoxLabel">Trim<br/>Received</div>
						</div>
					</div>
				</div>
				
				<hr/>
			</div>
			<br />
















			<div id="PhaseProgressMenu" class="PhaseProgressMenu">
				Set Progress<br/>
				<%
				Dim P : P=1
				For P = 1 to PrCount 
					Dim PA1 : PA1=ProgArr(P)(0)
					Dim PA2 : PA2=ProgArr(P)(1)
					Dim PA3 : PA3=ProgArr(P)(2)
					Dim PA4 : PA4=ProgArr(P)(3)
					Dim PA5 : PA5=ProgArr(P)(4)
					Dim PA6 : PA6=ProgArr(P)(5)
				%>
				
				<script type="text/javascript">//alert('< %=ProgArr(P)(0)%>');</script>
				
				<div class="ProgressItems" onClick="ProgressClick(ProjID,<%=PA1%>,ProgDivID,'<%=PA2%>','<%'=PA4%>','Plans','Projects');">

					<div id="ProgC<%=PA1%>" class="ProgressColor" style="background:#<%=PA2%>;"
					 onMouseOver="this.style.backgroundColor='#<%=PA3%>';"
					 onMouseOut="this.style.backgroundColor='#<%=PA2%>';">
						<%=Replace(PA4,"-AMPERSAND-","&")%>					</div>

					<div class="ProgressDesc" onMouseOver="Gebi('ProgC<%=PA1%>').style.backgroundColor='#<%=PA3%>';"
					 onMouseOut="Gebi('ProgC<%=PA1%>').style.backgroundColor='#<%=PA2%>';">
						<%=PA5%>					</div>
				</div>

			<%Next%>
				<div class="ProgressItemsCancel">
					<button class="PICancelBtn" onClick="CloseProgressMenu();">Cancel</button>
				</div>
			</div>
		</div>

		<div id="Checklist"  class="Checklist">

			<div id="ProgHead" class="ProgHead">
				<div class="HeadText" style="">Checklists</div>
				<button id="NewChecklist" class="ProgPrint" style="color:#060;">+New Checklist</button>
			</div>
			<hr/>
			
<!--			
			<iframe width='80%' height='80%' frameborder='0' src='https://spreadsheets.google.com/ccc?key=tU9TcZtgwSdrWp2MVs7ipPg&hl=en&output=html'></iframe><br /><br />

			<iframe width='80%' height='80%' frameborder='0' src='https://spreadsheets.google.com/pub?key=0AiyCYGtdNUgadFU5VGNadGd3U2RyV3AyTVZzN2lwUGc&widget=true'></iframe>
	</div>
</div>

-->
</div>
</div>
</div>



<div id="ScheduBox" class="BoxHidden">

	<div id="ProgHead"  class="ProgHead"><div class="HeadText" style="clear:left">Scheduling</div><hr/></div>

	<div id="SchList" style="width:100%; height:256px;">
		<iframe id="SchFrame" src="ProjMan-Schedule.asp?ProjID=<%=ProjID%>"></iframe>
	</div>
</div>
<script type="text/javascript">//LoadSchList();</script>
	
	
	  
<div id="PartsBox" class="WindowBox">
	<div id=PartsBoxTitle>Add Parts<div class="redXCircle" onClick="Gebi('Modal').style.display='none'; Gebi('PartsBox').style.display='none';">X</div></div>
	<div id=PartsLeft align=left>
		Part#:<br/>
		<input class="PartsInput" id="searchPartNum" onKeyUp="searchParts();"/>
		<br/><br/>
		<button class="PartsInput" id=addBlankPart
		 onClick=
		 "
			SendSQL('Write','INSERT INTO BOMItems (ProjID,Qty) VALUES (<%=ProjID%>,1)');
			BomContent(<%=ProjID%>,'True');
		 ">Add blank line.</button>
	</div>
	<div id=PartsRight align=left>
		<div id=ResultsTitle>Results</div>
		<div id=PartsResults></div>
	</div>
</div>

<div id="BOfMatBox" class="BoxHidden">

	<div id="BOMBox" class="ManageContent">	</div> <!-- End BOM Box -->
	<script type="text/javascript">BomContent(ProjID,'<%=rs("BOMIsGenerated")%>');</script>
</div>
	  
<div id="DocsBox" class="BoxHidden"></div>
	  
<div id="PrDocsBox" class="BoxHidden"></div>
	  
<div id="PlansBox" class="BoxHidden"></div>
	  
<div id="PicBox" class="BoxHidden"></div>
	  
<div id="MapBox" class="BoxHidden"></div>
	  
<div id="ClDocsBox" class="BoxHidden"></div>
	  
<div id="JobLogBox" class="BoxHidden"></div>
</div><!-- End Right Div -->

<script type="text/javascript">
var OldBkg=Gebi('RightTitle').parentNode.style.background;
Gebi('RightTitle').parentNode.style.background='#fefefe';
//Nifty('div#RightTitle','big transparent top');
Gebi('RightTitle').parentNode.style.background=OldBkg;




RollDn('Proj');
RollUp('Own');
RollDn('Gen');


setTimeout('Resize();',100);
//setTimeout('FadeOut(Gebi("Modal"));',105);
</script>
</div>
<!-- End Overall Div -->


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End Overall Div ~~~~~~~~~~~~~~~~~~~~~ -->


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End Overall Div ~~~~~~~~~~~~~~~~~~~~~ -->


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End Overall Div ~~~~~~~~~~~~~~~~~~~~~ -->














<%End If%>
</body>
</html>















<% 'Routines════════════════════════════════════════════════════════════════






%>
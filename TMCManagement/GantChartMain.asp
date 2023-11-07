<!--	#include file="../TMC/RED.asp"	-->
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Gant Chart</title>

<script type="text/javascript" src="Modules/rcstri.js"></script>
<script type="text/javascript" src="Library/SqlAjax.js"></script>
<script type="text/javascript" src="Modules/DragNDropJS.js"></script>
<SCRIPT type="text/javascript" src="Library/dhtmlgoodies_calendar.js?random=20060118"></script>

<script type="text/javascript" src="Modules/CommonAJAX.js"></script>
<script type="text/javascript">GetEmployeeList(true);</script>
<script type="text/javascript" src="Calendar/GantChartMain.js"></script>
<script type="text/javascript" src="Calendar/GantChartAJAX.js"></script>

<link rel="stylesheet" href="Library/CSS_DEFAULTS.css" media="screen">
<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">
<link rel="stylesheet" href="Calendar/GantChartMain.css" media="screen">

</head>
<%

wDate=Request.QueryString("Date")

if isNull(wDate) or wDate="" Then wDate=Date
'% ><%=wDate% ><br/><%=Date% ><%

wkDay=weekDay(wDate)
Monday=DateAdd("d",2-wkDay,wDate)
LastSaturday=DateAdd("d",-2,Monday)
Sunday=DateAdd("d",-1,Monday)
Tuesday=DateAdd("d",1,Monday)
Wednesday=DateAdd("d",2,Monday)
Thursday=DateAdd("d",3,Monday)
Friday=DateAdd("d",4,Monday)
Saturday=DateAdd("d",5,Monday)
Sunday2=DateAdd("d",6,Monday)

LastWeek=DateAdd("d",-7,Monday)
NextWeek=DateAdd("d",7,Monday)
LastMonth=DateAdd("M",-1,Monday)
NextMonth=DateAdd("M",1,Monday)


wkDays=Array(Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday2)
wkDayNames=Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday2")

%>
<script type="text/javascript">
 var LastSaturday= new Date('<%=LastSaturday%>')
 var Sunday= new Date('<%=Sunday%>')
 var Monday= new Date('<%=Monday%>')
 var Saturday= new Date('<%=Saturday%>')
 var Sunday2= new Date('<%=Sunday2%>')
</script>

<body onMouseUp="EvExID=null; EvExDir=0;" onLoad="LoadEvents('<%=Sunday%>');" onSelectStart="return false;">

<div class="Toolbar" style=" margin-left:auto; margin-right:auto;">
	<div class="tSpacer" >&nbsp;</div>
	<button id=LastMonth onClick="window.location='GantChartMain.asp?Date=<%=LastMonth%>';"><font face=Consolas>◄◄</font> Last Month</button>
	<button id=LastWeek onClick="window.location='GantChartMain.asp?Date=<%=LastWeek%>';"><font face=Consolas>◄</font> Last Week</button>
	<button id=ThisWeek onClick="window.location='GantChartMain.asp?Date=<%=Date%>';">This Week</button>
	<button id=NextWeek onClick="window.location='GantChartMain.asp?Date=<%=NextWeek%>';">Next Week <font face=Consolas>►</font></button>
	<button id=LastMonth onClick="window.location='GantChartMain.asp?Date=<%=NextMonth%>';">Next Month <font face=Consolas>►►</font></button>
	
	<div class="tSpacer" >&nbsp;</div>
	<div class="tSpacerLine"></div>
	<div class="tSpacer" >&nbsp;</div>
	
	<button id="ReloadFrame" onClick="window.location.reload();"></button>
</div>


<h1 style="height:6.5%; overflow:hidden;"><b><small>Week of</small></b> <big id="monDate"><%=Monday%> - <%=Sunday2%></big></h1>

<div id=WeekHead>
	<div style="width:100%;">
		<div class="HeadDay" >Vehicle<span class="BorderR"></span></div>
		<div class="HeadDay">Attn / Crew<span class="BorderR"></span><span class="BorderR"></span></div>
		<div class="HeadDay">Sunday<span class="BorderR"></span></div>
		<div class="HeadDay">Monday<span class="BorderR"></span></div>
		<div class="HeadDay">Tuesday<span class="BorderR"></span></div>
		<div class="HeadDay">Wednesday<span class="BorderR"></span></div>
		<div class="HeadDay">Thursday<span class="BorderR"></span></div>
		<div class="HeadDay">Friday<span class="BorderR"></span></div>
		<div class="HeadDay">Saturday<span class="BorderR"></span></div>
		<div class="HeadDay">Sunday</div> 
	</div>
</div>

<div id=Rows onselectstart="return false">
	<%
		W1="(DateFrom <='"&Sunday&"' AND DateTo >='"&Sunday&"')"  'Events that Include this Sunday
		W2="(DateFrom <='"&Sunday2&"' AND DateTo >='"&Sunday2&"')"'Events that Include next Sunday
		W3="(DateFrom >='"&Sunday&"' AND DateTo <='"&Sunday2&"')"	'Events that land within the week
	
		'SQL="SELECT * FROM Calendar WHERE "&W1&" OR "&W2&" OR "&W3&" ORDER BY AttentionID, DateFrom, TaskID, Done"
		'Set rs= server.CreateObject("AdoDB.RecordSet")
		'rs.Open SQL, REDConnString
		
		'RowNum=0
		'RowBackground="None"
		'Do Until rs.EOF
			'RowNum=RowNum+1
			'CalID=rs("CalID")
			'AttnID=rs("AttentionID")
			'
			'
			'SQL1="SELECT * FROM GantRows WHERE AttnID="&AttnID&" AND Monday='"&Monday&"'"
			'Set rs1=server.CreateObject("AdoDB.recordSet")
			'rs1.Open SQL1, REDConnString
			'
			'If rs1.EOF Then
			'	SQL2="INSERT INTO GantRows (AttnID,Monday) VALUES ("&AttnID&",'"&Monday&"')"
			'	Set rs2=server.CreateObject("AdoDB.RecordSet")
			'	rs2.Open SQL2, REDConnString
			'	Set rs2= Nothing
			'End If
			'
			'SQL2="SELECT * FROM GantRows WHERE AttnID="&AttnID&" AND Monday='"&Monday&"'"
			'Set rs2=Server.CreateObject("AdoDB.RecordSet")
			'rs2.Open SQL2, REDConnString
			'
			'SQL3="SELECT FName,LName FROM Employees WHERE EmpID="&AttnID
			'Set rs3=Server.CreateObject("AdoDB.RecordSet")
			'rs3.open SQL3, REDConnString
			'EmpName=rs3("FName")&" "&rs3("LName")
			'Set rs3=Nothing
			'
			'If RowBackground="None" Then RowBackground="rgba(0,0,0,.0625)" Else RowBackground="None"
			%>
			<!--
			<div id="Row< %=RowNum%>" class=Row style="background:< %=RowBackground%>;">
				<div id=Vehicle< %=RowNum%>Div class="RowDiv">
					<input id=Vehicle< %=RowNum%> value="< %=rs2("Vehicle")%>" style="border:none; float:left; height:99%; margin:0 auto; text-align:center; width:99%;" 
						onchange=""
					/>
					<span class="BorderR"></span>
				</div>
				<div id=AttnCrew< %=RowNum%> class="RowDiv">
					<select id=Attn< %=RowNum%> style=" cursor:pointer; height:20px; margin:0 auto; padding:0; width:99%;" >
						<option id=Emp0 value="< %=AttnID%>">< %=EmpName%></option>
						<%
						'SQL3="SELECT * FROM Employees WHERE Active=1 ORDER BY FName"
						'Set rs3=Server.CreateObject("AdoDB.recordSet")
						'rs3.Open SQL3, REDConnString
						'Do Until rs3.EOF
						'	Selected=""
						'	If rs3("EmpID")=AttnID Then Selected = "selected=""selected"""
							%>
							<option id="Emp< %=rs3("EmpID")%>" < %=Selected%>>< %=rs3("FName")&" "&rs3("LName")%></option>
							<%
						'	rs3.MoveNext
						'Loop
						%>
					</select>
					<textarea id=Crew< %=RowNum%> style="width:99%; height:28px; margin:0 auto; padding:0;"></textarea>
					<span class="BorderR"></span>
					<span class="BorderR"></span>
				</div>
				
				<div id="Week < %=RowNum%>" class=RowWeek onMouseMove="EventExtend(event,this);">
				</div>
			</div>
			-->
			<%
			'DaySlots=Array(Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false),Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false),Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false),Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false),Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false),Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false),Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false),Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false))
			
			
			'RowsTotalTop=126
			'Do Until rs("AttentionID") <> AttnID		
			'	CalID=rs("CalID")
			'	AttnID=rs("AttentionID")
			'	%>

				<%
			'	DayEventCount=0
			'	RowHeight=48
			'	RowH=0
			'	Do Until rs("DateFrom") > Sunday	Or	rs("AttentionID") <> AttnID		
			'		CalID=rs("CalID")
			'		AttnID=rs("AttentionID")
			'		
			'		DayEventCount=DayEventCount+1
			'		
			'		If DayEventCount > 3 Then RowH=DayEventCount*16
			'		If RowHeight<RowH Then RowHeight=RowH
			'		SQL4="SELECT BgColor, AltBgColor, TextColor FROM Tasks WHERE TaskID="&rs("TaskID")
			'		Set rs4=Server.CreateObject("AdoDB.recordSet")
			'		rs4.open SQL4, REDConnString
			'		BgColor=rs4("BgColor")
			'		Color=rs4("TextColor")
			'		BorderStyle="outset"
			'		If rs("Done")="True" Then
			'			Color="555"
			'			BgColor=rs4("AltBgColor")
			'			BorderStyle="inset"
			'		End If
			'		Set rs4=Nothing
			'		
			'		EventClass=" class=""Event "
			'		DragLeft="<span id=DragLeft"&rs("CalID")&" class=DragLeft onselectstart=""return false"" onMouseDown=""EvExID="&CalID&"; EvExDir=-1; "">◄</span>"
			'		DragRight="<span id=DragRight"&rs("CalID")&" class=DragRight onselectstart=""return false"" onMouseDown=""EvExID="&CalID&"; EvExDir=1; "">►</span>"
			'		
			'		If rs("DateFrom")>=Sunday Then EventClass=EventClass&" EventStart" Else DragLeft=""
			'		If rs("DateTo")<=Sunday2 Then EventClass=EventClass&" EventEnd" Else DragRight=""
			'		EventClass=EventClass&""""
			'		
			'		EvStart=rs("DateFrom")
			'		If EvStart<Sunday Then EvStart=Sunday
			'		EvStop=rs("DateTo")
			'		If EvStop>Sunday2 Then EvStop=Sunday2
			'		EvLength=DateDiff("d",EvStart,EvStop)+1
			'		
			'		if EvLength=0 Then EvLength=.25
			'	width=10*EvLength
			'		
			'		Style=" style=""background:#"&BgColor&"; border:1px "&BorderStyle&"; color:#"&Color&"; left:19.65%; width:"&width&"%;"" "
					%>
			<!--		
						<div id=Event< %=CalID%>< %=EvClass%>< %=Style%> d8From="< %=rs("DateFrom")%>" d8To="< %=rs("DateTo")%>" onMouseMove="evMPos(event,this);" onMouseDown="evMDown();">
							< %=DragLeft%>
							<div id="EventName< %=CalID%>" class="EventName" onselectstart="return false" onMouseDown="EvExID=< %=rs("CalID")%>; EvExDir=2">< %=rs("Title")%></div>
							< %=DragRight%>
						</div>
					<script type="text/javascript">
						Gebi('Event< %=CalID%>').title="< %=rs("Title")%>\n\n< %="NOTES:  "&Replace(rs("Note"),"Notes:","")%>";
						//Gebi('EventName< %=CalID%>').style.width=(Gebi('Event< %=CalID%>').offsetWidth-128)+'px';
					</script>
			-->	
					<%
			'		rs.moveNext	:	If rs.EOF Then Exit Do
			'	Loop
				%>
				
				<%
				
			'	If rs.EOF Then Exit Do
				
			'	For wkDayIndex=1 to 7
			'		LeftPos=(wkDayIndex+2)*9.825
			'		TopPos=RowsTotalTop
			'		Do Until rs("DateFrom") > wkDays(wkDayIndex)	Or	rs("AttentionID") <> AttnID		
			'			CalID=rs("CalID")
			'			AttnID=rs("AttentionID")
			'
			'			DayEventCount=DayEventCount+1
			'			TopPos=TopPos+16
			'			If DayEventCount > 3 Then RowH=DayEventCount*16
			'			If RowHeight<RowH Then RowHeight=RowH
			'			SQL4="SELECT BgColor, AltBgColor, TextColor FROM Tasks WHERE TaskID="&rs("TaskID")
			'			Set rs4=Server.CreateObject("AdoDB.recordSet")
			'			rs4.open SQL4, REDConnString
			'			BgColor=rs4("BgColor")
			'			Color=rs4("TextColor")
			'			BorderStyle="outset"
			'			If rs("Done")="True" Then
			'				Color="555"
			'				BgColor=rs4("AltBgColor")
			'				BorderStyle="inset"
			'			End If
			'			Set rs4=Nothing
			'			
			'			DragLeft="<span id=DragLeft"&rs("CalID")&" class=DragLeft onselectstart=""return false"" onMouseDown=""EvExID="&CalID&"; EvExDir=-1; "">◄</span>"
			'			DragRight="<span id=DragRight"&rs("CalID")&" class=DragRight onselectstart=""return false"" onMouseDown=""EvExID="&CalID&"; EvExDir=1; "">►</span>"
			'		
			'			EvClass=" class=""Event"
			'			'If rs("DateFrom")>=wkDays(wkDayIndex) Then EventClass=EventClass&" EventStart" Else DragLeft=""
			'			If rs("DateFrom")>=Sunday Then EvClass=EvClass&" EventStart" Else DragLeft=""
			'			If rs("DateTo")<=Sunday2 Then EvClass=EvClass&" EventEnd" Else DragRight=""
			'			EvClass=EvClass&""""
			'			
			'			EvStart=rs("DateFrom")
			'			EvStop=rs("DateTo")
			'			If EvStop>Sunday2 Then EvStop=Sunday2
			'			EvLength=DateDiff("d",EvStart,EvStop)+1
			'			
			'			if EvLength=0 Then EvLength=.25
			'			width=10*EvLength
			'			
			'			Style=" style=""Background:#"&BgColor&"; border:1px "&BorderStyle&"; color:#"&Color&"; left:"&LeftPos&"%; top:"&TopPos&"px; width:"&width&"%;"" "
						%>
			<!--
						<div id=Event< %=CalID%>< %=EvClass%>< %=Style%> d8From="< %=rs("DateFrom")%>" d8To="< %=rs("DateTo")%>" onMouseMove="evMPos(event,this);" onMouseDown="evMDown();">
							< %=DragLeft%>
							<div id="EventName< %=CalID%>" class="EventName" onselectstart="return false" onMouseDown="EvExID=< %=rs("CalID")%>; EvExDir=2">< %=rs("Title")%></div>
							< %=DragRight%>
						</div>
						<script type="text/javascript">
							Gebi('Event< %=CalID%>').title="< %=rs("Title")%>\n\n< %="NOTES:  "&Replace(rs("Note"),"Notes:","")%>";
							//Gebi('EventName< %=CalID%>').style.width=(Gebi('Event< %=CalID%>').offsetWidth-128)+'px';
						</script>
			-->
						<%
			'			rs.moveNext	:	If rs.EOF Then Exit Do
			'		Loop
			'		If rs.EOF Then Exit For
			'		RowsTotalTop=RowsTotalTop+RowHeight
			'	Next
			'	If rs.EOF Then Exit Do
			'Loop
			'% >
			'<script type="text/javascript"> Gebi('Row<%=RowNum% >').style.height='<%=RowHeight% >px'; < /script>
			'<%
			'Set rs1=Nothing
		'Loop
	%>
</div>
</body>
</html>
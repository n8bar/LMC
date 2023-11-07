<%@LANGUAGE=VBSCRIPT CODEPAGE=65001 %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<!-- #include file="../TMC/RED.asp" -->
<!-- #include file="Common.ASP" -->

<script type="text/javascript" src="Library/ListsCommon.js"></script>
<link rel=stylesheet href="Library/ListsCommon.css" media=all >
<%
TaskID=Request.QueryString("Type")

SQL="SELECT TaskName, TextColor FROM Tasks WHERE TaskID="&TaskID&" AND EnableCal=1"
%><%'=SQL%><%
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString
If Not rs.EOF Then 
	TaskName=rs("TaskName")
	%><style> * { color:#<%=rs("TextColor")%>; } </style><%
Else 
	TaskName=Unknown
	%><style> * { color:#07c; } </style><% 
End If
Set rs=Nothing

%>
<title><%=TaskName%> Events</title>

<script type="text/javascript">

var listSrc='eventlist.asp?Type=<%=TaskID%>';
var taskID=0<%=TaskID%>;
var topTab;
try {	topTab=window.top.getElementsByClassName('selectedMainTab'); } 
catch(e) { topTab='\\'; }

function Resize() {
	var H= Math.abs(document.body.offsetHeight-0);//54
	var H2=Gebi('Top').offsetHeight+Gebi('mainToolbar').offsetHeight+Gebi('SearchBar').offsetHeight
	Gebi('ListBody').style.height = (H-H2)+('px');//96
	//Gebi('TLItemsContainer').style.height=(Gebi('ListBody').offsetHeight-0)+'px';
	//var FrameH=Gebi('TLItemsContainer').offsetHeight-0;//-49;
	//Gebi('BidListFrame').style.height=FrameH+'px';
	//Gebi('ItemNotesContainer').style.height=Math.abs(Gebi('ListBody').offsetHeight-28)+'px';
	
}

function Load() {
	//try {	
		topTab=window.top.document.getElementsByClassName('selectedMainTab'); 
	//} 
	//catch(e) { topTab='\\'; }
	if(!!topTab) Gebi('path').innerHTML.replace('TMC',topTab.innerHTML);
	
	Search();
}

function Search() {
	var id=taskID.toString();
	sessionWrite('eventListText'+id,Gebi('sName').value);
	sessionWrite('eventListAttn'+id,SelI('sAttn').innerHTML);
	sessionWrite('eventListAttnID'+id,SelI('sAttn').value);
	sessionWrite('eventListFrom'+id,Gebi('sStartDate').value);
	sessionWrite('eventListTo'+id,Gebi('sEndDate').value);
	
	Gebi('eventList').contentWindow.location=listSrc;
}
</script>
</head>

<body onResize="Resize();" onLoad="Resize(); Load();">

<div id=newEventModal>
	<div id="NewEventBox" class="NewEventBox WindowBox">
		<div id=NewEventBoxTitle class="WindowTitle" style="border-bottom:1px solid #AAA; background:#3599E3;">
			<div  id="EventHeaderTxt" class="NewEventHeaderText" align="left">Create New Event</div>
		</div>
	 
		<div id=NewEventBoxLeft style="width:50%; height:268px; padding:8px 4px 0 4px; float:left;" align=left >
			<div class=EventLabelText >Title&nbsp;</div>
			<input type=text id=EventTitleText class=EventTextBox style="font-size:12px; font-weight:bold;" size=36 maxlength=44 />
			<br/>
			<br/>
			<div class="EventLabelText" >Date&nbsp;</div>
			<input type="text" name="FromDateTxt" id="FromDateTxt" class="EventTextBox" size="36" maxlength="20" value=""/>
			<img style="cursor:pointer;" onclick="displayCalendar('FromDateTxt','mm/dd/yyyy',this); posCal();" onMouseOver="calPosUpdate(event,this);" src="../images/cal.gif" width=16 height=16>
			<br/>
			<div class="EventLabelText" >To Date&nbsp;</div>
			<input type="text" name="ToDateTxt" id="ToDateTxt" class="EventTextBox" size="32"  onChange="ToDateChange();" maxlength="20"/>
			<img style="cursor:pointer;"onclick="displayCalendar('ToDateTxt','mm/dd/yyyy',this); posCal();" onMouseOver="calPosUpdate(event,this);" src="../images/cal.gif" width="16" height="16">
			<br/>
			<br/>
			<div class="EventLabelText" >Notes&nbsp;</div>
			<textarea name="EventNewNotes" id="EventNewNotes" class="EventTextBox" cols=32 rows=8 ></textarea>
			<br/>
			<label class="EventLabelText" ><input type="checkbox" name="DoneCheck" id="DoneCheck" />Done</label>
			<br/>
			<input type="submit" name="DeleteEventBtn" id="DeleteEventBtn" value="Delete" onClick="return EventDeleteConfirm();"/>
		</div>
		
		<div id=NewEventBoxRight style="width:50%; height:268px; padding:8px 4px 0 4px; float:left;" align=left >
			<div class="EventLabelText" >Attention&nbsp;</div>
			<%    
			SQL = "select EmpID, FName, LName from Employees WHERE Active=1 Order By FName" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>
			<select name=AttnList id=AttnList style="width:204px;">
				<option value=1500 >----</option>
				<% 
				Do While Not rs.EOF
				%><option value="<%= rs("EmpID")%>"><%= rs("Fname")&" "&rs("Lname")%></option><%   
					rs.MoveNext
				Loop
				
				Set rs = Nothing
				%>
			</select>
			<br/>
			<br/>
			<div class="EventLabelText" >Event Type&nbsp;</div>
			<%    
			SQL = "select TaskID, TaskName from Tasks order by OrderNum" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>            
			<select name=TaskList id=TaskList style="width:196px;" onChange="EventProjectSelect();">
				<option value="0"Selected>----</option>
				<%
				Do While Not rs.EOF
					%><option  value="<%= rs("TaskID")%>"><%= rs("TaskName")%></option><%
					rs.MoveNext
				Loop
				set rs = nothing
				%>
			</select>
			<br/>
			<br/>
			<select name=JobName id=JobName style="display:none;"></select>
			<br/>
			<!--
			<div class="EventLabelText" >Phase</div>
			<%    
			'SQL = "select PhaseID, PhaseName from Phase" 
			'set rs=Server.CreateObject("ADODB.Recordset")
			'rs.Open SQL, REDconnstring 
			%>
			-->
			<select name=PhaseList id=PhaseList style="display:none;">
				<option value="0"selected>----</option>
				<%
				'Do Until rs.EOF
				'	% ><option  value="<%= rs("PhaseID")% >">< %= rs("PhaseName")% ></option><%   
				'	rs.MoveNext
				'Loop
				'set rs = nothing
				%>
			</select>
			<div class=EventLabelText >Project Manager&nbsp;</div>
			<%    
			SQL = "SELECT EmpID, FName, LName FROM Employees WHERE Active=1" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>            
			<select name=SuperList id=SuperList style="width:156px;">
				<option value=0 Selected>----</option>
				<%
				Do Until rs.EOF
					%>
					<option  value="<%= rs("EmpID")%>" ><%= rs("Fname")&" "&rs("Lname")%></option>
					<%   
					rs.MoveNext
				Loop
				set rs = nothing
				%>
			</select> 
			<br/>
			<div class=EventLabelText >Area&nbsp;</div>
			<br/>
			<div class="EventLabelText" >Customer&nbsp;</div>
			<%    
			SQL = "SELECT ID, Name FROM Contacts WHERE Customer=1 ORDER BY Name" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>
			<select name=CustomerList id=CustomerList style="font-size:10px; width:212px">
				<option value="0"selected="selected">----</option>
				<%
				Do While Not rs.EOF
					%><option  value="<%= rs("ID")%>"><%= rs("Name")%></option><%
					rs.MoveNext
				Loop
				set rs = nothing
				%>
			</select>
			<br/>
			<br/>
			<div class=EventLabelText >Crew&nbsp;</div>
			<%    
			SQL = "select EmpID, FName, LName from Employees WHERE Active=1" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>
			<select id=CrewList onchange="Gebi('CrewNames').value+='\n'+SelI('CrewList').innerHTML; this.selectedIndex=0;" style="width:244px;">
				<option value=0 selected=selected >Click a name to add.</option>
				<% 
				Do Until rs.EOF
					%><option  value="<%= rs("EmpID")%>"><%= rs("Fname")&" "&rs("Lname")%></option><%   
					rs.MoveNext
				Loop
				Set rs = nothing
				%>
			</select>
			<br/>
			<textarea name=CrewNames id=CrewNames class=EventTextBox cols=41 rows=3 style="margin-bottom:8px;" ></textarea>
			<br/>
			 <input type="submit" name="SaveEventBtn" id="SaveEventBtn" value="Update/Save" style="float:right;" />
			 &nbsp;&nbsp;
			 <input type="Button" name="CancelEventBtn" id="CancelEventBtn" value="Cancel" style="float:right;" onClick="hideEventModal();"/>
			</div>
		
		<div class=EventLabelText >Repeat</div>
		<select name=EventRepeat id=EventRepeat class=EventListBox >
			<option value="0"Selected>No Repeat</option>
			<option value="365">Every Day</option>
			<option value="52">Once A Week</option>
			<option value="12">Once A Month</option>
			<option value="4">Every 3 Months</option>
			<option value="2">Every 6 Months</option>
			<option value="1">Once A Year</option>
		</select>
		
		<input name="EventID" id="EventID"type="hidden" size="1" />
		<input name="Source" id="Source"type="hidden" size="1" />
		
		<div id="EventDetailsScreen"  Class="EventDetailsScreen"></div>
	
		<div id="EventDetails2"  Class="EventDetailsScreen">
				</div>
				<div>
					<div>&nbsp;</div>
					<div>&nbsp;</div>
				</div>
			</div>
	</div>


	<div id=Top></div>
	<div id=mainToolbar class=Toolbar style="background:none; height:48px; text-align:center; width:98%;" >
		<% If TaskName="" Then TaskName="My ToDo" %>
		<div id=path>&nbsp; My TMC > <%=TaskName%> > <big><b>Task List</b></big></div>
		<script type="text/javascript">
			var path='';
			var topLevel=window.top.document;
			try { //(!!topLevel.getElementsByClassName('selectedMainTab')) {
				path+=topLevel.getElementsByClassName('selectedMainTab')[0].innerHTML+'>';
			} catch(e) { /*path='My TMC >'*/ }
			path+=' <%=TaskName%> > <big><b>Task List</b></big>';
			Gebi('path').innerHTML=path;
		</script>
		<div class=tSpacer5 >&nbsp;</div>
		<button id=newBid class="tButton32" onClick="showNewTask();" title="New Task" /><img src="../Images/plus_16.png" /></button>
		<div class=tSpacer1 >&nbsp;</div>
		<button id=searchBids class="tButton32" onClick="toggleSearchSort();" title="Search Bids" /><img src="../Images/search.png" /></button>
		<div class="tSpacer5">&nbsp;</div>
		<div class="tSpacer10">&nbsp;</div>
		<div class="tSpacer10">&nbsp;</div>
		<div class="tSpacer10">&nbsp;</div>
		<button id=ReloadFrame class=tButton32 onClick="window.location=window.location;" title="Reload Tab"/><img src="../Images/reloadblue24.png" /></button>
	</div>

	<form id=SearchBar class="Toolbar" style="height:auto;" action="javascript:Search();">
		<input id=btnSearch style="position:relative; float:right; " type="submit" value="search"/>
		&nbsp;<label>Event Title or Notes<input id=sName type="text" onkeypress="ifEnter(event,'Search();');" /></label>
		&nbsp;<label>Attn To:<select id=sAttn onkeypress="ifEnter(event,'Search();');"><option value=""></option><%EmployeeOptionList("allActive")%></select></label>&nbsp;
		&nbsp;
		<label>
			Ending After:
			<input id=sStartDate onkeypress="ifEnter(event,'Search();');" onClick="showCal(this,'mm/dd/yyyy',this.value)" value="<%=Date()-365%>" />
			<img src=../Images/cal24x24.gif height=16 style="cursor:pointer;" />
		</label>
		&nbsp;
		<label>
			Starting Before:
			<input id=sEndDate onkeypress="ifEnter(event,'Search();');" onClick="showCal(this,'mm/dd/yyyy',this.value)" value="<%=Date()+365%>" />
			<img src=../Images/cal24x24.gif height=16 style="cursor:pointer" />
		</label>
	</form>
	
	<div id=ListBody style="">
		<iframe id=eventList src="eventlist.asp?Type=<%=TaskID%>"></iframe>
	</div>
	
</body>
</html>

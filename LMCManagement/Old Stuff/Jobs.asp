<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>Jobs / Jobs</title>

<!-- #include file="../../LMC/RED.asp" -->

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="../LMC/LMC-AJAX.js"></script>
<script type="text/javascript" src="../LMC/LMC-JS.js"></script>
<script type="text/javascript" src="JobsJS.js"></script>
<script type="text/javascript" src="JobsAJAX.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>
<script type="text/javascript" src="../Library/dhtmlgoodies_calendar.js?random=20060118"></script>

<script type="text/javascript">
	var JobsListOnLoadJS='//alert(\'It\\\'s working!\');';
	<%
	Dim TaskType
	TaskType=Request.QueryString("Type")
	
	Dim BgColor
	Select Case TaskType  'Since this is this run server-side anyway why not pull it from the database?  Too lazy I guess.
		
		Case 0 'No Job Type Specified
			BgColor="CCC" 
		Case 2 'General Notes
			BgColor="FFB"
		Case 3 'Service
			BgColor="E6E6FF"
		Case 4 'Test/Maint
			BgColor="FFF2F2"
		Case 6 'Estimating / Sales
			BgColor="EBF5E0"
		Case 7 'Purchasing
			BgColor="E1FFFF"
		Case 8 'Shipping / Inventory
			BgColor="FBF5EE"
		Case 9 'Office Management
			BgColor="F3EFFC"
		Case 10 'Training
			BgColor="F3FEFA"
		Case 11 'Personal
			BgColor="F9E9FE"
		Case 12 'Website
			BgColor="F9F5FA"
		Case 17 'Environ
			BgColor="ECF4F0"
		Case Else
			BgColor="EEE"
	End Select
	%>
	
	var TaskType=<%=TaskType%>;
	
	<%
	tasksSQL="SELECT * FROM Tasks WHERE TaskID="&TaskType
	set tasksRS=Server.CreateObject("AdoDB.RecordSet")
	tasksRS.Open tasksSQL, REDConnString
	%>
	
	var calKey='tricomlv.com_<%=tasksRS("GoogleCalendarKey")%>%40group.calendar.google.com';
	var calFeed='https://www.google.com/calendar/feeds/'+calKey+'/private/full';
	
	//alert(calFeed);
	
	<%
	set tasksRS=Nothing
	%>

</script>


<link rel="stylesheet" href="../Library/CSS_DEFAULTS.css" media="screen">
<link rel="stylesheet" href="../Library/ListsCommon.css" media="screen">
<link rel="stylesheet" href="JobsCSS.css" media="screen">
<link type="text/css" rel="stylesheet" href="../Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">


</head>
<body onLoad="Resize(); ListResize(); setTimeout('LoadCommonData();',1000);" onResize="Resize(); ListResize();" onFocus="Resize(); ListResize();" onMouseMove="MouseMove(event);">

<div id=Modal></div>

<div id="ScheduleBox" align=left>
	<div id="SchTitle">Schedule Project <div id=SchProjID></div></div>
	<div style="float:left; width:100%; height:4px;"></div>
	<div id=SchProjName contenteditable=true></div>
	<div style="float:left; width:100%; height:8px;"></div>
	
	<div id=SchMain>
		<div id=SchLeft>
			<div style="width:100%;">
				<label class=SchBoxLabel for=SchDateFrom>From:<img class=SchCal onClick="//displayCalendar('SchDateFrom','mm/dd/yyyy',SchDateFrom);" src=../../LMCManagement/Images/cal.gif></label>
			</div>
			<input id=SchDateFrom class="SchBoxTxt" type="text" onFocus="displayCalendar('SchDateFrom','mm/dd/yyyy',SchDateFrom);" onChange=""/>
			<br/>
			
			<div style="width:100%;">
				<label class="SchBoxLabel" for=SchDateTo>To:<img class=SchCal onClick="//displayCalendar('SchDateTo','mm/dd/yyyy',SchDateTo);" src="../../LMCManagement/Images/cal.gif"></label>
			</div>
			<input id=SchDateTo class=SchBoxTxt type=text onFocus="displayCalendar('SchDateTo','mm/dd/yyyy',SchDateTo);" onChange=""/>
			<br/>
			
			<div style="width:100%;">
				<label class="SchBoxLabel" for=SchRecureence>Recurrence:</label>
			</div>
			<select id=SchRecureence class=SchBoxTxt >
				<option>Coming Soon...</option>
			</select>
			<br/>
		</div>
		
		<div id=SchRight>
			<div style="width:100%;">
				<label class="SchBoxLabel" for=SchAttn>Attention:</label>
			</div>
			<select id=SchAttn class=SchBoxTxt2 onChange="">
				<option>none</option>
			</select>
			<br/>		
		
			<div style="width:100%;">
				<label class="SchBoxLabel" for=SchLocation>Where?</label>
			</div>
			<input id=SchLoc class=SchBoxTxt2 type=text>
			<br/>		
		
			<div style="width:100%;">
				<label class="SchBoxLabel" for=SchPhase>Phase:</label>
			</div>
			<select id=SchPhase class=SchBoxTxt2>
				<option value=N/A>Not Applicable</option>
				<option value=Plan>Engineering</option>
				<option value=UG>Underground</option>
				<option value="Rough in">Rough in</option>
				<option value=Trim>Trim</option>
				<option value=Finish>Finish</option>
			</select>
			<br/>		
		</div>
	
		<div id=SchNotes>
			<label id=NotesLabel for=NotesText>&nbsp;Notes:</label>
			<textarea id=NotesText></textarea>
		</div>
	</div>
	
	<div id=SchCrew>
		<label id=CrewLabel for=CrewAdd>Crew:</label>
		<select id=Crew class=SchBoxTxt onChange="if(Gebi('CrewList').value!=''){Gebi('CrewList').value+=', ';} Gebi('CrewList').value+=SelI(this.id).innerText;">
			<option>none</option>
		</select>
		<textarea id=CrewList></textarea>
	</div>
	
	<div style="float:left; width:100%; height:4px;"></div>
	<form action="javascript:ScheduleEvent();" style="float:right;">
		&nbsp;<input id=SchSchedule type="submit" value=" Schedule " />&nbsp;</form>
	
	&nbsp;<button onClick="Gebi('ScheduleBox').style.display='none'; Gebi('Modal').style.display='none'; ">&nbsp;Cancel&nbsp;</button>

</div>



<div id="NewJobBox" class="ModalBox" style="background:#<%=BgColor%>;">
	
	<div style="width:100%; height:24px; font-size:22px; background:#3599E3; color:#000; text-align:center; font-weight:bold; text-shadow:-1px -1px 3px #fff;">New Job</div>
	<br/>
	<br/>
	<br/>
	<div for="NewJobTitle" style="width:33%; text-align:right; float:left;"><b>Job Name:</b></div>
	<input id="NewJobTitle" style="width:49%; min-width:49%; float:left;" /><br/>
	<br/>
	<br/>
	<label for="NewJobCust" style="width:33%; text-align:right; float:left;">Customer:</label>
	<input id="NewJobCust" style="width:49%; min-width:49%; float:left; position:relative;"
	 onfocus="CustSearch(this,Gebi('NewJobBox').style.left,Gebi('NewJobBox').style.top);" 
	 onChange="LoadCustList(this); this.style.color='#D00';" 
	 onKeyUp="LoadCustList(this); this.style.color='#D00';"
	 /><br/>
	<br/>
	<br/>
	<label for="NewJobAttn" style="width:33%; text-align:right; float:left;">Attention:</label>
	<select id="NewJobAttn" style="width:49%; min-width:49%; float:left;">
	<%
		EmpsSQL="SELECT * FROM Employees WHERE Active='True'"
		Set rsEmps=Server.CreateObject("AdoDB.RecordSet")
		rsEmps.Open EmpsSQL, REDConnString
		
		Do Until rsEmps.EOF
			%>	<option value="<%=rsEmps("EmpID")%>"><%=rsEmps("FName")%>&nbsp;<%=rsEmps("LName")%></option>	<%
			Response.Flush()
			rsEmps.MoveNext
		Loop
		
		Set rsEmps=Nothing
	%>
	</select><br/>
	<br/>
	<br/>
	<label for="NewJobDate" style="width:33%; text-align:right; float:left;">Date:</label>
	<input id="NewJobDate" style="width:49%; min-width:49%; float:left;" value="<%=Date()%>"/>
  <img style="cursor:pointer;"onclick="displayCalendar('NewJobDate','mm/dd/yyyy',this)" src="../../LMCManagement/Images/cal.gif" width="16" height="16"><br/>
	<br/>
	<br/>
	<label for="NewJobDue" style="width:33%; text-align:right; float:left;">Due:</label>
	<input id="NewJobDue" style="width:49%; min-width:49%; float:left;" value="<%=Date()%>"/>
  <img style="cursor:pointer;"onclick="displayCalendar('NewJobDue','mm/dd/yyyy',this)" src="../../LMCManagement/Images/cal.gif" width="16" height="16"><br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<button style="float:left; padding:0; margin:0;" onClick="this.parentNode.style.display='none'; Gebi('ModalScreen').style.display='none';">Cancel</button>
	<button style="float:right; padding:0; margin:0;" onClick="AddNewJob(Gebi('NewJobTitle').value, Gebi('NewJobCust').value, SelI('NewJobAttn').innerText, Gebi('NewJobDate').value, Gebi('NewJobDue').value);">Add</button>
</div>

<div id="ModalScreen"></div>











<div class="OverAllContainer" id="OverAllContainer">
<!--  Begin Right Container+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<div class="RightContainer" id="RightContainer">

	<div id="JobOverlay" class="JobOverlay" style="display:none;">
		<div id="JobOverlayTxt" class="JobOverlayTxt">Loading Jobs...</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<img name="" src="../../LMCManagement/Images/Roller.gif" width="32" height="32" alt="" />	</div>
 
	<div id="Lists" class="Lists" align="center">
	
		<div id="SearchSort" class="Toolbar" align="center" style="text-align:center; width:100; margin-left:auto; margin-right:auto;">
			<div id="SearchSortInner" style="width:100%;">
				<button id="TestButton1" style=" float:left; margin:1px 4px 0 0;" onClick="ChangeToArchive()">Job Archive</button>
				<button id="TestButton2" style=" float:left; margin:1px 4px 0 0; display:none;" onClick="ChangeToActive()">Current Jobs</button>
				
				<div style="float:left; margin:2px 0 0 0;">&nbsp; &nbsp; Sort by:</div>
				
				<select id="SelSortBy" onChange="SortBy(this[this.selectedIndex].value);">
					<option id="SortNoteID" value="NoteID">Job# (Lowest)</option>
					<option id="SortNoteID1" value="NoteID DESC">Job# (Highest)</option>
					<option id="SortPriority" value="Priority DESC" selected >Priority (Highest)</option>
					<option id="SortPriority1" value="Priority" >Priority (Lowest)</option>
					<option id="SortJobName" value="Job">Job Name</option>
					<option id="SortProgress" value="Progress DESC">Progress (Most)</option>
					<option id="SortProgress" value="Progress ">Progress (Least)</option>
					<option id="SortDateStarted" value="Date ">Date Started (Earliest)</option>
					<option id="SortDateStarted1" value="Date DESC">Date Started (Latest)</option>
					<option id="SortDateDue" value="DateDue">Date Due (Earliest)</option>
					<option id="SortDateDue1" value="DateDue DESC">Date Due (Latest)</option>
					<option id="SortDateCompleted" value="DateCompleted">Date Completed (Earliest)</option>
					<option id="SortDateCompleted1" value="DateCompleted DESC">Date Completed (Latest)</option>
				</select>
				
				<label for="JobRenamer" style="float:left; margin:2px 0 0 0;">&nbsp; &nbsp; Job Name:</label>
				
				<input id="JobRenamer" onKeyUp="RenameJob(this.value);" width="50"/>
				
				&nbsp; &nbsp; 
				
				<button id="NewJob" onClick=" Gebi('NewJobBox').style.display='block'; Gebi('ModalScreen').style.display='block'; Gebi('NewJobTitle').focus();"><img src="../../LMCManagement/images/plus_16.png"/>Add New Job</button>
				<button id="DelJob" onClick="DelJob();"><img src="../../LMCManagement/images/delete_16.png"/>Delete Selected Job</button>
					
				<button id="ReloadFrame" onClick="window.location=window.location"><img src="../../LMCManagement/images/reloadblue24.png" width="100%" height="100%"/></button>
			</div>
		</div>
							
		<div id="ToDoToolbar" class="Toolbar" style="min-width:992px; margin-left:auto; margin-right:auto;">
		
			<div style="float:left; width:33%; min-width:33%; height:100%; min-height:100%; overflow:hidden;">
				<div id="JobListControl" style="float:left; width:100%; height:100%; min-height:100%;">
					&nbsp;<span class="ControlLabel"> Add a list for:</span>
					<select id="ToDoEmpList" class="ControlInput">
						<option selected></option>
					</select>
					<button onClick="NewEmpList();"><img src="../../LMCManagement/images/plus_16.png"/>Add</button>
				</div>
			
				<div id="ItemListControl" style="float:left; display:none; width:100%;" align="left">
					<div id="lblItemListAdd" class="ControlLabel" style="font-size:14px; padding-top:2px;">&nbsp;New Task For Employee</div>
					<input id="txtItemListAdd" style="width:35%; max-width:35%; text-overflow:ellipsis; float:left;"/>
					<button onClick="NewItemList();" style="width:12%; max-width:35%; float:left;"><img src="../../LMCManagement/images/plus_16.png"/>Add</button>
				</div>
				
				<div id="ListItemControl" style="float:left; display:none; width:100%;">
					&nbsp;<span id="lblListItemAdd" class="ControlLabel" style="font-size:14px; padding-top:2px;" >New Task Item For Item List</span>
					<input id="txtListItemAdd" class="ControlInput"/>
					<button onClick="NewListItem();" style="width:12%; max-width:35%;"><img src="../../LMCManagement/images/plus_16.png"/>Add</button>
				</div>
				
				<div id="ListItemControl" style="float:left; display:none; width:100%;">
					&nbsp;<span id="lblListItemAdd" class="ControlLabel">New Task Item For Item List</span>
					<input id="txtListItemAdd"  class="ControlInput"/>
					<button onClick="NewListItem();" style="width:12%; max-width:35%;"><img src="../../LMCManagement/images/plus_16.png"/>Add</button>
				</div>
			</div>
				
			<div id="Rename Control" style="float:left; width:33%;">
				Rename <span id="lblRename"></span> <input id="txtRename" onKeyUp="RenameItem(this.value);"/>
			</div>
			
			<div style="float:right; width:33%">
				<button id="btnRemove" style=" margin-left:2%; text-overflow:ellipsis;" onClick="DelTreeItem();"><img src="../../LMCManagement/images/minus_16.png"/>Remove <span id="RemItemName"></span></button>
			</div>
		</div>
							
		<div id="ListBody" class="ListBody" align="center">
	
			<div id="TLItemsContainer" class="TLItemsContainer">
			
				<div id="ItemsHead" class="ItemsHead">        	
					<div class="HeadNum" align="left">#</div >
					<div class="HeadPri" align="left">!</div >
					<div class="HeadManage" align="left"><img src="../../LMCManagement/images/FolderOutline.png"/></div >
					<div class="HeadJob" align="left">Job</div >
					<div class="HeadCust" align="left">Customer</div>
					<div class="HeadProg" align="center"><big><big>•••</big></big></div>
					<div class="HeadAttn" align="left">Attention</div>
					
					<div class="HeadDates">Date</div >
					<div class="HeadDates" align="left">Due</div >
					<div class="HeadDates" align="left"><small>Completed</small></div >
				</div>

				<iframe id="JobsListFrame" src="JobsList.asp?TaskType=<%=TaskType%>&Active=True&SortBy=Priority DESC" frameborder="0" scrolling="auto"></iframe>
			</div> 
			
			<div id="TLItemsNotes" class="TLItemsNotes">
				<div id="ItemNotesHead" class="ItemNotesHead">Notes</div>
				<div id="ItemNotesContainer">
					<textarea id="ItemNotesText" onKeyUp="SaveNotes(this.value);"></textarea>
				</div>       	
			</div>
			<script type="text/javascript">
				var JobsList=Gebi('JobsListFrame').contentWindow;
				var Active='True';
				var SortedBy='Priority DESC';
			</script>
		</div>                
		
		
		<div id="TLItemsBottom" class=""></div> 
		
		
		<div id="EmployeeList" class="EmployeeList"></div>
	<!-- Popup Menu for assigning Employee List to tasks -->
		<div id="PhaseProgressMenu" class="PhaseProgressMenu"></div>
	</div>

<!--  End White Board------------------------------------------------------------------------------------------------------------- -->

<!--  End White Board------------------------------------------------------------------------------------------------------------- -->

<!--  End White Board------------------------------------------------------------------------------------------------------------- -->
<!--
	<div id="EstimateMain" class="MainContainer">
		<div id="PhaseProgressMenu" class="PhaseProgressMenu">
			<!-- Right Click Menu -->
<!--		</div>
	</div>
-->
</div>
<!-- -End Right Container=======================================================================End Right Container>
<!--  ------End Right Container=======================================================================End Right Container>
<!--  ------End Right Container=======================================================================End Right Container>
</div>

<!-- End OveralDiv $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ -->

<div id="CSearchBox" style="z-index:100020;"></div>
</body>
</html>







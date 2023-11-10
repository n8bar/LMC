<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>Jobs / Jobs</title>

<!-- #include file="../LMC/RED.asp" -->

<script type="text/javascript" src="Modules/rcstri.js"></script>
<script type="text/javascript" src="LMC/LMC-AJAX.js"></script>
<script type="text/javascript" src="LMC/LMC-JS.js"></script>
<script type="text/javascript" src="Library/SimpleJobsJS.js"></script>
<script type="text/javascript" src="Library/SimpleJobsAJAX.js"></script>
<script type="text/javascript" src="Library/SqlAjax.js"></script>
<script type="text/javascript" src="Library/dhtmlgoodies_calendar.js?random=20060118"></script>

<script type="text/javascript">
	var JobsListOnLoadJS='//alert(\'It\\\'s working!\');';
	<%
	Dim TaskType
	TaskType=Request.QueryString("Type")
	%>
	var TaskType=<%=TaskType%>;
	
	<%
	tasksSQL="SELECT * FROM Tasks WHERE TaskID="&TaskType
	set tasksRS=Server.CreateObject("AdoDB.RecordSet")
	tasksRS.Open tasksSQL, REDConnString
	%>
	
	var calKey='tricomlv.com_<%=tasksRS("GoogleCalendarKey")%>%40group.calendar.google.com';
	var calFeed='https://www.google.com/calendar/feeds/'+calKey+'/private/full';
	
	<%
	set tasksRS=Nothing
	%>

</script>


<link rel="stylesheet" href="Library/CSS_DEFAULTS.css" media="screen">
<link rel="stylesheet" href="Library/ListsCommon.css" media="screen">
<link rel="stylesheet" href="Library/SimpleJobsCSS.css" media="screen">
<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">


</head>
<body onLoad="Resize(); ListResize(); setTimeout('LoadCommonData();',1000);" onResize="Resize();" onFocus="Resize();" onMouseMove="MouseMove(event);">

<div id=Modal></div>

<div id="ScheduleBox" align=left>
	<div id="SchTitle">Schedule Project <div id=SchProjID></div></div>
	<div style="float:left; width:100%; height:4px;"></div>
	<div id=SchProjName contenteditable=true></div>
	<div style="float:left; width:100%; height:8px;"></div>
	
	<div id=SchMain>
		<div id=SchLeft>
			<div style="width:100%;">
				<label class=SchBoxLabel for=SchDateFrom>From:<img class=SchCal onClick="//displayCalendar('SchDateFrom','mm/dd/yyyy',SchDateFrom);" src=../LMCManagement/Images/cal.gif></label>
			</div>
			<input id=SchDateFrom class="SchBoxTxt" type="text" onFocus="displayCalendar('SchDateFrom','mm/dd/yyyy',SchDateFrom);" onChange=""/>
			<br/>
			
			<div style="width:100%;">
				<label class="SchBoxLabel" for=SchDateTo>To:<img class=SchCal onClick="//displayCalendar('SchDateTo','mm/dd/yyyy',SchDateTo);" src="../LMCManagement/Images/cal.gif"></label>
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



<div class="OverAllContainer" id="OverAllContainer">

<!--  Begin Right Container+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!--  Begin Right Container+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<div class="RightContainer" id="RightContainer">

	<div id="JobOverlay" class="JobOverlay" style="display:none;">
		<div id="JobOverlayTxt" class="JobOverlayTxt">Loading Jobs...</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<img name="" src="../LMCManagement/Images/Roller.gif" width="32" height="32" alt="" />	</div>
 
        

<!-- This is the Main White Board or task list-------------------------------------------------------------------- -->

	
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
				
				<button id="NewJob" onClick="AddNewJob();"><img src="../LMCManagement/images/plus_16.png"/>Add New Job</button>
				<button id="DelJob" onClick="DelJob();"><img src="../LMCManagement/images/delete_16.png"/>Delete Selected Job</button>
					
				<button id="ReloadFrame" onClick="window.location=window.location"><img src="../LMCManagement/images/reloadblue24.png" width="100%" height="100%"/></button>
			</div>
		</div>
							
		<div id="ToDoToolbar" class="Toolbar" style="margin-left:auto; margin-right:auto;">
		
			<div style="float:left; width:33%; min-width:33%; height:100%; min-height:100%; overflow:hidden;">
				<span id="JobListControl" style="float:left; width:100%; height:100%; min-height:100%;">
					&nbsp;<div class="ControlLabel"> Add a list for:</div>
					<select id="ToDoEmpList" class="ControlInput">
						<option selected></option>
					</select>
					<button onClick="NewEmpList();">Add</button>
				</span>
			
				<div id="ItemListControl" style="float:left; display:none; width:100%;" align="left">
					<div id="lblItemListAdd" class="ControlLabel" style="font-size:14px; padding-top:2px;">&nbsp;New Task For Employee</div>
					<input id="txtItemListAdd" style="width:35%; max-width:35%; text-overflow:ellipsis; float:left;"/>
					<button onClick="NewItemList();" style="width:12%; max-width:35%; float:left;">Add</button>
				</div>
				
				<div id="ListItemControl" style="float:left; display:none; width:100%;">
					&nbsp;<span id="lblListItemAdd" class="ControlLabel" style="font-size:14px; padding-top:2px;" >New Task Item For Item List</span>
					<input id="txtListItemAdd" class="ControlInput"/>
					<button onClick="NewListItem();" style="width:12%; max-width:35%;">Add</button>
				</div>
				
				<div id="ListItemControl" style="float:left; display:none; width:100%;">
					&nbsp;<span id="lblListItemAdd" class="ControlLabel">New Task Item For Item List</span>
					<input id="txtListItemAdd"  class="ControlInput"/>
					<button onClick="NewListItem();" style="width:12%; max-width:35%;">Add</button>
				</div>
			</div>
				
			<div id="Rename Control" style="float:left; width:33%;">
				Rename <span id="lblRename"></span> <input id="txtRename" onKeyUp="RenameItem(this.value);"/>
			</div>
			
			<div style="float:right; width:33%">
				<button id="btnRemove" style=" margin-left:2%; text-overflow:ellipsis;" onClick="DelTreeItem();">Remove <span id="RemItemName"></span></button>
			</div>
		</div>
							
		<div id="ListBody" class="ListBody" align="center">
	
			<div id="TLItemsContainer" class="TLItemsContainer">
			
				<div id="ItemsHead" class="ItemsHead">        	
					<div class="HeadNum" align="left">#</div >
					<div class="HeadPri" align="left">!</div >
					<div class="HeadManage" align="left"><img src="../LMCManagement/images/FolderOutline.png"/></div >
					<div class="HeadJob" align="left">Job</div >
					<!-- <div class="HeadCust" align="left">Customer</div> -->
					<div class="HeadProg" align="center"><big><big>•••</big></big></div>
					<div class="HeadAttn" align="left">Attention</div>
					
					<div class="HeadDates">Date</div >
					<div class="HeadDates" align="left">Due</div >
					<div class="HeadDates" align="left"><small>Completed</small></div >       
                                                
				</div>
                
               

				<iframe id="JobsListFrame" src="SimpleList.asp?TaskType=<%=TaskType%>&Active=True&SortBy=Priority DESC" frameborder="0" scrolling="auto"></iframe>
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

</body>
</html>







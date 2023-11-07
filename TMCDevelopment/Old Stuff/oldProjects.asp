<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>Projects / Jobs</title>

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="../TMC/TMC-AJAX.js"></script>
<script type="text/javascript" src="../TMC/TMC-JS.js"></script>
<script type="text/javascript" src="ProjectsJS.js"></script>
<script type="text/javascript" src="ProjectsAJAX.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>
<script type="text/javascript" src="../Library/dhtmlgoodies_calendar.js?random=20060118"></script>

<script type="text/javascript">
	var ProjListOnLoadJS='//alert(\'It\\\'s working!\');';
	var calKey='tricomlv.com_brn6cqc9naj3u6rvdotpiog8ec%40group.calendar.google.com';
	var calFeed = 'https://www.google.com/calendar/feeds/'+calKey+'/private/full';
</script>


<link rel="stylesheet" href="../Library/CSS_DEFAULTS.css" media="screen">
<link rel="stylesheet" href="../Library/ListsCommon.css" media="screen">
<link rel="stylesheet" href="ProjectsCSS.css" media="screen">
<link type="text/css" rel="stylesheet" href="../Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">


</head>
<body onLoad="Resize(); LoadCommonData(); " onResize="Resize();" onFocus="Resize(); " onMouseMove="MouseMove(event);">


<div id=Modal></div>

<div id="ScheduleBox" align=left>
	<div id="SchTitle">Schedule Project <div id=SchProjID></div></div>
	<div style="float:left; width:100%; height:4px;"></div>
	<div id=SchProjName contenteditable=true></div>
	<div style="float:left; width:100%; height:8px;"></div>
	
	<div id=SchMain>
		<div id=SchLeft>
			<div style="width:100%;">
				<label class=SchBoxLabel for=SchDateFrom>From:<img class=SchCal onClick="//displayCalendar('SchDateFrom','mm/dd/yyyy',SchDateFrom);" src=../Images/cal.gif></label>
			</div>
			<input id=SchDateFrom class="SchBoxTxt" type="text" onFocus="displayCalendar('SchDateFrom','mm/dd/yyyy',SchDateFrom);" onChange=""/>
			<br/>
			
			<div style="width:100%;">
				<label class="SchBoxLabel" for=SchDateTo>To:<img class=SchCal onClick="//displayCalendar('SchDateTo','mm/dd/yyyy',SchDateTo);" src="../Images/cal.gif"></label>
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

	<div id="ProjectOverlay" class="ProjectOverlay" style="display:none;">
		<div id="ProjectOverlayTxt" class="ProjectOverlayTxt">Loading Projects...</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<img name="" src="../Images/Roller.gif" width="32" height="32" alt="" />	</div>
 
        

<!-- This is the Main White Board or task list-------------------------------------------------------------------- -->

	<div id="Lists" class="Lists" align="center">
	
		<div id="SearchSort" class="Toolbar" style="text-align:center; margin-left:auto; margin-right:auto;">
			<button id="TestButton1" style=" float:left; margin:1px 4px 0 0;" onClick="ChangeToArchive()"><b>Project Archive</b></button>
			<button id="TestButton2" style=" float:left; margin:1px 4px 0 0; display:none;" onClick="ChangeToActive()"><b>Active Projects</b></button>
			
			<div style="float:left; margin:2px 0 0 0;">&nbsp; &nbsp; Sort by:</div>
			
			<select id="SelSortBy" onChange="SortBy(this[this.selectedIndex].value);">
				<option id="SortProjID" value="ProjID">Job# (Lowest)</option>
				<option id="SortProjID1" value="ProjID DESC">Job# (Highest)</option>
				<option id="SortPriority" value="Priority DESC" selected >Priority (Highest)</option>
				<option id="SortPriority1" value="Priority" >Priority (Lowest)</option>
				<option id="SortJobName" value="ProjName">Job Name</option>
				<option id="SorPlanst" value="Plans DESC">Plans</option>
				<option id="SortPermits" value="Permits DESC">Permits</option>
				<option id="SortUnderGround" value="UnderGround DESC">Underground</option>
				<option id="SortRoughIn" value="RoughIn DESC">Rough In</option>
				<option id="SortRoughInspect" value="RoughInspect DESC">Rough Inspection</option>
				<option id="SortOrderMaterials" value="OrderMaterials DESC">Purchasing</option>
				<option id="SortTrim" value="Trim DESC">Trim</option>
				<option id="SortFinishInspect" value="FinishInspect DESC">Finish Inspection</option>
				<option id="SortJobCompleted" value="JobCompleted DESC">Done</option>
				<option id="SortDateStarted" value="DateStarted ">Date Started (Earliest)</option>
				<option id="SortDateStarted1" value="DateStarted DESC">Date Started (Latest)</option>
				<option id="SortDateDue" value="DateDue">Date Due (Earliest)</option>
				<option id="SortDateDue1" value="DateDue DESC">Date Due (Latest)</option>
				<option id="SortDateCompleted" value="DateCompleted">Date Completed (Earliest)</option>
				<option id="SortDateCompleted1" value="DateCompleted DESC">Date Completed (Latest)</option>
			</select>
			<button id="ReloadFrame" onClick="PGebi('ProjectsIframe').src=PGebi('ProjectsIframe').src;">
				<img src="../images/reloadblue24.png" style="width:100%; height:100%"/>
			</button>
			<button id="calAuthenticate" onClick="parent.calLogin();">
				<img id="cAuthImg" src="../images/Cal24x24.gif" style="width:100%; height:100%"/>
			</button>
		</div>
							
		<div id="ToDoToolbar" class="Toolbar" style="text-align:center; margin-left:auto; margin-right:auto;">
		
			<div style="float:left; width:33%; min-width:33%; height:100%;">
				<div id="ProjectListControl" style="float:left; width:100%;">
					<div class="ControlLabel"> Add a list for:</div>
					<select id="ToDoEmpList" class="ControlInput">
						<option selected></option>
					</select>
					<button onClick="NewEmpList();">Add</button>
				</div>
			
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
			<!--	
				<div id="ListItemControl" style="float:left; display:none; width:100%;">
					&nbsp;<span id="lblListItemAdd" class="ControlLabel">New Task Item For Item List</span>
					<input id="txtListItemAdd"  class="ControlInput"/>
					<button onClick="NewListItem();" style="width:12%; max-width:35%;">Add</button>
				</div>
			-->	
				<div id="SubItemControl" style="float:left; display:none; width:100%;">
					&nbsp;<span id="lblSubItemAdd" class="ControlLabel">New SubItem For Item</span>
					<input id="txtSubItemAdd" class="ControlInput"/>
					<button onClick="NewSubItem();" style="width:12%; max-width:35%;">Add</button>
				</div>
			</div>
				
			<div id="Rename Control" style="float:left; width:33%;">
				Rename <span id="lblRename"></span> <input id="txtRename" onKeyUp="RenameItem(this.value);"/>
			</div>
			
			<div style="float:right; width:33%">
				<button id="btnRemove" style="width:100%; max-width:100%; text-overflow:ellipsis;" onClick="DelTreeItem();">Remove <span id="RemItemName"></span></button>
			</div>
		</div>
							
		<div id="ListBody" class="ListBody" align="center">
	
			<div id="TLItemsContainer" class="TLItemsContainer">
			
				<div id="ItemsHead" class="ItemsHead">        	
					<div class="HeadNum" align="left">#</div >
					<div class="HeadPri" align="left">!</div >
					<div class="HeadSched" align="left"></div >
					<div class="HeadReport" align="left"></div >
					<div class="HeadManage" align="left"></div >
					<div id="HeadJob" class="HeadJob" align="left">Project</div >
					<!--
					<div class="HeadCust" align="left">Customer</div>
					<div class="HeadAttn" align="left">Project Manager</div>
					-->
					
					<div class="HeadProg"><div id="HeadPlans" class="HeadDone" >Plans</div></div>
					<div class="HeadProg"><div id="HeadPermits" class="HeadDone">Permits</div></div>
					<div class="HeadProg"><div id="HeadUnderground" class="HeadDone" >UG</div></div>
					<div class="HeadProg"><div id="HeadRough" class="HeadDone">Rough</div></div>
					<div class="HeadProg"><div id="HeadRoughInsp" class="HeadDone">R. Insp.</div></div>
					<div class="HeadProg"><div id="HeadOrderMat" class="HeadDone">Purch.</div></div>
					<div class="HeadProg"><div id="HeadTrim" class="HeadDone">Trim</div></div>
					<div class="HeadProg"><div id="HeadFinalInsp" class="HeadDone">F. Insp.</div></div>
					<div class="HeadProg"><div id="HeadBill" class="HeadDone">Billed</div></div>
					<div class="HeadProg"><div id="HeadPaid" class="HeadDone">Paid</div></div>
					<div class="HeadProg"><div id="HeadDone" class="HeadDone">Done</div></div>
					
					<div class="HeadDates" align="left">Start</div >
					<div class="HeadDates" align="left">Due</div >
					<div class="HeadDates" align="left"><small>Completed</small></div >
				</div>

				<iframe id="ProjListFrame" src="ProjList.asp?Active=True&SortBy=Priority DESC" frameborder="0" scrolling="auto"></iframe>
			</div> 
			
			<div id="TLItemsNotes" class="TLItemsNotes">
				<div id="ItemNotesHead" class="ItemNotesHead">Notes</div>
				<div id="ItemNotesContainer">
					<textarea id="ItemNotesText" onKeyUp="SaveNotes(this.value);"></textarea>
				</div>       	
			</div>
			<script type="text/javascript">
				var ProjList=Gebi('ProjListFrame').contentWindow;
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
-->
	</div>
</div>
<!-- -End Right Container=======================================================================End Right Container>
<!--  ------End Right Container=======================================================================End Right Container>
<!--  ------End Right Container=======================================================================End Right Container>
</div>

<!-- End OveralDiv $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ -->

</body>
</html>







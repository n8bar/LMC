<!--#include file="../LMC/RED.asp" -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Estimating / Sales</title>
<!--#include file="Common.asp" -->

<script type="text/javascript" src="Service/ServiceJS.js?noCache=0<%=loadStamp%>"></script>
<script type="text/javascript" src="Service/ServiceAJAX.js?noCache=0<%=loadStamp%>"></script>
<script type="text/javascript" src="Library/SqlAjax.js?noCache=0<%=loadStamp%>"></script>

<link rel="stylesheet" href="Library/ListsCommon.css?noCache=0<%=loadStamp%>" media="all">
<link rel="stylesheet" href="Service/ServiceCSS.css?noCache=0<%=loadStamp%>" media="all">


</head>
<body onResize="Resize();" onLoad="Resize(); Gebi('ServiceListFrame').src='ServiceList.asp';" >

<div id=Modal></div>
<div id=Modal2></div>

<div id=newCustBox></div>

<div id=NewServiceBox class="WindowBox" align="center" >
	<div class="WindowTitle" style="background:#3366FF; color:#fff; text-align:center;">New Job<div class="redXCircle" onClick="hideNewService();" >X</div></div>
	<form action="javascript:SaveNewService();">
		<br/>
		<br/>
		<div class=newServiceBoxRow style="height:26px;" >
			<label class=newServiceLabel for=nbJobName ><big>Job Name:</big></label>
			<input id=nbJobName type=text class=newServiceTxt style="font-size:22px;" required/><big>&nbsp;</big>
		</div>
		<br/>
		<div class=newServiceBoxRow style="height:23px;" >
			<span class="newServiceLabel">
				<button class="tButton24 ToolbarButton" onclick="showNewCust();" style="margin:0 2px 0 0;"><img src="file://///Lmc/Images/plus_16.png"></button>
				<label for=nbCust style="font-size-adjust:1px;" >Customer:</label>
			</span>
			<input id=nbCust class=newServiceTxt type=search style="font-size:19px;" onKeyPress="nbCustKeyPress(event);" onkeyup="searchCustList(event,this.value);" onBlur="nbCustBlur();" onClick="this.select();" value="Type to search" />
			<label class=newServiceLabel >&nbsp;</label>
			<input id=nbCustID type=text class=newServiceTxt style="height:1px; border:none; outline:none !important;" onFocus="nbCustIDFocus(event);" required />
			<div id=custList></div>
		</div>
		
		<br/>
		<div class="newServiceBoxRow">
			<label class="newServiceLabel" id=nbAddrL for="nbAddress" >Address:</label>
			<input id="nbAddress" type="text" class="newServiceTxt" onKeyDown="nbAddressKeyDown(event);"/>
		</div>
		<br/>
		<div class="newServiceBoxRow">
			<label class="newServiceLabel" for="nbCity" style="font-size-adjust:1px;">City:</label>
			<div class="newServiceTxt">
				<input id="nbCity" type="text" class="newServiceBlock3"/>
				<label class="newServiceLabel3" for="nbState" >State:</label>
				<select id="nbState" type="text" class="newServiceTxt3">
					<option value="UT">UT</option>
					<%StateOptionList("Abbr")%>
				</select>
				<label class="newServiceLabel3" for="nbZip" >Zip:</label><input id="nbZip" type="text" class="newServiceTxt3"></input>
			</div>
		</div>
		
		<br/>
		<div class="w100p taC" >
			<label id=nbActL ><input id=nbActivate type="checkbox" /> Activate this job immediately</label>
		</div>
		
		<br/>
		<div align="left" style="height:56px; padding:0 0 0 2%; width:100%; display:none;">
			<label style=" float:left; height:100%; width:49.9%; ">
				<input type="checkbox" id=nbNewServicer onChange="Gebi('nbOldServicer').checked=!this.checked;" />
				Lump Sum Service <br/>
				<small>-For Larger Jobs: Margin is calculated off all expenses. </small>
			</label>
			<label style=" float:left; height:100%; width:49.9%; ">
				<input type="checkbox" id=nbOldServicer checked onChange="Gebi('nbNewServicer').checked=!this.checked;" />
				Itemized Materials Service <br/>
				<small>-For Smaller Jobs: Margin is calculated off materials only.</small>
			</label>
		</div>
		<div class="newServiceBoxRow" style="width:95%;">
			<!-- button style="float:right;" onclick=SaveNewService();>Save</button -->
			<input type="submit" value="Save" />
		</div>
	</form>
</div>

<div id="ScheduleBox" align=left>
	<div id="SchTitle">Schedule Job <div id=SchJobID></div></div>
	<div style="float:left; width:100%; height:4px;"></div>
	<div id=SchJobName contenteditable=true></div>
	<div style="float:left; width:100%; height:8px;"></div>
	
	<div id=SchMain>
		<div id=SchLeft>
			<div style="width:100%;">
				<label class=SchBoxLabel for=SchDateFrom>From:<img class=SchCal onClick="//showCal('SchDateFrom','mm/dd/yyyy',SchDateFrom);" src=../Images/cal.gif width="16" height="16"></label>
			</div>
			<input id=SchDateFrom class="SchBoxTxt" type="text" onFocus="displayCalendar('SchDateFrom','mm/dd/yyyy',SchDateFrom);" onChange=""/>
			<br/>
			
			<div style="width:100%;">
				<label class="SchBoxLabel" for=SchDateTo>To:<img class=SchCal onClick="//displayCalendar('SchDateTo','mm/dd/yyyy',SchDateTo);" src="../Images/cal.gif" width="16" height="16"></label>
			</div>
			<input id=SchDateTo class=SchBoxTxt type=text onFocus="displayCalendar('SchDateTo','mm/dd/yyyy',SchDateTo);" onChange=""/>
			<br/>
			
			<div style="width:100%;">
				<label class="SchBoxLabel" for=SchRecureence>Recurrence:</label>
			</div>
			<select id=SchRecurrence class=SchBoxTxt >
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


<div id=OverAllContainer>

	<div id=Lists class=Lists align=center>
	
		<div id=Top></div>
		<div id=mainToolbar class=Toolbar style="background:none; height:48px; text-align:center; width:98%;">
			
			<div id=path>&nbsp; Service > Service Jobs</div>
			
			<div class=tSpacer5 >&nbsp;</div>
			<button id=newService class="tButton32" onClick="showNewService();" title="New Job" /><img src="../Images/plus_16.png" /></button>
			<div class=tSpacer1 >&nbsp;</div>
			<button id=searchServices class="tButton32" onClick="toggleSearchSort();" title="Search Services" /><img src="../Images/search.png" /></button>
			<div class="tSpacer5">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<button id=ReloadFrame class=tButton32 onClick="window.location=window.location;" title="Reload Tab"/><img src="../Images/reloadblue24.png" /></button>
			
		</div>
		<form id=SearchBar class="Toolbar" action="javascript:Search();">
			<input id=btnSearch style="position:relative; float:right; " type="submit" value="search"/>
			&nbsp;<label>Job Name, #, or City<input id=sName type="text" onkeypress="ifEnter(event,'Search();');" /></label>
			&nbsp;<label>State:<select id=sState onkeypress="ifEnter(event,'Search();');"><option value=""></option><%StateOptionList("Else")%></select></label>&nbsp;
			<br/>
			&nbsp;
			<label>
				Created After:
				<input id=sAfter onkeypress="ifEnter(event,'Search();');" onClick="showCal(this,'mm/dd/yyyy',this.value)" />
				<img src=../Images/cal24x24.gif height=16 style="cursor:pointer;" />
			</label>
			&nbsp;
			<label>
				Created Before:
				<input id=sBefore onkeypress="ifEnter(event,'Search();');" onClick="showCal(this,'mm/dd/yyyy',this.value)" />
				<img src=../Images/cal24x24.gif height=16 style="cursor:pointer" />
			</label>
			<label>
				Status:
				<select id=sStatus onChange="sessionWrite('ShownServices',this.selectedIndex);">
					<option value="All" >All Jobs</option>
					<option value="Recent" selected>Recent Jobs</option>
					<option value="Open">Open Quotes</option>
					<option value="Closed">Closed Quotes</option>
					<option value="Won">Accepted Quotes</option>
					<option value="Lost">Declined Quotes</option>
					<option value="Active" >Active Jobs</option>
					<option value="Done">Completed Jobs</option>
				</select>
			</label>
		</form>
		<div id="SearchSort" class="Toolbar" style=" display:none; height:56px; text-align:center;">
			
			<div id=SSLeft style="float:left; font-family:Consolas, 'Courier New', Courier, monospace; height:100%; width:20%;">	
				<!--
				<button id="TestButton1" style=" float:left; margin:1px 0 0 2.5%; width:95%;" onClick="ChangeToArchive()"><b>Servicing Archive</b></button>
				<button id="TestButton2" style=" float:left; margin:1px 0 0 2.5%; width:95%; display:none;" onClick="ChangeToActive()"><b>Current Servicing</b></button>
				-->
				<div style="height:50%; text-align:center; width:100%;"><label><input id=ckActive type="checkbox" checked> Show Active Jobs &nbsp; </label></div>
				<div style="height:50%; text-align:center; width:100%;"><label><input id=ckArchive type="checkbox" > Show Archived Jobss</label></div>
				
			</div>	
			
			<div id=RefineArea style="border-left:4px groove rgba(0,0,0,.25); float:left; height:100%; width:15%;">
				<div style="color:black; font-size:22px; height:50%; text-align:center; width:100%;">Area:</div>
				<select id=searchArea style="width:90%;">
					<option id=0 selected>All</option>
					<%AreaOptionList("all")%>
				</select>
			</div>
			
			<div id=RefineDate style="border-left:4px groove rgba(0,0,0,.25); float:left; height:100%; width:30%;">
				<div style="color:black; font-size:22px; height:50%; text-align:center; width:100%;">Creation Date:</div>
				<div style=" text-align:center; width:100%;">
					After<input style="width:30%;" value="01/01/1900" />&nbsp;
					Before<input style="width:30%;" value="<%=Date%>" />&nbsp;
				</div>
			</div>
			
			<div id=RefineCustomer style="border-left:4px groove rgba(0,0,0,.25); float:left; height:100%; width:10%;">
				<div style="color:black; font-size:22px; height:50%; text-align:center; width:100%;">Customer:</div>
			</div>
			
			<label style="float:left; margin: 0 0 0 2%; max-width:32%; width:auto;" for="SelSortBy">Sort by:</label>
			<select id="SelSortBy" onChange="SortBy(this[this.selectedIndex].value);" style="float:left; max-width:66%; width:auto;">
				<option id="SortJobID" value="JobID">Job# (Lowest)</option>
				<option id="SortJobID1" value="JobID DESC">Job# (Highest)</option>
				<option id="SortPriority" value="ServicePriority DESC" selected >Priority (Highest)</option>
				<option id="SortPriority1" value="ServicePriority" >Priority (Lowest)</option>
				<option id="SortJobName" value="JobName">Job Name</option>
				<option id="SortServicing" value="ServiceGetInfo DESC">Got Info</option>
				<option id="SortPermits" value="ServiceGetPlansSpecs DESC">Got Plans/Specs</option>
				<option id="SortUnderGround" value="ServiceGetCustomers DESC">Got Customers</option>
				<option id="SortRoughIn" value="ServiceGeneratePrice DESC">Price Generated</option>
				<option id="SortRoughInspect" value="ServiceSubmit DESC">Submitted</option>
				<option id="SortOrderMaterials" value="ServiceFollowUp DESC">Follow Up</option>
				<option id="SortTrim" value="Obtained DESC">Won</option>
				<option id="SortTrim" value="ServiceLost DESC">Lost</option>
				<option id="SortDateStarted" value="ServicingStartDate ">Started (Earliest)</option>
				<option id="SortDateStarted1" value="ServicingStartDate DESC">Started (Latest)</option>
				<option id="SortDateDue" value="ServicingDueDate">Due (Earliest)</option>
				<option id="SortDateDue1" value="ServicingDueDate DESC">Due (Latest)</option>
				<option id="SortDateCompleted" value="ServicingCompletedDate">Completed (Earliest)</option>
				<option id="SortDateCompleted1" value="ServicingCompletedDate DESC">Completed (Latest)</option>
			</select>
			
		</div>


		<div id="ListBody" class="ListBody" align="center">
	
			<div id="TLItemsContainer" class="TLItemsContainer">
				<iframe id="ServiceListFrame" frameborder="0" scrolling="auto"></iframe>
			</div> 
			
			<div id="TLItemsNotes" class="TLItemsNotes">
				<div id="ItemNotesHead" class="ItemNotesHead">Notes</div>
				<div id="ItemNotesContainer">
					<textarea id="ItemNotesText" onKeyUp="SaveNotes(this.value);"></textarea>
				</div>       	
			</div>
			<script type="text/javascript">
				var ServiceList=Gebi('ServiceListFrame').contentWindow;
				var Active='True';
				var SortedBy='ServicePriority%20DESC';
			</script>
		</div>                
		
		<div id="TLItemsBottom"></div> 

		<!--
		<div id="ToDoToolbar" class="Toolbar" style="text-align:center; margin-left:auto; margin-right:auto; width:100%;">
			
			<div style="float:left; width:33%; min-width:33%; height:100%;">
				<span id="ServiceListControl" style="float:left; width:100%;">
					<span class="ControlLabel"> New list for:</span>
					<select id="ToDoEmpList" class="ControlInput"><%EmployeeOptionList("active")%></select>
					<button onClick="NewEmpList();">Add</button>
				</span>
			
				<div id="ItemListControl" style="float:left; display:none; width:100%; white-space:nowrap;" align="left">
					<div id="lblItemListAdd" class="ControlLabel" style="font-size:14px; padding-top:2px;">&nbsp;New Task For Employee</div>
					<input id="txtItemListAdd" style="width:35%; max-width:35%; text-overflow:ellipsis; float:left;"/>
					<button onClick="NewItemList();" style="width:12%; max-width:35%; float:left;">Add</button>
				</div>
				
				<div id="ListItemControl" style="float:left; display:none; width:100%; white-space:nowrap;">
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
				- ->
				<div id="SubItemControl" style="float:left; display:none; width:100%; white-space:nowrap;">
					&nbsp;<span id="lblSubItemAdd" class="ControlLabel">New SubItem For Item</span>
					<input id="txtSubItemAdd" class="ControlInput"/>
					<button onClick="NewSubItem();" style="width:12%; max-width:35%;">Add</button>
				</div>
				
			</div>
				
			<div id="Rename Control" style="float:left; width:33%;">
				<span id="lblRename">Rename </span> <input id="txtRename" onKeyUp="RenameItem(this.value);"/>
			</div>
			
			<div style="float:right; width:33%; border-left:4px groove rgba(0,0,0,.25); height:100%;">
				<button id="btnRemove" onClick="DelTreeItem();">Remove <span id="RemItemName"></span></button>
			</div>
		</div>
		-->
		
		
<!-- 		
		<div id="EmployeeList" class="EmployeeList"></div>
		<!-- Popup Menu for assigning Employee List to tasks - ->
		<div id="PhaseProgressMenu" class="PhaseProgressMenu"></div>
 -->
	</div>
</div>

</body>
</html>
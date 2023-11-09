<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>Estimating / Sales</title>
	<!--#include file="../LMCDevelopment/common.asp" -->
	<script type="text/javascript" src="../LMCDevelopment/Bid/BidJS.js"></script>
	<script type="text/javascript" src="../LMCDevelopment/Bid/BidAJAX.js"></script>
	<script type="text/javascript" src="../LMCDevelopment/Library/SqlAjax.js"></script>
	
	<link rel="stylesheet" href="../LMCDevelopment/Library/ListsCommon.css" media="all">
	<link rel="stylesheet" href="../LMCDevelopment/Bid/BidCSS.css" media="all">
	<link type="text/css" rel="stylesheet" href="../LMCDevelopment/Library/dhtmlgoodies_calendar.css?random=20051112" media="screen" />
</head>
<body onResize="Resize();" onLoad="Resize(); Gebi('BidListFrame').src='BidList.asp';" >

<div id=Modal></div>

<div id=NewBidBox class="WindowBox" align="center" >
	<div class="WindowTitle" style="background:#40631D; color:#fff; text-align:center;">New Project<div class="redXCircle" onClick="hideNewBid();" >X</div></div>
	<br/>
	<br/>
	<div class="newBidBoxRow" style="height:26px;">
		<label class="newBidLabel" for="nbProjName"><big>Project Name:</big></label>
		<input id="nbProjName" type="text" class="newBidTxt" style="font-size:22px;"/><big>&nbsp;</big>
	</div>
	<br/>
	<div class="newBidBoxRow" style="height:23px;">
		<label class="newBidLabel" for="nbCity" style="font-size-adjust:1px;">City:</label>
		<input id="nbCity" type="text" class="newBidTxt" style="font-size:19px;" onKeyUp="copyCity(this.value);"/>
	</div>
	
	<br/>
	<br/>
	
	<div class="newBidBoxRow">
		<label class="newBidLabel" for="nbAddress" >Address:</label>
		<input id="nbAddress" type="text" class="newBidTxt"/>
	</div>
	<br/>
	<div class="newBidBoxRow">
		<div class="newBidLabel" >City:</div>
		<div class="newBidTxt">
			<div id="nbCity2" class="newBidBlock3">&nbsp;</div>
			<label class="newBidLabel3" for="nbState" >State:</label>
			<select id="nbState" type="text" class="newBidTxt3">
				<option value="AZ">AZ</option>
				<%StateOptionList("Abbr")%>
			</select>
			<label class="newBidLabel3" for="nbZip" >Zip:</label><input id="nbZip" type="text" class="newBidTxt3"></input>
		</div>
	</div>
	
	<br/>
	<br/>
	
	<div class="newBidBoxRow" style="display:none;">
		<label class=newBidLabel2 for=nbSqFeet><small>Square Footage:</small></label>
		<input id=nbSqFeet class=newBidTxt2 />
		<label class=newBidLabel2 for=nbFloors><small># of Floors:</small></label>
		<input id=nbFloors class=newBidTxt2 />
	</div>
	<br/>
	<div align="left" style="height:56px; padding:0 0 0 2%; width:100%; display:none;">
		<label style=" float:left; height:100%; width:49.9%; color:darkgrey;">
			<input type="checkbox" id=nbNewBidder disabled onChange="Gebi('nbOldBidder').checked=!this.checked;" />
			Lump Sum Bid <br/>
			<small style="color:inherit;">-Materials cannot be itemized on proposal: Margin will be calculated off all expenses. </small>
		</label>
		<label style=" float:left; height:100%; width:49.9%; color:darkgrey; ">
			<input type="checkbox" id=nbOldBidder checked disabled onChange="Gebi('nbNewBidder').checked=!this.checked;" />
			Itemized Materials Bid <br/>
			<small style="color:inherit;">-Allows displaying material line items: Margin will be calculated off materials only.</small>
		</label>
	</div>
	<div class="newBidBoxRow" style="width:95%;"><button style="float:right;" onclick=SaveNewBid();>Save</button></div>
</div>

<div id="ScheduleBox" align=left>
	<div id="SchTitle">Schedule Project <div id=SchProjID></div></div>
	<div style="float:left; width:100%; height:4px;"></div>
	<div id=SchProjName contenteditable=true></div>
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
			
			<div id=path>&nbsp; Jobs > <big><b>Estimating/Sales</b></big></div>
			
			<div class=tSpacer5 >&nbsp;</div>
			<button id=newBid class="tButton32" onClick="showNewBid();" title="New Project" /><img src="../Images/plus_16.png" /></button>
			<div class=tSpacer1 >&nbsp;</div>
			<button id=searchBids class="tButton32" onClick="toggleSearchSort();" title="Search Bids" /><img src="../Images/search.png" /></button>
			<div class="tSpacer5">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<button id=ReloadFrame class=tButton32 onClick="window.location=window.location;" title="Reload Tab"/><img src="../Images/reloadblue24.png" /></button>
			
		</div>
		<form id=SearchBar class="Toolbar" action="javascript:Search();">
			<input id=btnSearch style="position:relative; float:right; " type="submit" value="search"/>
			&nbsp;<label>Project Name, #, or City<input id=sName type="text" onkeypress="ifEnter(event,'Search();');" /></label>
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
				<select id=sStatus onChange="sessionWrite('ShownBids',this.selectedIndex);">
					<option value="All" >All Bids</option>
					<option value="Recent" selected>Recent Bids</option>
					<option value="Open" >Open Bids</option>
					<option value="Closed">Closed Bids</option>
					<option value="Won">Won Bids</option>
					<option value="Lost">Lost Bids</option>
				</select>
			</label>
		</form>
		<div id="SearchSort" class="Toolbar" style=" display:none; height:56px; text-align:center;">
			
			<div id=SSLeft style="float:left; font-family:Consolas, 'Courier New', Courier, monospace; height:100%; width:20%;">	
				<!--
				<button id="TestButton1" style=" float:left; margin:1px 0 0 2.5%; width:95%;" onClick="ChangeToArchive()"><b>Bidding Archive</b></button>
				<button id="TestButton2" style=" float:left; margin:1px 0 0 2.5%; width:95%; display:none;" onClick="ChangeToActive()"><b>Current Bidding</b></button>
				-->
				<div style="height:50%; text-align:center; width:100%;"><label><input id=ckActive type="checkbox" checked> Show Active Projects &nbsp; </label></div>
				<div style="height:50%; text-align:center; width:100%;"><label><input id=ckArchive type="checkbox" > Show Archived Projectss</label></div>
				
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
				<option id="SortProjID" value="ProjID">Job# (Lowest)</option>
				<option id="SortProjID1" value="ProjID DESC">Job# (Highest)</option>
				<option id="SortPriority" value="BidPriority DESC" selected >Priority (Highest)</option>
				<option id="SortPriority1" value="BidPriority" >Priority (Lowest)</option>
				<option id="SortJobName" value="ProjName">Job Name</option>
				<option id="SorBiddingt" value="BidGetInfo DESC">Got Info</option>
				<option id="SortPermits" value="BidGetPlansSpecs DESC">Got Plans/Specs</option>
				<option id="SortUnderGround" value="BidGetCustomers DESC">Got Customers</option>
				<option id="SortRoughIn" value="BidGeneratePrice DESC">Price Generated</option>
				<option id="SortRoughInspect" value="BidSubmit DESC">Submitted</option>
				<option id="SortOrderMaterials" value="BidFollowUp DESC">Follow Up</option>
				<option id="SortTrim" value="Obtained DESC">Won</option>
				<option id="SortTrim" value="BidLost DESC">Lost</option>
				<option id="SortDateStarted" value="BiddingStartDate ">Started (Earliest)</option>
				<option id="SortDateStarted1" value="BiddingStartDate DESC">Started (Latest)</option>
				<option id="SortDateDue" value="BiddingDueDate">Due (Earliest)</option>
				<option id="SortDateDue1" value="BiddingDueDate DESC">Due (Latest)</option>
				<option id="SortDateCompleted" value="BiddingCompletedDate">Completed (Earliest)</option>
				<option id="SortDateCompleted1" value="BiddingCompletedDate DESC">Completed (Latest)</option>
			</select>
			
		</div>


		<div id="ListBody" class="ListBody" align="center">
	
			<div id="TLItemsContainer" class="TLItemsContainer">
				<iframe id="BidListFrame" frameborder="0" scrolling="auto"></iframe>
			</div> 
			
			<div id="TLItemsNotes" class="TLItemsNotes">
				<div id="ItemNotesHead" class="ItemNotesHead">Notes</div>
				<div id="ItemNotesContainer">
					<textarea id="ItemNotesText" onKeyUp="SaveNotes(this.value);"></textarea>
				</div>       	
			</div>
			<script type="text/javascript">
				var BidList=Gebi('BidListFrame').contentWindow;
				var Active='True';
				var SortedBy='BidPriority%20DESC';
			</script>
		</div>                
		
		<div id="TLItemsBottom"></div> 

		<!--
		<div id="ToDoToolbar" class="Toolbar" style="text-align:center; margin-left:auto; margin-right:auto; width:100%;">
			
			<div style="float:left; width:33%; min-width:33%; height:100%;">
				<span id="BidListControl" style="float:left; width:100%;">
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
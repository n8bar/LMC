<!--#include file="../TMC/RED.asp" -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Estimating / Sales</title>
<!--#include file="common.asp" -->

<script type="text/javascript" src="Service/Monitoring.js?noCache=<%=noCache%>"></script>
<script type="text/javascript" src="Service/MonitoringAJAX.js?noCache=<%=noCache%>"></script>
<script type="text/javascript" src="Library/SqlAjax.js?noCache=<%=noCache%>"></script>

<link rel=stylesheet href="Library/ListsCommon.css?noCache=<%=noCache%>" media="all">
<link rel=stylesheet href="Service/Monitoring.css?noCache=<%=noCache%>" media="all">


</head>
<body onResize="Resize();" onLoad="Resize(); Gebi('MonitoringListFrame').src='MonitoringList.asp';" >

<div id=Modal></div>

<div id=NewAccountBox class="WindowBox" align="center" >
	<div class=WindowTitle style="background:#00F; color:#fff; text-align:center;">New Account<div class="redXCircle" onClick="hideNewAccount();" >X</div></div>
	<br/>
	<br/>
	<div class=newAccountBoxRow style="height:26px;">
		<label class=newAccountLabel for=nbAcctName ><big>Account Name:</big></label>
		<input id=nbAcctName type=text class="newAccountTxt fS22" maxlength="128" /><big>&nbsp;</big>
	</div>
	<br/>
	<div class=newAccountBoxRow style="height:23px;">
		<label class="newAccountLabel" for="nbCity" style="font-size-adjust:1px;">City:</label>
		<input id="nbCity" type="text" class="newAccountTxt fS19" maxlength="64" onKeyUp="copyCity(this.value);"/>
	</div>
	
	<br/>
	<br/>
	
	<div class="newAccountBoxRow">
		<label class="newAccountLabel" for="nbAddress" >Address:</label>
		<input id="nbAddress" type="text" class="newAccountTxt" maxlength="256"/>
	</div>
	<br/>
	<div class="newAccountBoxRow">
		<div class="newAccountLabel" >City:</div>
		<div class="newAccountTxt">
			<div id="nbCity2" class="newAccountBlock3">&nbsp;</div>
			<label class="newAccountLabel3" for="nbState" >State:</label>
			<select id="nbState" type="text" class="newAccountTxt3">
				<option value="UT">UT</option>
				<%StateOptionList("Abbr")%>
			</select>
			<label class="newAccountLabel3" for="nbZip" >Zip:</label><input id="nbZip" type="text" class="newAccountTxt3" maxlength="10"></input>
		</div>
	</div>
	
	<br/>
	<br/>
	
	<div class="newAccountBoxRow">
		<label class=newAccountLabel2 for=naNumber><small>Account#:</small></label>
		<input id=naNumber class=newAccountTxt2 maxlength="24" />
		<label class=newAccountLabel2 for=naProvider><small>Provider:</small></label>
		<select id=naProvider type="text" class="newAccountTxt2">
			<option value="854">CMS Monitoring</option>
			<%HandyContactLister "vendors","option" %>
		</select>
	</div>
	<br/>
	<!-- div align="left" style="height:56px; padding:0 0 0 2%; width:100%;">
		<label style=" float:left; height:100%; width:49.9%; ">
			<input type="checkbox" id=nbNewAccountder checked onChange="Gebi('nbOldAccountder').checked=!this.checked;" />
			Lump Sum Account <br/>
			<small>-For Larger Accounts: Margin is calculated off all expenses. </small>
		</label>
		<label style=" float:left; height:100%; width:49.9%; ">
			<input type="checkbox" id=nbOldAccountder onChange="Gebi('nbNewAccountder').checked=!this.checked;" />
			Itemized Materials Account <br/>
			<small>-For Smaller Jobs: Margin is calculated off materials only.</small>
		</label>
	</div -->
	<div class="newAccountBoxRow" style="width:95%;"><button style="float:right;" onclick=SaveNewAccount();>Save</button></div>
</div>

<div id="ScheduleBox" align=left>
	<div id="SchTitle">Schedule Account <div id=SchAcctID></div></div>
	<div style="float:left; width:100%; height:4px;"></div>
	<div id=SchAcctName contenteditable=true></div>
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
			
			<div id=path>&nbsp; Service > <big><b>Monitoring</b></big> </div>
			
			<div class=tSpacer5 >&nbsp;</div>
			<button id=newAccount class="tButton32" onClick="showNewAccount();" title="New Account" /><img src="../Images/plus_16.png" /></button>
			<div class=tSpacer1 >&nbsp;</div>
			<button id=searchAccounts class="tButton32" onClick="toggleSearchSort();" title="Search Accounts" /><img src="../Images/search.png" /></button>
			<div class="tSpacer5">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<button id=ReloadFrame class=tButton32 onClick="noCacheReload();" title="Reload Tab"/><img src="../Images/reloadblue24.png" /></button>
			
		</div>
		<form id=SearchBar class="Toolbar taC h32 pT4" action="//javascript:Search();">
			<big><label><big>Search:</big><input id=sName class="h24 lH24 fS21" type="text" onkeypress="ifEnter(event,'Search();');" /></label></big>
			<big class="tButton0x24 fN" style="position:relative; top:-3px;" id=btnSearch onClick="Search();"><i>&nbsp;Go&nbsp;</i></big>
			<span class=dN>
				&nbsp;<label>Account Name, #, or City<input id=OLDsName type="text" onkeypress="ifEnter(event,'Search();');" /></label>
				&nbsp;<label>State:<select id=sState onkeypress="ifEnter(event,'Search();');"><option value=""></option>< %StateOptionList("Else")%></select></label>&nbsp;
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
					<select id=sStatus onChange="sessionWrite('ShownAccounts',this.selectedIndex);">
						<option value="All" selected >All Accounts</option>
						<option value="Recent">Recent Accounts</option>
						<option value="Open" >Open Accounts</option>
						<option value="Closed">Closed Accounts</option>
						<option value="Won">Won Accounts</option>
						<option value="Lost">Lost Accounts</option>
					</select>
				</label>
			</span>
		</form>
		<div id="SearchSort" class="Toolbar" style=" display:none; height:56px; text-align:center;">
			
			<div id=SSLeft style="float:left; font-family:Consolas, 'Courier New', Courier, monospace; height:100%; width:20%;">	

				<div style="height:50%; text-align:center; width:100%;"><label><input id=ckActive type="checkbox" checked> Show Active Accounts &nbsp; </label></div>
				<div style="height:50%; text-align:center; width:100%;"><label><input id=ckArchive type="checkbox" > Show Archived Accountss</label></div>
				
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
				<option id="SortAcctID" value="AcctID">Job# (Lowest)</option>
				<option id="SortAcctID1" value="AcctID DESC">Job# (Highest)</option>
				<option id="SortPriority" value="AccountPriority DESC" selected >Priority (Highest)</option>
				<option id="SortPriority1" value="AccountPriority" >Priority (Lowest)</option>
				<option id="SortJobName" value="AcctName">Job Name</option>
				<option id="SorAccountdingt" value="AccountGetInfo DESC">Got Info</option>
				<option id="SortPermits" value="AccountGetPlansSpecs DESC">Got Plans/Specs</option>
				<option id="SortUnderGround" value="AccountGetCustomers DESC">Got Customers</option>
				<option id="SortRoughIn" value="AccountGeneratePrice DESC">Price Generated</option>
				<option id="SortRoughInspect" value="AccountSubmit DESC">Submitted</option>
				<option id="SortOrderMaterials" value="AccountFollowUp DESC">Follow Up</option>
				<option id="SortTrim" value="Obtained DESC">Won</option>
				<option id="SortTrim" value="AccountLost DESC">Lost</option>
				<option id="SortDateStarted" value="AccountdingStartDate ">Started (Earliest)</option>
				<option id="SortDateStarted1" value="AccountdingStartDate DESC">Started (Latest)</option>
				<option id="SortDateDue" value="AccountdingDueDate">Due (Earliest)</option>
				<option id="SortDateDue1" value="AccountdingDueDate DESC">Due (Latest)</option>
				<option id="SortDateCompleted" value="AccountdingCompletedDate">Completed (Earliest)</option>
				<option id="SortDateCompleted1" value="AccountdingCompletedDate DESC">Completed (Latest)</option>
			</select>
			
		</div>


		<div id="ListBody" class="ListBody" align="center">
	
			<div id="TLItemsContainer" class="TLItemsContainer">
				<iframe id="MonitoringListFrame" frameborder="0" scrolling="auto"></iframe>
			</div> 
			
			<div id="TLItemsNotes" class="TLItemsNotes">
				<div id="ItemNotesHead" class="ItemNotesHead">Notes</div>
				<div id="ItemNotesContainer">
					<textarea id="ItemNotesText" onKeyUp="SaveNotes(this.value);"></textarea>
				</div>       	
			</div>
			<script type="text/javascript">
				var MonitoringList=Gebi('MonitoringListFrame').contentWindow;
				var Active='True';
				var SortedBy='AccountPriority%20DESC';
			</script>
		</div>                
		
		<div id="TLItemsBottom"></div> 

		
		
		
<!-- 		
		<div id="EmployeeList" class="EmployeeList"></div>
		<!-- Popup Menu for assigning Employee List to tasks - ->
		<div id="PhaseProgressMenu" class="PhaseProgressMenu"></div>
 -->
	</div>
</div>

</body>
</html>
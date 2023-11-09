<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>Contacts</title>
	<!--#include file="common.asp" -->
	<script type="text/javascript" src="Contacts/Contacts.js"></script>
	<script type="text/javascript" src="Contacts/ContactsAJAX.js"></script>
	<script type="text/javascript" src="Library/SqlAjax.js"></script>
	
	<link rel="stylesheet" href="Library/ListsCommon.css" media="all">
	<link rel="stylesheet" href="Contacts/Contacts.css" media="all">
	<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="screen" />
</head>
<body onResize="Resize();" onLoad="Resize(); Gebi('ContactListFrame').src='ContactList.asp';" >

<div id=Modal></div>

<div id=NewContactBox class="WindowBox" align="center" >
	<div class="WindowTitle" style="background:#40631D; color:#fff; text-align:center;">New Contact<div class="redXCircle" onClick="hideNewContact();" >X</div></div>
	<br/>
	<br/>
	<div class="newContactBoxRow" style="height:26px;">
		<label class="newContactLabel" for="nbContactName"><big>Contact Name:</big></label>
		<input id="nbContactName" type="text" class="newContactTxt" style="font-size:22px;"/><big>&nbsp;</big>
	</div>
	<br/>
	<div class="newContactBoxRow" style="height:23px;">
		<label class="newContactLabel" for="nbCity" style="font-size-adjust:1px;">City:</label>
		<input id="nbCity" type="text" class="newContactTxt" style="font-size:19px;" onKeyPress="copyCity(this.value);"/>
	</div>
	
	<br/>
	<br/>
	
	<div class="newContactBoxRow">
		<label class="newContactLabel" for="nbAddress" >Address:</label>
		<input id="nbAddress" type="text" class="newContactTxt"/>
	</div>
	<br/>
	<div class="newContactBoxRow">
		<div class="newContactLabel" >City:</div>
		<div class="newContactTxt">
			<div id="nbCity2" class="newContactBlock3">&nbsp;</div>
			<label class="newContactLabel3" for="nbState" >State:</label>
			<select id="nbState" type="text" class="newContactTxt3">
				<option value="UT">UT</option>
				<%StateOptionList("Abbr")%>
			</select>
			<label class="newContactLabel3" for="nbZip" >Zip:</label><input id="nbZip" type="text" class="newContactTxt3"></input>
		</div>
	</div>
	
	<br/>
	<br/>
	
	<div class="newContactBoxRow">
		<label class=newContactLabel2 for=nbSqFeet><small>Square Footage:</small></label>
		<input id=nbSqFeet class=newContactTxt2 />
		<label class=newContactLabel2 for=nbFloors><small># of Floors:</small></label>
		<input id=nbFloors class=newContactTxt2 />
	</div>
	<br/>
	<div align="left" style="height:56px; padding:0 0 0 2%; width:100%;">
		<label style=" float:left; height:100%; width:49.9%; ">
			<input type="checkbox" id=nbNewContactder checked onChange="Gebi('nbOldContactder').checked=!this.checked;" />
			Lump Sum Contact <br/>
			<small>-For Larger Contacts: Margin is calculated off all expenses. </small>
		</label>
		<label style=" float:left; height:100%; width:49.9%; ">
			<input type="checkbox" id=nbOldContactder onChange="Gebi('nbNewContactder').checked=!this.checked;" />
			Itemized Materials Contact <br/>
			<small>-For Smaller Jobs: Margin is calculated off materials only.</small>
		</label>
	</div>
	<div class="newContactBoxRow" style="width:95%;"><button style="float:right;" onclick=SaveNewContact();>Save</button></div>
</div>

<div id="ScheduleBox" align=left>
	<div id="SchTitle">Schedule Contact <div id=SchContactID></div></div>
	<div style="float:left; width:100%; height:4px;"></div>
	<div id=SchContactName contenteditable=true></div>
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
	<form action="javascript:ScheduleEvent();" style="float:right;" >
		&nbsp;<input id=SchSchedule type="submit" value=" Schedule " />&nbsp;</form>
	
	&nbsp;<button onClick="Gebi('ScheduleBox').style.display='none'; Gebi('Modal').style.display='none'; ">&nbsp;Cancel&nbsp;</button>
</div>


<div id=OverAllContainer>

	<div id=Lists class=Lists align=center>
	
		<div id=Top></div>
		<div id=mainToolbar class=Toolbar style="background:none; height:48px; text-align:center; width:98%;">
			
			<div id=path>&nbsp; Contacts</div>
			
			<div class=tSpacer5 >&nbsp;</div>
			<button id=newContact class="tButton32" onClick="showNewContact();" title="New Contact" /><img src="../Images/plus_16.png" /></button>
			<div class=tSpacer1 >&nbsp;</div>
			<button id=searchContacts class="tButton32" onClick="toggleSearchSort();" title="Search Contacts" /><img src="../Images/search.png" /></button>
			<div class="tSpacer5">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<button id=ReloadFrame class=tButton32 onClick="noCacheReload();" title="Reload Tab"/><img src="../Images/reloadblue24.png" /></button>
			
		</div>
		<form id=SearchBar class=Toolbar action="javascript:Search();">
			<input id=btnSearch style="position:relative; float:right; " type="submit" value="search"/>
			&nbsp;<label>Contact Name, Address, or Phone#<input id=sName type="text" onkeypress="ifEnter(event,'Search();');" /></label>
			&nbsp;<label>City or Zip:<input id=sCity type="text" onkeypress="ifEnter(event,'Search();');" /></label>
			&nbsp;<label>State:<select id=sState onkeypress="ifEnter(event,'Search();');"><option value=""></option><%StateOptionList("Else")%></select></label>
			&nbsp;<label>Notes<input id=sNotes type=text onkeypress="ifEnter(event,'Search();');" /></label>
			<!--&nbsp;
			<!-- label>
				Created After:
				<input id=sAfter onkeypress="ifEnter(event,'Search();');" onClick="showCal(this,'mm/dd/yyyy',this.value)" />
				<img src=../Images/cal24x24.gif height=16 style="cursor:pointer;" />
			</label>
			&nbsp;
			<label>
				Created Before:
				<input id=sBefore onkeypress="ifEnter(event,'Search();');" onClick="showCal(this,'mm/dd/yyyy',this.value)" />
				<img src=../Images/cal24x24.gif height=16 style="cursor:pointer" />
			</label -->
			&nbsp;
			<label>
				Status:
				<select id=sStatus onChange="sessionWrite('ShownContacts',this.selectedIndex);">
					<option value=All selected>All Contacts</option>
					<option value=Recent >Recent Contacts</option>
					<option value=Open >Open Contacts</option>
					<option value=Closed >Closed Contacts</option>
					<option value=Won >Won Contacts</option>
					<option value=Lost >Lost Contacts</option>
				</select>
			</label>
		</form>
		
		<div id="ListBody" class="ListBody" align="center">
			<div id="TLItemsContainer" class="TLItemsContainer">
				<iframe id="ContactListFrame" frameborder="0" scrolling="auto"></iframe>
			</div> 
			
			<div id="TLItemsNotes" class="TLItemsNotes">
				<div id="ItemNotesHead" class="ItemNotesHead">Notes</div>
				<div id="ItemNotesContainer">
					<textarea id="ItemNotesText" onKeyUp="SaveNotes(this.value);"></textarea>
				</div>       	
			</div>
			<script type="text/javascript">
				var ContactList=Gebi('ContactListFrame').contentWindow;
				var Active='True';
				var SortedBy='ContactPriority%20DESC';
			</script>
		</div>                
		
		<div id="TLItemsBottom"></div> 

	</div>
</div>

</body>
</html>
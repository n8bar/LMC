<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>Contacts</title>
	<!--#include file="Common.asp" -->
	<script type="text/javascript" src="Contacts/Contacts.js?noCache=<%=noCache%>"></script>
	<script type="text/javascript" src="Contacts/ContactsAJAX.js?noCache=<%=noCache%>"></script>
	<script type="text/javascript" src="Library/SqlAjax.js?noCache=<%=noCache%>"></script>
	
	<link rel="stylesheet" href="Library/ListsCommon.css?noCache=<%=noCache%>" media="all">
	<link rel="stylesheet" href="Contacts/Contacts.css?noCache=<%=noCache%>" media="all">
	<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?noCache=<%=noCache%>" media="screen" />
</head>
<body onResize="Resize();" onLoad="Resize(); Gebi('ContactListFrame').src='ContactList.asp'; sOmniSearch.focus();" >

<div id=Modal></div>

<div id=NewContactBox class="WindowBox" align="center" style="height:auto; width:auto;" >
	<div class="WindowTitle" style="background:#44b; color:#fff; text-align:center;">New Contact<div class="redXCircle" onClick="hideNewContact();" >X</div></div>
	<div id=PaddedContainer class="p16 hA wA">
		<div class="w100p h32 p0" >
			<label class="" for="nbContactName"><big>Contact Name:</big></label>
			<input id="nbContactName" type="text" class="fS22" onKeyUp="ifEnter(event,'SaveNewContact();');" />
			<button class="fS22 fN tButton0x32" onclick=SaveNewContact();>Go</button><big>&nbsp;</big>
		</div>
		<br/><br/>
		<div class="w100p taC" ><button onClick="hideNewContact();">&nbsp;Cancel&nbsp;</button></div>
	</div>
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
			
			<div id=path> My LMC > <b><big onDblClick="location='oldContacts.asp';">Contacts</big></b></div>
			
			<div class=tSpacer5 >&nbsp;</div>
			<button id=newContact class="tButton0x32" onClick="showNewContact();" title="New Contact" /><img src="../Images/plus_16.png" style="height:24px; width:24px; margin:auto; position:relative; top:4px; left:4px;" /> New Contact &nbsp;</button>
			<div class=tSpacer1 >&nbsp;</div>
			<button id=searchContacts class="tButton32" style="display:none;" onClick="toggleSearchSort();" title="Search Contacts" /><img src="../Images/search.png" /></button>
			<div class="tSpacer5">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<div class="tSpacer10">&nbsp;</div>
			<button id=ReloadFrame class=tButton32 onClick="noCacheReload();" title="Reload Tab"/><img src="../Images/reloadblue24.png" /></button>
			
		</div>
		<form id=SearchBar class=Toolbar action="javascript:Search();" style="display:block;">
			<div id=sbAdvanced  style="display:none; text-align:left; padding: 3px 2.5% 0 2.5%; width:100%; height:100%;" >
				<button class="m0 fR tButton0x24" onClick="searchSimple();" style="height:18px;" ><b> &nbsp; less options&hellip; &nbsp; </b></button>
				<div class="tSpacer5 fR">&nbsp;</div>
				<button id=btnSearch class="fR tButton32" onClick="SearchBar.submit();"><big>&nbsp;Go&nbsp;</big></button>
				<!-- input id=btnSearch style="position:relative; float:right; " type="submit" value=" &nbsp; Go &nbsp; "/ -->
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
			</div>
			<div id=sbSimple class="taC p0 pR2p5p pL2p5p w100p h100p" style="display:block;">
				<label class="w95p fS24 mB0 hA" style="margin:0;">
					<input id=sOmniSearch class="w90p fR p0" style="font-size:18px;" onKeyUp="omniSearch();" onKeyDown="Gebi('ContactListFrame').contentDocument.getElementById('Loading').style.display='block';" />
					<span class="w10p taR fR m0" style="font-family:'DejaVu Sans';">Search:</span>
				</label>
				<br/>
				<button class="m0 fR tButton0x24" onClick="searchAdvanced();" style="height:18px;" ><b> &nbsp; more options&hellip; &nbsp; </b></button>
			</div>
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
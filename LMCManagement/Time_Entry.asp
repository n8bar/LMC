<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Time_Entry</title>

<!--#include file="../LMC/RED.asp" -->
<!--#include file="Common.asp" -->
<script type="text/javascript" src="Modules/rcstri.js"></script>
<script type="text/javascript" src="Time/Time-EntryJS.js"></script>
<script type="text/javascript" src="Time/Time-EntryAJAX.js"></script>
<SCRIPT type="text/javascript" src="Library/dhtmlgoodies_calendar.js?random=20060118"></script>

<link rel="stylesheet" href="Library/CSS_DEFAULTS.css" media="screen">
<link rel="stylesheet" href="Time/Time_EntryCSS.css" media="screen">
<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">
<script>
	//alert('<%=Session("accessTime")%>');
	var accessTime=('<%=lcase(Session("accessTime"))%>'=='true');
</script>

</head>
<body onResize="Resizer(); parent.ResetLogoutTimer();" onLoad="LoadTimeEntryList();" onmousemove="MouseMove(event);" onkeyup="parent.ResetLogoutTimer();">


<div id="Modal" class="Modal"></div>
<div class="TimeEntry WindowBox" id="TimeEntry">
	
	<div class="TimeEntryTitleBar" id="TimeEntryTitleBar" onMouseDown="BoxX=mX; BoxY=mY; InnerMX=mX-Gebi('TimeEntry').offsetLeft; InnerMY=mY-Gebi('TimeEntry').offsetTop-20; ">
    	<div style="float:left;"> &nbsp; Time Entry</div>
        <img src="../Images/closeSmall.gif" onClick="CancelTimeEntry()" style="float:right; margin:3px 3px 0 0; cursor:default;" />
	</div>
	
	<!--div class="ServiceTimeEntry" id="ServiceTimeEntryBox">Service</div>
	<div class="OtherTimeEntry" id="OtherTimeEntryBox">Other</div--> 
	<select style="display:none;" id=ProjectList >
		<option value=0>Choose a project:</option>
		<%
		SQL1="SELECT ProjID, ProjName, ProjCity, ProjState FROM Projects WHERE Active=1 AND Obtained=1 ORDER BY ProjName, ProjCity, ProjState"
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		
		Do Until rs1.EOF
			City=rs1("ProjCity")
			ProjSplit=Split(DecodeChars(rs1("ProjName"))," - ")
			If (City="" Or IsNull(City)) And uBound(ProjSplit)>=1 Then City=ProjSplit(1)
			ProjectTitle=CStr(ProjSplit(0))&" - "&City&" "&rs1("ProjState")
			%><option value="<%=rs1("ProjID")%>"><%=ProjectTitle%></option><%
			rs1.MoveNext
		Loop
		Set rs1=Nothing
		%>
	</select>
	<select style="display:none;" id=ServiceList>
		<option>Service Job:</option>
		<%
		SQL1="SELECT NoteID, Job FROM JobsLists WHERE Active=1 AND Type=3 ORDER BY Job"
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		
		Do Until rs1.EOF
			%><option value="<%=rs1("NoteID")%>"><%=DecodeChars(rs1("Job"))%></option><%
			rs1.MoveNext
		Loop
		Set rs1=Nothing
		%>
	</select>
	<select style="display:none;" id=TestMaintList>
		<option>Testing / Maintenance Job:</option>
		<%
		SQL1="SELECT NoteID, Job FROM JobsLists WHERE Active=1 AND Type=4 ORDER BY Job"
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		
		Do Until rs1.EOF
			%><option value="<%=rs1("NoteID")%>"><%=DecodeChars(rs1("Job"))%></option><%
			rs1.MoveNext
		Loop
		Set rs1=Nothing
		%>
	</select>
	
	<div class="JobTimeEntry" id="JobTimeEntryBox">
		
		<div id="TimeEntryTopLeft" class="TimeEntryTopLeft" >
			<div class="ProjName">
				<div style="float:left; width:13%; height:100%; text-align:right; padding-right:1.5%;" >Project:</div>
				<select class="ProjectName" id="ProjectName" onChange="SelectProject();" ></select>
			</div>
			<div class="OName"> <input class=OtherName id=OtherName type=text onKeyPress="Gebi('SaveTimeButton').disabled=false;" /> </div>
			<br />
		
			<select class="TimeEntryPhase" id="TimeEntryPhase">
				<option value="">Please choose project phase / labor type:</option>
				<option value="Plan">Engineering</option>
				<option value="UG">Underground</option>
				<option value="Rough in">Rough in</option>
				<option value="Trim">Trim</option>
				<option value="Finish">Finish</option>
				<option value="N/A">Not Applicable</option>
			</select>
			
			<select class="SupName" id="SupName" ><option>SUPERVISOR APPROVAL:</option><%EmployeeOptionList("active")%></select>
		</div>
			
		<div id="CrewEntryList" class="CrewEntryList" >
			<div id="CrewEntryEmployeeList" class="EmployeeList">
				<select id="CrewSel" class="EmployeeListMenu" onChange="AddToCrew(SelI(this.id).value,SelI(this.id).textContent);">
					<option value="0"></option>
					<%EmployeeOptionList("active")%>
				</select>
			</div><br/>
			<div id="CrewTitleBar" class="CrewTitleBar">Whole Crew Time Entry</div>
			<div id="CrewNames" class="CrewNames" align="left"></div>
		</div>
		
		<div id="TimeEntryLeft" class="TimeEntryLeft" >
		
			<div id="note24hr" style="float:left; clear:left;">Time is in 24hr format.</div><br />
			<div class="JobTimeEntryInfoDesc" >Date</div>
			<input class="JobTimeEntryText" id="JobDate" maxlength="14" onChange="Gebi('TimeEntry').style.display='none';  Gebi('TimeEntry').style.display='block'; " value="" style="width:96px;" />
			<img class="JobTimeEntryDateIcon" onMouseUp="displayCalendar(Gebi('JobDate'),'mm/dd/yyyy',this)" src="../Images/cal24x24.gif"/>
			<div class="JobTimeEntryInfoDesc">Time In</div>
			<input class="JobTimeEntryText" id="JobTimeIn" type="text" maxlength="5" onBlur="GetTotalHrs();" onKeyUp="CheckTime(event,this)"/>
			
			<div class="JobTimeEntryInfoDesc">Time Out</div>
			<input class="JobTimeEntryText" id="JobTimeOut" type="text" maxlength="5" onBlur="GetTotalHrs();" onKeyUp="CheckTime(event,this)"/>

			<div class="JobTimeEntryInfoDesc">Total Hours</div>
			<input class="JobTimeEntryText" readonly id="JobTotalHrs" type="text" maxlength="48" />
		</div>

		<div id="TimeEntryRight" class="TimeEntryRight" style="border:#000 1px solid;">
			<div class="JobTimeEntryInfoDesc" id="JobTimeEntryDesc" style="border:none; text-align:left; padding:2px 0 0 0;"> Description</div>
			<div class="JobTimeEntryDescription" id="JobTimeEntryDescription">
				<textarea class="JobDescriptionText" id="JobDescriptionText" ></textarea>
			</div>
		</div>
		
		<div id="EntryBoxButtons" style="width:100%; float:left; clear:both;">
			<button id="CancelButton" class="CancelButton" onClick="CancelTimeEntry()">Cancel</button>
			<button id="DelButton" class="DelButton" onClick="DeleteTime();" >Delete</button>
			<button id="SaveTimeButton" class="SaveTimeButton" onClick="SaveCrewTime();" disabled >Save</button>
			<button id="UpdateButton" class="UpdateButton" onClick="UpdateEntry();">Update</button>
		</div>
	</div>
</div> 










<div class="MainContainer" id="MainContainer"><!-- Begin Main White Board---------------------------------------------------------------------- -->
	<script type="text/javascript">//alert('yo');</script>
	<input id="EmployeeNameHidden" type="hidden" value="<%=Session("EmpID")%>"/>
	
	<div id="TimeEntryHeader" class="TimeEntryHeader">
		<div style="float:left; font-weight:bold;"><small> </small>Time Entry</div>
		<button id="ReloadFrame" onClick="window.location=window.location"><img src="../Images/reloadblue24.png" width="100%" height="100%"/></button>
	</div>
	
	<div class="LeftBox" id="LeftBox">
      
    
    <!--------------------Employee Info------------------------------------------------------------------------------------------------------------>
   	<%
		LoginCheck()		
		SQL0="SELECT Phone, DCPhone, Email, Address, Position FROM Employees WHERE EmpID="&Session("EmpId")
		Set rs0= Server.CreateObject("AdoDB.RecordSet")
		rs0.open SQL0, REDConnString
		
		If rs0.EOF Then
			%><script type="text/javascript">window.location='../website/tmc/tmc.html'</script><%
		End If
		
		%>
        <div  class="EmployeeInfo">
        <div class="EmployeeName" id="EmployeeName"><%=Session("userName")%></div>
				<div id="TimeEntryEmployeeList" class="EmployeeList" >
					<select id="EmpName" class="EmployeeListMenu" onChange="LoadEmployeeInfo();">
						<option value="0"></option>
						<%EmployeeOptionList("active")%>
					</select>
				</div>
				<div class="EmployeeInfoList"  style="border-top:1px solid #000">
					<div class="EmployeeInfoDesc" >Phone#</div><br/>
					<div class="EmployeeInfoActual" id="EmployeePhone"><%=rs0("Phone")%></div>
				</div>
				<div class="EmployeeInfoList">
					<div class="EmployeeInfoDesc" >Nextel&reg; DC#</div>
						<div class="EmployeeInfoActual" id="EmployeeDCPhone"><%=rs0("DCPhone")%></div>
				</div>
				<div class="EmployeeInfoList">
					<div class="EmployeeInfoDesc" >Email</div>
						<div class="EmployeeInfoActual" id="EmployeeEmail"><%=rs0("Email")%></div>
				</div>
				<div class="EmployeeInfoList">
					<div class="EmployeeInfoDesc" >Address</div>                	
						<div class="EmployeeInfoActual" id="EmployeeAddress"><%=rs0("Address")%></div>
				</div>
				<div class="EmployeeInfoList">
					<div class="EmployeeInfoDesc" >Position</div>
					<div class="EmployeeInfoActual" id="EmployeePos"><%=rs0("Position")%></div>
				</div>
		</div>

	<!---------------Time Entry, Edit--------------------------------------------------------------------------------------------------------------------------->
	
	<div align="left"><big>Enter Time for:</big></div>
<!--input type="button" value="Enter Time" id="NewTimeButton" class="NewTimeButton" onclick="ShowTimeEntry();" /-->

	<div id="TimeEntryJobStyle" class="TimeEntryJobStyle">            	
		<div style="float:left; clear:both;"><input id="HideUnlocked" type="checkbox" onClick="HideTime(this);" /><label for="HideUnlocked">Hide Unlocked</label></div>
		<div style="float:left; clear:both;"><input id="HideLocked" type="checkbox" onClick="HideTime(this);" checked/><label for="HideLocked">Hide Locked</label></div>
		<br style="float:left; clear:both;" />
		<hr style="width:100%; float:left; clear:both;" />
		<br style="float:left; clear:both;" />
		<div style="float:left; clear:both;" align="left">New Entry:</div><br style="float:left; clear:both;" />
		<div style="height:64px;">
			<button id="ProjectTab" class="JobStyleTab" style="color:#950;" onClick="JobSelect('Project');">Project / Jobs</button>
			<button id="ServiceTab" class="JobStyleTab" style="color:#000090;" onClick="JobSelect('Service');">Service</button>
			<button id="TestTab" class="JobStyleTab" style="color:#9B0000;" onClick="JobSelect('Test');">Test / Maint.</button>
			<button id="OtherTab" class="JobStyleTab" style="color:#8C8C00;" onClick="JobSelect('Other');">Office / Other</button>
		</div>
		<!--
		<div class="JobLink" onclick="alert('To clock time for a project:\n\n 1. Under the Projects/Jobs tab find your project. \n 2. click the pencil icon for your project. \n 3. Record your time in a new or existing Forman\'s Report.');">I need to clock time to a project.</div>
		-->
	</div>
	 
<div class="EmployeeTimeEdit" id="EmployeeTimeEditBox"></div>
	</div>
<!-------------End of Left Box- Begin Right Box---------------------------------------------------------------------------------------------->
    
	<div class="RightBox" id="RightBox" onMouseOver="DropDownTimeClose(); EditDropDownClose();" >
    <div id="ListHead" class="Header">
    	<div id="HeaderCheckBox" >&nbsp;</div>
			<div id="HeaderDate"  >Date</div>
			<div id="HeaderTimeIn"  >In</div>
			<div id="HeaderTimeOut"  >Out</div>
			<div id="HeaderTotalHrs" >Total</div>
			<div id="HeaderWage" >Wage</div>
			<div id="HeaderShift" >Shift $</div>
			<div id="HeaderSup" >Supervisor Approval</div>
			<div id="HeaderJobName" >Job Name</div>
			<div id="HeaderJobPhase" >Job Phase</div>
			<div id="HeaderJobType" >Job Type</div>
			<div id="HeaderDescription" >Description</div>   
		</div>
    <div class="EmployeeTimeBody" id="EmployeeTimeBox"><br/><button style="color:#c00; font-size:18px; font-weight:bold;" onClick="LoadEmployeeTime();">Load Time...</button></div>
	</div>
</div>
<!--End Main White Board--------------------------------------------------------------------------------------------------------------------------------->

<div id="MenuProjects" class="RclickMenu">            </div>


</body>
</html>

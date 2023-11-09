<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Admin</title>

<!--#include file="../LMC/RED.asp" -->

<script type="text/javascript" src="Admin/AdminJS.js"></script>
<script type="text/javascript" src="Admin/AdminAJAX.js"></script>
<SCRIPT type="text/javascript" src="Library/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="Modules/rcstri.js"></script>

<link rel="stylesheet" href="Admin/AdminCSS.css" media="screen">
<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">

<script type="text/javascript">

	window.onload=function()
	{
		//Nifty("div#TimeTabBox,div#SQLTabBox,div#GeneralTabBox,div#BidPresetTabBox,div#EmployeeTabBox","medium transparent top");
		//Nifty("div#TimeByEmpTab,div#TimeByProjTab,div#TimeByServTab,div#TimeByTestTab,div#TimeByOtherTab","medium transparent top");
		//Nifty("div#EmpInfoTabBox,div#EmpAccessTabBox,div#EmpUserTabBox","small transparent top");
		
		DataTabs('TimeBox','TimeTabBox')
		//EmpTabs('EmpInfo','EmpInfoTabBox')
		
		setTimeout('LoadEmpList();',2500);
	}

</script>

</head>

<body onResize="Resize();" class="Body"  onmousemove="MouseMove(event); ResetLogoutTimer();" onkeyup="ResetLogoutTimer();">














<div id="DataTabsBox" class="DataTabsBox"><!--Creates dynamic tabs-->

	<div id="TimeTabBox" class="TabBox2" style="margin-left:1px; background:#EEE7AE;">
    <div id="TimeTab"  class="TabInner2" onClick="DataTabs('TimeBox','TimeTabBox')" onMouseOver="MouseOverMarTop('TimeTabBox')" onMouseOut="MouseOutMarTop('TimeTabBox');">Time Reports<br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </div>
	</div>
    
    <div id="EmployeeTabBox" class="TabBox2" style="background:#DEC9D3;">
    <div id="EmployeeTab"  class="TabInner2" onClick="DataTabs('EmployeeBox','EmployeeTabBox');" onMouseOver="MouseOverMarTop('EmployeeTabBox')" onMouseOut="MouseOutMarTop('EmployeeTabBox')">Employees<br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </div>
	</div>
    
    <div id="SQLTabBox" class="TabBox2" style="background:#CCC;">
    <div id="SQLTab"  class="TabInner2" onClick="DataTabs('SQLBox','SQLTabBox')" onMouseOver="MouseOverMarTop('SQLTabBox')" onMouseOut="MouseOutMarTop('SQLTabBox')">Database<br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </div>
	</div>
    
    <div id="BidPresetTabBox" class="TabBox2 ditch">
    <div id="BidPresetTab"  class="TabInner2" onClick="DataTabs('BidPreset','BidPresetTabBox');" onMouseOver="MouseOverMarTop('BidPresetTabBox')" onMouseOut="MouseOutMarTop('BidPresetTabBox')"><br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </div>
	</div>
    
    <div id="GeneralTabBox" class="TabBox2 ditch">
    <div id="GeneralTab"  class="TabInner2" onClick="DataTabs('GeneralBox','GeneralTabBox')" onMouseOver="MouseOverMarTop('GeneralTabBox')" onMouseOut="MouseOutMarTop('GeneralTabBox')"><br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </div>
	</div>
	
	<button id="ReloadFrame" onClick="window.location=window.location"><img src="../images/reloadblue24.png" width="100%" height="100%"/></button>
</div>    
 












  
  
<div id="TimeBox" class="MainBoxHidden" style="background:#EEE7AE;">


    
	<div class="TimeHead" align="left"> &nbsp; Time Reports</div> 
	
	<div id="TimeTabsBox" class="DataTabsBox" style="background:none;"><!--Creates dynamic time tabs-->
	
		<div id="TimeByEmpTab" class="TabBox2" style="margin-left:1px; background:#FAF8E2;">
			<div id="TimeTab"  class="TabInner2" onClick="TimeTabs('TimeByEmp');LoadEmpList();"
			 onmouseover="MouseOverMarTop('TimeByEmpTab')" onMouseOut="MouseOutMarTop('TimeByEmpTab')">
				Employee<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			</div>
		</div>
		
		<div id="TimeForWorkersCompTab" class="TabBox2" style="background:#FFFF9F;">
			<div id="WorkersCompTab" class="TabInner2" onClick="TimeTabs('TimeForWorkersComp');"
			 onMouseOver="MouseOverMarTop('TimeForWorkersCompTab')" onMouseOut="MouseOutMarTop('TimeForWorkersCompTab')">
			 	Workers' Comp.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			</div>
		</div>
			
		<div id="TimeByProjTab" class="TabBox2" style="background:#FFE4CC;">
			<div id="ProjectTab"  class="TabInner2" onClick="TimeTabs('TimeByProj')" onMouseOver="MouseOverMarTop('TimeByProjTab')" onMouseOut="MouseOutMarTop('TimeByProjTab')">Project<br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </div>
		</div>
			
		<div id="TimeByServTab" class="TabBox2" style="background:#D2D2FF;">
			<div id="ServiceTab"  class="TabInner2" onClick="TimeTabs('TimeByServ');" onMouseOver="MouseOverMarTop('TimeByServTab')" onMouseOut="MouseOutMarTop('TimeByServTab')">Service<br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </div>
		</div>
			
		<div id="TimeByTestTab" class="TabBox2" style="background:#FFE1E1;">
			<div id="TestTab"  class="TabInner2" onClick="TimeTabs('TimeByTest')" onMouseOver="MouseOverMarTop('TimeByTestTab')" onMouseOut="MouseOutMarTop('TimeByTestTab')">Test/Maint<br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </div>
		</div>
	</div><!--  End Time Tabs  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -->
    
    
    
		
		
	<div id="TimeByEmp" class="MainTimeBox" style="background:none;">
		<label>
			From:<br />
			<input id="FromDate" type="text" onChange="LoadEmployeeTime();" onFocus="displayCalendar('FromDate','mm/dd/yyyy',FromDate);" />
			<img style="cursor:pointer;" src="../Images/cal.gif" width="16" height="16"><br />
		</label>
		<label>
			To: <small>(inclusive)</small><br />
			<input id="ToDate" type="text" onChange="LoadEmployeeTime();" onFocus="displayCalendar('ToDate','mm/dd/yyyy',ToDate);" />
			<img style="cursor:pointer;" src="../Images/cal.gif" width="16" height="16"><br /><br />
		</label>
		<label for="EmpList">Employee:</label><br />
		<select id="EmpList" onChange="LoadEmployeeTime();"></select>
		<br />
		<br />
		<button id="PrintArchive" class="TimeButton" onClick="Archive('True'); PrintTime();">Lock &amp; Print</button>
		<button id="Archive" class="TimeButton" onClick="Archive('True'); ">Lock</button>
		<button id="Print" class="TimeButton" onClick="PrintTime();">Print</button>
		<button id="UnArchive" class="TimeButton" onClick="Archive('False');">Unlock</button>
	</div>
		
		
	<div id="TimeForWorkersComp" class="MainTimeBox" style="display:none; background:#FFFFDF;">
		From:<br />
		<input id="wcFromDate" type="text" onChange="LoadWorkersCompTime();" onFocus="displayCalendar('wcFromDate','mm/dd/yyyy',wcFromDate);" />
		<img style="cursor:pointer;" onClick="displayCalendar('wcFromDate','mm/dd/yyyy',wcFromDate);" src="../Images/cal.gif" width="16" height="16"><br />
		To: <small>(inclusive)</small><br />
		<input id="wcToDate" type="text" onChange="LoadWorkersCompTime();" onFocus="displayCalendar('wcToDate','mm/dd/yyyy',wcToDate);" />
		<img style="cursor:pointer;" onClick="displayCalendar('wcToDate','mm/dd/yyyy',wcToDate);" src="../Images/cal.gif" width="16" height="16"><br /><br />
		<button id="Print" class="TimeButton" onClick="PrintTime();">Print</button>
	</div>
	
	
		
	<div id="TimeByProj" class="MainTimeBox" style="display:none; background:#FFAC62;">
		<input id=ProjID type=hidden value=0 />
		
		From:<br />
		<input id=projFromDate value="01/01/1900" onChange="LoadJobTime(Gebi('ProjID').value,'Project');" onFocus="displayCalendar('projFromDate','mm/dd/yyyy','projFromDate');"
		/>
		<img style="cursor:pointer;" onClick="displayCalendar('projFromDate','mm/dd/yyyy',projFromDate);" src="../Images/cal.gif" width="16" height="16"><br />
		
		To: <small>(inclusive)</small><br />
		<input id=projToDate value="<%=Date%>" onChange="LoadJobTime(Gebi('ProjID').value,'Project');" onFocus="displayCalendar('projToDate','mm/dd/yyyy',projToDate);"/>
		<img style="cursor:pointer;" onClick="displayCalendar('projToDate','mm/dd/yyyy',projToDate);" src="../Images/cal.gif" width="16" height="16"><br /><br />
		<button id="Print" class="TimeButton" onClick="PrintTime();">Print</button><br /><br />
		
		<label><input id=cbInActiveProj type="checkbox" onChange="if(this.checked){Gebi('InactiveProjects').style.display='block';} else {Gebi('InactiveProjects').style.display='none';}"/>Show Inactive Projects</label>
		<label for="ProjList">Projects:</label><br />
		<div id="ProjList" class="ProjList" style="margin:0 1% 0 1%; width:98%;">
			<div id="ActiveProjects" class="ActiveProjList" >
			<%
			SQL="SELECT * FROM Projects WHERE Active=1 ORDER BY ProjName"
			Set rs=Server.CreateObject("AdoDB.RecordSet")
			rs.Open SQL, REDConnString
			Do Until rs.EOF
				
				SQL1="SELECT * FROM Time WHERE JobType='Project' AND JobID="&rs("ProjID")
				Set rs1=Server.CreateObject("AdoDB.RecordSet")
				rs1.Open SQL1, REDConnString
				
				If Not rs1.EOF Then
					%>
					<div class=ProjListItem id=Proj<%=rs("ProjID")%> onClick="LoadJobTime(<%=rs("ProjID")%>,'Project');" draggable=true>
				<%=DecodeChars(rs("ProjName"))%>					</div>
					<%
				End If
				
				Set rs1=Nothing
				
				rs.MoveNext
			Loop
			Set rs=Nothing
			%>
			</div>
			
			<div id="InactiveProjects" class="InactiveProjList" >
			<%
			SQL="SELECT * FROM Projects WHERE Active!=1 ORDER BY ProjName"
			Set rs=Server.CreateObject("AdoDB.RecordSet")
			rs.Open SQL, REDConnString
			Do Until rs.EOF
				
				SQL1="SELECT * FROM Time WHERE JobType='Project' AND JobID="&rs("ProjID")
				Set rs1=Server.CreateObject("AdoDB.RecordSet")
				rs1.Open SQL1, REDConnString
				
				If Not rs1.EOF Then
					%>
					<div class=ProjListItem id=Proj<%=rs("ProjID")%> onClick="LoadJobTime(<%=rs("ProjID")%>,'Project');" draggable=true><%=DecodeChars(rs("ProjName"))%></div>
					<%
				End If
				
				Set rs1=Nothing
				
				rs.MoveNext
			Loop
			Set rs=Nothing
			%>
			</div>
		</div>
	</div>
		
		
		
		
	<div id="TimeByServ" class="MainTimeBox" style="display:none;">	</div>
		
		
	<div id="TimeByTest" class="MainTimeBox" style="display:none;">	</div>
		
		
	<div id="TimeByOther" class="MainTimeBox" style="display:none;">	</div>

	<div id="TimeEmpRight" class="TimeEmpRight">
		
		<!-- 
		<div id="ListHead" class="Header">
			<div class="HeaderCheckBox"></div>
			<div id="HeaderDate" class="HeaderDate">Date</div>
			<div id="HeaderTimeIn" class="HeaderTimeIn">In</div>
			<div id="HeaderTimeOut" class="HeaderTimeOut">Out</div>
			<div id="HeaderTotalHrs" class="HeaderTotalHrs">Total</div>
			<div id="HeaderSup" class="HeaderSup">Supervisor Approval</div>
			<div id="HeaderJobName" class="HeaderJobName">Job Name</div>
			<div id="HeaderJobPhase" class="HeaderJobPhase">Job Phase</div>
			<div id="HeaderJobType" class="HeaderJobType">Job Type</div>
			<div id="HeaderDescription" class="HeaderDescription">Description</div>   
		</div>
		-->
		<div class=EmployeeTimeBody id=EmployeeTimeBox>
			<iframe id=ReportFrame src="" frameborder=0 style="width:100%; height:100%;"></iframe>
		</div>
	</div>
</div>
<!--END TimeBox--> 
  
  
  
  
     

<div id="EmployeeBox" class="MainBoxHidden" style="background:#CEB0BE;" ><!--Creates the Tabs-->

	<div id="EmployeeHead" class="EmployeeHead"> Employee Data </div>

	
	<div id="EmployeeData" class="EmployeeData">
    
		<div id="EmployeeDL" class="EmployeeDL" align="left"> 
		
		<div id="EmpDLTabs" class="EmpDLTabs">
			
			<div id="EmpInfoTabBox" class="TabBox2" style="margin-left:1px; ">
				<div id="EmpInfoTab"  class="TabInner2" onClick="EmpTabs('EmpInfo','EmpInfoTabBox')" style="height:10px; color:#FFFFFF;" 
				 onmouseover="MouseOverTab('EmpInfoTabBox')" onMouseOut="MouseOutTab('EmpInfoTabBox')">Employee Info</div>
			</div>
				 
			<div id="EmpUserTabBox" class="TabBox2">
				<div id="EmpUserTab"  class="TabInner2" onClick="EmpTabs('EmpUser','EmpUserTabBox')" style="height:10px; color:#FFFFFF;"
				 onmouseover="MouseOverTab('EmpUserTabBox')" onMouseOut="MouseOutTab('EmpUserTabBox')">Employee User</div>
			</div>
				
			<div id="EmpAccessTabBox" class="TabBox2">
				<div id="EmpAccessTab"  class="TabInner2" onClick="EmpTabs('EmpAccess','EmpAccessTabBox')" style="height:10px; color:#FFFFFF;"
				 onmouseover="MouseOverTab('EmpAccessTabBox')" onMouseOut="MouseOutTab('EmpAccessTabBox')">User Access</div>
			</div>
				 
			<div id="EmpName" class="EmpName">Choose an employee→</div>
		</div>
		
			<div id="EmpInfo" class="EmpInfo">
				<div id="EmpButtons1" class="EmpButtons1" valign="bottom">
					<input id="UpdateEmp" style="float:left; display:none;" type="button"onclick="UpdateEmployee();" value="Update"/> 
					<input id="SaveEmp" style="float:left; display:none;" type="button"onclick="SaveEmployee();" value="Save"/> 
					<input id="DelEmp" style="float:right; display:none;" type="button"onclick="DelEmployee();" value="Delete"/>      
					<input id="CancelEmp" style="float:right; display:none;" type="button"onclick="CancelEmployee();" value="Cancel"/> 
				</div>
						
				<div class="EmpTxtL"> Employee ID:</div> <div class="EmpTxtR" id="txtEmpID"></div><br />
				<div class="EmpTxtL"> First Name:</div> <div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpFName" type="text" value="" maxlength="50" /></div><br />
				<div class="EmpTxtL"> Last Name:</div> <div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpLName" type="text" value="" maxlength="50" /></div><br />
				<div class="EmpTxtL"> Address: </div> <div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpAddress" type="text" value="" maxlength="50" /></div><br />
				<div class="EmpTxtL"> City:   </div> <div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpCity" type="text" value="" maxlength="50" /></div><br />
				<div class="EmpTxtL"> State: </div> <div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpState" type="text" value="" maxlength="50" /></div><br />
				<div class="EmpTxtL"> Zip:  </div> <div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpZip" type="text" value="" maxlength="5" /></div><br />
				<div class="EmpTxtL"> Phone:</div> <div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpPhone" type="text" value="" maxlength="50" /></div><br />
				<div class="EmpTxtL"> 2<sup>nd</sup> Phone:</div><div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpPhone2" type="text" maxlength="50" /></div><br />
				<div class="EmpTxtL"> <small><b>Nextel</b><sup>&reg;</sup><small> DirectConnect</small><sup>&trade;</sup></small>:</div>
				                                      <div class="EmpTxtR"><input class="EmpTxt" id="txtEmpDCPhone" type="text" value="" maxlength="50" /></div><br />
				<div class="EmpTxtL"> Email:	 	  </div> <div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpEmail" type="text" value="" maxlength="50" /></div><br />
				<div class="EmpTxtL"> Position:  </div> <div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpPosition" type="text" value="" maxlength="50" /></div><br />
				<div class="EmpTxtL"> Wage:     </div> <div class="EmpTxtR"> <input class="EmpTxt" id="txtEmpWage" type="text" value="" maxlength="50" /></div><br />
				<div class="EmpTxtL"> Date Hired:</div>
				<div class="EmpTxtR"><small>
				<input class="DateEmpTxt" id="txtEmpDate" type="text" onKeyPress="return numbersonly(event);"  maxlength="10" /></small>
				<div style="float:right; position:static; margin-right:2%; top:-22px;"><input id="EmpActive" type="checkbox"/><label for="EmpActive">Active</label></div>
				</div>
			</div>

			
			<div id="EmpUser" class="EmpAccess">
			
					<div style="width:49.9%; float:left;">
						<pre><br />
Username:<input id="txtUserName" type="text" value="NONE" width="9"/><br />&#13;
Password:<input id="txtPassword" type="password" value="********" onFocus="this.select;" width="12"/><br />
 Confirm:<input id="txtConfirm" type="password" value="∙∙∙∙∙∙∙∙" onFocus="this.select;" width="12"/><br />
 						</pre>
					</div>
					<div style="width:49.9%; float:right; ">
						<pre><br />
<button style="width:100%;" onClick="UpdateUser();">Update UserName</button><br /></pre><br /><br /><pre>
<button style="width:100%;" onClick="UpdatePass();">Update Password</button><br />
						</pre>
					</div>
					<input id="EmpUserName" type="hidden" value=""/>
			
			<div id="UserModal" valign="center" align="center"
			 style="position:absolute; top:29px; left:0px; width:100%; height:100%; background-color:#C49FB1; filter:alpha(opacity=95); z-index:100000">
				<b>No user account for this employee.</b>
				<button style="height:20px;" onClick="document.getElementById('NewUser').style.display='block';"><b>create one</b></button>
				
				<div id="NewUser" style="display:none; width:75%; left:12%; text-align:left;">
						<pre><br/>
<div class="Center50">Username:</div><br /><input id="User" type="text" onKeyUp="MakeUser.value='Create '+this.value;" class="Center50"/>
</pre><br /><br /><pre>
<div class="Center50">Password:</div><br /><input id="Pass" type="password" class="Center50"/><br />
<div class="Center50">Confirm:</div><br /><input id="Conf" type="password" class="Center50"/><br />
</pre>
							<button class="Center50" id="MakeUser" accesskey="&#13;" onClick="NewUser();">Create User</button>
				</div>
			</div>
		</div>
		
		
		
		<div id="EmpAccess" class="EmpAccess" style="overflow-x:visible; overflow-y:scroll;" >
			
			<pre>
<input id="CBDataEntry" type="checkbox" onClick="UpdateAccess(this,this.checked,'DataEntry')" /><label for="CBDataEntry">Data Entry</label><br />
<input id="CBEstimates" type="checkbox" onClick="UpdateAccess(this,this.checked,'Estimates')" /><label for="CBEstimating">Estimating/Sales</label><br />
<input id="CBProjects" type="checkbox" onClick="UpdateAccess(this,this.checked,'Projects')" /><label for="CBProjects">Projects</label><br />
<input id="CBService" type="checkbox" onClick="UpdateAccess(this,this.checked,'Service')" /><label for="CBService">Service</label><br />
<input id="CBTest" type="checkbox" onClick="UpdateAccess(this,this.checked,'Test')" /><label for="CBTest">Test/Maintenance</label><br />
<input id="CBEngineering" type="checkbox" onClick="UpdateAccess(this,this.checked,'Engineering')"/><label for="CBEngineering">Engineering</label><br/>
<input id="CBPurchasing" type="checkbox" onClick="UpdateAccess(this,this.checked,'Purchasing')" /><label for="CBPurchasing">Purchasing</label><br />
<input id="CBTime" type="checkbox" onClick="UpdateAccess(this,this.checked,'Time')" /><label for="CBTime">Time Entry/Edit</label><br />
<input id="CBOffice" type="checkbox" onClick="UpdateAccess(this,this.checked,'Office')" /><label for="CBOffice">Office Management</label><br />
<input id="CBInventory" type="checkbox" onClick="UpdateAccess(this,this.checked,'Inventory')" /><label for="CBInventory">Inventory Control</label><br />
<input id="CBTraining" type="checkbox" onClick="UpdateAccess(this,this.checked,'Training')" /><label for="CB">Training</label><br />
<input id="CBWebsite" type="checkbox" onClick="UpdateAccess(this,this.checked,'Website')" /><label for="CBWebsite">Website</label><br />
<input id="CBAdmin" type="checkbox" onClick="UpdateAccess(this,this.checked,'Admin')" /><label for="CBAdmin">Administration</label>
			</pre>
		
			<div id="AccessModal" align="center" style="position:absolute; top:29px; left:0px; width:100%; height:100%; background-color:#C49FB1; filter:alpha(opacity=95); z-index:10000">
				<b>No user account for this employee.</b>			</div>
		</div>
	</div>

		<div id ="EmployeeDR" class="EmployeeDR" >
			Error loading employee list		</div>
	</div>
</div>
<!--End Employee-->  
  
  

  
  
  
  
<div id="SQLBox" class="MainBoxHidden" style="background:#EEE;"><!--Creates the Tabs for The Estimate-->
<iframe src="file://///Lmc/sqlwebi/SQL.ASP" style="width:100%; height:100%;"></iframe>
</div>     
    
  
  
  
  
  
  
  
  
  
  
  
  
  
<div id="BidPreset" class="MainBoxHidden"><!--BidPreset TAB Page-->
</div> 
<!--End BidPreset-->
  
   
   
   
   
   
   
   
   
   
   
   
    
    

<div id="GeneralBox" class="MainBoxHidden"><!--Creates the Tabs for The Estimate-->


	General</div>

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
<input id="HiddenPartID"type="hidden" value="" /> 
  
 
<script type="text/javascript">Resize();</script>   
</body>
</html>
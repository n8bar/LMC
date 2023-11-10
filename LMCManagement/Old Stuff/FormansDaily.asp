<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Forman's Daily Report</title>

<!--#include file="../../LMC/RED.asp" -->

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="FormansDaily.js"></script>
<script type="text/javascript" src="../Library/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>

<link type="text/css" rel="stylesheet" href="../Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">
<link type="text/css" rel="stylesheet" href="FormansDailyPrint.css" media="print" >
<link type="text/css" rel="stylesheet" href="FormansDaily.css" media="screen" >
</head>

<body>
<div id="Body">
	
	<%
		ReportID=Request.QueryString("Report")
		
		If ReportID = "ByDate" Then
			SQL="SELECT * FROM FormansReport WHERE Date='"&Request.QueryString("Date")&"' AND ProjID="&Request.QueryString("ProjID")
			Set rs=Server.CreateObject("AdoDB.RecordSet")
			rs.Open SQL, REDConnString
			
			ReportID= rs("ReportID")
		
		Else
			SQL="SELECT * FROM FormansReport WHERE ReportID="&ReportID
			Set rs=Server.CreateObject("AdoDB.RecordSet")
			rs.Open SQL, REDConnString
		
		End If
			
		ProjID=rs("ProjID")
		d8=rs("Date")
				
		SQL1="SELECT * FROM Projects WHERE ProjID="&ProjID
		Set rsProj=Server.CreateObject("AdoDB.RecordSet")
		rsProj.Open SQL1, REDConnString
	%>
	
	
	<div id="heading">
		<div id="TitleBuddy">Project: <div id=ProjName><%=rsProj("ProjName")%></div></div>
		<div id="Title">Forman's Daily Report</div>
	</div>
	
	<div id=TopButtons>
		<button id=Back onClick="PGebi('ProjectsIframe').src='formansdailyReports.asp?ProjID=<%=ProjID%>';">◄ Back 2 Report List</button>
		<button id=Back2Proj onClick="PGebi('ProjectsIframe').src='Projects.asp';">◄ Back 2 Projects</button>
		<button id=Print onClick="Gebi('TopButtons').style.display='none'; window.print(); Gebi('TopButtons').style.display='block';">Print Report</button>
	</div>
	
	<div id="Top">
		<img id="Logo" src="../../LMCManagement/Images/TCS.jpg"/>
		<div id="Weather">
			<%
				If rs("Sunny")="True" Then Sunny="checked" else Sunny=""
				If rs("Cloudy")="True" Then Cloudy="checked" else Cloudy=""
				If rs("Thunder")="True" Then Thunder="checked" else Thunder=""
				If rs("Rain")="True" Then Rain="checked" else Rain=""
				If rs("Ice")="True" Then Ice="checked" else Ice=""
				If rs("Wind")="True" Then Wind="checked" else Wind=""
				If rs("Snow")="True" Then Snow="checked" else Snow=""
				If rs("Cold")="True" Then Cold="checked" else Cold=""
			%>
			<label class="WeatherLabel" style="margin-left:.03125in;" title="Sunny">
				<img class="WeatherIcon" src="../../LMCManagement/images/weather/Sunny.jpg" />
				<input id="WeatherCheckboxSunny" class="WeatherCheckbox" type="checkbox"<%=Sunny%> onChange="SetBit('Sunny',this.checked,<%=ReportID%>)"  />&nbsp;
			</label>
			<label class="WeatherLabel" style="left:.5in;" title="Cloudy">
				<img class="WeatherIcon" src="../../LMCManagement/images/weather/Cloudy.jpg" />
				<input id="WeatherCheckboxCloudy" class="WeatherCheckbox" type="checkbox" <%=Cloudy%> onChange="SetBit('Cloudy',this.checked,<%=ReportID%>)"  />
			</label>
			<label class="WeatherLabel" style="left:1in;" title="Thunderstorms">
				<img class="WeatherIcon" src="../../LMCManagement/images/weather/Thunder.jpg" />
				<input id="WeatherCheckboxThunder" class="WeatherCheckbox" type="checkbox" <%=Thunder%> onChange="SetBit('Thunder',this.checked,<%=ReportID%>)"  />
			</label>
			<label class="WeatherLabel" style="left:1.5in;" title="Rain">
				<img class="WeatherIcon" src="../../LMCManagement/images/weather/Rain.jpg" />
				<input id="WeatherCheckboxRain" class="WeatherCheckbox" type="checkbox" <%=Rain%> onChange="SetBit('Rain',this.checked,<%=ReportID%>)"  />
			</label>
			<label class="WeatherLabel" style="left:2in;" title="Ice">
				<img class="WeatherIcon" src="../../LMCManagement/images/weather/Ice.jpg" />
				<input id="WeatherCheckboxIce" class="WeatherCheckbox" type="checkbox" <%=Ice%> onChange="SetBit('Ice',this.checked,<%=ReportID%>)"  />
			</label>
			<label class="WeatherLabel" style="left:2.5in;" title="Windy">
				<img class="WeatherIcon" src="../../LMCManagement/images/weather/Windy.jpg" />
				<input id="WeatherCheckboxWind" class="WeatherCheckbox" type="checkbox" <%=Wind%> onChange="SetBit('Wind',this.checked,<%=ReportID%>)"  />
			</label>
			<label class="WeatherLabel" style="left:3in;" title="Snow">
				<img class="WeatherIcon" src="../../LMCManagement/images/weather/Snow.jpg" />
				<input id="WeatherCheckboxSnow" class="WeatherCheckbox" type="checkbox" <%=Snow%> onChange="SetBit('Snow',this.checked,<%=ReportID%>)"  />
			</label>
			<label class="WeatherLabel" style="left:3.5in;" title="Cold">
				<img class="WeatherIcon" src="../../LMCManagement/images/weather/Cold.jpg" />
				<input id="WeatherCheckboxCold" class="WeatherCheckbox" type="checkbox" <%=Cold%> onChange="SetBit('Cold',this.checked,<%=ReportID%>)"  />
			</label>
		</div>
	
		<div id="Temp">
			<label id=lblTempHi>High:<input id="tempHi" value="<%=rs("Hi")%>" onChange="SendSQL('Write','UPDATE FormansReport Set Hi='+Numberize(this.value)+' WHERE ReportID=<%=ReportID%>');"/></label>
			<label id=lblTempLo>Low:<input id="tempLo" value="<%=rs("Lo")%>" onChange="SendSQL('Write','UPDATE FormansReport Set Lo='+Numberize(this.value)+' WHERE ReportID=<%=ReportID%>');" /></label>
		</div>
		
		<%
		FormanID=rs("FormanID")
		
		If IsNull(FormanID) Or FormanID="" Or FormanID=0 Then 
			Forman = "---NOT ENTERED---"
			FormanID = 0
		Else
			SQL2="SELECT * FROM Employees WHERE EmpID="&FormanID
			Set rsForman=Server.CreateObject("AdoDB.RecordSet")
			rsForman.Open SQL2, REDConnString
			
			Forman=rsForman("FName")&" "&rsForman("LName")
		End If
			
		Set rsForman=Nothing
		%>
		<div id="TopBottom">
			<label id=lblForman>Forman:
				<select id="Forman" Class="Forman"
				 onChange="FormanChange(this[this.selectedIndex].value,<%=ProjID%>,'<%=d8%>',<%=ReportID%>)
				           this.value=this[this.selectedIndex].value;
									 Gebi('FormanDiv').innerHTML=this[this.selectedIndex].innerText;
					         "
				>
					<option id="Emp0" value="0" >---NOT ENTERED---</option>
				<%
					SQL3="SELECT * FROM Employees WHERE Active='True' AND NonHuman!='True' ORDER BY FName"
					Set rsEmps=Server.CreateObject("AdoDB.RecordSet")
					rsEmps.Open SQL3, REDConnString
					
					Emps=0
					Do Until rsEmps.EOF
						Emps=Emps+1
						EmpName=rsEmps("FName")&" "&rsEmps("LName")
						If rsEmps("EmpID")=FormanID Then Selected="Selected" Else Selected=""
				%>
						<option id="Emp<%=Emps%>" value="<%=rsEmps("EmpID")%>" <%=Selected%> ><%=EmpName%></option>
				<%
						rsEmps.MoveNext
					Loop
				%>
				</select>
				<div id="FormanDiv" class="Forman"></div>
				<script type="text/javascript">Gebi('FormanDiv').innerHTML=SelI('Forman').innerHTML</script>
			</label>
			<label id=lblDate align=right>Date:<input id="ReportDate" value="<%=d8%>" onChange="DateChange('<%=d8%>',this.value,<%=ProjID%>,<%=ReportID%>);"/></label>
			<img id="DatePick" onClick="displayCalendar('ReportDate','mm/dd/yyyy',Gebi('ReportDate'))" src="../../LMCManagement/Images/cal.gif" />		</div>
	</div>

	<div id="TimeHead">
		
		<div id="EmpTimeTab" align="center">Employee Time</div>
		
		<div id="TimeHeadRow">
			<div id="ClearH">
				<img id=DelAll src=../../LMCManagement/images/delete_16.png title="Delete Everybody's Time!!!"
				 onClick="
				 if(confirm('You are about to wipe all the time for this project on this day!'))
				 	{SendSQL('Write', 'DELETE FROM Time WHERE Date=\'<%=d8%>\' AND JobType=\'Project\' AND JobID=<%=ProjID%>'); Gebi('TimeFrame').src=Gebi('TimeFrame').src;}"
				/>
			</div>
			<div id="EmpNameH">Employee Name</div>
			<div id="SystemsH">
				<!--
				<div id="SystemH">Systems</div>
				-->
				<div class="SysNameH" id="SysName1" style="border-left:none;">System</div>
				<!--
				<select class="SysNameH" id="SysName2">
					<option>Select a System</option>
				</select>
				<select class="SysNameH" id="SysName3">
					<option>Select a System</option>
				</select>
				-->
			</div>
			<div id="PhaseH">Phase</div>
			<div id="EmpWorkH">Work Performed</div>
			<div id="TotalHrsH">Total<br/>Hrs</div>
		</div>
	</div>
	
	<%d8=rs("Date")%>
	<iframe id="TimeFrame" frameborder="0" src="DailyTime.asp?ProjID=<%=ProjID%>&Date=<%=d8%>"></iframe>
	
	<%	If rs("Cleaned")="True" Then Cleaned="checked" Else Cleaned=""	%>
	
	<div id="TodayTab" align="center">Today's Report</div>
	<label id=Clean><input id=ckClean type=checkbox <%=Cleaned%> onChange="SetBit('Cleaned',this.checked)" /><small><small>&nbsp;</small></small>Cleaned Jobsite</label>
	<textarea id="TodaysWork" onKeyUp="SendSQL('Write','UPDATE FormansReport Set Report=\''+CharsEncode(this.value)+'\' WHERE ReportID=<%=ReportID%>');"><%=rs("Report")%></textarea>
	
	<div id="TomorrowTab" align="center">Tomorrow's Work Projection</div>
	<textarea id="TomorrowsWork" onKeyUp="SendSQL('Write','UPDATE FormansReport Set WorkTomorrow=\''+CharsEncode(this.value)+'\' WHERE ReportID=<%=ReportID%>');"><%=rs("WorkTomorrow")%></textarea>
	
	<div id=MatTab align=center>Materials & Rentals Received</div>
	<div id=MatNeededTab align=center>Materials Needed</div>
	<textarea id="MatRec" onKeyUp="SendSQL('Write','UPDATE FormansReport Set MatReceived=\''+CharsEncode(this.value)+'\' WHERE ReportID=<%=ReportID%>');"><%=rs("MatReceived")%></textarea>
	<textarea id="MatNeed" onKeyUp="SendSQL('Write','UPDATE FormansReport Set MatNeeded=\''+CharsEncode(this.value)+'\' WHERE ReportID=<%=ReportID%>');"><%=rs("MatNeeded")%></textarea>
</div>
</body>
</html>

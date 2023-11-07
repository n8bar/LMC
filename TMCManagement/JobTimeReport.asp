<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Time Report</title>

<!--#include file="../TMC/RED.asp" -->
<!--#include file="common.asp" -->

<script type="text/javascript" src="Modules/rcstri.js"></script>


<style type="text/css">

html,body{margin:0px; padding:0px; min-width:100%; width:100%; min-height:100%; height:100%;)}

/*div{text-align:center;}*/

.TimeRow{border-bottom:#000 1px solid; width:100%; height:18px; float:left;}
.TotalRow{border-bottom:#000 1px solid; width:100%; height:36px; float:left;}

.HourBox{ height:100%; float:left; border-left:1px solid #000; font-family:Consolas, 'Courier New'; font-size:14px; }
.TimeBox{
height:100%; float:left; border-left:1px solid #000; font-family:Georgia, "Times New Roman", Times, serif;
}
.HTimeBox{height:100%;float:left; font-family:"Times New Roman", Times, serif; font-size:20px; border-left:#000 1px solid; text-align:center;}

#TotalHours{font-size:14px; text-align:right; border-bottom:2px ridge; width:100%; height:16px;}
#HoursDiv{font-family:Consolas, "Courier New", Courier, monospace;}
</style>

</head>
<body>
<%

JobType=Request.QueryString("JobType")
JobID=Request.QueryString("JobID")
DateFrom = CStr(Request.QueryString("From"))
If DateFrom = "Earliest" Or DateFrom="" Then DateFrom = "01/01/1900"
DateTo = CStr(Request.QueryString("To"))
If DateTo = "Latest" Or DateTo="" Then DateTo = "12/31/2078"

Select Case JobType
	Case "Project"
		SQL0="SELECT * FROM Projects WHERE ProjID="&JobID
		Set rs0=Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
	'Case ""
	
	Case Else
		
		%>Can't handle JobType:<pre><%=JobType%></pre><%
		Response.End()
End Select

ProjName=DecodeChars(rs0("ProjName"))
Set rs=Nothing

%>
<div align="center"><big><b>Job Time Report</b></big></div>
<div align="center">for: <big><big><%=ProjName%></big></big></div>
<div align="center">From:<%=DateFrom%> Through:<%=DateTo%></div>
<div align="center"><small>Report Date: <%=Date%></small></div>
<div id=TotalHours >
	<div id=HoursDiv style="float:right;"></div>
	<div style="float:right;">Total Hours:</div>
</div>


<%
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	SQL="SELECT Supervisor, EmpID, TimeInHr, TimeInMin, TimeOutHr, TimeOutMin, JobPhase, Date FROM Time WHERE JobType='Project' AND JobID="&JobID&" AND Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"' ORDER BY EmpID, JobPhase, Date"
	rs.Open SQL, REDConnString
	If rs.EOF Then
		%><br/><br/><br/><div align=center><em>Nothing to show</em></div><%
	Else
		tNum=0
		TotalHours=0
		CurrentEmp=""
		TotalEmp=0
		Do Until rs.EOF
			tNum=tNum+1
			Set rs1=Server.CreateObject("AdoDB.RecordSet")
			SQL1="SELECT FName, LName FROM Employees WHERE EmpID="&rs("Supervisor")
			rs1.Open SQL1, REDConnString
			If rs1.EOF Then
				Supervisor=rs("Supervisor")
			Else
				Supervisor=rs1("FName")&" "&rs1("LName")
			End If
			Set rs1=Nothing
			
			If CurrentEmp <> rs("EmpID") Then
				If CurrentEmp<>"" Then
					%>
					<div class=TotalRow id=TotalRow<%=CurrentEmp%>>
						<div class=TimeBox style="width:80%; text-align:right;">Total for&nbsp;<b><%=Emp%></b>&nbsp;<br/><%=empWage%></div>
						<div class=HourBox style="width:16.25%; ">&nbsp;<%=Round(TotalEmp,3)%><br/><b>&nbsp;<big><%=formatCurrency(Wage*TotalEmp)%></big></b></div>
					</div>
					<br/>&nbsp;
					<br/>&nbsp;
					<%
				End If
				
				Set rs2=Server.CreateObject("AdoDB.RecordSet")
				SQL2="SELECT FName, LName, Wage FROM Employees WHERE EmpID="&rs("EmpID")
				rs2.Open SQL2, REDConnString
				If rs2.EOF Then
					Emp = rs("EmpID")
					Wage=0
					empWage=0
				Else
					Emp=rs2("FName")&" "&rs2("LName")
					Wage=rs2("Wage")
					empWage=formatCurrency(Wage)&"/hr" : If Wage=0 Then empWage="Salary"
				End If
				Set rs2=Nothing
				
				%>
				<div style="font-size:20px; font-weight:bold; width:100%; border-bottom:1px #000 solid;"><%=Emp%></div>

				<div style="float:left; height:22px; width:100%; border-bottom:#000 1px solid;">
					<div class=HTimeBox style="width:20%;">Phase</div>
					<div class=HTimeBox style="width:20%;">Date</div>
					<div class=HTimeBox style="width:40%;">Supervisor</div>
					<div class=HTimeBox style="width:16.25%;" align="right";>Hours</div>
				</div>

				<%
				CurrentEmp=rs("EmpID")
				TotalEmp=0
			End If
			
			

			InH=rs("TimeInHr")
			InM=rs("TimeInMin")
			OutH=rs("TimeOutHr")
			OutM=rs("TimeOutMin")
			
			ClockIn=InH+(InM/60)
			ClockOut=OutH+(OutM/60)
			
			EmpTime=ClockOut-ClockIn
			If EmpTime<0 Then EmpTime=EmpTime+24
			
			TotalHours=TotalHours+EmpTime
			TotalEmp=TotalEmp+EmpTime
			%>
			<div class="TimeRow" id=Row<%=tNum%>>
				<div class="TimeBox" style="width:20%;">&nbsp;<%=rs("JobPhase")%></div>
				<div class="HourBox" style="width:20%;" align=center><%=rs("Date")%></div>
				<div class="TimeBox" style="width:40%;">&nbsp;<%=Supervisor%></div>
				<div class="HourBox" style="width:16.25%;">&nbsp;<%=Round(EmpTime,3)%></div>
			</div>			
			<%
			rs.MoveNext
		Loop
		%>
		<div class=TotalRow id=TotalRow<%=CurrentEmp%>>
			<div class=TimeBox style="width:80%; text-align:right;">Total for&nbsp;<b><%=Emp%></b>&nbsp;<br/><%=empWage%></div>
			<div class=HourBox style="width:16.25%; ">&nbsp;<%=Round(TotalEmp,3)%><br/><b>&nbsp;<big><%=formatCurrency(Wage*TotalEmp)%></big></b></div>
		</div>
		<%
	
	End If
%>
<script type="text/javascript">Gebi('HoursDiv').innerHTML='&nbsp;<%=Round(TotalHours,3)%>';</script>

</body>
</html>
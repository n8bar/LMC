<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Time Report</title>

<!--#include file="../TMC/RED.asp" -->
<script type="text/javascript" src="Modules/rcstri.js"></script>

<%
	
Dim EmpID
Dim ColName
Dim DESC_ASC
Dim XMLtext
Dim LoopNum	
Dim ListLen

TimeID= array()
TimeEmpID= array()
TimeFName= array()
TimeLName= array()
TimeDate= array()
TimeInHr= array()
TimeInMin= array()
TimeOutHr= array()
TimeOutMin= array()
TimeDesc= array()
TimeSup= array()
TimeJobName= array()
TimeJobID= array()
TimeJobPhase= array()
TimeJobType= array()
TimeArchStat= array()


Dim EmpTotals(2048,128)

EmpID = Request.QueryString("EmpID")
DateFrom = CStr(Request.QueryString("From"))
If DateFrom = "Earliest" Then DateFrom = "01/01/1900"
DateTo = CStr(Request.QueryString("To"))
If DateTo = "Latest" Then DateTo = "01/01/2040"


Dim TOut
Dim TIn
Dim Shift
Dim TH
Function TotalHours(EmpID,AreaID)'------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------------------
	TH=0
	'% ><!-- <br/>Dude, The AreaID passed to TotalHours() Is:<%=AreaID% ><br/> --><%
	THAreaID=AreaID
	
	SQL2="Select * From Time Where EmpID="&EmpID&" AND DATE BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
	Set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDConnString
	
	Do Until rs2.EOF
		
		If THAreaID <> 0 And THAreaID <> "" And rs2("JobType") <> "Other" Then
			Select Case rs2("JobType")
				
				Case "Project"
					If rs2("JobPhase")="Plan" Then
						ThisAreaID=0
					Else
						Set rs3=Server.CreateObject("ADODB.Recordset")
						SQL3="SELECT * FROM Projects WHERE ProjID="&rs2("JobID")
						rs3.Open SQL3, REDConnString
						
						If rs3.EOF Then ThisArea="[Unknown]" Else ThisArea=rs3("Area")
						
						Set rs3=Nothing

						
						Set rs3=Server.CreateObject("ADODB.Recordset")
						SQL3="SELECT * FROM Area WHERE AreaDescription='"&ThisArea&"'"
						rs3.Open SQL3, REDConnString
						'% >ThisArea.<%=ThisArea% ><%
						ThisAreaID=rs3("AreaID")
						
						Set rs3=Nothing
					
					End If
					
'				Case Else	' "Service" '3
'
'					Set rs3=Server.CreateObject("ADODB.Recordset")
'					SQL3="SELECT * FROM JobsLists WHERE NoteID="&rs2("JobID")
'					rs3.Open SQL3, REDConnString
'					
'					if rs3.EOF Then ThisArea="" Else ThisArea=rs3("Area")
'					
'					Set rs3=Nothing
'					
'					If IsNull(ThisArea) Or ThisArea="" Then
'						ThisAreaID=0
'					Else
'						Set rs3=Server.CreateObject("ADODB.Recordset")
'						SQL3="SELECT * FROM Area WHERE AreaDescription='"&ThisArea&"'"
'						% >ThisArea:< %=ThisArea% ><%
'						rs3.Open SQL3, REDConnString
'						ThisAreaID=rs3("AreaID")
'						
'						Set rs3=Nothing
'					End If
				'Case "Test"	'4
				
			End Select
			
		End If
		
		'If THAreaID=0 Or THAreaID=ThisAreaID Then
		If THAreaID=ThisAreaID Then
	'% ><!-- <br/>The AreaID passed to TotalHours() Is Now:<%=THAreaID% ><br/> --><%
			TOut= rs2("TimeOutHr")+(rs2("TimeOutMin")/60)
			TIn = rs2("TimeInHr")+(rs2("TimeInMin")/60)
			If TOut<TIn Then TOut=TOut+24 'If the clockout time is earlier than clockin, clockout is next day.
			
			Shift=TOut-TIn
					
			TH=TH+Shift
		End If
				
		rs2.MoveNext
	Loop
	
	TotalHours=Round(TH*100)/100
	'TotalHours=EmpID-1500
	
End Function'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	


Dim LastEmpHours
Function GetEmpHours(GetEmpHoursAreaID)'------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------------------
	If GetEmpHoursAreaID= 0 Or GetEmpHoursAreaID="" Or IsNull(GetEmpHoursAreaID) Then
		AreaDesc="Everywhere Else"
	Else
		Set rs4=Server.CreateObject("AdoDB.RecordSet")
		SQL4="SELECT * FROM Area WHERE AreaID="&GetEmpHoursAreaID
		rs4.Open SQL4, REDConnString
		AreaDesc=rs4("AreaDescription")
		Set rs4=Nothing
	End If

	Dim FirstRowStyle: FirstRowStyle="border-top:1px #000 solid;"
	Dim BClr: BClr="#FFF"
	Dim Bk: Bk="#FFF"
	
	HTML =""
	For Emps = 0 to uBound(ActiveEmps,2)
		ThisEmpID=ActiveEmps(0,Emps)
		TheseHours=TotalHours(ThisEmpID,GetEmpHoursAreaID)
		
		Emp1500=ThisEmpID-1500
		'% ><!-- <%=Emp1500% >..<%=GetEmpHoursAreaID% > &nbsp; --><%

		If GetEmpHoursAreaID=0 Then
			TheseHours=TheseHours-EmpTotals(Emp1500,36)
			TheseHours=TheseHours-EmpTotals(Emp1500,62)
			TheseHours=TheseHours-EmpTotals(Emp1500,27)
			TheseHours=TheseHours-EmpTotals(Emp1500,49)
			TheseHours=TheseHours-EmpTotals(Emp1500,9)
		End If
		EmpTotals(Emp1500,GetEmpHoursAreaID)=EmpTotals(Emp1500,GetEmpHoursAreaID)+TheseHours
		
		
		If TheseHours<>0 Then
			If BClr="#FFF" Then 
				BClr = "#EEE"
				Bk="-webkit-gradient(linear,left top,left bottom, color-stop(0,#EEEEEE), color-stop(.5,#FFFFFF), color-stop(1,#C0C0C0)); "
			Else
				BClr="#FFF"
				Bk="#FFF"
			End If
			
			HTML=HTML&"<div style='float:left; border:1px #000 solid; border-top:none; "&FirstRowStyle&" width:100%; background:"&Bk&"; background-color:"&BClr&"';>"
			HTML=HTML&	"<div class='TimeBox' style='min-width:75px; width:13%; border:none;'>"&ActiveEmps(0,Emps)&"</div>"
			HTML=HTML&	"<div class='TimeBox' style='min-width:360px; width:64.5%;'>"&"&nbsp;"&ActiveEmps(1,Emps)&"&nbsp;"&ActiveEmps(2,Emps)&"</div>"	
			HTML=HTML&	"<div class='TimeBox' style='min-width:112px; width:21%;' align=right>"&TheseHours&"</div>"	
			HTML=HTML&	"<br/>"	
			HTML=HTML&"</div>"	
			
		End If
		
		FirstRowStyle=""
	Next
	
	If HTML <>"" Then
		%>
	
		<div id=Area<%=GetEmpHoursAreaID%>Header style="width:100%; height:80px; overflow:hidden;">
			<h2 style="float:left; width:100%; margin:16px 0 8px 8px;"><%=AreaDesc%></h2>
			<div style="float:left; width:100%;">
				<div class="HTimeBox" style="min-width:75px; width:13%; border:none; "> &nbsp; Emp #</div>
				<div class="HTimeBox" style="min-width:360px; width:64.5%;"> &nbsp;&nbsp; Name</div>
				<div class="HTimeBox" style="min-width:112px; width:21%;" align="right";> &nbsp; Total Hours</div>
			</div>
		</div>
		<div id=Area<%=GetEmpHoursAreaID%>Data><%=HTML%></div>
		<br/>
		<br/>
		<br/>
		<br/>
		<%
	End If
	
End Function'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	
'	ListLen = 0
'
'	Where=""
'	SQL="SELECT * FROM Time "&Where&" ORDER BY "&ColName&" "&DESC_ASC&", TimeInHr DESC, TimeInMin DESC"
'	set rs=Server.CreateObject("ADODB.Recordset")
'	rs.Open SQL, REDconnstring
'
'

SQL1="SELECT * FROM Employees WHERE Active='True' ORDER BY FName"
set rs1=Server.CreateObject("ADODB.Recordset")
rs1.Open SQL1, REDconnstring

ActiveEmps=rs1.GetRows()

set rs1 = nothing
set dbconn=nothing
%>

<style type="text/css">

html{margin:0px; padding:0 0 16px 0; min-width:100%; width:100%; min-height:100%; height:100%;}
body{margin:0 0 16px 0; padding:0px; min-width:100%; width:100%; min-height:100%; height:100%;}

/*div{text-align:center;}*/

.TimeBox{
height:28px; min-height:28px; float:left; border-left:1px solid #000; font-family:Consolas, 'Courier New', Courier, monospace; font-size:24px; margin:0; padding:0;
}
.HTimeBox{
height:22px; min-height:20px; float:left; font-family:"Times New Roman", Times, serif; font-size:20px;
}


</style>



</head>
<body>

<div align="center"><big><b>Workers' Compensation Hours Report</b></big></div>
<div align="center"><big>For all active employees</big></div>
<div align="center">From:<%=DateFrom%> Through:<%=DateTo%></div>
<div align="center"><small>Report Date: <%=Date%></small></div>

<div style="float:left; clear:both; margin:0 0 18px 2%; width:96%;">
	<%
	GetEmpHours(36)	
	GetEmpHours(62)	
	GetEmpHours(27)	
	GetEmpHours(49)	
	GetEmpHours(9)	
	GetEmpHours(0)	
	%>
	
</div>
<br>&nbsp;

<% If Request.QueryString("SkipPrint") <> "1" Then %>
	<script type="text/javascript">	window.print();</script>
<% End If %>



</body>
</html>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Time Report</title>

<!--#include file="../TMC/RED.asp" -->

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


EmpID = Request.QueryString("EmpID")
DateFrom = CStr(Request.QueryString("From"))
If DateFrom = "Earliest" Then DateFrom = "01/01/1900"
DateTo = CStr(Request.QueryString("To"))
If DateTo = "Latest" Then DateTo = "01/01/2040"


Dim TOut
Dim TIn
Dim Shift
Dim TH
Dim Jobs()
Dim JobType()
Dim JobHours()
Dim JobsIndex
Function TotalHours(EmpID)'-------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------------------
	ReDim Jobs(256)
	ReDim JobType(256)
	ReDim JobHours(256)
	JobsIndex=0
	
	TH=0
	SQL2="Select * From Time Where EmpID="&EmpID&" AND DATE BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
	Set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDConnString
	
	Do Until rs2.EOF
		TOut= rs2("TimeOutHr")+(rs2("TimeOutMin")/60)
		TIn = rs2("TimeInHr")+(rs2("TimeInMin")/60)
		If TOut<TIn Then TOut=TOut+24 'If the clockout time is earlier than clockin, clockout is next day.
		
		Shift=TOut-TIn
		
		NewJob=True
		For j=0 to JobsIndex
			NameComp1=uCase(Jobs(j))
			NameComp2=uCase(DecodeChars(rs2("JobName")))
            If IsNull(NameComp2) Or NameComp2 = "" Then NameComp2="NONE"
            If IsNull(NameComp1) Or NameComp1 = "" Then NameComp1="NONE"

			Do Until oldNC1=NameComp1
				oldNC1=NameComp1
				NameComp1=Replace(Replace(Replace(Replace(Replace(Replace(Replace(NameComp1," ",""),".",""),"/",""),"-",""),",",""),"^",""),"'","")
			Loop
			
			Do Until oldNC2=NameComp2
				oldNC2=NameComp2
				NameComp2=Replace(Replace(Replace(Replace(Replace(Replace(Replace(NameComp2," ",""),".",""),"/",""),"-",""),",",""),"^",""),"'","")
			Loop

			If NameComp1=NameComp2 AND JobType(j)=rs2("JobType") Then
				
				NewJob=False
				
				JobHours(j)=JobHours(j)+Shift
								
				Exit For
			
			End If
		Next
		
		If NewJob Then
			JobsIndex=JobsIndex+1
			Jobs(JobsIndex)=DecodeChars(rs2("JobName"))
			JobType(JobsIndex)=rs2("JobType")
			JobHours(JobsIndex)=JobHours(JobsIndex)+Shift
		End If

		TH=TH+Shift
		rs2.MoveNext
	Loop
	
	
	TotalHours=Round(TH*100)/100
	'TotalHours=EmpID-1500
	
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

<style type="text/css" media="all">

html{margin:0px; padding:0 0 16px 0; min-width:100%; width:100%; min-height:100%; height:100%;}
body{margin:0 0 16px 0; padding:0px; min-width:100%; width:100%; min-height:100%; height:100%;}

/*div{text-align:center;}*/

.TimeBox{
height:18px; float:left; /*border-left:1px solid #000;*/ font-family:Consolas, 'Courier New', Courier, monospace; font-size:16px; margin:0; padding:0;
}
.HTimeBox{
height:22px; float:left; font-family:"Times New Roman", Times, serif; font-size:20px;
}


</style>



</head>
<body>

<div align="center"><big><b>Time Report</b></big></div>
<div align="center"><big>For all active employees</big></div>
<div align="center">From:<%=DateFrom%> Through:<%=DateTo%></div>
<div align="center"><small>Report Date: <%=Date%></small></div>

<div style="float:left; clear:both; margin:0 0 18px 2%; width:96%;">
	<div style="float:left; width:100%;">
	
		<div class="HTimeBox" style="width:13%; border:none; white-space:nowrap;"> &nbsp; Employee</div>
		<div class="HTimeBox" style="min-width:90px; width:16.125%;"> &nbsp;&nbsp; </div>
		<div class="HTimeBox" style="min-width:270px; width:48.375%;"> &nbsp;Job </div>
		<div class="HTimeBox" style="min-width:112px; width:21%;" align="right";> &nbsp; Hours</div>

	</div>
	<%
	Dim NoHoursList(1000)
	
	FirstRowStyle="border-top:1px #000 solid;"
	For Emps = 0 to uBound(ActiveEmps,2)
		
		EmpID=ActiveEmps(0,Emps)
		EmpTotalHours=TotalHours(EmpID)
		EmpName=ActiveEmps(1,Emps)&"&nbsp;"&ActiveEmps(2,Emps)
			
		If EmpTotalHours = 0 Then
			NHLI=NHLI+1
			NoHoursList(NHLI)=EmpName
		Else
		
			%>
			<div style="float:left; clear:left; border:1px #000 solid; border-top:none; <%=FirstRowStyle%> width:100%; ">
			
				<!--
				<div class="TimeBox" style="min-width:75px; width:13%; border:none;">
				< %=EmpID%>
				</div>
				
				<div class="TimeBox" style="min-width:360px; width:64.5%; ">
				&nbsp;< %=EmpName%>
				</div>
				
				<div class="TimeBox" style="min-width:112px; width:21%;" align="right">
				< %=TotalHours(EmpID)%>
				</div>
				
				<br/>
				-->
				<div class="TimeBox" style="width:100%; white-space:nowrap;"><b><%=EmpID%> : <%=EmpName%></b></div>
				
				<%
				If JobsIndex >0 Then
					
					
					BClr="#FFF"
					Bk="#FFF"
					For J = 1 to JobsIndex
						
						If BClr="#FFF" Then 
							BClr = "#EEE"
							Bk="-webkit-gradient(linear,left top,left bottom, color-stop(0,#EEEEEE), color-stop(.5,#FFFFFF), color-stop(1,#C0C0C0)); "
						Else
							BClr="#FFF"
							Bk="#FFF"
						End If
						
						JH=JobHours(J)
						JH=Split(Round(JobHours(J),2),".")(0)&"."&left(Split(Round(JobHours(J),2)&".0",".")(1)&"0",2)
						%>
						<div style="width:100%; height:18px; background:<%=Bk%>; background-color:<%=BClr%>; overflow:hidden;">
							<!--	<div class="TimeBox" style="width:29.125%; min-width:165px;">&nbsp;</div>	-->
							<div class="TimeBox" style="width:70%; margin:0 0 0 10%; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" id=Job<%=EmpID%>.<%=J%>><%=Jobs(J)%></div>
							<div class="TimeBox" style="width:10%; float:right;" align="right"><%=JH%></div>
						</div>
						<%
					Next 'J
					
					If BClr="#FFF" Then 
						BClr = "#EEE"
						Bk="-webkit-gradient(linear,left top,left bottom, color-stop(0,#EEEEEE), color-stop(.5,#FFFFFF), color-stop(1,#C0C0C0)); "
					Else
						BClr="#FFF"
						Bk="#FFF"
					End If
	
					ETH=EmpTotalHours
					ETH=Split(EmpTotalHours,".")(0)&"."&left(Split(EmpTotalHours&".0",".")(1)&"0",2)
					%>
					<div style="width:100%; height:18px; background:<%=Bk%>; background-color:<%=BClr%>; overflow:hidden;">
						<div class="TimeBox" style="width:48%; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" id=Total<%=EmpID%>>Total for <%=EmpName%></div>
						<div class="TimeBox" style="width:21%; float:right;" align="right"><b><%=ETH%></b></div>
					</div>
					<%
				End If
				%>
			</div>
			<hr/><br/><br/>
			<%
		End If
		'FirstRowStyle=""
	Next
	
	If NHLI>0 Then
		%>
		<br/>
		<h4 style="float:left; width:100%; text-align:left; margin-bottom:4px;">No Hours for:</h4>
		<div id=NHL>
		<%
			
		For n=1 to NHLI
			%><span><%=NoHoursList(n)%></span><br/><%
		Next
	%></div><%
	End If
	%>		
</div>

<% If Request.QueryString("SkipPrint") <> "1" Then %>
	<script type="text/javascript">	window.print();</script>
<% End If %>



</body>
</html>
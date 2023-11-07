<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>




<!--#include file="RED.asp" -->

<%
	'Dim XML
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
	
	XML = ""
	
	DESC_ASC = "ASC"

	Dim Where
	Dim Order
	
	Select Case EmpID
	
		Case 9999 'All employees
			'Where = "WHERE Archived='False' AND Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			Where = "WHERE Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			ColName = "EmpID"
			
			
		Case 1000 'Active employees
			'Where = "WHERE Archived='False' AND Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			Where = "WHERE Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			ColName = "EmpID"
			
		Case Else
			'Where = "WHERE Archived='False' AND EmpID="&EmpID&" AND Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			Where = "WHERE EmpID="&EmpID&" AND Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			ColName = "Date"
			
	End Select

	ListLen = 0

	SQL="SELECT * FROM Time "&Where&" ORDER BY "&ColName&" "&DESC_ASC&", TimeInHr DESC, TimeInMin DESC"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring


	LoopNum = 1	
	
	XMLtext = ""	
	
	
	Dim FirstDate,LastDate
	
	If Not rs.EOF then FirstDate = "<FirstDate>"&rs("Date")&"</FirstDate>"
	dim JobName
	Do While Not rs.EOF 
	
		SQL1="SELECT * FROM Employees WHERE EmpID="&rs("EmpID")
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring

		If Not rs1.EOF Then
			If rs1("Active")="True" Or EmpID<>1000 Then

				Redim TimeID(LoopNum)
				Redim TimeEmpID(LoopNum)
				Redim TimeFName(LoopNum)
				Redim TimeLName(LoopNum)
				Redim TimeDate(LoopNum)
				Redim TimeInHr(LoopNum)
				Redim TimeInMin(LoopNum)
				Redim TimeOutHr(LoopNum)
				Redim TimeOutMin(LoopNum)
				Redim TimeDesc(LoopNum)
				Redim TimeSup(LoopNum)
				Redim TimeJobName(LoopNum)
				Redim TimeJobID(LoopNum)
				Redim TimeJobPhase(LoopNum)
				Redim TimeJobType(LoopNum)
				Redim TimeArchStat(LoopNum)


				TimeID(LoopNum)=rs("TimeID")
				TimeEmpID(LoopNum)=rs("EmpID")
				TimeFName(LoopNum)=rs1("FName")
				TimeLName(LoopNum)=rs1("LName")
				TimeDate(LoopNum)=rs("Date")
				TimeInHr(LoopNum)=rs("TimeInHr")
				TimeInMin(LoopNum)=rs("TimeInMin")
				TimeOutHr(LoopNum)=rs("TimeOutHr")
				TimeOutMin(LoopNum)=rs("TimeOutMin")
				TimeDesc(LoopNum)=rs("Description")
				TimeSup(LoopNum)=rs("Supervisor")
				JobName = rs("JobName"): If JobName = "" or (IsNull(JobName)) then JobName = "--"
				TimeJobName(LoopNum)=JobName
				TimeJobID(LoopNum)=rs("JobID")
				TimeJobPhase(LoopNum)=rs("JobPhase")
				TimeJobType(LoopNum)=rs("JobType")
				TimeArchStat(LoopNum)=rs("Archived")
				
				LoopNum = LoopNum + 1	
				ListLen = ListLen + 1      
				
				LastDate = "<LastDate>"&rs("Date")&"</LastDate>"
			
			End If
		End If
		Set rs1 = nothing
		
		rs.MoveNext 
	Loop

	Dim ActiveEmpID
	Dim ActiveCount : ActiveCount=0
	SQL1="SELECT * FROM Employees WHERE Active='True' ORDER BY FName"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring

	Do Until rs1.EOF
		ActiveCount=ActiveCount+1
		ActiveEmpID=ActiveEmpID&"<ActiveEmpID"&ActiveCount&">"&rs1("EmpID")&"</ActiveEmpID"&ActiveCount&">"
		ActiveEmpID=ActiveEmpID&"<ActiveFName"&ActiveCount&">"&rs1("FName")&"</ActiveFName"&ActiveCount&">"
		ActiveEmpID=ActiveEmpID&"<ActiveLName"&ActiveCount&">"&rs1("LName")&"</ActiveLName"&ActiveCount&">"
		rs1.MoveNext
	Loop
	ActiveEmpID=ActiveEmpID&"<ActiveCount>"&ActiveCount&"</ActiveCount>"
	
	'XML = ("<root>"&XMLtext&"<ListLen>"&ListLen&"</ListLen><EmpID>"&EmpID&"</EmpID>"&FirstDate&LastDate&ActiveEmpID&"</root>")

	'response.ContentType = "text/xml"
	'response.Write(XML)

	set rs = nothing
	set dbconn=nothing
%>

<script type="text/javascript">
	var LoopNum=<%=LoopNum%>;
</script>
</head>
<body>

<script type="text/javascript">
var EmpTimeListLength='<%=EmpTimeListLength%>';
var EmpID = <%=EmpID%>;
var TimeNum = 1;			
var EmpTimeList = "";
var ListTotalHrs = 0;
var TotalHrs = new Array;
var EmpName = new Array;
var EmpIDArray = new Array;
var E = 0;
var LastEmpID;

var ActiveCount=<%=ActiveCount%>;
var TheEmpID;

var i;
for(i=1;i<=ActiveCount;i++)
{
	TheEmpID='<%=ActiveEmpID%>';
	EmpIDArray[i]=TheEmpID;
	TotalHrs[EmpIDArray[i]]=0;
	EmpName[EmpIDArray[i]]='<%=ActiveFName%>'+' '+'<%=ActiveLName%>'
}

for (i = 1; i <= EmpTimeListLength; i++)
{
	var sEmpTimeID = 'EmpTimeID'+TimeNum;
	var sEmpID = 'EmpID'+TimeNum;
	var sEmpTimeFName = 'EmpTimeFName'+TimeNum;
	var sEmpTimeLName = 'EmpTimeLName'+TimeNum;
	var sEmpTimeDate = 'EmpTimeDate'+TimeNum;
	var sEmpTimeInHr = 'EmpTimeInHr'+TimeNum;
	var sEmpTimeInMin = 'EmpTimeInMin'+TimeNum;
	var sEmpTimeOutHr = 'EmpTimeOutHr'+TimeNum;
	var sEmpTimeOutMin = 'EmpTimeOutMin'+TimeNum;
	var sEmpTimeDesc = 'EmpTimeDesc'+TimeNum;
	var sEmpTimeSup = 'EmpTimeSup'+TimeNum;
	var sEmpTimeJobName = 'EmpTimeJobName'+TimeNum;
	var sEmpTimeJobID = 'EmpTimeJobID'+TimeNum;
	var sEmpTimeJobPhase = 'EmpTimeJobPhase'+TimeNum;
	var sEmpTimeJobType = 'EmpTimeJobType'+TimeNum;
	var sEmpTimeArchStat = 'EmpTimeArchStat'+TimeNum;
	
	var EmpTimeID = xmlDoc.getElementsByTagName(sEmpTimeID)[0].childNodes[0].nodeValue;
	var ThisEmpID = xmlDoc.getElementsByTagName(sEmpID)[0].childNodes[0].nodeValue;
	var EmpTimeFName = xmlDoc.getElementsByTagName(sEmpTimeFName)[0].childNodes[0].nodeValue;					
	var EmpTimeLName = xmlDoc.getElementsByTagName(sEmpTimeLName)[0].childNodes[0].nodeValue;					
	var EmpTimeDate = xmlDoc.getElementsByTagName(sEmpTimeDate)[0].childNodes[0].nodeValue;					
	var EmpTimeInHr = xmlDoc.getElementsByTagName(sEmpTimeInHr)[0].childNodes[0].nodeValue;
	var EmpTimeInMin = xmlDoc.getElementsByTagName(sEmpTimeInMin)[0].childNodes[0].nodeValue;
	var EmpTimeOutHr = xmlDoc.getElementsByTagName(sEmpTimeOutHr)[0].childNodes[0].nodeValue;
	var EmpTimeOutMin = xmlDoc.getElementsByTagName(sEmpTimeOutMin)[0].childNodes[0].nodeValue;
	var EmpTimeDesc = xmlDoc.getElementsByTagName(sEmpTimeDesc)[0].childNodes[0].nodeValue.replace('--','');
	var EmpTimeJobName = xmlDoc.getElementsByTagName(sEmpTimeJobName)[0].childNodes[0].nodeValue;
	var EmpTimeSup = xmlDoc.getElementsByTagName(sEmpTimeSup)[0].childNodes[0].nodeValue.replace('--','');
	var EmpTimeJobID = xmlDoc.getElementsByTagName(sEmpTimeJobID)[0].childNodes[0].nodeValue;
	var EmpTimeJobPhase = xmlDoc.getElementsByTagName(sEmpTimeJobPhase)[0].childNodes[0].nodeValue.replace('--','');
	var EmpTimeJobType = xmlDoc.getElementsByTagName(sEmpTimeJobType)[0].childNodes[0].nodeValue.replace('--','');
	var EmpTimeArchStat = xmlDoc.getElementsByTagName(sEmpTimeArchStat)[0].childNodes[0].nodeValue;					
	var EmpTimeJobTypeValue = EmpTimeJobType;

	if(EmpTimeJobType == 1){EmpTimeJobType = "Project"};
	if(EmpTimeJobType == 2){EmpTimeJobType = "Service"};
	if(EmpTimeJobType == 3){EmpTimeJobType = "Test/Maint."};
	if(EmpTimeJobType == 4){EmpTimeJobType = "Other"};
	
	if(EmpTimeInMin <= 9){EmpTimeInMin = '0'+EmpTimeInMin};
	if(EmpTimeOutMin <= 9){EmpTimeOutMin = '0'+EmpTimeOutMin};
	
	var Time_in = (EmpTimeInHr+':'+EmpTimeInMin)
	var Time_out = (EmpTimeOutHr+':'+EmpTimeOutMin)
		
	var DecimalTime_In = ((EmpTimeInHr*1)+(EmpTimeInMin/60));
	var DecimalTime_Out = ((EmpTimeOutHr*1)+(EmpTimeOutMin/60));
	var EmployeeTotalHrs = (DecimalTime_Out - DecimalTime_In);
	ListTotalHrs += EmployeeTotalHrs
	//alert(DecimalTime_In);
	if(EmployeeTotalHrs<0){EmployeeTotalHrs+=24}
	EmployeeTotalHrs = EmployeeTotalHrs;
	
	
	var onClick='';
	var SuperName='<b>NONE</b>';
	var Emps = new Array;
	Emps = parent.EmployeeArray;
	var L = Emps.length;
	for(var EID=1; EID<L; EID++)
	{
		//alert(EID+' '+parent.EmployeeArray[EID][1]);
		if(Emps[EID][1]==EmpTimeSup)
		{
			//alert(EID+' '+Emps.length);
			SuperName=Emps[EID][2]+' ';
			SuperName+=Emps[EID][3];
		}
	}
	
	var EditBoxShow = "";
	var EditBoxNoShow = "none;";
	
	if(EmpTimeArchStat == "False"){EditBoxShow = 'block', EditBoxNoShow = 'none;'};
	if(EmpTimeArchStat == "True"){EditBoxShow = 'none', EditBoxNoShow = 'block;'};
	
	if(parent.accessTime=='True')
		{onClick='"EditEmpTime(value,^'+TimeNum+'^,^'+EmpTimeJobID+'^);"';}
	else
		{onClick='"alert(^Sorry, Time Editing is disabled.  Please notify your supervisor.^);"';}
	
	
	if(EmpID != 9999 && EmpID != 1000)
	{
		EmpTimeList +='<div class="EmployeeTimeList" id="EmpTimeList'+TimeNum+'" >';
		EmpTimeList +='<div class="EmployeeTimeDate" id="EmployeeTimeDate'+TimeNum+'">'+EmpTimeDate+'</div>';
		EmpTimeList +='<div class="EmployeeTimeTimeIn" id="EmployeeTimeTimeIn'+TimeNum+'">'+Time_in+'</div>';
		EmpTimeList +='<div class="EmployeeTimeTimeOut" id="EmployeeTimeTimeOut'+TimeNum+'">'+Time_out+'</div>';
		//alert(EmployeeTotalHrs);
		EmpTimeList +='<div class="EmployeeTimeTotalHrs" id="EmployeeTimeTotalHrs'+TimeNum+'" value="'+EmployeeTotalHrs+'">'+EmployeeTotalHrs+'</div>';
		EmpTimeList +='<div class="EmployeeTimeSup" id="EmployeeTimeSup'+TimeNum+'" value="'+EmpTimeSup+'">'+SuperName+'</div>';
		EmpTimeList +='<div class="EmployeeTimeJobName" id="EmployeeTimeJobName'+TimeNum+' title="'+EmpTimeJobName+'">'+EmpTimeJobName+'</div>';
		EmpTimeList +='<div class="EmployeeTimeJobPhase" id="EmployeeTimeJobPhase'+TimeNum+'">'+EmpTimeJobPhase+'</div>';
		EmpTimeList +='<div class="EmployeeTimeJobType" value="'+EmpTimeJobTypeValue+'" id="EmployeeTimeJobType'+TimeNum+'">'+EmpTimeJobType+'</div>';
		EmpTimeList +='<div class="EmployeeTimeDescription" id="EmployeeTimeDescription'+TimeNum+'" title="'+EmpTimeDesc+'">'+EmpTimeDesc+'</div>';
		EmpTimeList +='</div>';
	}
	
	if(EmpID==9999||EmpID==1000)
	{
		TotalHrs[ThisEmpID]=TotalHrs[ThisEmpID]+(EmployeeTotalHrs*1);
		EmpName[ThisEmpID]=EmpTimeFName+' '+EmpTimeLName;
		LastEmpID=ThisEmpID;
	}
	
	
	TimeNum++;

}

var PeriodFrom='<%=DateFrom%>';
var PeriodTo='<%=DateTo%>';

EmpTimeList='<big><b>';
	if(PeriodFrom==''){PeriodFrom='Earliest'}
	if(PeriodTo==''){PeriodTo='Latest'}
	if(EmpID==1000)
	{
		EmpTimeList+='<div align="left">Time report for: All active employees. </div>';
	}
	if(EmpID==9999)
	{
		EmpTimeList+='<divalign="left">Time report for: All employees. </div>';
	}
	if(EmpID!=1000&&EmpID!=9999)
	{
		EmpTimeList+='<div align="left">Time report for: '+EmpName[EmpID]+'. </div>';
	}
EmpTimeList+='</b></big>';
EmpTimeList+='<div align="left">  From: '+PeriodFrom+' through '+PeriodTo+'. </div>';


var DT= new Date;
var Mo=DT.getMonth()+1;
var Hour=DT.getHours();
var Min=DT.getMinutes();
if(Min<10){Min='0'+Min}
var AMPM='AM';
if(Hour >12){Hour -=12; AMPM='PM'}
EmpTimeList+='<div align="left">Locked and printed on'+(Mo)+'/'+DT.getDate()+'/'+DT.getFullYear()+'  at '+Hour+':'+Min+' '+AMPM+'<br/></div>';

var ThisTotal = Math.round(TotalHrs[EmpIDArray[1]]*100)/100;
EmpTimeList+='<div style="width:100%; font-size:28px; float:left; clear:both;">'
EmpTimeList+='<div style="width:37.5%; float:left; clear:left; border-right:none;">';
EmpTimeList+='	Total Hours For'
EmpTimeList+='</div>';
EmpTimeList+='<div style="width:43.7%; float:left; border:1px #000 solid; border-right:none; border-left:none;" align="left">';
EmpTimeList+=		EmpName[EmpIDArray[1]]+':';
EmpTimeList+='</div>';
EmpTimeList+='<div style="float:left; width:18.7%; border:1px #000 solid;" align="right">';
EmpTimeList+='	<b>'+ThisTotal+'</b></div>';
EmpTimeList+='</div><font style="font-size:31px"><br/></font>';

for(a=2;a<EmpIDArray.length;a++)
<% Dim a': For a= 2 to LoopNum 
a=a+1%>
{
	ThisTotal = Math.round(TotalHrs[EmpIDArray[a]]*100)/100;
	
	EmpTimeList+='<div style="font-size:28px; white-space:nowrap; border-bottom:1px #000 solid;">'
	EmpTimeList+='  <div style="white-space:nowrap;">';
	EmpTimeList+='    <div style="width:37.5%; float:left; border-left:1px #000 solid; border-bottom:1px #000 solid;">';
	EmpTimeList+='      Total Hours For'
	EmpTimeList+='    </div>';
	EmpTimeList+='    <div style="width:43.7%; float:left; border-bottom:1px #000 solid;" align="left">';
	//EmpTimeList+=       EmpName[EmpIDArray[a]]+':';
	EmpTimeList+=       '<%=TimeEmpID(a)%>:';
	EmpTimeList+='    </div>';
	EmpTimeList+='  </div>';
	EmpTimeList+='  <div style="float:left; width:18.7%; border:1px #000 solid; border-top:none; padding-top:1px;" align="right">';
	EmpTimeList+='    <b>'+ThisTotal+'</b></div>';
	EmpTimeList+='</div><font style="font-size:30px"><br/></font>';
}
<%' Next %>
EmpTimeList+='</div>';

while(EmpTimeList != EmpTimeList.replace('^','&#39;'))
{
	EmpTimeList = EmpTimeList.replace('^','&#39;');
}

document.body.innerHTML = EmpTimeList;
</script>


</body>
</html>

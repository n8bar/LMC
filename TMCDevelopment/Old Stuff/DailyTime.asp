<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Daily Time</title>

<!--#include file="../../TMC/RED.asp" -->

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>
<script type="text/javascript" src="DailyTimeAJAX.js"></script>

<style media="screen">
html{width:100%; height:100%; margin:0; padding:0; overflow-x:hidden; overflow-y:hidden; white-space:nowrap;}
body{width:100%; min-height:100%; height:auto; margin:0; padding:0; overflow:hidden;}

div,img,input,label,span,select{padding:0; margin:0; -webkit-box-sizing:border-box; -moz-box-sizing:border-box; border-radius:2px;}
input,select{border-width:0px; border-bottom:#000 1px solid; background:none;}

.Row{width:200%; height:.21in; border-top:1px #000 solid; overflow:hidden; position:relative; left:-1px; float:left; text-overflow:ellipsis; white-space:nowrap;}

.RowItem{float:left; display:inline; height:100%; border-left:#888 1px solid; border-right:#000 1px solid; border-bottom:#000 1px solid; border-radius:1px; -webkit-box-sizing:border-box;}

.DelBox{width:.32in; text-align:center;}
	.DelTime{position:relative; top:2px; cursor:pointer;}
.EmpNameDiv{display:none;}
.EmpName{width:1.54in;}
.SysDiv{display:none;}
.Sys{width:1.52in}
.PhaseDiv{display:none;}
.Phase{width:.73in;}
.WorkDiv{display:none;}
.Work{width:3.02in}
.TotalH{width:.42in; border:#000 0px solid; border-bottom:#000 1px solid; background-color:#FFFFFF;}

#New{font-size:16px;}
</style>

<style media="print">
html{width:100%; height:100%; margin:0; padding:0; overflow-x:hidden; overflow-y:hidden; white-space:nowrap;}
body{width:200%; min-height:100%; height:auto; margin:0; padding:0; overflow:hidden;}

div,img,input,label,span,select{padding:0; margin:0; -webkit-box-sizing:border-box; -moz-box-sizing:border-box; border-radius:2px;}
input,select{border-width:0px; border-bottom:#000 1px solid; background:none;}

.Row{width:200%; height:.21in; border-top:1px #000 solid; overflow:hidden; position:relative; left:-1px; float:left; text-overflow:ellipsis; white-space:nowrap;}

.RowItem{float:left; display:inline; height:100%; border-left:#888 1px solid; border-right:#000 1px solid; border-bottom:#000 1px solid; border-radius:1px; -webkit-box-sizing:border-box;}

.DelBox{width:.32in; text-align:center;}
	.DelTime{display:none;}
.EmpName{display:none;}
.EmpNameDiv{width:1.54in;}
.Sys{display:none;}
.SysDiv{width:1.52in}
.Phase{display:none;}
.PhaseDiv{width:.73in;}
.Work{width:3.02in}
.TotalH{width:.42in; border:#000 0px solid; border-right:#000 1px solid; border-bottom:#000 1px solid; background-color:#FFFFFF;}

#New{display:none;}
</style>

</head>

<body onLoad="">

<%
ProjID=Request.QueryString("ProjID")
ReportDate=Request.QueryString("Date")
ReportDate=CDate(ReportDate)

SQL0="SELECT * FROM Employees WHERE Active='True' AND NonHuman!='True'"
Set rsEmps=Server.CreateObject("AdoDB.RecordSet")
rsEmps.Open SQL0, REDConnString

Emps=rsEmps.GetRows()

Set rsEmps=Nothing


SQL1="SELECT * FROM Systems WHERE ProjectID="&ProjID'&" AND Obtained='True'"
%><%'=SQL1%><%
Set rsSys=Server.CreateObject("AdoDb.RecordSet")
rsSys.Open SQL1, REDConnString

If rsSys.EOF Then
	Dim Systems(6,0)
	Systems(6,0)="NONE"
	Systems(0,0)=0
	NoSystems=True
Else
	Systems=rsSys.GetRows()
	NoSystems=False
End If

Set rsSys=Nothing

ProjName="--"
Set rs2=Server.CreateObject("AdoDB.RecordSet")
SQL2="SELECT * FROM Projects WHERE ProjID="&ProjID
rs2.Open SQL2, REDConnString
ProjName=rs2("ProjName")


SQL="SELECT * FROM Time WHERE JobID="&ProjID&" AND Date='"&ReportDate&"'"
Set rs=Server.CreateObject("AdoDb.RecordSet")
rs.Open SQL, REDConnString

RowNum=0
Do Until rs.EOF
	RowNum=RowNum+1
	
	TimeID=rs("TimeID")
	%>
	
	<input id=TimeID<%=RowNum%> type="hidden" value="<%=TimeID%>" />
	<div id=Row<%=RowNum%> class=Row>
		
		<div id=DelBox<%=RowNum%> class="DelBox RowItem">
			<img class="DelTime" src="../images/delete_16.png" title="Delete"
			 onClick="SendSQL('Write','DELETE FROM Time WHERE TimeID=<%=TimeID%>'); window.location=window.location;"
			/>
			
		</div>
		
		<select id=EmpName<%=RowNum%> Class="EmpName RowItem"
		 onChange="SendSQL('Write','UPDATE Time SET EmpID='+SelI(this.id).value+' WHERE TimeID=<%=TimeID%>');
		 Gebi('EmpNameDiv<%=RowNum%>').innerHTML=SelI(this.id).value;"
		>
				<option value=1542 >Choose Employee</option>
		<%
			ThisEmp=""
			For e = 0 to uBound(Emps,2)
				EmpID=Emps(0,e)
				EmpName=Emps(1,e)&" "&Emps(2,e)
				
				If EmpID = rs("EmpID") Then
					Selected="Selected"
					ThisEmp=EmpName
				Else
					Selected=""
				End If
			%>
				<option value="<%=EmpID%>" <%=Selected%>><%=EmpName%></option>
			<%
			Next
		%>
		</select>
		<div id=EmpNameDiv<%=RowNum%> Class="EmpNameDiv RowItem" ><%=ThisEmp%></div>
		
		<%	If NoSystems Then Disabled="disabled" Else Disabled=""	%>
		<select id=Sys<%=RowNum%> class="Sys RowItem" <%=Disabled%>
		 onChange="SendSQL('Write','UPDATE Time SET JobSystemID='+SelI(this.id).value+' WHERE TimeID=<%=TimeID%>');
		 Gebi('SysDiv<%=RowNum%>').innerHTML=SelI(this.id).innerText;"
		>
			<option value=0 >Other</option>
		<%
			ThisSys="Other"
			For s = 0 to uBound(Systems,2)
				SystemID=Systems(0,s)
				SysName=Systems(6,s)
				
				If SystemID = rs("JobSystemID") Then
					Selected="Selected"
					ThisSys=SysName
				Else
					Selected=""
				End If
			%>
				<option value="<%=SystemID%>" <%=Selected%>><%=SysName%></option>
			<%
			Next
		%>
		</select>
		<div id=SysDiv<%=RowNum%> class="SysDiv RowItem" ><%=ThisSys%></div>
		
		<div id=PhaseDiv<%=RowNum%> class="PhaseDiv RowItem" ><%=rs("JobPhase")%></div>
		<select id=Phase<%=RowNum%> class="Phase RowItem"
		 onChange="SendSQL('Write','UPDATE Time SET JobPhase=\''+SelI(this.id).value+'\' WHERE TimeID=<%=TimeID%>');
		 Gebi('PhaseDiv<%=RowNum%>').innerHTML=SelI(this.id).value;"
		>
			<option value="N/A"     <%If rs("JobPhase")="N/A"      Then %><%="Selected"%><% End If%> >N/A</option>
			<option value="Plan"    <%If rs("JobPhase")="Plan"     Then %><%="Selected"%><% End If%> >Plans</option>
			<option value="UG"      <%If rs("JobPhase")="UG"       Then %><%="Selected"%><% End If%> >Underground</option>
			<option value="Rough in"<%If rs("JobPhase")="Rough in" Then %><%="Selected"%><% End If%> >Rough in</option>
			<option value="Trim"    <%If rs("JobPhase")="Trim"     Then %><%="Selected"%><% End If%> >Trim</option>
			<option value="Finish"  <%If rs("JobPhase")="Finish"   Then %><%="Selected"%><% End If%> >Finish</option>
		</select>
		
		
		<input id=Work<%=RowNum%> class="Work RowItem" value="<%=rs("Description")%>"
		 onChange="SendSQL('Write','UPDATE Time SET Description=\''+this.value+'\' WHERE TimeID=<%=TimeID%>');"
		/>
		
		<%
			InH=rs("TimeInHr")
			InM=rs("TimeInMin")
			OutH=rs("TimeOutHr")
			OutM=rs("TimeOutMin")
			
			ClockIn=InH+(InM/60)
			ClockOut=OutH+(OutM/60)
			
			TotalTime=ClockOut-ClockIn
			If TotalTime<0 Then TotalTime=TotalTime+24
			
			'TotalTime=Split(
		%>
		<input id=TotalH<%=RowNum%> class="TotalH RowItem" value="<%=TotalTime%>" onKeyUp="Unsaved(this.id);" onBlur="ChangeHrs(<%=TimeID%>,this);"/>
	</div>
	<br/>
	
	<%
	Response.Flush()
	rs.MoveNext
Loop

Set rs=Nothing
%>

<button id="New" onClick="NewTime('<%=ReportDate%>', <%=ProjID%>, '<%=ProjName%>');"><div class="vPadding3"></div><img id="imgPlus" src="../images/plus_16.png">New
</button>

</body>

</html>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd" >


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Mobile Time</title>


<script type="text/javascript" src="../tmcManagement/rcstri.js"></script>
<script type="text/javascript" src="TimeJS.js"></script>
<script type="text/javascript" src="TimeAJAX.js"></script>


<link rel="stylesheet" href="mobile.css" media="screen">
<link rel="stylesheet" href="TimeCSS.css" media="screen">
<link type="text/css" rel="stylesheet" href="../lmcManagement/dhtmlgoodies_calendar.css?random=20051112" media="screen">

<!-- # include file="../LMCMangement/RED.asp" -->
<!--  #include file="Common.asp"  -->

<%
EmpID=Session("EmpID")
If EmpID="" Then response.Redirect("../m")
%>
<script type="text/javascript">
function Gebi(ID){return document.getElementById(ID);}
var EmpID=<%=EmpID%>;
</script>

<style type="text/css">
body {
}
<%
For wh= 1 to 1024
	%>.w<%=wh%>{width:<%=wh%>px;}	.w<%=wh%>p{width:<%=wh%>%;}	.h<%=wh%>{height:<%=wh%>px;} .bR<%=wh%>{border-radius:<%=wh%>px;}
	<%
Next
%>

.EntryLabel {  font-size: 40px; }
#d8D, #d8M, #d8Y { height:48px; font-size: 40px; width:64px; }
#d8Y {width:128px;}

</style>
<meta name="viewport" content="width=600; user-scalable=0;" />

</head>
<body onResize="Resizer();" onload="Gebi('d8M').focus();" class="shade">
<h1>Mobile Time</h1>

<%
Days=""
for d=1 to 31
	Days=Days&"<option id=d"&d&" "&selected&" >"&right("0"&d,2)&"</option>"
next
Months=""
for m=1 to 12
	Months=Months&"<option id=m"&m&" "&selected&" >"&right("0"&m,2)&"</option>"
next
Years=""
for y=2023 to 2099
	Years=Years&"<option id=y"&y&" "&selected&" >"&y&"</option>"
next
%>
<script>
  function dates() {
		
	}
</script>
<div id="NewEntry" class="w100p h144 fL shade borderRaised bR8" >
	<h3 style="margin:0px; ">&nbsp;New Entry:</h3>
	<br/>
	
	<div class="fL w100p">
		<label class="w96 EntryLabel" for=d8M align=Left>
			Date: <select id=d8M onChange="//Gebi('d8D').focus();"><%=Months%></select>
			<b>/</b> <select id=d8D onChange="//Gebi('d8Y').focus();"><%=Days%></select>
			<b>/</b> <input id=d8Y onChange="//Gebi('InH').focus();" />
		</label>
		<label class="w48 EntryLabel" for=InH align="left">In</label>
		<div class="fL Arial12">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </div>
		<label class="w48 EntryLabel" for=OutH align="left">Out</label>
	</div>
	<div class="fL w100p">
		<div class="fL Arial12">&nbsp; &nbsp; </div>
		
		<input id=InH class="w20 h16 fL Arial12" onKeyUp="if(this.value.length>1||this.value>2)Gebi('InM').focus();" />
		<div class="w8 h16 fL Arial12">:</div>
		<input id=InM class="w20 h16 fL Arial12" onKeyUp="if(this.value.length>1||this.value>5)Gebi('OutH').focus();" />
		<div class="fL Arial12">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </div>
		<input id=OutH class="w20 h16 fL Arial12" onKeyUp="if(this.value.length>1||this.value>2)Gebi('OutM').focus();" />
		<div class="w8 h16 fL Arial12">:</div>
		<input id=OutM class="w20 h16 fL Arial12" />
	</div>
	<br/>
	<br/>
	<br/>
	<div class="fL w100p">
		<div class="fL Arial12">&nbsp; &nbsp; </div>
		<select id=selJobType class="w96 h18 fL Arial12"
		 onChange=
		  "
				Gebi('selProj').disabled=false;
				Gebi('selServ').disabled=false;
				Gebi('selTest').disabled=false;
		  	if(this.selectedIndex==0){
		  		Gebi('selProj').disabled=true;
					Gebi('selProj').selectedIndex=0;
		  		Gebi('selServ').disabled=true;
					Gebi('selServ').selectedIndex=0;
		  		Gebi('selTest').disabled=true;
					Gebi('selTest').selectedIndex=0;
		  	}	
		  	
				switch (this[this.selectedIndex].innerText)	{
		  		case 'Other'
						Gebi('selProj').style.display='none';
						Gebi('selServ').style.display='none';
						Gebi('selTest').style.display='none';
						Gebi('txtJob').style.display='block';
					break;
					
					case 'Project'
						Gebi('selProj').style.display='block';
						Gebi('selServ').style.display='none';
						Gebi('selTest').style.display='none';
						Gebi('txtJob').style.display='none';
					break;
					
					case 'Service'
						Gebi('selProj').style.display='none';
						Gebi('selServ').style.display='block';
						Gebi('selTest').style.display='none';
						Gebi('txtJob').style.display='none';
					break;
					
					case 'Test/Maint'
						Gebi('selProj').style.display='none';
						Gebi('selServ').style.display='none';
						Gebi('selTest').style.display='block';
						Gebi('txtJob').style.display='none';
					break;
		  	}
		  	
		  	
			"
		>
			<option>JobType:</option>
			<option>Project</option>
			<option>Service</option>
			<option>Test/Maint</option>
			<option>Other</option>
		</select>
		<div class="fL Arial12">&nbsp; &nbsp; </div>
		<input id=txtJob class="w160 h18 fL Arial12" style="display:none;" />
		<select id=selJob class="w160 h18 fL Arial12" disabled="True">
			<option>Select Project:</option>
			<%
			SQL="SELECT ProjID, ProjName FROM Projects WHERE Active='True' ORDER BY ProjName"
			%>
		</select>
		<select id=selServ class="w160 h18 fL Arial12" style="display:none;" disabled="True">
			<option>Select Job:</option>
		</select>
		<select id=selTest class="w160 h18 fL Arial12" style="display:none;" disabled="True">
			<option>Select Job:</option>
		</select>
	</div>
	<br/>
	<button>&nbsp; &nbsp; &nbsp; Save &nbsp; &nbsp; &nbsp;</button>
</div>


<br />
<br />
<h3 style="margin-bottom:0px; text-align:left">&nbsp;Recent Shifts:</h3>

<br />
<div id="Titles" class="Row h16 m12">
		<div id="cEdit" class="RowItem w12p">Edit</div>
		<div id="cDate" class="RowItem w24p" >Date</div>
		<!-- 
		<div id="cIn" class="RowItem w48" >In</div>
		<div id="cOut" class="RowItem w48" >Out</div>
		-->
		<div id="cShift" class="RowItem w16p" >Shift</div>
		<div id="cJob" class="RowItem w48p" >Job</div>
</div>


<%

Dim ColName
Dim DESC_ASC

ColName = "Date"
DESC_ASC = "DESC"


Dim etListLength
etListLength = 0

Dim MaxRecord
MaxRecord=128

Dim etID'(128)
Dim etDate'(128)
Dim etInHr'(128)
Dim etInMin'(128)
Dim etOutHr'(128)
Dim etOutMin'(128)
Dim etDesc'(128)
Dim etSup'(128)
Dim etJobName'(128)
Dim etJobID'(128)
Dim etJobPhase'(128)
Dim etJobType'(128)
Dim etArchStat'(128)

SQL = "SELECT * FROM Time Where EmpID = "&EmpID&" ORDER BY "&ColName&" "&DESC_ASC&", TimeInHr DESC, TimeInMin DESC"
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring

Dim tI
tI = 1	

Do Until rs.EOF 'Or tI>MaxRecord
	etID=rs("TimeID")
	etDate=rs("Date")
	etInHr=rs("TimeInHr")
	etInMin=rs("TimeInMin")
	etOutHr=rs("TimeOutHr")
	etOutMin=rs("TimeOutMin")
	etDesc=rs("Description")
	etJobName=rs("JobName")
	etJobID=rs("JobID")
	etJobPhase=rs("JobPhase")
	etJobType=rs("JobType")
	etArchStat=rs("Archived")
	
	SQL1="SELECT * FROM Employees WHERE EmpID="&rs("Supervisor")
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	etSup=rs1("FName")&" "&rs1("LName")
	
	Set rs1=Nothing


	%>


	<div id="Row<%=tI%>" class="Row m12">
	<%
	Select Case etArchStat
		Case "False"
			%><div id="Edit<%=tI%>" class="RowItem Edit w12p">Edit</div><%
		Case Else
			%><div id="Edit<%=tI%>" class="RowItem w12p" ><small>Locked</small></div><%
	End Select
		%>
		<div id="Date<%=tI%>" class="RowItem w24p" ><%=etDate%></div>
		<!--
		<div id="In< %=tI%>" class="RowItem w48" >< %=etInHr%>:< %=etInMin%></div>
		<div id="Out< %=tI%>" class="RowItem w48" >< %=etOutHr%>:< %=etOutMin%></div>
		-->
		<%
			Dim tIn : tIn=etInHr+(etInMin/60)
			Dim tOut : tOut=etOutHr+(etOutMin/60)
			Dim Shift : Shift=tOut-tIn
			If Shift<0 Then Shift=Shift+24
		%>
		<div id="Shift<%=tI%>" class="RowItem w16p" ><%=Round(Shift*100)/100%></div>
		<div id="Job<%=tI%>" class="RowItem w48p" ><%=etJobName%></div>

		<div id="Super<%=tI%>" class="RowItem w48p Arial12" style="float:left; clear:left;" ><small style="float:left;"><b>Approved: </b></small><%=etSup%></div>
		<div id="Desc<%=tI%>" class="RowItem w52p Arial12" style="float:left;" ><%=etDesc%></div>

	</div>
<%
	tI = tI + 1	
	
	response.Flush()
	rs.MoveNext
	if tI>5 Then Exit Do
Loop
%>




</body>
</html>




















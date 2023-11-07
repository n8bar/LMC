<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title>Project Schedule</title>

<!-- <script type="text/javascript" src="jQuery.js"></script> -->
<!-- <script type="text/javascript" src="gears_init.js"></script> -->
<script type="text/javascript" src="ProjMan.js"></script>
<script type="text/javascript" src="ProjManAJAX.js"></script>
<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>
<SCRIPT type="text/javascript" src="../Library/dhtmlgoodies_calendar.js?random=20060118"></script>
<!-- script type="text/javascript" src="https://wave-api.appspot.com/public/embed.js"></script> 
<script type="text/javascript" src="Library/WaveEmbed.js"></script>  -->
<!-- #include file="../../TMC/RED.asp" -->

<%
	Dim ProjID:
	ProjID= Request.QueryString("ProjID")
	
	If ProjID = "" or (isNull(ProjID)) then ProjID=8702
%>
<script type="text/javascript">
var ProjID=<%=ProjID%>; //Copy the ASP ProjID to a JS ProjID
</script>

<link rel="stylesheet" href="../Library/CSS_DEFAULTS.css" media="screen"/>
<link rel="stylesheet" href="ProjMan.css" media="screen"/>
<link type="text/css" rel="stylesheet" href="../Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">

</head>

<body style="height:100%; overflow-x:hidden; overflow-y:scroll;">
<div id="SchToolbar" style="width:100%;">
	<button id="BtnSchNew" onClick="NewSched();" class="NewInfoBoxButton" style="float:left; clear:left;">+</button>
</div>

<hr style="height:0px; padding:0px; border-bottom:none;" />

<%

	Dim DivStyle : DivStyle="width:144px; float:left; margin:0 0 0 6px; "
	Dim DateStyle : DateStyle="width:72px; float:left; margin:0 0 0 6px; "
	Dim labelStyle : labelStyle="float:left; width:100%; text-align:left;"
	Dim inputStyle : inputStyle="float:left; width:100%;"
	
	SQL4="SELECT * FROM Calendar WHERE TaskEventTable = 'Projects' AND TaskEventID = "&ProjID
	set rs4=Server.CreateObject("ADODB.Recordset")
	rs4.Open SQL4, REDconnstring
	
	Dim i : i =0
	Do Until rs4.EOF
		i=i+1
		Dim Title: Title=rs4("Title")
		Dim ID : ID=rs4("CalID")
		%><div id="Row<%=i%>" class="SchRow">
				
				<div style="width:auto; height:auto; float:left; clear:left;">
					<button id="BtnSchDel" onClick="DelSched(<%=ID%>);" title="Delete This Schedule." class="NewInfoBoxButton" style="float:left; clear:none; color:#C00; padding:0px;">
						<div style="position:relative; top:-3px;"><big><big>&times;</big></big></div>
					</button>
					<label for="SchTitle" style="<%=labelStyle%> width:auto; padding-top:1px;"><b> Title:</b></label>
					<input id="SchTitle" style="<%=inputStyle%> width:256px; border:none;" value="<%=Title%>" onChange="UpdateCal('Title', this.value,<%=ID%>)"/>
				</div>
				<div style="width:auto; height:auto; float:left; clear:right;">
					<label for="SchAttention" style="<%=labelStyle%> width:auto; margin:0 0 0 6px; padding-top:1px;">Attn:</label>
					<%    
					SQL5 = "SELECT * FROM Employees WHERE Active='True' ORDER BY FName" 
					set rs5=Server.CreateObject("ADODB.Recordset")
					rs5.Open SQL5, REDconnstring 
					%>
					<select id="SchAttention" style="<%=inputStyle%> width:auto;" onChange="UpdateCal('AttentionID', SelI(this.id).value,<%=rs4("CalID")%>); UpdateCal('Attention', SelI(this.id).innerText,<%=rs4("CalID")%>);">
						<option value="<%=rs4("AttentionID")%>"><%=rs4("Attention")%></option>
						<%Do While Not rs5.EOF%>
              <option value="<%= rs5("EmpID")%>"><%= rs5("Fname")&" "&rs5("Lname")%></option>
						<%   
							rs5.MoveNext
						Loop
						set rs5 = nothing
						%>
					</select> 
				</div>
				
				<div style="<%=DivStyle%> width:auto; height:24px; max-height:24px;">
					<label for="SchCrewNames" style="float:left; padding-top:1px;">Crew Names:</label>
					<textarea id="SchCrewNames" style="width:144px; height:56px; float:left;" onChange="UpdateCal('CrewNames', this.value,<%=ID%>)"><%=rs4("CrewNames")%></textarea>
				</div>
				
				<div style="<%=DateStyle%> clear:left;">
					<label for="SchDateFrom" style="<%=labelStyle%> width:auto;">From:</label>
					<img style="cursor:pointer; padding:0; clear:none; float:right;" onClick="displayCalendar('SchDateFrom','mm/dd/yyyy',this)" src="../Images/cal.gif">
					<input id="SchDateFrom" style="<%=inputStyle%>" value="<%=rs4("DateFrom")%>" onChange="UpdateCal('DateFrom', this.value,<%=rs4("CalID")%>)"/>
				</div>
				<div style="<%=DateStyle%>">
					<label for="SchDateTo" style="<%=labelStyle%> width:auto;">To:</label>
					<img style="cursor:pointer; padding:0; clear:none; float:right;" onClick="displayCalendar('SchDateFrom','mm/dd/yyyy',this)" src="../Images/cal.gif">
					<input id="SchDateTo" style="<%=inputStyle%>" value="<%=rs4("DateTo")%>" onChange="UpdateCal('DateTo', this.value,<%=rs4("CalID")%>)"/>
				</div>
				<div style="<%=DateStyle%>">
					<label for="SchTime" style="<%=labelStyle%>">Time:</label>
					<input id="SchTime" style="<%=inputStyle%>" value="<%=rs4("Time")%>" onKeyUp="CheckTime(event,this)" onChange="UpdateCal('Time', this.value,<%=ID%>)"/>
				</div>
				<div style="<%=DivStyle%>">
					<label for="SchNote" style="<%=labelStyle%>">Note:</label>
					<input id="SchNote" style="<%=inputStyle%>" value="<%=rs4("Note")%>" onChange="UpdateCal('Note', this.value,<%=rs4("CalID")%>)"/>
				</div>
				<div style="<%=DivStyle%>">
					<label for="SchPhase" style="<%=labelStyle%>">Phase:</label>
					<%    
					SQL5 = "select * from Phase" 
					set rs5=Server.CreateObject("ADODB.Recordset")
					rs5.Open SQL5, REDconnstring 
					%>
					<select id="SchPhase" style="<%=inputStyle%>" value="<%=rs4("Phase")%>" onChange="UpdateCal('PhaseID', SelI(this.id).value,<%=rs4("CalID")%>); UpdateCal('Phase', SelI(this.id).innerText,<%=rs4("CalID")%>);">
						<% Do While Not rs5.EOF%>

							<option value="<%=rs5("PhaseID")%>">
								<%=rs5("PhaseName")%>
							</option>
							<%   
							rs5.MoveNext
						Loop
						set rs5 = nothing
						%>
					</select>              
					
				</div>
				
				<%
				Dim DoneCheck
				If rs4("Done")="True" Then DoneCheck = "checked" else Donecheck=""
				%>
				
				<div style="float:Left">
					<label for="SchDone" style="">Done</label>
					<input id="SchDone" style="<%=inputStyle%>" type="checkbox" onChange="UpdateCal('Done', this.checked,<%=rs4("CalID")%>)" <%=DoneCheck%>/>
				</div>
				
			</div>
		<%
		rs4.MoveNext
	Loop
	set rs4=nothing
%>
</body>
</html>

<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html id="HTMLTag" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title>Job List</title>

<!-- <script type="text/javascript" src="jQuery.js"></script> -->
<!-- <script type="text/javascript" src="gears_init.js"></script> -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="Library/SimpleJobsJS.js"></script>
<script type="text/javascript" src="Library/SimpleJobsAJAX.js"></script>
<script type="text/javascript" src="Modules/rcstri.js"></script>
<script type="text/javascript" src="Library/SqlAjax.js"></script>
<script type="text/javascript" src="Library/dhtmlgoodies_calendar.js?random=20060118"></script>
<!-- script type="text/javascript" src="https://wave-api.appspot.com/public/embed.js"></script> 
<script type="text/javascript" src="Library/WaveEmbed.js"></script>  -->

<script type="text/javascript">
	var calFeedUrl = "https://www.google.com/calendar/feeds/<%=Session("userEmail")%>tricomlv.com_brn6cqc9naj3u6rvdotpiog8ec%40group.calendar.google.com/private/full";
	
	function onLoadJS(){ setTimeout(parent.JobsListOnLoadJS,500); parent.JobsListOnLoadJS=''; }	
</script>


<!-- #include file="../LMC/RED.asp" -->

<link rel="stylesheet" href="Library/CSS_DEFAULTS.css" media="screen"/>
<link rel="stylesheet" href="Library/SimpleJobsCSS.css" media="screen"/>
<link rel="stylesheet" href="Library/SimpleJobsCSS.css" media="print"/>
<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">
<style>
	html{
	height:100%;
	overflow:scroll;
	}
	body{
	height:auto;
	/*overflow-x:hidden; overflow-y:scroll; width:992px; height:auto; min-height:64px;*/
	}
</style>

</head>

<body onLoad="SelectRow(1); onLoadJS(); ListResize(); " onMouseMove="MouseMove(event); UpdateParentMouse();" onResize="ListResize();">

<div id="Plus" style="background:center url(../LMCManagement/images/TreePlus.gif) no-repeat; display:none;"></div>
<div id="Minus" style="background:center url(../LMCManagement/images/TreeMinus.gif) no-repeat; display:none;"></div>


<div id="ProgressMenu" class="Menu" >
<%
Dim ProgArr(6)

SQL0= "SELECT * FROM Progress"
Set rs0=Server.CreateObject("ADODB.Recordset")
rs0.Open SQL0, REDconnstring	

Dim P: P=0
Do Until rs0.EOF
	P=P+1
	ProgArr(P)=rs0("BGColor")
	%>
		<div class="MenuItem" onClick="SetProgress(<%=rs0("ProgID")%>,Gebi('Prog<%=P%>'))" onMouseOver="MenuMouse(this,'#39F','#FFF');" onMouseOut="MenuMouse(this,'#EEE','#000');">
			<div id="Prog<%=P%>"	class="InnerProg" style="background-color:#<%=rs0("BGColor")%>; color:#<%=rs0("TextColor")%>; float:left;"><%=rs0("BGText")%></div>
			<div id="Prog<%=P%>" style="float:left; color:inherit;"><%=rs0("Text")%></div>
		</div>
	<%
	rs0.MoveNext
Loop

Set rs0=Nothing

%>

	<div style="width:100%;" align="center";>
		<button onClick="Gebi('ProgressMenu').style.display='none';">Cancel</button>
	</div>
</div>

<div id="PriorityMenu" class="Menu" >
<%
SQL0= "SELECT * FROM Priority"
Set rs0=Server.CreateObject("ADODB.Recordset")
rs0.Open SQL0, REDconnstring	

Pri=0
Do Until rs0.EOF
	Pri=Pri+1
	%>
		<div class="MenuItem" onClick="SetPriority(<%=rs0("PriID")%>,Gebi('Pri<%=Pri%>'))" onMouseOver="MenuMouse(this,'#39F','#FFF');" onMouseOut="MenuMouse(this,'#EEE','#000');">
			<div id="Pri<%=Pri%>"	class="InnerPri" style="background-color:#<%=rs0("BGColor")%>; color:#<%=rs0("TextColor")%>; float:left;"><%=rs0("BGText")%></div>
			<div id="PriText<%=Pri%>" style="float:left; color:inherit;"><%=rs0("Text")%></div>
		</div>
	<%
	rs0.MoveNext
Loop

Set rs0=Nothing

%>
	<div style="width:100%;" align="center";>
		<button onClick="Gebi('PriorityMenu').style.display='none';">Cancel</button>
	</div>
</div>
<%

Dim Active: Active=Request.QueryString("Active")
Dim SortBy: SortBy=Request.QueryString("SortBy")
Dim TaskType: TaskType=Request.QueryString("TaskType")

If TaskType="" Or (IsNull(TaskType)) Then
	TaskType="0"
	SQLTask=""
Else
	SQLTask="AND Type="&TaskType
End If
	
If SortBy="" Or (IsNull(SortBy)) Then SortBy="Priority DESC"

Dim TreeNum(2)

TreeNum(1)=1
TreeNum(2)=1

Dim TreeNumI: TreeNumI=1

SQL="SELECT * FROM JobsLists WHERE Active='"&Active&"' "&SQLTask&" ORDER BY "&SortBy
Set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring	


Dim LoopNum, EmpLoopNum

LoopNum=0

Select Case TaskType
	
	Case 0 'No Job Type Specified
		Dark="CCC" 
			 
	Case 2 'General Notes
		Dark="FFB"
	
	Case 3 'Service
		Dark="E6E6FF"
	
	Case 4 'Test/Maint
		Dark="FFF2F2"
	
	Case 6 'Estimating / Sales
		Dark="EBF5E0"
	
	Case 7 'Purchasing
		Dark="E1FFFF"
	
	Case 8 'Shipping / Inventory
		Dark="FBF5EE"
	
	Case 9 'Office Management
		Dark="F3EFFC"
	
	Case 10 'Training
		Dark="F3FEFA"
	
	Case 11 'Personal
		Dark="F9E9FE"
	
	Case 12 'Website
		Dark="F9F5FA"
	
	Case 17 'Environ
		Dark="ECF4F0"
	
	Case Else
		Dark="EEE"
End Select

Light="FFFFFF"
AltBG=Dark
Do Until rs.EOF
	LoopNum=LoopNum+1
	if rs("Active")="True" Then Done="" Else Done = "checked"
	
	'Gebi('JobOverlayTxt').innerHTM.
	If AltBG =Dark Then AltBG=Light Else AltBG=Dark
	%>
	<div id="RowContainer<%=LoopNum%>" class="RowContainer" style="background:#<%=AltBG%>; " onClick="SelectRow(<%=LoopNum%>);">
	<% SelectedRow=""%>
<script type="text/javascript">parent.document.getElementById('JobOverlay').style.display='none';</script>
	
	<!--	
	<div id="itemRow<%=LoopNum%>" class="ItemRow" >
	-->
	
	<div id="NoteID<%=LoopNum%>" class="NoteID"><%=rs("NoteID")%></div>
	<div class="ItemPri" id="ItemPri<%=LoopNum%>">
		<%
			Dim Pri: Pri = rs("Priority")
			If (IsNull(Pri)) Or Pri="" Then Pri=0
			
			SQL1="SELECT * FROM Priority WHERE PriID="&Pri
			Set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring	
		%>
		
		<div id="InnerPri<%=LoopNum%>" class="InnerPri" style="background:#<%=rs1("BGColor")%>; color:#<%=rs1("TextColor")%>;" onClick="ShowPriMenu(this);" title="Set Priority">
			<%=rs1("BGText")%>
		</div>
		
		<%	
			Set rs1=Nothing
			
			SQL1="SELECT * FROM TreeList WHERE ParentID=0 AND JobTableID="&rs("NoteID")
			Set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring	
			
			
		%>
		
	</div>
	<div class="ItemSched" id="ItemSched<%=LoopNum%>">
		<div id="InnerSched<%=LoopNum%>" class="InnerSched" onClick="SelectRow(<%=LoopNum%>); ToCal(); /* parent.Schedule(<%=rs("NoteID")%>,'<%=DecodeChars(rs("Job"))%>','<%=rs("Date")%>','<%=rs("DateDue")%>',''); */" title="Schedule"></div>
	</div>
	
	<input id="Notes<%=LoopNum%>" type="hidden" value="<%=rs("Notes")%>" />
	
	<span class="ItemJob" id="ItemJob<%=LoopNum%>" onDblClick="PlusMinusToggle(Gebi('PlusMinus.1.<%=LoopNum%>'),<%=LoopNum%>);">
		<div id="PlusMinus.1.<%=LoopNum%>.0" class="PlusMinus" onClick="PlusMinusToggle(this,<%=LoopNum%>); SelectRow(<%=LoopNum%>);"></div>
		&nbsp;
		<input id="Checkbox.1.<%=LoopNum%>.0" style="float:left; margin-top:4px; width:5%;" type="checkbox" <%=Done%>
		 onClick="CheckJobs(this.checked, <%=rs("NoteID")%>, this); SelectRow(<%=LoopNum%>);" 
		 />
		<span id="JobName<%=LoopNum%>" class="JobName" onClick="SelectRow(<%=LoopNum%>); SelectTreeItem(this);"><%=DecodeChars(rs("Job"))%></span>
		
		<%
			
			If rs1.EOF Then %>
			<script type="text/javascript">
				Gebi('PlusMinus.1.<%=LoopNum%>.0').style.background='none';
				Gebi('PlusMinus.1.<%=LoopNum%>.0').style.cursor='default';
				
				//Gebi('InnerManage<%=LoopNum%>').style.background='none';
				//Gebi('InnerManage<%=LoopNum%>').style.cursor='default';
			</script>
			<% End If
						
			EmpLoopNum=0
			Do Until rs1.EOF
			
				If rs1.EOF Then
					EmpName="None"
					EmpEmail=""
				Else
					EmpID=rs1("EmpID")
					SQL2="SELECT * FROM Employees WHERE EmpID="&EmpID
					Set rs2=Server.CreateObject("ADODB.Recordset")
					rs2.Open SQL2, REDconnstring	
				
					EmpName=rs2("FName")&" "&rs2("LName")
					EmpEmail=rs2("Email")
				
					Set rs2=Nothing
				End If
			
				EmpLoopNum=EmpLoopNum+1
				EmpTreeListID=rs1("TreeListID")
				if rs1("Done")="True" Then Done="checked" Else Done = ""
		%>
				<br/>
				<div id="ItemEmp.2.<%=LoopNum%>.<%=EmpLoopNum%>.0" class="ItemJob" style="height:15px; overflow:hidden;">
				
				<div id="PlusMinus.2.<%=LoopNum%>.<%=EmpLoopNum%>.0.0" style="margin-left:16px; " class="PlusMinus" onClick="PlusMinusToggle(this,<%=LoopNum%>);"></div>
				<input id="Checkbox.2.<%=LoopNum%>.<%=EmpLoopNum%>.0.0" style="float:left; margin-top:4px" type="checkbox" <%=Done%>
				 onClick="CheckDone(this.checked, <%=EmpTreeListID%>)"
				 />
				<div id="EmpListName.2.<%=LoopNum%>.<%=EmpLoopNum%>.0.0"
				 style="float:left; cursor:default; font-weight:normal; font-size:16px; margin-bottom:2px;"
				 onClick="setTimeout('SelectTreeItem(Gebi(\'EmpListName.2.<%=LoopNum%>.<%=EmpLoopNum%>.0.0\'));',250);"
				 ><%=DecodeChars(EmpName)%></div>
				 
				<input id="TreeListID.2.<%=LoopNum%>.<%=EmpLoopNum%>.0.0" type="hidden" value="<%=EmpTreeListID%>"/>
				<input id="ParentID.2.<%=LoopNum%>.<%=EmpLoopNum%>.0.0" type="hidden" value="<%=rs1("ParentID")%>"/>
				<input id="EmpID.2.<%=LoopNum%>.<%=EmpLoopNum%>.0.0" type="hidden" value="<%=rs1("EmpID")%>"/>
				<input id="Notes.2.<%=LoopNum%>.<%=EmpLoopNum%>.0.0" type="hidden" value="<%=rs1("Notes")%>"/>
				<%
					SQL2="SELECT * FROM TreeList WHERE ParentID="&EmpTreeListID
					Set rs2=Server.CreateObject("ADODB.Recordset")
					rs2.Open SQL2, REDconnstring

					ListLoopNum=0
					Do Until rs2.EOF
						ListLoopNum=ListLoopNum+1
						ListTreeListID=rs2("TreeListID")
						if rs2("Done")="True" Then Done="checked" Else Done = ""
					%>
						<br/>
						<div id="ItemList.3.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>" class="ItemJob" style="height:25px; overflow:hidden;">
							
							<div id="PlusMinus.3.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>"
							 style="margin-left:24px;"
							 class="PlusMinus"
							 onClick="PlusMinusToggle(this,<%=LoopNum%>);">
							</div>
							<input id="Checkbox.3.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>" style="float:left; margin-top:4px" type="checkbox" <%=Done%>
							 onClick="CheckDone(this.checked, <%=ListTreeListID%>)"
							 />
							<div id="ListName.3.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>" style="font-size:16px;" onClick="setTimeout('SelectTreeItem(Gebi(\'ListName.3.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>\'));',250);"><%=DecodeChars(rs2("Name"))%></div>
							<input id="TreeListID.3.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>" type="hidden" value="<%=ListTreeListID%>"/>
							<input id="ParentID.3.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>" type="hidden" value="<%=rs2("ParentID")%>"/>
							<input id="EmpID.3.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>" type="hidden" value="<%=rs1("EmpID")%>"/>
							<input id="Notes.3.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>" type="hidden" value="<%=rs2("Notes")%>"/>
							<%
								SQL3="SELECT * FROM TreeList WHERE ParentID="&ListTreeListID
								Set rs3=Server.CreateObject("ADODB.Recordset")
								rs3.Open SQL3, REDconnstring
								
								ItemLoopNum=0
								Do Until rs3.EOF
									ItemLoopNum=ItemLoopNum+1
									ItemTreeListID=rs3("TreeListID")
									if rs3("Done")="True" Then Done="checked" Else Done = ""
							%>
								<div id="ListItem.4.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>.<%=ItemLoopNum%>" class="ItemJob" style="height:25px; float:left; clear:both;">
								<!--
									<div id="PlusMinus.4.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>.<%=ItemLoopNum%>"
									 style="margin-left:24px;"
									 class="PlusMinus"
									 onClick="PlusMinusToggle(this,<%=LoopNum%>);">
									</div>
								-->	
									<input id="Checkbox.4.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>.<%=ItemLoopNum%>"type="checkbox" <%=Done%>
									  style="float:left; margin-top:4px; margin-left:48px;"
									 onClick="CheckDone(this.checked, <%=ItemTreeListID%>)"
									 />
									<div id="ItemName.4.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>.<%=ItemLoopNum%>"
									 onClick="setTimeout('SelectTreeItem(Gebi(\'ItemName.4.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>.<%=ItemLoopNum%>\'));',250);" style="font-size:16px;"><%=DecodeChars(rs3("Name"))%></div>
									
									<input id="TreeListID.4.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>.<%=ItemLoopNum%>" type="hidden" value="<%=ItemTreeListID%>"/>
									<input id="ParentID.4.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>.<%=ItemLoopNum%>" type="hidden" value="<%=rs3("ParentID")%>"/>
									<input id="EmpID.4.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>.<%=ItemLoopNum%>" type="hidden" value="<%=rs1("EmpID")%>"/>
									<input id="Notes.4.<%=LoopNum%>.<%=EmpLoopNum%>.<%=ListLoopNum%>.<%=ItemLoopNum%>" type="hidden" value="<%=rs3("Notes")%>"/>
								<!--
								-->
								</div>
							<%
									rs3.MoveNext
								Loop
							%>
						
						</div>
					<%
						rs2.MoveNext
					Loop
					%>
					<%'=SQL2%>
			</div>
		<%
			Set rs2=Nothing
			
			TreeNum(TreeNumI)=TreeNum(TreeNumI)+1
			rs1.MoveNext
		Loop
		Set rs1=Nothing
		%>
	</span>
	<!--
	<input class="ItemCust" id="ItemCust< %=LoopNum%>" value="< %=rs("Cust")%>" 
	 onfocus="CustSearch(this);" onChange="LoadCustList(this); this.style.color='#D00';" onKeyUp="LoadCustList(this); this.style.color='#D00';"/>
	-->
	<div class="ItemProg" id="ItemProgPlans<%=LoopNum%>">
		<%
			Dim Prog: Prog = rs("Progress")
			If (IsNull(Prog)) Or Prog="" Then Prog=1
			
			SQL1="SELECT * FROM Progress WHERE ProgID="&Prog
			Set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring	
		%>
		<div id="InnerProg<%=LoopNum%>" class="InnerProg" style="background:#<%=rs1("BGColor")%>; color:#<%=rs1("TextColor")%>;" onClick="ShowProgMenu(this)"><%=rs1("BGText")%></div>
		 
		<%Set rs1=Nothing%>
	</div>
	
	
	<select id="SelAttn<%=LoopNum%>" class="ItemAttn" onChange="SendSQL('Write', 'UPDATE JobsLists SET Attn=\''+SelI(this.id).innerHTML+'\' WHERE NoteID=<%=rs("NoteID")%>');">
		<option id="SelAttn<%=LoopNum%>Emp0"><%=rs("Attn")%></option>
	<%
			SQL1="SELECT * FROM Employees WHERE Active=1 ORDER BY FName"
			Set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring	
			
			Do Until rs1.EOF
				EmpName=rs1("FName")&" "&rs1("LName")
			%>
				<option id="SelAttn<%=LoopNum%>Emp<%=rs1("EmpID")%>" ><%=EmpName%></option>
			<%
				
				rs1.MoveNext
			Loop
			set rs1= nothing
	%>
	</select>
	
	<input class="ItemDates" id="ItemDateStarted<%=LoopNum%>" value="<%=rs("Date")%>"
	 onFocus="parent.displayCalendar(this,'mm/dd/yyyy',this)"
	 onChange="SendSQL('Write','UPDATE JobsLists SET Date=\''+this.value+'\' WHERE NoteID=<%=rs("NoteID")%>')"
	 onBlur="SendSQL('Write','UPDATE JobsLists SET Date=\''+this.value+'\' WHERE NoteID=<%=rs("NoteID")%>')"
	/>
	
	<input class="ItemDates" id="ItemDateDue<%=LoopNum%>" value="<%=rs("DateDue")%>"
	 onFocus="parent.displayCalendar(this,'mm/dd/yyyy',this)"
	 onChange="SendSQL('Write','UPDATE JobsLists SET DateDue=\''+this.value+'\' WHERE NoteID=<%=rs("NoteID")%>')"
	 onBlur="SendSQL('Write','UPDATE JobsLists SET DateDue=\''+this.value+'\' WHERE NoteID=<%=rs("NoteID")%>')"
	/>
	 
	<input class="ItemDates" style="cursor:default;" id="ItemDateCompleted<%=LoopNum%>" value="<%=rs("DateCompleted")%>" readonly />

</div>

<%
	response.Flush()
	rs.MoveNext
Loop
%>
<!--
<div id="PlansColumn" class="ProgColumn" style=""></div>
<div id="UndergroundColumn" class="ProgColumn" style=""></div>
<div id="RoughInspColumn" class="ProgColumn" style=""></div>
<div id="TrimColumn" class="ProgColumn" style=""></div>
<div id="DoneColumn" class="ProgColumn" style=""></div>
-->



<div id="CSearchBox" ></div>
</body>
</html>

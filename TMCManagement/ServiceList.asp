<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title>Service List</title>
<!-- #include file="common.asp" -->


<script type="text/javascript" src="Service/ServiceList.js?noCache=0<%=loadStamp%>"></script>
<script type="text/javascript" src="Service/ServiceListAJAX.js?noCache=0<%=loadStamp%>"></script>

<link type="text/css" rel="stylesheet" href="Library/CSS_DEFAULTS.css?noCache=0<%=loadStamp%>" media="all"/>
<link type="text/css" rel="stylesheet" href="Library/ListsCommon.css?noCache=0<%=loadStamp%>" media="all"/>
<link type="text/css" rel="stylesheet" href="Service/ServiceList.css?noCache=0<%=loadStamp%>" media="all"/>
<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="all" />

</head>

<body onLoad="Resize(); " onResize="Resize();">

<div id=Loading align="center">
	<div id=LoadText style="margin:10% auto;">
		Loading<br/>
		<img src="../Images/roller.gif"/>
	</div>
</div>

<div id=listHead>
	<div id=listToolbar class=Toolbar onDblClick="Gebi('hiddenSQLRabbit').style.display='block';">
		<button id=delServices class=tButton0x24 onClick="delServices();" title="Delete Selected Projects" />
			<span><img src="../Images/delete.png" style="float:left; height:22px; width:22px;"/></span>
			<span style="float:left; font-size:15px; height:100%;">Delete&nbsp;</span>
		</button>
		<!--
		<div class="tSpacer1">&nbsp;</div>
		<button id="editServices" class="tButton0x24" onClick="editServices();" title="Edit multiple Services simultaneously." />
			<span><img src="../Images/pencil_16.png" style="float:left; height:22px; width:22px;"/></span>
			<span style="float:left; font-size:15px; height:100%;">&nbsp;Mass Edit&nbsp;</span>
		</button>
		-->
		<%
		ListMax=Session("ServiceListMax")
		if ListMax="" Then ListMax=64
		%>
		
		<label id=lLMax>
			&nbsp; &nbsp; &nbsp; &nbsp; Show
			<input id=lMax type="text" width=3 onKeyUp="return false;" value="<%=ListMax%>" onChange="sessionWrite('ServiceListMax',this.value);" />
			results &nbsp; &nbsp;
		</label>
		
		<select id=selShowServices onChange="selShowServices_Change(this);" style="">
			<option value="All" >All Jobs</option>
			<option value="Recent" selected>Recent Jobs</option>
			<option value="Open">Open Quotes</option>
			<option value="Closed">Closed Quotes</option>
			<option value="Lost">Declined Quotes</option>
			<option value="Active" >Active Jobs</option>
			<option value="Done">Completed Jobs</option>
		</select>
		<label for="selShowServices" style="float:right; margin:5px 0 0 0;">Show&nbsp;</label>
		<% If Session("ShownServices") <> "" Then
				%>
				<script type="text/javascript">
					Gebi('selShowServices').selectedIndex=<%=Session("ShownServices")%>;
					try { PGebi('sStatus').selectedIndex=<%=Session("ShownServices")%>; } catch(e) {}
				</script>
				<%
			End If 
		%>
	</div>
</div>
<%
sortColumn=lcase(Session("SortServices"))
if sortColumn="" Then sortColumn="JobName"
%>

<div id="ItemsHead" >        	
	<div id=HeadCheck class=HeadCheck align=left ><input id=selAll type="checkbox" onChange="" /></div >
	<div id=ID class=HeadNum align="left" onClick="sortCol('ID');" style="<%If sortColumn="ID" Then %>font-weight:bold; <% End If %>" >Job #</div >
	<div id=JobName class=HeadJob align="left" onClick="sortCol('JobName');" style="<%If sortColumn="JobName" Then %>font-weight:bold; <% End If %>" >Job</div >
	<div id=HeadCust class=HeadCust align="left" onClick="sortCol('Location');" style="<%If sortColumn="Location" Then %>font-weight:bold; <% End If %>" >Customer</div >
	<div id=HeadLoc class=HeadLoc align="left" onClick="sortCol('Location');" style="<%If sortColumn="Location" Then %>font-weight:bold; <% End If %>" >Location</div >
	<!-- 
	<div id=JobAddr class=HeadAddr align="left" onClick="sortCol('Address');" style="<%If sortColumn="address" Then %>font-weight:bold; <% End If %>" >Address</div >
	<div id=JobCity class=HeadCity align="left" onClick="sortCol('City');" style="<%If sortColumn="city" Then %>font-weight:bold; <% End If %>" >City</div >
	<div id=JobState class=HeadState align="left" onClick="sortCol('State');" style="<%If sortColumn="state" Then %>font-weight:bold; <% End If %>" >State</div >
	-->
	<div id=HeadProg class=HeadProg >Status</div>
	<div id=DateEnt class=HeadDates align="left" onClick="sortCol('DateEnt');" style="<%If sortColumn="dateent" Then %>font-weight:bold; <% End If %>" >Created</div >
	<div id=ServiceTotal class=HeadAmount align="right" onClick="sortCol('ServiceTotal');" style="<%If sortColumn="Servicetotal" Then %>font-weight:bold; <% End If %>" >Amount</div >
	<!-- script type="text/javascript">/*	Gebi('< %=sortColumn%>').style.fontWeight='bold';	*/</script -->
	
	<!--
	<div class="HeadPri" align="left">!</div >
	<div class="HeadSched" align="left"><img src="images/FolderOutline.png"/></div >
	<div class="HeadEdit" align="left"><img src="images/Pencil-gray16.png"/></div >

	<div class="HeadProg"><div id="HeadInfo"       class="HeadDone" title="Get Servicing Info">Get Info</div></div>
	<div class="HeadProg"><div id="HeadPlansSpecs" class="HeadDone" title="Get Plans & Specs">Plans<br/>Specs</div></div>
	<div class="HeadProg"><div id="HeadCustomers"  class="HeadDone" title="Add Customers">Cust List</div></div>
	<div class="HeadProg"><div id="HeadPrice"      class="HeadDone" title="Generate Price">Price</div></div>
	<div class="HeadProg"><div id="HeadSubmit"     class="HeadDone" title="Submit Service">Submit</div></div>
	<div class="HeadProg"><div id="HeadFollowUp"   class="HeadDone" title="Service Follow-Up">FollowUp</div></div>
	
	<div class="HeadDates" align="left">Due</div >
	<div class="HeadDates" align="left" style="width:auto;">&nbsp;Completed</div>
	-->
	
</div>


<script type="text/javascript">Gebi('Loading').style.display='block';</script>

<div id="List" onScroll="Gebi('statusPopup').style.display='none';" >
	<div id=statusPopup>
		<div class=smallRedXCircle onClick="Gebi('statusPopup').style.display='none';">X</div>
		<label id=cbsOpen><input id=cbStatusOpen type=checkbox onChange="setStatus('Open', this.checked);" />Open</label>&nbsp;
		<label id=cbsWon ><input id=cbStatusWon type=checkbox onChange="setStatus('Active', this.checked);" />Active</label>&nbsp;
		<label id=cbsLost><input id=cbStatusLost type=checkbox onChange="setStatus('Lost', this.checked);" />Declined</label>&nbsp;
		<label id=cbsDone><input id=cbStatusDone type=checkbox onChange="setStatus('Done', this.checked);" />Done</label>&nbsp;
	</div>
	
	<%
	Where=""
	
	If Session("ShownServices")="" Then
		'Where="(Obtained='False' OR Obtained IS NULL) AND (ServiceLost='False' OR ServiceLost IS NULL)"
		Session("ShownServices")=1
	End If
	Select Case CInt(Session("ShownServices"))
		Case 0 'All
			Where=""
			
		Case 1 'Recent
			rbSQL="SELECT ServiceID FROM RecentServices ORDER BY ID DESC"
			Set rbRS=Server.CreateObject("AdoDB.RecordSet")
			rbRS.Open rbSQL, REDConnString
			
			If Not rbRS.EOF Then
				Where=" ID="&rbRS("ID")
				rbRS.MoveNext
			End If
			Do Until rbRS.EOF
				Where=Where&" OR ID="&rbRS("ID")
				rbRS.MoveNext
			Loop
			
			If Session("SortServices")="" Then Session("SortServices")=searchOrder
			If Session("SortServices")="" Then Session("SortServices")="lastOpened DESC"
			
		Case 2 'Open Services
			Where="(Obtained='False' OR Obtained IS NULL) AND (ServiceLost='False' OR ServiceLost IS NULL)"
		
		Case 3 'Closed Services
			Where="Obtained='True' OR ServiceLost='True' "
		
		Case 4 'Won Services
			Where="Obtained='True'"
		
		Case 5 'Lost Services
			Where="ServiceLost='True' "
			
		Case Else 'Open Services (default)
			Where="(Obtained='False' OR Obtained IS NULL) AND (ServiceLost='False' OR ServiceLost IS NULL)"
	End Select
	%><%'=Session("ShownServices")&"<br/>"%><%
	%><%'=Where&"<br/>"%><%
	
	searchWhere=""
	searchOrder=""
	If Session("ServiceSearch")="1" Then
		If Where<>"" Then Where="("&Where&")"
		
		NameNumCity=Session("ServiceSearchJobName")
		Session("ServiceSearchJobName")=""
		If NameNumCity<>"" Then
			searchWhere=searchWhere&" (JobName Like'%"&NameNumCity&"%' Or City Like'%"&NameNumCity&"%' Or ID Like'%"&NameNumCity&"%') "
			searchOrder=" JobName, City"
			%><%'=searchWhere&"<br/>"%><%
		End If
		
		If Session("ServiceSearchState")<>"" Then
			if searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" State = '"&Session("ServiceSearchState")&"'"
			Session("ServiceSearchState")=""
			if searchOrder <> "" Then searchOrder=searchOrder&", "
			searchOrder=searchOrder&" State"
		End If
		
		If Session("ServiceSearchDateAfter")<>"" Then
			If searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" DateEnt > '"&Session("ServiceSearchDateAfter")&"'"
			Session("ServiceSearchDateAfter")=""
			If searchOrder <> "" Then searchOrder=", "&searchOrder
			searchOrder=" DateEnt"&searchOrder
		End If
		
		If Session("ServiceSearchDateBefore")<>"" Then
			If searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" DateEnt < '"&Session("ServiceSearchDateBefore")&"'"
			Session("ServiceSearchDateBefore")=""
			
			If inStr(searchOrder,"DateEnt")<1 Then
				If searchOrder <> "" Then searchOrder=", "&searchOrder
				searchOrder=" DateEnt"&searchOrder
			End If
		End If
		'Response.write("search:"&searchWhere&"<br/>")
		If Where <> "" AND searchWhere <> "" Then 
			Where=Where& " AND "&searchWhere
		Else
			If searchWhere <>"" Then Where=SearchWhere
		End If
		Session("ServiceSearch")=""
	End If
	
	If Where<>""Then Where="WHERE "&Where
	
	If Session("SortServices")="" Then Session("SortServices")=searchOrder
	If Session("SortServices")="" Then Session("SortServices")="JobName"
	SortBy=Session("SortServices")
	%><script>var sortBy="<%=SortBy%>";</script><%
	%><%'=SortBy%><%
	Session("SortServices")=""
	
	Dim TreeNum(2)
	
	TreeNum(1)=1
	TreeNum(2)=1
	
	Dim TreeNumI: TreeNumI=1
	
	Fieldz="ID, CustAgreed, CustDeclined, JobName, Address, City, State, DateEnt, Total, Active, CustID"
	SQL="SELECT TOP "&ListMax&" "&Fieldz&" FROM Services "&Where&" ORDER BY "&SortBy
	%><div id=hiddenSQLRabbit style="width:100%; display:none;"><%=searchWhere&"<br/>"&SQL%></div><%
	
	Set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	FirstProj=Session("ServiceListStart")
	
	LoopNum=0
	%>
	<div id="RowContainerContainer" style="width:1024px; height:auto;">
		<%
		Do Until rs.EOF
			LoopNum=LoopNum+1
			
			bLost=(rs("CustDeclined")="True")
			bWon=(rs("CustAgreed")="True")
			bOpen= Not (bLost XOr bWon)
			bDone=bWon And (rs("Active")="False")
			If bWon Then bWon=1 Else bWon=0
			If bLost Then bLost=1 Else bLost=0
			If bDone Then bDone=1 Else bDone=0
			bCheck="&nbsp;"
			If bDone Then bCheck="✔"
				
			if rs("CustAgreed")="True" Then Done="checked" Else Done = ""
			
			'rowSty="background-image:-moz-linear-gradient(90deg bottom left, rgba(112,168,56,.0625), rgba(112,168,56,.0625)); " 
			rowSty="color:#44A;" 
			if bDone or bLost Then rowSty=" text-decoration:line-through !important; color:#999 !important;"
			
			%>
			<div id=RowContainer<%=LoopNum%> class=RowContainer style="<%=rowSty%>">
			<% SelectedRow=""%>		
			<div id="check<%=LoopNum%>" class="ItemCheck"><input id=sel<%=LoopNum%> class="ItemCheckBox" type="checkbox" /></div>
			<div id="ID<%=LoopNum%>" class="ID" style="<%=rowSty%>" ><%=rs("ID")%></div>
			<%	
			ID=rs("ID")
			JobName=DecodeChars(rs("JobName"))
			If instr(JobName," - ") Then JobName=split(JobName," - ")(0)
			d8from=rs("DateEnt")
			StartDate=rs("DateEnt")
			if StartDate="1/1/1900" Then StartDate=""
			%>
			
			<div id=ItemJob<%=LoopNum%> class=ItemJob style="<%=rowSty%>">
				<a id="JobName<%=LoopNum%>" class="JobName" href="ServiceJob.asp?id=<%=ID%>" target="_parent" onMouseDown="sessionWrite('ShownServices',Gebi('selShowServices').selectedIndex);" style="<%=rowSty%>"><%=JobName%></a>
			</div>
			<%
			if isNull(rs("custId")) or rs("custID")="" Then custID=0 Else custId=rs("CustID")
			custSQL="SELECT Name FROM Contacts WHERE ID="&custID
			%><div style="display:none;"><%=custSQL%></div><%
			Set custRS=Server.CreateObject("AdoDB.RecordSet")
			custRS.open custSQL, REDConnString
			if custRS.EOF Then Customer="NONE" Else Customer=DecodeChars(custRS("Name"))
			
			Address=DecodeChars(rs("Address")) : If Address="" Then Address="&nbsp;──"
			City=DecodeChars(rs("City")) : If City="" Then City="&nbsp;──"
			%>
			<div id="ItemCust<%=LoopNum%>" class="ItemCust" style="<%=rowSty%>" ><%=Customer%></div>
			<div id="ItemLoc<%=LoopNum%>" class="ItemLoc" style="<%=rowSty%>" ><%=Address&", "&City&", "&rs("State")%></div>
			<!--
			<div id="ItemAddr<%=LoopNum%>" class="ItemAddr" style="<%=rowSty%>" ><%=DecodeChars(rs("Address"))%></div>
			<div id="ItemCity<%=LoopNum%>" class="ItemCity" style="<%=rowSty%>" ><%=DecodeChars(rs("City"))%></div>
			<div id="ItemState<%=LoopNum%>" class="ItemState" style="<%=rowSty%>" ><%=rs("State")%></div>
			-->
			<%
	
			'sColor="#888"
			'sBColor="rgba(128,128,128,1)"
			'sBColor2="rgba(128,128,128,.75)"
			'sBColor3="rgba(128,128,128,.25)"
			cssClass="statusOpen"
			If bLost Then 
				cssClass="statusLost"
				'sColor="#c00"
				'sBColor="rgba(192,0,0,1)"
				'sBColor2="rgba(192,0,0,.75)"
				'sBColor3="rgba(192,0,0,.25)"
			End If
			If bWon Then 
				cssClass="statusWon"
				'sColor="#0c0"
				'sBColor="rgba(0,192,0,1)"
				'sBColor2="rgba(0,192,0,.75)"
				'sBColor3="rgba(0,192,0,.25)"
				If bDone Then cssClass="statusDone"
			End If
			
			
			%>
			<div class=ItemProg id=ItemProgServiceLost<%=LoopNum%> >
				<div class=<%=cssClass%> style="color:#070; font-size:20px; line-height:8px;" onClick="showStatusPopup(<%=ID%>, this, <%=bLost%>,<%=bWon%>,<%=bDone%>);"><%=bCheck%></div>
			</div>
			<%	
			StartDate=split(rs("DateEnt"),"/")
			StartM=StartDate(0)
			StartD=StartDate(1)
			StartY=split(StartDate(2)," ")(0)
			StartDate=StartM&"/"&StartD&"/"&StartY
			if StartDate="1/1/1900" Then StartDate=""			'DueDate=rs("ServicingDueDate")
			if DueDate="1/1/1900" Then DueDate=""			'DoneDate=rs("ServicingCompletedDate")
			if DoneDate="1/1/1900" Then DoneDate=""
			
			ServiceTotal=rs("Total")
			If IsNull(ServiceTotal) Or ServiceTotal="" Then ServiceTotal=0
			%>
			<div class=ItemDates id=ItemDateStarted<%=LoopNum%> style="<%=rowSty%>" ><%=StartDate%></div>
			
			<div class=ItemAmount id=ItemAmount<%=LoopNum%> style="<%=rowSty%>" ><%=formatCurrency(ServiceTotal)%></div>
			 
		</div>
		<%
			'response.Flush()
			rs.MoveNext
			if rs.EOF Then  Session("ServiceListStart")="" Else Session("ServiceListStart")=LoopNum+1
		Loop
		Refine1=""
		Refine2=""
		If LoopNum>=ListMax Then
			Refine1="Maximum of "
			Refine2="reached.  Please refine your search."
		End If
	%>
	</div>

	<div style="width:100%;">&nbsp; &nbsp; &nbsp;<%=Refine1%><%=LoopNum%> results <%=Refine2%></div>
	<script type="text/javascript">Gebi('Loading').style.display='none';</script>
</div>
<!--
<div id="ServicingColumn" class="ProgColumn" style=""></div>
<div id="UndergroundColumn" class="ProgColumn" style=""></div>
<div id="RoughInspColumn" class="ProgColumn" style=""></div>
<div id="TrimColumn" class="ProgColumn" style=""></div>
<div id="DoneColumn" class="ProgColumn" style=""></div>
-->
</body>
</html>

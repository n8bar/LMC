<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title>Project List</title>
<!-- #include file="Common.asp" -->

<script type="text/javascript" src="Project/ProjectList.js?nocache=<%=timer%>"></script>
<script type="text/javascript" src="Project/ProjectListAJAX.js?nocache=<%=timer%>"></script>

<link type="text/css" rel="stylesheet" href="Library/CSS_DEFAULTS.css" media="all"/>
<link type="text/css" rel="stylesheet" href="Library/ListsCommon.css?nocache=<%=timer%>" media="all"/>
<link type="text/css" rel="stylesheet" href="Project/ProjectList.css?nocache=<%=timer%>" media="all"/>
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
		<%'=Session("ShownProjects")%>
		<!--
		<button id=delBids class=tButton0x24 onClick="delBids();" title="Delete Selected Projects" />
			<span><img src="../Images/delete.png" style="float:left; height:22px; width:22px;"/></span>
			<span style="float:left; font-size:15px; height:100%;">Delete&nbsp;</span>
		</button>
		<div class="tSpacer1">&nbsp;</div>
		<button id="editBids" class="tButton0x24" onClick="editBids();" title="Edit multiple bids simultaneously." />
			<span><img src="../Images/pencil_16.png" style="float:left; height:22px; width:22px;"/></span>
			<span style="float:left; font-size:15px; height:100%;">&nbsp;Mass Edit&nbsp;</span>
		</button>
		-->
		<%
		ListMax=Session("ProjListMax")
		if ListMax="" Then ListMax=64
		%>

		<label id=lLMax>
			&nbsp; &nbsp; &nbsp; &nbsp; Show
			<input id=lMax type="text" width=3 onKeyUp="return false;" value="<%=ListMax%>" onChange="sessionWrite('ProjListMax',this.value);" />
			results &nbsp; &nbsp;
		</label>
		
		<select id=selShowBids onChange="selShowBids_Change(this);" style="">
			
			<option value="All">All Projects</option>
			
			<option value="Open" selected>Open Projects</option>
			
			<option value="Closed">Closed Projects</option>
		</select>
		<label for="selShowBids" style="float:right; margin:5px 0 0 0;">Show<%'=Session("ShownProjects")%>&nbsp;</label>
		<% If Session("ShownProjects") <> "" Then
				%>
				<script type="text/javascript">
					Gebi('selShowBids').selectedIndex=<%=Session("ShownProjects")%>;
					try { PGebi('sStatus').selectedIndex=<%=Session("ShownProjects")%>; } catch(e) {}
				</script>
				<%
			End If
		%>
	</div>
</div>

	<%
	sortColumn=lCase(Session("SortProjects"))
	if sortColumn="" Then sortColumn="projname"
	%>

<div id="ItemsHead" style="" >        	
	<!-- <div class="HeadCheck" align="left"><input id=selAll type="checkbox" onChange="" /></div > -->
	<div class=HeadNum align="left" onClick="sortCol('ProjID');" style="<%If sortColumn="projid" Then %>font-weight:bold; <% End If %>" >Project #</div >
	<div class=HeadJob align="left" onClick="sortCol('ProjName');"  style="<%If sortColumn="projname" Then %>font-weight:bold; <% End If %>" >Project</div >
	<div class=HeadCity align="left" onClick="sortCol('ProjCity');" style="<%If sortColumn="projcity" Then %>font-weight:bold; <% End If %>">City</div >
	<div class=HeadState align="left" onClick="sortCol('ProjState');" style="<%If sortColumn="projstate" Then %>font-weight:bold; <% End If %>">State</div >
	<div class=HeadProg>Status</div>
	<div class=HeadDates align="left" onClick="sortCol('DateStarted');" style="<%If sortColumn="datestarted" Then %>font-weight:bold; <% End If %>">Obtained</div >
	<div class=HeadPM align="right" onClick="sortCol('RCSPM');" style="<%If sortColumn="rcspm" Then %>font-weight:bold; <% End If %>" >Project Manager</div >
	<!--
	<div class="HeadPri" align="left">!</div >
	<div class="HeadSched" align="left"><img src="images/FolderOutline.png"/></div >
	<div class="HeadEdit" align="left"><img src="images/Pencil-gray16.png"/></div >

	<div class="HeadProg"><div id="HeadInfo"       class="HeadDone" title="Get Bidding Info">Get Info</div></div>
	<div class="HeadProg"><div id="HeadPlansSpecs" class="HeadDone" title="Get Plans & Specs">Plans<br/>Specs</div></div>
	<div class="HeadProg"><div id="HeadCustomers"  class="HeadDone" title="Add Customers">Cust List</div></div>
	<div class="HeadProg"><div id="HeadPrice"      class="HeadDone" title="Generate Price">Price</div></div>
	<div class="HeadProg"><div id="HeadSubmit"     class="HeadDone" title="Submit Bid">Submit</div></div>
	<div class="HeadProg"><div id="HeadFollowUp"   class="HeadDone" title="Bid Follow-Up">FollowUp</div></div>
	
	<div class="HeadDates" align="left">Due</div >
	<div class="HeadDates" align="left" style="width:auto;">&nbsp;Completed</div>
	
	
	-->
	
</div>


<script type="text/javascript">Gebi('Loading').style.display='block';</script>

<div id="List" onScroll="Gebi('statusPopup').style.display='none';" >
	<div id=statusPopup>
		<label><input id=cbStatusOpen type=checkbox onChange="setStatus('Open', this.checked);"/>Open</label>&nbsp;
		<label><input id=cbStatusClosed type=checkbox onChange="setStatus('Closed', this.checked);"/>Closed</label>&nbsp;
		<!-- <label><input id=cbStatusLost type=checkbox onChange="setStatus('Lost', this.checked);"/>Lost</label>&nbsp; -->
		<div class=smallRedXCircle onClick="Gebi('statusPopup').style.display='none';">X</div>
	</div>

	<%
	Where=""
	
	If Session("ShownProjects")="" Then
		'Where="Obtained='True' AND Active='True' "
		Session("ShownProjects")=1
	End If
	Select Case CInt(Session("ShownProjects"))
		Case 0 'All
			Where="Obtained='True'"
			
		Case 1 'Open Projects
			Where="Obtained='True' AND Active='True'"
		
		Case 2 'Closed Projects
			Where="Obtained='True' AND (Active='False' OR Active IS NULL) "
			
		Case Else 'Open Projects  (default)
			Where="Obtained='True' AND Active='True'"
	End Select


	
	searchWhere=""
	searchOrder=""
	If Session("ProjSearch")="1" Then
		If Where<>"" Then Where="("&Where&")"
		
		NameNumCity=Session("ProjSearchName")
		Session("ProjSearchName")=""
		If NameNumCity<>"" Then
			searchWhere=searchWhere&" (ProjName Like'%"&NameNumCity&"%' Or ProjCity Like'%"&NameNumCity&"%' Or ProjID Like'%"&NameNumCity&"%') "
			searchOrder=" ProjName, ProjCity"
			%><%'=searchWhere%><br/><%
		End If
		
		If Session("ProjSearchState")<>"" Then
			if searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" ProjState = '"&Session("BidSearchProjState")&"'"
			Session("ProjSearchState")=""
			if searchOrder <> "" Then searchOrder=searchOrder&", "
			searchOrder=searchOrder&" ProjState"
		End If
		
		If Session("ProjSearchDateAfter")<>"" Then
			If searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" DateStarted > '"&Session("BidSearchDateAfter")&"'"
			Session("ProjSearchDateAfter")=""
			If searchOrder <> "" Then searchOrder=", "&searchOrder
			searchOrder=" DateStarted"&searchOrder
		End If
		
		If Session("ProjSearchDateBefore")<>"" Then
			If searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" DateStarted < '"&Session("BidSearchDateBefore")&"'"
			Session("ProjSearchDateBefore")=""
			
			If inStr(searchOrder,"DateStarted")<1 Then
				If searchOrder <> "" Then searchOrder=", "&searchOrder
				searchOrder=" DateStarted"&searchOrder
			End If
		End If
		'Response.write("search:"&searchWhere)
		If Where <> "" AND searchWhere <> "" Then Where=Where& " AND "&searchWhere
		Session("ProjSearch")=""
	End If

	If Where<>""Then Where="WHERE "&Where

	If Session("SortProjects")="" Then Session("SortProjects")=searchOrder
	If Session("SortProjects")="" Then Session("SortProjects")="ProjName"
	SortBy=Session("SortProjects")
	%><script>var sortBy="<%=SortBy%>";</script><%
	%><%'=SortBy%><%
	Session("SortProjects")=""
	
	
	Dim TreeNum(2)
	
	TreeNum(1)=1
	TreeNum(2)=1
	
	Dim TreeNumI: TreeNumI=1
	
	Fieldz="ProjID, Obtained, BidLost, ProjName, ProjCity, ProjState, DateStarted, rcsPM, Use2010Bidder, Active"
	SQL="SELECT TOP "&ListMax&" "&Fieldz&" FROM Projects "&Where&" ORDER BY "&SortBy
	%><div id=hiddenSQLRabbit style="width:100%; display:none;"><%=SQL%></div><%

	Set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	FirstProj=Session("ProjectListStart")
	
	LoopNum=0
	%>
	<div id="RowContainerContainer" style="width:1024px; height:auto;">
		<%
		Do Until rs.EOF Or LoopNum >= ListMax
			LoopNum=LoopNum+1
			
			%>
			<div id=RowContainer<%=LoopNum%> class=RowContainer style="<%=rowSty%> ">
			<% SelectedRow=""%>		
			<div id=ProjID<%=LoopNum%> class=ProjID ><%=rs("ProjID")%></div>
			<%	
			ProjID=rs("ProjID")
			ProjName=DecodeChars(rs("ProjName"))
			If instr(ProjName," - ") Then ProjName=split(ProjName," - ")(0)
			d8from=rs("DateStarted")
	
			StartDate=rs("DateStarted")
			if isNull(StartDate) Then StartDate="1/1/1900"
			%>
			<div id=ItemJob<%=LoopNum%> class=ItemJob style="text-align:left !important;" >
				<a id="JobName<%=LoopNum%>" class="JobName" href="Project.asp?id=<%=ProjID%>" target="_parent" onMouseDown="sessionWrite('ShownProjects',Gebi('selShowBids').selectedIndex);" style="<%=rowSty%>"><%=ProjName%></a>
			</div>
			
			<div id=ItemCity<%=LoopNum%> class=ItemCity style="text-align:left; padding-left:6px" ><%=DecodeChars(rs("ProjCity"))%></div>
			<div id=ItemState<%=LoopNum%> class=ItemState ><%=rs("ProjState")%></div>
			<%

			cssClass="statusWon"
			bOpen=(rs("Active")="True")
			bClosed= Not bOpen
			If bClosed Then 
				cssClass="statusLost"
				bClosed=1
			Else
				bClosed=0
			End If
			If bLost Then bLost=1 Else bLost=0
			
			%>
			<div class=ItemProg id=ItemProgBidLost<%=LoopNum%> align="center" >
				<div class=<%=cssClass%> onClick="showStatusPopup(<%=ProjID%>, this, <%=bLost%>,<%=bClosed%>);" style="float:none;">&nbsp;</div>
			</div>
			<%	
			StartDate=split(StartDate,"/")
			StartM=StartDate(0)
			StartD=StartDate(1)
			StartY=split(StartDate(2)," ")(0)
			StartDate=StartM&"/"&StartD&"/"&StartY
			if StartDate="1/1/1900" Then StartDate=""
			if DueDate="1/1/1900" Then DueDate=""
			if DoneDate="1/1/1900" Then DoneDate=""
			%>
			<div class=ItemDates id=ItemDateStarted<%=LoopNum%> ><%=StartDate%></div>
			
			<div class=ItemPM id=ItemPM<%=LoopNum%> ><%=rs("rcsPM")%></div>
			 
		</div>
		<%
			'response.Flush()
			rs.MoveNext
			if rs.EOF Then  Session("ProjectListStart")="" Else Session("ProjectListStart")=LoopNum+1
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
<div id="BiddingColumn" class="ProgColumn" style=""></div>
<div id="UndergroundColumn" class="ProgColumn" style=""></div>
<div id="RoughInspColumn" class="ProgColumn" style=""></div>
<div id="TrimColumn" class="ProgColumn" style=""></div>
<div id="DoneColumn" class="ProgColumn" style=""></div>
-->
</body>
</html>

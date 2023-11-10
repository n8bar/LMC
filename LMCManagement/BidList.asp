<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title>Bid List</title>
<!-- #include file="Common.asp" -->

<script type="text/javascript" src="Bid/BidList.js?noCache=<%=noCache%>"></script>
<script type="text/javascript" src="Bid/BidListAJAX.js?noCache=<%=noCache%>"></script>

<link type="text/css" rel="stylesheet" href="Library/CSS_DEFAULTS.css?noCache=<%=noCache%>" media="all"/>
<link type="text/css" rel="stylesheet" href="Library/ListsCommon.css?noCache=<%=noCache%>" media="all"/>
<link type="text/css" rel="stylesheet" href="Bid/BidList.css?noCache=<%=noCache%>" media="all"/>
<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="all" />

</head>

<body onLoad="Resize(); //alert('loadedBidList'); " onResize="Resize();">

<div id=Loading align="center">
	<div id=LoadText style="margin:10% auto;">
		Loading<br/>
		<img src="../Images/roller.gif"/>
	</div>
</div>

<div id=listHead>
	<div id=listToolbar class=Toolbar onDblClick="Gebi('hiddenSQLRabbit').style.display='block';">
		<button id=delBids class=tButton0x24 onClick="delBids();" title="Delete Selected Projects" />
			<span><img src="../Images/delete.png" style="float:left; height:22px; width:22px;"/></span>
			<span style="float:left; font-size:15px; height:100%;">Delete&nbsp;</span>
		</button>
		<!--
		<div class="tSpacer1">&nbsp;</div>
		<button id="editBids" class="tButton0x24" onClick="editBids();" title="Edit multiple bids simultaneously." />
			<span><img src="../Images/pencil_16.png" style="float:left; height:22px; width:22px;"/></span>
			<span style="float:left; font-size:15px; height:100%;">&nbsp;Mass Edit&nbsp;</span>
		</button>
		-->
		<%
		ListMax=Session("BidListMax")
		if ListMax="" Then ListMax=64
		%>
		
		<label id=lLMax>
			&nbsp; &nbsp; &nbsp; &nbsp; Show
			<input id=lMax type="text" width=3 onKeyUp="return false;" value="<%=ListMax%>" onChange="sessionWrite('BidListMax',this.value);" />
			results &nbsp; &nbsp;
		</label>
		
		<select id=selShowBids onChange="selShowBids_Change(this);" style="">
			<option value="All" >All Bids</option>
			<option value="Recent" selected>Recent Bids</option>
			<option value="Open" >Open Bids</option>
			<option value="Closed">Closed Bids</option>
			<option value="Won">Won Bids</option>
			<option value="Lost">Lost Bids</option>
		</select>
		<label for="selShowBids" style="float:right; margin:5px 0 0 0;">Show&nbsp;</label>
		<% If Session("ShownBids") <> "" Then
				%>
				<script type="text/javascript">
					Gebi('selShowBids').selectedIndex=<%=Session("ShownBids")%>;
					try { PGebi('sStatus').selectedIndex=<%=Session("ShownBids")%>; } catch(e) {}
				</script>
				<%
			End If 
		%>
	</div>
</div>
<%
sortColumn=lcase(Session("SortBids"))
if sortColumn="" Then sortColumn="projname"
%>

<div id="ItemsHead" >        	
	<div id=HeadCheck class=HeadCheck align=left ><input id=selAll type="checkbox" onChange="" /></div >
	<div id=ProjID class=HeadNum align="left" onClick="sortCol('ProjID');" style="<%If sortColumn="projid" Then %>font-weight:bold; <% End If %>" >Project #</div >
	<div id=ProjName class=HeadJob align="left" onClick="sortCol('ProjName');" style="<%If sortColumn="projname" Then %>font-weight:bold; <% End If %>" >Project</div >
	<div id=ProjCity class=HeadCity align="left" onClick="sortCol('ProjCity');" style="<%If sortColumn="projcity" Then %>font-weight:bold; <% End If %>" >City</div >
	<div id=ProjStated class=HeadState align="left" onClick="sortCol('ProjState');" style="<%If sortColumn="projstate" Then %>font-weight:bold; <% End If %>" >State</div >
	<div id=HeadProg class=HeadProg >Status</div>
	<div id=DateEnt class=HeadDates align="left" onClick="sortCol('DateEnt');" style="<%If sortColumn="dateent" Then %>font-weight:bold; <% End If %>" >Created</div >
	<div id=BidTotal class=HeadAmount align="right" onClick="sortCol('BidTotal');" style="<%If sortColumn="bidtotal" Then %>font-weight:bold; <% End If %>" >Amount</div >
	<!-- script type="text/javascript">/*	Gebi('< %=sortColumn%>').style.fontWeight='bold';	*/</script -->
	
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
		<label><input id=cbStatusOpen type=checkbox onChange="setStatus('Open', this.checked);" />Open</label>&nbsp;
		<label><input id=cbStatusWon type=checkbox onChange="setStatus('Won', this.checked);"/>Won</label>&nbsp;
		<label><input id=cbStatusLost type=checkbox onChange="setStatus('Lost', this.checked);"/>Lost</label>&nbsp;
		<div class=smallRedXCircle onClick="Gebi('statusPopup').style.display='none';">X</div>
	</div>

	<%
	Where=""
	
	If Session("ShownBids")="" Then
		'Where="(Obtained='False' OR Obtained IS NULL) AND (BidLost='False' OR BidLost IS NULL)"
		Session("ShownBids")=1
	End If
	Select Case CInt(Session("ShownBids"))
		Case 0 'All
			Where=""
			
		Case 1 'Recent
			rbSQL="SELECT ProjID FROM RecentBids ORDER BY ID DESC"
			Set rbRS=Server.CreateObject("AdoDB.RecordSet")
			rbRS.Open rbSQL, REDConnString
			
			If Not rbRS.EOF Then
				Where=" ProjID="&rbRS("ProjID")
				rbRS.MoveNext
			End If
			Do Until rbRS.EOF
				Where=Where&" OR ProjID="&rbRS("ProjID")
				rbRS.MoveNext
			Loop
			
			If Session("SortBids")="" Then Session("SortBids")=searchOrder
			If Session("SortBids")="" Then Session("SortBids")="lastOpened DESC"
			
		Case 2 'Open Bids
			Where="(Obtained='False' OR Obtained IS NULL) AND (BidLost='False' OR BidLost IS NULL)"
		
		Case 3 'Closed Bids
			Where="Obtained='True' OR BidLost='True' "
		
		Case 4 'Won Bids
			Where="Obtained='True'"
		
		Case 5 'Lost Bids
			Where="BidLost='True' "
			
		Case Else 'Open Bids (default)
			Where="(Obtained='False' OR Obtained IS NULL) AND (BidLost='False' OR BidLost IS NULL)"
	End Select
	%><%'=Session("ShownBids")&"<br/>"%><%
	%><%'=Where&"<br/>"%><%
	
	searchWhere=""
	searchOrder=""
	If Session("BidSearch")="1" Then
		If Where<>"" Then Where="("&Where&")"
		
		NameNumCity=Session("BidSearchProjName")
		Session("BidSearchProjName")=""
		If NameNumCity<>"" Then
			searchWhere=searchWhere&" (ProjName Like'%"&NameNumCity&"%' Or ProjCity Like'%"&NameNumCity&"%' Or ProjID Like'%"&NameNumCity&"%') "
			searchOrder=" ProjName, ProjCity"
			%><%'=searchWhere&"<br/>"%><%
		End If
		
		If Session("BidSearchProjState")<>"" Then
			if searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" ProjState = '"&Session("BidSearchProjState")&"'"
			Session("BidSearchProjState")=""
			if searchOrder <> "" Then searchOrder=searchOrder&", "
			searchOrder=searchOrder&" ProjState"
		End If
		
		If Session("BidSearchDateAfter")<>"" Then
			If searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" DateEnt > '"&Session("BidSearchDateAfter")&"'"
			Session("BidSearchDateAfter")=""
			If searchOrder <> "" Then searchOrder=", "&searchOrder
			searchOrder=" DateEnt"&searchOrder
		End If
		
		If Session("BidSearchDateBefore")<>"" Then
			If searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" DateEnt < '"&Session("BidSearchDateBefore")&"'"
			Session("BidSearchDateBefore")=""
			
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
		Session("BidSearch")=""
	End If
	
	If Where<>""Then Where="WHERE "&Where
	
	If Session("SortBids")="" Then Session("SortBids")=searchOrder
	If Session("SortBids")="" Then Session("SortBids")="ProjName"
	SortBy=Session("SortBids")
	%><script>var sortBy="<%=SortBy%>";</script><%
	%><%'=SortBy%><%
	Session("SortBids")=""
	
	
	Dim TreeNum(2)
	
	TreeNum(1)=1
	TreeNum(2)=1
	
	Dim TreeNumI: TreeNumI=1
	
	Fieldz="ProjID, Obtained, BidLost, ProjName, ProjCity, ProjState, DateEnt, BidTotal, Use2010Bidder"
	SQL="SELECT TOP "&ListMax&" "&Fieldz&" FROM Projects "&Where&" ORDER BY "&SortBy
	%><div id=hiddenSQLRabbit style="width:100%; display:none;"><%=searchWhere&"<br/>"&SQL%></div><%
	
	Set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	FirstProj=Session("BidListStart")
	
	LoopNum=0
	%>
	<div id="RowContainerContainer" style="width:1024px; height:auto;">
		<%
		Do Until rs.EOF
			LoopNum=LoopNum+1
			
			if rs("Obtained")="True" Then Done="checked" Else Done = ""
			
			If rs("Use2010Bidder")<>"True" Then 
				'rowSty="background-image:-moz-linear-gradient(90deg bottom left, rgba(112,168,56,.0625), rgba(112,168,56,.0625)); " 
				rowSty="color:#40631D;" 
			Else 
				rowSty=""
			End If
			%>
			<div id=RowContainer<%=LoopNum%> class=RowContainer style="<%=rowSty%>">
			<% SelectedRow=""%>		
			<div id="check<%=LoopNum%>" class="ItemCheck"><input id=sel<%=LoopNum%> class="ItemCheckBox" type="checkbox" /></div>
			<div id="ProjID<%=LoopNum%>" class="ProjID"><%=rs("ProjID")%></div>
			<%	
			ProjID=rs("ProjID")
			ProjName=DecodeChars(rs("ProjName"))
			If instr(ProjName," - ") Then ProjName=split(ProjName," - ")(0)
			d8from=rs("DateEnt")
			StartDate=rs("DateEnt")
			if StartDate="1/1/1900" Then StartDate=""
			%>
			
			<div id=ItemJob<%=LoopNum%> class=ItemJob>
				<!-- img id=download<%=LoopNum%> class=download Project src="../images/down_64.png" width=24 height=24 onClick="downloadClick(this,< %=ProjID%>);" / -->
				<a class=download href="XMLX.LMCProject?action=project&id=<%=projId%>" ><img id=download<%=LoopNum%> Project src="../images/down_64.png" width=24 height=24 /></a>
				<a id=JobName<%=LoopNum%> class=JobName href="BidProject.asp?id=<%=ProjID%>&noCache=<%=timestamp%>" target="_parent" onMouseDown="sessionWrite('ShownBids',Gebi('selShowBids').selectedIndex);" style="<%=rowSty%>" ><%=ProjName%></a>
			</div>
			
			<div id="ItemCity<%=LoopNum%>" class="ItemCity" ><%=DecodeChars(rs("ProjCity"))%></div>
			<div id="ItemState<%=LoopNum%>" class="ItemState" ><%=rs("ProjState")%></div>
			
			<%
			bLost=(rs("BidLost")="True")
			bWon=(rs("Obtained")="True")
			bOpen= Not (bLost XOr bWon)
	
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
			End If
			
			If bWon Then bWon=1 Else bWon=0
			If bLost Then bLost=1 Else bLost=0
			%>
			<div class=ItemProg id=ItemProgBidLost<%=LoopNum%> >
				<div class=<%=cssClass%> onClick="showStatusPopup(<%=ProjID%>, this, <%=bLost%>,<%=bWon%>);">&nbsp;</div>
			</div>
			<%	
			StartDate=split(rs("DateEnt"),"/")
			StartM=StartDate(0)
			StartD=StartDate(1)
			StartY=split(StartDate(2)," ")(0)
			StartDate=StartM&"/"&StartD&"/"&StartY
			if StartDate="1/1/1900" Then StartDate=""			'DueDate=rs("BiddingDueDate")
			if DueDate="1/1/1900" Then DueDate=""			'DoneDate=rs("BiddingCompletedDate")
			if DoneDate="1/1/1900" Then DoneDate=""
			
			BidTotal=rs("BidTotal")
			If IsNull(BidTotal) Or BidTotal="" Then BidTotal=0
			%>
			<div class=ItemDates id=ItemDateStarted<%=LoopNum%> ><%=StartDate%></div>
			
			<div class=ItemAmount id=ItemAmount<%=LoopNum%> ><%=formatCurrency(BidTotal)%></div>
			 
		</div>
		<%
			'response.Flush()
			rs.MoveNext
			if rs.EOF Then  Session("BidListStart")="" Else Session("BidListStart")=LoopNum+1
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

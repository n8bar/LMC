<!DOCTYPE html>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8" />
<meta http-equiv=X-UA-Compatible content="chrome=1" />
<title>Monitoring Account List</title>
<!-- #include file="Common.asp" -->

<script type=text/javascript src=Service/MonitoringList.js?noCache=<%=noCache%> ></script>
<script type=text/javascript src=Service/MonitoringListAJAX.js?noCache=<%=noCache%> ></script>

<link type=text/css rel=stylesheet href=Library/CSS_DEFAULTS.css?noCache=<%=noCache%> media=all />
<link type=text/css rel=stylesheet href=Library/ListsCommon.css?noCache=<%=noCache%> media=all />
<link type=text/css rel=stylesheet href=Service/MonitoringList.css?noCache=<%=noCache%> media=all />
<link type=text/css rel=stylesheet href=Library/dhtmlgoodies_calendar.css?noCache=<%=noCache%> media=all />

</head>

<body onLoad="Resize(); //alert('loadedAccountList'); " onResize="Resize();">

<div id=Loading align=center onDblClick=n8CanHide(this)>
	<div id=LoadText style="margin:10% auto;">
		Loading<br/>
		<img src="../Images/roller.gif"/>
	</div>
</div>

<div id=listHead>
	<div id=listToolbar class=Toolbar onDblClick="this.ondblclick=function() { Gebi('hiddenSQLRabbit').style.display='block'; }">
		<button id=delAccounts class=tButton24 onClick="delAccounts();" title="Delete Selected Accounts" />
			<span><img src="../Images/delete.png" style="float:left; height:22px; width:22px;" /></span>
			<span style="float:left; font-size:15px; height:100%;">Delete&nbsp;</span>
		</button>
		<!--
		<div class="tSpacer1">&nbsp;</div>
		<button id="editAccounts" class="tButton0x24" onClick="editAccounts();" title="Edit multiple Accounts simultaneously." />
			<span><img src="../Images/pencil_16.png" style="float:left; height:22px; width:22px;"/></span>
			<span style="float:left; font-size:15px; height:100%;">&nbsp;Mass Edit&nbsp;</span>
		</button>
		-->
		<%
		ListMax=Session("AccountListMax")
		if ListMax="" Then ListMax=10
		%>
		
		<label id=lLMax>
			&nbsp; &nbsp; &nbsp; &nbsp; Show
			<input id=lMax type="text" width=3 onKeyUp="return false;" value="<%=ListMax%>" onChange="sessionWrite('AccountListMax',this.value);" />
			results &nbsp; &nbsp;
		</label>
		
		<select id=selShowAccounts onChange="selShowAccounts_Change(this);" style="" >
			<option value=All selected>All Accounts</option>
			<option value=Recent >Recent Accounts</option>
		</select>
		<label for="selShowAccounts" style="float:right; margin:5px 0 0 0;">Show&nbsp;</label>
		<%
		If Session("ShownAccounts") <> "" Then
			%>
			<script>
				Gebi('selShowAccounts').selectedIndex=<%=Session("ShownAccounts")%>;
				try { PGebi('sStatus').selectedIndex=<%=Session("ShownAccounts")%>; } catch(e) {}
			</script>
			<%
		Else
			Session("ShownAccounts") = 0
		End If 
		%>
	</div>
</div>
<%
sortColumn=lcase(Session("SortAccounts"))
if sortColumn="" Then sortColumn="Accountname"
%>

<div id="ItemsHead" >        	
	<div id=HeadCheck class=HeadCheck align=left ><input id=selAll type="checkbox" onChange="" /></div >
	<div id=AcctNo class=HeadNum align="left" onClick="sortCol('AcctNo');" style="<%If sortColumn="id" Then %>font-weight:bold; <% End If %>">Account #</div>
	<div id=HeadProg class=HeadProg >Status</div>
	<div id=Name class=HeadJob align="left" onClick="sortCol('SiteName');" style="<%If sortColumn="sitename" Then %>font-weight:bold; <% End If %>" >Site Name</div>
	<div id=Address class=HeadCity align=left onClick="sortCol('City');" style="<%If sortColumn="city" Then %>font-weight:bold; <% End If %>" >Address</div>
	<div id=DateEnt class=HeadDates align="left" onClick="sortCol('DateEnt');" style="<%If sortColumn="dateent" Then %>font-weight:bold; <% End If %>" >Created</div >
	<div id=Notes class=HeadAmount align="right" onClick="sortCol('Notes');" style="<%If sortColumn="Notes" Then %>font-weight:bold; <% End If %>" >Notes</div >
	<!-- script type="text/javascript">/*	Gebi('< %=sortColumn%>').style.fontWeight='bold';	*/</script -->
	
</div>


<script type="text/javascript">Gebi('Loading').style.display='block';</script>

<div id="List" onScroll="Gebi('statusPopup').style.display='none';" >
	<div id=statusPopup>
		<label><input id=cbStatusActive type=checkbox onChange="setStatus('Active', this.checked);"/>Active</label>&nbsp;
		<label><input id=cbStatusInactive type=checkbox onChange="setStatus('Inactive', this.checked);"/>Inactive</label>&nbsp;
		<label><input id=cbStatusOnTest type=checkbox onChange="setStatus('OnTest', this.checked);" />On Test</label><label> until: <input id=statusTestUntil onFocus="cbStatusOnTest.checked=false; cbStatusActive.checked=false; cbStatusInactive.checked=false;" onBlur="setStatus('OnTest', cbStatusOnTest.checked);" /></label>
		<div class=smallRedXCircle onClick="Gebi('statusPopup').style.display='none';">X</div>
	</div>

	<%
	Where=""
	
	If Session("ShownAccounts")="" Then
		'Where="(Obtained='False' OR Obtained IS NULL) AND (AccountLost='False' OR AccountLost IS NULL)"
		Session("ShownAccounts")=1
	End If
	Select Case CInt(Session("ShownAccounts"))
		Case 0 'All
			Where=""
			
		Case 1 'Recent
			rbSQL="SELECT AccountID FROM RecentMonitoring ORDER BY ID DESC"
			Set rbRS=Server.CreateObject("AdoDB.RecordSet")
			rbRS.Open rbSQL, REDConnString
			
			If Not rbRS.EOF Then
				Where=" id="&rbRS("AccountID")
				rbRS.MoveNext
			End If
			Do Until rbRS.EOF
				Where=Where&" OR id="&rbRS("AccountID")
				rbRS.MoveNext
			Loop
			
			If Session("SortAccounts")="" Then Session("SortAccounts")=searchOrder
			If Session("SortAccounts")="" Then Session("SortAccounts")="lastOpened DESC"
			
		Case 2 'Open Accounts
			Where="(Obtained='False' OR Obtained IS NULL) AND (AccountLost='False' OR AccountLost IS NULL)"
		
		Case 3 'Closed Accounts
			Where="Obtained='True' OR AccountLost='True' "
		
		Case 4 'Won Accounts
			Where="Obtained='True'"
		
		Case 5 'Lost Accounts
			Where="AccountLost='True' "
			
		Case Else 'Open Accounts (default)
			Where="(Obtained='False' OR Obtained IS NULL) AND (AccountLost='False' OR AccountLost IS NULL)"
	End Select
	%><%'=Session("ShownAccounts")&"<br/>"%><%
	%><%'=Where&"<br/>"%><%
	
	searchWhere=""
	searchOrder=""
	If Session("AccountSearch")="1" Then
		If Where<>"" Then Where="("&Where&")"
		
		NameNumCity=Session("AccountSearchName")
		Session("AccountSearchName")=""
		If NameNumCity<>"" Then
			searchWhere=searchWhere&" (SiteName Like'%"&NameNumCity&"%' Or City Like'%"&NameNumCity&"%' Or id Like'%"&NameNumCity&"%' Or AcctNo Like'%"&NameNumCity&"%') "
			searchOrder=" SiteName, City"
			%><%'=searchWhere&"<br/>"%><%
		End If
		
		If Session("AccountSearchState")<>"" Then
			if searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" State = '"&Session("AccountSearchState")&"'"
			Session("AccountSearchState")=""
			if searchOrder <> "" Then searchOrder=searchOrder&", "
			searchOrder=searchOrder&" State"
		End If
		
		If Session("AccountSearchDateAfter")<>"" Then
			If searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" DateEnt > '"&Session("AccountSearchDateAfter")&"'"
			Session("AccountSearchDateAfter")=""
			If searchOrder <> "" Then searchOrder=", "&searchOrder
			searchOrder=" DateEnt"&searchOrder
		End If
		
		If Session("AccountSearchDateBefore")<>"" Then
			If searchWhere <> "" Then searchWhere=searchWhere&" AND "
			searchWhere=searchWhere&" DateEnt < '"&Session("AccountSearchDateBefore")&"'"
			Session("AccountSearchDateBefore")=""
			
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
		Session("AccountSearch")=""
	End If
	
	If Where<>""Then Where="WHERE "&Where
	
	If Session("SortAccounts")="" Then Session("SortAccounts")=searchOrder
	If Session("SortAccounts")="" Then Session("SortAccounts")="AcctNo"
	SortBy=Session("SortAccounts")
	%><script>var sortBy="<%=SortBy%>";</script><%
	%><%'=SortBy%><%
	Session("SortAccounts")=""
	
	
	Dim TreeNum(2)
	
	TreeNum(1)=1
	TreeNum(2)=1
	
	Dim TreeNumI: TreeNumI=1
	
	SQL="SELECT TOP "&ListMax&" * FROM MonitoringAccounts "&Where&" ORDER BY "&SortBy
	%><div id=hiddenSQLRabbit style="width:100%; display:none;"><%=searchWhere&"<br/>"&SQL%></div><%
	
	Set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	FirstAccount=Session("AccountListStart")
	
	LoopNum=0
	%>
	<div id="RowContainerContainer" style="width:1024px; height:auto;">
		<%
		Do Until rs.EOF
			LoopNum=LoopNum+1
			
			AccountID=rs("id")
			'if rs("Obtained")="True" Then Done="checked" Else Done = ""
			'If rs("Use2010Accountder")<>"True" Then 
			'	'rowSty="background-image:-moz-linear-gradient(90deg bottom left, rgba(112,168,56,.0625), rgba(112,168,56,.0625)); " 
			'	rowSty="color:#40631D;" 
			'Else 
			'	rowSty=""
			'End If
					
			%>
			<div id=RowContainer<%=LoopNum%> class=RowContainer style="<%=rowSty%> height:49px;">
			<% SelectedRow=""%>		
			<label id=check<%=LoopNum%> class=ItemCheck>
				<input id=sel<%=LoopNum%> class=ItemCheckBox type=checkbox /><br/>
				<span id=AcctID<%=LoopNum%> class="AcctID" ><%=Right("000000"&AccountID,6)%></span>
			</label>
			<%
			providerSQL="SELECT Name FROM Contacts WHERE Id=0"&rs("ProviderId")
			set providerRS=Server.CreateObject("AdoDB.recordset")
			providerRS.Open providerSQL, REDConnString
			providerName=split(DecodeChars(providerRS("Name"))," ")(0)
			Set providerRS=Nothing
			%>
			<div id=AcctNo<%=LoopNum%> class=AcctNo><div class="taL h0"><%=providerName%>#</div><br/><b class=taR><%=DecodeChars(rs("AcctNo"))%></b></div>
			<%	
			aActive= (rs("active")="True")
			aInactive= Not aActive
			aOnTest= aActive And (rs("testUntil") > Now)
			
			If aInactive Then cssClass="statusInactive"
			If aActive Then cssClass="statusActive"
			If aOnTest Then cssClass="statusOnTest"
			
			If aActive Then aActive=1 Else aActive=0
			If aInactive Then aInactive=1 Else aInactive=0
			%>
			<div class=ItemProg id=ItemStatus<%=LoopNum%> >
				<div id=acctStatus<%=LoopNum%> class=<%=cssClass%> onClick="showStatusPopup(<%=AccountID%>, this, <%=aInactive%>,<%=aActive%>);">&nbsp;</div>
				<div id=testUntil<%=LoopNum%> style="display:none;"><%=rs("testUntil")%></div>
			</div>
			<%	
			AccountName=DecodeChars(rs("SiteName"))
			'If instr(AccountName," - ") Then AccountName=split(AccountName," - ")(0)
			d8from=rs("DateEnt")
			StartDate=rs("DateEnt")
			if StartDate="1/1/1900" Then StartDate=""

			Customer="[unknown]"
			CustId=rs("CustId")
			If CustID<>"" And Not IsNull(CustID) Then
				custSQL="SELECT Top 1 Name From Contacts WHERE Id="&CustId
				Set custRS=Server.CreateObject("AdoDB.RecordSet")
				custRS.Open custSQL, RedConnString
				If not CustRS.EOF Then Customer = DecodeChars(CustRS("Name"))
				Set custSQL=Nothing
			End if
			%>
			
			<div id=ItemJob<%=LoopNum%> class=ItemJob>
				<!-- img id=download<%=LoopNum%> class=download Account src="../images/down_64.png" width=24 height=24 onClick="downloadClick(this,< %=AccountID%>);" / -->
				<a id=JobName<%=LoopNum%> class=JobName href="MonitoringAccount.asp?id=<%=AccountID%>" target="_parent" onMouseDown="sessionWrite('ShownAccounts',Gebi('selShowAccounts').selectedIndex);" style="<%=rowSty%>" ><%=AccountName%></a><br/><small class=taL style="color:#666;"><small><b>Customer:</b></small> <%=Customer%></small>
			</div>
			
			<div id="ItemAddr<%=LoopNum%>" class="ItemAddr" ><%=DecodeChars(rs("Addr")&"<br/>"&rs("City"))&", "&rs("State")&" "&rs("Zip")%></div>
			
			<%
			If IsNull(StartDate) Then 
				StartDate=""
			Else 
				StartDate=split(rs("DateEnt"),"/")
				StartM=StartDate(0)
				StartD=StartDate(1)
				StartY=split(StartDate(2)," ")(0)
				StartDate=StartM&"/"&StartD&"/"&StartY
			End If
			if StartDate="1/1/1900" Then StartDate=""			'TestUntil=rs("AccountdingTestUntil")
			if TestUntil="1/1/1900" Then TestUntil=""			'DoneDate=rs("AccountdingCompletedDate")
			
			AccountTotal=0'rs("AccountTotal")
			If IsNull(AccountTotal) Or AccountTotal="" Then AccountTotal=0
			%>
			<div class=ItemDates id=ItemDateStarted<%=LoopNum%> ><%=StartDate%></div>
			
			<%
			Notes=DecodeChars(rs("Notes"))
			If rs("testUntil") > Now Then Notes=Notes&" --On test until "&rs("testUntil")
			%>
			<div class=ItemNotes id=ItemNotes<%=LoopNum%> ><%=Notes%></div>
			 
		</div>
		<%
			'response.Flush()
			rs.MoveNext
			if rs.EOF Then  Session("AccountListStart")="" Else Session("AccountListStart")=LoopNum+1
		Loop

		Refine1=""
		Refine2="."
		If LoopNum>=ListMax Then
			Refine1="<span style=""color:#C00;"" >Maximum of "
			Refine2=" reached.  Please refine your search.</span>"
		End If
		%>
		<div class="w100p h24 wsNW fL">
			<button id=newAccount class="tButton0x24 mL64 fL" onClick="parent.showNewAccount();" ><img src="../Images/plus_16.png" /> Add A New Account</button>
			<big class="lH24 mL32 fR"><%=Refine1%><%=LoopNum%> results<%=Refine2%></big>
		</div>
		<script type="text/javascript">Gebi('Loading').style.display='none';</script>
	</div>
</div>
</body>
</html>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title>Contact List</title>
<!-- #include file="common.asp" -->

<script type="text/javascript" src="Contacts/ContactList.js?noCache=<%=noCache%>"></script>
<script type="text/javascript" src="Contacts/ContactListAJAX.js?noCache=<%=noCache%>"></script>

<link type="text/css" rel="stylesheet" href="Library/CSS_DEFAULTS.css?noCache=<%=noCache%>" media="all"/>
<link type="text/css" rel="stylesheet" href="Library/ListsCommon.css?noCache=<%=noCache%>" media="all"/>
<link type="text/css" rel="stylesheet" href="Contacts/ContactList.css?noCache=<%=noCache%>" media="all"/>
<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="all" />

</head>

<script>
	function toggleSearchSort() { 
		<% 
		LinksTo=Request.QueryString("LinksTo") 
		If LinksTo="" or IsNull(LinksTo) Then 
			LinksTo=-1
			%>parent.toggleSearchSort();<%
		Else
			%>/*Nothing*/<%
		End if
		%>
	}
</script>

<body onLoad="Resize(); toggleSearchSort(); //alert('loadedConactList'); " onResize="Resize();">
<script> var LinksTo=false; </script>

<% If LinksTo < 0 Then %>
	<div id=Loading align=center onDblClick=n8CanHide(this)>
		<div id=LoadText style="margin:10% auto;">Loading<br/><img src="../Images/roller.gif"/></div>
	</div>
	
	<div id=listHead>
		<div id=listToolbar class=Toolbar onDblClick="this.ondblclick=function() { Gebi('hiddenSQLRabbit').style.display='block'; }">
			<button id=delContacts class=tButton0x24 onClick="delContacts();" title="Delete Selected Contacts" />
				<span><img src="../Images/delete.png" style="float:left; height:22px; width:22px;"/></span>
				<span style="float:left; font-size:15px; height:100%;">Delete&nbsp;</span>
			</button>
			<!--
			<div class="tSpacer1">&nbsp;</div>
			<button id="editContacts" class="tButton0x24" onClick="editContacts();" title="Edit multiple Contacts simultaneously." />
				<span><img src="../Images/pencil_16.png" style="float:left; height:22px; width:22px;"/></span>
				<span style="float:left; font-size:15px; height:100%;">&nbsp;Mass Edit&nbsp;</span>
			</button>
			-->
			<%
			ListMax=Session("ContactListMax")
			if ListMax="" Then ListMax=128
			%>
			
			<button class="fR mR12 h18 mT6" onClick="location+='';"><i> &nbsp; Go &nbsp; </i></button>
			<label id=lLMax>
				&nbsp; &nbsp; &nbsp; &nbsp; Show
				<input id=lMax type="text" width=3 onKeyUp="return false;" value="<%=ListMax%>" onChange="sessionWrite('ContactListMax',this.value);" />
				results &nbsp; &nbsp; 
			</label>
			
			<select id=selShowContacts onChange="selShowContacts_Change(this);" style="">
				<option value="All" selected >All Contacts</option>
				<option value="Recent">Recent Contacts</option>
			</select>
			<label for="selShowContacts" style="float:right; margin:5px 0 0 0;">Show&nbsp;</label>
			<% If Session("ShownContacts") <> "" Then
					%>
					<script>
						Gebi('selShowContacts').selectedIndex=<%=Session("ShownContacts")%>;
						try { PGebi('sStatus').selectedIndex=<%=Session("ShownContacts")%>; } catch(e) {}
					</script>
					<%
				End If 
			%>
		</div>
	</div>
	<%
	
	
	sortColumn=lcase(Session("SortContacts"))
	if sortColumn="" Then sortColumn="name"
	%>
	
	<div id="ItemsHead" >        	
		<div id=HeadCheck class=HeadCheck align=left ><input id=selAll type="checkbox" onChange="" /></div >
		<div id=HeadId align="left" onClick="sortCol('ID');" style="<%If sortColumn="id" Then %>font-weight:bold; <% End If %>" >#</div >
		<div id=HeadName align="left" onClick="sortCol('Name');" style="<%If sortColumn="name" Then %>font-weight:bold; <% End If %>" >Name</div >
		<div id=HeadAddr align="left" onClick="sortCol('City');" style="<%If sortColumn="city" Then %>font-weight:bold; <% End If %>" >Address</div >
		<div id=HeadPhone align="left" onClick="sortCol('phone1');" style="<%If sortColumn="phone1" Then %>font-weight:bold; <% End If %>" >Phone</div >
		<div id=HeadFax align="left" onClick="sortCol('fax');" style="<%If sortColumn="fax" Then %>font-weight:bold; <% End If %>" >Fax</div >
		<div id=HeadNotes align="left" onClick="sortCol('notes');" style="<%If sortColumn="notes" Then %>font-weight:bold; <% End If %>" >Notes</div >
	</div>
	
	<script type="text/javascript">Gebi('Loading').style.display='block';</script>
	<%
Else 'Linksto
	%>
	<script>LinksTo=true; </script>
	<div id="ItemsHead" style="display:none;" ></div>
	<div id="Loading" style="display:none !important;" ></div>
	<div id="LoadText" style="display:none;" ></div>
	<div id="List" style="display:none;" ></div>
	<div id="listHead" style="display:none;" ></div>
	<%
End If
%>
<div id="List" onScroll="Gebi('statusPopup').style.display='none';" >
	
	<% 
	If LinksTo < 0 Then 
		%>
		<div id=statusPopup>
			<label><input id=cbStatusOpen type=checkbox onChange="setStatus('Open', this.checked);" />Open</label>&nbsp;
			<label><input id=cbStatusWon type=checkbox onChange="setStatus('Won', this.checked);" />Won</label>&nbsp;
			<label><input id=cbStatusLost type=checkbox onChange="setStatus('Lost', this.checked);" />Lost</label>&nbsp;
			<div class=smallRedXCircle onClick="Gebi('statusPopup').style.display='none';">X</div>
		</div>
	
		<%
		Where=""
		
		If Session("ShownContacts")="" Then
			Session("ShownContacts")=1
		End If
		Select Case CInt(Session("ShownContacts"))
			Case 0 'All
				Where=""
				
			Case 1 'Recent
				rcSQL="SELECT ContactID FROM RecentContacts ORDER BY ID DESC"
				Set rcRS=Server.CreateObject("AdoDB.RecordSet")
				rcRS.Open rcSQL, REDConnString
				
				If Not rcRS.EOF Then
					Where=" Id="&rcRS("ContactID")
					rcRS.MoveNext
				End If
				Do Until rcRS.EOF
					Where=Where&" OR Id="&rcRS("ContactID")
					rcRS.MoveNext
				Loop
				
				If Session("SortContacts")="" Then Session("SortContacts")=searchOrder
				If Session("SortContacts")="" Then Session("SortContacts")="lastOpened DESC"
				
			'Case 2 'Open Contacts
			'	Where="(Obtained='False' OR Obtained IS NULL) AND (ContactLost='False' OR ContactLost IS NULL)"
			'
			'Case 3 'Closed Contacts
			'	Where="Obtained='True' OR ContactLost='True' "
			'
			'Case 4 'Won Contacts
			'	Where="Obtained='True'"
			'
			'Case 5 'Lost Contacts
			'	Where="ContactLost='True' "
		End Select
		%><%'=Session("ShownContacts")&"<br/>"%><%
		%><%'=Where&"<br/>"%><%
		
		searchWhere=""
		searchOrder=""
		If Session("ContactSearch")="Advanced" Then
			If Where<>"" Then Where="("&Where&")"
			
			contactOmni=Session("ContactSearchOmni")
			Session("ContactSearchOmni")=""
			If contactOmni<>"" Then
				searchWhere=searchWhere&" (Name Like'%"&contactOmni&"%' Or Address Like'%"&contactOmni&"%' Or Phone1 Like'%"&contactOmni&"%' Or Phone2 Like'%"&contactOmni&"%') "
				searchOrder=" Name, City"
				%><%'=searchWhere&"<br/>"%><%
			End If
			
			If Session("ContactSearchCity")<>"" Then
				if searchWhere <> "" Then searchWhere=searchWhere&" AND "
				searchWhere=searchWhere&" City LIKE '%"&Session("ContactSearchCity")&"%' OR Zip LIKE '%"&Session("ContactSearchCity")&"%'"
				Session("ContactSearchCity")=""
				if searchOrder <> "" Then searchOrder=searchOrder&", "
				searchOrder=searchOrder&" City"
			End If
			
			If Session("ContactSearchState")<>"" Then
				if searchWhere <> "" Then searchWhere=searchWhere&" AND "
				searchWhere=searchWhere&" State = '"&Session("ContactSearchState")&"'"
				Session("ContactSearchState")=""
				if searchOrder <> "" Then searchOrder=searchOrder&", "
				searchOrder=searchOrder&" State"
			End If
			
			If Session("ContactSearchDateAfter")<>"" Then
				If searchWhere <> "" Then searchWhere=searchWhere&" AND "
				searchWhere=searchWhere&" DateEnt > '"&Session("ContactSearchDateAfter")&"'"
				Session("ContactSearchDateAfter")=""
				If searchOrder <> "" Then searchOrder=", "&searchOrder
				searchOrder=" DateEnt"&searchOrder
			End If
			
			If Session("ContactSearchDateBefore")<>"" Then
				If searchWhere <> "" Then searchWhere=searchWhere&" AND "
				searchWhere=searchWhere&" DateEnt < '"&Session("ContactSearchDateBefore")&"'"
				Session("ContactSearchDateBefore")=""
				
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
			Session("ContactSearch")=""
		End If
		
		Hilite=false
		If Session("ContactSearch")="Simple" Then
			Hilite=true
			Q=EncodeChars(session("ContactSimpleSearch"))
			session("ContactSimpleSearch")=""
			Where="Name Like'%"&Q&"%' Or Address Like'%"&Q&"%' Or Phone1 Like'%"&Q&"%' Or Phone2 Like'%"&Q&"%' Or Fax Like'%"&Q&"%' Or Notes Like'%"&Q&"%'"
		End If
		
		
		If Where<>""Then Where="WHERE "&Where
		
		If Session("SortContacts")="" Then Session("SortContacts")=searchOrder
		If Session("SortContacts")="" Then Session("SortContacts")="Name"
		SortBy=Session("SortContacts")
		%><script>var sortBy="<%=SortBy%>";</script><%
		%><%'=SortBy%><%
		Session("SortContacts")=""
		
		Dim TreeNum(2)
		
		TreeNum(1)=1
		TreeNum(2)=1
		
		Dim TreeNumI: TreeNumI=1
	
	Else 'Linksto
		SortBy="Name"
		ListMax=1024
		linkListSQL="SELECT * FROM ContactContacts WHERE MasterID=0"&LinksTo
		%><div id=HiddenLLSql style="display:none;"><%=linkListSQL%></div><%
		Set llRS=server.CreateObject("AdoDB.RecordSet")
		llRS.Open linkListSQL, REDConnString
		llIsEmpty=llRS.EOF
		If Not llRS.EOF Then 
			cIdList="Id="&llRS("DetailID")
			Do Until llRS.EOF
				cIdList=cIdList&" OR Id="&llRS("DetailID")
				llRS.MoveNext
			Loop
			
		End If
		Set llRS=Nothing
		linkListSQL="SELECT * FROM ContactContacts WHERE DetailID=0"&LinksTo
		%><div id=HiddenLLSql style="display:none;"><%=linkListSQL%></div><%
		Set llRS=server.CreateObject("AdoDB.RecordSet")
		llRS.Open linkListSQL, REDConnString
		llIsEmpty=(llRS.EOF AND llIsEmpty)
		If Not llRS.EOF Then 
			cIdList="Id="&llRS("MasterID")
			Do Until llRS.EOF
				cIdList=cIdList&" OR Id="&llRS("MasterID")
				llRS.MoveNext
			Loop
			
		End If
		Set llRS=Nothing
		Fieldz="Name, Phone1"
		Where="WHERE "&cIdList
		
	End If
	
	%>
	<div id="RowContainerContainer" style="width:1024px; height:auto;">
		<%
		If LinksTo > 0 AND llIsEmpty THEN
			%>
			<div id=RowContainer-1 class="RowContainer" >No Contacts have been linked to this one.</div>
			<div id=RowContainer0 class="RowContainer" ><button id=newLink class=tButton24x0 title="Choose an existing Contact to link to this one." onClick="parent.showNewLink();"><img src=../Images/plus_16.png /> Link a contact.</button></div>
			<%
		Else
			Fieldz="*"
			SQL="SELECT TOP "&ListMax&" "&Fieldz&" FROM Contacts "&Where&" ORDER BY "&SortBy
			%><div id=hiddenSQLRabbit style="width:100%; display:none;"><%="QS:"&request.QueryString&" | searchW:"&searchWhere&"<br/>SQL:"&SQL%></div><%
			
			Set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring
			
			FirstContact=Session("ContactListStart")
			
			rowC=0
			Do Until rs.EOF
				rowC=rowC+1
					
				ContactID=rs("ID")
				cName=DecodeChars(rs("Name"))
				email=DecodeChars(rs("Email"))
				
				if LinksTo>0 Then rowSty="width:100%; min-width:0px; margin:0; max-height:24px;"
				
				%>
				<div id=RowContainer<%=rowC%> class=RowContainer style="<%=rowSty%> height:49px;">
					<% SelectedRow=""%>
					<%
						If LinksTo > 0 Then 																																
							relSQL="SELECT RelationshipId FROM ContactContacts WHERE MasterId="&ContactID				 
							Set relRS=Server.CreateObject("AdoDB.RecordSet")
							relRS.Open relSQL, REDConnString
								
							If Not relRS.EOF Then
								relationShipField="DetailRName"
							Else
								Set relRS=Nothing
								relSQL="SELECT RelationshipId FROM ContactContacts WHERE DetailId="&ContactID
								Set relRS=Server.CreateObject("AdoDB.RecordSet")
								relRS.Open relSQL, REDConnString
								relationShipField="MasterRName"
							End If
							
							relNameSQL="SELECT "&relationShipField&" FROM ContactRelationships WHERE Id="&relRS("RelationShipID") 
							Set relNameRS=Server.CreateObject("AdoDB.RecordSet")
							relNameRS.Open relNameSQL, REDConnString
							If relNameRS.EOF Then Relationship="unknown" Else Relationship=relNameRS(relationShipField)							
							%>	
							<div id=RelationShip<%=rowC%> class="w33p taC fL"><%=Relationship%></div>
							<div id=ItemName<%=rowC%> class="w33p taC fL">
								<a id=cName<%=rowC%> class=cName href=Contact.asp?id=<%=ContactID%> target=_parent onMouseDown="<%=md%>" style="<%=rowSty%>" ><%=cName%></a>
								<a id=email<%=rowC%> class=cName href=mailto:<%=email%> ><%=email%></a>
							</div>
							<div id=ItemPhone<%=rowC%> class="w33p taC fL" ><%=Phone(rs("Phone1"))%></div>
							
							<%
						Else %>
							<div id="check<%=rowC%>" class="ItemCheck">
								<label class="w100p h100p dB"><input id=sel<%=rowC%> class=ItemCheckBox type=checkbox /></label>
							</div>
							<div id="ContactID<%=rowC%>" class="ItemId"><%=rs("ID")%></div>
							<div id=ItemName<%=rowC%> class=ItemName>
								<%MD="sessionWrite('ShownContacts',Gebi('selShowContacts').selectedIndex);"%>
								<a id=cName<%=rowC%> class=cName href=Contact.asp?id=<%=ContactID%> target=_parent onMouseDown="<%=md%>" style="<%=rowSty%>" ><%=cName%></a>
								<a id=email<%=rowC%> class=cName href=mailto:<%=email%> ><%=email%></a>
							</div>
								
							<div id=ItemAddr<%=rowC%> class=ItemAddr ><%=DecodeChars(rs("Address")&"<br/>"&rs("City")&", "&rs("State")&" "&rs("Zip"))%></div>
							<div id=ItemPhone<%=rowC%> class=ItemPhone ><%=Phone(rs("Phone1"))%></div>
							<div id=ItemFax<%=rowC%> class=ItemPhone ><%=Phone(rs("Fax"))%></div>
							<div id=ItemNotes<%=rowC%> class=ItemNotes title="<%=DecodeChars(rs("Notes"))%>" ><%=DecodeChars(rs("Notes"))%></div>
					<% End If %>
				</div>
				<%
				'response.Flush()
				rs.MoveNext : if rs.EOF Then  Session("ContactListStart")="" Else Session("ContactListStart")=rowC+1
			Loop
			
			If LinksTo<0 Then
				Refine1=""
				Refine2=" results "
				If rowC>=ListMax Then
					Refine1="Maximum of "
					Refine2=" results reached.  Please refine your search."
				End If
			Else
				%><br/><div id=RowContainer<%=rowC+1%> class="RowContainer" ><button id=newLink class=tButton24x0 title="Choose an existing Contact to link to this one." onClick="parent.ShowLinker();"><img src=../Images/plus_16.png /> Link another contact.</button></div><%
			End If
			%><div style="width:100%;">&nbsp; &nbsp; &nbsp;<%=Refine1%><%=rowC%><%=Refine2%></div><%
		End If
		%>
	</div>
</div>
<script type="text/javascript">Gebi('Loading').style.display='none';</script>
</body>
</html>


<!--#include file="../TMC/RED.asp" -->
<%
Response.ContentType = "text/xml"
If Request.QueryString("html")=1 Then Response.ContentType = "text/html"
Response.Buffer="false"
sAction = lcase(CStr(Request.QueryString("action")))
%>
<root>
	<action><%=sAction%></action>
	<QueryString><%=EncodeChars(Request.QueryString())%></QueryString>
<%

Select Case sAction
	
	Case "savenewbid"'-------------------------------------------------------------------------------------------------------------------
		pName = CStr(Request.QueryString("name"))
		city = CStr(Request.QueryString("city")) 
		address = CStr(Request.QueryString("address"))
		pState = CStr(Request.QueryString("state"))
		zip = CStr(Request.QueryString("zip"))
		%><sqFeet><%=Request.QueryString("sqFeet")%></sqFeet><%
		sqFeet = CLng(Request.QueryString("sqFeet"))
		floors = CInt(Request.QueryString("floors"))
		newBid = (Request.QueryString("newBid"))
		pDate = Date()
		
		cKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID
		SQL="INSERT INTO Projects (ProjName, ProjAddress, ProjCity, ProjState, ProjZip, SqFoot, Floors, DateEnt, Use2010Bidder, CreationKey)"
		SQL=SQL&" VALUES ('"&pName&"', '"&address&"', '"&city&"', '"&pState&"', '"&zip&"', "&sqFeet&", "&floors&", '"&pDate&"', '"&newBid&"', '"&cKey&"')"
		%><SQL><%=SQL%></SQL><%
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring	
		
		Set rs=Nothing
	
		SQL="SELECT ProjID FROM Projects WHERE CreationKey='"&cKey&"'"
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring	
		
		If Not rs.EOF Then
			%><projId><%=rs("ProjID")%></projId><%
		End If
		
		Set rs=Nothing
		
		
		
	
	Case "searchcust"'-----------------------------------------------------------------------------------------------------------------
		search=Request.QueryString("search")
		
		SQL="SELECT ID, Name FROM Contacts WHERE Customer=1 AND Name LIKE '%"&search&"%' ORDER BY Name"
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		r=0
		Do Until rs.EOF
			r=r+1
			%><%="<custId"&r&">"&rs("ID")&"</custId"&r&">"%><%
			%><%="<name"&r&">"&rs("Name")&"</name"&r&">"%><%
			rs.MoveNext
		Loop
		%><recordCount>00<%=r%></recordCount><%
		Set rs=Nothing
		
	
	Case "searchmonprovider"'-----------------------------------------------------------------------------------------------------------------
		search=Request.QueryString("search")
		
		mpSQL="SELECT ContactID FROM ContactsType WHERE TypeID=6"
		Set mpRS=Server.CreateObject("AdoDB.RecordSet")
		mpRS.Open mpSQL, REDConnString
		If mpRS.EOF Then Response.End()
		
		mpIdList=""
		Do Until mpRS.EOF
			If mpIdList<>"" Then mpIdList=mpIdList&" OR "
			mpIdList=mpIdList&"ID="&mpRS("ContactID")
			mpRS.MoveNext
		Loop
		
		%><mpil><%=mpIdList%></mpil><%
		
		SQL="SELECT ID, Name FROM Contacts WHERE ("&mpIdList&") AND Name LIKE '%"&search&"%' ORDER BY Name"
		%><sql><%=SQL%></sql><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		r=0
		Do Until rs.EOF
			r=r+1
			%><%="<custId"&r&">"&rs("ID")&"</custId"&r&">"%><%
			%><%="<name"&r&">"&rs("Name")&"</name"&r&">"%><%
			rs.MoveNext
		Loop
		%><recordCount>00<%=r%></recordCount><%
		Set rs=Nothing
		
	
	Case "delproj"'-------------------------------------------------------------------------------------------------------------------
		
		projId=Request.QueryString("projId")
		
		If projId<>"" Then
			
			SQL="SELECT SectionID FROM Sections WHERE ProjectID="&projId
			set secRS=Server.CreateObject("ADODB.Recordset")
			secRS.Open SQL, REDconnstring	
			
			
			Do Until secRS.EOF
				SQL1="DELETE FROM BidItems WHERE SecID="&secRS("SectionID")
				set rs1=Server.CreateObject("ADODB.Recordset")
				rs1.Open SQL1, REDconnstring	
				set rs1=Nothing
				
				SQL2="DELETE FROM Expenses WHERE SecID="&secRS("SectionID")
				set rs2=Server.CreateObject("ADODB.Recordset")
				rs2.Open SQL2, REDconnstring	
				set rs2=Nothing

				SQL3="DELETE FROM Sections WHERE SectionID="&secRS("SectionID")
				set rs3=Server.CreateObject("ADODB.Recordset")
				rs3.Open SQL3, REDconnstring	
				set rs3=Nothing
				%>
				<SQL1><%=SQL1%></SQL1>
				<SQL2><%=SQL2%></SQL2>
				<SQL3><%=SQL3%></SQL3>
				<%
				secRS.MoveNext
			Loop
			Set SecRS=Nothing
			
			SQL4="DELETE FROM Projects WHERE ProjID="&projId
			set rs4=Server.CreateObject("ADODB.Recordset")
			rs4.Open SQL4, REDconnstring	
			set rs4=Nothing
			
			%>
			<SQL><%=SQL%></SQL>
			<SQL1><%=SQL1%></SQL1>
			<SQL2><%=SQL2%></SQL2>
			<SQL3><%=SQL3%></SQL3>
			<SQL4><%=SQL4%></SQL4>
			<%
		Else
			%>
			<error>ProjID is null.</error>
			<%
		End If
	
	Case "delsec"'-------------------------------------------------------------------------------------------------------------------
		
		secId=Request.QueryString("SecId")
		SQL1="DELETE FROM BidItems WHERE SecID="&secId
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring	
		set rs1=Nothing
		
		SQL2="DELETE FROM Expenses WHERE SecID="&secId
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring	
		set rs2=Nothing

		SQL3="DELETE FROM Sections WHERE SectionID="&secId
		set rs3=Server.CreateObject("ADODB.Recordset")
		rs3.Open SQL3, REDconnstring	
		set rs3=Nothing
		%>
		<SQL1><%=SQL1%></SQL1>
		<SQL2><%=SQL2%></SQL2>
		<SQL3><%=SQL3%></SQL3>
		<%

	
	Case "savenewsec"'-------------------------------------------------------------------------------------------------------------------
		
		section=Request.queryString("section")
		projId=Request.queryString("projId")
		SQL="INSERT INTO Sections (selected, Section, DateEntered, EnteredBy, EnteredByID, ProjectID) VALUES ('True', '"&EncodeChars(section)&"', '"&Date&"', '"&session("userName")&"', "&session("EmpID")&", "&projId&")"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.createObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		Set rs=Nothing
		
		
	Case "addpart"'-------------------------------------------------------------------------------------------------------------------
		
		SecID = CStr(Request.QueryString("SecID"))
		PartID = CStr(Request.QueryString("PartID"))
		costing = Request.QueryString("costing")
		if costing <> 1 Then costing=0
		
		'MU = CStr(Request.QueryString("MU"))
		CreationKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID
		If PartID="0" Then 
			SQLValues="VALUES ("&SecID&",'-','0','-','-',0,0,0,'Part',"&costing&", '"&CreationKey&"')"
		Else
			SQL1 = "SELECT * FROM Parts WHERE PartsID = "&PartID
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			Cost = rs1("Cost")
			'Sell = (((Cost*MU)/100)+Cost)	
			Desc=EncodeChars(rs1("Description"))
			
			SQLValues=" VALUES ("&SecID&",'"&rs1("Manufacturer")&"',"&PartID&",'"&rs1("PartNumber")&"','"&Desc&"',0"&Cost&", 0"&rs1("LaborValue")&", 0, 'Part',"&costing&", '"&CreationKey&"')"
		End If
		
		SQL2="INSERT INTO BidItems (SecID,Manufacturer,PartID,ItemName,ItemDescription,Cost,LaborValue,Qty,Type,editable,CreationKey)"
		SQL2=SQL2&SQLValues
		%><SQL2><%=SQL2%></SQL2><%
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		set rs1 = nothing
		set rs2 = nothing
		
		SQL3="SELECT BidItemsID FROM BidItems WHERE CreationKey ='"&CreationKey&"'"
		Set rs3 = Server.CreateObject("AdoDB.RecordSet")
		rs3.Open SQL3, REDConnString

		BidItemsID=rs3("BidItemsID")

		Set rs3=Nothing
		%>
		<SecID><%=SecID%></SecID>
		<ProjID><%=PartID%></ProjID>
		<PartID><%=PartID%></PartID>
		<BidItemsID><%=BidItemsID%></BidItemsID>
		<%
		
	
	
	Case "addpresetpart"'-------------------------------------------------------------------------------------------------------------------
		
		pId = CStr(Request.QueryString("pId"))
		PartID = CStr(Request.QueryString("PartID"))
		
		CreationKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID

		SQL1 = "SELECT Cost, Manufacturer, PartNumber, Description FROM Parts WHERE PartsID = "&PartID
			set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Cost = rs1("Cost")
		
		SQL2="INSERT INTO BidPresetItems (BidPresetID,ItemID,Qty,Type,CreationKey) VALUES ("&pId&","&PartID&",0,'Part','"&CreationKey&"')"
		%><SQL2><%=SQL2%></SQL2><%
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		
		SQL3="SELECT BidPresetItemsID FROM BidPresetItems WHERE CreationKey ='"&CreationKey&"'"
		Set rs3 = Server.CreateObject("AdoDB.RecordSet")
		rs3.Open SQL3, REDConnString

		BidPresetItemsID=rs3("BidPresetItemsID")

		%>
		<pId><%=pId%></pId>
		<PartID><%=PartID%></PartID>
		<BidPresetItemsId><%=BidPresetItemsID%></BidPresetItemsId>
		<Cost>0<%=rs1("Cost")%></Cost>
		<Manufacturer>--<%=rs1("Manufacturer")%></Manufacturer>
		<PN>--<%=rs1("PartNumber")%></PN>
		<Desc>--<%=rs1("Description")%></Desc>
		<%
		set rs1 = nothing
		set rs2 = nothing
		Set rs3 = Nothing
		
	
	
	Case "addlabor"'-------------------------------------------------------------------------------------------------------------------
		
		SecID = Request.QueryString("SecID")
		LaborID=Request.QueryString("LaborID")
		costing = Request.QueryString("costing")
		if costing <> 1 Then costing=0
		'MU = CStr(Request.QueryString("MU"))
		
		CreationKey=Date&Timer&Session.SessionID
		
		If LaborID="" Then 
			SQLValues="VALUES ("&SecID&",'-','-',55,0,'Labor', "&costing&", '"&CreationKey&"')"
		Else
			SQL1 = "SELECT * FROM Labor WHERE LaborID = "&LaborID
			%><SQL1><%=SQL1%></SQL1><%
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			
			SQLValues="VALUES ("&SecID&",'"&rs1("Name")&"','"&rs1("Description")&"',0"&Cost&",0,'Labor', "&costing&", '"&CreationKey&"')"

		End If
		
		SQL="INSERT INTO BidItems (SecID,ItemName,ItemDescription,Cost,Qty,Type,editable,CreationKey)"
		SQL=SQL&SQLValues
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring
		
		set rs = nothing
		
		SQL2="SELECT BidItemsID FROM BidItems WHERE CreationKey ='"&CreationKey&"'"
		Set rs2 = Server.CreateObject("AdoDB.RecordSet")
		rs2.Open SQL2, REDConnString

		BidItemsID=rs2("BidItemsID")

		Set rs3=Nothing
		%>
		<SecID><%=SecID%></SecID>
		<ProjID><%=PartID%></ProjID>
		<SQL><%=SQL%></SQL>
		<SQL2><%=SQL2%></SQL2>
		<LaborID><%=LaborID%></LaborID>
		<BidItemsID><%=BidItemsID%></BidItemsID>
		<%
		
	
	
	Case "addpresetlabor"'-------------------------------------------------------------------------------------------------------------------
		
		pId = CStr(Request.QueryString("pId"))
		LaborID = CStr(Request.QueryString("LaborID"))
		
		CreationKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID

		SQL1 = "SELECT RateCost, Name, Category, Description FROM Labor WHERE LaborID = "&LaborID
			set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Cost = rs1("RateCost")
		
		SQL2="INSERT INTO BidPresetItems (BidPresetID,ItemID,Qty,Type,CreationKey) VALUES ("&pId&","&LaborID&",0,'Labor','"&CreationKey&"')"
		%><SQL2><%=SQL2%></SQL2><%
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		
		SQL3="SELECT BidPresetItemsID FROM BidPresetItems WHERE CreationKey ='"&CreationKey&"'"
		Set rs3 = Server.CreateObject("AdoDB.RecordSet")
		rs3.Open SQL3, REDConnString

		BidPresetItemsID=rs3("BidPresetItemsID")

		%>
		<pId><%=pId%></pId>
		<LaborID><%=LaborID%></LaborID>
		<BidPresetItemsId><%=BidPresetItemsID%></BidPresetItemsId>
		<Cost>0<%=rs1("RateCost")%></Cost>
		<LaborName>--<%=rs1("Name")%></LaborName>
		<Category>--<%=rs1("Category")%></Category>
		<Desc>--<%=rs1("Description")%></Desc>
		<%
		set rs1 = nothing
		set rs2 = nothing
		Set rs3 = Nothing
		
	
	
	Case "partslist"'-------------------------------------------------------------------------------------------------------------------
		
		secId=Request.QueryString("secId")
		matOrder=""
		If session("MaterialListSortBy")<>"" Then matOrder=" ORDER BY "&session("MaterialListSortBy")
		
		SQL2="SELECT MU FROM Sections WHERE SectionID="&secID
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.open SQL2, REDConnString
		MU=rs2("MU")
		%><MU>0<%=rs2("MU")%></MU><%
		Set rs2=Nothing		
		
		SQL="SELECT BidItemsID, Manufacturer, ItemName, ItemDescription, IsNull(Qty,0) AS Qty, ActualQty, IsNull(Cost,0) AS Cost, CostDiff, Cost*Qty AS CTotal, Cost+(Cost*"&MU&") AS Sell, (Cost+(Cost*"&MU&"))*Qty AS STotal, editable FROM BidItems WHERE SecID="&secId&" AND Type='Part'"&matOrder
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.open SQL, REDConnString
		
		r=0
		Do Until rs.EOF
			r=r+1
			%>
			<%="<BidItemsID"&r&">"&rs("BidItemsID")&"</BidItemsID"&r&">"%>
			<%="<Manufacturer"&r&">--"&rs("Manufacturer")&"</Manufacturer"&r&">"%>
			<%="<ItemName"&r&">--"&rs("ItemName")&"</ItemName"&r&">"%>
			<%="<ItemDescription"&r&">--"&rs("ItemDescription")&"</ItemDescription"&r&">"%>
			<%="<Qty"&r&">0"&rs("Qty")&"</Qty"&r&">"%>
			<%="<ActualQty"&r&">0"&rs("ActualQty")&"</ActualQty"&r&">"%>
			<%="<Cost"&r&">0"&rs("Cost")&"</Cost"&r&">"%>
			<%="<CostDiff"&r&">0"&rs("CostDiff")&"</CostDiff"&r&">"%>
			<%="<editable"&r&">"&rs("editable")&"</editable"&r&">"%>
			<%
			rs.MoveNext
		Loop
		%>
		<recordCount>0<%=r%></recordCount>
		<%
		
	Case "laborlist"'-------------------------------------------------------------------------------------------------------------------
		
		secId=Request.QueryString("secId")
		
		SQL="SELECT BidItemsID, ItemName, ItemDescription, Qty, ActualQty, Cost, CostDiff, editable FROM BidItems WHERE SecID="&secId&" AND Type='Labor'"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.open SQL, REDConnString
		
		SQL2="SELECT MU FROM Sections WHERE SectionID="&secID
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.open SQL2, REDConnString
		%><MU>0<%=rs2("MU")%></MU><%

		r=0
		Do Until rs.EOF
			r=r+1
			%>
			<%="<BidItemsID"&r&">"&rs("BidItemsID")&"</BidItemsID"&r&">"%>
			<%="<ItemName"&r&">"&rs("ItemName")&"</ItemName"&r&">"%>
			<%="<ItemDescription"&r&">"&rs("ItemDescription")&"</ItemDescription"&r&">"%>
			<%="<Qty"&r&">"&rs("Qty")&"</Qty"&r&">"%>
			<%="<ActualQty"&r&">0"&rs("ActualQty")&"</ActualQty"&r&">"%>
			<%="<Cost"&r&">0"&rs("Cost")&"</Cost"&r&">"%>
			<%="<CostDiff"&r&">0"&rs("CostDiff")&"</CostDiff"&r&">"%>
			<%="<editable"&r&">"&rs("editable")&"</editable"&r&">"%>
			<%
			rs.MoveNext
		Loop
		%>
		<recordCount>0<%=r%></recordCount>
		<%
		
		
		
	Case "expenselist"'-------------------------------------------------------------------------------------------------------------------
		
		secId=Request.QueryString("secId")
		expenseType=Request.QueryString("Type")
		
		SQL="SELECT ExpenseID, SubType, Origin, Destination, UnitCost, Units, ActualUnits, editable FROM Expenses WHERE SecID="&secId&" AND Type='"&expenseType&"'"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.open SQL, REDConnString
		
		r=0
		Do Until rs.EOF
			r=r+1
			
			SubType=rs("SubType")
			If SubType="" Then SubType=" "
			
			If lcase(expenseType)="travel" Then
				ttSQL="SELECT Unit FROM TravelType WHERE Type='"&SubType&"'"
				%><ttSQL><%=ttSQL%></ttSQL><%
				Set ttRS=Server.CreateObject("AdoDB.Recordset")
				ttRS.Open ttSQL, REDConnString
				
				If ttRS.EOF Then 
					Unit="Unit"
				Else
					Unit=ttRS("Unit")
				End If
			End If
			Set ttRS=Nothing
			
			Cost=DecodeChars(rs("UnitCost"))
			Cost = Replace(Cost,"$","")
			Do While Cost <> Replace(Cost,",","")
				Cost = Replace(Cost,",","")
			Loop
			
			Qty=rs("Units")
			ActualQty=rs("ActualUnits")
			If ActualQty<>1 Then Unit=Unit+"s"
			
			editable=rs("editable") : if editable="" or IsNull(editable) Then editable="True"
			%>
			<%="<ExpenseID"&r&">"&rs("ExpenseID")&"</ExpenseID"&r&">"%>
			<%="<SubType"&r&">"&SubType&"</SubType"&r&">"%>
			<%="<Units"&r&">0"&Qty&"</Units"&r&">"%>
			<%="<ActualUnits"&r&">0"&ActualQty&"</ActualUnits"&r&">"%>
			<%="<UnitCost"&r&">"&Cost&"</UnitCost"&r&">"%>
			<%="<editable"&r&">"&editable&"</editable"&r&">"%>
			<%
			If lcase(expenseType)="travel" Then
				%>
				<%="<Origin"&r&">--"&rs("Origin")&"</Origin"&r&">"%>
				<%="<Destination"&r&">--"&rs("Destination")&"</Destination"&r&">"%>
				<%="<Unit"&r&">--"&Unit&"</Unit"&r&">"%>
				<%
			End If
			rs.MoveNext
		Loop
		%>
		<recordCount>0<%=r%></recordCount>
		<%
		
		
		
		
		
	Case "addexpense"'-------------------------------------------------------------------------------------------------------------------
		
		SecID = CStr(Request.QueryString("SecID"))
		expenseType = CStr(Request.QueryString("Type"))
		SubType = CStr(Request.QueryString("SubType"))
		Origin = CStr(Request.QueryString("Origin"))
		Dest = CStr(Request.QueryString("Dest"))
		Units = Request.QueryString("Units")
		Cost = CStr(Request.QueryString("Cost"))
		costing = Request.QueryString("costing")
		if costing <> 1 Then costing=0
		
		ActualUnits=0
		If costing=1 then
			ActualUnits=Units
			Units=0
		End If
		
		CreationKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID
		
		SQLValues=" VALUES ("&SecID&",'"&expenseType&"','"&SubType&"','"&Origin&"','"&Dest&"',"&Units&","&ActualUnits&", "&Cost&", "&costing&", '"&CreationKey&"')"
		
		SQL="INSERT INTO Expenses (SecID,Type,SubType,Origin,Destination,Units,ActualUnits,UnitCost,editable,CreationKey)"&SQLValues
		%><SQL><%=SQL%></SQL><%
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring
		
		set rs = nothing
		
		SQL1="SELECT ExpenseID FROM Expenses WHERE CreationKey ='"&CreationKey&"'"
		Set rs1 = Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString

		ExpenseID=rs1("ExpenseID")

		Set rs1=Nothing
		
		%>
		<SecID><%=SecID%></SecID>
		<ExpenseID><%=ExpenseID%></ExpenseID>
		<Type><%=expenseType%></Type>
		<SubType><%=SubType%></SubType>
		<Origin><%=Origin%></Origin>
		<Destination><%=Destination%></Destination>
		<Units><%=Units%></Units>
		<Cost><%=Cost%></Cost>
		<CreationKey><%=CreationKey%></CreationKey>
		<%
	
	
		
	Case "loadpreset"'-------------------------------------------------------------------------------------------------------------------
		SecID = CStr(Request.QueryString("SecID"))
		PresetID=Request.QueryString("PresetID")
		
		SQL="SELECT Type, ItemID, Qty FROM BidPresetItems WHERE BidPresetID="&PresetID&""
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		r=0
		Do Until rs.EOF
			r=r+1
			
			Select Case lcase(rs("Type"))
				Case "part"
					SQL1="SELECT PartsID, Manufacturer, PartNumber, Description, LaborValue, Cost, Category1 FROM Parts WHERE PartsID="&rs("ItemID")
					
				Case "labor"
					SQL1="SELECT LaborID, Name, Description, RateCost FROM Labor WHERE LaborID="&rs("ItemID")
			End Select
					
			%><%="<SQL1-"&r&">"&SQL1&"</SQL1-"&r&">"%><%
			Set rs1=Server.CreateObject("AdoDB.RecordSet")
			rs1.Open SQL1, REDConnString
			
			If Not rs1.EOF Then
				Select Case lCase(rs("Type"))
					Case "part"
						Fieldz="SecID, PartID, Manufacturer, ItemName, ItemDescription, LaborValue, Qty, Type, Cost, Category"
						Values=SecId&","&rs1("PartsID")&",'"&rs1("Manufacturer")&"','"&rs1("PartNumber")&"','"&rs1("Description")&"',0"&rs1("LaborValue")&",0"&rs("Qty")&",'Part',"&rs1("Cost")&",'"&rs1("Category1")&"'"
						
					Case "labor"
						Fieldz="SecID, PartID, ItemName, ItemDescription, Qty, Type, Cost"
						Values=SecId&","&rs1("LaborID")&",'"&rs1("Name")&"','"&rs1("Description")&"',"&rs("Qty")&",'Labor',"&rs1("RateCost")
			
				End Select
				
				SQL2="INSERT INTO BidItems ("&Fieldz&") VALUES ("&Values&")"
				%><%="<SQL2-"&r&">"&SQL2&"</SQL2-"&r&">"%><%
				Set rs2=Server.CreateObject("AdoDB.RecordSet")
				rs2.Open SQL2, REDConnString
			End If

			rs.MoveNext
		Loop
		
		SQL0="SELECT Type, Qty, Mfr, Name, Description, Cost, LaborValue FROM CustomPresetItems WHERE BidPresetID="&PresetID&""
		%><SQL0><%=SQL0%></SQL0><%
		Set rs0=Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		r=0
		Do Until rs.EOF
			r=r+1			
			
			Select Case lcase(rs0("Type"))
				Case "part"
					Fieldz="SecID, Manufacturer, ItemName, ItemDescription, LaborValue, Qty, Type, Cost"
					Values=SecId&",'"&rs0("Mfr")&"','"&rs0("Name")&"','"&rs0("Description")&"',0"&rs1("LaborValue")&",0"&rs("Qty")&",'Part',"&rs1("Cost")
				Case "labor"
					Fieldz="SecID, ItemName, ItemDescription, Qty, Type, Cost"
					Values=SecId&",'"&rs0("Name")&"','"&rs0("Description")&"',"&rs("Qty")&",'Labor',"&rs0("Cost")
			End Select
			SQL6="INSERT INTO BidItems ("&Fieldz&") VALUES ("&Values&")"
			%><%="<SQL6-"&r&">"&SQL6&"</SQL6-"&r&">"%><%
			Set rs6=Server.CreateObject("AdoDB.RecordSet")
			rs6.Open SQL6, REDConnString
	
			rs0.MoveNext
		Loop
		
		SQL="SELECT Notes, Includes, Excludes FROM Sections WHERE SectionID="&SecID&""
		%><SQL4><%=SQL%></SQL4><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		If Not rs.EOF Then
			Scope=rs("Notes")
			Includes=rs("Includes")
			Excludes=rs("Excludes")
		End If

		SQL="SELECT Scope, Includes, Excludes FROM BidPresets WHERE BidPresetID="&PresetID&""
		%><SQL5><%=SQL%></SQL5><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		If Not rs.EOF Then
			SQL3="UPDATE Sections SET Notes='"&rs("Scope")&"_CR_"&Scope&"', Includes='"&rs("Includes")&"_CR_"&Includes&"', Excludes='"&rs("Excludes")&"_CR_"&Excludes&"' WHERE SectionID="&SecID	
		%><SQL3><%=SQL3%></SQL3><%
			Set rs3=Server.CreateObject("AdoDB.RecordSet")
			rs3.Open SQL3, REDConnString
			set rs3=Nothing
			
		End If
		
		Set rs=Nothing
	
	
	
	case "copybid"'----------------------------------------------------------------------------------------------------------------
		SecID = Request.QueryString("SecID")
		SecType=CStr(Request.QueryString("SecType"))
		SecTypeID=Request.QueryString("SecTypeID")
		Preset=CStr(Request.QueryString("Preset"))
		copyQty=Request.QueryString("copyQty")
		if copyQty<>1 Then copyQty=0
		
		SQL0="SELECT Notes,Includes,Excludes FROM Sections WHERE SectionID="&SecID
		%><%=SQL0%><%
		Set rs0=Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		
		Scope=rs0("Notes")
		Includes=rs0("Includes")
		Excludes=rs0("Excludes")
		
		creationKey=newCreationKey()
				
		SQL="INSERT INTO BidPresets (BidPresetSectionID,BidPresetSection,BidPresetName,Scope,Includes,Excludes,creationKey)"
		SQL=SQL&" VALUES ("&SecTypeID&",'"&SecType&"','"&Preset&"','"&Scope&"','"&Includes&"','"&Excludes&"','"&creationKey&"')"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		SQL1="SELECT BidPresetID FROM BidPresets WHERE creationKey='"&creationKey&"'"
		%><SQL1><%=SQL1%></SQL1><%
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		PresetID=rs1("BidPresetID")
		
		set rs0=Nothing
		set rs=Nothing
		set rs1=Nothing
				
		SQL2="SELECT PartID, Manufacturer, ItemName, ItemDescription, Type, Cost, Category, Qty FROM BidItems WHERE SecID="&SecID&" ORDER BY Type"
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2= Server.CreateObject("AdoDB.RecordSet")
		rs2.Open SQL2, REDConnString
		
		bII=0
		Do Until rs2.eof
			bII=bII+1
			iType=lcase(rs2("Type"))
			iPartID="0"&rs2("PartID")
			iMfr=EncodeChars(rs2("Manufacturer"))
			iName=EncodeChars(rs2("ItemName"))
			iDesc=EncodeChars(rs2("ItemDescription"))
			iCost=EncodeChars(rs2("Cost"))
			iCat=EncodeChars(rs2("Category"))
			iQty="0"&Cstr(rs2("Qty"))
			%><%="<Type"&bII&">--"&iType&"</Type"&bII&">"%><%
			%><%="<Mfr"&bII&">--"&iMfr&"</Mfr"&bII&">"%><%
			%><%="<iName"&bII&">--"&iName&"</iName"&bII&">"%><%
			%><%="<Desc"&bII&">--"&iDesc&"</Desc"&bII&">"%><%
			%><%="<Cost"&bII&">--"&iCost&"</Cost"&bII&">"%><%
			%><%="<Cat"&bII&">--"&iCat&"</Cat"&bII&">"%><%
			%><%="<Qty"&bII&">"&iQty&"</Qty"&bII&">"%><%
			
			CustomPart=( (iPartID="") OR IsNull(iPartID) OR (iPartID=0) )
			'If no PartID, match PN -Dangerous if 2 Mfr's have same PN's. --no issues yet 6-4-12. Obsolete in <2 years.
			If CustomPart and iType="part" Then 
				SQL5="SELECT PartsID FROM Parts WHERE PartNumber='"&iName&"'"
				set rs5=Server.CreateObject("AdoDB.RecordSet")
				rs5.Open SQL5, REDConnString
				if not rs5.eof Then 
					iPartID=rs5("PartsID")
					CustomPart=( (iPartID="") OR IsNull(iPartID) OR (iPartID=0) )
				End If
			End If
			
			If CustomPart and iType="labor" Then 
				SQL5="SELECT LaborID FROM Labor WHERE Name='"&iName&"'"
				set rs5=Server.CreateObject("AdoDB.RecordSet")
				rs5.Open SQL5, REDConnString
				if not rs5.eof Then 
					iPartID=rs5("LaborID")
					CustomPart=( (iPartID="") OR IsNull(iPartID) OR (iPartID=0) )
				End If
			End If
			
			%><%="<PartID"&bII&">"&iPartID&"</PartID"&bII&">"%><%
			%><%="<CustomPart"&bII&">"&CustomPart&"</CustomPart"&bII&">"%><%
			
			If CustomPart Then 
				'unknownItemData=iType&"#"&iQty&"#"&iMfr&"#"&iName&"#"&iDesc&"#"&iCost
				Qty=CSng(iQty)*copyQty
				SQL3="INSERT INTO CustomPresetItems (BidPresetID,Type,Qty,Mfr,Name,Description,Cost) VALUES "
				SQL3=SQL3&"("&PresetID&",'"&iType&"',"&Qty&",'"&iMfr&"','"&iName&"','"&iDesc&"',"&iCost&")"
				%><%="<SQL3-"&bII&">"&SQL3&"</SQL3-"&bII&">"%><%
				Set rs3= Server.CreateObject("AdoDB.RecordSet")
				rs3.Open SQL3, REDConnString
				Set rs3=Nothing
			Else 'Grab from Database
				Qty=CSng(iQty)*copyQty
				SQL4="INSERT INTO BidPresetItems (BidPresetID,Type,ItemID,Qty) VALUES ("&PresetID&",'"&iType&"',"&iPartID&","&Qty&")"
				%><%="<SQL4-"&bII&">"&SQL4&"</SQL4-"&bII&">"%><%
				Set rs4= Server.CreateObject("AdoDB.RecordSet")
				rs4.Open SQL4, REDConnString
				Set rs4=Nothing
			End If
			'% ><%="<unknownItem"&bII&">--"&unknownItemData&"</unknownItem"&bII&">"% ><%
			
			
			
			
			rs2.MoveNext
		Loop
		
		%><%="<bidItemCount>"&bII&"</bidItemCount>"%><%
		%><%="<newPId>"&rs2.RecordCount&"</newPId>"%><%
		
		
	case "sectioncost"'-------------------------------------------------------------------------------------------------------------------
		SecID = CStr(Request.QueryString("SecID"))
		
		SQL0="SELECT SectionID, ProjectID, MU, TaxRate, Overhead, FixedPrice, Round, TotalFixed FROM Sections WHERE SectionID="&SecID
		%><SQL0><%=SQL0%></SQL0><%
		Set rs0=Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		MU=rs0("MU")
		fixedTotal=rs0("FixedPrice")
		projId=rs0("ProjectID")
		taxRate=rs0("TaxRate")
		Overhead=rs0("Overhead")
		roundUp=rs0("Round")
		totalFixed=rs0("TotalFixed")
		%><fixedTotal>0<%=fixedTotal%></fixedTotal><%
		%><roundUp>--<%=roundUp%></roundUp><%
		%><totalFixed>--<%=totalFixed%></totalFixed><%
		Set rs0=Nothing
		
		SQL="SELECT Use2010Bidder FROM Projects WHERE ProjID="&ProjID
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		useNewBidder=rs("use2010Bidder")
		'If useNewBidder="True" Then useNewBidder = True  Else  useNewBidder=False
		%><useNewBidder><%=useNewBidder%></useNewBidder><%
		
		parts=0
		labor=0
		travel=0
		equip=0
		other=0
		aParts=0
		aLabor=0
		aTravel=0
		aEquip=0
		aOther=0
		
		SQL1="SELECT Cost, Qty, ActualQty, Type FROM BidItems WHERE SecID="&SecID&" ORDER BY Type"
		%><SQL1><%=SQL1%></SQL1><%
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.open SQL1, REDConnString
		
		%><BidItems><%
		r=0
		Do Until rs1.EOF
			r=r+1
			Qty=rs1("Qty")  'Reminder: We may have negative quantities, for example, credits or alternates.
			If Qty="" OR ISNull(Qty) Then Qty=0
			ActualQty=rs1("ActualQty") : If ActualQty="" Then ActualQty=0  'Shouldn't have actual negatives... If we get into the demo business, we may want to consider it tho.
			
			If lCase(rs1("Type")) = "1" or lCase(rs1("Type")) = "labor" Then
				labor=labor+(rs1("Cost")*Qty) 
				aLabor=aLabor+(rs1("Cost")*ActualQty)
			Else
				%>"<info><br/>Parts = <%=parts%>+(<%=rs1("Cost")%>*<%=Qty%>) <br/></info><%
				parts=parts+(rs1("Cost")*Qty)
				aParts=aParts+(rs1("Cost")*ActualQty)
			End If
			
			%><%="<item"&r&">"%><%
			%><%="	<type"&r&">"&lCase(rs1("Type"))&"</type"&r&">"%><%
			%><%="	<qty"&r&">"&lCase(Qty)&"</qty"&r&">"%><%
			%><%="	<cost"&r&">"&lCase(rs1("Cost"))&"</cost"&r&">"%><%
			%><%="	<total"&r&">"&lCase(rs1("Cost")*Qty)&"</total"&r&">"%><%
			%><%="</item"&r&">"%><%
			%><%="<runningPartsTotal"&r&">"%><%=parts%><%="</runningPartsTotal"&r&">"%><%
			
			rs1.moveNext
		Loop
		%></BidItems><%
		
		
		
		SQL2="SELECT UnitCost, Units, ActualUnits, [Type] AS eType FROM Expenses WHERE SecID="&SecID&" AND editable!=1 ORDER BY Type"
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.open SQL2, REDConnString
		
		%><Expenses><%
		r=0
		Do Until rs2.EOF
			r=r+1
			UnitCost=rs2("UnitCost")
			UnitCost=UnCurrency(UnitCost)
			If UnitCost="" Then UnitCost=0
			Qty=rs2("Units") : If Qty="" Then Qty=0
			ActualQty=rs2("ActualUnits") : If ActualQty="" Then ActualQty=0
			
			Select Case lCase(rs2("eType"))
					
				Case "travel"', "0"
					travel=travel+(UnitCost*Qty)
					aTravel=aTravel+(UnitCost*ActualQty)
				Case "0"
					travel=travel+(UnitCost*Qty)
					aTravel=aTravel+(UnitCost*ActualQty)
			
				Case "equip"', "1"
					equip=equip+(UnitCost*Qty)
					aEquip=aEquip+(UnitCost*ActualQty)
				Case "1"
					equip=equip+(UnitCost*Qty)
					aEquip=aEquip+(UnitCost*ActualQty)
					
				Case Else
					other=other+(UnitCost*Qty)
					aOther=aOther+(UnitCost*ActualQty)
					
			End Select
			
			%><%="<expense"&r&">"%><%
			%><%="	<type"&r&">"&lCase(rs2("eType"))&"</type"&r&">"%><%
			%><%="	<qty"&r&">"&lCase(rs2("Units"))&"</qty"&r&">"%><%
			%><%="	<actualQty"&r&">"&lCase(rs2("ActualUnits"))&"</actualQty"&r&">"%><%
			%><%="	<cost"&r&">"&lCase(rs2("UnitCost"))&"</cost"&r&">"%><%
			%><%="</expense"&r&">"%><%
				
			rs2.moveNext
		Loop
		%></Expenses><%
		
		
		
		%>
		<MU>0<%=MU%></MU>
		<taxRate>0<%=taxRate%></taxRate>
		<overhead>0<%=overhead%></overhead>
		<parts>0<%=parts%></parts>
		<labor>0<%=labor%></labor>
		<travel>0<%=travel%></travel>
		<equip>0<%=equip%></equip>
		<other>0<%=other%></other>
		<aParts>0<%=aParts%></aParts>
		<aLabor>0<%=aLabor%></aLabor>
		<aTravel>0<%=aTravel%></aTravel>
		<aEquip>0<%=aEquip%></aEquip>
		<aOther>0<%=aOther%></aOther>
		<%
		
		
	
	case "projectcost"'-------------------------------------------------------------------------------------------------------------------
		projId=request.QueryString("projId")
		
		SQL="SELECT SectionID, Section FROM Sections WHERE ExcludeSec!='True' AND ProjectID="&projId
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		r=0
		If rs.EOF Then
			%><%="<Section"&r&">NONE</Section"&r&">"%><%
		End If
		Do Until rs.EOF
			r=r+1
			%><%="<Section"&r&">"&EncodeChars(rs("Section"))&"</Section"&r&">"%><%
			
			secId=rs("SectionID")
			
			parts=0
			labor=0
			travel=0
			equip=0
			other=0
			aParts=0
			aLabor=0
			aTravel=0
			aEquip=0
			aOther=0
			
			SQL0="SELECT SectionID, ProjectID, MU, TaxRate, Overhead, FixedPrice, Round, TotalFixed FROM Sections WHERE SectionID="&secId
			%><%="<SQL0."&r&">"&SQL0&"</SQL0."&r&">"%><%
			Set rs0=Server.CreateObject("AdoDB.RecordSet")
			rs0.Open SQL0, REDConnString
			MU=rs0("MU") : If IsNull(MU) Or MU="" Then MU=0
			fixedTotal=rs0("FixedPrice") : If IsNull(fixedTotal) Or fixedTotal="" Then fixedTotal=0
			projId=rs0("ProjectID")
			taxRate=rs0("TaxRate") : If IsNull(taxRate) Or taxRate="" Then taxRate=0
			Overhead=rs0("Overhead") : If IsNull(Overhead) Or Overhead="" Then Overhead=0
			roundUp=rs0("Round")
			totalFixed=rs0("TotalFixed")
			%>
			<%="<fixedTotal"&r&">0"&fixedTotal&"</fixedTotal"&r&">"%>
			<%="<roundUp"&r&">--"&roundUp&"</roundUp"&r&">"%>
			<%="<totalFixed"&r&">--"&totalFixed&"</totalFixed"&r&">"%>
			<%
			Set rs0=Nothing
			
			SQL1="SELECT Cost, Qty, ActualQty, Type FROM BidItems WHERE SecID="&SecID&" ORDER BY Type"
			%><%="<SQL1."&r&">"&SQL1&"</SQL1."&r&">"%><%
			Set rs1=Server.CreateObject("AdoDB.RecordSet")
			rs1.open SQL1, REDConnString
			
			Do Until rs1.EOF
				
				select Case lCase(rs1("type"))
					Case "part", "0" 
						parts=parts+(rs1("Cost")*rs1("Qty"))
						aParts=aParts+(rs1("Cost")*rs1("ActualQty"))
						
					Case "labor", "1" 
						labor=labor+(rs1("Cost")*rs1("Qty"))
						aLabor=aLabor+(rs1("Cost")*rs1("ActualQty"))
				
					Case else
					  SUPPOSEDtoBEpartORlabor() 'is not a function.
						
				End Select
				
				rs1.moveNext
			Loop
		
			
			SQL2="SELECT UnitCost, Units, ActualUnits, Type FROM Expenses WHERE SecID="&SecID
			%><%="<SQL2."&r&">"&SQL2&"</SQL2."&r&">"%><%
			Set rs2=Server.CreateObject("AdoDB.RecordSet")
			rs2.open SQL2, REDConnString
				
			Do Until rs2.EOF

				UnitCost=rs2("UnitCost")
				If UnitCost="" then UnitCost=0
				Qty=rs2("Units")
				If 	Qty="" then UnitCost=0
				ActualQty=rs2("ActualUnits")
				If ActualQty="" then UnitCost=0

				Select Case lCase(rs2("type"))
					Case "travel", "0" 
						travel=travel+(UnCurrency(UnitCost)*Qty)
						aTravel=aTravel+(UnCurrency(UnitCost)*ActualQty)
					Case "equip", "1" 
						equip=equip+(UnCurrency(UnitCost)*Qty)
						aEquip=aEquip+(UnCurrency(UnitCost)*ActualQty)
					Case Else
						other=other+(UnCurrency(UnitCost)*Qty)
						aOther=aOther+(UnCurrency(UnitCost)*ActualQty)
				End Select
				rs2.moveNext
			Loop
			
			if taxRate="" Then taxRate=0
			%>
			<%="<MU"&r&">0"&MU&"</MU"&r&">"%>
			<%="<taxRate"&r&">0"&taxRate/100&"</taxRate"&r&">"%>
			<%="<overhead"&r&">0"&overhead/100&"</overhead"&r&">"%>
			<%="<parts"&r&">0"&parts&"</parts"&r&">"%>
			<%="<labor"&r&">0"&labor&"</labor"&r&">"%>
			<%="<travel"&r&">0"&travel&"</travel"&r&">"%>
			<%="<equip"&r&">0"&equip&"</equip"&r&">"%>
			<%="<other"&r&">0"&other&"</other"&r&">"%>
			<%="<expenses"&r&">0"&travel+equip+other&"</expenses"&r&">"%>
			<%="<aParts"&r&">0"&aParts&"</aParts"&r&">"%>
			<%="<aLabor"&r&">0"&aLabor&"</aLabor"&r&">"%>
			<%="<aTravel"&r&">0"&aTravel&"</aTravel"&r&">"%>
			<%="<aEquip"&r&">0"&aEquip&"</aEquip"&r&">"%>
			<%="<aOther"&r&">0"&aOther&"</aOther"&r&">"%>
			<%="<aExpenses"&r&">0"&aTravel+aEquip+aOther&"</aExpenses"&r&">"%>
			<%="<aFixedTotal"&r&">0"&(aParts*(1+taxRate))+aLabor+aTravel+aEquip+aOther&"</aFixedTotal"&r&">"%>
			<%
			rs.MoveNext
		Loop
		
		%>
		<recordCount>0<%=r%></recordCount>
		<%
		
		
	
		
	Case Else '══════─
		%>
		<error>No subroutine found for:<%=sAction%> </error>
		<%
End Select		

%>
</root>
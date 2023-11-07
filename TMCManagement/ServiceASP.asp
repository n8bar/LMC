
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
	
	Case "searchcust"'-----------------------------------------------------------------------------------------------------------------------
		txt=Request.QueryString("txt")
		
		i=-1
		If txt <> "" Then
			SQL="SELECT TOP 10 ID, Name FROM Contacts WHERE Customer=1 AND Name Like '"&txt&"%' ORDER BY Name"
			%><SQL><%=SQL%></SQL><%
			Set rs=Server.CreateObject("AdoDB.RecordSet")
			rs.Open SQL, REDConnString
			
			Do Until rs.EOF
				i=i+1
				id=right("00000"&rs("ID"),5)
				%>
				<%="<id__"&i&">"&id&"</id__"&i&">"%>
				<%="<name__"&i&">"&rs("Name")&"</name__"&i&">"%>
				<%
				rs.MoveNext
			Loop
		End If
		%><count><%=i+1%></count><%
	
	
	Case "savenewservice"'-------------------------------------------------------------------------------------------------------------------
		sName = CStr(Request.QueryString("name"))
		custId=CStr(Request.QueryString("custid"))
		city = CStr(Request.QueryString("city")) 
		address = CStr(Request.QueryString("addr"))
		sState = CStr(Request.QueryString("state"))
		zip = CStr(Request.QueryString("zip"))
		active=Request.QueryString("active")
		sDate = Date()
		
		If lCase(active)="active" Then active=1 Else active=0
		
		trID=Session("EmpId")
		
		cKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID
		SQL="INSERT INTO Services (JobName, CustID, Address, City, State, Zip, DateEnt, Active, TricomRepID, CreationKey)"
		SQL=SQL&" VALUES ('"&sName&"', "&custId&", '"&address&"', '"&city&"', '"&sState&"', '"&zip&"', '"&sDate&"', "&active&", "&trID&", '"&cKey&"')"
		%><SQL><%=SQL%></SQL><%
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring	
		
		Set rs=Nothing
	
		SQL="SELECT ID FROM Services WHERE CreationKey='"&cKey&"'"
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring	
		
		If Not rs.EOF Then
			%><Id><%=rs("ID")%></Id><%
		End If
		
		Set rs=Nothing
		
		
		
	
	Case "deljob"'-------------------------------------------------------------------------------------------------------------------
		
		Id=Request.QueryString("Id")
		
		If Id<>"" Then

			SQL1="DELETE FROM BidItems WHERE SysID="&ID
			set rs1=Server.CreateObject("ADODB.Recordset")
			%><SQL1><%=SQL1%></SQL1><%
			rs1.Open SQL1, REDconnstring	
			set rs1=Nothing
			
			SQL2="DELETE FROM Expenses WHERE SysID="&ID
			set rs2=Server.CreateObject("ADODB.Recordset")
			%><SQL2><%=SQL2%></SQL2><%
			rs2.Open SQL2, REDconnstring	
			set rs2=Nothing

			SQL3="DELETE FROM Services WHERE ID="&ID
			set rs3=Server.CreateObject("ADODB.Recordset")
			%><SQL3><%=SQL3%></SQL3><%
			rs3.Open SQL3, REDconnstring	
			set rs3=Nothing

		Else
			%>
			<error>ID is null.</error>
			<%
		End If
	
	
	Case "addpart"'-------------------------------------------------------------------------------------------------------------------
		
		SysID = CStr(Request.QueryString("SysID"))
		PartID = CStr(Request.QueryString("PartID"))
		costing = Request.QueryString("costing")
		if costing <> 1 Then costing=0
		
		'MU = CStr(Request.QueryString("MU"))
		CreationKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID
		If PartID="0" Then 
			SQLValues="VALUES ("&SysID&",'-','0','-','-',0,0,0,'Part',"&costing&", '"&CreationKey&"')"
		Else
			SQL1 = "SELECT * FROM Parts WHERE PartsID = "&PartID
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			Cost = rs1("Cost")
			'Sell = (((Cost*MU)/100)+Cost)	
			
			SQLValues=" VALUES ("&SysID&",'"&rs1("Manufacturer")&"',"&PartID&",'"&rs1("PartNumber")&"','"&rs1("Description")&"',0"&Cost&", 0"&rs1("LaborValue")&", 0, 'Part',"&costing&", '"&CreationKey&"')"
		End If
		
		SQL2="INSERT INTO ServiceItems (SysID,Manufacturer,PartID,ItemName,ItemDescription,Cost,LaborValue,Qty,Type,editable,CreationKey)"
		SQL2=SQL2&SQLValues
		%><SQL2><%=SQL2%></SQL2><%
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		set rs1 = nothing
		set rs2 = nothing
		
		SQL3="SELECT ServiceItemsID FROM ServiceItems WHERE CreationKey ='"&CreationKey&"'"
		Set rs3 = Server.CreateObject("AdoDB.RecordSet")
		rs3.Open SQL3, REDConnString

		ServiceItemsID=rs3("ServiceItemsID")

		Set rs3=Nothing
		%>
		<SysID><%=SysID%></SysID>
		<JobID><%=PartID%></JobID>
		<PartID><%=PartID%></PartID>
		<ServiceItemsID><%=ServiceItemsID%></ServiceItemsID>
		<%
		
	
	
	Case "addpresetpart"'-------------------------------------------------------------------------------------------------------------------
		
		pId = CStr(Request.QueryString("pId"))
		PartID = CStr(Request.QueryString("PartID"))
		
		CreationKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID

		SQL1 = "SELECT Cost, Manufacturer, PartNumber, Description FROM Parts WHERE PartsID = "&PartID
			set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Cost = rs1("Cost")
		
		SQL2="INSERT INTO ServicePresetItems (ServicePresetID,ItemID,Qty,Type,CreationKey) VALUES ("&pId&","&PartID&",0,'Part','"&CreationKey&"')"
		%><SQL2><%=SQL2%></SQL2><%
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		
		SQL3="SELECT ServicePresetItemsID FROM ServicePresetItems WHERE CreationKey ='"&CreationKey&"'"
		Set rs3 = Server.CreateObject("AdoDB.RecordSet")
		rs3.Open SQL3, REDConnString

		ServicePresetItemsID=rs3("ServicePresetItemsID")

		%>
		<pId><%=pId%></pId>
		<PartID><%=PartID%></PartID>
		<ServicePresetItemsId><%=ServicePresetItemsID%></ServicePresetItemsId>
		<Cost>0<%=rs1("Cost")%></Cost>
		<Manufacturer>--<%=rs1("Manufacturer")%></Manufacturer>
		<PN>--<%=rs1("PartNumber")%></PN>
		<Desc>--<%=rs1("Description")%></Desc>
		<%
		set rs1 = nothing
		set rs2 = nothing
		Set rs3 = Nothing
		
	
	
	Case "addlabor"'-------------------------------------------------------------------------------------------------------------------
		
		SysID = Request.QueryString("SysID")
		LaborID=Request.QueryString("LaborID")
		costing = Request.QueryString("costing")
		if costing <> 1 Then costing=0
		'MU = CStr(Request.QueryString("MU"))
		
		CreationKey=Date&Timer&Session.SessionID
		
		If LaborID="" Then 
			SQLValues="VALUES ("&SysID&",'-','-',55,0,'Labor', "&costing&", '"&CreationKey&"')"
		Else
			SQL1 = "SELECT * FROM Labor WHERE LaborID = "&LaborID
			%><SQL1><%=SQL1%></SQL1><%
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			
			SQLValues="VALUES ("&SysID&",'"&rs1("Name")&"','"&rs1("Description")&"',0"&Cost&",0,'Labor', "&costing&", '"&CreationKey&"')"

		End If
		
		SQL="INSERT INTO ServiceItems (SysID,ItemName,ItemDescription,Cost,Qty,Type,editable,CreationKey)"
		SQL=SQL&SQLValues
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring
		
		set rs = nothing
		
		SQL2="SELECT ServiceItemsID FROM ServiceItems WHERE CreationKey ='"&CreationKey&"'"
		Set rs2 = Server.CreateObject("AdoDB.RecordSet")
		rs2.Open SQL2, REDConnString

		ServiceItemsID=rs2("ServiceItemsID")

		Set rs3=Nothing
		%>
		<SysID><%=SysID%></SysID>
		<JobID><%=PartID%></JobID>
		<SQL><%=SQL%></SQL>
		<SQL2><%=SQL2%></SQL2>
		<LaborID><%=LaborID%></LaborID>
		<ServiceItemsID><%=ServiceItemsID%></ServiceItemsID>
		<%
		
	
	
	Case "addpresetlabor"'-------------------------------------------------------------------------------------------------------------------
		
		pId = CStr(Request.QueryString("pId"))
		LaborID = CStr(Request.QueryString("LaborID"))
		
		CreationKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID

		SQL1 = "SELECT RateCost, Name, Category, Description FROM Labor WHERE LaborID = "&LaborID
			set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Cost = rs1("RateCost")
		
		SQL2="INSERT INTO ServicePresetItems (ServicePresetID,ItemID,Qty,Type,CreationKey) VALUES ("&pId&","&LaborID&",0,'Labor','"&CreationKey&"')"
		%><SQL2><%=SQL2%></SQL2><%
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		
		SQL3="SELECT ServicePresetItemsID FROM ServicePresetItems WHERE CreationKey ='"&CreationKey&"'"
		Set rs3 = Server.CreateObject("AdoDB.RecordSet")
		rs3.Open SQL3, REDConnString

		ServicePresetItemsID=rs3("ServicePresetItemsID")

		%>
		<pId><%=pId%></pId>
		<LaborID><%=LaborID%></LaborID>
		<ServicePresetItemsId><%=ServicePresetItemsID%></ServicePresetItemsId>
		<Cost>0<%=rs1("RateCost")%></Cost>
		<LaborName>--<%=rs1("Name")%></LaborName>
		<Category>--<%=rs1("Category")%></Category>
		<Desc>--<%=rs1("Description")%></Desc>
		<%
		set rs1 = nothing
		set rs2 = nothing
		Set rs3 = Nothing
		
	
	
	Case "partslist"'-------------------------------------------------------------------------------------------------------------------
		
		Id=Request.QueryString("ServiceId")
		
		SQL="SELECT BidItemsID, Manufacturer, ItemName, ItemDescription, Qty, ActualQty, Cost, CostDiff, editable FROM BidItems WHERE SysID="&Id&" AND Type='Part'"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.open SQL, REDConnString
		
		SQL2="SELECT MU FROM Services WHERE ID="&ID
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.open SQL2, REDConnString
		%><MU>0<%=rs2("MU")%></MU><%
		
		
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
		
		Id=Request.QueryString("serviceId")
		
		SQL="SELECT BidItemsID, ItemName, ItemDescription, Qty, ActualQty, Cost, CostDiff, editable FROM BidItems WHERE SysID="&Id&" AND Type='Labor'"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.open SQL, REDConnString
		
		SQL2="SELECT MU FROM Services WHERE Id="&Id
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.open SQL2, REDConnString
		%><MU><%=rs2("MU")%></MU><%

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
		
		Id=Request.QueryString("Id")
		expenseType=Request.QueryString("Type")
		
		SQL="SELECT ExpenseID, SubType, Origin, Destination, UnitCost, Units, ActualUnits, editable FROM Expenses WHERE SysID="&Id&" AND Type='"&expenseType&"'"
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
		
		SysID = CStr(Request.QueryString("SysID"))
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
		
		SQLValues=" VALUES ("&SysID&",'"&expenseType&"','"&SubType&"','"&Origin&"','"&Dest&"',"&Units&","&ActualUnits&", "&Cost&", "&costing&", '"&CreationKey&"')"
		
		SQL="INSERT INTO Expenses (SysID,Type,SubType,Origin,Destination,Units,ActualUnits,UnitCost,editable,CreationKey)"&SQLValues
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
		<SysID><%=SysID%></SysID>
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
		SysID = CStr(Request.QueryString("SysID"))
		PresetID=Request.QueryString("PresetID")
		
		SQL="SELECT Type, ItemID, Qty FROM ServicePresetItems WHERE ServicePresetID="&PresetID&""
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
						Fieldz="SysID, PartID, Manufacturer, ItemName, ItemDescription, LaborValue, Qty, Type, Cost, Category"
						Values=SysId&","&rs1("PartsID")&",'"&rs1("Manufacturer")&"','"&rs1("PartNumber")&"','"&rs1("Description")&"',0"&rs1("LaborValue")&",0"&rs("Qty")&",'Part',"&rs1("Cost")&",'"&rs1("Category1")&"'"
						
					Case "labor"
						Fieldz="SysID, PartID, ItemName, ItemDescription, Qty, Type, Cost"
						Values=SysId&","&rs1("LaborID")&",'"&rs1("Name")&"','"&rs1("Description")&"',"&rs("Qty")&",'Labor',"&rs1("RateCost")
			
				End Select
				
				SQL2="INSERT INTO ServiceItems ("&Fieldz&") VALUES ("&Values&")"
				%><%="<SQL2-"&r&">"&SQL2&"</SQL2-"&r&">"%><%
				Set rs2=Server.CreateObject("AdoDB.RecordSet")
				rs2.Open SQL2, REDConnString
			End If

			rs.MoveNext
		Loop
		
		SQL0="SELECT Type, Qty, Mfr, Name, Description, Cost, LaborValue FROM CustomPresetItems WHERE ServicePresetID="&PresetID&""
		%><SQL0><%=SQL0%></SQL0><%
		Set rs0=Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		r=0
		Do Until rs.EOF
			r=r+1			
			
			Select Case lcase(rs0("Type"))
				Case "part"
					Fieldz="SysID, Manufacturer, ItemName, ItemDescription, LaborValue, Qty, Type, Cost"
					Values=SysId&",'"&rs0("Mfr")&"','"&rs0("Name")&"','"&rs0("Description")&"',0"&rs1("LaborValue")&",0"&rs("Qty")&",'Part',"&rs1("Cost")
				Case "labor"
					Fieldz="SysID, ItemName, ItemDescription, Qty, Type, Cost"
					Values=SysId&",'"&rs0("Name")&"','"&rs0("Description")&"',"&rs("Qty")&",'Labor',"&rs0("Cost")
			End Select
			SQL6="INSERT INTO ServiceItems ("&Fieldz&") VALUES ("&Values&")"
			%><%="<SQL6-"&r&">"&SQL6&"</SQL6-"&r&">"%><%
			Set rs6=Server.CreateObject("AdoDB.RecordSet")
			rs6.Open SQL6, REDConnString
	
			rs0.MoveNext
		Loop
		
		SQL="SELECT Notes, Includes, Excludes FROM Systems WHERE SystemID="&SysID&""
		%><SQL4><%=SQL%></SQL4><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		If Not rs.EOF Then
			Scope=rs("Notes")
			Includes=rs("Includes")
			Excludes=rs("Excludes")
		End If

		SQL="SELECT Scope, Includes, Excludes FROM ServicePresets WHERE ServicePresetID="&PresetID&""
		%><SQL5><%=SQL%></SQL5><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		If Not rs.EOF Then
			SQL3="UPDATE Systems SET Notes='"&rs("Scope")&"_CR_"&Scope&"', Includes='"&rs("Includes")&"_CR_"&Includes&"', Excludes='"&rs("Excludes")&"_CR_"&Excludes&"' WHERE SystemID="&SysID	
		%><SQL3><%=SQL3%></SQL3><%
			Set rs3=Server.CreateObject("AdoDB.RecordSet")
			rs3.Open SQL3, REDConnString
			set rs3=Nothing
			
		End If
		
		Set rs=Nothing
	
	
	
	case "copyService"'----------------------------------------------------------------------------------------------------------------
		SysID = Request.QueryString("SysID")
		SysType=CStr(Request.QueryString("SysType"))
		SysTypeID=Request.QueryString("SysTypeID")
		Preset=CStr(Request.QueryString("Preset"))
		copyQty=Request.QueryString("copyQty")
		if copyQty<>1 Then copyQty=0
		
		SQL0="SELECT Notes,Includes,Excludes FROM Systems WHERE SystemID="&SysID
		%><%=SQL0%><%
		Set rs0=Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		
		Scope=rs0("Notes")
		Includes=rs0("Includes")
		Excludes=rs0("Excludes")
		
		creationKey=newCreationKey()
				
		SQL="INSERT INTO ServicePresets (ServicePresetSystemID,ServicePresetSystem,ServicePresetName,Scope,Includes,Excludes,creationKey)"
		SQL=SQL&" VALUES ("&SysTypeID&",'"&SysType&"','"&Preset&"','"&Scope&"','"&Includes&"','"&Excludes&"','"&creationKey&"')"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		SQL1="SELECT ServicePresetID FROM ServicePresets WHERE creationKey='"&creationKey&"'"
		%><SQL1><%=SQL1%></SQL1><%
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		PresetID=rs1("ServicePresetID")
		
		set rs0=Nothing
		set rs=Nothing
		set rs1=Nothing
				
		SQL2="SELECT PartID, Manufacturer, ItemName, ItemDescription, Type, Cost, Category, Qty FROM ServiceItems WHERE SysID="&SysID&" ORDER BY Type"
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
				SQL3="INSERT INTO CustomPresetItems (ServicePresetID,Type,Qty,Mfr,Name,Description,Cost) VALUES "
				SQL3=SQL3&"("&PresetID&",'"&iType&"',"&Qty&",'"&iMfr&"','"&iName&"','"&iDesc&"',"&iCost&")"
				%><%="<SQL3-"&bII&">"&SQL3&"</SQL3-"&bII&">"%><%
				Set rs3= Server.CreateObject("AdoDB.RecordSet")
				rs3.Open SQL3, REDConnString
				Set rs3=Nothing
			Else 'Grab from Database
				Qty=CSng(iQty)*copyQty
				SQL4="INSERT INTO ServicePresetItems (ServicePresetID,Type,ItemID,Qty) VALUES ("&PresetID&",'"&iType&"',"&iPartID&","&Qty&")"
				%><%="<SQL4-"&bII&">"&SQL4&"</SQL4-"&bII&">"%><%
				Set rs4= Server.CreateObject("AdoDB.RecordSet")
				rs4.Open SQL4, REDConnString
				Set rs4=Nothing
			End If
			'% ><%="<unknownItem"&bII&">--"&unknownItemData&"</unknownItem"&bII&">"% ><%
			
			
			
			
			rs2.MoveNext
		Loop
		
		%><%="<ServiceItemCount>"&bII&"</ServiceItemCount>"%><%
		%><%="<newPId>"&rs2.RecordCount&"</newPId>"%><%
		
		
	case "cost"'-------------------------------------------------------------------------------------------------------------------
		serviceId = CStr(Request.QueryString("serviceId"))
		
		SQL0="SELECT ID, MU, Overhead, TaxRate, FixedPrice, isFixedPrice, Round FROM Services WHERE ID="&serviceId
		%><SQL0><%=SQL0%></SQL0><%
		Set rs0=Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		MU=rs0("MU")
		fixedTotal=rs0("FixedPrice")
		taxRate=rs0("TaxRate")
		Overhead=rs0("Overhead")
		roundUp=rs0("Round")
		totalFixed=rs0("isFixedPrice")
		%><fixedTotal>0<%=fixedTotal%></fixedTotal><%
		%><roundUp>--<%=roundUp%></roundUp><%
		%><totalFixed>--<%=totalFixed%></totalFixed><%
		Set rs0=Nothing
		
		'SQL="SELECT Use2010Servicer FROM Jobs WHERE JobID="&JobID
		'Set rs=Server.CreateObject("AdoDB.RecordSet")
		'rs.Open SQL, REDConnString
		'useNewServicer=rs("use2010Servicer")
		'If useNewServicer="True" Then useNewServicer = True  Else  useNewServicer=False
		'% ><useNewServicer><%=useNewServicer% ></useNewServicer><%
		
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
		
		SQL1="SELECT Cost, Qty, ActualQty, Type FROM BidItems WHERE SysID="&serviceID&" ORDER BY Type"
		%><SQL1><%=SQL1%></SQL1><%
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.open SQL1, REDConnString
		
		%><ServiceItems><%
		r=0
		Do Until rs1.EOF
			r=r+1
			Qty="0"&rs1("Qty") : If Qty="" OR ISNull(Qty) Then Qty=0
			ActualQty=rs1("ActualQty") : If ActualQty="" Then ActualQty=0
			
			If lCase(rs1("Type")) = "1" or lCase(rs1("Type")) = "labor" Then
				labor=labor+(rs1("Cost")*Qty)
				aLabor=aLabor+(rs1("Cost")*ActualQty)
			Else
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
		%></ServiceItems><%
		
		
		SQL2="SELECT UnitCost, Units, ActualUnits, [Type] AS eType FROM Expenses WHERE SysID="&serviceID&" AND editable!=1 ORDER BY Type"
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
		<overhead>0<%=overhead%></overhead>
		<taxRate>0<%=taxRate%></taxRate>
		<fixedPrice>0<%=fixedPrice%></fixedPrice>
		<isFixedPrice>0<%=isFixedPrice%></isFixedPrice>
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
		
		
	
	case "Jobcost"'-------------------------------------------------------------------------------------------------------------------
		JobId=request.QueryString("JobId")
		
		SQL="SELECT SystemID, System FROM Systems WHERE ExcludeSys!='True' AND JobID="&JobId
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		r=0
		If rs.EOF Then
			%><%="<System"&r&">NONE</System"&r&">"%><%
		End If
		Do Until rs.EOF
			r=r+1
			%><%="<System"&r&">"&EncodeChars(rs("System"))&"</System"&r&">"%><%
			
			sysId=rs("SystemID")
			
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
			
			SQL0="SELECT SystemID, JobID, MU, TaxRate, Overhead, FixedPrice, Round, TotalFixed FROM Systems WHERE SystemID="&sysId
			%><%="<SQL0."&r&">"&SQL0&"</SQL0."&r&">"%><%
			Set rs0=Server.CreateObject("AdoDB.RecordSet")
			rs0.Open SQL0, REDConnString
			MU=rs0("MU") : If IsNull(MU) Or MU="" Then MU=0
			fixedTotal=rs0("FixedPrice") : If IsNull(fixedTotal) Or fixedTotal="" Then fixedTotal=0
			JobId=rs0("JobID")
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
			
			SQL1="SELECT Cost, Qty, ActualQty, Type FROM ServiceItems WHERE SysID="&SysID&" ORDER BY Type"
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
		
			
			SQL2="SELECT UnitCost, Units, ActualUnits, Type FROM Expenses WHERE SysID="&SysID
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
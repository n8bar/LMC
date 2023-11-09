
<!--#include file="../LMC/RED.asp" -->
<%
Response.ContentType = "text/xml"
If Request.QueryString("html")=1 Then Response.ContentType = "text/html"
Response.Buffer="false"
sAction = CStr(Request.QueryString("action"))

%>
<root>
	<action><%=sAction%></action>
<%

Select Case lCase(sAction)
	
	Case "savenewbid"'-------------------------------------------------------------------------------------------------------------------
		pName = CStr(Request.QueryString("name"))
		city = CStr(Request.QueryString("city")) 
		address = CStr(Request.QueryString("address"))
		pState = CStr(Request.QueryString("state"))
		zip = CStr(Request.QueryString("zip"))
		sqFeet = CInt(Request.QueryString("sqFeet"))
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
		
		SQL="SELECT CustID, Name FROM Customers WHERE Customer=1 AND Name LIKE '%"&search&"%' ORDER BY Name"
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		r=0
		Do Until rs.EOF
			r=r+1
			%><%="<custId"&r&">"&rs("CustID")&"</custId"&r&">"%><%
			%><%="<name"&r&">"&rs("Name")&"</name"&r&">"%><%
			rs.MoveNext
		Loop
		%><recordCount>00<%=r%></recordCount><%
		Set rs=Nothing
		
	
	Case "delproj"'-------------------------------------------------------------------------------------------------------------------
		
		projId=Request.QueryString("projId")
		
		If projId<>"" Then
			
			SQL="SELECT SystemID FROM Systems WHERE ProjectID="&projId
			set sysRS=Server.CreateObject("ADODB.Recordset")
			sysRS.Open SQL, REDconnstring	
			
			Do Until sysRS.EOF
				SQL1="DELETE FROM BidItems WHERE SysID="&sysRS("SystemID")
				set rs1=Server.CreateObject("ADODB.Recordset")
				rs1.Open SQL1, REDconnstring	
				set rs1=Nothing
				
				SQL2="DELETE FROM Expenses WHERE SysID="&sysRS("SystemID")
				set rs2=Server.CreateObject("ADODB.Recordset")
				rs2.Open SQL2, REDconnstring	
				set rs2=Nothing

				SQL3="DELETE FROM Systems WHERE SystemID="&sysRS("SystemID")
				set rs3=Server.CreateObject("ADODB.Recordset")
				rs3.Open SQL3, REDconnstring	
				set rs3=Nothing
				%>
				<SQL1><%=SQL1%></SQL1>
				<SQL2><%=SQL2%></SQL2>
				<SQL3><%=SQL3%></SQL3>
				<%
				sysRS.MoveNext
			Loop
			Set SysRS=Nothing
			
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
	
	
	Case "savenewsys"
		
		system=Request.queryString("system")
		projId=Request.queryString("projId")
		SQL="INSERT INTO Systems (selected, System, DateEntered, EnteredBy, EnteredByID, ProjectID) VALUES ('True', '"&system&"', '"&Date&"', '"&session("userName")&"', "&session("EmpID")&", "&projId&")"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.createObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		Set rs=Nothing
		
		
	Case "addpart"'-------------------------------------------------------------------------------------------------------------------
		
		SysID = CStr(Request.QueryString("SysID"))
		PartID = CStr(Request.QueryString("PartID"))
		'MU = CStr(Request.QueryString("MU"))
		
		CreationKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID
		If PartID="0" Then 
			SQLValues="VALUES ("&SysID&",'-','0','-','-',0,0,0,'Part', '"&CreationKey&"')"
		Else
			SQL1 = "SELECT * FROM Parts WHERE PartsID = "&PartID
				set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			Cost = rs1("Cost")
			'Sell = (((Cost*MU)/100)+Cost)	
			
			
			
			SQLValues=" VALUES ("&SysID&",'"&rs1("Manufacturer")&"',"&PartID&",'"&rs1("PartNumber")&"','"&rs1("Description")&"',"&rs1("Cost")&", 0"&rs1("LaborValue")&", 0, 'Part', '"&CreationKey&"')"
		End If
		
		SQL2="INSERT INTO BidItems (SysID,Manufacturer,PartID,ItemName,ItemDescription,Cost,LaborValue,Qty,Type,CreationKey)"
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
		<SysID><%=SysID%></SysID>
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
		
		SysID = CStr(Request.QueryString("SysID"))
		'MU = CStr(Request.QueryString("MU"))
		
		CreationKey=Date&Timer&Session.SessionID
		SQLValues="VALUES ("&SysID&",'-','-',55,0,'Labor', '"&CreationKey&"')"
		
		SQL="INSERT INTO BidItems (SysID,ItemName,ItemDescription,Cost,Qty,Type,CreationKey)"
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
		<SysID><%=SysID%></SysID>
		<ProjID><%=PartID%></ProjID>
		<SQL><%=SQL%></SQL>
		<SQL2><%=SQL2%></SQL2>
		<PartID><%=PartID%></PartID>
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
		
		sysId=Request.QueryString("sysId")
		
		SQL="SELECT BidItemsID, Manufacturer, ItemName, ItemDescription, Qty, Cost FROM BidItems WHERE SysID="&sysId&" AND Type='Part'"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.open SQL, REDConnString
		
		SQL2="SELECT MU FROM Systems WHERE SystemID="&sysID
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
			<%="<Qty"&r&">"&rs("Qty")&"</Qty"&r&">"%>
			<%="<Cost"&r&">"&rs("Cost")&"</Cost"&r&">"%>
			<%
			rs.MoveNext
		Loop
		%>
		<recordCount>0<%=r%></recordCount>
		<%
		
	Case "laborlist"'-------------------------------------------------------------------------------------------------------------------
		
		sysId=Request.QueryString("sysId")
		
		SQL="SELECT BidItemsID, ItemName, ItemDescription, Qty, Cost FROM BidItems WHERE SysID="&sysId&" AND Type='Labor'"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.open SQL, REDConnString
		
		SQL2="SELECT MU FROM Systems WHERE SystemID="&sysID
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
			<%="<Cost"&r&">"&rs("Cost")&"</Cost"&r&">"%>
			<%
			rs.MoveNext
		Loop
		%>
		<recordCount>0<%=r%></recordCount>
		<%
		
		
		
	Case "expenselist"'-------------------------------------------------------------------------------------------------------------------
		
		sysId=Request.QueryString("sysId")
		expenseType=Request.QueryString("Type")
		
		SQL="SELECT ExpenseID, SubType, Origin, Destination, UnitCost, Units FROM Expenses WHERE SysID="&sysId&" AND Type='"&expenseType&"'"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.open SQL, REDConnString
		
		r=0
		Do Until rs.EOF
			r=r+1
			
			SubType=rs("SubType")
			If SubType="" Then SubType=" "
			
			If expenseType="Travel" Then
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
			If Qty<>1 Then Unit=Unit+"s"

			%>
			<%="<ExpenseID"&r&">"&rs("ExpenseID")&"</ExpenseID"&r&">"%>
			<%="<SubType"&r&">"&SubType&"</SubType"&r&">"%>
			<%="<Units"&r&">0"&Qty&"</Units"&r&">"%>
			<%="<UnitCost"&r&">"&Cost&"</UnitCost"&r&">"%>
			<%
			If expenseType="Travel" Then
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
		
		CreationKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID
		
		SQLValues=" VALUES ("&SysID&",'"&expenseType&"','"&SubType&"','"&Origin&"','"&Dest&"',"&Units&", "&Cost&", '"&CreationKey&"')"
		
		SQL="INSERT INTO Expenses (SysID,Type,SubType,Origin,Destination,Units,UnitCost,CreationKey)"&SQLValues
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
		SQL="SELECT Type, ItemID, Qty FROM BidPresetItems WHERE BidPresetID="&PresetID&""
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		r=0
		Do Until rs.EOF
			r=r+1
			
			Select Case rs("Type")
				Case "Part"
					SQL1="SELECT PartsID, Manufacturer, PartNumber, Description, LaborValue, Cost, Category1 FROM Parts WHERE PartsID="&rs("ItemID")
					
				Case "Labor"
					SQL1="SELECT LaborID, Name, Description, RateCost FROM Labor WHERE LaborID="&rs("ItemID")
					
			End Select
					
			%><%="<SQL1-"&r&">"&SQL1&"</SQL1-"&r&">"%><%
			Set rs1=Server.CreateObject("AdoDB.RecordSet")
			rs1.Open SQL1, REDConnString
			
			If Not rs1.EOF Then
				Select Case lCase(rs("Type"))
					Case "part"
						Fieldz="SysID, PartID, Manufacturer, ItemName, ItemDescription, LaborValue, Qty, Type, Cost, Category"
						Values=SysId&","&rs1("PartsID")&",'"&rs1("Manufacturer")&"','"&rs1("PartNumber")&"','"&rs1("Description")&"',"&rs1("LaborValue")&","&rs("Qty")&",'Part',"&rs1("Cost")&",'"&rs1("Category1")&"'"
						
					Case "labor"
						Fieldz="SysID, PartID, ItemName, ItemDescription, Qty, Type, Cost"
						Values=SysId&","&rs1("LaborID")&",'"&rs1("Name")&"','"&rs1("Description")&"',"&rs("Qty")&",'Labor',"&rs1("RateCost")
			
				End Select
				
				SQL2="INSERT INTO BidItems ("&Fieldz&") VALUES ("&Values&")"
				%><%="<SQL2-"&r&">"&SQL2&"</SQL2-"&r&">"%><%
				Set rs2=Server.CreateObject("AdoDB.RecordSet")
				rs2.Open SQL2, REDConnString
			End If
			
			rs.MoveNext
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

		SQL="SELECT Scope, Includes, Excludes FROM BidPresets WHERE BidPresetID="&PresetID&""
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
		
	case "systemcost"'-------------------------------------------------------------------------------------------------------------------
		SysID = CStr(Request.QueryString("SysID"))
		
		
		SQL0="SELECT SystemID, ProjectID, MU, TaxRate, Overhead, FixedPrice, Round, TotalFixed FROM Systems WHERE SystemID="&SysID
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
		
		SQL1="SELECT Cost, Qty, Type FROM BidItems WHERE SysID="&SysID
		%><SQL1><%=SQL1%></SQL1><%
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.open SQL1, REDConnString
		
		Do Until rs1.EOF
			If lCase(rs1("type"))="labor" Then labor=labor+(rs1("Cost")*rs1("Qty"))
			If lCase(rs1("type"))="part" Then	parts=parts+(rs1("Cost")*rs1("Qty"))
			
			rs1.moveNext
		Loop
		
		
		
		SQL2="SELECT UnitCost, Units, Type FROM Expenses WHERE SysID="&SysID
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.open SQL2, REDConnString
		
		r=0
		Do Until rs2.EOF
			r=r+1
			UnitCost=rs2("UnitCost")
			UnitCost=UnCurrency(UnitCost)
			If UnitCost="" Then UnitCost=0
			Qty=rs2("Units")
			If Qty="" Then Qty=0
			
			
			Select Case lCase(rs2("type"))
				Case "travel" 
					travel=travel+(UnitCost*Qty)
				Case "equip" 
					equip=equip+(UnitCost*Qty)
				Case Else
					other=other+(UnitCost*Qty)
			End Select
			rs2.moveNext
		Loop
		
		
		
		%>
		<MU>0<%=MU%></MU>
		<taxRate>0<%=taxRate%></taxRate>
		<overhead>0<%=overhead%></overhead>
		<parts>0<%=parts%></parts>
		<labor>0<%=labor%></labor>
		<travel>0<%=travel%></travel>
		<equip>0<%=equip%></equip>
		<other>0<%=other%></other>
		<%
		
		
	
	case "projectcost"'-------------------------------------------------------------------------------------------------------------------
		projId=request.QueryString("projId")
		
		SQL="SELECT SystemID, System FROM Systems WHERE ExcludeSys!='True' AND ProjectID="&projId
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		parts=0
		labor=0
		travel=0
		equip=0
		other=0
		
		r=0
		If rs.EOF Then
			%><%="<System"&r&">NONE</System"&r&">"%><%
		End If
		Do Until rs.EOF
			r=r+1
			%><%="<System"&r&">"&EncodeChars(rs("System"))&"</System"&r&">"%><%
			
			sysId=rs("SystemID")
			
			SQL0="SELECT SystemID, ProjectID, MU, TaxRate, Overhead, FixedPrice, Round, TotalFixed FROM Systems WHERE SystemID="&sysId
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
			
			parts=0
			labor=0
			travel=0
			equip=0
			other=0
			
			SQL1="SELECT Cost, Qty, Type FROM BidItems WHERE SysID="&SysID
			%><%="<SQL1."&r&">"&SQL1&"</SQL1."&r&">"%><%
			Set rs1=Server.CreateObject("AdoDB.RecordSet")
			rs1.open SQL1, REDConnString
			
			Do Until rs1.EOF
				If lCase(rs1("type"))="labor" Then labor=labor+(rs1("Cost")*rs1("Qty"))
				If lCase(rs1("type"))="part" Then	parts=parts+(rs1("Cost")*rs1("Qty"))
				
				rs1.moveNext
			Loop
		
			
			SQL2="SELECT UnitCost, Units, Type FROM Expenses WHERE SysID="&SysID
			%><%="<SQL2."&r&">"&SQL2&"</SQL2."&r&">"%><%
			Set rs2=Server.CreateObject("AdoDB.RecordSet")
			rs2.open SQL2, REDConnString
				
			Do Until rs2.EOF

				UnitCost=rs2("UnitCost")
				If UnitCost="" then UnitCost=0
				Qty=rs2("Units")
				If 	Qty="" then UnitCost=0

				Select Case lCase(rs2("type"))
					Case "travel" 
						travel=travel+(UnCurrency(UnitCost)*Qty)
					Case "equip" 
						equip=equip+(UnCurrency(UnitCost)*Qty)
					Case Else
						other=other+(UnCurrency(UnitCost)*Qty)
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
			<%
			rs.MoveNext
		Loop
		
		%>
		<recordCount>0<%=r%></recordCount>
		<%
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
		
		
	Case Else '═════════════════════════════════════════════════════════════════════
		%>
		<error>No subroutine found for:<%=sAction%> </error>
		<%
End Select		

%>
</root>
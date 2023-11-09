
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
	
	Case "delpart"'-------------------------------------------------------------------------------------------------------------------
		
		partId=Request.QueryString("partId")
		
		If projId<>"" Then
			
			SQL="DELETE FROM Parts WHERE PartID="&projId
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring	
			set rs=Nothing
			
			%><SQL><%=SQL%></SQL><%
		Else
			%><error>PartID is null.</error><%
		End If
	
	
	Case "openpart"'--------------------------------------------------------------------------------------------------------------------
		pID=request.QueryString("pID")
		
		Fieldz=" Model, PartNumber, Inventory, InventoryLevel, Manufacturer, Description, Vendor1, Vendor2, Vendor3, Cost1, Cost2, Cost3, Date1, Date2, Date3, Category1, Category2, System, Cost, LaborValue"
		SQL="SELECT "&Fieldz&" FROM Parts WHERE PartsID="&pID
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		If Not rs.EOF Then
		%>
		<Model>--<%=rs("Model")%></Model>
		<PartNumber>--<%=rs("PartNumber")%></PartNumber>
		<Manufacturer>--<%=rs("Manufacturer")%></Manufacturer>
		<Description>--<%=rs("Description")%></Description>
		<Qty>0<%=rs("Inventory")%></Qty>
		<Level>0<%=rs("InventoryLevel")%></Level>
		<Vendor1>--<%=rs("Vendor1")%></Vendor1>
		<Vendor2>--<%=rs("Vendor2")%></Vendor2>
		<Vendor3>--<%=rs("Vendor3")%></Vendor3>
		<Cost1>0<%=rs("Cost1")%></Cost1>
		<Cost2>0<%=rs("Cost2")%></Cost2>
		<Cost3>0<%=rs("Cost3")%></Cost3>
		<Date1>--<%=rs("Date1")%></Date1>
		<Date2>--<%=rs("Date2")%></Date2>
		<Date3>--<%=rs("Date3")%></Date3>
		<Category1>--<%=rs("Category1")%></Category1>
		<Category2>--<%=rs("Category2")%></Category2>
		<System>--<%=rs("System")%></System>
		<Cost>0<%=rs("Cost")%></Cost>
		<LaborValue>0<%=rs("LaborValue")%></LaborValue>
		<%	
		Else
		
		End If
	Case "search"'------------------------------------------------------------------------------------------------------------------
		
		PN=Request.QueryString("Name")
		Mfg=Request.QueryString("Mfg")
		Desc=Request.QueryString("Desc")
		Vendor=Request.QueryString("Vendor")
		Max=Request.QueryString("Max")
		Min=Request.QueryString("Min")
		Sys=Request.QueryString("System")
		Cat=Request.QueryString("Category")
		
		if Request.QueryString("and")="true" Then andOr=" AND " Else andOr=" OR "
		
		Order=Request.QueryString("Order")
		
		Where=""
		If PN<>"" AND (NOT IsNull(PN)) THEN Where = " WHERE ( Model LIKE '%"&PN&"%' OR PartNumber LIKE '%"&PN&"%' ) "
		
		If Mfg<>"" AND (NOT IsNull(Mfg)) AND Mfg<>"[Any]" THEN
			If Where="" Then Where=" Where " Else Where=Where&andOr
			Where=Where&" (Manufacturer LIKE '%"&Mfg&"%') "
		End If
		
		If Desc<>"" AND (NOT IsNull(Desc)) AND Desc<>"[Any]" THEN
			If Where="" Then Where=" Where " Else Where=Where&andOr
			Where=Where&" (Description LIKE '%"&Desc&"%') "
		End If
		
		If Vendor<>"" AND (NOT IsNull(Vendor)) AND Vendor<>"[Any]" THEN
			If Where="" Then Where=" Where " Else Where=Where&andOr
			Where=Where&" (Vendor1 LIKE '%"&Vendor&"%' OR Vendor2 LIKE '%"&Vendor&"%' OR Vendor3 LIKE '%"&Vendor&"%')"
		End If
		
		If Max<>"" AND (NOT IsNull(Max)) AND Max<>"NaN" THEN
			If Where="" Then Where=" Where " Else Where=Where&andOr
			Where=Where&" (Cost <= "&Max&")"
		End If
		
		If Min<>"" AND (NOT IsNull(Min)) AND Min<>"NaN" THEN
			If Where="" Then Where=" Where " Else Where=Where&andOr
			Where=Where&" (Cost >= "&Min&")"
		End If
		
		If Sys<>"" AND (NOT IsNull(Sys)) AND Sys<>"[Any]" THEN
			If Where="" Then Where=" Where " Else Where=Where&andOr
			Where=Where&" (System LIKE '%"&Sys&"%') "
		End If
		
		If Cat<>"" AND (NOT IsNull(Cat)) AND Cat<>"[Any]" THEN
			If Where="" Then Where=" Where " Else Where=Where&andOr
			Where=Where&" (Category1 LIKE '%"&Cat&"%' OR Category2 LIKE '%"&Cat&"%') "
		End If
		
		
		If Order="" Then
			Order="Order By PartsID"
		Else 
			O=" ORDER BY "&Order
			If Session("OldPartsOrder")<>"" And Session("OldPartsOrder")<>Order Then O=O&", "&Session("OldPartsOrder")
			Order=O
		End If
		
		F="PartsID, Manufacturer, Model, Inventory, InventoryLevel, PartNumber, Description, Cost, System, Category1, Category2"
		F=F&", LaborValue, Vendor1, Vendor2, Vendor3, Cost1, Cost2, Cost3, Date1, Date2, Date3"
		'where="" : order=""
		maxR=session("partsListMax") : If maxR>0 Then top=" TOP "&maxR
		SQL="Select "&top&" "&F&" FROM Parts "&where&order
		%><SQL><%=Replace(SQL,"<","&lt;")%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		r=0
		Do Until rs.EOF Or r >= maxR
			r=r+1
			%>
			<%=chr(13)&"<PartsID"&r&">"&rs("PartsID")&"</PartsID"&r&">"&chr(13)%>
			<%="<Manufacturer"&r&">--"&EncodeChars(rs("Manufacturer"))&"</Manufacturer"&r&">"&chr(13)%>
			<%="<Model"&r&">--"&EncodeChars(rs("Model"))&"</Model"&r&">"&chr(13)%>
			<%="<PartNumber"&r&">--"&EncodeChars(rs("PartNumber"))&"</PartNumber"&r&">"&chr(13)%>
			<%="<Description"&r&">--"&EncodeChars(rs("Description"))&"</Description"&r&">"&chr(13)%>
			<%="<Qty"&r&">0"&rs("Inventory")&"</Qty"&r&">"&chr(13)%>
			<%="<Level"&r&">0"&rs("InventoryLevel")&"</Level"&r&">"&chr(13)%>
			<%="<Cost"&r&">0"&rs("Cost")&"</Cost"&r&">"&chr(13)%>
			<%="<Labor"&r&">0"&rs("LaborValue")&"</Labor"&r&">"&chr(13)%>
			<%="<System"&r&">--"&rs("System")&"</System"&r&">"&chr(13)%>
			<%="<Category1-"&r&">--"&rs("Category1")&"</Category1-"&r&">"&chr(13)%>
			<%="<Category2-"&r&">--"&rs("Category2")&"</Category2-"&r&">"&chr(13)%>
			<%="<Vendor1-"&r&">--"&EncodeChars(rs("Vendor1"))&"</Vendor1-"&r&">"&chr(13)%>
			<%="<Vendor2-"&r&">--"&EncodeChars(rs("Vendor2"))&"</Vendor2-"&r&">"&chr(13)%>
			<%="<Vendor3-"&r&">--"&rs("Vendor3")&"</Vendor3-"&r&">"&chr(13)%>
			<%="<Cost1-"&r&">0"&rs("Cost1")&"</Cost1-"&r&">"&chr(13)%>
			<%="<Cost2-"&r&">0"&rs("Cost2")&"</Cost2-"&r&">"&chr(13)%>
			<%="<Cost3-"&r&">0"&rs("Cost3")&"</Cost3-"&r&">"&chr(13)%>
			<%="<Date1-"&r&">--"&rs("Date1")&"</Date1-"&r&">"&chr(13)%>
			<%="<Date2-"&r&">--"&rs("Date2")&"</Date2-"&r&">"&chr(13)%>
			<%="<Date3-"&r&">--"&rs("Date3")&"</Date3-"&r&">"&chr(13)%>
			<%
			rs.MoveNext
		Loop 
		SET rs=Nothing
		%><recordMax>0<%=maxR%></recordMax><%
		%><recordCount><%=r%></recordCount><%
		
		
	Case "newmfg"'------------------------------------------------------------------------------------------------------------------
		
		mName=Request.QueryString("name")
		creationKey=replace(replace(Date,"/",""),"/","")&Timer&Session.SessionID
		SQL="INSERT INTO Manufacturers (Name, CreationKey) VALUES ('"&mName&"','"&creationKey&"')"
		%><SQL1><%=SQL%></SQL1><%
		SET rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		SET rs=Nothing
		SQL="SELECT ManufID FROM Manufacturers WHERE CreationKey='"&creationKey&"'"
		%><SQL2><%=SQL%></SQL2><%
		SET rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		%><ID><%=rs("ManufID")%></ID><%
		SET rs=Nothing
		
	Case "fixem"'------------------------------------------------------------------------------------------------------------------
		
		SQL="SELECT PartsID FROM Parts WHERE Vendor2='Tried'"
		%><SQL><%=SQL%></SQL><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		r=0
		Do Until rs.EOF
			r=r+1
			SQL1="UPDATE PARTS SET Vendor2='Tri-ed' WHERE PartsID="&rs("PartsID")
			%><%="<SQL1-"&r&">"&SQL1&"</SQL1-"&r&">"%><%
			Set rs1=Server.CreateObject("AdoDB.RecordSet")
			rs1.Open SQL1, REDConnString
			rs.MoveNext
		Loop
		
		Set rs=Nothing
		
	
			
	Case lCase("bidPartToMR")'------------------------------------------------------------------------------------------------------------------
		
		BidItemsID=Request.QueryString("BidItemsID")
		mrID=Request.QueryString("mrId")
		
		SQL="SELECT PartID, Qty, Manufacturer, ItemName, ItemDescription FROM BidItems WHERE BidItemsID="&BidItemsID
		%><%="<SQL>"&SQL&"</SQL>"%><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		partsID=cInt("0"&rs("PartID"))
		%><partsID><%=partsID%></partsID><%
		qty=Cint("0"&rs("Qty")) : If qty<1 Then qty=1 'There are issues when trying to add 0 parts.  If were adding any, probly at least 1.
		
		SQL0="SELECT ProjID FROM MaterialRequests WHERE Id="&mrID
		Set rs0=Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		ProjID=rs0("ProjID")
		
		partsWhere=" PartsID="&partsID
		If partsID=0 Then
			partsWhere=" PartNumber='"&rs("ItemName")&"'"
		End If
		
		%><Mfr><%=rs("Manufacturer")%></Mfr><%
		%><PN><%=rs("ItemName")%></PN><%
					
		SQL1="SELECT PartsID, Category1, Cost FROM Parts WHERE "&partsWhere
		%><%="<SQL1>"&SQL1&"</SQL1>"%><%
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		If rs1.EOF Then
			%><count>0</count><%
		Else
			If partsID=0 Then partsID=rs1("PartsId")
			%><realPartsID><%=partsID%></realPartsID><%
			Category=rs1("Category1")
			Cost=rs1("Cost")
			
			SQL2="SELECT unitSize FROM Categories WHERE Category='"&Category&"'"
			%><%="<SQL2a>"&SQL2&"</SQL2a>"%><%
			Set rs2=Server.CreateObject("AdoDB.RecordSet")
			rs2.Open SQL2, REDConnString
			If rs2.EOF Then
				If InStr(Category," - ")>0 Then 
					%><instrHooni><%=InStr(Category," - ")%></instrHooni><%
					Cat=Split(Category," - ") : Category=Cat(0) : SubCategory=Cat(1)
				End If
				SQL2="SELECT unitSize FROM Categories WHERE Category='"&Category&"'"
				%><%="<SQL2b>"&SQL2&"</SQL2b>"%><%
				Set rs2=Server.CreateObject("AdoDB.RecordSet")
				rs2.Open SQL2, REDConnString
			End If
			If rs2.EOF Then unitSize=1 Else unitSize=rs2("unitSize")
			
			unitQty=fix(Qty/unitSize) : if unitQty<qty*unitSize Then unitQty=unitQty+1 'Round Up
			F=" mRID, ProjID, PartsID, Mfr, PartNo, Description, unitSize, Cost"
			q=0
			
			Do while q<unitQty				
				ItemName=Replace(Replace(Replace(rs("ItemName"),"<div>",""),"</div>",""),"<br>","")
				%><%="<bidItemsID__"&q&">"&bidItemsID&"</bidItemsID__"&q&">"%><%
				%><%="<partsID__"&q&">"&partsID&"</partsID__"&q&">"%><%
				%><%="<mfr__"&q&">"&rs("Manufacturer")&"</mfr__"&q&">"%><%
				%><%="<pn__"&q&">"&ItemName&"</pn__"&q&">"%><%
				%><%="<desc__"&q&">"&rs("ItemDescription")&"</desc__"&q&">"%><%
				V=mrID&","&ProjID&","&partsID&", '"&rs("Manufacturer")&"','"&ItemName&"','"&rs("ItemDescription")&"',"&unitSize&","&Cost&""
				SQL3="INSERT INTO MatReqItems ( "&F&" ) VALUES ( "&V&" )"
				%><%="<SQL3__"&q&">"&SQL3&"</SQL3__"&q&">"%><%
				Set rs3=Server.CreateObject("AdoDB.RecordSet")
				rs3.Open SQL3, REDConnString
				q=q+1
			Loop
			%><count>0<%=q%></count><%
		End If
	
	
	Case "loadmrs"'------------------------------------------------------------------------------------------------------------------
	
		ProjID=Request.QueryString("projID")

		SQL="SELECT * FROM MaterialRequests WHERE ProjID="&ProjID&" ORDER BY Edit DESC, Done, Id"
		Set rs=Server.CreateObject("AdoDb.RecordSet")
		rs.Open SQL, REDConnString
		
		mrID=0
		If rs.EOF Then 
			%><totalCount>0</totalCount><%
			Done=1
			Edit=-1'I forgot what Edit is...
		Else 
			Done=rs("Done")
			Edit=rs("Edit")
			currentMrID=rs("Id")
			
			shipToAttn=rs("ShipToAttn")
			shipToName=rs("shipToName")
			shipToAddress=rs("shipToAddress")
			shipToCity=rs("shipToCity")
			shipToState=rs("shipToState")
			shipToZip=rs("shipToZip")
			ByEmpId=rs("ByEmpId")
			dueBy=rs("Due")
			notes=rs("notes")

			
			mrItems=-1
		End If
		%>
		<%		
		
		
		TotalItemCount=0
		Dim MatReqItemsIDList(4096)
		Dim mriPartsID(4096)
		Dim mriProjID(4096)
		Dim mriMfr(4096)
		Dim mriPN(4096)
		Dim mriDesc(4096)
		Dim mriUnitSize(4096)
		Dim mriCost(4096)
		Dim mriJpID(4096)
		Dim mriPO(4096)
		Dim mriQty(4096)
		
		mr=-1
		Do Until rs.EOF
			mr=mr+1
			opacity=""
			If rs("Done")=1 Then opacity=" opacity:.5; "
			
			Done=rs("Done")
			Edit=rs("Edit")
			mrID=rs("Id")
			shipToAttn=rs("ShipToAttn")
			shipToName=rs("shipToName")
			shipToAddress=rs("shipToAddress")
			shipToCity=rs("shipToCity")
			shipToState=rs("shipToState")
			shipToZip=rs("shipToZip")
			ByEmpId=rs("ByEmpId")

			empSQL="SELECT FName,LName FROM Employees WHERE EmpID="&ByEmpID
			Set empRS=Server.CreateObject("AdoDB.RecordSet")
			empRS.Open empSQL, REDConnString
			If Not empRS.EOF Then empName=empRS("FName")&" "&empRS("LName") Else empName="Error Employee #"&ByEmpID&" Is not in the database"
			Set empRS=Nothing
			
			d8=rs("Date")
			dueBy=rs("Due")
			notes=rs("notes")
			
			%><%="<MatReq__"&mr&">"%><%
				%>
				<id><%=mrID%></id>
				<done><%=Done%></done>
				<edit><%=Edit%></edit>
				<shipToAttn><%=shipToAttn%></shipToAttn>
				<shipToName><%=shipToName%></shipToName>
				<shipToAddress><%=shipToAddress%></shipToAddress>
				<shipToCity><%=shipToCity%></shipToCity>
				<shipToState><%=shipToState%></shipToState>
				<shipToZip><%=shipToZip%></shipToZip>
				<d8><%=d8%></d8>
				<byEmpId><%=ByEmpId%></byEmpId>
				<empName><%=empName%></empName>
				<dueBy><%=dueBy%></dueBy>
				<notes><%=notes%></notes>
				
				<%
				
				UnloadArray(MatReqItemsIDList)
				UnloadArray(mriPartsID)
				UnloadArray(mriProjID)
				UnloadArray(mriMfr)
				UnloadArray(mriPN)
				UnloadArray(mriDesc)
				UnloadArray(mriUnitSize)
				UnloadArray(mriCost)
				UnloadArray(mriJpID)
				UnloadArray(mriPO)
				UnloadArray(mriQty)
				
				SQL0="SELECT * FROM MatReqItems WHERE mRID="&rs("Id")&" AND needed=1 ORDER BY PartsID"
				%><itemsSQL><%=SQL0%></itemsSQL><%
				Set rs0=Server.CreateObject("AdoDb.RecordSet")
				rs0.Open SQL0, REDConnString
		
				If rs0.EOF Then
					%><empty>true</empty><%
				Else
					%><empty>false</empty><%
					MatReqItemsIDList(0)=MatReqItemsIDList(0)&rs0("ID")
					mriPartsID(0)=rs0("PartsID")
					mriProjID(0)=rs0("ProjID")
					mriMfr(0)=rs0("Mfr")
					mriPN(0)=rs0("PartNo")
					mriDesc(0)=rs0("Description")
					mriUnitSize(0)=rs0("unitSize")
					mriCost(0)=rs0("Cost")
					mriJpID(0)=rs0("JobPackID")
					mriPO(0)=rs0("PO")
					mriQty(0)=1
					'If len(MatReqItemsIDList(0))>1 Then MatReqItemsIDList(0)=MatReqItemsIDList(0)&","
					'MatReqItemsIDList(0)=MatReqItemsIDList(0)&rs0("ID")
					rs0.MoveNext
				End If
				
				mrItems=0 : loops=0
				Do Until rs0.EOF
					If rs0("PartsID")<>mriPartsID(mrItems) Then
						mrItems=mrItems+1
						mriPartsID(mrItems)=rs0("PartsID")
						mriProjID(mrItems)=rs0("ProjID")
						mriMfr(mrItems)=rs0("Mfr")
						mriPN(mrItems)=rs0("PartNo")
						mriDesc(mrItems)=rs0("Description")
						mriUnitSize(mrItems)=rs0("unitSize")
						mriCost(mrItems)=rs0("Cost")
						mriJpID(mrItems)=rs0("JobPackID")
						mriPO(mrItems)=rs0("PO")
						mriQty(mrItems)=1
					Else
						mriQty(mrItems)=mriQty(mrItems)+1
						TotalItemCount=TotalItemCount+1
					End If
					If len(MatReqItemsIDList(mrItems))>1 Then MatReqItemsIDList(mrItems)=MatReqItemsIDList(mrItems)&","
					MatReqItemsIDList(mrItems)=MatReqItemsIDList(mrItems)&rs0("ID")
					rs0.MoveNext
				Loop
				
				Set rs0=Nothing
				
				%>
				<itemCount><%=mrItems+1%></itemCount>
				<%
				For r=0 to mrItems'-1
					%>
					<%="<mrItems__"&r&">"%>
						<partsID><%=mriPartsID(r)%></partsID>
						<unitSize><%=mriUnitSize(r)%></unitSize>
						<mfr><%=mriMfr(r)%></mfr>
						<pn><%=mriPN(r)%></pn>
						<cost><%=mriCost(r)%></cost>
						<desc><%=mriDesc(r)%></desc>
						<%
						qtyAdjust=0
						If instr(MatReqItemsIDList(r),",") >0 Then 
							idList=Split(MatReqItemsIDList(r),",")(0) 
						Else 
							idList=MatReqItemsIDList(r)
						End If
						For ii=1 to (mriQty(r)-1)
							thisPartsID=Split(MatReqItemsIDList(r),",")(ii)
							If thisPartsID="" Or IsNull(thisPartsID) Then 
								TotalItemCount=TotalItemCount-1
								'qtyAdjust=qtyAdjust-1
								idList=idList&",null"
							Else
								idList=idList&","&thisPartsID
							End If
						Next
						%>
						<qty><%=(mriQty(r)+qtyAdjust)%></qty>
						<qtyAdjust><%=qtyAdjust%></qtyAdjust>
						<!-- idList><%=idList%></idList -->
						<idList><%=MatReqItemsIDList(r)%></idList>
					<%="</mrItems__"&r&">"%>
					<%
				Next
				
				%>
			<%="</MatReq__"&mr&">"%><%
			
		
			rs.MoveNext
		Loop
		
		%>
		<totalItemCount><%=totalItemCount%></totalItemCount>
		<mrCount><%=mr+1%></mrCount>
		<mrId><%=currentMrID%></mrId>
		<%

	Case "deletemr"'------------------------------------------------------------------------------------------------------------------
	
		id=Request.QueryString("id")
			
		SQL="DELETE FROM MatReqItems WHERE mRID="&id
		%><sql><%=SQL%></sql><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL,RedConnString
		
		SQL="DELETE FROM MaterialRequests WHERE ID="&id
		%><sql2><%=SQL%></sql2><%
		Set rs=Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL,RedConnString
		
		Set rs=Nothing


	Case "updatejpq"'------------------------------------------------------------------------------------------------------------------
		
		partsId=Request.QueryString("partsId")
		mrid=Request.QueryString("mrid")
		jpid=Request.QueryString("jpid")
		qty=Request.QueryString("qty")*1
		
		mrSQL="SELECT ProjID FROM MaterialRequests WHERE Id="&mrid
		Set mrRs=Server.CreateObject("AdoDB.RecordSet")
		mrRs.Open mrSQL, REDConnString
		ProjID=mrRs("ProjID")
		Set mrRs=Nothing
		
		SQL="SELECT ID, JobPackID, needed FROM MatReqItems WHERE PartsID="&PartsID&" AND mrId="&mrid&" ORDER BY PartsID, needed"
		%><sql><%=SQL%></sql><%
		Set rs=CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		Dim jp(4096)
		Dim jpiNeeded(4096)
		Dim needed(4096)
		Dim unNeeded(4096)
		Dim sent(4096)
		jpQty=0 : nQty=0 : unQty=0: sQty=0
		Do until rs.EOF
			thisJPid=rs("JobPackID")
			mriid=rs("ID")
			thisNeeded=rs("needed")="True"
			%><DEBUG><%="jpid:"&jpid&" thisJPID:"&thisJPID%></DEBUG><%
			If (thisJPid*1)=(jpid*1) Then
				jp(jpQty)=mriid
				%><%="<jp__"&jpQty&">"&mriid&"</jp__"&jpQty&">"%><%
				If thisNeeded Then jpiNeeded(jpQty)=1 Else jpiNeeded(jpQty)=0
				jpQty=jpQty+1
			Else
			End If
			If thisJPId>0 Then
				sent(sQty)=mriid
				%><%="<sent__"&sQty&">"&mriid&"</sent__"&sQty&">"%><%
				sQty=sQty+1
			Else
				If thisNeeded Then
					needed(nQty)=mriid
					%><%="<needed__"&nQty&">"&mriid&"</needed__"&nQty&">"%><%
					nQty=nQty+1
				Else
					unNeeded(nQty)=mriid
					%><%="<unNeeded__"&unQty&">"&mriid&"</unNeeded__"&unQty&">"%><%
					unQty=unQty+1
				End If
			End If
			rs.MoveNext
		Loop
		
		SQL0="SELECT Manufacturer, PartNumber, Description, Category1, Cost FROM Parts WHERE PartsID="&PartsID
		%><partSQL><%=sql0%></partSQL><%
		Set rs0=Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		
		Mfr=rs0("Manufacturer")
		PN=rs0("PartNumber")
		Desc=rs0("Description")
		Cost=rs0("Cost")
		Category=rs0("Category1")
		
		SQL0="SELECT unitSize FROM Categories WHERE Category='"&Category&"'"
		%><catSQL><%=sql0%></catSQL><%
		Set rs0=Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		If rs0.EOF Then unitSize=1 Else	unitSize=rs0("unitSize")
				
		Set rs0=Nothing
		
		qtyDiff=qty-jpQty
		
		%><sql1__0>placeholder</sql1__0><%
		%><DEBUG><%="jpid:"&jpid&" jpQty:"&jpQty&" qty:"&qty&" nqty:"&nqty&" qtyDiff:"&qtyDiff%></DEBUG><%
		If qtyDiff > 0 Then 
			' We will add parts to the Job Pack
			For i = 0 to qtyDiff-1
				if needed(i) = "" Then 
					'Since the quantity of parts in the Job Pack is more than what is on the M.R. then add a part to MatReqItems with the needed flag set to 0.
					cKey=SessionID&Timer
					SQL1="INSERT INTO MatReqItems (mRID, ProjID, PartsID, Mfr, PartNo, Description, unitSize, Cost, CreationKey, JobPackID, needed)"
					SQL1=SQL1&" VALUES ( "&mrid&", "&ProjID&", "&PartsID&", '"&Mfr&"', '"&PN&"', '"&Desc&"', "&unitSize&", '"&cKey&"', "&Cost&", "&jpid&",0 )"
					%><%="<sql1__"&i&">"&SQL1&"</sql1__"&i&">"%><%
					Set rs1=Server.CreateObject("AdoDB.RecordSet") 
					rs1.Open SQL1, RedConnString
				Else 
					'Since the quantity on the Job Pack hasn't exceeded the M.R. quantity, add this M.R. Item to the current Job Pack.
					SQL1="UPDATE MatReqItems SET JobPackID="&jpid&" WHERE ID="&needed(i)
					%><%="<sql1__"&i&">"&SQL1&"</sql1__"&i&">"%><%
					Set rs1=CreateObject("AdoDB.RecordSet")
					rs1.Open SQL1, REDConnString
				End If
			Next
		Else
			' We will take parts off the Job Pack
			qtyDiff=-qtyDiff
			For i = 0 to qtyDiff-1
				'If the item is not needed (not on the M.R.), we will delete it, but if it is, we'll take it off the Job Pack"
				If jpiNeeded(i)=1 Then		
					SQL1="UPDATE MatReqItems SET JobPackID=0 WHERE ID="&jp(i)
					%><%="<sql1__"&i&">"&SQL1&"</sql1__"&i&">"%><%
					Set rs1=CreateObject("AdoDB.RecordSet")
					rs1.Open SQL1, REDConnString
				Else
					SQL1="DELETE FROM MatReqItems WHERE ID="&jp(i)
					%><%="<sql1__"&i&">"&SQL1&"</sql1__"&i&">"%><%
					Set rs1=CreateObject("AdoDB.RecordSet")
					rs1.Open SQL1, REDConnString
				End If
			Next
		End If

		SQL2="SELECT ID, JobPackID, needed FROM MatReqItems WHERE PartsID="&PartsID&" AND mrId="&mrid&" ORDER BY PartsID"
		%><sql2><%=SQL2%></sql2><%
		Set rs2=CreateObject("AdoDB.RecordSet")
		rs2.Open SQL2, REDConnString
		
		jpQty=0 : nQty=0 : sQty=0 :qty=0
		%><jpid><%=jpid%></jpid><%
		Do until rs2.EOF
			thisJPid=rs2("JobPackID") : If thisJPid="" Then thisJPid=-1
			%><THISjpid><%=THISjpid%>:<%=jpid%></THISjpid><%
			mriid=rs2("ID")
			If rs2("needed")="True" Then nQty=nQty+1
			If (thisJPid*1)=(jpid *1) Then
				jpQty=jpQty+1
			Else
				If thisJPId>0 Then 
					sQty=sQty+1 
				Else 
					If rs2("needed")="True" Then nQty=nQty+1
				End If
			End If
			rs2.MoveNext
		Loop
		
		%>
		<jpQty><%=jpQty%></jpQty>
		<nQty><%=nQty-jpQty%></nQty>
		<sQty><%=sQty%></sQty>
		<%
		
		SQL3="SELECT Inventory FROM Parts WHERE PartsID="&PartsID
		%><sql3><%=SQL3%></sql3><%
		Set rs3=Server.CreateObject("AdoDB.RecordSet")
		rs3.Open SQL3, REDConnString
		%>
		<iQty>0<%=rs3("Inventory")%></iQty>
		<%
		
		
	Case "senditems"'----------------------------------------------------------------------------------------------------------------
		jpId=request.QueryString("jpId")
		keepJP= Not (request.QueryString("keepJP")="false")
		
		jpSQL="SELECT mrId FROM JobPacks WHERE ID="&jpId
		Set jpRS=Server.CreateObject("AdoDB.RecordSet")
		jpRS.Open jpSQL, REDConnString
		
		mrId=jpRS("mrId")
		
		miSQL="SELECT id,partsId,JobPackID FROM MatReqItems WHERE mrId="&mrId&" ORDER BY partsId,JobPackID"
		Set miRS=Server.CreateObject("AdoDB.RecordSet")
		miRS.Open miSQL, REDConnString
		
		Sent=0
		notSent=0
		miCount=0
		Do Until miRS.End
			If miRS("JobPackID")=jpId Then 
				SendSQL("UPDATE MatReqItems SET needed=0 WHERE ID="&miRS("ID"))
				Sent=Sent+1
			Else
				If miRS("JobPackID")=0 THEN notSent=notSent+1
			End If
			
			miCount=miCount+1
			miRS.MoveNext
		Loop
		
		If notSent=0 Then	SendSQL("UPDATE JobPacks SET Shipped=1 WHERE id="&jpId)

		
		
	Case Else '═════════════════════════════════════════════════════════════════════
		%>
		<error>No subroutine found for:<%=sAction%> </error>
		<%
End Select		

Set rs=Nothing : Set rs1=Nothing : Set rs2=Nothing : Set rs3=Nothing : Set rs4=Nothing : Set rs5=Nothing : Set rs6=Nothing : Set rs7=Nothing : Set rs8=Nothing : Set rs9=Nothing : Set rs0=Nothing

%>
</root>
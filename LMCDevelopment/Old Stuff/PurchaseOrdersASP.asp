<!--#include file="../../LMC/RED.asp" -->

<%

If Request.QueryString("HTML")=0 Then
	Response.ContentType = "text/xml"
Else
	Response.ContentType = "text/html"
End If

%>
<root>
	<action><%=Request.QueryString("action")%></action>
<%

Select Case CStr(Request.QueryString("action"))

	Case "NewPO"
		NewPO
	
	Case "GeneratePOs"
		GeneratePOs
		
		
		
	Case Else 
		 oops 
				
End Select		


%>
</root>
<%


Sub NewPO  () '------------------------------------------------------------------------

	ProjID=Request.QueryString("ProjID")
	d8=Request.QueryString("Date")
	VendorID=Request.QueryString("VendorID")
	
	%><Date><%=d8%></Date><%
	
	SQL="SELECT * FROM PurchaseOrders WHERE VendorID='"&VendorID&"' AND ProjID="&ProjID
	%><SQL><%=SQL%></SQL><%
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.open SQL, REDConnString
	
	SQL1="SELECT * FROM Projects WHERE ProjID="&ProjID
	Set rs1=Server.CreateObject("AdoDB.RecordSet")
	rs1.open SQL1, REDConnString
		ProjName=Replace(DecodeChars(rs1("ProjName")),"-"," ")
		ProjState=rs1("ProjState")
		CustID=rs1("CustomerID")
	Set rs1=Nothing
	
	SQL0="SELECT * FROM Customers WHERE CustID="&VendorID
	Set rs0=Server.CreateObject("AdoDB.RecordSet")
	rs0.open SQL0, REDConnString
		Vendor=rs0("Name")
	Set rs0=Nothing
	
	PONum=uCase("FA"&ProjState&"-"&ProjName&"-V"&VendorID&"-C"&CustID&"-")
	
	POIndex=1
	ShipCols="ShipToName, ShipToAddress, ShipToAddress2, ShipToCity, ShipToState, ShipToZip, ShipToPhone, ShipToFax"
	Columns="(PONum, ProjID, POIndex, Date, VendorID, "&ShipCols&", PaymentType)"
	ShipVals="'Tricom Communications', '1280 W Utah Ave Suite 103', '', 'Hildale', 'UT', '84784', '7023832800', '4358742801'"
	If rs.EOF Then
		%><Exists>0</Exists><% 
		PONum=PONum&"1"
		SQL2="INSERT INTO PurchaseOrders "&Columns&" VALUES ('"&PONum&"',"&ProjID&","&POIndex&", '"&Date&"', "&VendorID&", "&ShipVals&", 2)"
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.open SQL2, REDConnString
	Else
		%><Exists>1</Exists><%
		Do Until rs.EOF
			%><POID<%=POIndex%>><%=rs("POID")%></POID><%=POIndex%>><% 
			POIndex=POIndex+1
			rs.MoveNext
		Loop
		PONum=PONum&POIndex
		SQL2="INSERT INTO PurchaseOrders "&Columns&" VALUES ('"&PONum&"',"&ProjID&","&POIndex&", '"&Date&"', "&VendorID&", "&ShipVals&", 2)"
		%><SQL2><%=SQL2%></SQL2><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.open SQL2, REDConnString
	End If
	
	Set rs2=Nothing
	%><POIndex><%=POIndex%></POIndex><%
	%><ProjID><%=ProjID%></ProjID><%
	
	Set rs=Nothing
	Set rs2=Nothing
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub GeneratePOs() '------------------------------------------------------------------------
	
	ProjID=Request.QueryString("ProjID")
	SQL="SELECT * FROM BOMItems WHERE ProjID="&ProjID
	%><SQL><%=SQL%></SQL><%
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.Open SQL,REDConnString

	SQL1="SELECT * FROM Projects WHERE ProjID="&ProjID
	Set rs1=Server.CreateObject("AdoDB.RecordSet")
	rs1.open SQL1, REDConnString
		ProjName=Replace(DecodeChars(rs1("ProjName")),"-"," ")
		ProjState=rs1("ProjState")
		CustID=rs1("CustomerID")
	Set rs1=Nothing
	
	Dim Vendors(65536)
	Dim VendorIDs(65536)
	VendorsI=0
	
	Do Until rs.EOF
		
		ThisVendor=rs("Vendor")
		HaveThisVendor=False

		If IsNull(ThisVendor) Or ThisVendor="" Or ThisVendor="" Or ThisVendor="None" Then
			ThisVendor="NONE"
			sqlVendorFix="UPDATE BOMItems SET Vendor='NONE' WHERE BOMItemsID="&rs("BOMItemsID")
			%><sqlVendorFix><%=sqlVendorFix%></sqlVendorFix><%
			Set rsVendorFix=Server.CreateObject("AdoDB.RecordSet")
			rsVendorFix.Open sqlVendorFix,REDConnString
			Set rsVendorFix=Nothing
		End If
		
		For v= 0 to VendorsI
			If ThisVendor=Vendors(v) Then 
				HaveThisVendor=True
				Exit For
			End If
		Next		
		
		If Not HaveThisVendor Then
			VendorsI=VendorsI+1
			SQLVendor="SELECT CustID FROM Customers WHERE Name='"&ThisVendor&"'"
			Set rsVendor=Server.CreateObject("AdoDB.RecordSet")
			rsVendor.Open SQLVendor,REDConnString
			
			If rsVendor.EOF Then
				VendorIDs(v)=801  'This is the "None" Customer
			Else
				VendorIDs(v)=rsVendor("CustID")
				If VendorIDs(v)="" or IsNull(VendorIDs(v))  Then VendorIDs(v)=801  'This is the "None" Customer
			End If
			
			Vendors(v)=ThisVendor
		End If
		
		Response.Flush()
		rs.MoveNext
	Loop
	
	
	%><Vendors><%=VendorsI%></Vendors><%
	
	ExistingPOs=0
	For v=1 to VendorsI
		
		If VendorIDs(v)="" or IsNull(VendorIDs(v))  Then VendorIDs(v)=801  'This is the "None" Customer
		
		timestamp = year(now) & right("0"&month(now),2) & right("0"&day(now),2) & (timer*100)
		Key=Session.SessionID&timestamp

		POIndex="0"
		PONum=uCase("FA"&ProjState&"-"&ProjName&"-V"&VendorIDs(v)&"-C"&CustID&"-")&"0"

		ShipCols="ShipToName, ShipToAddress, ShipToAddress2, ShipToCity, ShipToState, ShipToZip, ShipToPhone, ShipToFax"
		Columns="(PONum, ProjID, POIndex, Date, VendorID, "&ShipCols&", PaymentType, Notes, creationKey)"
		ShipVals="'Tricom Communications', '1280 W Utah Ave Suite 103', '', 'Hildale', 'UT', '84784', '7023832800', '4358742801'"
		SQL4="INSERT INTO PurchaseOrders "&Columns&" VALUES ('"&PONum&"',"&ProjID&","&POIndex&", '"&Date&"', "&VendorIDs(v)&", "&ShipVals&", 2,'-AUTOMATICALLY GENERATED-', '"&Key&"')"
		'SQL4="INSERT INTO PurchaseOrders (ProjID, Date, PONum, VendorID, Notes, creationKey) VALUES ("&ProjID&",'"&DATE&"','XXXX-"&Vendors(v)&"-',"&VendorIDs(v)&",'-AUTOMATICALLY GENERATED-', '"&Key&"')"
		%><SQL4-<%=Vendors(v)%>><%=SQL4%></SQL4-><%=Vendors(v)%>><%
		Set rs4=Server.CreateObject("AdoDB.RecordSet")
		rs4.Open SQL4,REDConnString
		
		SQL5="SELECT POID FROM PurchaseOrders WHERE creationKey='"&Key&"'"
		Set rs5=Server.CreateObject("AdoDB.RecordSet")
		rs5.Open SQL5,REDConnString
			NewPOID=rs5("POID")
		Set rs5=Nothing
		
		SQL2="SELECT BOMItemsID, PartID, Qty, ItemName, ProjID, Vendor FROM BOMItems WHERE Vendor='"&Vendors(v)&"' AND ProjID="&ProjID
		%><SQL2-<%=Vendors(v)%>><%=SQL2%></SQL2-><%=Vendors(v)%>><%
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		rs2.Open SQL2,REDConnString
		
		Max=2048
		Loops=0
		Do Until rs2.EOF Or Loops>=Max
			Loops=Loops+1
			BomiID=CInt(Right(rs2("BOMItemsID"),6))
			
			SQL0="SELECT * FROM Parts WHERE PartsID="&rs2("PartID")
			Set rs0 = Server.CreateObject("AdoDB.RecordSet")
			rs0.Open SQL0, REDConnString
			
			PartCost=rs0("Cost")
			Set rs0=Nothing
			
			If PartCost="" or isNull(PartCost) Then PartCost=0
			
			sqlValues=rs2("PartID")&", "&NewPOID&", "&rs2("Qty")&", '"&rs2("ItemName")&"',"&PartCost
			SQL3="Insert Into POItems (PartID, POID, Qty, PartNumber, Cost) VALUES ("&sqlValues&")"
			%><SQL3-<%=v%>-<%=BomiID%>><%=SQL3%></SQL3-><%=v%>-<%=BomiID%>><%
			Set rs3=Server.CreateObject("AdoDB.RecordSet")
			rs3.Open SQL3,REDConnString
			
			Response.Flush()
			Set rs3=Nothing
			rs2.MoveNext
		Loop
		
		Set rs2=Nothing
	Next
	%><ExistingPOs><%=ExistingPOs%></ExistingPOs><%
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub oops ()'------------------------------------------------------------------------
	%>
	<Error>Missing "action" subroutine assignment for:<%=Request.QueryString("action")%></Error>
	<%
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%>
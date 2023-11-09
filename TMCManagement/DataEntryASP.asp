<!--#include file="../LMC/RED.asp" -->


<%
Dim GlobalCustID
XML=""

'Dim sAction 
'sAction = CStr(Request.QueryString("action"))
'Select Case sAction

Select Case CStr(Request.QueryString("action"))
	Case "UpdateText"
		UpdateText
		
	Case "GetManufList"
		GetManufList
		
	Case "GetSystemsList"
		GetSystemsList	
		
	Case "GetCategoryList"
		GetCategoryList
		
	Case "GetVendorList"
		GetVendorList
		
	Case "SearchParts"
		SearchParts
		
	Case "IncludeSearchParts"
		IncludeSearchParts
	
	
	
	Case "IncludedPartsList"'----------------------------------------------------------------------------------------------
		'IncludedPartsList
		Dim L : L=""
		Dim PartCount : PartCount=0
		Dim SubPID
	
		SQL= "SELECT * FROM PartsInclude WHERE PartID="&CStr(Request.QueryString("PartID"))
		Set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring	
		
		Do Until rs.EOF
			PartCount=PartCount+1
			
			SQL1="SELECT * FROM Parts WHERE PartsID="&rs("SubPartID")
			Set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			L=L&"<SQL1."&PartCount&">"&SQL1&"</SQL1."&PartCount&">"
			L=L&"<SubPartID"&PartCount&">"&rs("SubPartID")&"</SubPartID"&PartCount&">"
			L=L&"<RowID"&PartCount&">"&rs("PartsIncludeID")&"</RowID"&PartCount&">"
			L=L&"<Qty"&PartCount&">0"&rs("Qty")&"</Qty"&PartCount&">"

			L=L&"<Mfr"&PartCount&">"&rs1("Manufacturer")&"</Mfr"&PartCount&">"
			L=L&"<Model"&PartCount&">"&rs1("Model")&"</Model"&PartCount&">"
			L=L&"<PN"&PartCount&">"&rs1("PartNumber")&"</PN"&PartCount&">"
			L=L&"<Sys"&PartCount&">"&rs1("System")&"</Sys"&PartCount&">"
			L=L&"<Cat"&PartCount&">"&rs1("Category1")&"</Cat"&PartCount&">"
			L=L&"<Desc"&PartCount&">"&rs1("Description")&"</Desc"&PartCount&">"
'			'L=L&"<"&PartCount&">"&rs1("")&"</"&PartCount&">"
			
			rs.MoveNext			
			Set rs1 = Nothing
			
		Loop
		
		Set rs=nothing


		XML = "<PartCount>"&PartCount&"</PartCount>"&L
		response.ContentType = "text/xml"
		response.Write("<root><SQL>IncludedPartsList SQL Statement:"&Chr(13)&SQL&"</SQL>"&XML&"</root>")
		
	'End IncludePartsList ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		
		
	Case "IncludePart" '-------------------------------------------------------------------------------------------------------------
		'IncludePart
		
		Dim PartID : PartID=CStr(Request.QueryString("PartID"))
		Dim SubPartID : SubPartID=CStr(Request.QueryString("IncPartID"))
		
		SQL= "INSERT INTO PartsInclude (PartID, SubPartID) VALUES ("&PartID&","&SubPartID&")"
		Set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring	
		
		Set rs=nothing
		
		XML = "<root><SQL>SQL:"&SQL&"</SQL></root>"
		response.ContentType = "text/xml"
		response.Write(XML)
	'End IncludePart ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
		
		
	Case "ExcludePart" '-------------------------------------------------------------------------------------------------------------
		'ExcludePart
		
		Dim RowID : RowID=CStr(Request.QueryString("RowID"))
		
		SQL = "DELETE FROM PartsInclude WHERE PartsIncludeID = "&RowID
		Set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring	
		Set rs=nothing
		
		XML = "<root><SQL>SQL:"&SQL&"</SQL></root>"
		response.ContentType = "text/xml"
		response.Write(XML)
	'End ExcludePart ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
		
	Case "EditPart"
		EditPart
		
	Case "SaveExistingPart"
		SaveExistingPart
		
	Case "SaveNewPart"
		SaveNewPart
		
	Case "DeletePart"
		DeletePart
		
	Case "BidPresetNew"
		BidPresetNew
		
	Case "BidPresetList"
		BidPresetList
		
	Case "BidPresetEdit"
		BidPresetEdit
		
	Case "PresetSearchParts"
		PresetSearchParts
		
	Case "PresetAddItem"
		PresetAddItem

	Case "PresetDeletePart"
		PresetDeletePart
		
	Case "BidPresetDelete"
		BidPresetDelete
		
	Case "PresetSearchLabor"
		PresetSearchLabor		
		
	Case "SearchContacts"
		SearchContacts

	Case "ContactEdit"
		ContactEdit
		
	Case "ContactUpdate"
		ContactUpdate

	Case "SaveContact"
		SaveContact

	Case "ContactDel"
		ContactDel
		
	Case "LoadEmpList"
		LoadEmpList

	Case "OpenEmployee"
		OpenEmployee
		
	Case "UpdateEmployee"
		UpdateEmployee
		
	Case "SaveEmployee"
		SaveEmployee
		
	Case "DelEmployee"
		DelEmployee
		
	Case "UpdateAccess"
		UpdateAccess

	Case "NewUser"
		NewUser		

	Case "CheckUser"
		CheckUser		
		
		
		
	Case Else 
		 oops 
				
End Select		





Sub UpdateText() '------------------------------------------------------------------------------------------------------


Dim Text
Dim Table
Dim IDColumn
Dim Column
Dim RowID
XML=""
Dim Ok
Dim BoxID
Dim BoxType

	Text = CStr(Request.QueryString("Text"))
	Table = CStr(Request.QueryString("Table"))
	IDColumn = CStr(Request.QueryString("IDColumn"))
	Column = CStr(Request.QueryString("Column"))
	RowID = CStr(Request.QueryString("RowID"))
	SysOK = CStr(Request.QueryString("SysOK"))
	BoxID = CStr(Request.QueryString("BoxID"))
	BoxType = CStr(Request.QueryString("BoxType"))

	Text = Replace(Text, ",", " ")
	Text = Replace(Text, "'", " ")
	Text = Replace(Text, "+", " ")

  	
	SQL = "UPDATE "&Table&" SET "&Column&" ='"&Text&"' WHERE "&IDColumn&" = "&RowID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	'BoxID,BoxType,Table,IDColumn,Column,RowID

	if Key = "" then Key ="0" end if 	
    XML = ("<root><Ok>"&SysOK&"</Ok><BoxID>"&BoxID&"</BoxID> <BoxType>"&BoxType&"</BoxType> <Table>"&Table&"</Table> <IDColumn>"&IDColumn&"</IDColumn> <Column>"&Column&"</Column> <RowID>"&RowID&"</RowID></root>")

	response.ContentType = "text/xml"
	response.Write(XML)		
									  


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub GetManufList  () '--------------------------------------------------------------------------------------------------------


XML=""
Dim XML_Events
Dim ArrCount



XML_Events = ""
ArrCount = 1
     
						
			SQL = "SELECT * FROM Manufacturers ORDER BY Name"
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring	
			
			Do While Not rs.EOF 
			
			    XML_Events = XML_Events+"<ID"&ArrCount&">"&rs("ManufID")&"</ID"&ArrCount&">"
				XML_Events = XML_Events+"<Name"&ArrCount&">"&rs("Name")&"</Name"&ArrCount&">" 
				
			ArrCount = ArrCount + 1	
			       
			rs.MoveNext 
			Loop
			
			set rs = nothing


    XML = ("<root>"&XML_Events&"<ArrCount>"&ArrCount&"</ArrCount></root>")

	response.ContentType = "text/xml"
	response.Write(XML)
			
			
			
			

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub GetSystemsList  () '--------------------------------------------------------------------------------------------------------



XML=""
Dim XML_Events
Dim ArrCount



XML_Events = ""
ArrCount = 1
     
						
			SQL = "SELECT * FROM SystemList ORDER BY SystemName"
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring	
			
			Do While Not rs.EOF 
			
			    XML_Events = XML_Events+"<ID"&ArrCount&">"&rs("SystemID")&"</ID"&ArrCount&">"
				XML_Events = XML_Events+"<Name"&ArrCount&">"&rs("SystemName")&"</Name"&ArrCount&">" 
				
			ArrCount = ArrCount + 1	
			       
			rs.MoveNext 
			Loop
			
			
			
			set rs = nothing




    XML = ("<root>"&XML_Events&"<ArrCount>"&ArrCount&"</ArrCount></root>")

	response.ContentType = "text/xml"
	response.Write(XML)
			
			
			
			

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~













Sub GetCategoryList  () '--------------------------------------------------------------------------------------------------------


XML=""
Dim XML_Events
Dim ArrCount



XML_Events = ""
ArrCount = 1
     
						
			SQL = "SELECT * FROM Categories ORDER BY Category"
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring	
			
			Do While Not rs.EOF 
			
			    XML_Events = XML_Events+"<ID"&ArrCount&">"&rs("CategoryID")&"</ID"&ArrCount&">"
				XML_Events = XML_Events+"<Name"&ArrCount&">"&rs("Category")&"</Name"&ArrCount&">" 
				
			ArrCount = ArrCount + 1	
			       
			rs.MoveNext 
			Loop
			
			
			
			set rs = nothing




    XML = ("<root>"&XML_Events&"<ArrCount>"&ArrCount&"</ArrCount></root>")

	response.ContentType = "text/xml"
	response.Write(XML)
			
			
			
			

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~







Sub GetVendorList  () '--------------------------------------------------------------------------------------------------------

XML=""
Dim XML_Events
Dim ArrCount

XML_Events = ""
ArrCount = 0

SQL = "SELECT * FROM Customers WHERE Vendor='True' ORDER BY Name"
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring	

Do While Not rs.EOF 
	ArrCount = ArrCount + 1	

	XML_Events = XML_Events+"<ID"&ArrCount&">"&rs("CustID")&"</ID"&ArrCount&">"
	XML_Events = XML_Events+"<Name"&ArrCount&">"&rs("Name")&"</Name"&ArrCount&">" 
			 
	rs.MoveNext 
Loop

set rs = nothing

XML = ("<root>"&XML_Events&"<ArrCount>"&ArrCount&"</ArrCount></root>")

response.ContentType = "text/xml"
response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~








Sub SearchParts  () '--------------------------------------------------------------------------------------------------------
	
	response.ContentType = "text/xml"
	response.Write("<root>")
	
	XML=""
	Dim L
	Dim SearchTxt
	Dim SearchName
	Dim ModelColor
	Dim ManufColor
	Dim PartColor
	Dim DescColor
	Dim SysColor
	Dim CatColor
	Dim VendColor
	
	SearchTxt = CStr(Request.QueryString("SearchTxt"))
	SearchFields = CStr(Request.QueryString("SearchFields"))
	
'	if instr(SearchFields,"Manufacturer")>0 then
'	 ManufColor = "DD00DD" 
'	 else ManufColor = "000"  
'	end if 
'	
'	if instr(SearchFields,"Model")>0 then
'	 ModelColor = "DD00DD" 
'	 else ModelColor = "000"  
'	end if 
'	
'	if instr(SearchFields,"PartNumber")>0 then
'	 PartColor = "DD00DD" 
'	 else PartColor = "000"  
'	end if 
'	
'	if instr(SearchFields,"Description")>0 then
'	 DescColor = "DD00DD" 
'	 else DescColor = "000"  
'	end if
'	
'	if instr(SearchFields,"System")>0 then
'	 SysColor = "DD00DD" 
'	 else SysColor = "000"  
'	end if
'	
'	if instr(SearchFields,"Category1")>0 then
'	 CatColor = "DD00DD" 
'	 else CatColor = "000"  
'	end if
'	
'	if instr(SearchFields,"Vendor1")>0 then
'	 VendColor = "DD00DD" 
'	 else VendColor = "000"  
'	end if
	
	L = ""
	
	FieldsArray=Split(SearchFields,".")
	Response.Write("<Fields>"&uBound(FieldsArray)&"</Fields>")
	
	SQL = "SELECT * FROM Parts WHERE "&FieldsArray(0)&" LIKE '%"&SearchTxt&"%'"
	
	For f = 1 to uBound(FieldsArray)
		If f>=uBound(FieldsArray) Then Exit For
		SQL=SQL&" OR "&FieldsArray(F)&" LIKE '%"&SearchTxt&"%'"
	Next
	
	Response.Write("<SQL>"&SQL&"</SQL>")
	
  set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	
	
	MaxLoopNum=255
	LoopNum=0
	BG="background:#EDE0E7;"
	AltBG=BG
	Do While Not rs.EOF
		LoopNum=LoopNum+1
		
		if AltBG=BG Then AltBG="" Else AltBG=BG
		
		L=L&"<div id='Part"&rs("PartsID")&"' class='PartsListItemRow' Style='"&AltBG&"'>"
		L=L&	"<div class='PartsListItem' style='width:25px; padding:1px 0 0 3px; border-left:none;'>"
		L=L&		"<button class='PartsListItemEdit' onClick='DeletePart("&rs("PartsID")&");'>X</button>"
		L=L&	"</div>"
		L=L&	"<div class='PartsListItem' style='width:40px; padding:1px 0 0 3px;  '>"
		L=L&		"<button class='PartsListItemEdit' onClick='EditPart("&rs("PartsID")&");'>Edit</button>"
		L=L&	"</div>"
		L=L&	"<div class='PartsListItem' style='width:76px; color:#"&ManufColor&";'>"&rs("Manufacturer")&"</div>"
		L=L&	"<div class='PartsListItem' style='width:76px; color:#"&ModelColor&";'>"&rs("Model")&"</div>"
		L=L&	"<div class='PartsListItem' style='width:106px; color:#"&PartColor&";'>"&rs("PartNumber")&"</div>"
		L=L&	"<div class='PartsListItem' style='width:81px;display:inline; color:#"&SysColor&";'>"&rs("System")&"</div>"
		L=L&	"<div class='PartsListItem' style='width:116px;display:inline; color:#"&CatColor&";'>"&rs("Category1")&"</div>"
		L=L&	"<div class='PartsListItem' style='width:71px; display:inline; color:#"&VendColor&";'>"&rs("Vendor1")&"</div>"
		L=L&	"<div class='PartsListItem' style='width:71px; display:inline;'>$"&rs("Cost")&"</div>"
		L=L&	"<div class='PartsListItem' style='width:36px; display:inline;'>"&rs("LaborValue")&"</div>"
		L=L&	"<div class='PartsListItem' style='width:1px; display:inline; overflow:visible; color:#"&DescColor&"'>"&rs("Description")&" </div>"
		L=L&"</div>"
		
		If LoopNum>=MaxLoopNum Then
			L=L&"<div class=PartsListItemRow align=Center>Maximum of "&MaxLoopNum&" results reached.  Please refine your search.</div>"
			Exit Do
		End IF
		
		rs.MoveNext 
	Loop
	
	If LoopNum<MaxLoopNum Then L=L&"<div class=PartsListItemRow align=Center>"&LoopNum&" results.</div>"
	
	set rs = nothing	

	if L = "" then
		L = "None Found"
	Else
		Dim OldL
		Do While L<>OldL
			OldL=L
			L=Replace(Replace(Replace(L,"<","&lt;"),">","&gt;"),"^","""")
		Loop
	end if

	XML = "<Results>"&LoopNum&"</Results><Parts>"&L&"</Parts>" 
	
	Response.Write(XML&"</root>")

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub IncludeSearchParts  () '--------------------------------------------------------------------------------------------------------
	Dim SearchTimeout, TimerStamp
	TimerStamp=Timer
	SearchTimeout = 15 'In 15 seconds, stop searching & return results.
	Dim L
	Dim SQL
	Dim pID
	Dim Mfr
	Dim Model
	Dim PN
	Dim Sys
	Dim Cat
	Dim Vend
	Dim Desc
	Dim pCount: pCount=0
	Dim Col(5)
	Dim Txt(5)
	Dim Cols : Cols=5
	Col(1)="Manufacturer"
	Col(2)="Model"
	Col(3)="PartNumber"
	Col(4)="System"
	Col(5)="Description"
	Txt(1)=CStr(Request.QueryString("Mfr"))
	Txt(2)=CStr(Request.QueryString("Model"))
	Txt(3)=CStr(Request.QueryString("PN"))
	Txt(4)=CStr(Request.QueryString("Sys"))
	Txt(5)=CStr(Request.QueryString("Desc"))
	If Txt(1)="" And Txt(2)="" And Txt(3)="" And Txt(4)="" And Txt(5)="" Then
	Else
		
		Dim C : C=1
		Dim SQLW : SQLW=""
		SQL="SELECT * FROM Parts WHERE "
		'SQL=Txt(1)&Txt(2)&Txt(3)&Txt(4)&Txt(5)
		For C=1 To Cols
			If Txt(C) <> "" Then 
				If SQLW <> "" Then SQLW=SQLW&" AND "
				SQLW=SQLW&Col(C)&" LIKE '%"&Txt(C)&"%'"
			End If
		Next
		SQL=SQL&SQLW
		Set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring	
		
		Dim RowClr: RowClr="E0E8ED"
		Do Until rs.EOF
			pCount=pCount+1
			pID=rs("PartsID")
			
			'L=L&"<div id='Part"&pID&"' class='PartsListItemRow' onmouseover='MouseOverPartsAdd(""Part"&pID&""")' onmouseout='MouseOutPartsAdd(""Part"&pID&""")'>"
			'L=L&"<div class='PartsListItem' style='width:40px; padding:1px 0px 0px 3px; border-left: 1px solid #000;'>"
			'L=L&"<button class='PartsListItemEdit' onClick='EditPart("&rs("PartsID")&");'>Edit</button></div>"
			'L=L&"<div class='PartsListItem' style='width:70px; border-left: 1px solid #000;'>"&rs("Manufacturer")&"</div>"
			'L=L&"<div class='PartsListItem' style='width:70px; border-left: 1px solid #000;'>"&rs("Model")&"</div>"
			'L=L&"<div class='PartsListItem' style='width:100px; border-left: 1px solid #000;'>"&rs("PartNumber")&"</div>"
			'L=L&"<div class='PartsListItem' style='width:75px; border-left: 1px solid #000; display:inline;'>"&rs("System")&"</div>"
			'L=L&"<div class='PartsListItem' style='width:110px; border-left: 1px solid #000; display:inline;'>"&rs("Category1")&"</div>"
			'L=L&"<div class='PartsListItem' style='width:65px; border-left: 1px solid #000; display:inline;'>"&rs("Vendor1")&"</div>"
			'L=L&"<div class='PartsListItem' style='width:65px; border-left: 1px solid #000; display:inline;'>$"&rs("Cost")&"</div>"
			'L=L&"<div class='PartsListItem' style='width:30px; border-left: 1px solid #000; display:inline;'>"&rs("LaborValue")&"</div>"
			'L=L&"<div class='PartsListItem' style='width:400px; border-left: 1px solid #000; display:inline; >"&rs("Description")&" </div>"
			'L=L&"</div>"
			
			
			If RowClr="E0E8ED" Then RowClr="E8EDE0" Else RowClr="E0E8ED"
			L=L&"<div id=^Part"&pID&"^ class=^IncPartsListItemRow^ style=^background:#"&RowClr&"^>"
				L=L&"<div class='IncPartsListItem' style='width:42px; '>"
					L=L&"<button class='PartsListItemEdit' onClick='IncludePart("&pID&");'> ▼ Add </button>"
				L=L&"</div>"
				L=L&"<div class='IncPartsListItem' style='width:96px; ' title='"&rs("Manufacturer")&"'>"&rs("Manufacturer")&"</div>"
				L=L&"<div class='IncPartsListItem' style='width:48px; ' title='"&rs("Model")&"'>"&rs("Model")&"</div>"
				L=L&"<div class='IncPartsListItem' style='width:48px; ' title='"&rs("PartNumber")&"'>"&rs("PartNumber")&"</div>"
				L=L&"<div class='IncPartsListItem' style='width:48px; ' title='"&rs("System")&"'>"&rs("System")&"</div>"
				L=L&"<div class='IncPartsListItem' style='width:64px; ' title='"&rs("Category1")&"'>"&rs("Category1")&"</div>"
				L=L&"<div class='IncPartsListItem' style='overflow:visible; ' title='"&rs("Description")&"'>"&rs("Description")&"</div>"
				'L=L&"<div class='IncPartsListItem' style='width:48px; '>"&rs("")&"</div>"
			L=L&"</div>"
		
	'		If Abs(Timer-TimerStamp)>=SearchTimeout Then
	'			L=L&"<div style=^color:#4B637A; font-weight:bold;^>There's more but the "&CStr(Round(SearchTimeout*100)/100)&"-second Server-Timeout was reached.</div>"
	'			Exit Do
	'		End If
			
			
			rs.MoveNext
		
			If pCount>=100 Then 
				L=L&"<br/>The first 100 parts are shown.  Please refine your search."
				Exit Do
			End If
		
		Loop
		
	set rs = nothing	
	End If
	
	If L = "" then
		L = "None Found"
	Else
		Dim OldL
		Do While L<>OldL
			OldL=L
			L=Replace(Replace(Replace(L,"<","&lt;"),">","&gt;"),"^","""")
		Loop
		'L=EncodeChars(L)
	End if
	
	XML=""
	SQL="SQL:"&SQL
	SQL=""
	XML="<root><SQL>"&SQL&"</SQL><L>--"&L&"</L></root>"
	response.ContentType = "text/xml"
	response.Write(XML)
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub IncludePart()'--------------------------------------------------------------------------------------------------------
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub EditPart () '--------------------------------------------------------------------------------------------------------

Dim PartID
'XML=""
Dim XMLMain


PartID = CStr(Request.QueryString("PartID"))


    SQL = "SELECT * FROM Parts WHERE PartsID = "&PartID
    set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	dim Category2
	Category2 = rs("Category2")

	dim Model
	Model = rs("Model")

	dim Vendor2
	Vendor2 = rs("Vendor2")
	dim Vendor3
	Vendor3 = rs("Vendor3")
	dim Vendor4
	Vendor4 = rs("Vendor4")
	dim Vendor5
	Vendor5 = rs("Vendor5")
	dim Vendor6
	Vendor6 = rs("Vendor6")

	dim Cost2
	Cost2 = rs("Cost2")
	dim Cost3
	Cost3 = rs("Cost3")
	dim Cost4
	Cost4 = rs("Cost4")
	dim Cost5
	Cost5 = rs("Cost5")
	dim Cost6
	Cost6 = rs("Cost6")

	dim Date2
	dim Date3
	Date3 = rs("Date3")
	dim Date4
	Date4 = rs("Date4")
	dim Date5
	Date5 = rs("Date5")
	dim Date6
	Date6 = rs("Date6")

	  
		    
	XMLMain=XMLMain&"<PartID>-"&PartID&"</PartID>"
	XMLMain=XMLMain&"<Manufacturer>-"&rs("Manufacturer")&"</Manufacturer>"
	XMLMain=XMLMain&"<Model>-"&Model&"</Model>"
	XMLMain=XMLMain&"<PartNumber>-"&rs("PartNumber")&"</PartNumber>"
	XMLMain=XMLMain&"<Description>-"&rs("Description")&"</Description>"
	XMLMain=XMLMain&"<LaborValue>-"&rs("LaborValue")&"</LaborValue>"
	XMLMain=XMLMain&"<System>-"&rs("System")&"</System>"
	XMLMain=XMLMain&"<Category1>-"&rs("Category1")&"</Category1>"
	XMLMain=XMLMain&"<Category2>-"&Category2&"</Category2>"
	XMLMain=XMLMain&"<Vendor1>-"&rs("Vendor1")&"</Vendor1>"
	XMLMain=XMLMain&"<Cost>-"&rs("Cost")&"</Cost>"
	XMLMain=XMLMain&"<Vendor2>-"&Vendor2&"</Vendor2>"
	XMLMain=XMLMain&"<Vendor3>-"&Vendor3&"</Vendor3>"
	XMLMain=XMLMain&"<Vendor4>-"&Vendor4&"</Vendor4>"
	XMLMain=XMLMain&"<Vendor5>-"&Vendor5&"</Vendor5>"
	XMLMain=XMLMain&"<Vendor6>-"&Vendor6&"</Vendor6>"
	XMLMain=XMLMain&"<Cost>-"&rs("Cost")&"</Cost>"
	XMLMain=XMLMain&"<Cost1>-"&rs("Cost1")&"</Cost1>"
	XMLMain=XMLMain&"<Cost2>-"&Cost2&"</Cost2>"
	XMLMain=XMLMain&"<Cost3>-"&Cost3&"</Cost3>"
	XMLMain=XMLMain&"<Cost4>-"&Cost4&"</Cost4>"
	XMLMain=XMLMain&"<Cost5>-"&Cost5&"</Cost5>"
	XMLMain=XMLMain&"<Cost6>-"&Cost6&"</Cost6>"
	XMLMain=XMLMain&"<Date1>-"&rs("Date1")&"</Date1>"
	XMLMain=XMLMain&"<Date2>-"&Date2&"</Date2>"
	XMLMain=XMLMain&"<Date3>-"&Date3&"</Date3>"
	XMLMain=XMLMain&"<Date4>-"&Date4&"</Date4>"
	XMLMain=XMLMain&"<Date5>-"&Date5&"</Date5>"
	XMLMain=XMLMain&"<Date6>-"&Date6&"</Date6>"
	set rs = nothing
		

	 
	 
	'XML = "<root>"&XMLMain&"</root>" 
	response.ContentType = "text/xml"
	response.Write("<?xml version='1.0' encoding='ISO-8859-1'?><root>"&XMLMain&"</root>")
	%> <%'=XML%> <%


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~















Sub SaveExistingPart() 'Updates the calculation entries from a parts or labor entry----------------------------------------------------

	Dim PartID
	Dim Manufacturer
	Dim Model
	Dim PartNumber
	Dim sDescription
	Dim LaborValue
	Dim Systems
	Dim Category1
	Dim Category2
	Dim Cost
	Dim Cost1
	Dim Cost2
	Dim Cost3
	Dim Cost4
	Dim Cost5
	Dim Cost6
	Dim Vendor1
	Dim Vendor2
	Dim Vendor3
	Dim Vendor4
	Dim Vendor5
	Dim Vendor6
	XML=""

	PartID = CStr(Request.QueryString("PartID"))
	Manufacturer = CStr(Request.QueryString("Manufacturer"))
	Model = CStr(Request.QueryString("Model"))
	PartNumber = CStr(Request.QueryString("PartNumber"))
	sDescription = CStr(Request.QueryString("Description"))
	LaborValue = CStr(Request.QueryString("LaborValue"))
	System = CStr(Request.QueryString("System"))
	Category1 = CStr(Request.QueryString("Category1"))
	Category2 = CStr(Request.QueryString("Category2"))
	Cost = CStr(Request.QueryString("Cost"))
	Cost1 = CStr(Request.QueryString("Cost1"))
	Cost2 = CStr(Request.QueryString("Cost2"))
	Cost3 = CStr(Request.QueryString("Cost3"))
	Cost4 = CStr(Request.QueryString("Cost4"))
	Cost5 = CStr(Request.QueryString("Cost5"))
	Cost6 = CStr(Request.QueryString("Cost6"))
	Vendor1 = CStr(Request.QueryString("Vendor1"))
	Vendor2 = CStr(Request.QueryString("Vendor2"))
	Vendor3 = CStr(Request.QueryString("Vendor3"))
	Vendor4 = CStr(Request.QueryString("Vendor4"))
	Vendor5 = CStr(Request.QueryString("Vendor5"))
	Vendor6 = CStr(Request.QueryString("Vendor6"))
	Date1 = CStr(Request.QueryString("Date1"))
	Date2 = CStr(Request.QueryString("Date2"))
	Date3 = CStr(Request.QueryString("Date3"))
	Date4 = CStr(Request.QueryString("Date4"))
	Date5 = CStr(Request.QueryString("Date5"))
	Date6 = CStr(Request.QueryString("Date6"))

	Model = Replace(Model, ",", " ")
	Model = Replace(Model, "'", " ")
	Model = Replace(Model, "+", " ")
	Model = Replace(Model, "&", " ")
	Model = Replace(Model, "/", "-")	

	PartNumber = Replace(PartNumber, ",", " ")
	PartNumber = Replace(PartNumber, "'", " ")
	PartNumber = Replace(PartNumber, "+", " ")
	PartNumber = Replace(PartNumber, "&", " ")
	PartNumber = Replace(PartNumber, "/", "-")

	sDescription = Replace(sDescription, ",", " ")
	sDescription = Replace(sDescription, "'", " ")
	sDescription = Replace(sDescription, "+", " ")
	sDescription = Replace(sDescription, "&", " ")
	sDescription = Replace(sDescription, "/", "-")

	if Cost2 = "" then Cost2 = "NULL" end if
	if Cost3 = "" then Cost3 = "NULL" end if
	if Cost4 = "" then Cost4 = "NULL" end if
	if Cost5 = "" then Cost5 = "NULL" end if
	if Cost6 = "" then Cost6 = "NULL" end if

	if Date2 = "" then Date2 = "NULL" else Date2 = "'"&Date2&"'" end if
	if Date3 = "" then Date3 = "NULL" else Date3 = "'"&Date3&"'" end if
	if Date4 = "" then Date4 = "NULL" else Date4 = "'"&Date4&"'" end if
	if Date5 = "" then Date5 = "NULL" else Date5 = "'"&Date5&"'" end if
	if Date6 = "" then Date6 = "NULL" else Date6 = "'"&Date6&"'" end if


	SQL="UPDATE Parts SET Manufacturer='"&Manufacturer&"', Model='"&Model&"', PartNumber='"&PartNumber&"', Description='"&sDescription&"', LaborValue="&LaborValue&", System='"&System&"'"
	SQL=SQL&", Category1 = '"&Category1&"' , Category2 = '"&Category2&"', Cost = "&Cost&",  Cost1 = "&Cost1&", Cost2 = "&Cost2
	SQL=SQL&", Cost3 = "&Cost3&" , Cost4 = "&Cost4&", Cost5 = "&Cost5&", Cost6 = "&Cost6
	SQL=SQL&", Vendor1 = '"&Vendor1&"' , Vendor2 = '"&Vendor2&"', Vendor3 = '"&Vendor3&"', Vendor4 = '"&Vendor4&"', Vendor5 = '"&Vendor5&"', Vendor6 = '"&Vendor6&"'"
	SQL=SQL&", Date1 = '"&Date1&"', Date2 = "&Date2&", Date3 = "&Date3&", Date4 = "&Date4&", Date5 = "&Date5&", Date6 = "&Date6
	SQL=SQL&" WHERE PartsID = "&PartID
	
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing


	XML = ("<root><PartID>"&PartID&"</PartID><SQL>"&SQL&"</SQL></root>")

	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


















Sub SaveNewPart() 'Updates the calculation entries from a parts or labor entry----------------------------------------------------


	Dim Manufacturer
	Dim Model
	Dim PartNumber
	Dim sDescription
	Dim LaborValue
	Dim Systems
	Dim Category1
	Dim Category2
	Dim Cost
	Dim Cost1
	Dim Cost2
	Dim Cost3
	Dim Cost4
	Dim Cost5
	Dim Cost6
	Dim Vendor1
	Dim Vendor2
	Dim Vendor3
	Dim Vendor4
	Dim Vendor5
	Dim Vendor6
	XML=""
	Dim Date1
	Dim Date2
	Dim Date3
	Dim Date4
	Dim Date5
	Dim Date6
	Dim XMLparts
	Dim PartID


	Manufacturer = CStr(Request.QueryString("Manufacturer"))
	Model = CStr(Request.QueryString("Model"))
	PartNumber = CStr(Request.QueryString("PartNumber"))
	sDescription = CStr(Request.QueryString("Description"))
	LaborValue = CStr(Request.QueryString("LaborValue"))
	System = CStr(Request.QueryString("System"))
	Category1 = CStr(Request.QueryString("Category1"))
	Category2 = CStr(Request.QueryString("Category2"))
	Cost = CStr(Request.QueryString("Cost"))
	Cost1 = CStr(Request.QueryString("Cost1"))
	Cost2 = CStr(Request.QueryString("Cost2"))
	Cost3 = CStr(Request.QueryString("Cost3"))
	Cost4 = CStr(Request.QueryString("Cost4"))
	Cost5 = CStr(Request.QueryString("Cost5"))
	Cost6 = CStr(Request.QueryString("Cost6"))
	Vendor1 = CStr(Request.QueryString("Vendor1"))
	Vendor2 = CStr(Request.QueryString("Vendor2"))
	Vendor3 = CStr(Request.QueryString("Vendor3"))
	Vendor4 = CStr(Request.QueryString("Vendor4"))
	Vendor5 = CStr(Request.QueryString("Vendor5"))
	Vendor6 = CStr(Request.QueryString("Vendor6"))
	Date1 = CStr(Request.QueryString("Date1"))
	Date2 = CStr(Request.QueryString("Date2"))
	Date3 = CStr(Request.QueryString("Date3"))
	Date4 = CStr(Request.QueryString("Date4"))
	Date5 = CStr(Request.QueryString("Date5"))
	Date6 = CStr(Request.QueryString("Date6"))


	Model = Replace(Model, ",", " ")
	Model = Replace(Model, "'", " ")
	Model = Replace(Model, "+", " ")
	Model = Replace(Model, "&", " ")
	Model = Replace(Model, "/", "-")

	PartNumber = Replace(PartNumber, ",", " ")
	PartNumber = Replace(PartNumber, "'", " ")
	PartNumber = Replace(PartNumber, "+", " ")
	PartNumber = Replace(PartNumber, "&", " ")
	PartNumber = Replace(PartNumber, "/", "-")

	sDescription = Replace(sDescription, ",", " ")
	sDescription = Replace(sDescription, "'", " ")
	sDescription = Replace(sDescription, "+", " ")
	sDescription = Replace(sDescription, "&", " ")
	sDescription = Replace(sDescription, "/", "-")

		
	if Cost2 = "" then Cost2 = "NULL" end if
	if Cost3 = "" then Cost3 = "NULL" end if
	if Cost4 = "" then Cost4 = "NULL" end if
	if Cost5 = "" then Cost5 = "NULL" end if
	if Cost6 = "" then Cost6 = "NULL" end if

	if Date2 = "" then Date2 = "NULL" else Date2 = "'"&Date2&"'" end if
	if Date3 = "" then Date3 = "NULL" else Date3 = "'"&Date3&"'" end if
	if Date4 = "" then Date4 = "NULL" else Date4 = "'"&Date4&"'" end if
	if Date5 = "" then Date5 = "NULL" else Date5 = "'"&Date5&"'" end if
	if Date6 = "" then Date6 = "NULL" else Date6 = "'"&Date6&"'" end if

	SQL ="Insert into Parts (Manufacturer,Model,PartNumber,Description,Cost,LaborValue,System,Category1,Category2,"
	SQL = SQL + ("Cost1,Cost2,Cost3,Cost4,Cost5,Cost6,")
	SQL = SQL + ("Vendor1,Vendor2,Vendor3,Vendor4,Vendor5,Vendor6,")
	SQL = SQL + ("Date1,Date2,Date3,Date4,Date5,Date6)")
	SQL = SQL + (" VALUES ('"&Manufacturer&"','"&Model&"','"&PartNumber&"','"&sDescription&"',"&Cost&","&LaborValue&",'"&System&"','"&Category1&"','"&Category2&"',")
	SQL = SQL + (Cost1&","&Cost2&","&Cost3&","&Cost4&","&Cost5&","&Cost6&",")
	SQL = SQL + ("'"&Vendor1&"','"&Vendor2&"','"&Vendor3&"','"&Vendor4&"','"&Vendor5&"','"&Vendor6&"',")
	SQL = SQL + ("'"&Date1&"',"&Date2&","&Date3&","&Date4&","&Date5&","&Date6&")")
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	SQL = "select @@identity as 'PartIDs'"
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	PartID=rs("PartIDs")

	set rs2= nothing


   XMLparts =""

   XMLparts = XMLparts+("&lt;div id='Part"&PartID&"' class='PartsListItemRow'  onmouseover='MouseOverPartsAdd(""Part"&PartID&""")' onmouseout='MouseOutPartsAdd(""Part"&PartID&""")' &gt;")

		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:25px; padding:1px 0px 0px 3px; '&gt;&lt;button class='PartsListItemEdit' onClick='EditPart("&PartID&");'&gt;X&lt;/button&gt;&lt;/div&gt;")
		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:40px; padding:1px 0px 0px 3px;  border-left: 1px solid #000; '&gt;&lt;button class='PartsListItemEdit' onClick='EditPart("&PartID&");'&gt;Edit&lt;/button&gt;&lt;/div&gt;")
		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:70px; border-left: 1px solid #000;'&gt;"&Manufacturer&"&lt;/div&gt;")
		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:70px; border-left: 1px solid #000;'&gt;"&Model&"&lt;/div&gt;")
		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:100px; border-left: 1px solid #000;'&gt;"&PartNumber&"&lt;/div&gt;")
		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:75px; border-left: 1px solid #000;display:inline;'&gt;"&System&"&lt;/div&gt;")
		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:110px; border-left: 1px solid #000;display:inline;'&gt;"&Category1&"&lt;/div&gt;")
		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:65px; border-left: 1px solid #000;display:inline;'&gt;"&Vendor1&"&lt;/div&gt;")
		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:65px; border-left: 1px solid #000;display:inline;'&gt;$"&Cost&"&lt;/div&gt;")
		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:30px; border-left: 1px solid #000;display:inline;'&gt;"&LaborValue&"&lt;/div&gt;")
		XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:400px; border-left: 1px solid #000;display:inline;'&gt;"&sDescription&" &lt;/div&gt;")
		

	XMLparts = XMLparts+("&lt;/div&gt;")





	XML = ("<root><Part>"&XMLparts&"</Part></root>")

	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





















Sub DeletePart  () '--------------------------------------------------------------------------------------------------------

	Dim PartID


	PartID = CStr(Request.QueryString("PartID"))


	SQL = "DELETE FROM Parts WHERE PartsID = "&PartID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing



End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub BidPresetNew  () '--------------------------------------------------------------------------------------------------------


Dim PresetName
Dim SystemType
Dim BidPresetID
Dim SystemTypeText

		PresetName = CStr(Request.QueryString("PresetName"))
		SystemType = CStr(Request.QueryString("SystemType")) 
		SystemTypeText = CStr(Request.QueryString("SystemTypeText"))    
						
			SQL ="Insert into BidPresets (BidPresetSystemID,BidPresetSystem,BidPresetName) VALUES ("&SystemType&",'"&SystemTypeText&"','"&PresetName&"')"
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring
			
			SQL = "select @@identity as 'ID'"
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring
			
			BidPresetID=rs("ID")
			
			set rs = nothing




    XML = ("<root><SystemType>"&SystemType&"</SystemType><PresetName>"&PresetName&"</PresetName><BidPresetID>"&BidPresetID&"</BidPresetID></root>")

	response.ContentType = "text/xml"
	response.Write(XML)
			
			
			
			

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub BidPresetList  () '--------------------------------------------------------------------------------------------------------



XML=""
Dim XMLpresets


XMLpresets = ""

	SQL = "SELECT * FROM BidPresets order by BidPresetName"
    set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	

			Do While Not rs.EOF
				
				XMLpresets = XMLpresets & ("&lt;div id='BidPreset"&rs("BidPresetID")&"' class='BidPresetRListRow'")
				XMLpresets = XMLpresets & ("onmouseover='MouseOverPartsAdd(""BidPreset"&rs("BidPresetID")&""")' onmouseout='MouseOutPartsAdd(""BidPreset"&rs("BidPresetID")&""")' &gt;")
				
					XMLpresets = XMLpresets & ("&lt;div class='BidPresetRListItem' style='width:10%; padding:1px 0px 0px 0px; text-align:center; '&gt;")
					XMLpresets = XMLpresets & ("&lt;button onclick='BidPresetEdit("&rs("BidPresetID")&");' class='BidPresetRListBtn'&gt;E&lt;/button&gt;")
					XMLpresets = XMLpresets & ("&lt;button onclick='BidPresetDelete("&rs("BidPresetID")&");' class='BidPresetRListBtn' style='margin:0px 0px 0px 6px;'&gt;X&lt;/button&gt; &lt;/div&gt;")
					
					XMLpresets = XMLpresets & ("&lt;div class='BidPresetRListItem' style='width:38%; border-left: 1px solid #000;'&gt;"&rs("BidPresetName")&"&lt;/div&gt;")
					XMLpresets = XMLpresets & ("&lt;div class='BidPresetRListItem' style='width:45%; border-left: 1px solid #000;'&gt;"&rs("BidPresetSystem")&"&lt;/div&gt;")
					
				XMLpresets = XMLpresets & ("&lt;/div&gt;")
				
			rs.MoveNext 
			Loop
	set rs = nothing	


	if XMLpresets = "" then
		XMLpresets = "None Found"
	end if
	 
	 
	XML = "<root><BidPresetList>"&XMLpresets&"</BidPresetList></root>" 
	response.ContentType = "text/xml"
	response.Write(XML)


			
			
			
			

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





















Sub BidPresetEdit  () '--------------------------------------------------------------------------------------------------------


XML=""
Dim XML_Sting
Dim XMLparts
Dim XMLLabor
Dim Scope
Dim Includes
Dim Excludes


XML_Sting = ""

BidPresetID = CStr(Request.QueryString("BidPresetID"))



						
	SQL1 = "SELECT * FROM BidPresets where BidPresetID ="& BidPresetID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
		
	    Scope = (rs1("Scope").value)
		Includes = (rs1("Includes").value)
		Excludes = (rs1("Excludes").value)
		
		if IsNull(Scope) then Scope = "--" end if
		if IsNull(Includes) then Includes = "--" end if
		if IsNull(Excludes) then Excludes = "--" end if
		
		
		
		XML_Sting = XML_Sting+"<BidPresetName>"&rs1("BidPresetName")&"</BidPresetName>"
		XML_Sting = XML_Sting+"<BidPresetSystemID>"&rs1("BidPresetSystemID")&"</BidPresetSystemID>" 
		XML_Sting = XML_Sting+"<BidPresetID>"&rs1("BidPresetID")&"</BidPresetID>"
		XML_Sting = XML_Sting+"<Scope>"&Scope&"</Scope>"
		XML_Sting = XML_Sting+"<Includes>"&Includes&"</Includes>"
		XML_Sting = XML_Sting+"<Excludes>"&Excludes&"</Excludes>"

	set rs1 = nothing






XMLparts = ""

	SQL2 = "SELECT * FROM BidPresetItems WHERE BidPresetID = "&BidPresetID&" and Type = 'Part'"
    set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring	

			Do While Not rs2.EOF
			
			
				SQL = "SELECT * FROM Parts WHERE PartsID = "&rs2("ItemID")
				set rs=Server.CreateObject("ADODB.Recordset")
				rs.Open SQL, REDconnstring	
			
			
			    XMLparts = XMLparts & ("&lt;div id='Part"&rs("PartsID")&"' class='PartsListItemRow'   style='width:100%;' onmouseover='MouseOverPartsAdd(""Part"&rs("PartsID")&""")' onmouseout='MouseOutPartsAdd(""Part"&rs("PartsID")&""")' &gt;")
				
					XMLparts = XMLparts & ("&lt;div class='BidPresetPartsListItem' style='width:4%; padding:1px 0px 0px 3px;'&gt;&lt;button class='BidPresetRListBtn' onClick='PresetDeletePart("&rs2("BidPresetItemsID")&");'&gt; X &lt;/button&gt;&lt;/div&gt;")
					XMLparts = XMLparts & ("&lt;div class='BidPresetPartsListItem' style='width:14%; border-left: 1px solid #000;'&gt;"&rs("Manufacturer")&"&lt;/div&gt;")
					XMLparts = XMLparts & ("&lt;div class='BidPresetPartsListItem' style='width:14%; border-left: 1px solid #000;'&gt;"&rs("Model")&"&lt;/div&gt;")
					XMLparts = XMLparts & ("&lt;div class='BidPresetPartsListItem' style='width:14%; border-left: 1px solid #000;'&gt;"&rs("PartNumber")&"&lt;/div&gt;")
					XMLparts = XMLparts & ("&lt;div class='BidPresetPartsListItem' style='width:45%; border-left: 1px solid #000;display:inline;'&gt;"&rs("Description")&" &lt;/div&gt;")
				
				XMLparts = XMLparts+("&lt;/div&gt;")
				
				
				
				
				
			rs2.MoveNext 
			Loop
	set rs = nothing	
	set rs2 = nothing

	if XMLparts = "" then
		XMLparts = "None Found"
	end if










XMLLabor = ""

	SQL2 = "SELECT * FROM BidPresetItems WHERE BidPresetID = "&BidPresetID&" and Type = 'Labor'"
    set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring	

			Do While Not rs2.EOF
			
			
				SQL = "SELECT * FROM Labor WHERE LaborID = "&rs2("ItemID")
				set rs=Server.CreateObject("ADODB.Recordset")
				rs.Open SQL, REDconnstring	
			
			
			    XMLLabor = XMLLabor+("&lt;div id='Labor"&rs("LaborID")&"' class='LaborListItemRow'  onmouseover='MouseOverPartsAdd(""Labor"&rs("LaborID")&""")' onmouseout='MouseOutPartsAdd(""Labor"&rs("LaborID")&""")' &gt;")
				
					XMLLabor = XMLLabor+("&lt;div class='BidPresetLaborListItem' style='width:4.8%; padding:1px 0px 0px 3px;  border-left: 1px solid #000; '&gt;&lt;button class='PartsListItemAdd' onClick='PresetDeletePart("&rs2("BidPresetItemsID")&");'&gt;X&lt;/button&gt;&lt;/div&gt;")
					XMLLabor = XMLLabor+("&lt;div class='BidPresetLaborListItem' style='width:19.5%; border-left: 1px solid #000; '&gt;"&rs("Name")&"&lt;/div&gt;")
					XMLLabor = XMLLabor+("&lt;div class='BidPresetLaborListItem' style='width:70%; border-left: 1px solid #000; '&gt;"&rs("Description")&"&lt;/div&gt;")
					
				
				XMLLabor = XMLLabor+("&lt;/div&gt;")
				
				
				
				
			rs2.MoveNext 
			Loop
			
	set rs = nothing	
	set rs2 = nothing	


	if XMLLabor = "" then
		XMLLabor = "None Found"
	end if







    XML = ("<root>"&XML_Sting&"<PartsList>"&XMLparts&"</PartsList><LaborList>"&XMLLabor&"</LaborList></root>")

	response.ContentType = "text/xml"
	response.Write(XML)
			


			
			
			
			

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub PresetSearchParts  () '--------------------------------------------------------------------------------------------------------

XML=""
Dim XMLparts
Dim SearchTxt
Dim SearchName
Dim ModelColor
Dim ManufColor
Dim PartColor
Dim DescColor
Dim SysColor
Dim CatColor
Dim VendColor

SearchTxt = CStr(Request.QueryString("SearchTxt"))
SearchName = CStr(Request.QueryString("SearchName"))

if SearchName = "Manufacturer" then
 ManufColor = "DD00DD" 
 else ManufColor = "000"  
end if 

if SearchName = "Model" then
 ModelColor = "DD00DD" 
 else ModelColor = "000"  
end if 

if SearchName = "PartNumber" then
 PartColor = "DD00DD" 
 else PartColor = "000"  
end if 

if SearchName = "Description" then
 DescColor = "DD00DD" 
 else DescColor = "000"  
end if

if SearchName = "System" then
 SysColor = "DD00DD" 
 else SysColor = "000"  
end if

if SearchName = "Category1" then
 CatColor = "DD00DD" 
 else CatColor = "000"  
end if

if SearchName = "Vendor1" then
 VendColor = "DD00DD" 
 else VendColor = "000"  
end if

XMLparts = ""

	SQL = "SELECT * FROM Parts WHERE "&SearchName&" LIKE '%"&SearchTxt&"%' order by "&SearchName
    set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	

			Do While Not rs.EOF
			 
			    XMLparts = XMLparts+("&lt;div id='Part"&rs("PartsID")&"' class='PartsListItemRow'  onmouseover='MouseOverPartsAdd(""Part"&rs("PartsID")&""")' onmouseout='MouseOutPartsAdd(""Part"&rs("PartsID")&""")' &gt;")
				
					XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:40px; padding:1px 0px 0px 3px;  border-left: 1px solid #000; '&gt;&lt;button class='PartsListItemEdit' onClick='PresetAddItem("&rs("PartsID")&",""Part"");' &gt;ADD&lt;/button&gt;&lt;/div&gt;")
					XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:70px; border-left: 1px solid #000; color:#"&ManufColor&";'&gt;"&rs("Manufacturer")&"&lt;/div&gt;")
					XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:70px; border-left: 1px solid #000; color:#"&ModelColor&";'&gt;"&rs("Model")&"&lt;/div&gt;")
					XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:70px; border-left: 1px solid #000; color:#"&PartColor&";'&gt;"&rs("PartNumber")&"&lt;/div&gt;")
					XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:65px; border-left: 1px solid #000;display:inline;'&gt;$"&rs("Cost")&"&lt;/div&gt;")
					XMLparts = XMLparts+("&lt;div class='PartsListItem' style='width:400px; border-left: 1px solid #000;display:inline;  color:#"&DescColor&"'&gt;"&rs("Description")&" &lt;/div&gt;")
					
				
				XMLparts = XMLparts+("&lt;/div&gt;")
				
				
			rs.MoveNext 
			Loop
	set rs = nothing	


	if XMLparts = "" then
		XMLparts = "None Found"
	end if
	 
	 
	XML = "<root><Parts>"&XMLparts&"</Parts></root>" 
	response.ContentType = "text/xml"
	response.Write(XML)





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub PresetAddItem() '--------------------------------------------------------------------------------------------------------



	Dim PresetID
	Dim ItemID
	XML=""
	Dim sType

	PresetID = CStr(Request.QueryString("PresetID"))
	ItemID = CStr(Request.QueryString("ItemID"))
	sType = CStr(Request.QueryString("Type"))


	SQL = "Insert into BidPresetItems (BidPresetID,ItemID,Type) VALUES ("&PresetID&","&ItemID&",'"&sType&"')"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	set rs = nothing


    XML = ("<root><PresetID>"&PresetID&"</PresetID></root>")

	response.ContentType = "text/xml"
	response.Write(XML)





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub BidPresetDelete  () '--------------------------------------------------------------------------------------------------------

	Dim PresetID


	PresetID = CStr(Request.QueryString("PresetID"))


	SQL = "DELETE FROM BidPresets WHERE BidPresetID = "&PresetID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing



End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub PresetDeletePart  () '--------------------------------------------------------------------------------------------------------

	Dim PartID
	Dim PresetID
	XML=""


	PresetID = CStr(Request.QueryString("PresetID"))
	PartID = CStr(Request.QueryString("PartID"))


	SQL = "DELETE FROM BidPresetItems WHERE BidPresetItemsID = "&PartID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing



	XML = ("<root><PresetID>"&PresetID&"</PresetID></root>")

	response.ContentType = "text/xml"
	response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub PresetSearchLabor  () '--------------------------------------------------------------------------------------------------------

XML=""
Dim XMLLabor


XMLLabor = ""

	SQL = "SELECT * FROM Labor order by Name"
    set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	

			Do While Not rs.EOF
			 
			    XMLLabor = XMLLabor & ("&lt;div id='Labor"&rs("LaborID")&"' class='LaborListItemRow'  onmouseover='MouseOverPartsAdd(""Labor"&rs("LaborID")&""")' onmouseout='MouseOutPartsAdd(""Labor"&rs("LaborID")&""")' &gt;")
				
					XMLLabor = XMLLabor & ("&lt;div class='LaborListItem' style='width:45px; padding:1px 0px 0px 3px;  border-left: 1px solid #000; '&gt;&lt;button class='PartsListItemAdd' onClick='PresetAddItem("&rs("LaborID")&",""Labor"");' &gt;ADD&lt;/button&gt;&lt;/div&gt;")
					XMLLabor = XMLLabor & ("&lt;div class='LaborListItem' style='width:120px; border-left: 1px solid #000; '&gt;"&rs("Name")&"&lt;/div&gt;")
					XMLLabor = XMLLabor & ("&lt;div class='LaborListItem' style='width:400px; border-left: 1px solid #000; '&gt;"&rs("Description")&"&lt;/div&gt;")
					XMLLabor = XMLLabor & ("&lt;div class='LaborListItem' style='width:40px; border-left: 1px solid #000; '&gt;"&rs("RateCost")&"&lt;/div&gt;")
					
				
				XMLLabor = XMLLabor+("&lt;/div&gt;")
				
				
			rs.MoveNext 
			Loop
	set rs = nothing	


	if XMLLabor = "" then
		XMLLabor = "None Found"
	end if
	 
	XML = "<root><Labor>"&XMLLabor&"</Labor></root>" 
	response.ContentType = "text/xml"
	response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~













Sub SearchContacts  () '--------------------------------------------------------------------------------------------------------
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub ContactEdit  () '--------------------------------------------------------------------------------------------------------

XML=""
Dim XML_List

GlobalCustID = CStr(Request.QueryString("CustID"))

XML_List = "" 

Dim vName, vAddress, vCity, vState, vZip, vPhone1, vPhone2, vFax, vContact1, vCphone1, vEmail1
Dim vContact2, vCphone2, vEmail2, vTax, vMU, vNotes, vWebsite
Dim vCustomer, vVendor 'as Boolean

SQL = "SELECT * FROM Customers WHERE CustID = "&GlobalCustID
set rs = Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring


	vName = rs("Name")			:	if IsNull(vName) then vName = "--"			:if vName = "" then vName = "--"
	vAddress = rs("Address")	:	if IsNull(vAddress) then vAddress = "--"	:if vAddress = "" then vAddress = "--"
	vCity = rs("City")			:	if IsNull(vCity) then vCity = "--"			:if vCity = "" then vCity = "--"
	vState = rs("State")		:	if IsNull(vState) then vState = "--"		:if vState = "" then vState = "--"
	vZip = rs("Zip")			:	if IsNull(vZip) then vZip = "--"			:if vZip = "" then vZip = "--"
	vPhone1 = rs("Phone1")		:	if IsNull(vPhone1) then vPhone1 = "--"		:if vPhone1 = "" then vPhone1 = "--"
	vPhone2 = rs("Phone2")		:	if IsNull(vPhone2) then vPhone2 = "--"		:if vPhone2 = "" then vPhone2 = "--"
	vFax = rs("Fax")			:	if IsNull(vFax) then vFax = "--"			:if vFax = "" then vFax = "--"
	vContact1 = rs("Contact1")	:	if IsNull(vContact1) then vContact1 = "--"	:if vContact1 = "" then vContact1 = "--"
	vCphone1 = rs("Cphone1")	:	if IsNull(vCphone1) then vCphone1 = "--"	:if vCphone1 = "" then vCphone1 = "--"
	vEmail1 = rs("Email1")		:	if IsNull(vEmail1) then vEmail1 = "--"		:if vEmail1 = "" then vEmail1 = "--"
	vContact2 = rs("Contact2")	:	if IsNull(vContact2) then vContact2 = "--"	:if vContact2 = "" then vContact2 = "--"
	vCphone2 = rs("Cphone2")	:	if IsNull(vCphone2) then vCphone2 = "--"	:if vCphone2 = "" then vCphone2 = "--"
	vEmail2 = rs("Email2")		:	if IsNull(vEmail2) then vEmail2 = "--"		:if vEmail2 = "" then vEmail2 = "--"
	vTax = rs("Tax")			:	if IsNull(vTax) then vTax = "--"			:if vTax = "" then vTax = "--"
	vMU = rs("MU")				:	if IsNull(vMU) then vMU = "--"				:if vMU = "" then vMU = "--"
	vNotes = rs("Notes")		:	if IsNull(vNotes) then vNotes = "--"		:if vNotes = "" then vNotes = "--"
	vWebsite = rs("Website")	:	if IsNull(vWebsite) then vWebsite = "--"	:if vWebsite = "" then vWebsite = "--"
	vCustomer = rs("Customer")	:	if IsNull(vCustomer) then vCustomer = "False"
	vVendor = rs("Vendor")		:	if IsNull(vVendor) then vVendor = "False"



	XML_List = XML_List & "<CustID>-CannotBeNull-" &rs("CustID") &"</CustID>"
	XML_List = XML_List & "<Name>-CannotBeNull-" &vName &"</Name>"
	XML_List = XML_List & "<Address>-CannotBeNull-" &vAddress &"</Address>"
	XML_List = XML_List & "<City>-CannotBeNull-" &vCity &"</City>"
	XML_List = XML_List & "<State>-CannotBeNull-" &vState &"</State>"
	XML_List = XML_List & "<Zip>-CannotBeNull-" &vZip &"</Zip>"
	XML_List = XML_List & "<Phone1>-CannotBeNull-" &vPhone1 &"</Phone1>"
	XML_List = XML_List & "<Phone2>-CannotBeNull-" &vPhone2 &"</Phone2>"
	XML_List = XML_List & "<Fax>-CannotBeNull-" &vFax &"</Fax>"
	XML_List = XML_List & "<Contact1>-CannotBeNull-" &vContact1 &"</Contact1>"
	XML_List = XML_List & "<Cphone1>-CannotBeNull-" &vCphone1&"</Cphone1>"
	XML_List = XML_List & "<Email1>-CannotBeNull-" &vEmail1 &"</Email1>"
	XML_List = XML_List & "<Contact2>-CannotBeNull-" &vContact2 &"</Contact2>"
	XML_List = XML_List & "<Cphone2>-CannotBeNull-" &vCphone2 &"</Cphone2>"
	XML_List = XML_List & "<Email2>-CannotBeNull-" &vEmail2 &"</Email2>"
	XML_List = XML_List & "<Tax>-CannotBeNull-" &vTax &"</Tax>"
	XML_List = XML_List & "<MU>-CannotBeNull-" &vMU &"</MU>"
	XML_List = XML_List & "<Notes>-CannotBeNull-" &vNotes &"</Notes>"
	XML_List = XML_List & "<Website>-CannotBeNull-" &vWebsite &"</Website>"
	XML_List = XML_List & "<Customer>-CannotBeNull-" &vCustomer &"</Customer>"
	XML_List = XML_List & "<Vendor>-CannotBeNull-" &vVendor &"</Vendor>"

set rs = nothing



XML = ("<root>"&XML_List&"</root>")



response.ContentType = "text/xml"
response.Write(XML)


		

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub ContactUpdate() 'Updates Contact----------------------------------------------------

	XML=""
	Dim CustID
	Dim vName
	Dim vAddress
	Dim vCity
	Dim vState
	Dim vZip
	Dim vPhone1
	Dim vPhone2
	Dim vFax
	Dim vContact1
	Dim vCphone	
	Dim vEmail1
	Dim vContact2
	Dim vCphone2
	Dim vEmail2
	Dim vTax
	Dim vMU
	Dim vNotes
	Dim vWebsite
	Dim vCustomer
	Dim vVendor


	CustID = CStr(Request.QueryString("CustID"))
	vName = CStr(Request.QueryString("Name"))
	vAddress = CStr(Request.QueryString("Address"))
	vCity = CStr(Request.QueryString("City"))
	vState = CStr(Request.QueryString("State"))
	vZip = CStr(Request.QueryString("Zip"))
	vPhone1 = CStr(Request.QueryString("Phone1"))
	vPhone2 = CStr(Request.QueryString("Phone2"))
	vFax = CStr(Request.QueryString("Fax"))
	vContact1 = CStr(Request.QueryString("Contact1"))
	vCphone1 = CStr(Request.QueryString("Cphone1"))
	vEmail1 = CStr(Request.QueryString("Email1"))
	vContact2 = CStr(Request.QueryString("Contact2"))
	vCphone2 = CStr(Request.QueryString("Cphone2"))
	vEmail2 = CStr(Request.QueryString("Email2"))
	vTax = CStr(Request.QueryString("Tax"))
	vMU = CStr(Request.QueryString("MU"))
	vNotes = CStr(Request.QueryString("Notes"))
	vWebsite = CStr(Request.QueryString("Website"))
	vCustomer = CStr(Request.QueryString("Customer"))
	vVendor = CStr(Request.QueryString("Vendor"))

'	Model = Replace(Model, ",", " ")
'	Model = Replace(Model, "'", " ")
'	Model = Replace(Model, "+", " ")
'	Model = Replace(Model, "&", " ")
'	Model = Replace(Model, "/", "-")	
'	
'	if Cost2 = "" then Cost2 = "NULL"

	SQL = "UPDATE Customers SET Name = '"&vName&"'"
	SQL = SQL & ", Address = '"&vAddress&"'"
	SQL = SQL & ", City = '"&vCity&"'"
	SQL = SQL & ", State = '"&vState&"'"
	SQL = SQL & ", Zip = '"&vZip&"'"
	SQL = SQL & ", Phone1 = '"&vPhone1&"'"
	SQL = SQL & ", Phone2 = '"&vPhone2&"'"
	SQL = SQL & ", Fax = '"&vFax&"'"
	SQL = SQL & ", Contact1 = '"&vContact1&"'"
	SQL = SQL & ", Cphone1 = '"&vCphone1&"'"
	SQL = SQL & ", Email1 = '"&vEmail1&"'"
	SQL = SQL & ", Contact2 = '"&vContact2&"'"
	SQL = SQL & ", Cphone2 = '"&vCphone2&"'"
	SQL = SQL & ", Email2 = '"&vEmail2&"'"
	SQL = SQL & ", Tax = '"&vTax&"'"
	SQL = SQL & ", MU = '"&vMU&"'"
	SQL = SQL & ", Notes = '"&vNotes&"'"
	SQL = SQL & ", Website = '"&vWebsite&"'"
	SQL = SQL & ", Customer = '"&vCustomer&"'"
	SQL = SQL & ", Vendor = '"&vVendor&"'"
	SQL = SQL & " WHERE CustID = "&CustID

	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

		
	'SQL2 = "SELECT * FROM Customers WHERE CustID = "&CustID
	'set rs2 = Server.CreateObject("ADODB.Recordset")
	'rs2.Open SQL2, REDconnstring
	'
	'
	'
	'XMLStr = ""
	'
	'
	'
	''Dim CustCB, VendCB
	'
	'XMLStr = "<CustCB>" & "Cust: " & rs2("Customer") & "</CustCB>"
	'XMLStr = XMLStr & "<VendCB>" & "Vend: " & rs2("Vendor") & "</VendCB>"
	'set rs2 = nothing

	XMLStr = XMLStr & "<CustID>" & CustID & "</CustID>"
	XMLStr = XMLStr & "<Name>" & vName & "</Name>"
	XMLStr = XMLStr & "<Customer>" & vCustomer & "</Customer>"
	XMLStr = XMLStr & "<Vendor>" & vVendor & "</Vendor>"

	XML = ("<root>"+XMLStr+"</root>")

	response.ContentType = "text/xml"
	response.Write(XML)




End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub SaveContact() 'Updates the calculation entries from a parts or labor entry----------------------------------------------------

	Dim SQL
	Dim vName
	Dim vAddress
	Dim vCity
	Dim vState
	Dim vZip
	Dim vPhone1
	Dim vPhone2
	Dim vFax
	Dim vContact1
	Dim vCphone	
	Dim vEmail1
	Dim vContact2
	Dim vCphone2
	Dim vEmail2
	Dim vTax
	Dim vMU
	Dim vNotes
	Dim vWebsite
	Dim vCustomer
	Dim vVendor

	vName = CStr(Request.QueryString("Name"))
	vAddress = CStr(Request.QueryString("Address"))
	vCity = CStr(Request.QueryString("City"))
	vState = CStr(Request.QueryString("State"))
	vZip = CStr(Request.QueryString("Zip"))
	vPhone1 = CStr(Request.QueryString("Phone1"))
	vPhone2 = CStr(Request.QueryString("Phone2"))
	vFax = CStr(Request.QueryString("Fax"))
	vContact1 = CStr(Request.QueryString("Contact1"))
	vCphone1 = CStr(Request.QueryString("Cphone1"))
	vEmail1 = CStr(Request.QueryString("Email1"))
	vContact2 = CStr(Request.QueryString("Contact2"))
	vCphone2 = CStr(Request.QueryString("Cphone2"))
	vEmail2 = CStr(Request.QueryString("Email2"))
	vTax = CStr(Request.QueryString("Tax"))
	vMU = CStr(Request.QueryString("MU"))
	vNotes = CStr(Request.QueryString("Notes"))
	vWebsite = CStr(Request.QueryString("Website"))
	vCustomer = CStr(Request.QueryString("Customer"))
	vVendor = CStr(Request.QueryString("Vendor"))


'	Model = Replace(Model, ",", " ")
'	Model = Replace(Model, "'", " ")
'	Model = Replace(Model, "+", " ")
'	Model = Replace(Model, "&", " ")
'	Model = Replace(Model, "/", "-")

		
'	if Cost2 = "" then Cost2 = "NULL" end if

	SQL ="INSERT INTO Customers (Name, Address, City, State, Zip, Phone1, Phone2, Fax, Contact1, Cphone1, Email1, Contact2, Cphone2, Email2, Tax, MU, Notes, Website, Customer, Vendor)"		
	SQL = SQL &" VALUES ('" & vName & "', '" & vAddress & "','" & vCity & "','" & vState & "','" & vZip & "','" & vPhone1 & "','" & vPhone2 & "','" & vFax &"','" & vContact1 &"','" & vCphone1 &"','" & vEmail1 & "','" & vContact2 & "','" & vCphone2 & "','" & vEmail2 & "','" & vTax & "','" & vMU & "','" & vNotes & "','" & vWebsite & "','" & vCustomer & "','" & vVendor & "')"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing


   	XMLContacts =""

	XMLContacts ="<Name>" & vName & "</Name>"



	XML = ("<root>"&XMLContacts&"</root>")

	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub ContactDel() '----------------------------------------------------------------------------------------------------------


	Dim CustID
	CustID = CStr(Request.QueryString("CustID"))


	SQL2 = "DELETE FROM Customers WHERE CustID = " & CustID
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring
	set rs2 = nothing



    XML = ("<root><CustID>Deleted-" & CustID & "</CustID></root>")

	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
















































Sub LoadEmpList  () '--------------------------------------------------------------------------------------------------------

	XML=""
	Dim XML_List

	XML_List = "Error" 
    XML = ("<root><EmpList>"&XML_List&"</EmpList></root>")

    

	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub OpenEmployee () '--------------------------------------------------------------------------------------------------------

Dim EmpID

EmpID = CStr(Request.QueryString("EmpID"))



XML=""
Dim XMLMain



XMLMain = ""


  SQL = "SELECT * FROM Employees WHERE EmpID = " & EmpID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	dim eFName 		: eFName = rs("FName")
	dim eLName 		: eLName = rs("LName")
	dim ePosition : ePosition = rs("Position")
	dim eWage 		: eWage = rs("Wage")
	dim eAddress	: eAddress = rs("Address")
	dim eCity 		: eCity = rs("City")
	dim eState 		: eState = rs("State")
	dim eZip 			: eZip = rs("Zip")
	dim ePhone 		: ePhone = rs("Phone")
	dim ePhone2 	: ePhone2 = rs("Phone2")
	dim eDCPhone	: eDCPhone = rs("DCPhone")
	dim eEmail 		: eEmail = rs("Email")
	dim eHired 		: eHired = rs("Hired")
	dim Active 		: Active = rs("Active")
		
	if IsNull(eFName) then eFName = "--" 			:	if eFName = "" then eFName = "--"
	if IsNull(eLName) then eLName = "--" 			:	if eLName = "" then eLName = "--"
	if IsNull(ePosition) then ePosition = "--":	if ePosition = "" then ePosition = "--"
	if IsNull(eWage) then eWage = "--"				:	if eWage = "" then eWage = "--"
	if IsNull(eAddress) then eAddress = "--" 	:	if eAddress = "" then eAddress = "--"
	if IsNull(eCity) then eCity = "--" 				:	if eCity = "" then eCity = "--"
	if IsNull(eState) then eState = "--" 			:	if eState = "" then eState = "--"
	if IsNull(eZip) then eZip = "--" 					:	if eZip = "" then eZip = "--"
	if IsNull(ePhone) then ePhone = "--" 			:	if ePhone = "" then ePhone = "--"
	if IsNull(ePhone2) then ePhone2 = "--" 		:	if ePhone2 = "" then ePhone2 = "--"
	if IsNull(eDCPhone) then eDCPhone = "--" 	:	if eDCPhone = "" then eDCPhone = "--"
	if IsNull(eEmail) then eEmail = "--" 			:	if eEmail = "" then eEmail = "--"
	if IsNull(eHired) or eHired = "" then eHired = "12/31/2049"
	eHired = formatDateTime(eHired)
	if IsNull(Active) then Active = "True"	End if	:	if Active = "" then Active = "True"

		    
	XMLMain = XMLMain + "<EmpID>" & rs("EmpID") & "</EmpID>"
	XMLMain = XMLMain + "<FName>--" & eFName & "</FName>"
	XMLMain = XMLMain + "<LName>--" & eLName & "</LName>"
	XMLMain = XMLMain + "<Position>--" & ePosition & "</Position>"
	XMLMain = XMLMain + "<Wage>--" & eWage & "</Wage>"
	XMLMain = XMLMain + "<Address>--" & eAddress & "</Address>"
	XMLMain = XMLMain + "<City>--" & eCity & "</City>"
	XMLMain = XMLMain + "<State>--" & eState & "</State>"
	XMLMain = XMLMain + "<Zip>--" & eZip & "</Zip>"
	XMLMain = XMLMain + "<Phone>--" & ePhone & "</Phone>"
	XMLMain = XMLMain + "<Phone2>--" & ePhone2 & "</Phone2>"
	XMLMain = XMLMain + "<DCPhone>--" & eDCPhone & "</DCPhone>"
	XMLMain = XMLMain + "<Email>--" & eEmail & "</Email>"
	XMLMain = XMLMain + "<Active>" & Active & "</Active>"

	XMLMain = XMLMain + "<HiredDate>" & eHired & "</HiredDate>"
	  
	set rs = nothing


  SQL = "SELECT * FROM Access WHERE EmpID = " & EmpID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	Dim DataEntry
	Dim Estimates
	Dim Projects
	Dim Service
	Dim TestMaint
	Dim Engineering
	Dim Purchasing
	Dim TimeEntry
	Dim Office
	Dim Inventory
	Dim Training
	Dim Website
	Dim Admin
	Dim User

	Dim HasAccess
	HasAccess=1
	If rs.EOF Then HasAccess=0

	XMLMain=XMLMain & "<HasAccess>" & HasAccess & "</HasAccess>"

	Do Until rs.EOF
		DataEntry = rs("DataEntry")    
		Estimates = rs("Estimates")    
		Projects = rs("Projects")      
		Service = rs("Service")        
		TestMaint = rs("Test")         
		Engineering = rs("Engineering")
		Purchasing = rs("Purchasing")  
		TimeEntry = rs("Time")         
		Office = rs("Office")          
		Inventory = rs("Inventory")    
		Training = rs("Training")      
		Website = rs("Website")        
		Admin = rs("Admin")            
		User = rs("UserName")            
		rs.MoveNext
	Loop

	If DataEntry <> "True" Or (IsNull(DataEntry)) Then DataEntry = "False"
	If IsNull(Estimates) Then Estimates = "False"
	If IsNull(Projects) Then Projects = "False"
	If IsNull(Service) Then Service = "False"
	If IsNull(TestMaint) Then TestMaint = "False"
	If IsNull(Engineering) Then Engineering = "False"
	If IsNull(Purchasing) Then Purchasing = "False"
	If IsNull(TimeEntry) Then TimeEntry = "False"
	If IsNull(Office) Then Office = "False"
	If IsNull(Inventory) Then Inventory = "False"
	If IsNull(Training) Then Training = "False"
	If IsNull(Website) Then Website = "False"
	If IsNull(Admin) Then Admin = "False"

	set rs = nothing
	 
	XMLMain=XMLMain+"<DataEntry>"&DataEntry&"</DataEntry>"
	XMLMain=XMLMain+"<Estimates>"&Estimates&"</Estimates>"
	XMLMain=XMLMain+"<Projects>"&Projects&"</Projects>"
	XMLMain=XMLMain+"<Service>"&Service&"</Service>"
	XMLMain=XMLMain+"<Test>"&TestMaint&"</Test>"
	XMLMain=XMLMain+"<Engineering>"&Engineering&"</Engineering>"
	XMLMain=XMLMain+"<Purchasing>"&Purchasing&"</Purchasing>"
	XMLMain=XMLMain+"<Time>"&TimeEntry&"</Time>"
	XMLMain=XMLMain+"<Office>"&Office&"</Office>"
	XMLMain=XMLMain+"<Inventory>"&Inventory&"</Inventory>"
	XMLMain=XMLMain+"<Training>"&Training&"</Training>"
	XMLMain=XMLMain+"<Website>"&Website&"</Website>"
	XMLMain=XMLMain+"<Admin>"&Admin&"</Admin>"
	XMLMain=XMLMain+"<User>"&User&"</User>"

	XML = "<root>"&XMLMain&"</root>" 
	response.ContentType = "text/xml"
	response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






sub UpdateEmployee() '--------------------------------------------------------------------------------------------

	XML=""
	Dim XMLStr
	Dim EmpID
	Dim eFName
	Dim eLName
	dim ePosition 
	dim eWage 		
	dim eAddress	
	dim eCity 		
	dim eState 		
	dim eZip 			
	dim ePhone 		
	dim ePhone2 	
	dim eDCPhone	
	dim eEmail 		
	dim eHired
	dim Active

	EmpID = CStr(Request.QueryString("EmpID"))
	eFName = CStr(Request.QueryString("FName"))
	eLName = CStr(Request.QueryString("LName"))
	ePosition = CStr(Request.QueryString("Position"))
	eWage = CStr(Request.QueryString("Wage"))
	eAddress = CStr(Request.QueryString("Address"))
	eCity = CStr(Request.QueryString("City"))
	eState = CStr(Request.QueryString("State"))
	eZip = CStr(Request.QueryString("Zip"))
	ePhone = CStr(Request.QueryString("Phone"))
	ePhone2 = CStr(Request.QueryString("Phone2"))
	eDCPhone = CStr(Request.QueryString("DCPhone"))
	eEmail = CStr(Request.QueryString("Email"))
	eHired = CStr(Request.QueryString("Hired"))
	Active = CStr(Request.QueryString("Active"))

'	Model = Replace(Model, ",", " ")
'	Model = Replace(Model, "'", " ")
'	Model = Replace(Model, "+", " ")
'	Model = Replace(Model, "&", " ")
'	Model = Replace(Model, "/", "-")	
'	
'	if Cost2 = "" then Cost2 = "NULL"

	SQL = "UPDATE Employees SET FName = '"&eFName&"', LName='"&eLName&"', Position='"&ePosition&"', Hired='"&eHired&"', Wage='"&eWage&"', Address='"&eAddress&"'"
	SQL = SQL +", City='"&eCity&"', State='"&eState&"', Zip='"&eZip&"', Phone='"&ePhone&"', Phone2='"&ePhone2&"', DCPhone='"&eDCPhone&"', Email='"&eEmail&"',Active='"&Active&"'"
	SQL = SQL & " WHERE EmpID = "&EmpID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	XMLStr = "<EmpID>" & EmpID & "</EmpID>"
	XMLStr = XMLStr & "<FName>" & eFName & "</FName>"

	XML = ("<root>"+XMLStr+"</root>")

	response.ContentType = "text/xml"
	response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub SaveEmployee() 'Updates the calculation entries from a parts or labor entry----------------------------------------------------

	XML=""
	Dim XMLData
	Dim SQL

	Dim EmpID
	Dim eFName
	Dim eLName
	dim ePosition 
	dim eWage 		
	dim eAddress	
	dim eCity 		
	dim eState 		
	dim eZip 			
	dim ePhone 		
	dim ePhone2 	
	dim eDCPhone	
	dim eEmail 		
	dim eHired

	EmpID = CStr(Request.QueryString("EmpID"))
	eFName = CStr(Request.QueryString("FName"))
	eLName = CStr(Request.QueryString("LName"))
	ePosition = CStr(Request.QueryString("Position"))
	eWage = CStr(Request.QueryString("Wage"))
	eAddress = CStr(Request.QueryString("Address"))
	eCity = CStr(Request.QueryString("City"))
	eState = CStr(Request.QueryString("State"))
	eZip = CStr(Request.QueryString("Zip"))
	ePhone = CStr(Request.QueryString("Phone"))
	ePhone2 = CStr(Request.QueryString("Phone2"))
	eDCPhone = CStr(Request.QueryString("DCPhone"))
	eEmail = CStr(Request.QueryString("Email"))
	eHired = Request.QueryString("Hired")
	
	if eHired = "" Or IsNull(eHired) Then
		eHired="1/1/1900"
	Else
		eHired = CDate(eHired)
	End If

'	Model = Replace(Model, ",", " ")
'	Model = Replace(Model, "'", " ")
'	Model = Replace(Model, "+", " ")
'	Model = Replace(Model, "&", " ")
'	Model = Replace(Model, "/", "-")
		
'	if Cost2 = "" then Cost2 = "NULL" end if

dim SQLInsert
dim SQLValues	

	SQLInsert ="INSERT INTO Employees (FName, LName, Position, Wage, Address, City, State, Zip, Phone, Phone2, DCPhone, Email, Hired, Active)"		
	SQLValues =" VALUES ('"&eFName&"', '"&eLName&"', '"&ePosition&"', '"&eWage&"', '"&eAddress&"', '"&eCity&"', '"&eState&"', '"&eZip&"', '"&ePhone&"', '"&ePhone2&"', '"&eDCPhone&"', '"&eEmail&"', '"&eHired& "',1)"
	SQL = SQLInsert & SQLValues
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing


   	XMLData =""

	XMLData ="<FName>" & eFName & "</FName>"



	XML = ("<root>"&XMLData&"</root>")

	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub DelEmployee() '----------------------------------------------------------------------------------------------------------


	Dim EmpID
	EmpID = CStr(Request.QueryString("EmpID"))


	SQL2 = "DELETE FROM Employees WHERE EmpID = " & EmpID
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring
	set rs2 = nothing



    XML = ("<root><EmpID>Deleted-" & CustID & "</EmpID></root>")

	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub UpdateAccess() '----------------------------------------------------------------------------------------------------------


	Dim aField
	Dim aValue
	aField = CStr(Request.QueryString("Field"))
	aValue = CStr(Request.QueryString("Value"))
	User = CStr(Request.QueryString("User"))


	SQL2 = "UPDATE Access Set "&aField&"= '"&aValue&"' WHERE UserName = '"&User&"'"
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring
	set rs2 = nothing



    XML = ("<root><EmpID>Deleted-" & CustID & "</EmpID></root>")

	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub NewUser() '------------------------------------------------------------------------------------

	Dim EmpID
	Dim User
	Dim Pass
	Dim Url

	EmpID = CStr(Request.QueryString("EmpID"))
	User = CStr(Request.QueryString("User"))
	Pass = CStr(Request.QueryString("Pass"))
	url = "https://www.rcstri.com/website/tmcmanagement/tmc.html"

	SQL2 = "INSERT INTO Access (EmpID,UserName,Password,url) Values("&EmpID&",'"&User&"','"&Pass&"','"&Url&"')"
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring
	set rs2 = nothing

	response.ContentType = "text/xml"
	response.Write("<root><EmpID>"&EmpID&"</EmpID></root>")

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub CheckUser() '------------------------------------------------------------------------------------
	Dim User
	Dim Available

	User = CStr(Request.QueryString("User"))

	SQL2 = "SELECT * FROM Access WHERE User='"&User&"'"
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring

	if rs2.eof then Available=1 else Available = 0

	set rs2 = nothing

	response.ContentType = "text/xml"
	response.Write("<root><Available>"&Available&"</Available></root>")
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub oops  () '--------------------------------------------------------------------------------------------------------
	response.write "Oops Didn't Work"
End Sub '------------------------------------------------------------------------------------------------------------------------

%>

 
<!--#include file="../../TMC/RED.asp" -->




<%
Dim sAction 

sAction = CStr(Request.QueryString("action"))

Select Case sAction

	Case "UpdateText"
		UpdateText
		
	Case "UpdateSystemPrint"
		UpdateSystemPrint

	Case "GetEmployeeList"
		GetEmployeeList
		
	Case "GetTaskList"
		GetTaskList
	
	Case "GetBidTo"
		GetBidTo
		
	Case "NewEventSingle"
		NewEventSingle
		   
	Case "FindCust"
		FindCust
		
	Case "LoadAreaProj"
		LoadAreaProj
		
	Case "FindProj"
		FindProj
				
	Case "OpenProject"
		OpenProject
					
	Case "NewProject"
		NewProject

	Case "NewProjSave"
		NewProjSave
		
	Case "NewSystem"
		NewSystem
		
	Case "OpenSystem"
		OpenSystem
		
	Case "PartsList"
		PartsList
		
	Case "LaborList"
		LaborList	

	Case "UpdateSystem"
		UpdateSystem
		
	Case "ToggleActiveProject"
		ToggleActiveProject	

	Case "CheckBoxSysUpdate"
		CheckBoxSysUpdate
		
	Case "ListEntryUpdate"
		ListEntryUpdate
		
	Case "ListSubItemsUpdate"
		ListSubItemsUpdate
		
	Case "CalcProjTotals"
		CalcProjTotals
		
	Case "CalculateEstTotal"
		CalculateEstTotal
			
	Case "UpdateAllItemCosting"
		UpdateAllItemCosting
		
	Case "ItemSelected"
		ItemSelected
		
	Case "UncheckAll"
		UncheckAll
	
	Case "DeleteItems"
		DeleteItems
		
	Case "DeleteProject"
		DeleteProject

	Case "DeleteSystem"
		DeleteSystem
		
	Case "SearchParts"
		SearchParts
		
	Case "AddPart"
		AddPart
		
	Case "SearchLabor"
		SearchLabor
	
	Case "AddLabor"
		AddLabor
	
	
	
	Case "SystemsList"
		SystemsList
		
	Case "LetterHeadSW"
		LetterHeadSW
	
	Case "MakeLicenseFooters"
		MakeLicenseFooters
	
	
	
	Case "BidPresetList"
		BidPresetList
		
	Case "BidPresetCreate"
		BidPresetCreate
	
	Case "UnBidTo"
		UnBidTo				
	
	Case "AddBidToCust"
		AddBidToCust

	Case "ObtainBid"
		ObtainBid

	Case "Contract"
		Contract

	Case "UnContract"
		UnContract

Case Else 
		 oops 
				
End Select		






Sub UpdateText() '------------------------------------------------------------------------------------------------------

	Dim Text
	Dim Table
	Dim IDColumn
	Dim Column
	Dim RowID
	Dim XML
	Dim Ok
	Dim BoxID

	BoxID = CStr(Request.QueryString("BoxID"))
	Text = CStr(Request.QueryString("Text"))
	Table = CStr(Request.QueryString("Table"))
	IDColumn = CStr(Request.QueryString("IDColumn"))
	Column = CStr(Request.QueryString("Column"))
	RowID = CStr(Request.QueryString("RowID"))
	SysOK = CStr(Request.QueryString("SysOK"))
	
	'Text=EncodeChars(Text)
	''Text = Replace(Text, ",", "-COMMA-")
	''Text = Replace(Text, "'", " ")
	''Text = Replace(Text, "+", " ")
	'''Text = Replace(Text, "/", "-")
	'''Text = Replace(Text, chr(13), "--Return--")
	'''Text = Replace(Text, chr(10), "--Ret--")
		
	SQL = "UPDATE "&Table&" SET "&Column&" ='"&Text&"' WHERE "&IDColumn&" = "&RowID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	if Key = "" then Key ="0" end if 	
	XML = ("<root><SysID>--"&RowID&"</SysID><Ok>"&SysOK&"</Ok><BoxID>"&BoxID&"</BoxID></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)		
									  
	

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub UpdateSystemPrint '---------------------------------------------------------------------------------------------------------
	Dim SysID
	Dim PrintChecked

	SysID = CStr(Request.QueryString("SysID"))
	PrintChecked = CStr(Request.QueryString("PrintChecked"))
	
	SQL = "UPDATE Systems SET PrintChecked ='"&PrintChecked&"' WHERE SystemID = "&SysID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	XML = ("<root>Nothing</root>")
	response.ContentType = "text/xml"
	response.Write(XML)		
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~








Sub GetEmployeeList  () '--------------------------------------------------------------------------------------------------------

Dim XML
Dim ProjList
Dim dbconn
Dim ArrCount



ProjList = ""
ArrCount = 1
     
			SQL = "SELECT * FROM Employees"
			set rs=Server.CreateObject("ADODB.Recordset")
			set dbconn = server.createobject("adodb.connection")
			dbconn.open REDconnstring
			rs.Open SQL, dbconn
			
			Do While Not rs.EOF 
			
			    ProjList = ProjList+"<EmpID"&ArrCount&">"&rs("EmpID")&"</EmpID"&ArrCount&">"
				ProjList = ProjList+"<Fname"&ArrCount&">"&rs("Fname")&"</Fname"&ArrCount&">" 
				ProjList = ProjList+"<Lname"&ArrCount&">"&rs("Lname")&"</Lname"&ArrCount&">"
				
			ArrCount = ArrCount + 1	
			       
			rs.MoveNext 
			Loop
			
			
			
			set rs = nothing
			set dbconn=nothing


	

    XML = ("<root>"&ProjList&"<ArrCount>"&ArrCount&"</ArrCount></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)
			
			
			
			

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~













Sub GetTaskList  () '--------------------------------------------------------------------------------------------------------



Dim XML
Dim ProjList
Dim dbconn
Dim ArrCount


ProjList = ""
ArrCount = 1
     
			SQL = "SELECT * FROM Tasks"
			set rs=Server.CreateObject("ADODB.Recordset")
			set dbconn = server.createobject("adodb.connection")
			dbconn.open REDconnstring
			rs.Open SQL, dbconn
			
			Do While Not rs.EOF 
			
			    ProjList = ProjList+"<TaskID"&ArrCount&">"&rs("TaskID")&"</TaskID"&ArrCount&">"
				ProjList = ProjList+"<TaskName"&ArrCount&">"&rs("TaskName")&"</TaskName"&ArrCount&">" 
				
			ArrCount = ArrCount + 1	
			       
			rs.MoveNext 
			Loop
			
			
			
			set rs = nothing
			set dbconn=nothing


	

    XML = ("<root>"&ProjList&"<ArrCount>"&ArrCount&"</ArrCount></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)
			
			
			
			

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub GetBidTo  () '--------------------------------------------------------------------------------------------------------
	
	Dim XML
	Dim ProjList
	Dim BidCount
	
	ProjList = ""
	
	SQL = "SELECT * FROM BidTo WHERE ProjID="&CStr(Request.QueryString("ProjID"))
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	BidCount = 1
	Do While Not rs.EOF 
		
		ProjList = ProjList+"<CustID"&BidCount&">"&rs("CustID")&"</CustID"&BidCount&">"
		ProjList = ProjList+"<CustName"&BidCount&">"&rs("CustName")&"</CustName"&BidCount&">" 
		BidCount = BidCount + 1	
		
		rs.MoveNext 
	Loop
	
	set rs = nothing
	
	
	XML = ("<root>"&ProjList&"<BidCount>"&BidCount&"</BidCount></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub FindCust  () '--------------------------------------------------------------------------------------------------------

	Dim CustText
		
	Dim XML
	Dim CustList
	Dim BidToSearch
	Dim dbconn
	Dim Names
	
	Dim CustID
	Dim cName
	Dim Contact
	
	CustText = CStr(Request.QueryString("CustText"))
	
	CustList = ""
	
	
	SQL = "SELECT * FROM Customers WHERE Name LIKE '%"&CustText&"%' ORDER BY Name"
	set rs=Server.CreateObject("ADODB.Recordset")
	set dbconn = server.createobject("adodb.connection")
	dbconn.open REDconnstring
	rs.Open SQL, dbconn
	
	Dim cCount
	Do While Not rs.EOF
		cCount = cCount + 1 
		CustID = rs("CustID")
		cName = rs("Name")
		Contact = rs("Contact1")
		
		if isNull(Contact) or (Contact="") then Contact="Dear sir/madam"
		
		CustList=CustList&"&lt;a href=""javascript:Void(0);"" onclick=""Gebi('CustomerTxt').value='"&cName&"'; SearchCustID="&CustID&"; GetProjects();"" class=""CustListItems"" title="""&cName&""" &gt;"&cName&"&lt;/a&gt; &lt;br&gt;" 
		BidToSearch=BidToSearch&"&lt;a href=""javascript:Void(0);"" onclick=""HiddenCustName.value='"&cName&"'; AddBidToCust("&CustID&",'"&cName&"','"&Contact&"');"" class=""CustListItems""&gt; "&cName&"&lt;/a&gt; &lt;br&gt;" 
		NewProjCusts = NewProjCusts & "&lt;a href=""javascript:Void(0);"" onclick=""GrabNewProjCust('"&cName&"',"&CustID&");"" class=""CustListItems"" &gt;"&cName&"&lt;/a&gt; &lt;br&gt;" 
		rs.MoveNext 
	Loop
	
	if CustList = "" then CustList = "-No Data-"
	
	set rs = nothing
	set dbconn=nothing


	XML = ("<root><Customers>"&CustList&"</Customers><BidToSearch>"&BidToSearch&"</BidToSearch><NewProjCusts>"&NewProjCusts&"</NewProjCusts><Test>sam</Test></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~













Sub LoadAreaProj  () '--------------------------------------------------------------------------------------------------------


Dim XML
Dim XMLTags
Dim HTMLList : HTMLList = ""

Const LT = "&lt;"
Const GT = "&gt;"
Const DivL ="&lt;div " 
Const DivR ="&lt;/div&gt;" 
Const Brk ="&lt;br / &gt;"

Dim AreaID
Dim Area
Dim ProjName

Dim dbconn, dbconn2
Dim Names

Dim DivAttrib

AreaID = CStr(Request.QueryString("AreaID"))

if AreaID="--" then AreaID="NULL"
     
SQL = "SELECT * FROM Area WHERE AreaID = " & AreaID
set rs=Server.CreateObject("ADODB.Recordset")
set dbconn = server.createobject("adodb.connection")
dbconn.open REDconnstring
rs.Open SQL, dbconn
Area = rs("AreaDescription")
set rs = nothing
set dbconn = nothing
'Area = "Nevada - North"	


if Area="--" then Area="NULL" ELSE Area="'"&Area&"'"

SQL = "SELECT * from Projects WHERE Area = " & Area & " order by ProjName "
set rs  =Server.CreateObject("ADODB.Recordset")
set dbconn = server.createobject("adodb.connection")
dbconn.open REDconnstring
rs.Open SQL, dbconn
			

if rs.EOF then HTMLList = "No Projects in " & Area & "."

Do While Not rs.EOF 

	ProjName = rs("ProjName") 
	ProjID = rs("ProjID")
	
	if (isNull(Area)		) = true or Area =		"" then Area = "--"
	if (isNull(ProjName)) = true or ProjName ="" then ProjName = "--"

'	XMLTags=XMLTags&"<AreaID>"&AreaID&"</AreaID>"
	XMLTags=XMLTags&"<Area>"&Area&"</Area>"
	XMLTags = XMLTags & "<ProjName>" & ProjName & "</ProjName>"

	DivAttrib = "id="&ProjID&Q&" "'
	DivAttrib = DivAttrib&"title="""& ProjName &""" "
	DivAttrib = DivAttrib&"class=""ProjListItems"" "
	DivAttrib = DivAttrib&"onclick=""OpenProject("&ProjID&");"" "
	HTMLList=HTMLList&DivL&DivAttrib&GT &ProjName & DivR &Brk
	rs.MoveNext 
Loop

			

set rs = nothing
set dbconn = nothing

XML = ("<root><Test>XML Test ok</Test>"&XMLTags&"<HTMLList>--" & HTMLList & "</HTMLList></root>")
	
response.ContentType = "text/xml"
response.Write(XML)




End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~







Sub FindProj () '--------------------------------------------------------------------------------------------------------

Dim CustID
Dim Area
Dim XML
Dim List
Dim Active
Dim Obtained
Dim Finished
Dim Color
Dim RdColor
Dim GrColor
Dim BlColor

Dim DateFrom
Dim DateTo

CustID = Request.QueryString("CustID")
Area = CStr(Request.QueryString("Area"))
DateFrom = CStr(Request.QueryString("DateFrom"))
DateTo = CStr(Request.QueryString("DateTo"))
Obtained = Request.QueryString("Obtained")

Dim ShowObtained
If Obtained=1 Then ShowObtained="Obtained='True' AND" Else ShowObtained="" 

If DateTo="" or (IsNull(DateTo)) Then DateTo=Date 'If there isn't a DateTo, use Today.

If CustID<>0 or Area<>"All" or DateFrom <> "1/1/1900" or CDate(DateTo) < Date or Obtained=1 Then 'Don't Show anything unless the criteria is sufficiently refined.

	SQL = "SELECT * FROM Projects WHERE "&ShowObtained&" (DateEnt BETWEEN '"&DateFrom&"' AND '"&DateTo&"') "
	
	If CustID<>0 Or Area<>"All" Then SQL=SQL&"AND ("
		
		If CustID<>0 Then SQL=SQL&"CustomerID = "&CustID
		If CustID<>0 and Area<>"All" Then SQL=SQL&" AND "
		If Area<>"All" Then SQL=SQL&"Area = '"&Area&"'" 
		
	If CustID<>0 Or Area<>"All" Then SQL=SQL& ") "
	
	SQL=SQL&"ORDER BY ProjName "
	
	
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	Dim br: br="&lt;br/&gt;"
	Dim MaxResults: MaxResults=255
	Dim pID
	Dim pName
	Dim pCount : pCount=0
	List = ""
	
	Do Until rs.EOF 
		pCount=pCount+1
		Active = rs("Active")
		Obtained = rs("Obtained") 'variable reused
		if rs("JobCompleted") = 5 Then Finished="True" Else Finished="False"
		
		Color="#000"
		
		'if Active = True then BlColor = "8" 
		'if Active = False then BlColor = "0"			    
		'if Obtained = True then GrColor = "8" 
		'if Obtained = False then GrColor = "0"			    
		'RdColor="0"
		
		'Color ="#"&RdColor&GrColor&BlColor
		
		
		'if Obtained Then Color="#008"
		'if Active = Then Color="#080"
		'if Finished = Then Color="#C44"
				
		pID=rs("ProjID")
		pName=rs("ProjName")
		
		'List=List&"<div id=^Sys"&pID&"^ class=^CustListBox^>"
		'	List=List&"<a href=^javascript:Void();^ onclick=^OpenProject("&pID&");^ class=^ProjListItems^ style=^color:"&Color&";^ Title=^"&pName&"^>"&pName&"</a>"
		'List=List&"</div>"
		
		List=List&"<refine>0</refine>"
		List=List&"<Use2010Bidder"&pCount&">"&rs("Use2010Bidder")&"</Use2010Bidder"&pCount&">"
		List=List&"<ProjID"&pCount&">"&pID&"</ProjID"&pCount&">"
		List=List&"<ProjName"&pCount&">--"&pName&"</ProjName"&pCount&">"
		List=List&"<Active"&pCount&">"&Active&"</Active"&pCount&">"
		List=List&"<Obtained"&pCount&">"&Obtained&"</Obtained"&pCount&">"
		List=List&"<Finished"&pCount&">"&Finished&"</Finished"&pCount&">"
		
		If pCount > MaxResults Then
			pCount=pCount+1
			List=List&"<ProjID"&pCount&">0</ProjID"&pCount&">"
			List=List&"<ProjName"&pCount&">"&MaxResults&"+ Matches"&br&"Please refine your search.</ProjName"&pCount&">"
			List=List&"<Active"&pCount&">1</Active"&pCount&">"
			List=List&"<Obtained"&pCount&">1</Obtained"&pCount&">"
			List=List&"<Finished"&pCount&">1</Finished"&pCount&">"
			List=List&"<Projects></Projects><Name>NONE</Name><CustomerID>0</CustomerID>"
			Exit Do
		End If
		
		rs.MoveNext 
	Loop 

	set rs = nothing
	
	'Dim OldList
	'Do Until OldList=List
	'	OldList=List
	'	List=Replace(Replace(Replace(List,"^",""""),"<","&lt;"),">","&gt;")
	'Loop
	
	'if List = "" then
	'	List = "-No Data-"
	'end if
	
	If CustID=0 Then
		'XML="<Projects>"&List&"</Projects><Name>NONE</Name><CustomerID>"&CustID&"</CustomerID>"
		XML=List&"<Name>NONE</Name><CustomerID>"&CustID&"</CustomerID>"
	Else
		SQL2 = "SELECT * FROM Customers WHERE CustID = "&CustID
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
	
		'XML=XML&"<Projects>"&List&"</Projects>"
		XML=XML&List
		XML=XML&"<Name>"&rs2("Name")&"</Name>"
		XML=XML&"<CustomerID>"&CustID&"</CustomerID>"
			
		set rs2 = nothing
	End If
Else
	pCount=1
	XML=XML&"<refine>1</refine>"
	XML=XML&"<ProjID"&pCount&">0</ProjID"&pCount&">"
	XML=XML&"<ProjName"&pCount&">Please refine your search by Area,&lt;br/&gt;Date, Obtained, and/or Customer</ProjName"&pCount&">"
	XML=XML&"<Active"&pCount&">1</Active"&pCount&">"
	XML=XML&"<Obtained"&pCount&">1</Obtained"&pCount&">"
	XML=XML&"<Finished"&pCount&">1</Finished"&pCount&">"
	XML=XML&"<Projects></Projects><Name>NONE</Name><CustomerID>0</CustomerID>"
End If

response.ContentType = "text/xml"
response.Write("<root><ProjCount>0"&pCount&"</ProjCount>"&XML&"<Sub>FindProj</Sub><SQL>"&SQL&"</SQL></root>")

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~











Sub OpenProject  () '----------Gets the list of Systems-------------------------------------------------------

	Dim ProjID
	Dim XML
	Dim Sys
	Dim XMLMain
	Dim IDarray
	Dim sDate
	
	ProjID = CStr(Request.QueryString("ProjID"))
	sDate = Now()
	
	
	Dim CheckedDB
	Dim Checked
	
	XMLMain = ""
	
	
	SQL3 = "SELECT * FROM Projects WHERE ProjID = "&ProjID
	set rs3=Server.CreateObject("ADODB.Recordset")
	rs3.Open SQL3, REDconnstring
	
	dim ProjAddress
	ProjAddress = rs3("ProjAddress")
	if IsNull(ProjAddress) then ProjAddress = "0"
	if ProjAddress = "" then ProjAddress = "0"
	
	dim ProjCity
	ProjCity = rs3("ProjCity")
	if IsNull(ProjCity) then ProjCity = "0"
	if ProjCity = "" then ProjCity = "0"
	
	dim ProjState
	ProjState = rs3("ProjState")
	if IsNull(ProjState) then ProjState = "0"
	if ProjState = "" then ProjState = "0"
	
	dim ProjZip
	ProjZip = rs3("ProjZip")
	if IsNull(ProjZip) then ProjZip = "0"
	if ProjZip = "" then ProjZip = "0"
	
	dim DateEnt
	DateEnt = rs3("DateEnt")
	if IsNull(DateEnt) then DateEnt = "0"
	if DateEnt = "" then DateEnt = "0"
	
	dim Area
	Area = rs3("Area")
	if IsNull(Area) then Area = "0"
	if Area = "" then Area = "0"
	
	dim Franchise
	Franchise = rs3("Franchise")
	if IsNull(Franchise) then Franchise = "0"
	if Franchise = "" then Franchise = "0"
	
	dim SubOf
	SubOf = rs3("SubOf")
	if IsNull(SubOf) then SubOf = "0"
	if SubOf = "" then SubOf = "0"
	
	dim OwnName
	OwnName = rs3("OwnName")
	if IsNull(OwnName) then OwnName = "0"
	if OwnName = "" then OwnName = "0"
	
	dim OwnContact
	OwnContact = rs3("OwnContact")
	if IsNull(OwnContact) then OwnContact = "0"
	if OwnContact = "" then OwnContact = "0"
	
	dim OwnPhone1
	OwnPhone1 = rs3("OwnPhone1")
	if IsNull(OwnPhone1) then OwnPhone1 = "0"
	if OwnPhone1 = "" then OwnPhone1 = "0"
	
	dim OwnFax
	OwnFax = rs3("OwnFax")
	if IsNull(OwnFax) then OwnFax = "0"
	if OwnFax = "" then OwnFax = "0"
	
	dim OwnEmail
	OwnEmail = rs3("OwnEmail")
	if IsNull(OwnEmail) then OwnEmail = "0"
	if OwnEmail = "" then OwnEmail = "0"
	
	'dim SqFoot
	'SqFoot = rs3("SqFoot")
	'if IsNull(SqFoot) then SqFoot = "0"
	'if SqFoot = "" then SqFoot = "0"
	
	dim Floors
	Floors = rs3("Floors")
	if IsNull(Floors) then Floors = "0"
	if Floors = "" then Floors = "0"
	
	dim Rooms
	Rooms = rs3("Rooms")
	if IsNull(Rooms) then Rooms = "0"
	if Rooms = "" then Rooms = "0"
	
	dim ADArooms
	ADArooms = rs3("ADArooms")
	if IsNull(ADArooms) then ADArooms = "0"
	if ADArooms = "" then ADArooms = "0"
	
	dim CeilingHeight
	CeilingHeight = rs3("CeilingHeight")
	if IsNull(CeilingHeight) then CeilingHeight = "0"
	if CeilingHeight = "" then CeilingHeight = "0"
	
	dim ConstrType
	ConstrType = rs3("ConstrType")
	if IsNull(ConstrType) then ConstrType = "0"
	if ConstrType = "" then ConstrType = "0"
	
	dim OccRating
	OccRating = rs3("OccRating")
	if IsNull(OccRating) then OccRating = "0"
	if OccRating = "" then OccRating = "0"
	
	dim OccLoad
	OccLoad = rs3("OccLoad")
	if IsNull(OccLoad) then OccLoad = "0"
	if OccLoad = "" then OccLoad = "0"
	
	dim Wiring
	Wiring = rs3("Wiring")
	if IsNull(Wiring) then Wiring = "0"
	if Wiring = "" then Wiring = "0"
	
	dim Codes
	Codes = rs3("Codes")
	if IsNull(Codes) then Codes = "0"
	if Codes = "" then Codes = "0"
	
	Dim RCSNotes
	RCSNotes = rs3("RCSNotes")
	
	Dim Contract
	Contract = rs3("Contract")
	If Contract <> "True" then
		Contract=0
	Else
		Contract=1
	End If
	
	
	XMLMain = XMLMain + "<ProjID>"&ProjID&"</ProjID>"	
	XMLMain = XMLMain + "<Name>-NotNull-"&rs3("ProjName")&"</Name>"
	XMLMain = XMLMain + "<CustID>-NotNull-"&rs3("CustomerID")&"</CustID>"
	XMLMain = XMLMain + "<ProjAddress>"&ProjAddress&"</ProjAddress>"
	XMLMain = XMLMain + "<ProjCity>"&ProjCity&"</ProjCity>"
	XMLMain = XMLMain + "<ProjState>"&ProjState&"</ProjState>"
	XMLMain = XMLMain + "<ProjZip>"&ProjZip&"</ProjZip>"
	XMLMain = XMLMain + "<DateEnt>"&DateEnt&"</DateEnt>"
	XMLMain = XMLMain + "<Area>"&Area&"</Area>"
	XMLMain = XMLMain + "<Franchise>"&Franchise&"</Franchise>"
	XMLMain = XMLMain + "<SubOf>"&SubOf&"</SubOf>"
	XMLMain = XMLMain + "<OwnName>"&OwnName&"</OwnName>"
	XMLMain = XMLMain + "<OwnContact>"&OwnContact&"</OwnContact>"
	XMLMain = XMLMain + "<OwnPhone1>"&OwnPhone1&"</OwnPhone1>"
	XMLMain = XMLMain + "<OwnFax>"&OwnFax&"</OwnFax>"
	XMLMain = XMLMain + "<OwnEmail>"&OwnEmail&"</OwnEmail>"
	XMLMain = XMLMain + "<Floors>"&Floors&"</Floors>"
	XMLMain = XMLMain + "<Rooms>"&Rooms&"</Rooms>"
	XMLMain = XMLMain + "<ADArooms>"&ADArooms&"</ADArooms>"
	XMLMain = XMLMain + "<CeilingHeight>"&CeilingHeight&"</CeilingHeight>"
	XMLMain = XMLMain + "<ConstrType>"&ConstrType&"</ConstrType>"
	XMLMain = XMLMain + "<OccRating>"&OccRating&"</OccRating>"
	XMLMain = XMLMain + "<OccLoad>"&OccLoad&"</OccLoad>"
	XMLMain = XMLMain + "<Wiring>"&Wiring&"</Wiring>"
	XMLMain = XMLMain + "<Codes>--"&Codes&"</Codes>"
	XMLMain = XMLMain + "<RCSNotes>--"&RCSNotes&"</RCSNotes>"
	
	
	
	
	set rs3 = nothing	
	
	
	
	
	
	
	
	
	
	
	SQL1 = "SELECT * FROM ProjectPrint WHERE ProjectID = "&ProjID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	if rs1.EOF Then
	
	SQL2 ="Insert into ProjectPrint (ProjectID,PrintDate,Notes) VALUES ("&ProjID&",'"&sDate&"', 'True')"
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring
	
	end if
	
	set rs1 = nothing
	
	
	
	SQL1 = "SELECT * FROM ProjectPrint WHERE ProjectID = "&ProjID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	dim LetterTitle
	LetterTitle = rs1("LetterTitle")
	if IsNull(LetterTitle) then LetterTitle = "0"
	if LetterTitle = "" then LetterTitle = "0"
	
	dim ScopeTitle
	ScopeTitle = rs1("ScopeTitle")
	if IsNull(ScopeTitle) then ScopeTitle = "0"
	if ScopeTitle = "" then ScopeTitle = "0"
	
	dim PartsTitle
	PartsTitle = rs1("PartsTitle")
	if IsNull(PartsTitle) then PartsTitle = "0"
	if PartsTitle = "" then PartsTitle = "0"
	
	dim LaborTitle
	LaborTitle = rs1("LaborTitle")
	if IsNull(LaborTitle) then LaborTitle = "0"
	if LaborTitle = "" then LaborTitle = "0"
	
	dim SignedTCS
	SignedTCS = rs1("SignedTCS")
	if IsNull(SignedTCS) then SignedTCS = "0"
	if SignedTCS = "" then SignedTCS = "0"
	
	dim SignedCust
	SignedCust = rs1("SignedCust")
	if IsNull(SignedCust) then SignedCust = "0"
	if SignedCust = "" then SignedCust = "0"
	
	dim PrintDate
	PrintDate = rs1("PrintDate")
	if IsNull(PrintDate) then PrintDate = "0"
	if PrintDate = "" then PrintDate = "0"
	
	dim Addressing
	Addressing = rs1("Addressing")
	if IsNull(Addressing) then Addressing = "0"
	if Addressing = "" then Addressing = "0"
	
	dim Body
	Body = rs1("Body")
	if IsNull(Body) then Body = "0"
	if Body = "" then Body = "0"
	
	dim LegalNotes
	LegalNotes = rs1("LegalNotes")
	if IsNull(LegalNotes) then LegalNotes = "0"
	if LegalNotes = "" then LegalNotes = "0"
	
	dim PartsNotes
	PartsNotes = rs1("PartsNotes")
	if IsNull(PartsNotes) then PartsNotes = "0"
	if PartsNotes = "" then PartsNotes = "0"
	
	dim LaborNotes
	LaborNotes = rs1("LaborNotes")
	if IsNull(LaborNotes) then LaborNotes = "0"
	if LaborNotes = "" then LaborNotes = "0"
	
	XMLMain = XMLMain + "<LetterTitle>"&LetterTitle&"</LetterTitle>"
	XMLMain = XMLMain + "<ScopeTitle>"&ScopeTitle&"</ScopeTitle>"
	XMLMain = XMLMain + "<PartsTitle>"&PartsTitle&"</PartsTitle>"
	XMLMain = XMLMain + "<LaborTitle>"&LaborTitle&"</LaborTitle>"
	XMLMain = XMLMain + "<SignedTCS>"&SignedTCS&"</SignedTCS>"
	XMLMain = XMLMain + "<SignedCust>"&SignedCust&"</SignedCust>"
	XMLMain = XMLMain + "<PrintDate>"&PrintDate&"</PrintDate>"
	XMLMain = XMLMain + "<Addressing>"&Addressing&"</Addressing>"
	XMLMain = XMLMain + "<Body>"&Body&"</Body>"
	XMLMain = XMLMain + "<LegalNotes>"&LegalNotes&"</LegalNotes>"
	XMLMain = XMLMain + "<PartsNotes>"&PartsNotes&"</PartsNotes>"
	XMLMain = XMLMain + "<LaborNotes>"&LaborNotes&"</LaborNotes>"
	XMLMain = XMLMain + "<TFP_TCS>"&rs1("TFP_TCS")&"</TFP_TCS>"
	XMLMain = XMLMain + "<TFP>"&rs1("TFP")&"</TFP>"
	XMLMain = XMLMain + "<TCS>"&rs1("TCS")&"</TCS>"
	XMLMain = XMLMain + "<SystemTotals>"&rs1("SystemTotals")&"</SystemTotals>"
	XMLMain = XMLMain + "<LetterBody>"&rs1("LetterBody")&"</LetterBody>"
	XMLMain = XMLMain + "<Includes>"&rs1("Includes")&"</Includes>"
	XMLMain = XMLMain + "<Excludes>"&rs1("Excludes")&"</Excludes>"
	XMLMain = XMLMain + "<Notes>"&rs1("Notes")&"</Notes>"
	XMLMain = XMLMain + "<Subtotal>"&rs1("Subtotal")&"</Subtotal>"
	XMLMain = XMLMain + "<Tax>"&rs1("Tax")&"</Tax>"
	XMLMain = XMLMain + "<Total>"&rs1("Total")&"</Total>"
	XMLMain = XMLMain + "<PartsDesc>"&rs1("PartsDesc")&"</PartsDesc>"
	XMLMain = XMLMain + "<PartsQty>"&rs1("PartsQty")&"</PartsQty>"
	XMLMain = XMLMain + "<PartsPricing>"&rs1("PartsPricing")&"</PartsPricing>"
	XMLMain = XMLMain + "<PartsTotal>"&rs1("PartsTotal")&"</PartsTotal>"
	XMLMain = XMLMain + "<LaborDesc>"&rs1("LaborDesc")&"</LaborDesc>"
	XMLMain = XMLMain + "<LaborQty>"&rs1("LaborQty")&"</LaborQty>"
	XMLMain = XMLMain + "<LaborPricing>"&rs1("LaborPricing")&"</LaborPricing>"
	XMLMain = XMLMain + "<LaborTotal>"&rs1("LaborTotal")&"</LaborTotal>"
	
	
	
	
	
	
	set rs1 = nothing
	
	
	
	
	
	
	
	
	
	
	Sys = "<div>" 
	IDarray = "ProjMainTab,ProjPrintTab," 
	dim NiftyIDarray : NiftyIDarray = ""'div#ProjMainTab,div#ProjPrintTab"
	
	SQL = "SELECT * FROM Systems WHERE ProjectID = "&ProjID&" order by System "
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	Dim IncludedSystemCount: IncludedSystemCount=0
	
	Dim SysID
	Dim SqFoot, SysSqFoot
	SqFoot=0
	
	
	Do While Not rs.EOF 
		SysID=rs("SystemID")
		CSysID=rs("CopiedSysID")
		Sys=Sys&"<div id='Tab"&SysID&"' onMouseUp='ProjTabs(^ProjSysBox^,^Tab"&SysID&"^)' class='ProjTab3' style='width:auto;' onclick='GetSystemEdit("&SysID&");'"
		Sys=Sys&"onmouseover='MouseOverTab(^Tab"&SysID&"^)' onmouseout='MouseOutTab(^Tab"&SysID&"^)' value='"&CLng("0"&CSysID)&"'>"&EncodeChars(rs("System"))&"</div> "
		
		IDarray=IDarray&"Tab"&SysID&","
		
		'If NiftyIDarray <> "" then NiftyIDarray = NiftyIDarray &","
		If IDs <> "" then IDs = IDs &","
		'NiftyIDarray = NiftyIDarray &"div#Tab"&SysID
		
		If rs("SqFootAdd")="True" Then
			SysSqFoot=rs("SqFoot")
			If (IsNull(SysSqFoot)) Or SysSqFoot="" Then SysSqFoot=0
			SqFoot=SqFoot+SysSqFoot
		End If
		
		If rs("CopiedSysID")<>"" Then
		
			SQL4="SELECT * FROM BidItems WHERE SysID="&rs("CopiedSysID")
			Set rs4=Server.CreateObject("ADODB.RecordSet")
			rs4.Open SQL4, REDconnstring
			
			Do Until rs4.EOF
				Columns="Selected,SysID, PartID, Manufacturer, ItemName, ItemDescription, LaborValue, Qty, Type, Cost, GeneratedLabor, Category"
				Values=""
				Values=Values&"'"&rs4("Selected")&"',"
				Values=Values&"'"&SysID&"',"
				Values=Values&"'"&rs4("PartID")&"',"
				Values=Values&"'"&rs4("Manufacturer")&"',"
				Values=Values&"'"&rs4("ItemName")&"',"
				Values=Values&"'"&rs4("ItemDescription")&"',"
				Values=Values&"'"&rs4("LaborValue")&"',"
				Values=Values&"'"&rs4("Qty")&"',"
				Values=Values&"'"&rs4("Type")&"',"
				Values=Values&"'"&rs4("Cost")&"',"
				Values=Values&"'"&rs4("GeneratedLabor")&"',"
				Values=Values&"'"&rs4("Category")&"'"
				
				SQL5="INSERT INTO BidItems ("&Columns&") VALUES ("&Values&")"
				Set rs5=Server.CreateObject("ADODB.RecordSet")
				rs5.Open SQL5, REDconnstring
				Set rs5= Nothing
				
				rs4.MoveNext
				
			Loop
			Set rs4=Nothing
			
			SQL6="SELECT * FROM Expenses WHERE SysID="&rs("CopiedSysID")
			Set rs6=Server.CreateObject("ADODB.RecordSet")
			rs6.Open SQL6, REDconnstring
			
			Do Until rs6.EOF
				Columns="SysID,Type,SubType,Origin,Destination,Units,UnitCost"
				Values=""
				Values=Values&"'"&SysID&"','"&rs6("Type")&"','"&rs6("SubType")&"','"&rs6("Origin")&"','"&rs6("Destination")&"','"&rs6("Units")&"','"&rs6("UnitCost")&"'"
				
				SQL7="INSERT INTO Expenses ("&Columns&") VALUES ("&Values&")"
				Set rs7=Server.CreateObject("ADODB.RecordSet")
				rs7.Open SQL7, REDconnstring
				Set rs7= Nothing
				
				rs6.MoveNext
			Loop
			
			Set rs6=Nothing
			
			SQL8="UPDATE Systems SET CopiedSysID='' WHERE SystemID="&SysID
			Set rs8=Server.CreateObject("AdoDB.RecordSet")
			rs8.Open SQL8, REDConnstring
			Set rs8=Nothing
		End If
		
		rs.MoveNext 
	Loop
	
	
	if Sys = "" Then 
		Sys = "<small>Click 'New system' below to add a system bid.</small>"
	else
		Sys = Sys & "</div>"
	end if
	
	Do While instr(Sys,"<") or instr(Sys,">") or instr(Sys,"^")
		Sys= Replace(Replace(Replace(Sys,"<","&lt;"),">","&gt;"),"^","""")
	Loop
	
	'PartsList("&rs("SystemID")&");
	
	
	set rs = nothing
	
	
	
	
	
	SQL = "SELECT * FROM BidTo WHERE ProjID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	Dim HasTheJob
	Dim HTJ
	Dim BidToList
	Dim ObWith
	
	
	Do While Not rs.EOF 
		
		If IsNull(rs("HasTheJob")) then
			HasTheJob = "False"
		else
			HasTheJob = CStr(rs("HasTheJob")) 
		end if
		
		If HasTheJob = "True" then
			HTJ = 1 
			ObWith = rs("CustName")
		Else
			HTJ = 0	
		End If
		
		'if HTJ = 1 then
		'	BidToList = "Bid obtained with " & ObWith '& "&lt;big&gt;&lt;br /&gt;&lt;/big&gt; &lt;div style=""color:#7F7F7F;""&gt;"&BidToList&"&lt;/div&gt;"
		'else
		'end if
		BidToList =BidToList & "&lt;div  style="" float:left; clear:right; padding-top:2px;"" &gt;"
		BidToList =BidToList & "&lt;a href=""javascript:Void(0)"" onclick=""UnBidTo('" & rs("CustName") & "', "&ProjID&");"" &gt;"
		BidToList =BidToList & "&lt;img src=""Images/closeSmall.gif"" alt=""Remove"" border=""0"" /&gt; &lt;/a&gt;&lt;/div&gt;"
		BidToList =BidToList & "&lt;a href=""javascript:Void(0);""  onclick=""javascript:Void(0);""  class=""CustListItems""&gt; "&rs("CustName")&"&lt;/a&gt;"
		BidToList =BidToList & "&lt;big&gt;&lt;br /&gt;&lt;/big&gt;"

		rs.MoveNext 
	Loop
	
		
	if BidToList = "" then BidToList = "-No Data-"
	if HasTheJob = "" then HasTheJob = "False"
	
	
	set rs = nothing
	
	
	XML = "<root>"&XMLMain&"<Systems>"&Sys&"</Systems><IDarray>-NotNull-"&IDarray&"</IDarray><NiftyIDarray>-NotNull-"&NiftyIDarray&"</NiftyIDarray><BidToList>"&BidToList&"</BidToList><Contract>HasTheJob"&Contract&"</Contract><Obtained>HasTheJob"&HTJ&"</Obtained><ObtainWith>-NotNull-"&ObWith&"</ObtainWith></root>"
	
	response.ContentType = "text/xml"
	response.Write(XML)
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~













Sub OpenSystem () '--------------------------------------------------------------------------------------------------------



Dim EstID
Dim XML
Dim System
Dim DateEntered
Dim EnteredBy
Dim TaxRate
Dim MU
Dim XMLMain


SysID = CStr(Request.QueryString("SysID"))


XMLMain = ""
XMLparts = ""
XMLlabor = ""

    SQL = "SELECT * FROM Systems WHERE SystemID = "&SysID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	dim SysName
	dim note
	dim DateBid
	dim DateWon
	
	SysName = (rs.Fields("System").value)
	note = (rs.Fields("Notes").value)
	DateBid = (rs.Fields("DateBid").value)
	DateWon = (rs.Fields("DateWon").value)
	Includes = (rs.Fields("Includes").value)
	Excludes = (rs.Fields("Excludes").value)
	EnteredBy = (rs.Fields("EnteredBy").value)
	DateEntered = (rs.Fields("DateEntered").value)
		
	if (IsNull(SysName) or (SysName = "")) then SysName = "--"
	if note = "" then note = "--" end if
	if (IsNull(DateBid) or (DateBid = "")) then DateBid = "--"
	if (IsNull(DateWon) or (DateWon = "")) then DateWon = "--"
	if (IsNull(Includes) or (Includes = "")) then Includes = "--"
	if (IsNull(Excludes) or (Excludes = "")) then Excludes = "--"
	if (IsNull(EnteredBy) or (EnteredBy = "")) then EnteredBy = "--"
	if (IsNull(DateEntered) or (DateEntered = "")) then DateEntered = "--Null--"
		    
	XMLMain = XMLMain & "<System>" & EncodeChars(SysName) & "</System>"
	XMLMain = XMLMain & "<DateEntered>" & DateEntered & "</DateEntered>"
	XMLMain = XMLMain & "<EnteredBy>--EntBy--" & EnteredBy & "</EnteredBy>"
	XMLMain = XMLMain & "<EnteredByID>" & rs.Fields("EnteredByID").value & "</EnteredByID>"
	XMLMain = XMLMain & "<Notes>" &note& "</Notes>"
	XMLMain = XMLMain & "<RCSNotes>" & rs.Fields("RCSNotes").value & "</RCSNotes>"
	XMLMain = XMLMain & "<Includes>" &Includes&"</Includes>"
	XMLMain = XMLMain & "<Excludes>" &Excludes&"</Excludes>"
	XMLMain = XMLMain & "<DateBid>" &DateBid& "</DateBid>"
	XMLMain = XMLMain & "<DateWon>" &DateWon& "</DateWon>"
	XMLMain = XMLMain & "<TaxRate>0" & rs("TaxRate") & "</TaxRate>"
	XMLMain = XMLMain & "<MU>0" & rs("MU") & "</MU>"
	XMLMain = XMLMain & "<Obtained>0" & rs("Obtained") & "</Obtained>"
	XMLMain = XMLMain & "<SysID>" & SysID & "</SysID>"
	'XMLMain = XMLMain & "<SysID>" & SysID & "</SysID>"
	'XMLMain = XMLMain & "<SysID>" & PartsMU & "</SysID>"
	'XMLMain = XMLMain & "<SysID>" & LaborMU & "</SysID>"
	'XMLMain = XMLMain & "<SysID>" & ROI & "</SysID>"
	'XMLMain = XMLMain & "<SysID>" & OH & "</SysID>"
	'XMLMain = XMLMain & "<SysID>" & Travel & "</SysID>"
	'XMLMain = XMLMain & "<SysID>" & Profit & "</SysID>"
	  
	set rs = nothing
	
	
	
	
	
	 
	 
	XML = "<root>"&XMLMain&"</root>" 
	response.ContentType = "text/xml"
	response.Write(XML)





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





















Sub PartsList  () '--------------------------------------------------------------------------------------------------------

Dim SysID1
Dim XML1
Dim PL

Dim Cost
Dim Qty


SysID1 = CStr(Request.QueryString("SysID"))

PL = ""

SQL="SELECT * FROM Systems WHERE SystemID="&SysID1
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring

MU = rs("MU")
	
SQL1 = "SELECT * FROM BidItems WHERE Type = 'Part' and SysID = "&SysID1
set rs1=Server.CreateObject("ADODB.Recordset")
rs1.Open SQL1, REDconnstring	
	
Do While Not rs1.EOF
	
	Cost=rs1("Cost")
	Qty=rs1("Qty")
	CostSub=Cost*Qty
	Sell=Cost+(Cost*(MU/100))
	SellSub=Sell*Qty
			 
	PL= PL&"&lt;div class='PartsItemRow'&gt;"
	PL= PL&"&lt;div class='PartsItemTxtBox' style='width:3%; border-left:0px; '&gt;"
	PL= PL&"&lt;input class='PartsItemText' style='border:#DDD;' id='CBselect"&rs1("BidItemsID")&"' name='CBselect"&rs1("BidItemsID")&"' type='checkbox' value=''"
	PL= PL&"onClick='ItemSelected("&rs1("BidItemsID")&",""CBselect"&rs1("BidItemsID")&""");' /&gt;"
	PL= PL&"&lt;/div&gt; "
	PL= PL&"&lt;div class='PartsItemTxtBox' style='width:3%;'&gt;"
	PL= PL&"&lt;input class='PartsItemText' style=' border-left:0px; ' id='CB2' type='checkbox' value='' checked/&gt;"
	PL= PL&"&lt;/div &gt;"
	
	PL= PL&"&lt;div class='PartsItemTxtBox' style='width:5%;' &gt;"
	PL= PL&"&lt;input class='PartsItemText' style='width:90%;' type='text' id='Qty"&rs1("BidItemsID")&"'  maxlength='10'"
	PL= PL&"onkeypress='//return alpha(event,numbers1+decimal,this)' value='"&rs1("Qty")&"'"
	PL= PL&"onKeyUp='ListEntryUpdate("&rs1("BidItemsID")&",""Qty"",""Qty"&rs1("BidItemsID")&""");'/&gt;"
	PL= PL&"&lt;/div&gt;"
	
	PL= PL&"&lt;div class='PartsItemTxtBox' style='width:10%;'&gt;"
	PL= PL&"&lt;input class='PartsItemText' style='width:95%;' type='text' id='Manuf"&rs1("BidItemsID")&"' maxlength='20' value='"&rs1("Manufacturer")&"'"
	PL= PL&"onKeyUp='ListEntryUpdate("&rs1("BidItemsID")&",""Manufacturer"",""Manuf"&rs1("BidItemsID")&""");'/&gt;"
	PL= PL&"&lt;/div&gt;"
	
	PL= PL&"&lt;div class='PartsItemTxtBox' style='width:10%;'&gt;"
	PL= PL&"&lt;input class='PartsItemText' style='width:95%;' type='text' id='Name"&rs1("BidItemsID")&"' maxlength='25' value='"&rs1("ItemName")&"'"
	PL= PL&"onKeyUp='ListEntryUpdate("&rs1("BidItemsID")&",""ItemName"",""Name"&rs1("BidItemsID")&""");'/&gt;"
	PL= PL&"&lt;/div &gt;"
	
	PL= PL&"&lt;div class='PartsItemTxtBox' style='width:37%;'&gt;"
	PL= PL&"&lt;input class='PartsItemText' style='width:96%;' type='text' id='Desc"&rs1("BidItemsID")&"'  maxlength='75'  value='"&rs1("ItemDescription")&"'"
	PL= PL&"onKeyUp='ListEntryUpdate("&rs1("BidItemsID")&",""ItemDescription"",""Desc"&rs1("BidItemsID")&""");'/&gt;"
	PL= PL&"&lt;/div&gt;"
	
	PL= PL&"&lt;div class='PartsItemTxtBox' style='width:7%;'&gt;"
	PL= PL&"&lt;input class='PartsItemText' style='width:85%;' type='text' id='CostEa"&rs1("BidItemsID")&"'"
	PL= PL&"onkeypress='//return alpha(event,numbers1+decimal,this)' maxlength='25' value='"&rs1("Cost")&"'"
	PL= PL&"onKeyUp='ListEntryUpdate("&rs1("BidItemsID")&",""Cost"",""CostEa"&rs1("BidItemsID")&""");  CalculateItemRow("&rs1("BidItemsID")&");'/&gt;"
	PL= PL&"&lt;/div &gt;"
	
	PL= PL&"&lt;div class='PartsItemTxtBox' style='width:7%;' &gt;"
	PL= PL&"&lt;input class='PartsItemText' style='width:85%; color:#114; cursor:default;' type='text' id='CostSub"&rs1("BidItemsID")&"' readonly maxlength='25' value='"&CostSub&"' onFocus=""Gebi('PartsTab').focus();"" /&gt;"
	PL= PL&"&lt;/div&gt;"
	PL= PL&"&lt;div class='PartsItemTxtBox' style='width:7%;'&gt;"
	PL= PL&"&lt;input class='PartsItemText' style='width:85%; color:#114; cursor:default;' type='text' id='SellEa"&rs1("BidItemsID")&"' readonly maxlength='25' value='"&Sell&"' onFocus=""Gebi('PartsTab').focus();"" /&gt;"
	PL= PL&"&lt;/div&gt;"
	PL= PL&"&lt;div class='PartsItemTxtBox' style='width:9%;'&gt;"
	PL= PL&"&lt;input class='PartsItemText' style='width:85%; color:#114; cursor:default;' type='text' id='SellSub"&rs1("BidItemsID")&"' readonly maxlength='25'  value='"&SellSub&"' onFocus=""Gebi('PartsTab').focus();"" /&gt;"
	PL= PL&"&lt;/div&gt;"
	PL= PL&"&lt;/div&gt;"
	
	rs1.MoveNext 
Loop

set rs1 = nothing	
set rs = nothing	

if PL = "" then
	PL = "No Parts"
end if

XML1 = "<root><Parts>--"&PL&"</Parts></root>" 
response.ContentType = "text/xml"
response.Write(XML1)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

















Sub LaborList  () '--------------------------------------------------------------------------------------------------------



Dim SysID2
Dim XML2
Dim XMLlabor



SysID2 = CStr(Request.QueryString("SysID"))

XMLlabor = ""


	SQL="SELECT * FROM Systems WHERE SystemID="&SysID2
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	MU = rs("MU")

	SQL2 = "SELECT * FROM BidItems WHERE Type = 'Labor' and SysID = "&SysID2
	set rs2=Server.CreateObject("ADODB.Recordset")
	
	rs2.Open SQL2, REDconnstring	
	
	Do While Not rs2.EOF
	 
		Cost=rs2("Cost")
		Qty=rs2("Qty")
		CostSub=Cost*Qty
		Sell=Cost+(Cost*(MU/100))
		SellSub=Sell*Qty

		XMLlabor = XMLlabor+("&lt;div class='PartsItemRow'&gt;")
		XMLlabor = XMLlabor+("&lt;div class='PartsItemTxtBox' style='width:3%; border-left:0px; background:#FFFFB7;'&gt;")
		XMLlabor = XMLlabor+("&lt;input class='PartsItemText' style='border:#DDD;' id='CB"&rs2("BidItemsID")&"' type='checkbox' value='' ")
		XMLlabor = XMLlabor+("onClick='ItemSelected("&rs2("BidItemsID")&",""CB"&rs2("BidItemsID")&""");' /&gt;") 
		XMLlabor = XMLlabor+("&lt;/div&gt; ")
		
		
		XMLlabor = XMLlabor+("&lt;div class='PartsItemTxtBox' style='width:5%;' &gt;")
		XMLlabor = XMLlabor+("&lt;input class='PartsItemText' style='width:90%;' type='text' id='Qty"&rs2("BidItemsID")&"'  maxlength='10'")
		XMLlabor = XMLlabor+("onkeypress='return alpha(event,numbers+decimal,this)'  value='"&rs2("Qty")&"' ")
		XMLlabor = XMLlabor+("onKeyUp='ListEntryUpdate("&rs2("BidItemsID")&",""Qty"",""Qty"&rs2("BidItemsID")&""");  CalculateItemRow("&rs2("BidItemsID")&");' /&gt;")
		XMLlabor = XMLlabor+("&lt;/div&gt;")
		
		
		XMLlabor = XMLlabor+("&lt;div class='PartsItemTxtBox' style='width:15%;'&gt;")
		XMLlabor = XMLlabor+("&lt;input class='PartsItemText' style='width:95%;' type='text' id='Name"&rs2("BidItemsID")&"' maxlength='25' value='"&rs2("ItemName")&"'")
		XMLlabor = XMLlabor+("onKeyUp='ListEntryUpdate("&rs2("BidItemsID")&",""ItemName"",""Name"&rs2("BidItemsID")&""");  CalculateItemRow("&rs2("BidItemsID")&");' /&gt;")
		XMLlabor = XMLlabor+("&lt;/div &gt;")
		
		
		
		XMLlabor = XMLlabor+("&lt;div class='PartsItemTxtBox' style='width:45%;'&gt;")
		XMLlabor = XMLlabor+("&lt;input class='PartsItemText' style='width:96%;' type='text' id='Desc"&rs2("BidItemsID")&"' maxlength='75' value='"&rs2("ItemDescription")&"'")
		XMLlabor = XMLlabor+("onKeyUp='ListEntryUpdate("&rs2("BidItemsID")&",""ItemDescription"",""Desc"&rs2("BidItemsID")&""");' /&gt;")
		XMLlabor = XMLlabor+("&lt;/div&gt;")
		
		
		XMLlabor = XMLlabor+("&lt;div class='PartsItemTxtBox' style='width:7%;'&gt;")
		XMLlabor = XMLlabor+("&lt;input class='PartsItemText' style='width:85%;' type='text' id='CostEa"&rs2("BidItemsID")&"'  maxlength='25'")
		XMLlabor = XMLlabor+("onkeypress='return alpha(event,numbers2+decimal,this)' value='"&rs2("Cost")&"'")
		XMLlabor = XMLlabor+("onKeyUp='ListEntryUpdate("&rs2("BidItemsID")&",""Cost"",""CostEa"&rs2("BidItemsID")&""");  CalculateItemRow("&rs2("BidItemsID")&");' /&gt;")
		XMLlabor = XMLlabor+("&lt;/div &gt;")
		
		
		XMLlabor = XMLlabor+("&lt;div class='PartsItemTxtBox' style='width:7%;' &gt;")
		XMLlabor = XMLlabor+("&lt;input class='PartsItemText' style='width:85%; color:#114; cursor:default;' type='text' readonly id='CostSub"&rs2("BidItemsID")&"'  maxlength='25' value='"&CostSub&"' onFocus=""Gebi('PartsTab').focus();"" /&gt;")
		XMLlabor = XMLlabor+("&lt;/div&gt;")
		XMLlabor = XMLlabor+("&lt;div class='PartsItemTxtBox' style='width:7%;'&gt;")
		XMLlabor = XMLlabor+("&lt;input class='PartsItemText' style='width:85%; color:#114; cursor:default;' type='text' readonly id='SellEa"&rs2("BidItemsID")&"'  maxlength='25' value='"&Sell&"' onFocus=""Gebi('PartsTab').focus();"" /&gt;")
		XMLlabor = XMLlabor+("&lt;/div&gt;")
		XMLlabor = XMLlabor+("&lt;div class='PartsItemTxtBox' style='width:9%;'&gt;")
		XMLlabor = XMLlabor+("&lt;input class='PartsItemText' style='width:85%; color:#114; cursor:default;' type='text' readonly id='SellSub"&rs2("BidItemsID")&"''  value='"&SellSub&"' onFocus=""Gebi('PartsTab').focus();"" /&gt;")
		XMLlabor = XMLlabor+("&lt;/div&gt;")
		XMLlabor = XMLlabor+("&lt;/div&gt;")

		rs2.MoveNext 
	Loop
	
	set rs2=nothing	
	set rs=Nothing
	 
	 
	XML2 = "<root><Labor>--NotNull--"&XMLLabor&"</Labor></root>" 
	response.ContentType = "text/xml"
	response.Write(XML2)





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~












Sub NewProject  () '--------------------------------------------------------------------------------------------------------



Dim ProjName
Dim CustID
Dim XML
Dim DateNow

ProjName = CStr(Request.QueryString("ProjName"))
CustID = CStr(Request.QueryString("CustID"))

ProjName = Replace(ProjName, ",", " ")
ProjName = Replace(ProjName, "'", " ")
ProjName = Replace(ProjName, "+", " ")
ProjName = Replace(ProjName, "&", " ")
ProjName = Replace(ProjName, "/", "-")


DateNow = Now()

SQL ="Insert into Projects (ProjName,DateEnt,CustomerID) VALUES ('"&ProjName&"','"&DateNow&"',"&CustID&")"
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring
set rs = nothing
	
	
	
                                  
set rs = nothing



    XML = ("<Event>Updated</Event><CustID>"&CustID&"</CustID>")
	XML = ("<root>"&XML&"</root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)



End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~







Sub NewProjSave() 'Updates the calculation entries from a parts or labor entry----------------------------------------------------
	
	Dim dbconn
	Dim dbconn2
	Dim XMLProjects

	Dim LastProjID
	Dim ProjID
	Dim DidWrite
	
	Dim ProjName
	'Dim ProjCust
	'Dim ProjCustID
	Dim ProjAddress
	Dim ProjCity
	Dim ProjState
	Dim ProjZip
	Dim SqFoot
	Dim Floors
	Dim Franchise
	Dim SubOf
	Dim Area
	Dim DateEnt
	
	ProjName = CStr(Request.QueryString("ProjName"))
	'ProjCust = CStr(Request.QueryString("ProjCust"))
	'ProjCustID = CStr(Request.QueryString("ProjCustID"))
	ProjAddress = CStr(Request.QueryString("ProjAddress"))
	ProjCity = CStr(Request.QueryString("ProjCity"))
	ProjState = Replace(CStr(Request.QueryString("ProjState")),"undefined","un")
	ProjZip = CStr(Request.QueryString("ProjZip"))
	SqFoot = CStr(Request.QueryString("SqFoot"))
	Floors = CInt(Request.QueryString("Floors"))
	Franchise = CStr(Request.QueryString("Franchise"))
	SubOf = CStr(Request.QueryString("SubOf"))
	Area = CStr(Request.QueryString("Area"))
	DateEnt = Now

	
'	Model = Replace(Model, ",", " ")
'	Model = Replace(Model, "'", " ")
'	Model = Replace(Model, "+", " ")
'	Model = Replace(Model, "&", " ")
'	Model = Replace(Model, "/", "-")
		
'	if Cost2 = "" then Cost2 = "NULL" end if


	If SqFoot="" Then SqFoot=0
	If Floors="" Then Floors=0

	SQL = "SELECT * FROM Projects"
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	Do until rs.eof
		LastProjID = rs("ProjID")
		rs.MoveNext
	loop '^Weird way of getting the last ProjID from the table. (.MoveLast didn't work)
	set rs = nothing
	
	SQL1 ="INSERT INTO Projects (ProjName, ProjAddress, ProjCity, ProjState, ProjZip, SqFoot, Floors, Area, Franchise, SubOf, DateEnt, Active)"'	)"'	
	SQL1 = SQL1 &" VALUES ('"&ProjName&"', '"&ProjAddress&"', '"&ProjCity&"', '"&ProjState&"', '"&ProjZip&"', "&SqFoot&", "&Floors&", '"&Area&"', '"&Franchise&"', '"&SubOf&"', '"&DateEnt&"', 'True')"'	)"'
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	set rs1 = nothing


	SQL2 = "SELECT * FROM Projects"
	set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring

	Do until rs2.eof
		ProjID = rs2("ProjID")
		rs2.MoveNext
	loop '^Weird way of getting the last ProjID from the table. (.MoveLast didn't work)
	set rs2 = nothing
	
	
	'If ProjID <> LastProjID Then 
		DidWrite = 1
	'	SQL ="Insert into BidTo (ProjID, ProjName, CustID, CustName) VALUES ("&ProjID&", '"&ProjName&"', "&ProjCustID&", '"&ProjCust&"')"
	'	set rs=Server.CreateObject("ADODB.Recordset")
	'	rs.Open SQL, REDconnstring
	'	set rs = nothing
	'Else 
	'	DidWrite = 0
	'End if
	
	XMLProjects =""
	
	'	ProjName="A Big Hotel"
	'	ProjID="8702"
	'	ProjCustID="1"
	'	ProjCust="A Big Company Out West"
	'	DidWrite=0
	'	SQL="---"
	
	XMLProjects ="<ProjName>" & ProjName & "</ProjName>"
	XMLProjects =XMLProjects&"<LastProjID>" & ProjID & "</LastProjID>"
	XMLProjects =XMLProjects&"<CustID>" & ProjCustID & "</CustID>"
	XMLProjects =XMLProjects&"<CustName>--" & ProjCust & "</CustName>"
	XMLProjects =XMLProjects&"<DidWrite>" & DidWrite & "</DidWrite>"
	XMLProjects =XMLProjects&"<SQL>" & SQL1 & "</SQL>"
	
	XML = ("<root>"&XMLProjects&"</root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~















Sub NewSystem  () '--------------------------------------------------------------------------------------------------------



	Dim NewSysEnteredBy
	Dim NewSysName
	Dim NewSysDate
	Dim NewSysMU
	Dim NewSysTax
	Dim CustID
	Dim ProjID
	Dim XML
	Dim DateNow

	NewSysEnteredBy = CStr(Request.QueryString("NewSysEnteredBy"))
	NewSysName = CStr(Request.QueryString("NewSysName"))
	NewSysDate = CStr(Request.QueryString("NewSysDate"))
	NewSysMU = CStr(Request.QueryString("NewSysMU"))
	NewSysTax = CStr(Request.QueryString("NewSysTax"))
	CustID = CStr(Request.QueryString("CustID"))
	ProjID = CStr(Request.QueryString("ProjID"))
	
	NewSysName = Replace(NewSysName, ",", " ")
	NewSysName = Replace(NewSysName, "'", " ")
	NewSysName = Replace(NewSysName, "+", " ")
	NewSysName = Replace(NewSysName, "&", " ")
	NewSysName = Replace(NewSysName, "/", "-")
	
	DateNow = Now()
	
	SQL ="Insert into Systems (ProjectID,System,DateEntered,EnteredByID,MU,TaxRate) VALUES ("&ProjID&",'"&NewSysName&"','"&NewSysDate&"','"&NewSysEnteredBy&"',"&NewSysMU&",'"&NewSysTax&"')"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing




   
	XML = ("<root><Event>Updated</Event><ProjID>"&ProjID&"</ProjID><Date>"&NewSysDate&"</Date></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~













Sub UpdateSystem() '------------------------------------------------------------------------------------------------------




	Dim ObjValue
	Dim SQLName
	Dim EstID
	Dim XML
	Dim DateNow
	
	ObjValue = CStr(Request.QueryString("ObjValue"))
	SQLName = CStr(Request.QueryString("SQLName"))
	SysID = CStr(Request.QueryString("SysID"))
	
	ObjValue = Replace(ObjValue, ",", " ")
	ObjValue = Replace(ObjValue, "'", " ")
	ObjValue = Replace(ObjValue, "+", " ")
	ObjValue = Replace(ObjValue, "&", " ")
	ObjValue = Replace(ObjValue, "/", "-")



	DateNow = Now()
	
	SQL = "UPDATE Systems SET "&SQLName&" ='"&ObjValue&"' WHERE SystemID = "&SysID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
		
		
									  
	set rs = nothing



    XML = ("<Event>Updated</Event><ObjValue>"&ObjValue&"</ObjValue><SysID>"&SysID&"</SysID>")
	XML = ("<root>"&XML&"</root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~















Sub ToggleActiveProject() '-------------------------------------------------------------------------------------------------------

	Dim ProjID
	Dim Active
	
	ProjID = CStr(Request.QueryString("ProjID"))
	Active = CStr(Request.QueryString("Active"))
	
	SQL = "UPDATE Projects SET Active ="&Active&" WHERE ProjID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub CheckBoxSysUpdate() '--------------------------------------------------------------------------------------------------------



Dim SysID
Dim Checked

SysID= CStr(Request.QueryString("SysID"))
Checked = CStr(Request.QueryString("Checked"))

	
	SQL = "UPDATE Systems SET Obtained ='"&Checked&"' WHERE SystemID = "&SysID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
		
		
									  
	set rs = nothing






End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~












Sub ListEntryUpdate() 'Updates the Text from the Parts or Labor text field on blur----------------------------------------------------------------------

	Dim RowID
	Dim FieldName
	'Dim TypeD
	Dim TextString
	Dim XML

	RowID = CStr(Request.QueryString("RowID"))
	FieldName = CStr(Request.QueryString("FieldName"))
	TextString = CStr(Request.QueryString("TextString"))
	if (IsNull(TextString)) Or TextString="" Then TextString="0"
	
	'Do Until InStr(TextString, ",")=0 : Replace(TextString, ",", "...")	Loop
	'Do Until TextString = Replace(TextString, "'", "*"): Replace(TextString, "'", "*")  : Loop
	'Do Until TextString = Replace(TextString, "+", " plus "): Replace(TextString, "+", " plus ")  : Loop
	'Do Until TextString = Replace(TextString, "&", " and "): Replace(TextString, "&", " and ")  : Loop
	'Do Until TextString = Replace(TextString, "/", "-"): Replace(TextString, "/", "-")  : Loop
	
	SQL = "UPDATE BidItems SET "&FieldName&" ='"&TextString&"' WHERE BidItemsID = "&RowID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	XML = ("<root><RowID>"&RowID&"</RowID></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~









Sub ListSubItemsUpdate() 'Updates the calculation entries from a parts or labor entry----------------------------------------------------


	Dim RowID
	Dim CostSub
	Dim SellEa
	Dim SellSub
	Dim XML

	RowID = CStr(Request.QueryString("RowID"))
	CostSub = CStr(Request.QueryString("CostSub"))
	SellEa = CStr(Request.QueryString("SellEa"))
	SellSub = CStr(Request.QueryString("SellSub"))

	'SQL = "UPDATE BidItems SET CostSub = "&CostSub&", Sell = "&SellEa&", SellSub = "&SellSub&" WHERE BidItemsID = "&RowID
	'set rs=Server.CreateObject("ADODB.Recordset")
	'rs.Open SQL, REDconnstring
	set rs = nothing
	

	XML = ("<root><RowID>"&SellEa&"</RowID></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub CalcProjTotals
	
	Dim ProjID
	ProjID=Request.QueryString("ProjID")
	
	SQL = "SELECT * FROM Systems WHERE ProjectID = "&ProjID&" order by System "
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	Dim IncludedSystemCount: IncludedSystemCount=0
	
	Dim SysID
	Dim SqFoot, SysSqFoot
	SqFoot=0
	
	Dim PartsCost, LaborCost, Travel, Equipment, Overhead, Tax, Profit, TotalPrice
	PartsCost=0: LaborCost=0: Travel=0: Equipment=0: Overhead=0: Tax=0: Profit=0: TotalPrice=0
	
	Do While Not rs.EOF 
		SysID=rs("SystemID")
		
		
		If rs("SqFootAdd")="True" Then
			SysSqFoot=rs("SqFoot")
			If (IsNull(SysSqFoot)) Or SysSqFoot="" Then SysSqFoot=0
			SqFoot=SqFoot+SysSqFoot
		End If
		
		If rs("ExcludeSys") <> "True" Then
			IncludedSystemCount=IncludedSystemCount+1

			sPartsCost=rs("PartsCost")
			sLaborCost=rs("LaborCost")
			sSalesTax=rs("SalesTax")
			sMarginPercent=1+(rs("MU")/100)
			'sTravel=rs("Travel")
			'sEquipment=rs("Equipment")
			'sOverhead=rs("Overhead")
			
			SQL1="SELECT * FROM Expenses WHERE Type='Travel' AND SysID="&rs("SystemID")
			set rs1=Server.CreateObject("ADODB.RecordSet")
			rs1.open SQL1, REDConnstring
			
			sTravel=0
			Do Until rs1.EOF
				Units=rs1("Units") : if Units="" Then Units=0
				UnitCost=rs1("UnitCost") : if UnitCost="" Then UnitCost=0
				
				sTravel=sTravel+(Units*UnitCost)
				rs1.MoveNext
			Loop
			
			Set rs1= Nothing
			
			
			SQL1="SELECT * FROM Expenses WHERE Type='Equip' AND SysID="&rs("SystemID")
			set rs1=Server.CreateObject("ADODB.RecordSet")
			rs1.open SQL1, REDConnstring
			
			sEquipment=0
			Do Until rs1.EOF
			sEquipment=sEquipment+(rs1("Units")*rs1("UnitCost"))
				rs1.MoveNext
			Loop
			
			Set rs1= Nothing
			
			
			SQL1="SELECT * FROM Expenses WHERE Type='OH' AND SysID="&rs("SystemID")
			set rs1=Server.CreateObject("ADODB.RecordSet")
			rs1.open SQL1, REDConnstring
			
			sOverhead=0
			Do Until rs1.EOF
			sOverhead=sOverhead+(rs1("Units")*rs1("UnitCost"))
				rs1.MoveNext
			Loop
			
			Set rs1= Nothing
			
			
			If sPartsCost="" Or IsNull(sPartsCost) Then sPartsCost=0
			If sLaborCost="" Or IsNull(sLaborCost) Then sLaborCost=0
			If sTravel="" Or IsNull(sTravel) Then sTravel=0
			If sEquipment="" Or IsNull(sEquipment) Then sEquipment=0
			If sSalesTax="" Or IsNull(sSalesTax) Then sSalesTax=0
			If sOverhead="" Or IsNull(sOverhead) Then sOverhead=0
			If sMU="" Or IsNull(sMU) Then sMU=0
			
			sTotalPrice=(sPartsCost*sMarginPercent)+(sLaborCost*sMarginPercent)+sTravel+sEquipment+sOverhead+sSalesTax
			If sTotalPrice="" Or IsNull(sTotalPrice) Then sTotalPrice=0
			
			PartsCost=PartsCost+CCur(sPartsCost)
			LaborCost=LaborCost+sLaborCost
			Travel=Travel+sTravel
			Equipment=Equipment+sEquipment
			SalesTax=SalesTax+sSalesTax
			Overhead=Overhead+sOverhead
			TotalPrice=TotalPrice+sTotalPrice
		End If
		
		rs.MoveNext 
	Loop
	
	TotalPrice=Round(TotalPrice*100)/100
	
	Response.ContentType="text/xml"
	%>
	<root>
		<SqFoot>0<%=SqFoot%></SqFoot>
		<PartsCost>0<%=PartsCost%></PartsCost>
		<LaborCost>0<%=LaborCost%></LaborCost>
		<Travel>0<%=Travel%></Travel>
		<Equipment>0<%=Equipment%></Equipment>
		<SalesTax>0<%=SalesTax%></SalesTax>
		<Overhead>0<%=Overhead%></Overhead>
		<TotalPrice>0<%=TotalPrice%></TotalPrice>
	</root>
	<%
	

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~









Sub CalculateEstTotal() 'Gets the System Estimaate Totals----------------------------------------------------

	Dim SysID
	Dim TotalFixed
	
	Dim XML
	
	%>
	<root>
	<%
	
	SysID = CStr(Request.QueryString("SysID"))
	TotalFixed = CBool(Request.QueryString("FixedTotal"))
	
	SQL1 = "SELECT * FROM Systems WHERE SystemID = "&SysID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	

	Markup =  rs1("MU")
	FixedPrice= rs1("FixedPrice")
	
	TaxRate =  "0"&rs1("TaxRate")
	TaxPerc = (TaxRate / 100)
	
	'Travel = rs1("Travel")
	'Equipment = rs1("Equipment")
	'Overhead = rs1("Overhead")
	
	Obtained= rs1("Obtained")
	
		SQL2="SELECT * FROM Expenses WHERE Type='Travel' AND SysID="&SysID
		set rs2=Server.CreateObject("ADODB.RecordSet")
		rs2.open SQL2, REDConnstring
		
		Travel=0
		Do Until rs2.EOF
			Units=rs2("Units") : if Units="" Then Units=0
			UnitCost=rs2("UnitCost") : if UnitCost="" Then UnitCost=0
			
			Travel=Travel+(Units*UnitCost)
			rs2.MoveNext
		Loop
		
		Set rs2= Nothing
		
		
		SQL2="SELECT * FROM Expenses WHERE Type='Equip' AND SysID="&SysID
		set rs2=Server.CreateObject("ADODB.RecordSet")
		rs2.open SQL2, REDConnstring
		
		Equipment=0
		Do Until rs2.EOF
		Equipment=Equipment+(rs2("Units")*rs2("UnitCost"))
			rs2.MoveNext
		Loop
		
		Set rs2= Nothing
		
		
		SQL2="SELECT * FROM Expenses WHERE Type='OH' AND SysID="&SysID
		set rs2=Server.CreateObject("ADODB.RecordSet")
		rs2.open SQL2, REDConnstring
		
		Overhead=0
		Do Until rs2.EOF
		Overhead=Overhead+(rs2("Units")*rs2("UnitCost"))
			rs2.MoveNext
		Loop
	
		Set rs2= Nothing
	
	SqFt= rs1("SqFoot")
	SqFtAdd= rs1("SqFootAdd")
	RoundUp= rs1("Round")
	ExcludeSys= rs1("ExcludeSys")
	
	set rs1 = nothing
	
	If Markup="" Or (IsNull(Markup)) Then Markup=0
	If TotalSell="" Or (IsNull(TotalSell)) Then TotalSell=0
	If TaxRate="" Or (IsNull(TaxRate)) Then TaxRate=0
	If TaxPerc="" Or (IsNull(TaxPerc)) Then TaxPerc=0
	If Travel="" Or (IsNull(Travel)) Then Travel=0
	If Equipment="" Or (IsNull(Equipment)) Then Equipment=0
	If Overhead="" Or (IsNull(Overhead)) Then Overhead=0
	If SqFt="" Or (IsNull(SqFt)) Then SqFt=0
	
	SQL2 = "SELECT * FROM BidItems WHERE Type = 'Part' and SysID = "&SysID
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring
	
	PartsCost = 0
	PartsSell = 0
		
	Do While Not rs2.EOF
		
		PCost=rs2("Cost")
		Qty=rs2("Qty")
		CostSub=PCost*Qty
		'Sell=Cost+(Cost*(MU/100))
		'SellSub=Sell*Qty
	
		
		PartsCost = PartsCost + (("0")+(CostSub))
		'PartsSell = PartsSell + (("0")+(rs2("SellSub")))
	
		rs2.MoveNext 
	Loop
	
	
	set rs2 = nothing
	
	
	SQL3 = "SELECT * FROM BidItems WHERE Type = 'Labor' and SysID = "&SysID
	set rs3=Server.CreateObject("ADODB.Recordset")
	rs3.Open SQL3, REDconnstring
	
	LaborCost = 0
	LaborSell = 0	
	Do While Not rs3.EOF
	 
		LCost=rs3("Cost")
		Qty=rs3("Qty")
		CostSub=LCost*Qty
		
		LaborCost = LaborCost + CostSub
		'LaborSell = LaborSell + rs3("SellSub")
	
	rs3.MoveNext 
	Loop

	set rs3 = nothing
	
	
	Expenses=CCur(Travel)+CCur(Equipment)+CCur(Overhead)

	
	
	Cost = LaborCost+PartsCost
	
	If TotalFixed Then
		
		Calc="Margin"
	 
		%><debug><%=100*.01%></debug><%
		Markup=(FixedPrice-Expenses)
		if Markup=0 then Markup=.01
		if Cost=0 Then Cost=1
		Markup=(Markup/Cost)*100
		
		PartsSell=PartsCost*((Markup/100)+1)
		LaborSell=LaborCost*((Markup/100)+1)
		
		'SubTotal = (CCur(PartsSell)+CCur(LaborSell)+Expenses)
		SubTotal=FixedPrice
		If RoundUp="True" Then SubTotal=(CInt(SubTotal/10)*10)+10
		TotalSell=(SubTotal + CCur(Tax))
		
		Tax = (PartsSell * TaxPerc)
		If Tax<0 Then Tax=0	'It's sad but I don't think we get to charge the state when we sell for less than cost.
		
		PartsPL = (PartsCost*(Markup/100))
		LaborPL = (LaborCost*(Markup/100))
		TotalMargin = (PartsPL + LaborPL)
		
	Else
	
		Calc="Price"
	 
		PartsSell=PartsCost*((Markup/100)+1)
		LaborSell=LaborCost*((Markup/100)+1)
		
		Tax = (PartsSell * TaxPerc)
		If Tax<0 Then Tax=0	'It's sad but I don't think we get to charge the state when we sell for less than cost.
		
		SubTotal = (CCur(PartsSell)+CCur(LaborSell)+Expenses)
		If RoundUp="True" Then SubTotal=(CInt(SubTotal/10)*10)+10
		TotalSell=(SubTotal + CCur(Tax))
		
		PartsPL = (PartsSell - PartsCost)
		LaborPL = (LaborSell - LaborCost)
		TotalMargin = (PartsPL + LaborPL)
	End If
	
	
	If SubTotal="" Or (IsNull(SubTotal)) Then SubTotal=0
	If PartsPL="" Or (IsNull(PartsPL)) Then PartsPL=0
	If LaborPL="" Or (IsNull(LaborPL)) Then LaborPL=0
	If Cost="" Or (IsNull(Cost)) Then Cost=0
	If TotalMargin="" Or (IsNull(TotalMargin)) Then TotalMargin=0
	If LaborCost="" Or (IsNull(LaborCost)) Then LaborCost=0
	If PartsCost="" Or (IsNull(PartsCost)) Then PartsCost=0
	If PartsSell="" Or (IsNull(PartsSell)) Then PartsSell=0
	If Markup="" Or (IsNull(Markup)) Then Markup=0
	If Tax="" Or (IsNull(Tax)) Then Tax=0
	If TotalSell="" Or (IsNull(TotalSell)) Then TotalSell=0
	
	
	
  SubTotal = Fix(SubTotal*100)/100 'Formats 2 decimal places  
	If Not TotalFixed Then FP=SubTotal Else FP=FixedPrice 
	'Tax = formatnumber(Tax,2,,,0)
	'TotalSell = formatnumber(TotalSell,2,,,0)
	PartsPL = formatnumber(PartsPL,2,,,0)'Formats 2 decimal places  
	LaborPL = formatnumber(LaborPL,2,,,0)
	Cost = formatnumber(Cost,2,,,0)
	TotalMargin = formatnumber(TotalMargin,2,,,0)
	LaborCost = formatnumber(LaborCost,2,,,0)
	LaborSell = formatnumber(LaborSell,2,,,0)
	PartsCost = formatnumber(PartsCost,2,,,0)
	PartsSell = formatnumber(PartsSell,2,,,0)
	
	SQL="UPDATE Systems SET LaborCost="&LaborCost&", LaborSell="&LaborSell&", PartsCost="&PartsCost&", PartsSell="&PartsSell&", SubTotal="&SubTotal&", FixedPrice="&FP
	SQL=SQL&", SalesTax="&Tax&", TotalSale="&TotalSell&", PartsPL="&PartsPL&", LaborPL="&LaborPL&", TotalCost="&Cost&", MU="&Markup&" WHERE SystemID="&SysID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
response.ContentType = "text/xml"
%>	
		<SQL><%=SQL%></SQL>
		<Calc>--<%=Calc%></Calc>
		<TotalFixed>--<%=TotalFixed%></TotalFixed>
		<PartsCost>0<%=PartsCost%></PartsCost>
		<PartsSell><%=PartsSell%></PartsSell>
		<LaborCost>0<%=LaborCost%></LaborCost>
		<LaborSell><%=LaborSell%></LaborSell>
		<Travel>0<%=Travel%></Travel>
		<Equipment>0<%=Equipment%></Equipment>
		<Overhead>0<%=Overhead%></Overhead>
		<Expenses>0<%=Expenses%></Expenses>
		<TotalMargin><%=TotalMargin%></TotalMargin>
		<SubTotal>0<%=SubTotal%></SubTotal>
		<Tax>0<%=Tax%></Tax>
		<TaxPerc>0<%=TaxPerc%></TaxPerc>
		<TaxRate>0<%=TaxRate%></TaxRate>
		<TotalSell>0<%=TotalSell%></TotalSell>
		<Markup><%=Markup%></Markup>
		<PartsPL><%=PartsPL%></PartsPL>
		<LaborPL><%=LaborPL%></LaborPL>
		<TotalCost>0<%=Cost%></TotalCost>
		<SqFt>--<%=SqFt%></SqFt>
		<SqFtAdd>--<%=SqFtAdd%></SqFtAdd>
		<Round>--<%=RoundUp%></Round>
		<ExcludeSys>--<%=ExcludeSys%></ExcludeSys>
		<Obtained>--<%=Obtained%></Obtained>
	</root>
<%
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub UpdateAllItemCosting() 'Updates the calculation entries from a parts or labor entry----------------------------------------------------


	Dim SysID
	Dim Markup
	Dim Qty
	Dim CostEa
	Dim CostSub
	Dim SellEa
	Dim SellSub
	Dim XML

	SysID = CStr(Request.QueryString("SysID"))
	
	

    SQL1 = "SELECT * FROM Systems WHERE SystemID = "&SysID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	Markup =  rs1("MU")	
		
		

    SQL = "SELECT * FROM BidItems WHERE  SysID = "&SysID
    set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

			Do While Not rs.EOF
			
				Qty = rs("Qty")
				CostEa = rs("Cost")
				CostSub = (Qty * CostEa)
				SellEa = (((CostEa*Markup)/100)+CostEa) 
				SellSub = (SellEa * Qty)
				ItemID = rs("BidItemsID")
			
			
				SQL2 = "UPDATE BidItems SET CostSub = "&CostSub&", Sell = "&SellEa&", SellSub = "&SellSub&" WHERE BidItemsID = "&ItemID
				set rs2=Server.CreateObject("ADODB.Recordset")
				'rs2.Open SQL2, REDconnstring
				set rs2 = nothing
			
			
			rs.MoveNext 
			Loop
			
	 set rs = nothing	









	
	
	XML = ("<root><SysID>"&SysID&"</SysID></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~








Sub ItemSelected() '----------------------------------------------------


	Dim ItemID
	Dim ItemChecked
	Dim XML

	ItemID = CStr(Request.QueryString("ItemID"))
	ItemChecked = CStr(Request.QueryString("ItemChecked"))
	

	SQL = "UPDATE BidItems SET Selected = "&ItemChecked&" WHERE BidItemsID = "&ItemID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing



    XML = ("<root><SysID>"&ItemID&"</SysID></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~











Sub UncheckAll() '----------------------------------------------------



	SQL = "UPDATE BidItems SET Selected = 0"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing




End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub DeleteItems() '----------------------------------------------------


	Dim SysID
	Dim List
	Dim XML

	SysID = CStr(Request.QueryString("SysID"))
	List = CStr(Request.QueryString("List"))
	

	SQL = "DELETE FROM BidItems WHERE Selected = 1"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing



    XML = ("<root><SysID>"&SysID&"</SysID><List>"&List&"</List></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub DeleteProject() '----------------------------------------------------


	Dim ProjID
	Dim AreaIndex
	Dim XML

	ProjID = CStr(Request.QueryString("ProjID"))
	area = CStr(Request.QueryString("AreaIndex"))
	

	SQL = "DELETE FROM Projects WHERE ProjID ="&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	XML = "<root><AreaIndex>"&AreaIndex&"</AreaIndex></root>"
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub DeleteSystem() '----------------------------------------------------


	Dim SysID
	Dim XML

	SysID = CStr(Request.QueryString("SysID"))
	

	SQL = "DELETE FROM Systems WHERE SystemID ="&SysID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	XML = "<root><SysID>"&SysID&"</SysID><SQL>"&SQL&"</SQL></root>"
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~















Sub SearchParts  () '--------------------------------------------------------------------------------------------------------

Dim XML
Dim XMLparts
Dim SearchTxt
Dim SearchName
Dim MfrClr
Dim PartColor
Dim DescColor

SearchTxt = CStr(Request.QueryString("SearchTxt"))
SearchName = CStr(Request.QueryString("SearchName"))

if SearchName = "Manufacturer" then
 MfrClr = "DD00DD" 
 else MfrClr = "000"  
end if 

if SearchName = "PartNumber" then
 PartColor = "DD00DD" 
 else PartColor = "000"  
end if 

if SearchName = "Description" then
 DescColor = "DD00DD" 
 else DescColor = "000"  
end if

XMLparts = ""

	SQL = "SELECT * FROM Parts WHERE "&SearchName&" LIKE '%"&SearchTxt&"%'"
  set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	
	
	Dim MaxResults: MaxResults=255
	Dim MatchCount: MatchCount=0
	
	Do While Not rs.EOF
		MatchCount=MatchCount+1
		
		XMLparts=XMLparts&"&lt;div id='Part"&rs("PartsID")&"' class='PartsListItemRow'  onmouseover='MouseOverPartsAdd(""Part"&rs("PartsID")&""")' onmouseout='MouseOutPartsAdd(""Part"&rs("PartsID")&""")' &gt;"
		
		XMLparts=XMLparts&"&lt;div class='PartsListItem' style='width:40px; padding:1px 0px 0px 3px;'&gt;"
		
		XMLparts=XMLparts&"&lt;button class='PartsListItemAdd' onClick='AddPart("&rs("PartsID")&");'&gt; Add &lt;/button&gt;&lt;/div&gt;"
		XMLparts=XMLparts&"&lt;div class='PartsListItem' style='width:70px; border-left: 1px solid #000; color:#"&MfrClr&";'&gt;"&rs("Manufacturer")&"&lt;/div&gt;"
		XMLparts=XMLparts&"&lt;div class='PartsListItem' style='width:100px; border-left: 1px solid #000; color:#"&PartColor&";'&gt;"&rs("PartNumber")&"&lt;/div&gt;"
		XMLparts=XMLparts&"&lt;div class='PartsListItem' style='width:65px; border-left: 1px solid #000;display:inline;'&gt;$"&rs("Cost")&"&lt;/div&gt;"
		XMLparts=XMLparts&"&lt;div class='PartsListItem' style='width:350px; border-left: 1px solid #000;display:inline; color:#"&DescColor&"'&gt;"&rs("Description")
		XMLparts=XMLparts&" &lt;/div&gt;"
		
		XMLparts=XMLparts&"&lt;/div&gt;"
		
		if MatchCount>=MaxResults Then 
			Exit Do
			XMLparts=XMLparts&"&lt;br/&gt; &lt;br/&gt; &lt;br/&gt; Maximum of "&MaxResults&" matches has been reached. Please Refine your search."
		End If
					
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







Sub AddPart() '--------------------------------------------------------------------------------------------------------

	Dim SysID
	Dim PartID
	Dim XML
	Dim Sell
	
	Dim SQLValues

	SysID = CStr(Request.QueryString("SysID"))
	PartID = CStr(Request.QueryString("PartID"))
	MU = CStr(Request.QueryString("MU"))
	
	If PartID="0" Then 
		SQLValues="VALUES ("&SysID&",'-','0','-','-',0,0,1,'Part')"
	Else
		SQL1 = "SELECT * FROM Parts WHERE PartsID = "&PartID
			set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Cost = rs1("Cost")
		Sell = (((Cost*MU)/100)+Cost)	
	
		SQLValues=" VALUES ("&SysID&",'"&rs1("Manufacturer")&"',"&PartID&",'"&rs1("PartNumber")&"','"&rs1("Description")&"',"&rs1("Cost")&","&rs1("LaborValue")&",1,'Part')"
	End If
	
	SQL2="INSERT INTO BidItems (SysID,Manufacturer,PartID,ItemName,ItemDescription,Cost,LaborValue,Qty,Type)"
	SQL2=SQL2&SQLValues
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring
	
	set rs1 = nothing
	set rs2 = nothing

	XML = ("<root><SysID>"&SysID&"</SysID><ProjID>"&PartID&"</ProjID><SQL2>"&SQL2&"</SQL2><PartID>"&PartID&"</PartID></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub SearchLabor  () '--------------------------------------------------------------------------------------------------------

Dim XML
Dim XMLLabor
Dim SearchTxt
Dim SearchName
Dim NameColor
Dim SysColor
Dim DescColor

SearchTxt = CStr(Request.QueryString("SearchTxt"))
SearchName = CStr(Request.QueryString("SearchName"))

if SearchName = "Name" then
 NameColor = "DD00DD" 
 else NameColor = "000"  
end if 

if SearchName = "System" then
 SysColor = "DD00DD" 
 else SysColor = "000"  
end if 

if SearchName = "Description" then
 DescColor = "DD00DD" 
 else DescColor = "000"  
end if

XMLLabor = ""

	SQL = "SELECT * FROM Labor WHERE "&SearchName&" LIKE '%"&SearchTxt&"%'"
    set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	
	
			Do While Not rs.EOF
			 
			    XMLLabor = XMLLabor&"&lt;div id='Part"&rs("LaborID")&"' class='LaborListItemRow' "
					' onmouseover='MouseOverLaborAdd(""Part"&rs("LaborID")&""")' onmouseout='MouseOutLaborAdd(""Part"&rs("LaborID")&""")' &gt;"
				
					XMLLabor = XMLLabor+("&lt;div class='LaborListItem' style='width:40px; padding:1px 0px 0px 3px;'&gt;&lt;button class='LaborListItemAdd' onClick='AddLabor("&rs("LaborID")&");'&gt; Add &lt;/button&gt;&lt;/div&gt;")
					XMLLabor = XMLLabor+("&lt;div class='LaborListItem' style='width:70px; border-left: 1px solid #000; color:#"&SysColor&";'&gt;"&rs("Category")&"&lt;/div&gt;")
					XMLLabor = XMLLabor+("&lt;div class='LaborListItem' style='width:100px; border-left: 1px solid #000; color:#"&NameColor&";'&gt;"&rs("Name")&"&lt;/div&gt;")
					XMLLabor = XMLLabor+("&lt;div class='LaborListItem' style='width:65px; border-left: 1px solid #000;display:inline;'&gt;$"&rs("RateCost")&"&lt;/div&gt;")
					XMLLabor = XMLLabor+("&lt;div class='LaborListItem' style='width:350px; overflow:visible; border-left: 1px solid #000;display:inline;  color:#"&DescColor&"'&gt;"&rs("Description")&" &lt;/div&gt;")
				
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


Sub AddLabor() '--------------------------------------------------------------------------------------------------------

	Dim SysID
	Dim LaborID
	Dim XML
	Dim Cost
	Dim Sell
	Dim Category
	Dim SQLValues

	SysID = CStr(Request.QueryString("SysID"))
	LaborID = CStr(Request.QueryString("LaborID"))
	MU = CStr(Request.QueryString("MU"))
	
	If LaborID="0" Then 
		SQLValues="VALUES ("&SysID&",'-','-',0,1,'Labor')"
	Else
		SQL1 = "SELECT * FROM Labor WHERE LaborID = "&LaborID
			set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Category=rs1("Category")
		Cost = rs1("RateCost")
		Sell = (((Cost*MU)/100)+Cost)
		SQLValues=" VALUES ("&SysID&",'"&rs1("Name")&"','"&rs1("Description")&"',"&Cost&",1,'Labor')"
	End If

	SQL2 ="Insert into BidItems (SysID,ItemName,ItemDescription,Cost,Qty,Type)"
	SQL2 = SQL2&SQLValues
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring
	
	set rs1 = nothing
	set rs2 = nothing

   
	XML = ("<root><SysID>"&SysID&"</SysID></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~















Sub BidToList  () '----------Gets the list of Systems---------------------------------------------------------------------------------------
	
	
	
	
	response.ContentType = "text/xml"
	response.Write(XML)
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub SystemsList  () '----------Gets the list of Systems------& BidTo Customers----------------------------------------------

	Dim ProjID
	Dim XML
	Dim Sys
	Dim XMLMain
	Dim CustomerList
	Dim AddressingList
	Dim IDarray
	Dim CheckedVar
	Dim Checked
	Dim CustCount
	Dim SysCount
	
	ProjID = CStr(Request.QueryString("ProjID"))

	Sys = "" 
	SQL = "SELECT * FROM Systems WHERE ProjectID = "&ProjID&" order by System "
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	SysCount = 0
	Do While Not rs.EOF 
		SysCount = SysCount +1
		
		'Checked = rs("PrintChecked")
		'if Checked = "True" then CheckedVar = "checked"
		'if Checked = "False" then CheckedVar = ""
		
		XMLSystems = XMLSystems & "<SystemID" &SysCount &">" &rs("SystemID") &"</SystemID" &SysCount &">" 
		XMLSystems = XMLSystems & "<SysName" &SysCount &">" &rs("System") &"</SysName" &SysCount &">" 
		XMLSystems = XMLSystems & "<PrintChecked" &SysCount &">" &rs("PrintChecked") &"</PrintChecked" &SysCount &">" 
		
		
		'Sys = Sys & "&lt;div&gt; &lt;input name='CB" & rs("SystemID") & "' type='checkbox' value='' " 
		''Sys = Sys+("onClick='UpdateText(""CB"&rs("SystemID")&""",""CheckBox"",""Systems"",""SystemID"",""PrintChecked"","""&rs("SystemID")&""");' "&CheckedVar&"/&gt;"&rs("System"))
		'Sys = Sys & " onclick='alert('click');' /&gt;"
		'Sys = Sys & rs("System") & "&lt;/div&gt;"
		rs.MoveNext 
	Loop

	set rs = nothing

			
	
	CustomerList = "" 
	SQL = "SELECT * FROM BidTo WHERE ProjID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	CustomerList = CustomerList & "<div style=*width:100%;* >" 
	AddressingList = "<div align='right' style='width:100%; float:left;'>"
	dim ID
	Do Until rs.EOF 
		Dim Contact
		Contact=rs("Contact")
		if (Contact="") or IsNull(Contact) then Contact = "Dear Sir/Madam,"
		
		CustCount = CustCount+1
		ID="cbCust"&CustCount
		CustomerList = CustomerList & "<input type=*checkbox* id=*"&ID&"* checked/>"
		CustomerList = CustomerList & "<label for='"&ID&"' >"&rs("CustName")&"</label><br />"
		CustomerList = CustomerList & "<input type=*hidden* id=*PrintCustId"&CustCount&"* value=*"&rs("CustID")&"* />"
		
		AddressingList=AddressingList&"<div align='right' style='margin-right:16px; width:auto;'><br />"
		AddressingList=AddressingList&	"<div class='PrintSetupTitles'><label for=''>Addressing for "&rs("CustName")&":</label></div>"
		AddressingList=AddressingList&	"<div class='PrintSetupTextInput' align='left'>"
		AddressingList=AddressingList&		"<input id='Addressing"&CustCount&"' type='text' style='margin-left:48px;' value='"&rs("Contact")&",'"
		AddressingList=AddressingList&		" onKeyUp='UpdateText(*Addressing"&CustCount&"*,*Text*,*BidTo*,*CustID*,*Contact*,*"&rs("CustID")&"*);'/>"
		AddressingList=AddressingList&"</div></div>"
		
		rs.MoveNext 
	Loop
		
	set rs = nothing
	
	SQL = "SELECT * FROM Projects WHERE ProjID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	Dim Area: Area=rs("Area")
	SQL1 = "SELECT * FROM AreaLicense WHERE Area = '"&Area&"'"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	set rs=nothing
	
	Dim LicNo 
	Dim Spc10 : Spc10="-AMPERSAND-nbsp; -AMPERSAND-nbsp; -AMPERSAND-nbsp; -AMPERSAND-nbsp; -AMPERSAND-nbsp;-AMPERSAND-nbsp;"
	Dim LicCount : LicCount=0
	Dim LicList
	LicList = LicList & "<div id=*LicenseList* style=*width:100%; font-size:12px;* >"
	If rs1.EOF Then LicList=LicList&"No licenses found for *"&Area&"*"
	Do Until rs1.EOF
		LicNo=rs1("Number")
		if(Instr(LicNo," - ")>0) Then	LicNumber=Split(LicNo," - ")
		LicCount = LicCount+1
		ID="cbLic"&CStr(rs1("AreaLicenseID"))'CStr(LicCount)
		LicList=LicList & "<input type=*checkbox* id=*"&ID&"* onclick=*MakeLicenseFooters();*/>"
		LicList=LicList & "<label for=*"&ID&"* >"&rs1("State")&" - "&rs1("Type")& "</label><br />"
		LicList=LicList & "<div id=*LicenseFooter"&rs1("AreaLicenseID")&"* style=*display:none*>"
			LicList=LicList & "<div class=*CompanyInfo*>"
				LicList=LicList & "License No. "&LicNo
				If rs1("BidLimit") Then LicList=LicList&Spc10&" Bid Limit:"&rs1("BidLimit")
				LicList=LicList &Spc10& rs1("State")&" - "&CStr(Split(LicNo," - ")(0))
			LicList=LicList & "</div>"
		LicList=LicList & "</div>"
		rs1.MoveNext
	Loop
	LicList=LicList&"</div>"
	LicList = LicList & "<input type=*hidden* id=*LicCount* value=*"&LicCount&"* />"
	
	CustomerList = CustomerList & "</div> "
	CustomerList = CustomerList & "<input type=*hidden* id=*CustCount* value=*"&CustCount&"* />"
	AddressingList=AddressingList&"</div>"
	
	
	Do Until instr(Customerlist, "<") = 0 and instr(Customerlist, ">") = 0 and instr(Customerlist, "*") = 0
		CustomerList = Replace(CustomerList, "<", "&lt;")
		CustomerList = Replace(CustomerList, ">", "&gt;")
		CustomerList = Replace(CustomerList, "*", """")
	Loop

	Do Until instr(AddressingList, "<") = 0 and instr(AddressingList, ">") = 0 and instr(AddressingList, "*") = 0
		AddressingList = Replace(AddressingList, "<", "&lt;")
		AddressingList = Replace(AddressingList, ">", "&gt;")
		AddressingList = Replace(AddressingList, "*", """")
	Loop
	
	Do Until instr(LicList, "<") = 0 and instr(LicList, ">") = 0 and instr(LicList, "*") = 0
		LicList = Replace(LicList, "<", "&lt;")
		LicList = Replace(LicList, ">", "&gt;")
		LicList = Replace(LicList, "*", """")
	Loop
	If LicList = "" then LicList= "No Licenses for "&Area&" have been entered."
	
	
	XML = "<root>"
	XML=XML&"<PrintForList>"&CustomerList&"</PrintForList>"
	XML=XML&"<AddressingList>--"&AddressingList&"</AddressingList>"
	XML=XML&"<LicList>--"&LicList&"</LicList>"
	XML=XML&"<SysCount>"&SysCount&"</SysCount>"
	XML=XML&XMLSystems&"</root>"
	
	
	response.ContentType = "text/xml"
	response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub LetterHeadSW() '------------------------------------------------------------------------------------------------------


Dim ProjID
Dim TFP_TCS
Dim TFP
Dim TCS

ProjID = CStr(Request.QueryString("ProjID"))
TFP_TCS = CStr(Request.QueryString("TFP_TCS"))
TFP = CStr(Request.QueryString("TFP"))
TCS = CStr(Request.QueryString("TCS"))

'if TFP_TCS = true then TFP_TCS = "1"

SQL = "UPDATE ProjectPrint SET TFP_TCS ='"&TFP_TCS&"', TFP ='"&TFP&"', TCS ='"&TCS&"' WHERE ProjectID = "&ProjID
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring
set rs = nothing

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub MakeLicenseFooters '------------------------------------------------------------------------------------------------------

Dim HTML : HTML=CStr(Request.QueryString("HTML"))
HTML=Replace(HTML,"-ERASE-","")
Dim XML

Dim ProjID : ProjID=CStr(Request.QueryString("ProjID"))

SQL = "UPDATE ProjectPrint SET LicenseFooterHTML='"&HTML&"' WHERE ProjectID="&ProjID
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring
set rs=nothing

If HTML="" Then HTML="-LICENSE FOOTERS HAVE BEEN ERASED-"
XML="<root>"
XML=XML&"<LF>"&HTML&"</LF>"
XML=XML&"<ProjID>"&ProjID&"</ProjID>"
XML=XML&"</root>"


response.ContentType = "text/xml"
response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~









Sub BidPresetList  () '----------Gets the list of Systems---------------------------------------------------------------------------------------




Dim SystemID
Dim XML
Dim XML_Presets

SystemID = CStr(Request.QueryString("SystemID"))




			XML_Presets = "" 


			SQL = "SELECT * FROM BidPresets WHERE BidPresetSystemID = "&SystemID&" order by BidPresetName "
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring
			
			Do While Not rs.EOF 
											
				XML_Presets = XML_Presets+("&lt;div id='Pre"&rs("BidPresetID")&"' class='PresetItems' onClick='SetPresetID("&rs("BidPresetID")&");'  &gt;") 
				XML_Presets = XML_Presets+(rs("BidPresetName")&"&lt;/div&gt; ")
				
			rs.MoveNext 
			Loop

			set rs = nothing
			
	        if XML_Presets = "" then
				XML_Presets = "Blank"
			end if


    XML = ("<root><Presets>"&XML_Presets&"</Presets></root>")
	
    set rs1 = nothing
	
	response.ContentType = "text/xml"
	response.Write(XML)





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~














Sub BidPresetCreate() '------------------------------------------------------------------------------------------------------


Dim SystemID
Dim PresetID
Dim MU
Dim Cost
Dim Sell
Dim XML


SystemID = CStr(Request.QueryString("SystemID"))
PresetID = CStr(Request.QueryString("PresetID"))
MU = CStr(Request.QueryString("MU"))

	
	SQL = "SELECT * FROM BidPresets WHERE BidPresetID = "&PresetID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
		
	SQL1 = "UPDATE Systems SET Notes ='"&rs("Scope")&"', Includes ='"&rs("Includes")&"', Excludes ='"&rs("Excludes")&"' WHERE SystemID = "&SystemID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	set rs = nothing
	set rs1 = nothing
	
	
	
	
	
	SQL = "SELECT * FROM BidPresetItems WHERE BidPresetID = "&PresetID& "and Type = 'Part'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	Do While Not rs.EOF
		
					
			SQL1 = "SELECT * FROM Parts WHERE PartsID = "&rs("ItemID")
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			Cost = rs1("Cost")
			Sell = (((Cost*MU)/100)+Cost)	
			
			
			SQL2 ="Insert into BidItems (SysID,Manufacturer,ItemName,ItemDescription,Cost,LaborValue,Qty,Type)"
			SQL2 = SQL2+(" VALUES ("&SystemID&",'"&rs1("Manufacturer")&"','"&rs1("PartNumber")&"','"&rs1("Description")&"',"&rs1("Cost")&","&rs1("LaborValue")&",1,'Part')")
			set rs2=Server.CreateObject("ADODB.Recordset")
			rs2.Open SQL2, REDconnstring
			
			set rs1 = nothing
		
	rs.MoveNext 
	Loop
	
    set rs = nothing


	
	

	SQL = "SELECT * FROM BidPresetItems WHERE BidPresetID = "&PresetID& "and Type = 'Labor'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	Do While Not rs.EOF
		
		SQL1 = "SELECT * FROM Labor WHERE LaborID = "&rs("ItemID")
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Cost = rs1("RateCost")
		'Sell = (((Cost*MU)/100)+Cost)	
		
		
		SQL2 ="Insert into BidItems (SysID,ItemName,ItemDescription,Cost,Qty,Type)"
		SQL2 = SQL2+(" VALUES ("&SystemID&",'"&rs1("Name")&"','"&rs1("Description")&"',"&rs1("RateCost")&",1,'Labor')")
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		set rs1 = nothing
		
		rs.MoveNext 
	Loop
	
    set rs = nothing


		
	    XML = ("<root><SystemID>"&SystemID&"</SystemID></root>")
			
		response.ContentType = "text/xml"
		response.Write(XML)



End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub UnBidTo()'---------------------------------------------------------------------

	Dim CustName
	Dim ProjID
	CustName = CStr(Request.QueryString("CustName"))
	ProjID = CStr(Request.QueryString("ProjID"))

	SQL = "DELETE FROM BidTo WHERE CustName = '" & CustName & "' AND ProjID =" & ProjID
	If CustName = "--ALL--" then SQL = "DELETE FROM BidTo WHERE ProjID =" & ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	XML = ("<root><Removed>" & CustName & "</Removed></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)

End Sub'---------------------------------------------------------------------------


Sub AddBidToCust()'---------------------------------------------

	Dim XML
		
	Dim ProjID : ProjID = CStr(Request.QueryString("ProjID"))
	Dim ProjName : ProjName = EncodeChars(CStr(Request.QueryString("ProjName")))
	Dim CustID : CustID = CStr(Request.QueryString("CustID"))
	Dim CustName : CustName = CStr(Request.QueryString("CustName"))
	Dim Contact : Contact = CStr(Request.QueryString("Contact"))
	
	SQL ="Insert into BidTo (Contact, ProjID, CustID, CustName) VALUES ('"&Contact&"', "&ProjID&", "&CustID&", '"&CustName&"')"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
	XML  =  "<ProjID>"  &ProjID  &"</ProjID>"
	XML=XML&"<ProjName>"&ProjName&"</ProjName>"
	XML=XML&"<CustID>"  &CustID  &"</CustID>"
	XML=XML&"<CustName>"&CustName&"</CustName>"
	XML=XML&"<Contact>" &Contact &"</Contact>"
	XML=XML&"<SQL>" &SQL &"</SQL>"
	response.ContentType = "text/xml"
	response.Write("<root>"&XML&"</root>")
	
End Sub'--------------------------------------------------------




Sub ObtainBid()'---------------------------------------------

'	Dim XML
	Dim ProjID : ProjID = CStr(Request.QueryString("ProjID"))
	Dim ProjName : ProjName = CStr(Request.QueryString("ProjName"))
	Dim CustID : CustID = CStr(Request.QueryString("CustID"))
	Dim CustName : CustName = CStr(Request.QueryString("CustName"))
	
	SQL ="UPDATE BidTo SET HasTheJob = 'False' Where ProjID ="&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
	SQL ="UPDATE BidTo SET HasTheJob = 'True' Where ProjID ="&ProjID&" AND CustID="&CustID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
	SQL ="UPDATE Projects SET Active = 'True', Obtained = 'True', Contract='True', CustomerID = "&CustID&", CustName = '"&CustName&"' WHERE ProjID ="&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
'	XML = "<nuthin>nuthin</nuthin>"
'	response.ContentType = "text/xml"
'	response.Write(XML)
	
End Sub'--------------------------------------------------------


Sub Contract()'---------------------------------------------------

	Response.ContentType = "text/xml"
	%>
	<root>
	<%
	
	SysID = CStr(Request.QueryString("SysID"))
	
	SQL="UPDATE Systems SET Obtained='False' WHERE SystemID="&SysID
	%><SQL1><%=SQL%></SQL1><%
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	Set rs=Nothing
	
	SQL="Select * FROM Systems WHERE SystemID="&SysID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	SQL="Select * FROM Systems WHERE ProjectID="&rs("ProjectID")
	%><SQL3><%=SQL%></SQL3><%
	set rs=Nothing
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	Systems=0
	
	Do Until rs.EOF
		
		If rs("Obtained")="True" Then Systems=Systems+1
		
		rs.MoveNext
	Loop
	
		If Systems>0 Then IsOnlySys=0 Else IsOnlySys=1
		
	%>
		<IsOnlySys>--<%=IsOnlySys%></IsOnlySys>
		<SysID>--<%=SysID%></SysID>
	</root>
	<%
End Sub'--------------------------------------------------------



Sub UnContract()'---------------------------------------------

'	Dim XML
	Dim ProjID : ProjID = CStr(Request.QueryString("ProjID"))
	
	SQL ="UPDATE BidTo SET HasTheJob = 'False' Where ProjID ="&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
	SQL ="UPDATE Projects SET Active = 'False', Obtained = 'False' WHERE ProjID ="&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
'	XML = "<nuthin>nuthin</nuthin>"
'	response.ContentType = "text/xml"
'	response.Write(XML)
	
End Sub'--------------------------------------------------------



Sub oops  () '--------------------------------------------------------------------------------------------------------
	response.write "Oops Didn't Work "
End Sub '------------------------------------------------------------------------------------------------------------------------

%>
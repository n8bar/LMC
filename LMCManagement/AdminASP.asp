 
<!--#include file="../LMC/RED.asp" -->




<%

Dim GlobalCustID


Dim sAction 

sAction = CStr(Request.QueryString("action"))

Select Case sAction


	Case "LoadEmployeeTime"
		LoadEmployeeTime
	
	Case "LoadProjectTime"
		LoadProjectTime
		
	Case "Archive"
		Archive


		

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











Sub LoadEmployeeTime  () '--------------------------------------------------------------------------------------------------------

	Dim XML
	Dim EmpID
	Dim ColName
	Dim DESC_ASC
	Dim XMLtext
	Dim LoopNum	
	Dim EmpTimeListLength
	
	
	EmpID = Request.QueryString("EmpID")
	DateFrom = CStr(Request.QueryString("From"))
	If DateFrom = "Earliest" Then DateFrom = "01/01/1900"
	DateTo = CStr(Request.QueryString("To"))
	If DateTo = "Latest" Then DateTo = "01/01/2040"
	
	XML = ""
	
	DESC_ASC = "ASC"

	Dim Where
	Dim Order
	
	Select Case EmpID
	
		Case 9999 'All employees
			'Where = "WHERE Archived='False' AND Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			Where = "WHERE Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			ColName = "EmpID"
			
			
		Case 1000 'Active employees
			'Where = "WHERE Archived='False' AND Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			Where = "WHERE Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			ColName = "EmpID"
			
		Case Else
			'Where = "WHERE Archived='False' AND EmpID="&EmpID&" AND Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			Where = "WHERE EmpID="&EmpID&" AND Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			ColName = "Date"
			
	End Select

	EmpTimeListLength = 0

	SQL="SELECT * FROM Time "&Where&" ORDER BY "&ColName&" "&DESC_ASC&", TimeInHr DESC, TimeInMin DESC"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring


	LoopNum = 1	
	
	XMLtext = ""	
	
	
	Dim FirstDate,LastDate
	
	If Not rs.EOF then FirstDate = "<FirstDate>"&rs("Date")&"</FirstDate>"
	dim JobName
	Do While Not rs.EOF 
	
		SQL1="SELECT * FROM Employees WHERE EmpID="&rs("EmpID")
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		If Not rs1.EOF Then
			If rs1("Active")="True" Or EmpID<>1000 Then

				XMLtext = XMLtext&"<EmpTimeID"&LoopNum&">"&rs("TimeID")&"</EmpTimeID"&LoopNum&">" 
				XMLtext = XMLtext&"<EmpID"&LoopNum&">"&rs("EmpID")&"</EmpID"&LoopNum&">" 
				XMLtext = XMLtext&"<EmpTimeFName"&LoopNum&">"&rs1("FName")&"</EmpTimeFName"&LoopNum&">" 
				XMLtext = XMLtext&"<EmpTimeLName"&LoopNum&">"&rs1("LName")&"</EmpTimeLName"&LoopNum&">" 
				XMLtext = XMLtext&"<EmpTimeDate"&LoopNum&">"&rs("Date")&"</EmpTimeDate"&LoopNum&">" 
				XMLtext = XMLtext&"<EmpTimeInHr"&LoopNum&">"&rs("TimeInHr")&"</EmpTimeInHr"&LoopNum&">"
				XMLtext = XMLtext&"<EmpTimeInMin"&LoopNum&">"&rs("TimeInMin")&"</EmpTimeInMin"&LoopNum&">"
				XMLtext = XMLtext&"<EmpTimeOutHr"&LoopNum&">"&rs("TimeOutHr")&"</EmpTimeOutHr"&LoopNum&">"
				XMLtext = XMLtext&"<EmpTimeOutMin"&LoopNum&">"&rs("TimeOutMin")&"</EmpTimeOutMin"&LoopNum&">"
				XMLtext = XMLtext&"<EmpTimeDesc"&LoopNum&">--"&rs("Description")&"</EmpTimeDesc"&LoopNum&">"
				XMLtext = XMLtext&"<EmpTimeSup"&LoopNum&">--"&rs("Supervisor")&"</EmpTimeSup"&LoopNum&">"
				JobName = rs("JobName"): If JobName = "" or (IsNull(JobName)) then JobName = "--"
				XMLtext = XMLtext&"<EmpTimeJobName"&LoopNum&">"&JobName&"</EmpTimeJobName"&LoopNum&">"
				XMLtext = XMLtext&"<EmpTimeJobID"&LoopNum&">"&rs("JobID")&"</EmpTimeJobID"&LoopNum&">"
				XMLtext = XMLtext&"<EmpTimeJobPhase"&LoopNum&">--"&rs("JobPhase")&"</EmpTimeJobPhase"&LoopNum&">"
				XMLtext = XMLtext&"<EmpTimeJobType"&LoopNum&">--"&rs("JobType")&"</EmpTimeJobType"&LoopNum&">"
				XMLtext = XMLtext&"<EmpTimeArchStat"&LoopNum&">--"&rs("Archived")&"</EmpTimeArchStat"&LoopNum&">"
				
				LoopNum = LoopNum + 1	
				EmpTimeListLength = EmpTimeListLength + 1      
				
				LastDate = "<LastDate>"&rs("Date")&"</LastDate>"
			
			End If
		End If
		Set rs1 = nothing
		
		rs.MoveNext 
	Loop

	Dim ActiveEmpID
	Dim ActiveCount : ActiveCount=0
	SQL1="SELECT * FROM Employees WHERE Active='True' ORDER BY FName"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring

	Do Until rs1.EOF
		ActiveCount=ActiveCount+1
		ActiveEmpID=ActiveEmpID&"<ActiveEmpID"&ActiveCount&">"&rs1("EmpID")&"</ActiveEmpID"&ActiveCount&">"
		ActiveEmpID=ActiveEmpID&"<ActiveFName"&ActiveCount&">"&rs1("FName")&"</ActiveFName"&ActiveCount&">"
		ActiveEmpID=ActiveEmpID&"<ActiveLName"&ActiveCount&">"&rs1("LName")&"</ActiveLName"&ActiveCount&">"
		rs1.MoveNext
	Loop
	ActiveEmpID=ActiveEmpID&"<ActiveCount>"&ActiveCount&"</ActiveCount>"
	
	
	
	XML = ("<root>"&XMLtext&"<EmpTimeListLength>"&EmpTimeListLength&"</EmpTimeListLength><EmpID>"&EmpID&"</EmpID>"&FirstDate&LastDate&ActiveEmpID&"</root>")

	response.ContentType = "text/xml"
	response.Write(XML)


	set rs = nothing
	set dbconn=nothing


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~









Sub LoadProjectTime()'------------------------------------------------------
	Response.ContentType = "text/xml"
	
	%>
	<root>
	<%
	
	ProjID= Request.QueryString("ProjID")
	d8From= Request.QueryString("From")
	d8To= Request.QueryString("To")
	
	
	SQL="SELECT * FROM Time WHERE JobType='Project' AND  JobID="&ProjID&" ORDER BY JobPhase, Date, SuperVisor, TimeOutHr"
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.Open SQL, REDConnString
	
	tNum=0
	Do Until rs.EOF
		tNum=tNum+1
		
		tIn=rs("TimeInHr")+(rs("TimeInMin")/60)
		tOut=rs("TimeOutHr")+(rs("TimeOutMin")/60)
		Hours=tOut-tIn
		If Hours<0 Then Hours=Hours+24
		
		
		Set rs2=Server.CreateObject("AdoDB.RecordSet")
		SQL2="SELECT * FROM Employees WHERE EmpID="&rs("Supervisor")
		rs2.Open SQL2, REDConnString
		
		If Not rs2.EOF	Then	Supervisor = rs2("FName")&" "&rs2("LName")	Else	Supervisor="---NOT ENTERED---"
		
		
		Set rs3=Server.CreateObject("AdoDB.RecordSet")
		SQL3="SELECT * FROM Employees WHERE EmpID="&rs("EmpID")
		rs3.Open SQL3, REDConnString
		
		If Not rs3.EOF	Then	Emp = rs3("FName")&" "&rs3("LName")	Else	Emp="---NOT ENTERED---"
		
		
		Set rs4=Server.CreateObject("AdoDB.RecordSet")
		SQL4="SELECT * FROM Projects WHERE ProjID="&ProjID
		rs4.Open SQL4, REDConnString
		
		If Not rs4.EOF Then ProjName=rs4("ProjName") Else ProjName="Project Not Found"
		
		%>
		<Date<%=tNum%>><%=rs("Date")%></Date><%=tNum%>>
		<Hours<%=tNum%>><%=Hours%></Hours><%=tNum%>>
		<Supervisor<%=tNum%>><%=Supervisor%></Supervisor><%=tNum%>>
		<Phase<%=tNum%>><%=rs("JobPhase")%></Phase><%=tNum%>>
		<Emp<%=tNum%>><%=Emp%></Emp><%=tNum%>>
		<!--
		<><%'=%></>
		<><%'=%></>
		-->
		<%
		
		rs.MoveNext
	Loop

	%>
	<records><%=tNum%></records>
	<project>--<%=ProjName%></project>
	</root>
	<%

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub Archive()'------------------------------------------------------

	Dim XML
	Dim EmpID   :	EmpID=Request.QueryString("EmpID")
	Dim DateFrom: DateFrom = CStr(Request.QueryString("From"))
	Dim DateTo  : DateTo = CStr(Request.QueryString("To"))
	Dim Archived: Archived = CStr(Request.QueryString("Archived"))
	
	If DateFrom = "Earliest" Then DateFrom = "01/01/1900"
	If DateTo = "Latest" Then DateTo = "01/01/2040"

	Dim Where
	Select Case EmpID
	
		Case 9999 'All employees
			Where = "WHERE Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			
		Case 1000 'Active employees
			Where = "WHERE Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			
		Case Else
			Where = "WHERE EmpID="&EmpID&" AND Date BETWEEN '"&DateFrom&"' AND '"&DateTo&"'"
			
	End Select
	
	SQL="UPDATE Time SET Archived='"&Archived&"' "&Where
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring




	set rs=nothing

	XML="<root><EmpID>"&EmpID&"</EmpID></root>"

	response.ContentType = "text/xml"
	response.Write(XML)


End Sub'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





















Sub LoadEmpList  () '--------------------------------------------------------------------------------------------------------

	Dim XML
	Dim XML_List

	XML_List = "Error" 
    XML = ("<root><EmpList>"&XML_List&"</EmpList></root>")
	
    
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub OpenEmployee () '--------------------------------------------------------------------------------------------------------

Dim EmpID

EmpID = CStr(Request.QueryString("EmpID"))



Dim XML
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

	Dim XML
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
	
	Dim XML
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
	eHired = CDate(Request.QueryString("Hired"))
	
'	Model = Replace(Model, ",", " ")
'	Model = Replace(Model, "'", " ")
'	Model = Replace(Model, "+", " ")
'	Model = Replace(Model, "&", " ")
'	Model = Replace(Model, "/", "-")
		
'	if Cost2 = "" then Cost2 = "NULL" end if

dim SQLInsert
dim SQLValues	
	
	SQLInsert ="INSERT INTO Employees (FName, LName, Position, Wage, Address, City, State, Zip, Phone, Phone2, DCPhone, Email, Hired, Active)"		
	SQLValues =" VALUES ('"&eFName&"', '"&eLName&"', '"&ePosition&"', '"&eWage&"', '"&eAddress&"', '"&eCity&"', '"&eState&"', '"&eZip&"', '"&ePhone&"', '"&ePhone2&"', '"&eDCPhone&"', '"&eEmail&"', '"&eHired& "', 'True')"
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
	url = "https://www.rcstri.com/website/LMCmanagement/LMC.html"
	
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
